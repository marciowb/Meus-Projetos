{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppRichTxDrwCmd;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Messages,
  SysUtils,
  Types,
  Classes,
  Forms,
  Graphics,
  Controls,
  ComCtrls,
  RichEdit,
  SyncObjs,

  ppTypes,
  ppClass,
  ppRTTI,
  ppUtils,
  ppCollectionBase,
  ppDevice,
  ppPrnDev,
  ppPrintr,
  ppViewr,
  ppCharacter,
  ppGraphicsDevice,
  ppDrwCmd;

type


  TppCustomRichEditClass = class of TCustomRichEdit;

  TppDrawRichTextLines = class;

  {@TppDrawRichText

     Contains the information necessary to draw rich text to any device.}

  {@TppDrawRichText.Color

    The value of the Color property of the richtext component which created the
    draw command.}

  {@TppDrawRichText.EndCharPos

    The last character in the richtext stream which should be rendered.}

  {@TppDrawRichText.RichTextStream

    The value of the RichText property of the richtext component which created
    the draw command.}

  {@TppDrawRichText.StartCharPos

    The first character in the richtext stream which should be rendered.}

  {@TppDrawRichText.Transparent

    The value of the Transparent property of the richtext component which
    created the draw command.}

  TppDrawRichText = class(TppDrawCommand)
    private
      FColor: TColor;
      FEndCharPos: Integer;
      FLeftMargin: Integer;
      FLines: TppDrawRichTextLines;
      FRichTextStream: TMemoryStream;
      FStartCharPos: Integer;
      FTransparent: Boolean;

      function CompareStreams(aStream1, aStream2: TMemoryStream): Boolean;
      function GetLines: TppDrawRichTextLines;
      procedure ReadRTFStream(Stream: TStream);
      procedure WriteRTFStream(Stream: TStream);

    protected
      function CreateDrawRichTextLines: TppDrawRichTextLines;
      procedure DefineProperties(Filer: TFiler); override;

    public

      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;
      function AsMetaFile: TMetaFile;

      procedure Assign(Source: TPersistent); override;
      function Draw(aDevice: TppDevice): Boolean; override;
      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;
      property Lines: TppDrawRichTextLines read GetLines;

    published
      property Color: TColor read FColor write FColor;
      property DataType default dtBlob;
      property EndCharPos: Integer read FEndCharPos write FEndCharPos;
      property LeftMargin: Integer read FLeftMargin write FLeftMargin;
      property RichTextStream: TMemoryStream read FRichTextStream write FRichTextStream stored False;
      property StartCharPos: Integer read FStartCharPos write FStartCharPos;
      property Transparent: Boolean read FTransparent write FTransparent default False;

  end; {class, TppDrawRichText}


   {TppDrawRichTextLine }
   TppDrawRichTextLine = class(TppDrawCommand)
   private
     FItems: TppDrawTextCollection;
   public
     constructor Create(Owner: TComponent); override;
     destructor Destroy; override;
     property Items: TppDrawTextCollection read FItems;
   end;


   {TppDrawRichTextLines }
   TppDrawRichTextLines = class(TppCollectionBase)
   private
     function GetItems(Index: Integer): TppDrawRichTextLine;
   public
     constructor Create; override;
     function Add: TppDrawRichTextLine; overload;
     function Add(aLine: TppDrawRichTextLine): Integer; overload;
     property Items[Index: Integer]: TppDrawRichTextLine read GetItems; default;
   end;



  {@TppRTFEngine}
  TppRTFEngine = class
    private
      class function CriticalSection: TCriticalSection;

      class procedure Lock;
      class procedure UnLock;
      class function CalcSingleLineHeight(aRichEdit: TCustomRichEdit; aDC: HDC; aCharRange: TCharRange; aDestRect: TRect): Integer;

    public
      class function ChangeBackgroundColor(aRichEdit: TCustomRichEdit; aNewColor: TColor; var aUseResult: Boolean): TColor;  
      class function CalcRangeHeight(aRichEdit: TCustomRichEdit; aDC: HDC; aCharRange: TCharRange; aDestRect: TRect): Integer;  
      class function CheckRangeFit(aRichEdit: TCustomRichEdit; aDC: HDC; aCharRange: TCharRange; aDestRect: TRect;
                                    var aLastFittedChar: Longint; var aHeightUsed: Longint): Boolean;  
      class function FormatRange(aRichEdit: TCustomRichEdit; aDC: HDC; aFormatDC: HDC; const aRect: TRect; aCharRange: TCharRange; aRender: Boolean): Integer;  
      class procedure DrawRichText(aRichEdit: TCustomRichEdit; aDC: HDC; aFormatDC: HDC; const aRect: TRect; aCharRange: TCharRange); 

 end; {class, TppRTFEngine}


  {@TppParaAttributes

    Descendends from Delphi's TParaAttributes class. Adds a TextAlignment
    property that can be used to fully justify paragraph text (in addition
    to the basic left, right, center options.

    See Also: TppCustomRichText.Paragraph property. Delphi help topic for
    TParaAttributes}

   {@TppParaAttributes.TextAlignment

    Controls the text alignment for a paragraph.

    <Table>
    Value	             Meaning
    ----------------   --------
    taLeftJustified	   Align text to the left side of the control
    taCentered	       Center text horizontally in the control
    taRightJustified	 Align text to the right side of the control
    taFullJustified	   Align the text to the left and right sides of the
                       control.
    </Table>}

  TppParaAttributes = class(TParaAttributes)
  private
    FRichEdit: TCustomRichEdit;

    function GetTextAlignment: TppTextAlignment;
    procedure InitializeStruct(var ParaFormat: TParaFormat);
    procedure SetTextAlignment(const Value: TppTextAlignment);

  public
    constructor Create(AOwner: TCustomRichEdit);
    procedure Assign(Source: TPersistent); override;

  public
    property TextAlignment: TppTextAlignment read GetTextAlignment write SetTextAlignment;
  end;

  {@TppRichEdit}
  TppRichEdit = class(TRichEdit)
    private
      class function CriticalSection: TCriticalSection;
      class procedure Lock;
      class procedure UnLock;

    protected
      procedure CreateParams(var Params: TCreateParams); override;
      procedure CreateWnd; override;
{$IFNDEF Unicode}
      function GetSelLength: Integer; override;
      function GetSelLengthInBytes: Integer; 
      function GetSelText: string; override;
{$ENDIF}
      procedure WndProc(var Message: TMessage); override;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      class procedure EnableAdvancedTypography(aValue: Boolean);

    end;  {class, TppRichEdit}

{$M+}
  {TppRichEditUtils
    provides work around for bug in protected text }
  TppRichEditUtils = class(TObject)
    published
      procedure ProtectChangeHandler(Sender: TObject; StartPos, EndPos: Integer; var AllowChange: Boolean);
  end;
{$M-}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@ppControls.TraTppCustomTextRTTI }
  TraTppDrawRichTextRTTI = class(TraTppComponentRTTI)
    public
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDrawRichTextRTTI}



  {rich text routines }
  function ppCreateRichEdit(aOwner: TComponent): TCustomRichEdit;
  function ppCreateRichEditOffScreen(aOwner: TComponent): TCustomRichEdit;
  function ppGetRichEditClass: TppCustomRichEditClass;
  function ppGetRichEditLines(aRichEdit: TCustomRichEdit): TStrings;
  function ppGetRichEditUtils: TppRichEditUtils;

  procedure ppRegisterRichEditClass(aRichEditClass: TppCustomRichEditClass);
  procedure ppUnRegisterRichEditClass(aRichEditClass: TppCustomRichEditClass);


implementation

uses
  ppMetaGraphics;

var
  uRichEditClass: TppCustomRichEditClass;
  uRichEditLibrary: THandle;
  uRichEditUtils: TppRichEditUtils;
  uCriticalSection: TCriticalSection;
  uAdvancedTypography: Boolean = True;


type

  {TppRichTextMetaFileValidator}
  TppRichTextMetaFileValidator = class
  private
    function IsValidMetaRecord(aPMetaRecord: Pointer): Boolean;
    procedure ProcessMetaFile(aMetaFile: TMetaFile);
  public
    class procedure Execute(aMetaFile: TMetaFile);

  end;

{******************************************************************************
 *
 ** T p p  D r a w  R i c h T e x t
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawRichText.Create }

constructor TppDrawRichText.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FRichTextStream := TMemoryStream.Create;
  FStartCharPos := -1;
  FEndCharPos   := -1;
  FTransparent  := False;

  {backward compatibility - default to 1/32 inch left margin}
  FLeftMargin :=  ppToMMThousandths(0.03125, utInches, pprtHorizontal, nil);

  DataType := dtBlob;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawRichText.Destroy }

destructor TppDrawRichText.Destroy;
begin
  FRichTextStream.Free;
  FLines.Free;

  inherited Destroy;
  
end; {destructor, Destroy}

function TppDrawRichText.CreateDrawRichTextLines: TppDrawRichTextLines;
var
  lMetaFile: TMetaFile;
  lDrawCommands: TList;
  lDrawRichTextLines: TppDrawRichTextLines;
  lDrawRichTextLine: TppDrawRichTextLine;
  liIndex: Integer;
  lDrawText: TppDrawText;
  liBottom: Integer;
begin

  lMetaFile := AsMetaFile;

  lDrawCommands := TList.Create;

  lDrawRichTextLines := TppDrawRichTextLines.Create;

  liBottom := -1;
  lDrawRichTextLine := nil;

  TppMetaFileToDrawCommandConverter.Convert(lMetaFile, lDrawCommands);

  for liIndex := 0 to lDrawCommands.Count-1 do
    begin
      if not(TppDrawCommand(lDrawCommands[liIndex]) is TppDrawText) then continue;

      lDrawText := TppDrawText(lDrawCommands[liIndex]);

      lDrawText.Top := lDrawText.Top + Self.Top;
      lDrawText.Left := lDrawText.Left + Self.Left;

      // add new line, if needed
      if (lDrawText.Top >= liBottom) then
        begin
          liBottom := lDrawText.Top + lDrawText.Height;
          lDrawRichTextLine := lDrawRichTextLines.Add;
          lDrawRichTextLine.Left := Self.Left;
          lDrawRichTextLine.Top := lDrawText.Top;
          lDrawRichTextLine.Width := Self.Width;
          lDrawRichTextLine.Height := lDrawText.Height;
        end;

      // add drawtext to line
      lDrawRichTextLine.Items.Add(lDrawText);

      if (lDrawText.Height > lDrawRichTextLine.Height) then
        lDrawRichTextLine.Height := lDrawText.Height;

    end;

  lMetaFile.Free;
  lDrawCommands.Free;

  Result := lDrawRichTextLines;



end;

function TppDrawRichText.AsMetaFile: TMetaFile;
var
  lMetaFile: TMetaFile;
  lMetaFileCanvas: TMetaFileCanvas;
  lCanvasRect: TRect;
  liControlWidth, liControlHeight: Integer;
  lCharRange: TCharRange;
  lPrinter: TppPrinter;
  lDC: HDC;
  lRichEdit: TCustomRichEdit;
  liXBorderOffset: Integer;
  liYBorderOffset: Integer;
  liSize: Integer;
  lRichEditLines: TStrings;
begin

  lRichEdit := ppCreateRichEdit(nil);

  if (FRichTextStream.Size > 0) then
    begin
      liSize := FRichTextStream.Size;
      TraRTTI.SetPropValue(lRichEdit, 'MaxLength', liSize);
    end;

  FRichTextStream.Position := 0;

  lRichEditLines := ppGetRichEditLines(lRichEdit);

  lRichEditLines.LoadFromStream(FRichTextStream);

  lCharRange.cpMin := FStartCharPos;
  lCharRange.cpMax := FEndCharPos;

  lPrinter := ppPrinter;

  liXBorderOffset := Round(Border.Weight * lPrinter.PixelsPerInch.X / 72);
  liYBorderOffset := Round(Border.Weight * lPrinter.PixelsPerInch.Y / 72);

  if (lPrinter <> nil) and (Page <> nil) then
    lPrinter.PrinterSetup := Page.PrinterSetup;

  if (lPrinter <> nil) and (lPrinter.DC <> 0) then
    lDC := lPrinter.DC
  else
    lDC := GetDC(0);

  liControlWidth  := Trunc(ppFromMMThousandths(Width, utPrinterPixels, pprtHorizontal, lPrinter));
  liControlHeight := Trunc(ppFromMMThousandths(Height, utPrinterPixels, pprtVertical, lPrinter));

  {create a metafile}
  lMetaFile := TMetaFile.Create;
  lMetaFile.Width  := liControlWidth;
  lMetaFile.Height := liControlHeight;

  lCanvasRect := Rect(0, 0, liControlWidth, liControlHeight);

  {note following this line, lMetaFile.Width & lMetaFile.Height will return 0}
  lMetaFileCanvas := TppMetaFileCanvas.CreateCanvas(lMetaFile, lDC);

  {draw background color}
  if Transparent or (FColor = clNone) then
    lMetaFileCanvas.Brush.Style := bsClear
  else
    begin
      lMetaFileCanvas.Brush.Style := bsSolid;
      lMetaFileCanvas.Brush.Color := FColor;
      lMetaFileCanvas.FillRect(lCanvasRect);
    end;

  if Border.Visible then
    begin
      if (bpTop in Border.BorderPositions) then
        lCanvasRect.Top := lCanvasRect.Top + liYBorderOffset;

      if (bpLeft in Border.BorderPositions) then
        lCanvasRect.Left := lCanvasRect.Left + liXBorderOffset;

      if (bpRight in Border.BorderPositions) then
        lCanvasRect.Right := lCanvasRect.Right - liXBorderOffset;

      if (bpBottom in Border.BorderPositions) then
        lCanvasRect.Bottom := lCanvasRect.Bottom - liYBorderOffset;
    end;

  if FLeftMargin > 0 then
    lCanvasRect.Left := lCanvasRect.Left + Trunc(ppFromMMThousandths(FLeftMargin, utPrinterPixels, pprtHorizontal, lPrinter));

  {draw the RichText to the metafile}
  TppRTFEngine.DrawRichText(lRichEdit, lMetaFileCanvas.Handle, lDC, lCanvasRect, lCharRange);

  lMetaFileCanvas.Free;

  if (lPrinter = nil) or (lPrinter.DC = 0) then
    ReleaseDC(0,lDC);

//     lMetaFile.SaveToFile('C:\Documents and Settings\nmoseley\desktop\TestRichText.wmf');
//      lMetaFile.Free;


  lRichEdit.Free;

  TppRichTextMetaFileValidator.Execute(lMetaFile);

  Result := lMetaFile;

end;


{@TppDrawRichText.Assign
 Transfers the value of properties added as a descendant of TppDrawCommand.}

procedure TppDrawRichText.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawRichText;

begin

  inherited Assign(Source);

  if not(Source is TppDrawRichText) then Exit;

  lDrawCommand := TppDrawRichText(Source);

  FColor        := lDrawCommand.Color;
  FEndCharPos   := lDrawCommand.EndCharPos;
  FColor        := lDrawCommand.Color;
  FStartCharPos := lDrawCommand.StartCharPos;
  FTransparent  := lDrawCommand.Transparent;
  FLeftMargin   := lDrawCommand.LeftMargin;

  lDrawCommand.RichTextStream.SaveToStream(FRichTextStream);


end; {procedure, Assign}


{ TppDrawRichText.Draw }

function TppDrawRichText.Draw(aDevice: TppDevice): Boolean;
var
  lMetaFile: TMetaFile;
  lCharRange: TCharRange;
  lPrinterDevice: TppPrinterDevice;
  lGraphicsDevice: TppGraphicsDevice;
  lPrinter: TppPrinter;
  lRichEdit: TCustomRichEdit;
  lSaveFont: TFont;
  liSize: Integer;
  lRichEditLines: TStrings;
  liXBorderOffset: Integer;
  liYBorderOffset: Integer;
  lClientRect: TRect;
begin

  Result := True;

  if (aDevice is TppPrinterDevice) then
    begin
      lRichEdit := ppCreateRichEdit(nil);

      if (FRichTextStream.Size > 0) then
        begin
          liSize := FRichTextStream.Size;
          TraRTTI.SetPropValue(lRichEdit, 'MaxLength', liSize);
        end;

      FRichTextStream.Position := 0;

      lRichEditLines := ppGetRichEditLines(lRichEdit);

      lRichEditLines.LoadFromStream(FRichTextStream);

      lCharRange.cpMin := FStartCharPos;
      lCharRange.cpMax := FEndCharPos;


      lPrinterDevice := TppPrinterDevice(aDevice);
      lPrinter := lPrinterDevice.Printer;

      liXBorderOffset := Round(Border.Weight * lPrinter.PixelsPerInch.X / 72);
      liYBorderOffset := Round(Border.Weight * lPrinter.PixelsPerInch.Y / 72);

      lSaveFont := TFont.Create;
      lSaveFont.Assign(lPrinter.Canvas.Font);

      lPrinterDevice.CalcDrawPosition(Self);

      lClientRect := DrawRect;

      if Border.Visible then
        begin
          if (bpTop in Border.BorderPositions) then
            lClientRect.Top := lClientRect.Top + liYBorderOffset;

          if (bpLeft in Border.BorderPositions) then
            lClientRect.Left := lClientRect.Left + liXBorderOffset;

          if (bpRight in Border.BorderPositions) then
            lClientRect.Right := lClientRect.Right - liXBorderOffset;

          if (bpBottom in Border.BorderPositions) then
            lClientRect.Bottom := lClientRect.Bottom - liYBorderOffset;
        end;

      if FLeftMargin > 0 then
        lClientRect.Left := lClientRect.Left + Trunc(ppFromMMThousandths(FLeftMargin, utPrinterPixels, pprtHorizontal, lPrinter));

      if Transparent then
        begin

          lMetaFile := AsMetaFile();

          lPrinter.Canvas.StretchDraw(lClientRect, lMetaFile);

          lMetaFile.Free;

        end

      else
        begin
          {draw background color}
          lPrinter.Canvas.CopyMode := cmSrcCopy;
          lPrinter.Canvas.Brush.Style := bsSolid;
          lPrinter.Canvas.Brush.Color := FColor;
          lPrinter.Canvas.FillRect(DrawRect);

          lPrinter.Canvas.CopyMode := cmSrcAnd;

          TppRTFEngine.DrawRichText(lRichEdit, lPrinter.DC, lPrinter.DC, lClientRect, lCharRange);

        end;

      // draw border
      if Border.Visible then
        lPrinterDevice.DrawBorder(Self, Rect(DrawLeft, DrawTop, DrawRight, DrawBottom));

      lPrinter.Canvas.Font.Assign(lSaveFont);

      lSaveFont.Free;

      lRichEdit.Free;

    end

  else if (aDevice is TppGraphicsDevice) then
    begin

      lGraphicsDevice := TppGraphicsDevice(aDevice);

      lGraphicsDevice.ScaleVertices(Self);

      // adjust by one pixel - solves issue with rendering the metafile via the stretch draw call
      DrawRight := DrawRight + 1;
      DrawBottom := DrawBottom + 1;

      // get the richtext as a metafile
      lMetaFile := AsMetaFile();

      // render metafile
      lGraphicsDevice.Canvas.StretchDraw(DrawRect, lMetaFile);

      // draw the border
      if Border.Visible then
        lGraphicsDevice.DrawBorder(Self, Rect(DrawLeft, DrawTop, DrawRight, DrawBottom));

//      lMetaFile.SaveToFile('C:\Documents and Settings\nmoseley\desktop\TestRichText.wmf');
      lMetaFile.Free;

    end
  else
    Result := False;



end; {function, Draw}


{ TppDrawRichText.EqualTo }

function TppDrawRichText.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
var
  lDrawRichText: TppDrawRichText;
begin

  Result := inherited EqualTo(aDrawCommand);

  if Result then
    begin

      lDrawRichText := TppDrawRichText(aDrawCommand);

      if (Color = lDrawRichText.Color) and (EndCharPos = lDrawRichText.EndCharPos) and
         (StartCharPos = lDrawRichText.StartCharPos) and (Transparent = lDrawRichText.Transparent) then
        begin
          Result := CompareStreams(RichTextStream, lDrawRichText.RichTextStream);
        end
      else
        Result := False;

    end;

end;

{ TppDrawRichText.CompareStreams }

function TppDrawRichText.CompareStreams(aStream1, aStream2: TMemoryStream): Boolean;
var
  liIndex: Integer;
  lTextLines1: TStringList;
  lTextLines2: TStringList;
begin

  if (aStream1.Size = aStream2.Size) then
    Result := True
  else
    Result := False;

  if Result then
    begin

      lTextLines1 := TStringList.Create;
      lTextLines2 := TStringList.Create;

      aStream1.Position := 0;
      lTextLines1.LoadFromStream(aStream1);

      aStream2.Position := 0;
      lTextLines2.LoadFromStream(aStream2);

      if (lTextLines1.Count = lTextLines2.Count) then
        begin

          liIndex := 0;

          while Result and (liIndex < lTextLines1.Count) do
            begin

              if (CompareStr(lTextLines1[liIndex], lTextLines2[liIndex]) <> 0) then
                Result := False;

              Inc(liIndex);

            end;

        end;

      lTextLines1.Free;
      lTextLines2.Free;

    end;

end;

{------------------------------------------------------------------------------}
{ TppDrawRichText.DefineProperties }

procedure TppDrawRichText.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  Filer.DefineBinaryProperty('RTFStream', ReadRTFStream, WriteRTFStream, True)

end; {procedure, DefineProperties}

function TppDrawRichText.GetLines: TppDrawRichTextLines;
begin
  if FLines = nil then
    FLines := CreateDrawRichTextLines;

  Result := FLines;
end;

{------------------------------------------------------------------------------}
{ TppDrawRichText.ReadRTFStream }

procedure TppDrawRichText.ReadRTFStream(Stream: TStream);
var
  llSize: Longint;
begin

  Stream.Read(llSize, SizeOf(Longint));
  FRichTextStream.CopyFrom(Stream, llSize);

end; {procedure, ReadRTFStream}

{------------------------------------------------------------------------------}
{ TppDrawRichText.WriteRTFStream }

procedure TppDrawRichText.WriteRTFStream(Stream: TStream);
var
  llSize: Longint;
begin

  llSize := FRichTextStream.Size;

  Stream.Write(llSize, SizeOf(Longint));

  {note: specify 0 as second parameter to copy the entire stream}
  Stream.CopyFrom(FRichTextStream, 0);

end; {procedure, WriteRTFStream}


{******************************************************************************
 *
 ** R T F  E N G I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRTFEngine.CriticalSection }

class function TppRTFEngine.CriticalSection: TCriticalSection;
begin
  if (uCriticalSection = nil) then
    uCriticalSection := TCriticalSection.Create;

  Result := uCriticalSection;

end;

{------------------------------------------------------------------------------}
{ TppRTFEngine.Lock }

class procedure TppRTFEngine.Lock;
begin
  TppRTFEngine.CriticalSection.Acquire;

end; {class function, Lock}

{------------------------------------------------------------------------------}
{ TppRTFEngine.UnLock }

class procedure TppRTFEngine.UnLock;
begin
  TppRTFEngine.CriticalSection.Release;

end; {class function, UnLock}

{------------------------------------------------------------------------------}
{ TppRTFEngine.DrawRichText}

class procedure TppRTFEngine.DrawRichText(aRichEdit: TCustomRichEdit; aDC: HDC; aFormatDC: HDC; const aRect: TRect; aCharRange: TCharRange);
begin

  FormatRange(aRichEdit, aDC, aFormatDC, aRect, aCharRange, True);

end; {procedure, DrawRichText}

{------------------------------------------------------------------------------}
{ TppRTFEngine.FormatRange}

class function TppRTFEngine.FormatRange(aRichEdit: TCustomRichEdit; aDC: HDC; aFormatDC: HDC; const aRect: TRect; aCharRange: TCharRange;
                                 aRender: Boolean): Integer;
var
  lFormatRange: TFormatRange;
  liSaveMapMode: Integer;
  liPixelsPerInchX: Integer;
  liPixelsPerInchY: Integer;
  liRender: Integer;

begin

  Lock;

  try

    lFormatRange.hdc       := aDC;
    lFormatRange.hdcTarget := aFormatDC;

    {convert destination rect to TWIPS}
    liPixelsPerInchX := GetDeviceCaps(aDC, LOGPIXELSX);
    liPixelsPerInchY := GetDeviceCaps(aDC, LOGPIXELSY);

    lFormatRange.rc.left   := (aRect.Left * 1440 div liPixelsPerInchX);
    lFormatRange.rc.right  := aRect.Right  * 1440 div liPixelsPerInchX;
    lFormatRange.rc.top    := aRect.Top    * 1440 div liPixelsPerInchY;
    lFormatRange.rc.bottom := aRect.Bottom * 1440 div liPixelsPerInchY;

    lFormatRange.rcPage := lFormatRange.rc;

    lFormatRange.chrg.cpMin := aCharRange.cpMin;
    lFormatRange.chrg.cpMax := aCharRange.cpMax;

    if aRender then
      liRender := 1
    else
      liRender := 0;

    liSaveMapMode := SetMapMode(lFormatRange.hdc, MM_TEXT);

    aRichEdit.Perform(EM_FORMATRANGE, 0, 0);   { flush buffer}

    try
      Result := aRichEdit.Perform(EM_FORMATRANGE, liRender, Longint(@lFormatRange));

    finally
      aRichEdit.Perform(EM_FORMATRANGE, 0, 0);

      SetMapMode(lFormatRange.hdc, liSaveMapMode);   { restore previous map mode}

    end;

  finally
    UnLock;

  end;

end; {procedure, FormatRange}

{------------------------------------------------------------------------------}
{ TppRTFEngine.CheckRangeFit}

class function TppRTFEngine.CheckRangeFit(aRichEdit: TCustomRichEdit; aDC: HDC; aCharRange: TCharRange; aDestRect: TRect;
                                    var aLastFittedChar: Longint; var aHeightUsed: Longint): Boolean;
begin

  Lock;

  try

    {calc whether the range fits into the destination rectangle }
    aLastFittedChar := FormatRange(aRichEdit, aDC, aDC, aDestRect, aCharRange, False);

    {range fits if the LastFitted char includes the last char in the range }
    Result := (aLastFittedChar >= aCharRange.cpMax);

    if Result then

        {range fits, so calc height used by the range}
        aHeightUsed := CalcRangeHeight(aRichEdit, aDC, aCharRange, aDestRect)
    else
      begin
        {format range returns the last char that fits plus one}
        Dec(aLastFittedChar);

        {range does not fit, so height used is the height of the rectangle}
        aHeightUsed := aDestRect.Bottom - aDestRect.Top;
      end;


    {if range does not fit, check whether the text is just a carriage return + line feed
        note: for some reason CheckRangeFit will always return a false result}
    if not Result then
      begin

        aRichEdit.SelStart  := aLastFittedChar;
        aRichEdit.SelLength := aCharRange.cpMax;

        if (aRichEdit.SelText =#13#10) or (aRichEdit.SelText = #10) or
           (aRichEdit.SelText = #13)  then
          Result := True;

      end;

  finally
    UnLock;

  end;


end; {function, CheckRangeFit}

{------------------------------------------------------------------------------}
{ TppRTFEngine.ChangeBackgroundColor

  Changes the currently selected text in the rich edit control to a new
  background color. The result is the previous background color that was
  changed.  This is used to support highlighting of text in a text search of a
  rich text draw command on the screen device's page.}


class function TppRTFEngine.ChangeBackgroundColor(aRichEdit: TCustomRichEdit; aNewColor: TColor; var aUseResult: Boolean): TColor;
var
  liSize: Integer;
  lGetFormat: TCharFormat2;
  lSetFormat: TCharFormat2;
  lColor: TColor;
begin

  aUseResult := True;

  Lock;

  liSize := SizeOf(TCharFormat2);

  FillChar(lGetFormat, liSize, 0);
  lGetFormat.cbSize := liSize;
  lGetFormat.dwMask := CFM_BackColor;
  aRichEdit.Perform(EM_GetCharFormat, SCF_Selection, lParam(@lGetFormat));
  Result := lGetFormat.crBackColor;

  {color comes back black when it may be black or white}
  if (Result = 0) then
    begin

      lColor := ColorToRGB(aRichEdit.SelAttributes.Color);

      {the background most likely is not white}
      if (lColor = clWhite) then
        Result := clBlack

      {the background most likely is not black}
      else if (lColor = clBlack) then
        Result := clWhite

      else
        begin
          Result := clWhite;

          aUseResult := False;
        end;

    end;

  FillChar(lSetFormat, liSize, 0);
  lSetFormat.cbSize := liSize;
  lSetFormat.dwMask := CFM_BackColor;

  try
    lSetFormat.crBackColor := ColorToRGB(aNewColor);
  except
    on E: ERangeError do
      begin
        lSetFormat.crBackColor := Result;
      end;
  end;

  aRichEdit.Perform(EM_SetCharFormat, SCF_Selection, LongInt(@lSetFormat));

  UnLock;

end; {procedure, ChangeBackgroundColor}

{------------------------------------------------------------------------------}
{ TppRTFEngine.CalcRangeHeight}

class function TppRTFEngine.CalcRangeHeight(aRichEdit: TCustomRichEdit; aDC: HDC; aCharRange: TCharRange; aDestRect: TRect): Integer;
var
  lPrintRect: TRect;
  liMinHeight: Integer;
  liMaxHeight: Integer;
  liRangeHeight: Integer;
  lbRangeFits: Boolean;
  lbCalcDone: Boolean;
  liPixelsPerInchY: Integer;
  liTolerance: Integer;
  lFont: TFont;
  lTextMetric: TTextMetric;
  liSaveSelStart: Integer;
  liSaveSelLength: Integer;
  lsSelText: String;
  liLastChar: Integer;
  
begin

  Lock;

  try

    {intitialize}
    lPrintRect.Left   := aDestRect.Left;
    lPrintRect.Top    := aDestRect.Top;
    lPrintRect.Right  := aDestRect.Right;

    liPixelsPerInchY := GetDeviceCaps(aDC, LOGPIXELSY);

    {save selected text}
    liSaveSelStart  := aRichEdit.SelStart;
    liSaveSelLength := aRichEdit.SelLength;

    {calculate the sizing tolerance based upon the font height of the last character in the range}

    {find the last non-null character in the range}
    aRichEdit.SelStart  := aCharRange.cpMin;
    aRichEdit.SelLength := aCharRange.cpMax - aCharRange.cpMin + 1;

    lsSelText  := aRichEdit.SelText;
    liLastChar := Length(lsSelText);

    if (lsSelText <> '') then
      while (liLastChar > 0) and ppCharInSet(lsSelText[liLastChar], [#13, #10, #0]) do
        Dec(liLastChar);

    {sel start is 0 based, liLastChar is 1 based}
    if liLastChar > 0 then
      liLastChar := aCharRange.cpMin + liLastChar -1;

    aRichEdit.SelStart    := liLastChar;
    aRichEdit.SelLength   := 1;

    if ppPrinter <> nil then
      begin
        lFont := TFont.Create;
        lFont.Assign(aRichEdit.SelAttributes);
        ppPrinter.Canvas.Font := lFont;
        GetTextMetrics(ppPrinter.Canvas.Handle, lTextMetric);
        lFont.Free;
     end
    else
      lTextMetric.tmDescent := 0;

    liTolerance := Round(Abs(aRichEdit.SelAttributes.Size) * liPixelsPerInchY / 72);

    {restore selected text}
    aRichEdit.SelStart := liSaveSelStart;
    aRichEdit.SelLength := liSaveSelLength;

    liMinHeight   := 0;
    liMaxHeight   := aDestRect.Bottom - aDestRect.Top;
    liRangeHeight := liMaxHeight;
    lbRangeFits   := True;
    lbCalcDone    := False;

    {liCount := 0;}

    while not lbCalcDone do
      begin

        {try the halfway point }
        liRangeHeight := liMinHeight + ((liMaxHeight - liMinHeight) div 2);

        lPrintRect.Bottom := lPrintRect.Top + liRangeHeight;

        lbRangeFits := (FormatRange(aRichEdit, aDC, aDC, lPrintRect, aCharRange, False) >= aCharRange.cpMax);

        {calc a new Max or Min based on whether the range fits}
        if ((liMaxHeight - liMinHeight) <= liTolerance) then

          lbCalcDone := True

        else if lbRangeFits then
          liMaxHeight := liRangeHeight
        else
          liMinHeight := liRangeHeight;

      {  inc(liCount);
        if liCount > 50 then
          ShowMessage('CalcRangeHeight: stuck in loop'); }
      end;

      {showMessage('FormatRange calls: ' + IntToStr(liCount));}
     if lbRangeFits then
       Result := liRangeHeight
     else
       Result := liMaxHeight;

     {make sure the text is at least one line high
       note: this is because of a bug in the rich edit control }
     if Result <= liTolerance then
       Result := CalcSingleLineHeight(aRichEdit, aDC, aCharRange, aDestRect)
     else
       Result := Result + lTextMetric.tmDescent;

  finally
    UnLock;

  end;

end; {function, CalcRangeHeight}


{------------------------------------------------------------------------------}
{ TppRTFEngine.CalcSingleLineHeight}

class function TppRTFEngine.CalcSingleLineHeight(aRichEdit: TCustomRichEdit; aDC: HDC; aCharRange: TCharRange; aDestRect: TRect): Integer;
var
  lFont: TFont;
  liIndex: Integer;
  liMaxFontSize: Integer;
  liPixelsPerInchY: Integer;
  liSaveSelStart: Integer;
  liSaveSelLength: Integer;
  lTextMetric: TTextMetric;
begin

  Lock;

  lFont := TFont.Create;

  liPixelsPerInchY := GetDeviceCaps(aDC, LOGPIXELSY);

  {save selected text}
  liSaveSelStart  := aRichEdit.SelStart;
  liSaveSelLength := aRichEdit.SelLength;

  liMaxFontSize := 0;

  try

    {calculate the sizing tolerance based upon the font height of the last
     character in the range}
    for liIndex := aCharRange.cpMin to aCharRange.cpMax do
      begin
        aRichEdit.SelStart  := liIndex;
        aRichEdit.SelLength := 1;

        if (aRichEdit.SelAttributes.Size > liMaxFontSize) then
          begin
            liMaxFontSize := aRichEdit.SelAttributes.Size;

            if (ppPrinter <> nil) then
              begin
                lFont.Assign(aRichEdit.SelAttributes);
                ppPrinter.Canvas.Font := lFont;
                GetTextMetrics(ppPrinter.Canvas.Handle, lTextMetric);
             end
            else
              lTextMetric.tmDescent := 0;

          end;

      end;

    Result := Round(Abs(liMaxFontSize) * liPixelsPerInchY / 72) + lTextMetric.tmDescent;

  finally
  
    {restore selected text}
    aRichEdit.SelStart := liSaveSelStart;
    aRichEdit.SelLength := liSaveSelLength;

    lFont.Free;

    UnLock;

  end;

end; {function, CalcSingleLineHeight}


{******************************************************************************
 *
 ** R I C H E D I T
 *
{******************************************************************************}

const
  EM_SETTYPOGRAPHYOPTIONS  = WM_USER + 202;
  TO_ADVANCEDTYPOGRAPHY = $1;
  TO_SIMPLELINEBREAK = $2;
  PFA_JUSTIFY         = $0004;
  PFA_FULL_INTERWORD  = $0005;

{ TRichEdit }

constructor TppRichEdit.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

end;

destructor TppRichEdit.Destroy;
begin


  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppRichEdit.CriticalSection }

class function TppRichEdit.CriticalSection: TCriticalSection;
begin
  if (uCriticalSection = nil) then
    uCriticalSection := TCriticalSection.Create;

  Result := uCriticalSection;

end;

{------------------------------------------------------------------------------}
{ TppRTFEngine.Lock }

class procedure TppRichEdit.Lock;
begin
  TppRichEdit.CriticalSection.Acquire;

end; {class function, Lock}

{------------------------------------------------------------------------------}
{ TppRTFEngine.UnLock }

class procedure TppRichEdit.UnLock;
begin
  TppRichEdit.CriticalSection.Release;

end; {class function, UnLock}

{------------------------------------------------------------------------------}
{ TppRichEdit.CreateParams }

procedure TppRichEdit.CreateParams(var Params: TCreateParams);
const
  cHideScrollBars: array[Boolean] of DWORD = (ES_DISABLENOSCROLL, 0);
  cHideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
begin

  Lock;

  try

    {try to load the RichEdit 2 dll}
    if uRichEditLibrary = 0 then
      begin
        uRichEditLibrary := LoadLibrary('RICHED20.DLL');
        if uRichEditLibrary <= HINSTANCE_ERROR then
          uRichEditLibrary := 0;
      end;

    {call inherited - which will load the RichEdit version 1 libary (RichED32.DLL)}
    inherited CreateParams(Params);

    {create the appropriate windows subclass for the rich edit library}
    if uRichEditLibrary <> 0 then
      CreateSubClass(Params, RICHEDIT_CLASS)

    else
      CreateSubClass(Params, 'RICHEDIT');

    Params.Style := Params.Style or (WS_CLIPCHILDREN or WS_CLIPSIBLINGS);

    Params.Style := Params.Style or cHideScrollBars[HideScrollBars] or cHideSelections[HideSelection];

    if (Parent = nil) then
      Params.Style := Params.Style and not(WS_CHILD);

    if WordWrap then
      Params.Style := Params.Style and not WS_HSCROLL;

    Params.WindowClass.Style := Params.WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);

  finally
    UnLock;

  end;

end; {procedure, CreateParams}

procedure TppRichEdit.CreateWnd;
begin

  Lock;

  try
  
    inherited;

  // set to support full justified rtf
  if uAdvancedTypography then
    begin
      Windows.SendMessage(Handle, EM_SETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY);
    end;

  finally
    UnLock;

  end;

end;

{------------------------------------------------------------------------------}
{ TppRichEdit.EnableAdvancedTypography }

class procedure TppRichEdit.EnableAdvancedTypography(aValue: Boolean);
begin

  // set to support full justified rtf
  uAdvancedTypography := aValue;

end;

{$IFNDEF Unicode}

function TppRichEdit.GetSelLength: Integer;
var
  lTextLen: TGetTextLengthEx;
begin

  lTextLen.CodePage := CP_ACP;  // Active ANSI code page
  Result := SendMessage(Self.Handle, EM_GETTEXTLENGTHEX, LPARAM(@lTextLen), 0);

end;

function TppRichEdit.GetSelLengthInBytes: Integer;
var
  lTextLen: TGetTextLengthEx;
begin

  lTextLen.flags := GTL_NUMBYTES;  // get length in bytes
  lTextLen.CodePage := CP_ACP;  // Active ANSI code page
  Result := SendMessage(Self.Handle, EM_GETTEXTLENGTHEX, LPARAM(@lTextLen), 0);

end;

function TppRichEdit.GetSelText: string;
const
  GT_SELECTION = 2;
var
  lGetTextEx: TGetTextEx;
  liLength: Integer;
  liByteLength: Integer;
  lsResult: String;
begin
  //liLength := GetSelLength + 1;

  liByteLength := GetSelLengthInBytes;

  SetLength(lsResult, liByteLength);
  lGetTextEx.cb := liByteLength; // Size is in bytes, not chars
  lGetTextEx.Flags := GT_SELECTION; // Get selected text
  lGetTextEx.codepage := CP_ACP;  // Active ANSI code page
  lGetTextEx.lpDefaultChar := nil;
  lGetTextEx.lpUsedDefChar := nil;

  liLength := SendMessage(Self.Handle, EM_GETTEXTEX,  Windows.WPARAM(@lGetTextEx), Windows.LPARAM(PChar(lsResult)));
  SetLength(lsResult, liLength);

  Result := lsResult;

end;

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppRichEdit.WndProc }

procedure TppRichEdit.WndProc(var Message: TMessage);
const FR_DOWN = $00000001;

begin
  {RichEdit 2.0 support additional search options not available in RichEdit 1.0,
   FR_DOWN indicates to search from current selection to bottom of document}
  if (Message.Msg = EM_FINDTEXT) then
     Message.wParam:= Message.wParam or FR_DOWN;

  inherited WndProc(Message);

end; {procedure, WndProc}


{******************************************************************************
 *
 ** R I C H E D I T  U T I L S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRichEditUtils.ProtectChangeHandler }

procedure TppRichEditUtils.ProtectChangeHandler(Sender: TObject; StartPos, EndPos: Integer; var AllowChange: Boolean);
begin
  {workaround for bug in RichEdit protected text}
  AllowChange := True;
end;


{******************************************************************************
 *
 ** F U N C T I O N S
 *
{******************************************************************************}
{------------------------------------------------------------------------------}
{ ppRegisterRichEditClass }


procedure ppRegisterRichEditClass(aRichEditClass: TppCustomRichEditClass);
begin

  uRichEditClass := aRichEditClass;

end; {function, ppRegisterRichEditClass}


{------------------------------------------------------------------------------}
{ ppUnRegisterRichEditClass }

procedure ppUnRegisterRichEditClass(aRichEditClass: TppCustomRichEditClass);
begin
  if (uRichEditClass = aRichEditClass) then
    uRichEditClass := TRichEdit;

end; {function, ppRegisterRichEditClass}


{------------------------------------------------------------------------------}
{ ppRegisterRichEditClass }

function ppGetRichEditClass: TppCustomRichEditClass;
begin

  if uRichEditClass = nil then
    uRichEditClass := TppRichEdit;

  Result := uRichEditClass;

end; {function, ppRegisterRichEditClass}

{------------------------------------------------------------------------------}
{ ppCreateRichEdit }

function ppCreateRichEdit(aOwner: TComponent): TCustomRichEdit;
begin

  Result := ppGetRichEditClass.Create(aOwner);
  ppSetMethodPropValue(Result, 'OnProtectChange', ppFindMethod(ppGetRichEditUtils, 'ProtectChangeHandler'));

end; {function, ppCreateRichEdit}

{------------------------------------------------------------------------------}
{ ppCreateRichEditOffScreen }

function ppCreateRichEditOffScreen(aOwner: TComponent): TCustomRichEdit;
begin
  Result := ppCreateRichEdit(aOwner);
  Result.Visible := False;
  Result.Parent := nil;
  Result.Top := -1500;
  Result.Left := -1500;
end; {function, ppCreateRichEditOffScreen}

{------------------------------------------------------------------------------}
{ ppGetRichEditUtils }

function ppGetRichEditUtils: TppRichEditUtils;
begin

  if (uRichEditUtils = nil) then
    uRichEditUtils := TppRichEditUtils.Create;

  Result := uRichEditUtils;

end; {function, ppGetRichEditUtils}

{------------------------------------------------------------------------------}
{ ppGetRichEditLines }

function ppGetRichEditLines(aRichEdit: TCustomRichEdit): TStrings;
var
  lObject: TObject;
begin
  TraRTTI.GetPropValue(aRichEdit, 'Lines', lObject);
  Result := TStrings(lObject);

end; {function, ppGetRichEditLines}

{******************************************************************************
 *
 ** DrawRichText R T T I
 *
{******************************************************************************}

class function TraTppDrawRichTextRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin
  Result := True;

  if (CompareText(aPropName, 'Color') = 0) then
    EnumPropToRec(aPropName, 'TColor', False, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

class function TraTppDrawRichTextRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin
  Result := True;

  if (CompareText(aPropName, 'Color') = 0) then
    Integer(aValue) := Ord(TppDrawRichText(aObject).Color)
  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end;

class function TraTppDrawRichTextRTTI.RefClass: TClass;
begin
  Result := TppDrawRichText;

end;

class function TraTppDrawRichTextRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin
  Result := True;

  if (CompareText(aPropName, 'Color') = 0) then
    TppDrawRichText(aObject).Color := TColor(aValue)
  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end;

{ TppParaAttributes }

constructor TppParaAttributes.Create(AOwner: TCustomRichEdit);
begin
  inherited Create(aOwner);
  FRichEdit := AOwner;
end;

procedure TppParaAttributes.Assign(Source: TPersistent);
begin

  if Source is TppParaAttributes then
    begin
     inherited Assign(Source);
      TextAlignment := TppParaAttributes(Source).TextAlignment;
    end
  else
    inherited Assign(Source);

end;

function TppParaAttributes.GetTextAlignment: TppTextAlignment;
var
  lParaFormat: TParaFormat;
begin
  InitializeStruct(lParaFormat);

  FRichEdit.HandleNeeded;

  if FRichEdit.HandleAllocated then
    SendMessage(FRichEdit.Handle, EM_GETPARAFORMAT, 0, LPARAM(@lParaFormat));

  Result :=  TppTextAlignment(lParaFormat.wAlignment - 1);

end;

procedure TppParaAttributes.InitializeStruct(var ParaFormat: TParaFormat);
begin
  FillChar(ParaFormat, SizeOf(TParaFormat), 0);
  ParaFormat.cbSize := SizeOf(TParaFormat);
end;

procedure TppParaAttributes.SetTextAlignment(const Value: TppTextAlignment);
var
  lParaFormat: TParaFormat;
begin

  if Value = taFullJustified then
    begin
      InitializeStruct(lParaFormat);

      // set to struct values
      lParaFormat.dwMask := PFM_ALIGNMENT;
      lParaFormat.wAlignment := Ord(Value) + 1;

      FRichEdit.HandleNeeded;
      
      if FRichEdit.HandleAllocated then
        SendMessage(FRichEdit.Handle, EM_SETPARAFORMAT, 0, LPARAM(@lParaFormat));
    end
  else
    Alignment := TAlignment(Value);

end;

class procedure TppRichTextMetaFileValidator.Execute(aMetaFile: TMetaFile);
var
  lMetaFileValidator: TppRichTextMetaFileValidator;
begin
  lMetaFileValidator := TppRichTextMetaFileValidator.Create;

  lMetaFileValidator.ProcessMetaFile(aMetaFile);

  lMetaFileValidator.Free;
end;


function cbReadMetaFunc(aDC: HDC; apHTable: PHANDLETABLE; apEMFR: PENHMETARECORD; aObjCount: Integer; aMetaFileReader: TppRichTextMetaFileValidator): Integer; stdcall;
var
  lbResult: Boolean;
begin

  if aMetaFileReader.IsValidMetaRecord(apEMFR) then
    lbResult := PlayEnhMetaFileRecord(aDC, apHTable^, apEMFR^, aObjCount)
  else
    lbResult := True;

  Result := Ord(lbResult);

end;

procedure TppRichTextMetaFileValidator.ProcessMetaFile(aMetaFile: TMetaFile);
var
  lNewMetaFile: TMetaFile;
  lMetaFileCanvas: TMetaFileCanvas;
//  lBitmap: TBitmap;
  lClipRect: TRect;
begin

  lClipRect := Rect(0, 0, aMetaFile.Width, aMetaFile.Height);

  lNewMetaFile := TMetaFile.Create;
  lNewMetaFile.Width := aMetaFile.Width;
  lNewMetaFile.Height := aMetaFile.Height;

  lMetaFileCanvas := TMetaFileCanvas.Create(lNewMetaFile, ppPrinter.DC);

  EnumEnhMetaFile(lMetaFileCanvas.Handle, aMetaFile.Handle, @cbReadMetaFunc, self, lClipRect );

  lMetaFileCanvas.Free;

  // use for testing
//  lBitmap := TBitmap.Create;
//  lBitmap.Width := aMetaFile.Width;
//  lBitmap.Height := aMetaFile.Height;

//  lBitmap.Canvas.Brush.Color := clWhite;
//  lBitmap.Canvas.Brush.Style := bsSolid;
//  lBitmap.Canvas.FillRect(lClipRect);
//  lBitmap.Canvas.Draw(0, 0, lNewMetaFile);

  aMetaFile.Assign(lNewMetaFile);

//  lNewMetaFile.SaveToFile(TppFileUtils.GetApplicationFilePath + 'Edited.emf');

  lNewMetaFile.Free;

//  lBitmap.SaveToFile(TppFileUtils.GetApplicationFilePath + 'Edited.bmp');
//  lBitmap.Free;

end;

function TppRichTextMetaFileValidator.IsValidMetaRecord(aPMetaRecord: Pointer): Boolean;
var
 liEMRType: Cardinal;
begin

  Result := True;

  liEMRType := PENHMETARECORD(aPMetaRecord)^.iType;

  case liEMRType of

    EMR_HEADER:
      Result := False;   // ommit header

    EMR_EOF:
      Result := False; // ommit eof

    EMR_EXTTEXTOUTW, EMR_EXTTEXTOUTA: // ommit empty opaque text
      if (PEMREXTTEXTOUT(aPMetaRecord)^.emrtext.nChars = 0) and
         ((PEMREXTTEXTOUT(aPMetaRecord)^.emrtext.fOptions and ETO_OPAQUE) > 0) then
        Result := False; // ommit empty opaque text

  end;

end;

constructor TppDrawRichTextLines.Create;
begin
  inherited;
  InnerList.OwnsObjects := True;
end;

function TppDrawRichTextLines.Add: TppDrawRichTextLine;
begin
  Result := TppDrawRichTextLine.Create(nil);
  Add(Result);
end;

function TppDrawRichTextLines.Add(aLine: TppDrawRichTextLine): Integer;
begin
  Result := InnerList.Add(aLine);
end;

function TppDrawRichTextLines.GetItems(Index: Integer): TppDrawRichTextLine;
begin
  Result := TppDrawRichTextLine(InnerList[Index]);
end;

constructor TppDrawRichTextLine.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FItems := TppDrawTextOwnedCollection.Create;

end;

destructor TppDrawRichTextLine.Destroy;
begin
  inherited;
  FItems.Free;
  FItems := nil;
end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization
  RegisterClasses([TppDrawRichText]);

  ppRegisterRichEditClass(TppRichEdit);

  raRegisterRTTI(TraTppDrawRichTextRTTI);

finalization

  if uRichEditLibrary <> 0 then
    FreeLibrary(uRichEditLibrary);

  uRichEditUtils.Free;
  uRichEditUtils := nil;

  uCriticalSection.Free;
  uCriticalSection := nil;

  UnRegisterClasses([TppDrawRichText]);

  raUnRegisterRTTI(TraTppDrawRichTextRTTI);


end.
