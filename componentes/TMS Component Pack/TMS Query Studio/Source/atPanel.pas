unit atPanel;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,StdCtrls; 

const
  WM_AUTOSIZE = WM_USER + 100;
  {$IFDEF NoFlicking}
  WM_ARRANGE = WM_USER + 101;
  {$ENDIF}

type
{The TSortStyle tells atPanel how the controls will be ordered.
ssCreation: The controls will be sorted according to the creation order.
ssTag: Controls will be sorted using its Tag property. If TArrangeMethod is amLabels or
amLabelsJustified, the Tag property used to sort the controls must be in the labels.}
  TSortStyle = (ssCreation,ssTag);
{Use TArrangement type to specify if the controls will be arranged horizontally or vertically}
  TArrangement = (arHorizontal,arVertical);
{atPanel uses TMinWidthType to check how the minimum width of controls will be calculated.
If TMinWidthType is mwLabelWidth, the minimum width of the control will be the width of the label
associated with the control. If TMinWidthType is mwEditorTag, the minimum width will be the same as
the Tag property of the control.}
  TMinWidthType = (mwLabelWidth,mwEditorTag);
{atPanel uses the TArrangeMethod to check how controls will be arranged.
amNone: no arrangement is done, and atPanels works like a TPanel.
amControls: All controls are arranged.
amLabels: Only labels are arranged, but the control specified in the FocusControl of the label will be
put just below the labels.
amLabelsJustified: same as amLabels, but the controls in label's FocusControl property will be
left-right justified.}
  TArrangeMethod = (amNone,amControls,amLabels,amLabelsJustified,amLabelsVertical);

{The atPanel component is a TPanel descendant with an enhancement: it can
arrange controls it contains, horizontally, or vertically. There are various arrangement
types. The atPanel can arrange controls side-by-side, or by labels and its focus control.
This component can be very useful when you want to build sizable forms, and want the controls in
the form rearrange when the form is resized.

The atPanel can also be very useful to build speed bars. You just drop the
buttons in the atPanel, and it will align the buttons horizontally (or vertically),
and space equally. If you want remove some buttons at run-time, setting the
visible property to false, the atPanel will rearrange the remain buttons, and
space equally the buttons.}
  TatPanel = class(TPanel)
  private
    { Private declarations }
    FAutoTabOrder: boolean;
    FLabels : TList;
    FMinWidthType : TMinWidthType;
    FHorzMargin : integer;
    FVertMargin : integer;
    FHorzInterSpace : integer;
    FVertInterSpace : integer;
    FMinSize : integer;
    FControls : TList;
    FSortStyle : TSortStyle;
    FArrangement : TArrangement;
    FWrapControls: boolean;
    FArrangeMethod: TArrangeMethod;
    FMaxWidth : integer;
    FMaxHeight : integer;
    procedure SetHorzMargin(Value : integer);
    procedure SetVertMargin(Value : integer);
    procedure SetHorzInterSpace(Value : integer);
    procedure SetVertInterSpace(Value : integer);
    procedure SetSortStyle(Value : TSortStyle);
    procedure SetArrangement(Value : TArrangement);
    procedure SetMaxWidth(Value: integer);
    procedure SetMaxHeight(Value: integer);
    procedure GetControlList;
    procedure GetLabelList;
    procedure RequestResize(var Message: TMessage); message WM_AUTOSIZE;
    procedure SetArrangeMethod(Value: TArrangeMethod);
    procedure SetWrapControls(Value: boolean);
    procedure SetMinWidthType(Value: TMinWidthType);
    procedure SetAutoTabOrder(Value: boolean);
    procedure CheckAutoSize;
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Resize; override;
    procedure Loaded; override;
    procedure ArrangeNormalControls;
    procedure ArrangeLabels;
    procedure ArrangeLabelsVertical;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{Call this property when you want the controls inside the atPanel to be
rearranged. Sometimes the atPanel doesn't automatically arrange the controls
(when you set the visible property of a control to false, for example), and
you can call this method to do that.}
    procedure ArrangeControls(immediately : Boolean = FALSE); virtual;
    {$IFDEF NoFlicking}
     procedure DoArrange; { do it now }
     procedure ArrangeMsg(var Message: TMessage); message WM_ARRANGE;
    {$ENDIF}
{Call this procedure to retrieve the width and height of the atPanel which
exactly fit all the controls inside it. This method has a similar purpose of
the AutoSize property. The difference is that AutoSize automatically tries to
fit the atPanel size. The GetExactSize method doesn't try to change the atpanel
size, only retrieve the width and Height values, in the AWidth and AHeight params.
If, for example, the atPanel has the Align property set to alClient, the AutoSize
property will not have effect, but you can use GetExactSize to change the size
of the atPanel's parent. Always call ArrangeControsl before GetExactSize.}
    procedure GetExactSize(var AWidth, AHeight: integer);
  published
    { Published declarations }
{Set this property to true if you want the atPanel automatically arrange the
controls inside it, when the panel is resizable, or a control is removed from
the panel.}
    property ArrangeMethod: TArrangeMethod read FArrangeMethod write SetArrangeMethod default amControls;
{Use this property to set distance, in pixels, between the most left control and
the left side of the panel. This property also set the distance, in pixels,
between the most right control and the right side of the panel.}
    property HorzMargin : integer read FHorzMargin write SetHorzMargin default 2;
{Use this property to set distance, in pixels, between the most top control and
the top side of the panel. This property also set the distance, in pixels,
between the most bottom control and the bottom side of the panel.}
    property VertMargin : integer read FVertMargin write SetVertMargin default 2;
{Use this property to set the horizontal distance, in pixels, between the arranged controls.}
    property HorzInterSpace : integer read FHorzInterSpace write SetHorzInterSpace default 2;
{Use this property to set the vertical distance, in pixels, between the arranged controls.}
    property VertInterSpace : integer read FVertInterSpace write SetVertInterSpace default 2;
{Use this property to define which criteria will be used to sort the controls inside the
atPanel.

If this property is ssCreation, the controls will be sorted using the creation order as criteria.

If this property is ssTag, the Tag property of the controls will be used to sort the controls.}
    property SortStyle : TSortStyle read FSortStyle write SetSortStyle default ssCreation;
{Use this property to set the arrangement type of the controls. This can be arHorizontal,
or arVertical.}
    property Arrangement : TArrangement read FArrangement write SetArrangement default arHorizontal;
{Set this property to true if you want the controls to be wrapped, if they don't fit in
the width (if Arrangement is arHorizontal) or the height (if Arrangement is arVertical)
of the atPanel. If this property is false, the AutoSize property doesn't make sense.}
    property WrapControls: boolean read FWrapControls write SetWrapControls default true;
{Use this property to define the MaxSize of the atPanel. This property is useful when
the AutoSize property is true, and you don't want the atPanel to be bigger than a specified
value.

If this property is 0 (zero), the atPanel can have any size, and the MaxSize will not be
checked. The default value is 0 (zero).}
    property MaxWidth: integer read FMaxWidth write SetMaxWidth default 0;
    property MaxHeight: integer read FMaxHeight write SetMaxHeight default 0;

{MinWidthType tells atPanel how the minimum width of the controls will be calculated. Check TMinWidthType
to see the available options.}
    property MinWidthType: TMinWidthType read FMinWidthType write SetMinWidthType default mwLabelWidth;
{if AutoTabOrder is true, atPanel will automatically set the TabOrder of controls according the order
they are arranged}
    property AutoTabOrder: boolean read FAutoTabOrder write SetAutoTabOrder;
{Set this property to true if you want the atPanel automatically set its size
to fit the controls. This property is useful when you use the atPanel to build
tool bars. When this property is true, the following happens:

If the Arrangement property is set to arHorizontal, and the Align property is
alNone, alTop or alBottom, the height of the panel is automatically adjusted
to fit the controls.

If the Arrangement property is set to arVertical, and the Align property is
alNone, alLeft or alRight, the width of the panel is automatically adjusted
to fit the controls.}
    property AutoSize default false;
  end;

implementation

{$IFNDEF TMSDOTNET}
function ComparaItemLista(Item1, Item2: Pointer): Integer;
{$ENDIF}
{$IFDEF TMSDOTNET}
function ComparaItemLista(Item1, Item2: TObject): Integer;
{$ENDIF}
begin
   result := -1;
   if TControl(Item1).Tag = TControl(Item2).Tag then
     result := 0;
   if integer(TControl(Item1).Tag) > integer(TControl(Item2).Tag) then
     result := 1;
end;

constructor TatPanel.Create(AOwner : TComponent);
begin
   FControls:=TList.Create;
   FLabels:=TList.Create;
   inherited Create(AOwner);
   FMinSize:=20;
   FHorzMargin:=2;
   FVertMargin:=2;
   FHorzInterSpace:=2;
   FVertInterSpace:=2;
   FSortStyle:=ssCreation;
   FArrangement:=arHorizontal;
   FWrapControls:=true;
   AutoSize:=false;
   FArrangeMethod:=amControls;
   FMaxWidth:=0;
   FMaxHeight:=0;
   FMinWidthType:=mwLabelWidth;
end;

destructor TatPanel.Destroy;
begin
   if FControls<>nil then FControls.Free;
   if FLabels<>nil then FLabels.Free;
   inherited;
end;

procedure TatPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
   inherited Notification(AComponent, Operation);
   if not (csDestroying in ComponentState) and (csDesigning in ComponentState) then
      ArrangeControls;
end;

procedure TatPanel.SetHorzMargin(Value : integer);
begin
   if Value<>FHorzMargin then
   begin
      FHorzMargin:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetSortStyle(Value : TSortStyle);
begin
   if Value<>FSortStyle then
   begin
      FSortStyle:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetVertMargin(Value : integer);
begin
   if Value<>FVertMargin then
   begin
      FVertMargin:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetAutoTabOrder(Value : boolean);
begin
   if Value<>FAutoTabOrder then
   begin
      FAutoTabOrder:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetHorzInterSpace(Value : integer);
begin
   if Value<>FHorzInterSpace then
   begin
      FHorzInterSpace:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetVertInterSpace(Value : integer);
begin
   if Value<>FVertInterSpace then
   begin
      FVertInterSpace:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetMaxWidth(Value: integer);
begin
   if Value<>FMaxWidth then
   begin
      FMaxWidth:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetMaxHeight(Value: integer);
begin
   if Value<>FMaxHeight then
   begin
      FMaxHeight:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetArrangement(Value : TArrangement);
begin
   if Value<>FArrangement then
   begin
      FArrangement:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetMinWidthType(Value: TMinWidthType);
begin
   if Value<>FMinWidthType then
   begin
      FMinWidthType:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetWrapControls(Value: boolean);
begin
   if Value<>FWrapControls then
   begin
      FWrapControls:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.SetArrangeMethod(Value: TArrangeMethod);
begin
   if Value<>FArrangeMethod then
   begin
      FArrangeMethod:=Value;
      ArrangeControls;
   end;
end;

procedure TatPanel.GetControlList;
Var c : integer;
begin
   if FControls<>nil then With FControls do
   begin
      Clear;
      for c:=0 to Self.ControlCount-1 do Add(Self.Controls[c]);
      Case FSortStyle of
         ssTag : begin
                    Sort(ComparaItemLista);
                 end;
      end;
   end;
end;

procedure TatPanel.GetLabelList;
Var c : integer;
begin
   if FLabels<>nil then With FLabels do
   begin
      Clear;
      for c:=0 to Self.ControlCount-1 do
         if (Self.Controls[c] is TCustomLabel) and
            (( csDesigning in ComponentState) or Self.Controls[c].Visible) then
               Add(Self.Controls[c]);
      Case FSortStyle of
         ssTag : begin
                    Sort(ComparaItemLista);
                 end;
      end;
   end;
end;

const
  MAXLABELS = 200;

procedure TatPanel.ArrangeLabels;
var c,c1       : integer;
    x,y,dx,minw  : integer;
    Ampliacao    : double;
    Deslocamento : integer;
    h,dy         : integer;
    lefts        : array[0..MAXLABELS] of integer;
    tops         : array[0..MAXLABELS] of integer;
    widths       : array[0..MAXLABELS] of integer;

    function GetMinWidth(ALabel: TLabel):integer;
    begin
       result:=0;
       Case FMinWidthType of
          mwLabelWidth: result:=ALabel.Width;
          mwEditorTag: if Assigned(ALabel.FocusControl) then
                          result := integer(ALabel.FocusControl.Tag)
                       else result:=0;
       end;
    end;

    procedure Justifica;
    var c2,w,len,minw : integer;
    begin
       len:=Width-2*HorzMargin-(c-c1-1)*HorzInterSpace;
       Ampliacao:=len/(x-(c-c1)*HorzInterSpace-HorzMargin);
       Deslocamento:=0;
       w:=0;
       for c2:=c1 to c-1 do with TLabel(FLabels[c2]) do
       begin
//          minw:=GetMinWidth(TLabel(FLabels[c2]))*Canvas.TextWidth('9')+8;
          minw:=GetMinWidth(TLabel(FLabels[c2]))+8;
          if (c2<c-1) then
             dx:=Trunc(Ampliacao*minw)-Widths[c2]
          else
             dx:=len-w-Widths[c2];
          Widths[c2]:=Widths[c2]+dx;
          w:=w+Widths[c2];
          Lefts[c2]:=Lefts[c2]+Deslocamento;
          Deslocamento:=Deslocamento+dx;
       end;
       c1:=c;
    end;

begin
   {$IFDEF NoFlicking}
    DoubleBuffered := TRUE;
   {$ENDIF}
   GetLabelList;
   x:=HorzMargin;
   y:=VertMargin;
   dy:=0;
   c1:=0;
   for c:=0 to FLabels.Count-1 do with TLabel(FLabels[c]) do
   begin
      if FAutoTabOrder and Assigned(FocusControl) then
          FocusControl.TabOrder:=c;
//      MinW:=GetMinWidth(TLabel(FLabels[c]))*Canvas.TextWidth('9')+8;
      MinW:=GetMinWidth(TLabel(FLabels[c]))+8;
      if (x+MinW>Self.Width-HorzMargin) and (x>HorzMargin) then
      begin
         if (FArrangeMethod=amLabelsJustified) then Justifica;
         x:=HorzMargin;
         y:=y+dy+VertInterSpace;
         dy:=0;
      end;
      Lefts[c]:=x;
      Tops[c]:=y;
      Widths[c]:=MinW;
      if Assigned(TLabel(FLabels[c]).FocusControl) then
         h:=TLabel(FLabels[c]).height+1+TLabel(FLabels[c]).FocusControl.Height
      else
         h:=TLabel(FLabels[c]).height+1;
      if h>dy then dy:=h;
      x:=x+MinW+HorzInterSpace;
   end;
   if (FArrangeMethod=amLabelsJustified) and (FLabels.Count>0) then Justifica;
   for c:=0 to FLabels.Count-1 do with TLabel(FLabels[c]) do
   begin
      Left:=Lefts[c];
      Top:=Tops[c];
//      Width:=Widths[c];
      if Assigned(FocusControl) then With FocusControl do
      begin
         {$IFDEF NoFlicking}
         if TLabel(FLabels[c]).FocusControl is TWinControl then
         begin
            TWinControl(TLabel(FLabels[c]).FocusControl).doublebuffered := TRUE;
            for i := 0 to TWinControl(TLabel(FLabels[c]).FocusControl).ControlCount-1 do
               if TWinControl(TLabel(FLabels[c]).FocusControl).Controls[i] is TWinControl then
                  (TWinControl(TLabel(FLabels[c]).FocusControl).Controls[i] as TWinControl).DoubleBuffered := TRUE;
         end;
         {$ENDIF}
         Left:=Lefts[c];
         Top:=Tops[c]+TLabel(FLabels[c]).Height+1;
         Width:=Widths[c];
      end;
   end;
   CheckAutoSize;
end;

procedure TatPanel.ArrangeLabelsVertical;
Var MaxLabelWidth,MaxControlWidth: integer;
    c,x,y: integer;
    CurLab: TLabel;

    function GetLabelTop(Lab: TLabel;OffY:integer):integer;
    begin
       if Assigned(Lab.FocusControl) and (Lab.FocusControl.Height>Lab.Height) then
          result:=Offy + (Lab.FocusControl.Height div 2) - (Lab.Height div 2)
       else
          result:=OffY;
    end;

    function GetControlTop(Lab: TLabel;OffY:integer):integer;
    begin
       if Assigned(Lab.FocusControl) and (Lab.FocusControl.Height<Lab.Height) then
          result:=Offy + (Lab.Height div 2) - (Lab.FocusControl.Height div 2)
       else
          result:=OffY;
    end;

    function GetLineHeight(Lab: TLabel):integer;
    begin
       result:=Lab.Height;
       if Assigned(Lab.FocusControl) and (Lab.FocusControl.Height>result) then
          result:=Lab.FocusControl.Height;
    end;

begin
   GetLabelList;
   MaxLabelWidth:=0;
   MaxControlWidth:=0;

   {Get max width of labels and controls, and set tab order if requested}
   for c:=0 to FLabels.Count-1 do With TLabel(FLabels[c]) do
   begin
      if FAutoTabOrder and Assigned(FocusControl) then FocusControl.TabOrder:=c;
      if Canvas.TextWidth(Caption)>MaxLabelWidth then MaxLabelWidth:=Canvas.TextWidth(Caption);
      if Assigned(FocusControl) then
         Case FMinWidthType of
            mwLabelWidth:
               if Width>MaxControlWidth then MaxControlWidth:=Width;
            mwEditorTag:
               if integer(FocusControl.Tag) > MaxControlWidth then
                  MaxControlWidth := integer(FocusControl.Tag);
         end;
   end;
   x:=MaxLabelWidth+FHorzMargin+FHorzInterSpace;
   y:=FVertMargin;
   for c:=0 to FLabels.Count-1 do
   begin
      CurLab:=TLabel(FLabels[c]);
      With CurLab do
      begin
         Top:=GetLabelTop(CurLab,y);
         Case Alignment of
            taLeftJustify : Left:=FHorzMargin;
            taRightJustify : Left:=x-FHorzInterSpace-CurLab.Width;
            taCenter : Left:=FHorzMargin+((x-FHorzMargin-FHorzInterspace) div 2)-(CurLab.Width div 2);
         end;
      end;
      if Assigned(CurLab.FocusControl) then
      With CurLab.FocusControl do
      begin
         Top:=GetControlTop(CurLab,y);
         Left:=x;
         Case FMinWidthType of
            mwLabelWidth: Width:=CurLab.Width;
            mwEditorTag: Width := integer(CurLab.FocusControl.Tag);
         end;
         if Left+Width>Self.Width-FHorzMargin then
            Width:=Self.Width-FHorzMargin-Left;
         y:=y+GetLineHeight(CurLab)+FVertInterSpace;
      end;
   end;

   CheckAutoSize;
end;

procedure TatPanel.CheckAutoSize;
Var MaxRight, MaxBottom: integer;
    RequestResize: boolean;

begin
   if AutoSize then
   begin
      GetExactSize(MaxRight,MaxBottom);
      RequestResize:=false;
      if ((Height<>MaxBottom) and (Align in [alNone,alTop,alBottom])) then
      begin
         Height:=MaxBottom;
         if (MaxHeight<>0) and (Height>FMaxHeight) then Height:=FMaxHeight;
         RequestResize:=true;
      end;
      if ((Width<>MaxRight) and (Align in [alNone,alLeft,alRight])) then
      begin
         Width:=MaxRight;
         if (MaxWidth<>0) and (Width>FMaxWidth) then Width:=FMaxWidth;
         RequestResize:=true;
      end;
      if RequestResize then PostMessage(Handle,WM_AUTOSIZE,0,0);
   end;
end;

procedure TatPanel.ArrangeNormalControls;
Var c : integer;
    l,t : integer;
    MaxRowSize:integer;
begin
   l:=FHorzMargin;
   t:=FVertMargin;
   MaxRowSize:=0;
   GetControlList;
   if FControls<>nil then
   begin
      for c:=0 to FControls.Count-1 do With TControl(FControls[c]) do
      if Visible or (csDesigning in ComponentState) then
      begin
         if FAutoTabOrder and (TObject(FControls[c]) is TWinControl) then
            TWinControl(FControls[c]).TabOrder:=c;
         Left:=l;
         Top:=t;
         Case FArrangement of
            arHorizontal :
               begin
                  l:=l+Width+FHorzInterSpace;
                  if (l>Self.Width) and (FWrapControls) then
                  begin
                     Left:=FHorzMargin;
                     t:=t+MaxRowSize+FVertInterSpace;
                     Top:=t;
                     l:=Left+Width+FHorzInterSpace;
                     MaxRowSize:=Height;
                  end;
                  if Height>MaxRowSize then MaxRowSize:=Height;
               end;
            arVertical :
               begin
                  t:=t+Height+FVertInterSpace;
                  if (t>Self.Height) and (FWrapControls) then
                  begin
                     Top:=FVertMargin;
                     l:=l+MaxRowSize+FHorzInterSpace;
                     Left:=l;
                     t:=Top+Height+FVertInterSpace;
                     MaxRowSize:=Width;
                  end;
                  if Width>MaxRowSize then MaxRowSize:=Width;
               end;
         end;
      end;
      if AutoSize then
         Case FArrangement of
            arHorizontal :
               if (Height<>t+MaxRowSize+FVertMargin) and
                  (Align in [alNone,alTop,alBottom]) then
               begin
                  Height:=t+MaxRowSize+FVertMargin;
                  if (MaxHeight<>0) and (Height>FMaxHeight) then Height:=FMaxHeight;
                  PostMessage(Handle,WM_AUTOSIZE,0,0);
               end;
            arVertical :
               if (Width<>l+MaxRowSize+FHorzMargin) and
                  (Align in [alNone,alLeft,alRight]) then
               begin
                  Width:=l+MaxRowSize+FHorzMargin;
                  if (MaxWidth<>0) and (Width>FMaxWidth) then Width:=FMaxWidth;
                  PostMessage(Handle,WM_AUTOSIZE,0,0);
               end;
         end;
   end;
end;

procedure TatPanel.ArrangeControls(immediately : Boolean = FALSE);
{$IFDEF NoFlicking}
var
  msg: TMsg;
{$ENDIF}
begin
  if WindowHandle <> 0 then
  begin
    {$IFDEF NoFlicking}
    if NOT immediately then
    begin
       while PeekMessage(msg,handle,WM_ARRANGE,WM_ARRANGE,PM_REMOVE) do ;
       PostMessage(handle,WM_ARRANGE,0,0);
    end
    else
    {$ENDIF}
       Case FArrangeMethod of
          amControls : ArrangeNormalControls;
          amLabels,amLabelsJustified : ArrangeLabels;
          amLabelsVertical : ArrangeLabelsVertical;
       end;
  end;
end;

procedure TatPanel.Resize;
begin
  inherited;
     if not (csDestroying in ComponentState) then
        ArrangeControls;
end;

procedure TatPanel.Loaded;
begin
  inherited;
  ArrangeControls;
end;

procedure TatPanel.GetExactSize(var AWidth, AHeight: integer);
Var c: integer;
    MaxRight: integer;
    MaxBottom: integer;
begin
   MaxRight:=0;
   MaxBottom:=0;
   for c:=0 to ControlCount-1 do With Controls[c] do
      if Visible then
      begin
         if (Left+Width)>MaxRight then MaxRight:=Left+Width;
         if (Top+Height)>MaxBottom then MaxBottom:=Top+Height;
      end;
   AWidth:=MaxRight+FHorzMargin;
   AHeight:=MaxBottom+FVertMargin;
end;

procedure TatPanel.RequestResize(var Message: TMessage);
begin
   {$IFDEF DELPHI3_LVL}
   RequestAlign;
   {$ELSE}
   Parent.Realign;
   {$ENDIF}
end;

{$IFDEF NoFlicking}
procedure TatPanel.DoArrange;
begin
   Case FArrangeMethod of
      amControls : ArrangeNormalControls;
      amLabels,amLabelsJustified : ArrangeLabels;
      amLabelsVertical : ArrangeLabelsVertical;
   end;
end;

procedure TatPanel.ArrangeMsg(var Message: TMessage);
begin
  DoArrange;
end;
{$ENDIF}

end.
