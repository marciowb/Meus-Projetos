unit ppBarCode2DDesign;

interface

uses
  Classes,
  Graphics,
  ppDesignControls, {contains DesignControlFactory used to register the checkbox design control}
  ppDesignControlsEx, {contains declaration of component design control ancestor}

  ppBarCode2D,
  ppBarCode2DDrawCmd;

type

  {@Tpp2DBarCodeControl}
  Tpp2DBarCodeControl = class(TppCustomComponentControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


implementation

uses
  Types,

  ppPopupMenus,
  ppUtils,
  ppTypes;


{TppPDF417BarCodeControl }

{------------------------------------------------------------------------------}
{@Tpp2DBarCodeControl.PaintDesignControl}

procedure Tpp2DBarCodeControl.PaintDesignControl(aCanvas: TCanvas);
var
  lDrawCommand: TppDraw2DBarCode;
  lMetaFile: TMetaFile;
begin

  lDrawCommand := TppDraw2DBarCode.Create(nil);

  try

    if not(Tpp2DbarCode(Component).AutoSize) then
      Tpp2dBarCode(Component).Initialize;

    Component.PrintPosRect := ppRect(0, 0, Component.mmWidth, Component.mmHeight);
    Tpp2DBarCode(Component).PropertiesToDrawCommand(lDrawCommand);

    lMetaFile := lDrawCommand.AsMetaFile;

    try
      aCanvas.StretchDraw(ClientRect, lMetaFile);
    finally
      lMetaFile.Free;
    end;

  finally
    lDrawCommand.Free;

  end;

end; {procedure, PaintDesignControl}



end.
