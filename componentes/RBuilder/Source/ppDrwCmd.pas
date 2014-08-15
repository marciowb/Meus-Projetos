{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDrwCmd;

interface

{$I ppIfDef.pas}

{.$Define QA}
{.$Define CodeSite}

uses
  {$IFDEF CodeSite} csIntf, {$ENDIF}
  Windows,
  Classes,
  Graphics,
  ExtCtrls,
  SysUtils,
  Variants,
  Forms,
  Controls,
  Messages,

  ppTypes,
  ppUtils,
  ppPrintr,
  ppCollectionBase,
  ppComm,
  ppDevice,
  ppRTTI;


type

                                          
  {@TppDrawText

    A pointer to the component which generated this draw command.}

  {@TppDrawText.Alignment

    The value of the component's Alignment property at the time the component
    was generated.}

  {@TppDrawText.Angle

    The value of the component's Angle property at the time the component
    was generated.}

  {@TppDrawText.AutoSize

    The value of the component's AutoSize property at the time the component was
    generated.}

  {@TppDrawText.BandSave

    The value of the band's Save property at the time the component was
    generated.}

  {@TppDrawText.BandSaveNo

    The value of the ReportBandCount property at the time the component was
    generated.}

  {@TppDrawText.ReportSaveNo

    The value of the TppSubreport.Count property at the time the component was
    generated.  This property is 0 if the component is in the main report.}

  {@TppDrawText.ColumnSaveNo

    Used when exporting crosstabs to text.  Represents the crosstab column
    number at the time the component is generated.  This property defaults to 0
    if the component is not part of a crosstab.}

  {@TppDrawText.RowSaveNo

    Used when exporting crosstabs to text.  Represents the crosstab row
    number at the time the component is generated.  This property defaults to 0
    if the component is not part of a crosstab.}

  {@TppDrawText.Color

    The value of the component's Color property at the time the component was
    generated.}

  {@TppDrawText.Component

    A pointer to the component which generated this draw command.}

  {@TppDrawText.ComponentSave

    The value of the component's Save property at the time the component was
    generated.}

  {@TppDrawText.ComponentSaveNo

    The value of the component's SaveNo property at the time the component was
    generated.}

  {@TppDrawText.Font

    The value of the component's Font property at the time the component was
    generated.}

  {@TppDrawText.IsMemo

    Whether or not the command was created by a memo component.}

  {@TppDrawText.Leading

    The value of the component's Leading property at the time the component was
    generated (memo component's only.)}

  {@TppDrawText.Order

    The value of the BandSaveNo and ComponentSaveNo properties formatted and
    concatenated together. This property is used by the TextFileDevice to sort
    the drawtext commands.}

  {@TppDrawText.SaveLength

    The value of the component's SaveLength property at the time the component
    was generated.}

  {@TppDrawText.TabStopPositions

    The value of the component's TabStopPositions property at the time the
    component was generated (memo components only.)}

  {@TppDrawText.Text

    The value of the component's Text property at the time the component was generated
    (non-memo component's only.)}

  {@TppDrawText.Transparent

    The value of the component's Transparent property at the time the component
    was generated.}

  {@TppDrawText.WordWrap

    The value of the component's WordWrap property at the time the component was
    generated.}

  {@TppDrawText.WrappedText

    When the component is a memo, or has been word-wrapped, the lines of text
    which should be rendered by the device.}

  TppDrawText = class(TppDrawCommand)
    private
      FAlignment: TAlignment;
      FAngle: Integer;
      FAutoSize: Boolean;
      FColor: TColor;
      FFont: TFont;
      FHyperlink: string;
      FIsMemo: Boolean;
      FLeading: Integer;
      FRotatedOrigin: TPoint;
      FText: String;
      FTransparent: Boolean;
      FWordWrap: Boolean;
      FWrappedText: TStrings;
      FTabStopPositions: TStrings;
      FDeviceFontHeight: Integer;
      FDeviceLineHeight: Integer;
      FDeviceLineWidth: Integer;

      {print to file properties}
      FBandSave: Boolean;
      FBandSaveNo: Longint;
      FBandType: TppBandType;
      FReportSaveNo: Integer;
      FRowSaveNo: Integer;
      FColumnSaveNo: Integer;
      FComponent: TComponent;
      FComponentSave: Boolean;
      FComponentSaveNo: Integer;
      FForceJustifyLastLine: Boolean;
      FTextAlignment: TppTextAlignment;
      FSaveLength: Integer;

      function GetHasTabStopPositions: Boolean;
      function GetIsMultiLine: Boolean;
      function  GetOrder: String;
      procedure ReadAlignment(Reader: TReader);
      procedure SetAlignment(Value: TAlignment);
      procedure SetTextAlignment(Value: TppTextAlignment);

      procedure SetFont(aFont: TFont);
      procedure SetWrappedText(Value: TStrings);
      procedure SetTabStopPositions(Value: TStrings);
      procedure SetHyperLink(Value: string);

      procedure ReadRotatedOriginLeft(Reader: TReader);
      procedure ReadRotatedOriginTop(Reader: TReader);
      procedure WriteRotatedOriginLeft(Writer: TWriter);
      procedure WriteRotatedOriginTop(Writer: TWriter);

    protected
      procedure DefineProperties(Filer: TFiler); override;
      function  GetText: String; virtual;
      function GetValue: Variant; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;

      property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
      property Component: TComponent read FComponent write FComponent;
      property Order: String read GetOrder;
      property DeviceFontHeight: Integer read FDeviceFontHeight write FDeviceFontHeight;
      property DeviceLineHeight: Integer read FDeviceLineHeight write FDeviceLineHeight;
      property DeviceLineWidth: Integer read FDeviceLineWidth write FDeviceLineWidth;
      property HasTabStopPositions: Boolean read GetHasTabStopPositions;

    published
      property Angle: Integer read FAngle write FAngle;
      property AutoSize: Boolean read FAutoSize write FAutoSize default False;
      property Color: TColor read FColor write FColor default clWhite;
      property Font: TFont read FFont write SetFont;
      property ForceJustifyLastLine: Boolean read FForceJustifyLastLine write FForceJustifyLastLine default False;
      property Hyperlink: string read FHyperlink write SetHyperlink;
      property IsMemo: Boolean read FIsMemo write FIsMemo default False;
      property IsMultiLine: Boolean read GetIsMultiLine stored False;
      property Leading: Integer read FLeading write FLeading default 0;
      property RotatedOrigin: TPoint read FRotatedOrigin write FRotatedOrigin stored False;
      property TabStopPositions: TStrings read FTabStopPositions write SetTabStopPositions;
      property Text: String read GetText write FText;
      property TextAlignment: TppTextAlignment read FTextAlignment write SetTextAlignment default taLeftJustified;
      property Transparent: Boolean read FTransparent write FTransparent default False;
      property WordWrap: Boolean read FWordWrap write FWordWrap default False;
      property WrappedText: TStrings read FWrappedText write SetWrappedText;

      {print to file properties}
      property BandSave: Boolean read FBandSave write FBandSave default False;
      property BandSaveNo: Longint read FBandSaveNo write FBandSaveNo default 0;
      property BandType: TppBandType read FBandType write FBandType default btNotKnown;
      property ReportSaveNo: Integer read FReportSaveNo write FReportSaveNo default 0;
      property RowSaveNo: Integer read FRowSaveNo write FRowSaveNo default 0;
      property ColumnSaveNo: Integer read FColumnSaveNo write FColumnSaveNo default 0;
      property ComponentSave: Boolean read FComponentSave write FComponentSave default False;
      property ComponentSaveNo: Integer read FComponentSaveNo write FComponentSaveNo default 0;
      property SaveLength: Integer read FSaveLength write FSaveLength default 0;

  end; {class, TppDrawText}


  {@TraTppDrawTextRTTI }
  TraTppDrawTextRTTI = class(TraTppDrawCommandRTTI)
    public
      class function RefClass: TClass; override;
  end; {class, TraTppDrawTextRTTI}


  {@TppDrawVariable }
  TppDrawVariable = class(TppDrawText)
    private
      FLookAhead: Boolean;
      FLookAheadKey: String;
      FTraversalCount: Integer;
      FWalkieTalkie: TppCommunicator;

      procedure WalkieTalkieEventNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
      procedure SetLookAhead(aValue: Boolean);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;

      function  IsUpdateable: Boolean; override;
      function  Update: Boolean; override;

      property LookAhead: Boolean read FLookAhead write SetLookAhead;
      property LookAheadKey: String read FLookAheadKey write FLookAheadKey;
      property TraversalCount: Integer read FTraversalCount write FTraversalCount;
      property WalkieTalkie: TppCommunicator read FWalkieTalkie write FWalkieTalkie;

  end; {class, TppDrawVariable}


  {@TppDrawVar }
  TppDrawVar = class(TppDrawText)
    private
      FVarType: TppVarType;

    protected
      function GetText: string; override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure Assign(Source: TPersistent); override;
      function  EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;
      function  IsUpdateable: Boolean; override;
      function  Update: Boolean; override;

    published
      property VarType: TppVarType read FVarType write FVarType default vtDate;

  end; {class, TppDrawVar}


  {@TppDrawCalc

    Contains the information necessary to draw text which is based on a
    calculation to any device.  This is a special draw command created by the
    TppCalc component so that the PageCount will be maintained in the page of
    the print preview window as the report generates.}

  {@TppDrawCalc.CalcType

    The value of the component's CalcType property at the time the component was
    generated.}

  TppDrawCalc = class(TppDrawText)
    private
      FCalcType: TppCalcType;

    public
      constructor Create(aOwner: TComponent); override;

      function  IsUpdateable: Boolean; override;
      procedure Assign(Source: TPersistent); override;
      function  Update: Boolean; override;

    published
      property CalcType: TppCalcType read FCalcType write FCalcType default ctDate;

  end; {class, TppDrawCalc}


  {@TppDrawShape

    Contains the information necessary to draw a shape to any device}

  {@TppDrawShape.Brush

    The value of the Brush property of the component at the time it was
    generated by the report engine.}

  {@TppDrawShape.Gradient

    The value of the Gradient property of the component at the time it was
    generated by the report engine.}

  {@TppDrawShape.Pen

    The value of the Pen property of the component at the time it was generated
    by the report engine.}

  {@TppDrawShape.ShapeType

    The value of the ShapeType property of the component at the time it was
    generated by the report engine.}

  {@TppDrawShape.XCornerRound

    Factor to be used when rounding the corner of a RoundRect type shape.}

  {@TppDrawShape.YCornerRound

    Factor to be used when rounding the corner of a RoundRect type shape.}

  TppDrawShape = class(TppDrawCommand)
    private
      FBrush        : TBrush;
      FGradient: TppGradient;
      FOldStyle: Boolean;
      FPen          : TPen;
      FShapeType    : TShapeType;
      FXCornerRound : Integer;
      FYCornerRound : Integer;

      procedure SetBrush(aBrush: TBrush);
      procedure SetGradient(Value: TppGradient);
      procedure SetPen(aPen: TPen);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;

    published

      property DataType default dtGraphic;
      property Brush: TBrush read FBrush write SetBrush;
      property Gradient: TppGradient read FGradient write SetGradient;
      property OldStyle: Boolean read FOldStyle write FOldStyle default True;
      property Pen: TPen read FPen write SetPen;
      property ShapeType: TShapeType read FShapeType write FShapeType default stRectangle;
      property XCornerRound: Integer read FXCornerRound write FXCornerRound default 0;
      property YCornerRound: Integer read FYCornerRound write FYCornerRound default 0;

  end; {class, TppDrawShape}

  {@TppDrawLine

    Contains the information necessary to draw a line to any device.}

  {@TppDrawLine.LinePosition

    The value of the Position property of a line component as generated by the
    report engine (always in thousandths of millimeters.)}

  {@TppDrawLine.LineStyle

    The value of Style property for a line component as generated by the report
    engine (always in thousandths of millimeters.)}

  {@TppDrawLine.Pen

    The value of the Pen property for a line component as generated by the
    report engine (always in thousandths of millimeters.)}

  TppDrawLine = class(TppDrawCommand)
    private
      FLinePosition: TppLinePositionType;
      FLineStyle: TppLineStyleType;
      FPen: TPen;
      FWeight: Single;

      procedure SetPen(aPen: TPen);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;

    published

      property DataType default dtGraphic;
      property LinePosition : TppLinePositionType read FLinePosition write FLinePosition default lpTop;
      property LineStyle : TppLineStyleType read FLineStyle write FLineStyle default lsSingle;
      property Pen: TPen read FPen write SetPen;
      property Weight: Single read FWeight write FWeight;

  end; {class, TppDrawLine}


  {@TppDrawImage
    Contains the information necessary to draw an image to any device.}

  {@TppDrawImage.AlignHorizontal

    The value of the AlignHorizontal property of the image component which
    created the draw command.}

  {@TppDrawImage.AlignVertical

    The value of the AlignVertical property of the image component which created
    the draw command.}

  {@TppDrawImage.MaintainAspectRatio

    The value of the MaintainAspectRatio property of the image component which
    created the draw command.}

  {@TppDrawImage.Picture

    The rectangle which represents the valid area in which the component should
    be rendered, given the height and and width of the parent region or band. By
    default the image data in the picture is streamed down with the form. To
    prevent this from hapenning set StoreImage to false.}

  {@TppDrawImage.Scale

    Whether or not the image should be scaled.}

  {@TppDrawImage.Stretch

    The value of the Stretch property of the image component which created the
    draw command.}

  {@TppDrawImage.Transparent

    The value of the Transparent property of the image component which created
    the draw command.}

  TppDrawImage = class(TppDrawCommand)
    private
      FAlignHorizontal: TppAlignHorizontalType;
      FAlignVertical: TppAlignVerticalType;
      FMaintainAspectRatio: Boolean;
      FPicture: TPicture;
      FScale: Boolean;
      FStretch: Boolean;
      FTransparent: Boolean;
      FDirectDraw: Boolean;
      FBitmap: TBitmap;
      FImageName: String;
      FStoreImage: Boolean;

      function GetCenter: Boolean;
      procedure SetPicture(aPicture: TPicture);
      function  GetGraphicAsBitmap: TBitmap;
      procedure ReadCenter(Reader: TReader);

    protected
      procedure DefineProperties(Filer: TFiler); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      function AsBitmap: TBitmap;


      property Center: Boolean read GetCenter; // backward compatibility
      property StoreImage: Boolean read FStoreImage write FStoreImage;

    published
      property AlignHorizontal: TppAlignHorizontalType read FAlignHorizontal write FAlignHorizontal;
      property AlignVertical: TppAlignVerticalType read FAlignVertical write FAlignVertical;
      property DataType default dtGraphic;
      property MaintainAspectRatio: Boolean read FMaintainAspectRatio write FMaintainAspectRatio default False;
      property Picture: TPicture read FPicture write SetPicture stored FStoreImage;
      property Scale: Boolean read FScale write FScale default False;
      property Stretch: Boolean read FStretch write FStretch default False;
      property Transparent: Boolean read FTransparent write FTransparent default False;
      property DirectDraw: Boolean read FDirectDraw write FDirectDraw default False;
      property ImageName: String read FImageName write FImageName;

  end; {class, TppDrawImage}

type
  {TppDrawTextCollection}
  TppDrawTextCollection = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TppDrawText;
  public
    function Add(aDrawText: TppDrawText): Integer;
    function Remove(aDrawText: TppDrawText): Integer;
    property Items[Index: Integer]: TppDrawText read GetItems; default;
  end;

  TppDrawTextOwnedCollection = class(TppDrawTextCollection)

  public
    constructor Create; override;
  end;

 {general procedures}
  procedure ppTextOutRotate(aCanvas: TCanvas; aFont: TFont; aX, aY: Integer; aAngle: longint; aText: string);
  function ppInInches(aValue: Longint): Single;


implementation

uses
  ppViewr, ppPrnDev;

{******************************************************************************
 *
 ** D R A W   T E X T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawText.Create }

constructor TppDrawText.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FAlignment := taLeftJustify;
  FTextAlignment := taLeftJustified;
  FForceJustifyLastLine := False;
  FAutoSize  := False ;
  FColor := clWhite;
  FDeviceFontHeight := 0;
  FDeviceLineHeight := 0;
  FDeviceLineWidth := 0;
  FFont := TppFont.Create;
  FIsMemo := False;
  FLeading := 0;
  FSaveLength := 0;
  FText := '';
  FTransparent := False;
  FTabStopPositions := TStringList.Create;
  FWordWrap := False;
  FWrappedText := TStringList.Create;

  {print to file properties}
  FBandType := btNotKnown;
  FBandSave := False;
  FBandSaveNo := 0;
  FReportSaveNo := 0;
  FRowSaveNo := 0;
  FColumnSaveNo := 0;
  FComponent := nil;
  FComponentSave  := False;
  FComponentSaveNo := 0;
  FSaveLength := 0;

end; {constructor, TppDrawText}

{------------------------------------------------------------------------------}
{ TppDrawText.Destroy }

destructor TppDrawText.Destroy;
begin
  FFont.Free;
  FTabStopPositions.Free;
  FWrappedText.Free;

  inherited Destroy;
end; {destructor, TppDrawText}

{------------------------------------------------------------------------------}
{ TppDrawText.EqualTo }

function TppDrawText.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
var
  lDrawText: TppDrawText;
{$IFDEF QA and CodeSite}
  liIndex: Integer;
{$ENDIF}
begin      

  lDrawText := TppDrawText(aDrawCommand);

  Result := inherited EqualTo(aDrawCommand) and
            (FAlignment = lDrawText.FAlignment) and
            (FTextAlignment = lDrawText.FTextAlignment) and
            (FForceJustifyLastLine = lDrawText.FForceJustifyLastLine) and
            (FAutoSize  = lDrawText.FAutoSize) and
            (FColor = lDrawText.FColor) and
            (FFont.Name = lDrawText.FFont.Name) and
            (FFont.Size = lDrawText.FFont.Size) and
            (FFont.Style = lDrawText.FFont.Style) and
            (FIsMemo = lDrawText.FIsMemo) and
            (FLeading = lDrawText.FLeading) and
            (FSaveLength = lDrawText.FSaveLength) and
            (FText = lDrawText.FText) and
            (FTransparent = lDrawText.FTransparent) and
            (FTabStopPositions.Text = lDrawText.FTabStopPositions.Text) and
            (FWordWrap = lDrawText.FWordWrap) and
            (FWrappedText.Text = lDrawText.FWrappedText.Text) and
            (FHyperlink = lDrawText.Hyperlink) and
            (FBandType = lDrawText.BandType);

{$IFDEF QA and CodeSite}
 if not Result and (FWrappedText.Text <> lDrawText.FWrappedText.Text) then
  begin
    CodeSite.EnterMethod('**TppDrawText.EqualTo');

    if (FWrappedText.Count <> lDrawText.FWrappedText.Count) then
      CodeSite.Send('FWrappedText.Count: ' + IntToStr(FWrappedText.Count) + ' <> ' +  IntToStr(lDrawText.FWrappedText.Count))
    else
      for liIndex := 0 to FWrappedText.Count - 1 do
       if (FWrappedText[liIndex] <> lDrawText.FWrappedText[liIndex]) then
         begin
           CodeSite.Send('FWrappedText[ ' + IntToStr(liIndex) + '] ' +  FWrappedText[liIndex]);
           CodeSite.Send('lDrawText.FWrappedText[ ' + IntToStr(liIndex) + '] ' +  lDrawText.FWrappedText[liIndex]);


         end;

    CodeSite.ExitMethod('**TppDrawText.EqualTo');

  end;
{$ENDIF}

end; {function, EqualTo}

{@TppDrawText.Assign
 Transfers the value of properties added as a descendant of TppDrawCommand.}

procedure TppDrawText.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawText;
begin

  inherited Assign(Source);

  if not(Source is TppDrawText) then Exit;

  lDrawCommand := TppDrawText(Source);

  FAlignment            := lDrawCommand.Alignment;
  FAngle                := lDrawCommand.Angle;
  FAutoSize             := lDrawCommand.AutoSize;
  FColor                := lDrawCommand.Color;
  FForceJustifyLastLine := lDrawCommand.ForceJustifyLastLine;
  FIsMemo               := lDrawCommand.IsMemo;
  FTextAlignment        := lDrawCommand.TextAlignment;
  FLeading              := lDrawCommand.Leading;
  FRotatedOrigin        := lDrawCommand.RotatedOrigin;
  FText                 := lDrawCommand.Text;
  FTransparent          := lDrawCommand.Transparent;
  FWordWrap             := lDrawCommand.WordWrap;
  FHyperLink            := lDrawCommand.HyperLink;

  FDeviceFontHeight := lDrawCommand.FDeviceFontHeight;
  FDeviceLineHeight := lDrawCommand.FDeviceLineHeight;
  FDeviceLineWidth := lDrawCommand.FDeviceLineWidth;

  {object assigns}
  FFont.Assign(lDrawCommand.Font);
  FTabStopPositions.Assign(lDrawCommand.TabStopPositions);
  FWrappedText.Assign(lDrawCommand.WrappedText);

  {print to file properties}
  FBandType        := lDrawCommand.BandType;
  FBandSave        := lDrawCommand.BandSave;
  FBandSaveNo      := lDrawCommand.BandSaveNo;
  FReportSaveNo    := lDrawCommand.ReportSaveNo;
  FComponent       := lDrawCommand.Component;
  FComponentSave   := lDrawCommand.ComponentSave;
  FComponentSaveNo := lDrawCommand.ComponentSaveNo;
  FSaveLength      := lDrawCommand.SaveLength;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDrawText.DefineProperties }

procedure TppDrawText.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  Filer.DefineProperty('Alignment', ReadAlignment, nil, False);

  Filer.DefineProperty('RotatedOriginLeft', ReadRotatedOriginLeft, WriteRotatedOriginLeft, Angle <> 0);
  Filer.DefineProperty('RotatedOriginTop', ReadRotatedOriginTop, WriteRotatedOriginTop, Angle <> 0);

end; {procedure, DefineProperties}


{------------------------------------------------------------------------------}
{ TppDrawText.GetHasTabStopPositions }

function TppDrawText.GetHasTabStopPositions: Boolean;
begin
  Result := FTabStopPositions.Count > 0;
end;

{------------------------------------------------------------------------------}
{ TppDrawText.GetIsMultiLine }

function TppDrawText.GetIsMultiLine: Boolean;
begin
  Result := FWrappedText.Count > 0;
end;

{------------------------------------------------------------------------------}
{ TppDrawText.ReadRotatedOriginLeft }

procedure TppDrawText.ReadRotatedOriginLeft(Reader: TReader);
begin
  FRotatedOrigin.X := Reader.ReadInteger;

end; {procedure, ReadRotatedOriginLeft}

{------------------------------------------------------------------------------}
{ TppDrawText.ReadRotatedOriginTop }

procedure TppDrawText.ReadRotatedOriginTop(Reader: TReader);
begin
  FRotatedOrigin.Y := Reader.ReadInteger;

end; {procedure, ReadRotatedOriginTop}

{------------------------------------------------------------------------------}
{ TppDrawText.WriteRotatedOriginLeft }

procedure TppDrawText.WriteRotatedOriginLeft(Writer: TWriter);
begin
  Writer.WriteInteger(FRotatedOrigin.X);

end; {procedure, WriteRotatedOriginLeft}

{------------------------------------------------------------------------------}
{ TppDrawText.WriteRotatedOriginTop }

procedure TppDrawText.WriteRotatedOriginTop(Writer: TWriter);
begin
  Writer.WriteInteger(FRotatedOrigin.Y);
  
end; {procedure, WriteRotatedOriginTop}

{------------------------------------------------------------------------------}
{ TppDrawText.ReadAlignment }

procedure TppDrawText.ReadAlignment(Reader: TReader);
var
  lsValue: String;
begin
  lsValue := Reader.ReadIdent;

  if lsValue = csAlignLeftIdent then
    Alignment := taLeftJustify
  else if lsValue = csAlignCenterIdent then
    Alignment := taCenter
  else if lsValue = csAlignRightIdent then
    Alignment := taRightJustify;
end; {procedure, ReadAlignment}

{------------------------------------------------------------------------------}
{ TppDrawText.GetOrder }

function TppDrawText.GetOrder: String;
begin
  Result := Format('%8d', [FReportSaveNo]) + Format('%8d',[FBandSaveNo]) + Format('%8d',[FRowSaveNo]) +
            Format('%8d', [FColumnSaveNo]) + Format('%8d',[FComponentSaveNo]);
end; {function, GetOrder}

{------------------------------------------------------------------------------}
{ TppDrawText.GetText }

function TppDrawText.GetText: String;
begin
  Result := FText;
end; {function, GetText}

function TppDrawText.GetValue: Variant;
begin

  Result := inherited GetValue;

  if csWriting in ComponentState then Exit;

  if (DataType in [dtString, dtMemo]) and (VarIsEmpty(Result) or (Result = '')) then
     if IsMultiLine then
       Result := WrappedText.Text
     else
       Result := Text;

end;

{------------------------------------------------------------------------------}
{ TppDrawText.SetFont }

procedure TppDrawText.SetFont(aFont: TFont);
begin
  FFont.Assign(aFont);
end; {function, SetFont}

{------------------------------------------------------------------------------}
{ TppDrawText.SetWrappedText }

procedure TppDrawText.SetWrappedText(Value: TStrings);
begin
  FWrappedText.Assign(Value);
end; {function, SetWrappedText}

{------------------------------------------------------------------------------}
{ TppDrawText.SetTabStopPositions }

procedure TppDrawText.SetTabStopPositions(Value: TStrings);
begin
  FTabStopPositions.Assign(Value);
end; {function, SetTabStopPositions}

{------------------------------------------------------------------------------}
{ TppDrawText.SetAlignment }

procedure TppDrawText.SetAlignment(Value: TAlignment);
begin

  if (FAlignment <> Value) then
    begin
      FAlignment := Value;

      case FAlignment of
        taLeftJustify:
            FTextAlignment := taLeftJustified;

        taRightJustify:
            FTextAlignment := taRightJustified;

        taCenter:
            FTextAlignment := taCentered;
      end;
    end;

end; {procedure, SetAlignment}

{------------------------------------------------------------------------------}
{ TppDrawText.SetHyperLink }

procedure TppDrawText.SetHyperLink(Value: string);
begin
  FHyperLink := Value;

end;

{------------------------------------------------------------------------------}
{ TppDrawText.SetTextAlignment }

procedure TppDrawText.SetTextAlignment(Value: TppTextAlignment);
begin

  if (FTextAlignment <> Value) then
    begin
      FTextAlignment := Value;

      Case FTextAlignment of
        taRightJustified:
          FAlignment := taRightJustify;

        taCentered:
          FAlignment := taCenter;

        else
          FAlignment := taLeftJustify;
      end;

    end;

end; {procedure, SetTextAlignment}

{******************************************************************************
 *
 ** D R A W   L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawLine.Create }

constructor TppDrawLine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DataType := dtGraphic;

  FLinePosition := lpTop;
  FLineStyle := lsSingle;
  FPen := TPen.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawLine.Destroy }

destructor TppDrawLine.Destroy;
begin

  FPen.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDrawLine.EqualTo }

function TppDrawLine.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
var
  lDrawLine: TppDrawLine;
begin

  lDrawLine := TppDrawLine(aDrawCommand);

  Result := inherited EqualTo(aDrawCommand) and
            (FLinePosition = lDrawLine.LinePosition) and
            (FLineStyle = lDrawLine.LineStyle) and
            (FPen.Color = lDrawLine.Pen.Color) and
            (FPen.Style = lDrawLine.Pen.Style) and
            (FPen.Width = lDrawLine.Pen.Width);

end; {function, EqualTo}

{------------------------------------------------------------------------------}
{ TppDrawLine.Assign }

procedure TppDrawLine.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawLine;
begin

  inherited Assign(Source);

  if not(Source is TppDrawLine) then Exit;

  lDrawCommand := TppDrawLine(Source);

  FLinePosition := lDrawCommand.LinePosition;
  FLineStyle    := lDrawCommand.LineStyle;

  {object assigns}
  FPen.Assign(lDrawCommand.Pen);

  FWeight := lDrawCommand.Weight;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDrawLine.SetPen }

procedure TppDrawLine.SetPen(aPen: TPen);
begin
  FPen.Assign(aPen);
end; {procedure, SetPen}

{******************************************************************************
 *
 ** D R A W   S H A P E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawShape.Create }

constructor TppDrawShape.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DataType := dtGraphic;

  FBrush := TBrush.Create;
  FPen := TPen.Create;
  FGradient := TppGradient.Create(aOwner);
  FShapeType := stRectangle;
  FXCornerRound := 0;
  FYCornerRound := 0;
  FOldStyle := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawShape.Destroy }

destructor TppDrawShape.Destroy;
begin
  FBrush.Free;
  FPen.Free;

  FGradient.Free;
  FGradient := nil;

  inherited Destroy;
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDrawShape.EqualTo }

function TppDrawShape.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
var
  lDrawShape: TppDrawShape;
begin

  lDrawShape := TppDrawShape(aDrawCommand);

  Result := inherited EqualTo(aDrawCommand) and
            (FBrush.Color = lDrawShape.Brush.Color) and
            (FBrush.Style = lDrawShape.Brush.Style) and
            (FPen.Color = lDrawShape.Pen.Color) and
            (FPen.Style = lDrawShape.Pen.Style) and
            (FPen.Width = lDrawShape.Pen.Width) and
            (FGradient.StartColor = lDrawShape.Gradient.StartColor) and
            (FGradient.EndColor = lDrawShape.Gradient.EndColor) and
            (FGradient.Style = lDrawShape.Gradient.Style) and
            (FShapeType = lDrawShape.ShapeType) and
            (FXCornerRound = lDrawShape.XCornerRound) and
            (FYCornerRound = lDrawShape.YCornerRound);
{$IFDEF NewRect}
            and (FOldStyle = lDrawShape.OldStyle);
{$ENDIF}

end; {function, EqualTo}


{@TppDrawShape.Assign
 Transfers the value of properties added as a descendant of TppDrawCommand.}

procedure TppDrawShape.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawShape;
begin

  inherited Assign(Source);

  if not(Source is TppDrawShape) then Exit;

  lDrawCommand := TppDrawShape(Source);

  FShapeType    := lDrawCommand.ShapeType;
  FXCornerRound := lDrawCommand.XCornerRound;
  FYCornerRound := lDrawCommand.YCornerRound;
  FOldStyle     := lDrawCommand.OldStyle;

  {object assigns}
  FBrush.Assign(lDrawCommand.Brush);
  FPen.Assign(lDrawCommand.Pen);
  FGradient.Assign(lDrawCommand.Gradient);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDrawShape.SetBrush }

procedure TppDrawShape.SetBrush(aBrush: TBrush);
begin
  FBrush.Assign(aBrush);
end; {procedure, SetBrush}

procedure TppDrawShape.SetGradient(Value: TppGradient);
begin
  FGradient.Assign(Value);

end;

{------------------------------------------------------------------------------}
{ TppDrawShape.SetPen }

procedure TppDrawShape.SetPen(aPen: TPen);
begin
  FPen.Assign(aPen);
end; {procedure, SetPen}

{******************************************************************************
 *
 ** D R A W   I M A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawImage.Create }

constructor TppDrawImage.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FBitmap := nil;

  FPicture     := TPicture.Create;
  FScale       := False;
  FStretch     := False;
  FTransparent := False;
  FDirectDraw  := False;
  FMaintainAspectRatio := False;
  FImageName := '';
  FStoreImage := True;

  DataType := dtGraphic;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawImage.Destroy }

destructor TppDrawImage.Destroy;
begin

  FBitmap.Free;

  FPicture.Assign(nil);

  {if FPicture.Graphic <> nil then
    begin
      FPicture.Graphic.Free;
      FPicture.Graphic := nil;
    end;}

  FPicture.Free;

  inherited Destroy;

end; {destructor, Destroy}

procedure TppDrawImage.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  {Used for converstion to 11.0}
  Filer.DefineProperty('Center', ReadCenter, nil, False);

end;
{------------------------------------------------------------------------------}
{ TppDrawImage.ReadCenter }

procedure TppDrawImage.ReadCenter(Reader: TReader);
begin
  if Reader.ReadBoolean then
    begin
      AlignHorizontal := ahCenter;
      AlignVertical := avCenter;
    end
  else
    begin
      AlignHorizontal := ahLeft;
      AlignVertical := avTop;
    end;

end; {procedure, ReadCenter}

{@TppDrawImage.Assign
 Transfers the value of properties added as a descendant of TppDrawCommand.}

procedure TppDrawImage.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawImage;
begin

  inherited Assign(Source);

  if not(Source is TppDrawImage) then Exit;

  lDrawCommand := TppDrawImage(Source);

  FDirectDraw   := lDrawCommand.DirectDraw;
  FMaintainAspectRatio := lDrawCommand.MaintainAspectRatio;
  FScale        := lDrawCommand.Scale;
  FStretch      := lDrawCommand.Stretch;
  FTransparent  := lDrawCommand.Transparent;
  FImageName    := lDrawCommand.ImageName;
  FAlignHorizontal := lDrawCommand.AlignHorizontal;
  FAlignVertical   := lDrawCommand.AlignVertical;

  {object assigns}
 { FPicture.Assign(lDrawCommand.Picture);}
 SetPicture(lDrawCommand.Picture);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDrawImage.SetPicture }

procedure TppDrawImage.SetPicture(aPicture: TPicture);
begin
  FPicture.Assign(aPicture);

  if (FPicture.Graphic is TBitmap) then
    FPicture.Bitmap.HandleType := bmDIB;

end; {procedure, SetPicture}

{------------------------------------------------------------------------------}
{ TppDrawImage.AsBitmap }

function TppDrawImage.AsBitmap: TBitmap;
begin

  if (FPicture.Graphic is TMetaFile) then
     Result := nil

  else if (FPicture.Graphic is TBitmap) then
    Result := FPicture.Bitmap

  else
    Result := GetGraphicAsBitmap;


end; {procedure, AsBitmap}

{------------------------------------------------------------------------------}
{ TppDrawImage.GetCenter }

function TppDrawImage.GetCenter: Boolean;
begin
  Result :=  (FAlignHorizontal = ahCenter) and (AlignVertical = avCenter);
end;


{------------------------------------------------------------------------------}
{ TppDrawImage.GetGraphicAsBitmap }

function TppDrawImage.GetGraphicAsBitmap: TBitmap;
begin

  if (FBitmap = nil) and (FPicture.Graphic <> nil) then
    begin

      {create bmp}
      FBitmap := TBitmap.Create;

      try

        FBitmap.Assign(FPicture.Graphic);

      except
        try
          FBitmap.Width   := Trunc(FPicture.Graphic.Width  * 0.25);
          FBitmap.Height  := Trunc(FPicture.Graphic.Height * 0.25);
          FBitmap.Palette := FPicture.Graphic.Palette;
          FBitmap.HandleType := bmDIB;

          {draw graphic to bmp}
          FBitmap.Canvas.StretchDraw(Rect(0, 0,FBitmap.Width,FBitmap.Height), FPicture.Graphic);

        except

          FBitmap.Free;
          FBitmap := nil;
        end;

      end;

   end;

  Result := FBitmap;

end; {function, GetGraphicAsBitmap}


{******************************************************************************
 *
 ** D R A W   V A R I A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawVariable.Create }

constructor TppDrawVariable.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FLookAhead := False;
  FLookAheadKey := '';
  FTraversalCount := 0;
  FWalkieTalkie := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawVariable.Destroy }

destructor TppDrawVariable.Destroy;
begin

  FWalkieTalkie.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDrawVariable.Assign }

procedure TppDrawVariable.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawVariable;
  liIndex: Integer;
  lWalkieTalkie: TppCommunicator;
  lCommunicator: TppCommunicator;
begin

  inherited Assign(Source);

  if not(Source is TppDrawVariable) then Exit;

  lDrawCommand := TppDrawVariable(Source);

  FLookAheadKey := lDrawCommand.LookAheadKey;

  SetLookAhead(lDrawCommand.LookAhead);

  {copy event notifications from one walkie talkie to the other}
  if (FLookAhead) then
    begin
      lWalkieTalkie := lDrawCommand.WalkieTalkie;

      for liIndex := 0 to lWalkieTalkie.NotifyCommunicatorCount - 1 do
        begin
          lCommunicator := lWalkieTalkie.NotifyCommunicators[liIndex];

          lCommunicator.AddEventNotify(FWalkieTalkie);
        end;
    end;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDrawVariable.EqualTo }

function TppDrawVariable.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
{var
  lDrawVar: TppDrawVar;
begin

  if (FVarType in [vtPrintDateTime, vtTime, vtDate, vtDateTime]) then
    begin
      if (aDrawCommand is TppDrawVar) and (TppDrawVar(aDrawCommand).VarType in [vtPrintDateTime, vtTime, vtDate, vtDateTime])then
        Result := True
      else
        Result := False;
    end
  else
    begin
      lDrawVar := TppDrawVar(aDrawCommand);

      Result := inherited EqualTo(aDrawCommand) and
                (FVarType = lDrawVar.VarType);
    end;   }

begin
  Result := inherited EqualTo(aDrawCommand);
end;

{------------------------------------------------------------------------------}
{ TppDrawVariable.SetLookAhead }

procedure TppDrawVariable.SetLookAhead(aValue: Boolean);
begin

  FLookAhead := aValue;

  if (FLookAhead) then
    begin
      if (FWalkieTalkie = nil) then
        FWalkieTalkie := TppCommunicator.Create(Self);

      FWalkieTalkie.EventNotifies := [ciComponentCalcLookAhead];
      FWalkieTalkie.OnEventNotify := WalkieTalkieEventNotifyEvent;
    end
  else
    begin
      FWalkieTalkie.Free;
      FWalkieTalkie := nil;
    end

end; {procedure, SetLookAhead}

{------------------------------------------------------------------------------}
{ TppDrawVariable.IsUpdateable }

function TppDrawVariable.IsUpdateable;
begin
  Result := FLookAhead;
end; {function, IsUpdateable}

{------------------------------------------------------------------------------}
{ TppDrawVariable.WalkieTalkieEventNotifyEvent }

procedure TppDrawVariable.WalkieTalkieEventNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lsLookAheadKey: String;
  liTraversalCount: Integer;
  lsText: String;
begin

  aParams.GetParamValue(0, lsLookAheadKey);
  aParams.GetParamValue(1, liTraversalCount);
  aParams.GetParamValue(2, lsText);

  if (lsLookAheadKey = FLookAheadKey)  then
    begin

      if (liTraversalCount > FTraversalCount) then
        begin
          Text := lsText;

          FTraversalCount := liTraversalCount;
        end;

    end

   else 
    FWalkieTalkie.EventNotifies := [];

end; {procedure, WalkieTalkieEventNotifyEvent}

{------------------------------------------------------------------------------}
{ TppDrawVariable.Update }

function TppDrawVariable.Update: Boolean;
begin
  Result := FLookAhead and (FWalkieTalkie.EventNotifies <> []);
end; {procedure, Update}

{******************************************************************************
 *
 ** D R A W   V A R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawVar.Create }

constructor TppDrawVar.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FVarType := vtDate;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawVar.EqualTo }

function TppDrawVar.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
var
  lDrawVar: TppDrawVar;
begin

  if (FVarType in [vtPrintDateTime, vtTime, vtDate, vtDateTime]) then
    begin
      if (aDrawCommand is TppDrawVar) and (TppDrawVar(aDrawCommand).VarType in [vtPrintDateTime, vtTime, vtDate, vtDateTime])then
        Result := True
      else
        Result := False;
    end
  else
    begin
      lDrawVar := TppDrawVar(aDrawCommand);

      Result := inherited EqualTo(aDrawCommand) and
                (FVarType = lDrawVar.VarType);
    end;

end; {function, EqualTo}

{------------------------------------------------------------------------------}
{ TppDrawVar.Assign }

procedure TppDrawVar.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawVar;
begin

  inherited Assign(Source);

  if not(Source is TppDrawVar) then Exit;

  lDrawCommand := TppDrawVar(Source);

  FVarType := lDrawCommand.VarType;

end; {procedure, Assign}

function TppDrawVar.GetText: string;
begin

  {Do not display for the original document (copy 0)}
  if (FVarType in [vtCopyNo, vtCopyNoDesc]) and (Page.CopyNo = 0) then
    Result := ''

  else if FVarType = vtCopyNo then
    Result := IntToStr(Page.CopyNo)

  else if FVarType = vtCopyNoDesc then
    Result := ppLoadStr(1099) + ' ' + IntToStr(Page.CopyNo)

  else
    Result := inherited GetText;

end;

{------------------------------------------------------------------------------}
{ TppDrawVar.IsUpdateable }

function TppDrawVar.IsUpdateable;
begin
  Result := FVarType in [vtPageNo, vtPageNoDesc, vtPageCount, vtPageSet, vtPageSetDesc];
end; {function, IsUpdateable}

{------------------------------------------------------------------------------}
{ TppDrawVar.Update }

function TppDrawVar.Update: Boolean;
var
  liValue: Integer;
begin

  Result := False;

  if (Component <> nil) and (FVarType in [vtPageCount, vtPageNo]) then
    begin
      if FVarType = vtPageNo then
        liValue := Page.PageNo
      else
        liValue := Page.PageCount;

        Text := ppFormat(TraRTTI.GetPropValueAsString(Component, 'DisplayFormat'), dtInteger, liValue);
        Result := True;
    end

  else case FVarType of

    vtPageNo, vtPageNoDesc, vtPageCount, vtPageSet, vtPageSetDesc:
      begin
        Text := ppFormatVarValue(FVarType, Page.PageNo, Page.PageCount,
                                 Page.PrintDateTime, Page.LanguageIndex, True);

        Result := True;
      end;

  end; {case, calctype}

end; {procedure, Update}

{******************************************************************************
 *
 ** D R A W   C A L C
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawCalc.Create }

constructor TppDrawCalc.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FCalcType := ctDate;

end; {constructor, Create}


{@TppDrawCalc.Assign
 Transfers the value of properties added as a descendant of TppDrawText.}

procedure TppDrawCalc.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawCalc;
begin

  inherited Assign(Source);

  if not(Source is TppDrawCalc) then Exit;

  lDrawCommand := TppDrawCalc(Source);

  FCalcType := lDrawCommand.CalcType;

end; {procedure, Assign}


{@TppDrawCalc.IsUpdateable
Returns true, because drawcalc commands are updateable.

 Indicates whether the command should be notified as the report engine generates
 pages.  This is used by draw commands which represent page counts in order to
 update their values as the report generates.  Each time the screen device
 receives a message page the Update method of the page is called.  This method
 loops thru the updateable draw commands calling the Update method.}

function TppDrawCalc.IsUpdateable;
begin
  Result := True;
end; {function, IsUpdateable}


{@TppDrawCalc.Update
 When the drawcalc command represents a PageCount, PageSet, or PageSetDesc type
 TppCalc, then this routine updates the text property with the current page
 information from the report.}

function TppDrawCalc.Update: Boolean;
begin

  Result := False;

  case FCalcType of

    ctPageCount, ctPageSet, ctPageSetDesc:
      begin
        Text := ppFormatCalcValue(FCalcType, Page.PageNo, Page.PageCount,
                                  Page.PrintDateTime, Page.LanguageIndex, True);

        Result := True;
      end;

  end; {case, calctype}

end; {procedure, Update}

{******************************************************************************
 *
 ** D R A W   T E X T   R T T I
 *
{******************************************************************************}

{ TraTppDrawTextRTTI }

class function TraTppDrawTextRTTI.RefClass: TClass;
begin
  Result :=  TppDrawText;

end;



{******************************************************************************
 *
 **  G E N E R A L  R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppInInches }

function ppInInches(aValue: Longint): Single;
begin
 Result := ppFromMMThousandths(aValue, utInches, pprtHorizontal, nil);
end; {function, ppInInches}

{------------------------------------------------------------------------------}
{ ppCreateRotatedFont }

function ppCreateRotatedFont(aFont: TFont; aAngle: Integer): HFont;
{-create a rotated font based on the font object F}
var
  lLogFont: TLogFont;
begin
  FillChar(lLogFont, SizeOf(lLogFont), #0);

  with lLogFont do
  begin
    lfHeight := -Round(aFont.Size * aFont.PixelsPerInch / 72);
    lfWidth := 0;
    lfEscapement := aAngle *10;
    lfOrientation := aAngle * 10;
    lfCharSet := DEFAULT_CHARSET;
    StrPCopy(lfFaceName, aFont.Name);
    lfQuality := DEFAULT_QUALITY;
    lfOutPrecision := OUT_DEFAULT_PRECIS;
    lfClipPrecision := CLIP_DEFAULT_PRECIS;
    if (fsBold in aFont.Style) then
      lfWeight := FW_BOLD;
    lfItalic := Byte(fsItalic in aFont.Style);
    lfUnderline := Byte(fsUnderline in aFont.Style);
    lfStrikeOut := Byte(fsStrikeout in aFont.Style);
  end;
  Result := CreateFontIndirect(lLogFont);

end; {function, ppCreateRotatedFont}

{------------------------------------------------------------------------------}
{ ppTextOutRotate }

procedure ppTextOutRotate(aCanvas: TCanvas; aFont: TFont; aX, aY: Integer; aAngle: longint; aText: string);
var
  hSaveFont, hNewFont: hFont;
  lBrushStyle: TBrushStyle;

begin
  lBrushStyle := aCanvas.Brush.Style;
  aCanvas.Brush.Style := bsClear;

  hNewFont  := 0;
  hSaveFont := 0;
  try
    hNewFont  := ppCreateRotatedFont(aFont, aAngle);
    hSaveFont := SelectObject(aCanvas.Handle, hNewFont);
    aCanvas.TextOut(aX, aY, aText);
  finally
    SelectObject(aCanvas.Handle, hSaveFont);
    DeleteObject(hNewFont);
    aCanvas.Brush.Style := lBrushStyle;

  end;

end; {function, ppTextOutRotate}

function TppDrawTextCollection.Add(aDrawText: TppDrawText): Integer;
begin
  Result := InnerList.Add(aDrawText);
end;

function TppDrawTextCollection.GetItems(Index: Integer): TppDrawText;
begin
  Result := TppDrawText(InnerList[Index]);
end;

function TppDrawTextCollection.Remove(aDrawText: TppDrawText): Integer;
begin
  Result := InnerList.Remove(aDrawText);
end;

constructor TppDrawTextOwnedCollection.Create;
begin
  inherited;
  InnerList.OwnsObjects := True;
end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppDrawText, TppDrawVar, TppDrawCalc, TppDrawShape, TppDrawLine,
                   TppDrawImage, TppDrawVariable]);

  raRegisterRTTI(TraTppDrawTextRTTI);

finalization

   UnRegisterClasses([TppDrawText, TppDrawVar, TppDrawCalc, TppDrawShape, TppDrawLine,
                     TppDrawImage, TppDrawVariable]);

  raUnRegisterRTTI(TraTppDrawTextRTTI);

end.


