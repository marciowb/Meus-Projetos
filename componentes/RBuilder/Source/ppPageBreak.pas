unit ppPageBreak;

interface

uses
  Classes,
  SysUtils,
  ppClass,
  ppBands,
  ppStrtch,
  ppRTTI;

type

  {@TppPageBreak

    The TppPageBreak component is a report control that allows the user to force
    a new page during report generation.  Placing a TppPageBreak component on a
    report will cause all objects created after the PageBreak (Z-Order) to be
    moved to the next page in the report relative to the PageBreak object's top
    position.  If you would like a report to break a page after a stretchable
    component has finished printing, you will need to assign the
    TppPageBreak.ShiftRelativeTo property to the Stretchable component.

    The TppPageBreak component is not supported inside the page Footer Band or
    a TppRegion component.}

  TppPageBreak = class(TppStretchable)
    protected
      procedure CalcSpaceUsed; override;
      procedure SetRegion(aRegion: TppComponent); override;
      procedure SetShiftRelativeTo(aStretchable: TppStretchable); override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure Generate; override;

      function  HasColor: Boolean; override;
      function  HasFont: Boolean; override;

      property Stretch;

    published
      property ShiftRelativeTo;
      property Top;
      property Visible;

  end;

  TraTppPageBreakRTTI = class(TraTppStretchableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end;

implementation

{******************************************************************************
 *
 ** P A G E   B R E A K
 *
{******************************************************************************}

constructor TppPageBreak.Create(aOwner: TComponent);
begin
  inherited;

  ParentWidth := True;
  spHeight := 13;
  Stretch := False;
end;

{------------------------------------------------------------------------------}
{ TppPageBreak.CalcSpaceUsed }

procedure TppPageBreak.Generate;
begin

  // required to support toggling of PageBreak.Visible
  // CalcSpaceUsed is only called when the component is visible
  if not(Visible) and OverFlow then
    OverFlow := False;

  inherited;

end;


{------------------------------------------------------------------------------}
{ TppPageBreak.CalcSpaceUsed }

procedure TppPageBreak.CalcSpaceUsed;
begin
{  if (ShiftRelativeTo <> nil) then
    begin
      SpaceUsed := TppCustomBand(Band).PageBottom - TppCustomBand(Band).PrintPosRect.Top;
    end
  else
    begin}
      // set SpaceUsed to 1, rather than 0 - this fixes a case when a PageBreak is
      // inside a child subreport
      SpaceUsed := 1;

      if OverFlow then
        OverFlow := False
      else
        begin

          TppCustomBand(Band).OutOfSpace := True;
          TppCustomBand(Band).GenerationComplete := True;

          OverFlow := True;
        end;

//    end;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppPageBreak.SetRegion }

procedure TppPageBreak.SetRegion(aRegion: TppComponent);
begin
  {Overide this method to prevent a PageBreak component from being placed inside
   a region. }
end; {procedure, SetRegion}

{------------------------------------------------------------------------------}
{ TppPageBreak.SetShiftRelativeTo }

procedure TppPageBreak.SetShiftRelativeTo(aStretchable: TppStretchable);
begin
  inherited SetShiftRelativeTo(aStretchable);

  if aStretchable <> nil then
    Stretch := True
  else
    Stretch := False;
end; {procedure, SetShiftRelativeTo}

function TppPageBreak.HasColor: Boolean;
begin
  Result := False;
end;

function TppPageBreak.HasFont: Boolean;
begin
  Result := False;
end;

{******************************************************************************
 *
 ** P A G E   B R E A K   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppPageBreakRTTI.RefClass }

class function TraTppPageBreakRTTI.RefClass: TClass;
begin
  Result := TppPageBreak;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppPageBreakRTTI.GetPropList }

class procedure TraTppPageBreakRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Stretch');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppPageBreakRTTI.GetPropValue }

class function TraTppPageBreakRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Stretch') = 0) then
    Boolean(aValue) := TppPageBreak(aObject).Stretch

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class procedure, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppPageBreakRTTI.SetPropValue }

class function TraTppPageBreakRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Stretch') = 0) then
    TppPageBreak(aObject).Stretch := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class procedure, SetPropValue}



end.
