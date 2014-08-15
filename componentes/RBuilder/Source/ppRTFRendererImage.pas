{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFRendererImage;

interface

uses
  Windows,
  Graphics,
  Classes,
  Types,
  ppRTFRenderer,
  ppDevice,
  ppDrwCmd;

type

  TppRTFImageInfo = record
    Left: Integer;
    Top: Integer;
    Right: Integer;
    Bottom: Integer;
    PicW: Integer;      //Actual picture width in twips
    PicH: Integer;      //Actual picture height in twips
    PicWGoal: Integer;  //Desired picture width in twips.
    PicHGoal: Integer;  //Desired picture height in twips.
    BorderColor: TColor;
    BorderWidth: Integer;
  end;

  {@TppRTFRendererImage

    Processes image properties and writes it to the Richtext document stream.

    Images inside a Richtext document are supported for RTF 1.5 specification
    (Word 97 or later compatible editors). }

  TppRTFRendererImage = class(TppRTFRenderer)
  private
    FForceRender: Boolean;

    function  CreateImageStream(aMetaFile: TMetaFile): TMemoryStream;
    function  CreateMetafile(aGraphic: TGraphic): TMetaFile;
    procedure DrawImage(aImageInfo: TppRTFImageInfo);
    function  GenerateImageInfo: TppRTFImageInfo; overload;
    function  GetDrawImageCommand: TppDrawImage;

  public
    constructor Create; override;

    class function DrawCommandClass: TppDrawCommandClass; override;

    procedure RenderToRTF; override;

    property DrawImageCommand: TppDrawImage read GetDrawImageCommand;
    property ForceRender: Boolean read FForceRender write FForceRender;

  end;

implementation

uses
  SysUtils,
  ppTypes,
  ppRTFRendererManager,
  ppFilDev;

constructor TppRTFRendererImage.Create;
begin
  inherited;

  FForceRender := False;

end;

function TppRTFRendererImage.CreateImageStream(aMetaFile: TMetaFile): TMemoryStream;
var
  lTempStream: TMemoryStream;
begin

  Result := TMemoryStream.Create;
  lTempStream := TMemoryStream.Create;

  try
    aMetaFile.SaveToStream(lTempStream);
    lTempStream.Position := 0;
    Result.CopyFrom(lTempStream, lTempStream.Size);
    Result.Position := 0;

  finally
    lTempStream.Free;
  end;

end;

function TppRTFRendererImage.CreateMetafile(aGraphic: TGraphic): TMetafile;
var
  lMetafileCanvas: TMetafileCanvas;
begin

  Result := TMetaFile.Create;

  if (aGraphic is TMetaFile) then
    begin
      Result.Assign(TMetaFile(aGraphic));
      Result.Enhanced := True;
    end
  else
    begin
      Result.Width  := aGraphic.Width;
      Result.Height := aGraphic.Height;
      Result.Enhanced := True;

      lMetaFileCanvas := TMetaFileCanvas.Create(Result, 0);
      lMetaFileCanvas.Draw(0, 0, aGraphic);
      lMetaFileCanvas.Free;  //Draw to metafile
    end;

end;

class function TppRTFRendererImage.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawImage;

end;

procedure TppRTFRendererImage.DrawImage(aImageInfo: TppRTFImageInfo);
var
  lMetaStream: TMemoryStream;
  lBitmap: TBitmap;
  lMetaFile: TMetaFile;
begin

  lBitmap := nil;

  //RTF images are stretched by default.  This handles non-stretching cases.
  if not(DrawImageCommand.Stretch) or ((DrawImageCommand.Stretch) and (DrawImageCommand.MaintainAspectRatio)) then
    begin
      lBitmap := TppFileDeviceUtils.DrawCommandToBitmap(DrawImageCommand, 100, clWhite);
      lMetafile := CreateMetafile(lBitmap);
    end
  else
    lMetafile := CreateMetafile(DrawImageCommand.Picture.Graphic);

  lMetaStream := CreateImageStream(lMetaFile);

  try
    aImageInfo.PicW := TppFileDeviceUtils.MicronsToTwips(lMetaFile.MMWidth);
    aImageInfo.PicH := TppFileDeviceUtils.MicronsToTwips(lMetaFile.MMHeight);

    WriteMem('{\shp{\*\shpinst\shpbxpage\shpbypage');       //start the shape
    WriteMem('\shpwr3\shpwrk0\shpfblwtxt0');                //text wrapping options
    WriteMem('\shpleft' + IntToStr(aImageInfo.Left));       //left position
    WriteMem('\shptop' + IntToStr(aImageInfo.Top));         //top position
    WriteMem('\shpright' + IntToStr(aImageInfo.Right));     //right position
    WriteMem('\shpbottom' + IntToStr(aImageInfo.Bottom));   //bottom position
    WriteMem('\shpz' + IntToStr(ID));                       //z-order
    WriteMem('\shplid' + IntToStr(ID));                     //unique id

    WriteMem('{\sp{\sn shapeType}{\sv 75}}');               //place image inside a picture frame
    WriteMem('{\sp{\sn fBehindDocument}{\sv 1}}');          //place the image behind the text
    WriteMem('{\sp{\sn linecolor}{\sv ' + IntToStr(aImageInfo.BorderColor) + '}}');  //border color
    WriteMem('{\sp{\sn linewidth}{\sv ' + IntToStr(aImageInfo.BorderWidth) + '}}');  //border width
    WriteMem('{\sp{\sn pib}{\sv ');                         //start the picture
    WriteMem('{\pict\emfblip');
    WriteMem('\picw' + IntToStr(aImageInfo.PicW));          //actual image width
    WriteMem('\pich' + IntToStr(aImageInfo.PicH));          //actual image height
    WriteMem('\picwgoal' + IntToStr(aImageInfo.PicWGoal));  //desired image width
    WriteLine('\pichgoal' + IntToStr(aImageInfo.PicHGoal)); //desired image height

    WriteMem('\bin' + IntToStr(lMetaStream.Size) + #32);
    DocStream.CopyFrom(lMetaStream, lMetaStream.Size);      //copy image stream to document
    WriteLine('}}}}}');

  finally
    lMetaStream.Free;
    lMetafile.Free;

    if lBitmap <> nil then
      lBitmap.Free;
  end;

end;

function TppRTFRendererImage.GenerateImageInfo: TppRTFImageInfo;
const
  cBottomBuffer = 100;  //Shape control cuts off bottom portion of images.
var
  lImageInfo: TppRTFImageInfo;
begin

  lImageInfo.Left := TppFileDeviceUtils.MicronsToTwips(DrawImageCommand.Left);
  lImageInfo.Top := TppFileDeviceUtils.MicronsToTwips(DrawImageCommand.Top);
  lImageInfo.Right := TppFileDeviceUtils.MicronsToTwips(DrawImageCommand.Left + DrawImageCommand.Width);
  lImageInfo.Bottom := TppFileDeviceUtils.MicronsToTwips(DrawImageCommand.Top + DrawImagecommand.Height) + cBottomBuffer;
  lImageInfo.PicWGoal := TppFileDeviceUtils.MicronsToTwips(DrawImageCommand.Width);
  lImageInfo.PicHGoal := TppFileDeviceUtils.MicronsToTwips(DrawImageCommand.Height);

  if DrawImageCommand.Border.Visible then
    begin
      lImageInfo.BorderColor := DrawImageCommand.Border.Color;
      lImageInfo.BorderWidth := Trunc(DrawImageCommand.Border.Weight * 12700);   //12700 EMU units per point.
    end
  else
    begin
      lImageInfo.BorderColor := clWhite;
      lImageInfo.BorderWidth := 0;
    end;

  Result := lImageInfo;
end;

function TppRTFRendererImage.GetDrawImageCommand: TppDrawImage;
begin
  Result := TppDrawImage(RTFObject.DrawCommand);

end;

procedure TppRTFRendererImage.RenderToRTF;
var
  lImageInfo: TppRTFImageInfo;
begin

  if DrawImageCommand.Picture.Graphic = nil then Exit;

  if (ecImage in RTFSettings.ExportComponents) or (ForceRender) then
    begin
      lImageInfo := GenerateImageInfo;

      DrawImage(lImageInfo);
    end;

end;

initialization

  TppRTFRendererManager.RegisterRenderer(TppRTFRendererImage);

finalization

  TppRTFRendererManager.UnRegisterRenderer(TppRTFRendererImage);

end.

