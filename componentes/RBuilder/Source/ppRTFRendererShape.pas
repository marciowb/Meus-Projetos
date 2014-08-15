{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFRendererShape;

interface

uses
  Windows,
  Graphics,
  Types,
  ppRTFRenderer,
  ppDevice,
  ppDrwCmd;

type

  TppRTFShapeInfo = record
    ShapeType: Integer;
    ShapeRect: TRect;
    FillColor: TColor;
    FillPattern: Integer;
    LineColor: TColor;
    LineStyle: Integer;
  end;

  {@TppRTFRendererLine

    Creates the instructions to render a shame of specified style to the
    Richtext File.

    Shapes inside a Richtext document are supported for RTF 1.5 specification
    (Word 97 or later compatible editors).}

  TppRTFRendererShape = class(TppRTFRenderer)
  private
    procedure DrawShape(aShapeInfo: TppRTFShapeInfo);
    function GenerateShapeInfo: TppRTFShapeInfo; overload;
    function GetDrawShapeCommand: TppDrawShape;

  public
    class function DrawCommandClass: TppDrawCommandClass; override;

    procedure RenderToRTF; override;

    property DrawShapeCommand: TppDrawShape read GetDrawShapeCommand;

  end;

implementation

uses
  Forms,
  SysUtils,
  ExtCtrls,
  ppTypes,
  ppRTFRendererManager,
  ppFilDev;

class function TppRTFRendererShape.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawShape;

end;

procedure TppRTFRendererShape.DrawShape(aShapeInfo: TppRTFShapeInfo);
begin
  WriteMem('{\shp{\*\shpinst\shpbxpage\shpbypage');
  WriteMem('\shpleft' + IntToStr(aShapeInfo.ShapeRect.Left));
  WriteMem('\shptop' + IntToStr(aShapeInfo.ShapeRect.Top));
  WriteMem('\shpright' + IntToStr(aShapeInfo.ShapeRect.Right));
  WriteMem('\shpbottom' + IntToStr(aShapeInfo.ShapeRect.Bottom));
  WriteMem('\shpwr3\shpwrk0\shpfblwtxt0');                                          //text wrapping options
  WriteMem('\shpfhdr0');                                                            //shape is in the main document
  WriteMem('\shpz' + IntToStr(ID));                                                 //z-order
  WriteMem('\shplid' + IntToStr(ID));                                               //unique id
  WriteMem('{\sp{\sn fBehindDocument}{\sv 1}}');                                    //place the shape behind the text
  WriteMem('{\sp{\sn shapeType}{\sv ' + IntToStr(aShapeInfo.ShapeType) + '}}');     //Shape Type
  WriteMem('{\sp{\sn fillType}{\sv ' + IntToStr(aShapeInfo.FillPattern) + '}}');    //Fill pattern
  WriteMem('{\sp{\sn fillColor}{\sv ' + IntToStr(aShapeInfo.FillColor) + '}}');     //Fill color
  WriteMem('{\sp{\sn lineColor}{\sv ' + IntToStr(aShapeInfo.LineColor) + '}}');     //Line color
  WriteMem('{\sp{\sn lineDashing}{\sv ' + IntToStr(aShapeInfo.LineStyle) + '}}');   //Line style
  WriteLine('}}');

end;

function TppRTFRendererShape.GenerateShapeInfo: TppRTFShapeInfo;
var
  lShapeInfo: TppRTFShapeInfo;
begin

  //Shape Type
  case DrawShapeCommand.ShapeType of
    stRectangle, stSquare: lShapeInfo.ShapeType := 1;
    stRoundRect, stRoundSquare: lShapeInfo.ShapeType := 2;
    stEllipse, stCircle: lShapeInfo.ShapeType := 3;
  end;

  //Position
  lShapeInfo.ShapeRect.Left := TppFileDeviceUtils.MicronsToTwips(DrawShapeCommand.Left);
  lShapeInfo.ShapeRect.Top := TppFileDeviceUtils.MicronsToTwips(DrawShapeCommand.Top);
  lShapeInfo.ShapeRect.Right := TppFileDeviceUtils.MicronsToTwips(DrawShapeCommand.Left + DrawShapeCommand.Width);
  lShapeInfo.ShapeRect.Bottom := TppFileDeviceUtils.MicronsToTwips(DrawShapeCommand.Top + DrawShapeCommand.Height);

  //Color
  if DrawShapeCommand.Pen.Style = psClear then
    lShapeInfo.LineColor := clWhite
  else
    lShapeInfo.LineColor := DrawShapeCommand.Pen.Color;

  if DrawShapeCommand.Brush.Style = bsClear then
    lShapeInfo.FillColor := clWhite
  else
    lShapeInfo.FillColor := DrawShapeCommand.Brush.Color;

  //Style
  case DrawShapeCommand.Pen.Style of
    psSolid: lShapeInfo.LineStyle := 0;
    psDash: lShapeInfo.LineStyle := 1;
    psDot: lShapeInfo.LineStyle := 2;
    psDashDot: lShapeInfo.LineStyle := 3;
    psDashDotDot: lShapeInfo.LineStyle := 4;
  else
    lShapeInfo.LineStyle := 0;
  end;

  //Pattern
  lShapeInfo.FillPattern := 0;  //TODO create metafile?

  Result := lShapeInfo;

end;

function TppRTFRendererShape.GetDrawShapeCommand: TppDrawShape;
begin
  Result := TppDrawShape(RTFObject.DrawCommand);

end;

procedure TppRTFRendererShape.RenderToRTF;
var
  lShapeInfo: TppRTFShapeInfo;
begin

  if (ecShape in RTFSettings.ExportComponents) then
    begin
      lShapeInfo := GenerateShapeInfo;

      DrawShape(lShapeInfo);
    end;

end;

initialization

  TppRTFRendererManager.RegisterRenderer(TppRTFRendererShape);

finalization

  TppRTFRendererManager.UnRegisterRenderer(TppRTFRendererShape);

end.
