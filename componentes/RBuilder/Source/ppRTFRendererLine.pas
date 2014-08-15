{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFRendererLine;

interface

uses
  Windows,
  Graphics,
  Types,
  ppRTFRenderer,
  ppDevice,
  ppDrwCmd;

type

  TppRTFLineInfo = record
    LineRect: TRect;
    LineStyle: Integer;
    LineDashing: Integer;
    LineWidth: Integer;
    FlipH: Integer;
    Color: TColor;
  end;

  {@TppRTFRendererLine

    Creates the instructions to render a line of specified style and width to the
    Richtext File.

    Lines inside a Richtext document are supported for RTF 1.5 specification
    (Word 97 or later compatible editors).}

  TppRTFRendererLine = class(TppRTFRenderer)
  private
    procedure DrawLine(aLineInfo: TppRTFLineInfo);
    function GetDrawLineCommand: TppDrawLine;
    function GenerateLineInfo: TppRTFLineInfo;

  public
    class function DrawCommandClass: TppDrawCommandClass; override;

    procedure RenderToRTF; override;

    property DrawLineCommand: TppDrawLine read GetDrawLineCommand;

  end;


implementation

uses
  SysUtils,
  ppTypes,
  ppRTFRendererManager,
  ppFilDev;

class function TppRTFRendererLine.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawLine;

end;

procedure TppRTFRendererLine.DrawLine(aLineInfo: TppRTFLineInfo);
begin
  WriteMem('{\shp{\*\shpinst\shpbxpage\shpbypage');
  WriteMem('\shpleft' + IntToStr(aLineInfo.LineRect.Left));
  WriteMem('\shptop' + IntToStr(aLineInfo.LineRect.Top));
  WriteMem('\shpright' + IntToStr(aLineInfo.LineRect.Right));
  WriteMem('\shpbottom' + IntToStr(aLineInfo.LineRect.Bottom));
  WriteMem('\shpwr3\shpwrk0\shpfblwtxt0');                                              //text wrapping options
  WriteMem('\shpfhdr0');                                                                //line is in the main document
  WriteMem('\shpz' + IntToStr(ID));                                                     //z-order
  WriteMem('\shplid' + IntToStr(ID));                                                   //unique id
  WriteMem('{\sp{\sn fBehindDocument}{\sv 1}}');                                        //place the line behind the text
  WriteMem('{\sp{\sn fFlipH}{\sv ' + IntToStr(aLineInfo.FlipH) + '}}');
  WriteMem('{\sp{\sn shapeType}{\sv 20}}');                                             //Shapetype (line)
  WriteMem('{\sp{\sn lineStyle}{\sv ' + IntToStr(aLineInfo.LineStyle) + '}}');          //Line Style (single or double)
  WriteMem('{\sp{\sn lineDashing}{\sv ' + IntToStr(aLineInfo.LineDashing) + '}}');      //Line Dashing
  WriteMem('{\sp{\sn lineColor}{\sv ' + IntToStr(aLineInfo.Color) + '}}');              //Line Color
  WriteMem('{\sp{\sn lineWidth}{\sv ' + IntToStr(aLineInfo.LineWidth) + '}}');          //Line Width (EMU Units)
  WriteLine('}}');

end;

function TppRTFRendererLine.GenerateLineInfo: TppRTFLineInfo;
var
  lLineInfo: TppRTFLineInfo;
begin

  lLineInfo.FlipH := 0;

  //Location
  lLineInfo.LineRect.Left := TppFileDeviceUtils.MicronsToTwips(DrawLineCommand.Left);
  lLineInfo.LineRect.Top := TppFileDeviceUtils.MicronsToTwips(DrawLineCommand.Top);
  lLineInfo.LineRect.Right := TppFileDeviceUtils.MicronsToTwips(DrawLineCommand.Left + DrawLineCommand.Width);
  lLineInfo.LineRect.Bottom := TppFileDeviceUtils.MicronsToTwips(DrawLineCommand.Top + DrawLineCommand.Height);

  //Weight
  lLineInfo.LineWidth := Trunc(DrawLineCommand.Weight * 12700);  //12700 EMU units per point

  if DrawLineCommand.LineStyle = lsDouble then
    begin
      lLineInfo.LineStyle := 1;
      lLineInfo.LineWidth := lLineInfo.LineWidth * 3;  //multiply times 3 to make room for extra line and space
    end
  else
    lLineInfo.LineStyle := 0;

  //Position
  case DrawLineCommand.LinePosition of
    lpTop: lLineInfo.LineRect.Bottom := lLineInfo.LineRect.Top;

    lpBottom: lLineInfo.LineRect.Top := lLineInfo.LineRect.Bottom;

    lpLeft: lLineInfo.LineRect.Right := lLineInfo.LineRect.Left;

    lpRight: lLineInfo.LineRect.Left := lLineInfo.LineRect.Right;

    lpDiagRight: lLineInfo.FlipH := 1;

  end;

  //Color
  lLineInfo.Color := DrawLineCommand.Pen.Color;

  //Style
  case DrawLineCommand.Pen.Style of
    psSolid: lLineInfo.LineDashing := 0;
    psDash: lLineInfo.LineDashing := 1;
    psDot: lLineInfo.LineDashing := 2;
    psDashDot: lLineInfo.LineDashing := 3;
    psDashDotDot: lLineInfo.LineDashing := 4;
  else
    lLineInfo.LineDashing := 0;
  end;

  Result := lLineInfo;

end;

function TppRTFRendererLine.GetDrawLineCommand: TppDrawLine;
begin
  Result := TppDrawLine(RTFObject.DrawCommand);

end;

procedure TppRTFRendererLine.RenderToRTF;
var
  lLineInfo: TppRTFLineInfo;
begin

  if DrawLineCommand.Pen.Style = psClear then Exit;

  if (ecLine in RTFSettings.ExportComponents) then
    begin
      lLineInfo := GenerateLineInfo;
      DrawLine(lLineInfo);
    end;

end;

initialization

  TppRTFRendererManager.RegisterRenderer(TppRTFRendererLine);

finalization

  TppRTFRendererManager.UnregisterRenderer(TppRTFRendererLine);

end.
