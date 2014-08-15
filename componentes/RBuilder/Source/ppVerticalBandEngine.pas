unit ppVerticalBandEngine;

interface

uses
  Classes,
  ppDetailBandEngine;

type

  { TppVerticalBandEngine }

  TppVerticalBandEngine = class(TppDetailBandEngine)
    protected
      procedure UpdatePrintPosition; override;
  end;

implementation

uses
  ppTypes, ppBands;
  

{------------------------------------------------------------------------------}
{ TppVerticalBandEngine.UpdatePrintPosition }

procedure TppVerticalBandEngine.UpdatePrintPosition;
var
  lRect: TppRect;
begin

  if (Band.PrintHeight = phStatic) then
    SpaceUsed := Band.mmHeight;

  SpaceUsed := SpaceUsed + Band.mmBottomOffset;

  lRect := PrintPosRect;
  lRect.Top := lRect.Top + SpaceUsed;
  lRect.Bottom := lRect.Top;

  Report.Engine.SetPrintPosition(lRect.Left, lRect.Top, lRect.Right, lRect.Top);

  Report.Engine.SpaceUsed := Report.Engine.SpaceUsed + SpaceUsed;

end;{procedure, UpdatePrintPosition}

end.
