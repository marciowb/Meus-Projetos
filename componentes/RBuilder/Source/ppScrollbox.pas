{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppScrollBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ppTypes;

type

  TppScrollInViewEvent = procedure(Sender: TObject; aControl: TControl; var Accept: Boolean) of object;

 {@TppScrollBox

   Descendent scrollbox which allows access to the scrolling events of the
   scrollbox which TScrollbox doesn't provide.}

  TppScrollBox = class(TScrollBox)
    private
      FOnVerticalScroll: TppVerticalScrollEvent;
      FOnHorizontalScroll: TppHorizontalScrollEvent;
      FOnScrollInView: TppScrollInViewEvent;

      procedure WMVScroll(var aMessage: TWMScroll); message WM_VScroll;
      procedure WMHScroll(var aMessage: TWMScroll); message WM_HScroll;

    protected
      procedure AutoScrollInView(aControl: TControl); override;
      procedure VerticalScroll(aPosition: Integer; aEventType: TppVerticalScrollEventType); virtual;
      procedure HorizontalScroll(aPosition: Integer; aEventType: TppHorizontalScrollEventType); virtual;

    public
      constructor Create(aOwner: TComponent); override;

    published
      property OnScrollInView: TppScrollInViewEvent read FOnScrollInView write FOnScrollInView;
      property OnVerticalScroll: TppVerticalScrollEvent read FOnVerticalScroll write FOnVerticalScroll;
      property OnHorizontalScroll: TppHorizontalScrollEvent read FOnHorizontalScroll write FOnHorizontalScroll;
  end;

implementation

{@TppScrollBox.Create}

constructor TppScrollBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FOnVerticalScroll := nil;
  FOnHorizontalScroll := nil;
end;

{@TppScrollBox.AutoScrollInView}

procedure TppScrollBox.AutoScrollInView(AControl: TControl);
var
  lbAccept: Boolean;
begin

  lbAccept := True;

  if Assigned(FOnScrollInView) then FOnScrollInView(Self, aControl, lbAccept);

  if lbAccept then
    inherited;

end;

{@TppScrollBox.Create}

procedure TppScrollBox.VerticalScroll(aPosition: Integer; aEventType: TppVerticalScrollEventType);
begin
  if Assigned(FOnVerticalScroll) then FOnVerticalScroll(Self, aPosition, aEventType);
end;

{@TppScrollBox.Create}

procedure TppScrollBox.HorizontalScroll(aPosition: Integer; aEventType: TppHorizontalScrollEventType);
begin
  if Assigned(FOnHorizontalScroll) then FOnHorizontalScroll(Self, aPosition, aEventType);
end;

{@TppScrollBox.Create}

procedure TppScrollBox.WMVScroll(var aMessage: TWMScroll);
var
  lEventType : TppVerticalScrollEventType;
begin

  inherited;

  lEventType := TppVerticalScrollEventType(aMessage.ScrollCode);

  if lEventType in [vsThumbPos, vsThumbTrack] then
    VerticalScroll(aMessage.Pos, lEventType)
  else
    VerticalScroll(VertScrollBar.Position, lEventType)
end;

{@TppScrollBox.Create}

procedure TppScrollBox.WMHScroll(var aMessage: TWMScroll);
var
  lEventType : TppHorizontalScrollEventType;
begin

  inherited;

  lEventType := TppHorizontalScrollEventType(aMessage.ScrollCode);

  if lEventType in [hsThumbPos, hsThumbTrack] then
    HorizontalScroll(aMessage.Pos, lEventType)
  else
    HorizontalScroll(HorzScrollBar.Position, lEventType)
end;

initialization
  RegisterClass(TppScrollBox);

finalization
  UnRegisterClass(TppScrollBox);

end.
