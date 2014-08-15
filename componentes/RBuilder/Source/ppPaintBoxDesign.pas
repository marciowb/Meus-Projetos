{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPaintBoxDesign;

interface

uses
  Graphics,

  ppTypes,
  ppUtils,
  ppDrwCmd,
  ppPaintBox,

  ppDesignControls,
  ppDesignControlsEx,
  ppPopupMenus;

type

  {TppPaintBoxControl}
  TppPaintBoxControl = class(TppCustomComponentControl)
  protected
    procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@TppPainBoxPopupMenu}
  TppPainBoxPopupMenu = class(TppComponentPopupMenu)
    protected
      procedure CreateMenuItems; override;
  end;

implementation


{******************************************************************************
 *
 ** P A I N T   B O X  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppPaintBoxControl.PaintDesignControl(aCanvas: TCanvas);
var
  lDrawCommand: TppDrawImage;
begin


  lDrawCommand := TppDrawImage.Create(nil);

  try

    {set print position}
    TppPaintBoxBase(Component).PrintPosRect := ppRect(0, 0, Component.mmWidth, Component.mmHeight);

    {assign draw command properties}
    TppPaintBoxBase(Component).PropertiesToDrawCommand(lDrawCommand);

    if TppPaintBoxBase(Component).Transparent then
      aCanvas.CopyMode := cmSrcAnd
    else
      aCanvas.CopyMode := cmSrcCopy;


    {draw to the canvas}
    aCanvas.Draw(0, 0, lDrawCommand.Picture.Graphic);

  finally

    lDrawCommand.free;

  end;

  // paint frame/border
  FrameStyle := fsDashed;
  PaintFrame(aCanvas);

end;

{******************************************************************************
 *
 ** P A I N T B O X    P O P U P  M E N U
 *
{******************************************************************************}

procedure TppPainBoxPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'Transparent', '',  246); {'Transparent'}

end;



end.
