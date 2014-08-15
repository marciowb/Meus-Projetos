{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPaintBox;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Graphics,
  SysUtils,
  Types,

  ppRTTI,
  ppTypes,
  ppUtils,
  ppClass,
  ppCtrls,
  ppDrwCmd,
  ppDevice;

type


  {@TppPaintBoxBase

    Ancestor to TppPaintBox. Defines a report control that can be used to draw
    directly to a Canvas.

    TppPaintBoxBase can be used as an ancestor class for creating simple custom
    components.}

  TppPaintBoxBase = class(TppCustomComponent)
  private
    FCanvas: TMetaFileCanvas;
    FDesignMetaFile: TMetaFile;
    FMetaFile: TMetaFile;

  protected
    procedure BoundsChange; override;


    function GetCanvas: TCanvas; virtual;
    function GetCaption: String; override;
    function GetDesignTimeImage: TGraphic; virtual;
    property Canvas: TCanvas read GetCanvas;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

    procedure DoOnPrint; override;

  published

    property Anchors;
    property Border;
    property OnDrawCommandClick;
    property OnDrawCommandCreate;
    property ReprintOnOverFlow;
    property UserName;
    property Visible;
    property Transparent;

    {these properties saved in 'fake' properties}
    property Height stored False;
    property Left stored False;
    property Top stored False;
    property Width stored False;

  end;


  {@TppPaintBox

    The TppPaintBox component is a report control that can be used to draw
    directly to a Canvas. Position and size the paint box to occupy the desired
    area of the report layout. Use the OnPrint event to access the
    Canvas and draw text, lines, images, etc.
    <CODE>

        myPaintBox.Canvas.Font.Name := 'Times New Roman';
        myPaintBox.Canvas.Font.Size := 10;

        myPaintBox.Canvas.TextOut(2, 2, 'Hello Paintbox!');


    </CODE>}

  {@TppPaintBox.Canvas

    Use the Canvas property to draw text, lines, images, etc. Use the OnPrint
    event to draw to the canvas.
    <CODE>

        myPaintBox.Canvas.Font.Name := 'Times New Roman';
        myPaintBox.Canvas.Font.Size := 10;

        myPaintBox.Canvas.TextOut(2, 2, 'Hello Paintbox!');


    </CODE>}

   TppPaintBox = class(TppPaintBoxBase)
   public
     property Canvas;

   end;


  {TraTppPaintBoxRTTI}
  TraTppPaintBoxRTTI = class(TraTppComponentRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
    class function RefClass: TClass; override;
  end;


  {TraTCanvasRTTI}
  TraTCanvasRTTI = class(TraTPersistentRTTI)
  public
    class function CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function GetParams(const aMethodName: String): TraParamList; override;
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function RefClass: TClass; override;
  end;

{
  // test code for Canvas.TextOut
  PaintBox1.Canvas.Font.Name := 'Courier New';
  PaintBox1.Canvas.Font.Color := clRed;
  PaintBox1.Canvas.TextOut(10, 10, 'Paintbox Rocks!!!');

  PaintBox1.Canvas.Font.Color := clBlue;
  PaintBox1.Canvas.TextOut(10, 30, 'Blue text');
}

{
   TppComponentWrapper = class(TppPaintBoxBase)
     property Component: IRBAdapter
   end;

   IRBAdapter
     SetWidth(Width);
     SetHeight(Height);
     Draw(aBoundsRect: TRect; aCanvas);

     ??DrawDesignImage(aCanvas);

}


implementation

{******************************************************************************
 *
 ** P A I N T B O X
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.Create }

constructor TppPaintBoxBase.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  {init inherited properties}
  DefaultPropName     := 'UserName';
  DrawCommandClass := TppDrawImage;

  spHeight   := 75;
  spWidth    := 75;

  FMetaFile := TMetaFile.Create;

  FDesignMetaFile := TMetaFile.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.Destroy }

destructor TppPaintBoxBase.Destroy;
begin
  FCanvas.Free;
  FCanvas := nil;

  FMetaFile.Free;
  FMetaFile := nil;

  FDesignMetaFile.Free;
  FDesignMetaFile := nil;

  inherited Destroy;
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.BoundsChange }

procedure TppPaintBoxBase.BoundsChange;
begin

  // free the canvas
  FCanvas.Free;
  FCanvas := nil;

  if (FMetaFile <> nil) then
    begin
      FMetaFile.MMWidth := mmWidth div 10;
      FMetaFile.MMHeight := mmHeight div 10;
    end;

  inherited;

end; {procedure, BoundsChange}

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.DoOnPrint }

procedure TppPaintBoxBase.DoOnPrint;
begin

  // descendants can add custom painting code here

  // fire the OnPrint event
  inherited;

end; {function, DoOnPrint}

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.GetCanvas }

function TppPaintBoxBase.GetCanvas: TCanvas;
begin

  // create on demand to allow drawing
  if (FCanvas = nil) and (FMetafile <> nil) then
    FCanvas := TMetaFileCanvas.Create(FMetaFile, 0);

  Result := FCanvas;

end;

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.GetCaption }

function TppPaintBoxBase.GetCaption: String;
begin

 Result := UserName;

end; {procedure, GetCaption}

{------------------------------------------------------------------------------}
{TppPaintBoxBase.GetDesignTimeImage}

function TppPaintBoxBase.GetDesignTimeImage: TGraphic;
var
  lsCaption: String;
  liX: Integer;
  liY: Integer;
  liWidth: Integer;
  liHeight: Integer;
  lCanvas: TMetaFileCanvas;
  lRect: TRect;
begin

  FDesignMetaFile.MMWidth := mmWidth div 10;
  FDesignMetaFile.MMHeight := mmHeight div 10;

  lRect := spClientRect;
  lRect.Right := lRect.Right + 1;
  lRect.Bottom := lRect.Bottom + 1;

  lCanvas := TMetaFileCanvas.Create(FDesignMetaFile, 0);

  try
    lCanvas.Brush.Color := clBtnFace;
    lCanvas.FillRect(lRect);

    {center caption}
    lCanvas.Font := Font;

    lsCaption := '(' + Caption + ')';
    liWidth  := lCanvas.TextWidth(lsCaption);
    liHeight := lCanvas.TextHeight(lsCaption);
    liX      := (spClientRect.Right - liWidth) div 2;
    liY      := (spClientRect.Bottom - liHeight) div 2;

    lCanvas.TextRect(spClientRect, liX, liY, lsCaption);
    
  finally
    lCanvas.Free;

  end;


  Result := FDesignMetaFile;

end;

{------------------------------------------------------------------------------}
{ TppPaintBoxBase.PropertiesToDrawCommand }

procedure TppPaintBoxBase.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawImage;
begin

  if not(aDrawCommand is TppDrawImage) then Exit;

  lDrawCommand := TppDrawImage(aDrawCommand);

  {transfer properties to draw command}
  lDrawCommand.Left := PrintPosRect.Left;
  lDrawCommand.Top := PrintPosRect.Top;
  lDrawCommand.Height := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawCommand.Width := PrintPosRect.Right - PrintPosRect.Left;
  lDrawCommand.DirectDraw := True;
  lDrawCommand.Transparent := Transparent;
  lDrawCommand.Border := Border;

  {we need a name for the optimization scheme}
//  if (Name = '') then
//    Name := GetValidName(Self);

//  lDrawCommand.ImageName := Name + IntToStr(FImageID);

  // free the canvas
  FCanvas.Free;
  FCanvas := nil;

  // assign metafile after freeing the canvas
  if (pppcDesigning in DesignState) and not Printing then
    lDrawCommand.Picture.Graphic := GetDesignTimeImage
  else
    lDrawCommand.Picture.Graphic := FMetaFile;

end; {procedure, PropertiesToDrawCommand}


{******************************************************************************
 *
 ** P A I N T B O X  R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppPaintBoxRTTI.RefClass }

class function TraTppPaintBoxRTTI.RefClass: TClass;
begin
  Result := TppPaintBoxBase;

end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppPaintBoxRTTI.GetPropList }

class procedure TraTppPaintBoxRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('Canvas');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppPaintBoxRTTI.GetPropRec }

class function TraTppPaintBoxRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Canvas') = 0) then
    ClassPropToRec(aPropname, TCanvas, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppPaintBoxRTTI.GetPropValue }

class function TraTppPaintBoxRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Canvas') = 0) then
    TCanvas(aValue) := TppPaintBoxBase(aObject).Canvas

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}



{******************************************************************************
 *
 ** C A N V A S  R T T I
 *
{******************************************************************************}


class procedure TraTCanvasRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  // Canvas methods
  aPropList.AddMethod('Arc');
  aPropList.AddMethod('Draw');
  aPropList.AddMethod('StretchDraw');
  aPropList.AddMethod('Ellipse');
  aPropList.AddMethod('FillRect');
  aPropList.AddMethod('FrameRect');
  aPropList.AddMethod('LineTo');
  aPropList.AddMethod('MoveTo');
  aPropList.AddMethod('Rectangle');
  aPropList.AddMethod('TextOut');
  aPropList.AddMethod('TextRect');
  aPropList.AddMethod('TextHeight');
  aPropList.AddMethod('TextWidth');

// NOT supported by RAP...
// Polygon - requires array of points
// PolyBezier - requires array of points
// Polyline - requires array of points

end;


class function TraTCanvasRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Arc') or
     ppEqual(aPropName, 'Draw') or
     ppEqual(aPropName, 'StretchDraw') or
     ppEqual(aPropName, 'Ellipse') or
     ppEqual(aPropName, 'LineTo') or
     ppEqual(aPropName, 'MoveTo') or
     ppEqual(aPropName, 'TextWidth') or
     ppEqual(aPropName, 'TextHeight') or
     ppEqual(aPropName, 'TextOut') or
     ppEqual(aPropName, 'TextRect') or
     ppEqual(aPropName, 'FrameRect') or
     ppEqual(aPropName, 'FillRect') or
     ppEqual(aPropName, 'Rectangle') then

    MethodToRec(aPropName, True, aPropRec)


  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;


class function TraTCanvasRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'Arc') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X1', daInteger, nil, '', False, False);
      Result.AddParam('Y1', daInteger, nil, '', False, False);
      Result.AddParam('X2', daInteger, nil, '', False, False);
      Result.AddParam('Y2', daInteger, nil, '', False, False);
      Result.AddParam('X3', daInteger, nil, '', False, False);
      Result.AddParam('Y3', daInteger, nil, '', False, False);
      Result.AddParam('X4', daInteger, nil, '', False, False);
      Result.AddParam('Y5', daInteger, nil, '', False, False);
    end
  else if ppEqual(aMethodName, 'Draw') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X', daInteger, nil, '', False, False);
      Result.AddParam('Y', daInteger, nil, '', False, False);
      Result.AddParam('aGraphic', daClass, TGraphic, '', False, False);
    end
  else if ppEqual(aMethodName, 'StretchDraw') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X', daInteger, nil, '', False, False);
      Result.AddParam('Y', daInteger, nil, '', False, False);
      Result.AddParam('Width', daInteger, nil, '', False, False);
      Result.AddParam('Height', daInteger, nil, '', False, False);
      Result.AddParam('aGraphic', daClass, TGraphic, '', False, False);
    end
  else if ppEqual(aMethodName, 'MoveTo') or
     ppEqual(aMethodName, 'LineTo') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X', daInteger, nil, '', False, False);
      Result.AddParam('Y', daInteger, nil, '', False, False);
    end
  else if ppEqual(aMethodName, 'Rectangle') or
     ppEqual(aMethodName, ' FrameRect') or
     ppEqual(aMethodName, 'FillRect') or
     ppEqual(aMethodName, 'Ellipse') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X1', daInteger, nil, '', False, False);
      Result.AddParam('Y1', daInteger, nil, '', False, False);
      Result.AddParam('X2', daInteger, nil, '', False, False);
      Result.AddParam('Y2', daInteger, nil, '', False, False);
    end
 else  if CompareText(aMethodName, 'TextOut') = 0 then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X', daInteger, nil, '', False, False);
      Result.AddParam('Y', daInteger, nil, '', False, False);
      Result.AddParam('Text', daString, nil, '', False, False);
    end
  else if CompareText(aMethodName, 'TextRect') = 0 then
    begin
      Result := TraParamList.Create;

      Result.AddParam('X', daInteger, nil, '', False, False);
      Result.AddParam('Y', daInteger, nil, '', False, False);
      Result.AddParam('Width', daInteger, nil, '', False, False);
      Result.AddParam('Height', daInteger, nil, '', False, False);
      Result.AddParam('Text', daString, nil, '', False, False);
    end
  else if ppEqual(aMethodName, 'TextHeight') or
          ppEqual(aMethodName, 'TextWidth') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Text', daString, nil, '', False, False);
      Result.AddParam('Result', daInteger, nil, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;


class function TraTCanvasRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lCanvas: TCanvas;
  liX: Integer;
  liY: Integer;
  liX2: Integer;
  liY2: Integer;
  liX3: Integer;
  liY3: Integer;
  liX4: Integer;
  liY4: Integer;
  liWidth: Integer;
  liHeight: Integer;
  lRect: TRect;
  lsText: String;
  lGraphic: TGraphic;
begin

  Result := True;

  lCanvas := TCanvas(aObject);

  if CompareText(aMethodName, 'Arc') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liX2);
      aParams.GetParamValue(3, liY2);
      aParams.GetParamValue(4, liX3);
      aParams.GetParamValue(5, liY3);
      aParams.GetParamValue(6, liX4);
      aParams.GetParamValue(7, liY4);

      lCanvas.Arc(liX, liY, liX2, liY2, liX3, liY3, liX4, liY4);

    end
  else if CompareText(aMethodName, 'Draw') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, lGraphic);

      lCanvas.Draw(liX, liY, lGraphic);

    end
  else if CompareText(aMethodName, 'StretchDraw') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liWidth);
      aParams.GetParamValue(3, liHeight);
      aParams.GetParamValue(4, lGraphic);

      lRect := Rect(liX, liY, liX + liWidth, liY + liHeight);

      lCanvas.StretchDraw(lRect, lGraphic);

    end
  else if CompareText(aMethodName, 'LineTo') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);

      lCanvas.LineTo(liX, liY);

    end
  else if CompareText(aMethodName, 'MoveTo') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);

      lCanvas.MoveTo(liX, liY);

    end
  else if CompareText(aMethodName, 'Ellipse') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liX2);
      aParams.GetParamValue(3, liY2);

      lRect := Rect(liX, liY, liX2, liY2);

      lCanvas.Ellipse(lRect);

    end
  else if CompareText(aMethodName, 'FrameRect') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liX2);
      aParams.GetParamValue(3, liY2);

      lRect := Rect(liX, liY, liX2, liY2);

      lCanvas.FrameRect(lRect);

    end
  else if CompareText(aMethodName, 'FillRect') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liX2);
      aParams.GetParamValue(3, liY2);

      lRect := Rect(liX, liY, liX2, liY2);

      lCanvas.FillRect(lRect);

    end
  else if CompareText(aMethodName, 'Rectangle') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liX2);
      aParams.GetParamValue(3, liY2);

      lCanvas.Rectangle(liX, liY, liX2, liY2);

    end
  else if CompareText(aMethodName, 'TextOut') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, lsText);

      lCanvas.TextOut(liX, liY, lsText);

    end
  else if CompareText(aMethodName, 'TextRect') = 0 then
    begin
      aParams.GetParamValue(0, liX);
      aParams.GetParamValue(1, liY);
      aParams.GetParamValue(2, liWidth);
      aParams.GetParamValue(3, liHeight);
      aParams.GetParamValue(4, lsText);

      lRect := Rect(liX, liY, liX + liWidth, liY + liHeight);

      lCanvas.TextRect(lRect, liX, liY, lsText);

    end
  else if CompareText(aMethodName, 'TextHeight') = 0 then
    begin
      aParams.GetParamValue(0, lsText);

      liHeight := lCanvas.TextHeight(lsText);

      aParams.SetParamValue(1, liHeight);

    end
  else if CompareText(aMethodName, 'TextWidth') = 0 then
    begin
      aParams.GetParamValue(0, lsText);

      liWidth := lCanvas.TextWidth(lsText);

      aParams.SetParamValue(1, liWidth);

    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;


class function TraTCanvasRTTI.RefClass: TClass;
begin
  Result := TCanvas;

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClass(TppPaintBox);

  // register RTTI for RAP
  raRegisterRTTI(TraTppPaintBoxRTTI);
  raRegisterRTTI(TraTCanvasRTTI);


finalization

  raUnRegisterRTTI(TraTppPaintBoxRTTI);
  raUnRegisterRTTI(TraTCanvasRTTI);

  ppUnRegisterComponent(TppPaintBox);
  UnRegisterClass(TppPaintBox);



end.
