{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                    BBBBB   }

unit ppBarCod;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Dialogs,

  ppClass,
  ppCtrls,
  ppTypes,
  ppCharacter,
  ppUtils,
  ppDevice,
  ppDrwCmd,
  ppDB,
  ppPrnabl,
  ppComm,
  ppRTTI,
  ppBarCodDrwCmd;

type
  EBarCodeError = class(Exception);

  {@TppCustomBarCode

    Base class for one-dimensional barcode components. Descendants are

            TppBarCode
            TppDBBarCode}

  {@TppCustomBarCode.AddOnCode

    The AddOnCode property allows you to implement either 2 or 5 digit addon
    codes for UPC or EAN. If you try to enter an AddOnCode and the BarCodeType
    property is not set to either bcUPC_A or bcEAN_13, an exception will be
    raised. The AddOnCode is used for a few rather specific purposes.  The 2
    digit addon code is used to track the serial number of periodicals, mainly
    magazines.  The 5 digit addon has several purposes, but mainly it is used in
    conjunction with EAN-13 for bar coding books. A books ISBN number can be
    encoded in the actual EAN code.  Then the addon code is used to indicate the
    price of the book and the currency. This form of EAN is commonly known as
    "Bookland EAN."}

  {@TppCustomBarCode.AlignBarCode

    Aligns the barcode horizontally within the barcode control box.  The
    possible values for this property are:

    <Table>
    Value	      Meaning
    --------    ---------
    ahLeft   	  Align the barcode to the left (or top if using vertical
                orientation).
    ahCenter	  Align the barcode to the center of the control.
    ahRight	    Align the barcode to the right (or bottom if using vertical
                orientation).
    </Table>}

  {@TppCustomBarCode.AutoEncode

    This property is used in conjunction with the Code 128 symbology.  Code 128
    can be difficult to work with because there are actually three code sets
    within it, each used for a different purpose.  Added to this complexity is
    the capability to switch between code sets within the same symbol. You can
    even switch to another code set for a single character only.

    The AutoEncode property alleviates the difficulty of implementing Code 128
    symbols.  You no longer need to be concerned with any of the special control
    codes for set switching. Instead, set AutoEncode to True to invoke a
    proprietary algorithm which will automatically encode data as efficiently as
    possible. You simply set the Data property to the actual data you want to
    encode and the BarCode component will generate the most compact code
    possible.

    Note: For Code 128 symbols, AutoEncode defaults to True. (e.g. when you
    select bcCode128 as the BarCodeType, AutoEncode will be set to True).  You
    should only set this property to False if you have some special requirement
    and need to encode the symbol yourself. See Manually Encoding Data for Code
    128 for an explanation of manual set switching.}

  {@TppCustomBarCode.AutoSizeFont

    By default, the human readable text is set to a standard accepted font size
    based on the size of the barcode component. In order to take manual control
    of the font size, set AutoSizeFont to False. The human readable text will
    then be sized based on the value of the Font.Size property.}

  {@TppCustomBarCode.BarCodeType

    This is the main property of the component. It defines which symbology you
    want to use to create the bar code. When you set the BarCodeType, the Data
    property will be checked to ensure that the data is acceptable for the
    chosen type. For example, you cannot have alpha characters in an Interleaved
    2 of 5 code. If the data is not acceptable, an exception will be raised.

    These are the possible values:

    <Table>
    Value	              Meaning
    --------            ---------
    bcCodabar	          the bar code is created using Codabar.
    bcCode128	          the bar code is created using Code 128.
    bcCode39	          the bar code is created using Code 39.
    bcEAN_8	            the bar code is created using EAN-8.
    bcEAN_13	          the bar code is created using EAN-13.
    bcInt2of5	          the bar code is created using Interleaved 2 of 5.
    bcIntelligentMail   the bar code is created usign Intelligent Mail
    bcPostnet	          the bar code is created using PostNet.
    bcUPC_A	            the bar code is created using UPC-A.
    bcUPC_E	            the bar code is created using UPC-E.
    </Table>}

  {@TppCustomBarCode.BarColor

    Use this property to set a color for the actual bars themselves as well as
    the human readable text beneath the bar code.

    Note: for best scanning, bar codes should be black bars on a white
    background.}

  {@TppCustomBarCode.BarWidth

    This property allows you to change the width of each bar. For barcodes that
    have a narrow to wide bar ratio, the wide BarWidth is calculated based on
    the WideBarRatio property.  If you have the AutoSize property set to True,
    the component will resize when this property is changed.

    The standard accepted BarWidth for each symbology is listed below.

    <Table>
    Type              Inches            Millimeters      Comment
    -----------       ---------------   ---------------  -------
    Code 128          0.0070 to 0.015   0.1778 to 0.381  Varies based on use.
    Code 39 	        0.010             0.254
    EAN-13 	          0.013             0.3302
    Int. 2 of 5       0.015             0.381
    Intelligent Mail  0.020	            0.508
    Postnet           0.020	            0.508
    UPC-A             0.013             0.3302
    </Table>

    Note: These are only recommendations, you are free to use whatever BarWidth
    you choose.

    Further Note: We have successfully printed a Code 128 barcode on a 300 dpi
    laser printer with a bar width of 0.0070 inches.  That is an extremely
    efficient code!}

  {@TppCustomBarCode.BearerBars

    Bearer bars are horizontal lines that run along the top and bottom of the
    code. When bearer bars are not present, a partial scan can sometimes be
    interpreted as a complete scan. Bearer bars greatly reduce the chance of
    this happening.

    Note: Only Interleaved 2 of 5 bar codes can have bearer bars. The other
    symbologies do not need them. If you try to set BearerBars equal to True for
    any other symbology, an exception will be raised.}

  {@TppCustomBarCode.CalcCheckDigit

    When this property is to True, a check digit is automatically generated for
    UPC-A and EAN-13 barcodes. If CalcCheckDigit is set to False, then you must
    provide all 12 digits of the UPC code in the Data property, or an exception
    will be raised.}

  {@TppCustomBarCode.Color

    The background color for the component. Defaults to white.

    Note: for best scanning, bar codes should be black bars on a white
    background.}

  {@TppCustomBarCode.Data

    Use this property to specify the data to be encoded.  Data for each bar code
    symbology must follow certain rules or an exception will be raised. A
    description of acceptable data for each type of barcode is provided in the
    TppBarCode help topic.

    Note: Code 128 requires special characters in order to function properly.}

  {@TppCustomBarCode.Font

    This is the font that will be used to draw the human readable portion of the
    barcode. Also note that you can change the font attributes (bold, italic,
    etc.), but the font's size, by default, is automatically calculated by the
    component.  If you wish to specify a font size yourself, you must set the
    AutoSizeFont property to False. The Font's color is taken from the BarColor
    property, as all barcode specifications call for the bars and human readable
    text to be the same color.

    If possible, you should always use the font OCR-B font for the human
    readable portion of your barcode. If you do not have this TrueType font, it
    is available from a variety of sources. Most bar code specification
    documents call for this font to be used.

    Note: Always assign a scalable font (either TrueType or ATM) to a barcode
    component, otherwise text rotation and other font related functionality may
    not work properly.}

  {@TppCustomBarCode.Orientation

    The Orientation property is used to rotate the bar code in 90 degree
    increments.  You would never want to have a bar code that is not rotated in
    an increment of 90 degrees. The human readable text is also rotated. These
    are the possible values:

    <Table>
    Value	          Meaning
    -------------   -----------
    orLeftToRight	  The bar code is created from Left to Right (this is the default.)
    orRightToLeft  	The bar code is created from Right to Left.
    orTopToBottom  	The bar code is created from Top to Bottom.
    orBottomToTop  	The bar code is created from Bottom to Top.
    </Table>}

  {@TppCustomBarCode.PrintHumanReadable

    This property allows you to set whether the component will output the human
    readable version of the bar code (i.e. the actual letters or numbers).  Bar
    codes like UPC-A and EAN-13 should always have this set to True.  As for the
    other bar codes, it is completely up to you.}

  {@TppCustomBarCode.Visible

    The Visible property determines whether a report component will be printed.

    You can conditionally print a report component by setting the Visible
    property at run-time from an OnPrint event handler.

    You can suppress the printing of an entire band by setting the Visible
    property of each report component to False.  If the PrintHeight property of
    the report band is set to phStatic, then blank white space equivalent to the
    height of the band will be printed.  If PrintHeight is set to phDynamic, no
    page space is used and the next band begins printing. If you want to
    suppress an entire band, it is usually best to use the Visible property of
    the band itself.

    To set the Visible property from the Report Designer, position your mouse
    cursor over the component and click the right mouse button.  The Visible
    option should be near the bottom of the speedmenu.  If it is checked, the
    component will be printed.  Selecting the Visible option from this menu will
    toggle its value.}

  {@TppCustomBarCode.WideBarRatio

    This property effects the narrow-to-wide bar ratio for symbologies that have
    such elements. The value you give this property will be multiplied by the
    value of BarWidth to get the wide bar width.  Most symbologies dictate a
    wide bar ratio in the 2.0 to 3.0 range. You will want a higher WideBarRatio
    if your BarWidth is very small. Most applications call for this ratio to be
    3.0.}

  TppCustomBarCode = class(TppCustomComponent)
  private
    FAddOnCode: String;
    FAlignBarCode: TppAlignHorizontalType;
    FAutoEncode: boolean;
    FAutoSizeFont: Boolean;
    FAutoWidth: Longint;
    FAutoHeight: Longint;
    FBarCodeType: TppBarCodeType;
    FBarColor: TColor;
    FBarWidth: Longint;
    FBearerBars: Boolean;
    FCalcCheckDigit: Boolean;
    FData: String;
    FDrawCommand: TppDrawBarCode;
    FOrientation: TppBarCodeOrientation;                                         
    FBarCodeImage: TBitmap;
    FPrintHumanReadable: Boolean;
    FWideBarRatio: Longint;
    FIsUpdating: Integer;
    FCodeOk: Boolean;

    function  IsValidData(aData: String): Boolean;

    function  GetBarWidth: Single;
    function  GetWideBarRatio: Single;
    procedure SetAddOnCode(Value: string);
    procedure SetAutoEncode(Value : boolean);
    procedure SetAutoSizeFont(Value: Boolean);
    procedure SetBarColor(Value: TColor);
    procedure SetBarWidth(Value: Single);
    procedure SetBearerBars(Value: Boolean);
    procedure SetCalcCheckDigit(Value: Boolean);
    procedure SetData(Value: string);
    procedure SetOrientation(Value: TppBarCodeOrientation);
    procedure SetPrintHumanReadable(Value: Boolean);
    procedure SetWideBarRatio(Value: Single);

    {read/write private properties}
    procedure ReadBarWidth(Reader: TReader);
    procedure WriteBarWidth(Writer: TWriter);
    procedure ReadWideBarRatio(Reader: TReader);
    procedure WriteWideBarRatio(Writer: TWriter);
    procedure SetAlignBarCode(const Value: TppAlignHorizontalType);

  protected

    {override from TComponent}
    procedure DefineProperties(Filer: TFiler); override;

    procedure AdjustBounds; override;
    procedure BoundsChange; override;
    procedure DisplayMessage(aMessage: String); virtual;
    procedure FontChanged(Sender: TObject); override;
    function  GetCaption: String; override;
    function  GetData: String; virtual;
    function  GetDefaultData: string;
    function  GetDefaultPropHint: String; override;
    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
    procedure SetAutoSize(Value: Boolean); override;
    procedure SetBarCodeType(Value: TppBarCodeType); virtual;
    procedure SetCaption(Value: String); override;
    procedure SetFont(Value: TFont); override;

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate;

    property AddOnCode: String read FAddOnCode write SetAddOnCode;
    property AlignBarCode: TppAlignHorizontalType read FAlignBarCode write SetAlignBarCode;
    property AutoEncode: Boolean read FAutoEncode write SetAutoEncode default False;
    property AutoSizeFont: Boolean read FAutoSizeFont write SetAutoSizeFont default True;
    property BarCodeType: TppBarCodeType read FBarCodeType write SetBarCodeType;
    property BarColor: TColor read FBarColor write SetBarColor;
    property BarWidth: Single read GetBarWidth write SetBarWidth stored False;
    property BearerBars: Boolean read FBearerBars write SetBearerBars default False;
    property CalcCheckDigit: Boolean read FCalcCheckDigit write SetCalcCheckDigit default True;
    procedure CalcSize(aDeviceClass: TppDeviceClass; aDrawCommand: TppDrawBarCode);
    property CodeOK: Boolean read FCodeOK;
    property Data: String read GetData write SetData;
    property Orientation: TppBarCodeOrientation read FOrientation write SetOrientation default orLeftToRight;
    property PrintHumanReadable: Boolean read FPrintHumanReadable write SetPrintHumanReadable default True;
    property IsUpdating: Integer read FIsUpdating;
    property WideBarRatio: Single read GetWideBarRatio write SetWideBarRatio;

    property Color;
    property Font;
    property Visible;
  end; {class, TppCustomBarCode}


  {@TppBarCode
    A bar code is a series of lines and spaces which represent data. A
    special set of rules is used to convert data into the lines and spaces
    of a barcode. This set of rules is called a symbology. There are many
    different symbologies, some for general purpose use and some for very 
    specific applications. With TppBarCode, you can create valid bar codes
    for the most popular symbologies. They are:

    <PRE>
    Codabar
    Code 128
    Code 39
    EAN-13
    EAN-8
    FIM A,B,C
    Interleaved 2 of 5
    IntelligentMail
    PostNet
    UPC-A
    UPC-E
    MSI
    </PRE>

    When creating a barcode use the BarCodeType property to specify the
    symbology which should be used to encode the data. Use the Data
    property to specify the data to be encoded.
    <Keywords BarCode>}

  {@TppBarCode.Alignment

    Determines the position of any human-readable text which is part of the
    barcode. These are the possible values:

    <Table>
    Value	           Meaning
    ------------     ------------
    taLeftJustify	   Align text to the left side of the control
    taCenter	       Center text horizontally in the control
    taRightJustify   Align text to the right side of the control

    Note: This setting is ignored for EAN-13 and UPC-A barcodes. These two
    symbologies have special text placement requirements, which must be
    supported in order to create valid barcodes
    </Table>}

  {@TppBarCode.Data

    Run-time and read-only. Contains the data as retrieved from the database,
    which will be encoded.}

  TppBarCode = class(TppCustomBarCode)
    protected
    {  procedure SetBarCodeType(Value: TppBarCodeType); override;}
    public
      constructor Create(AOwner: TComponent); override;

    published
      property Anchors;
      property AddOnCode;
      property AlignBarCode;
      property AutoEncode;
      property AutoSizeFont;
      property BarCodeType;
      property BarColor;
      property BarWidth stored False;
      property BearerBars;
      property Border;
      property CalcCheckDigit;
      property Data;
      property Orientation;
      property PrintHumanReadable;
      property WideBarRatio stored False;

      property Alignment;
      property AutoSize default True;
      property Color;
      property Font;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property ReprintOnOverFlow;
      property Transparent;
      property UserName;
      property Visible;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;

    end; {class, TppBarCode}


  {@TppDBBarCode

    A bar code is a series of lines and spaces which represent data. A
    special set of rules is used to convert data into the lines and spaces
    of a barcode. This set of rules is called a symbology. There are many
    different symbologies, some for general purpose use and some for very
    specific applications. With TppBarCode, you can create valid bar codes
    for the most popular symbologies. They are:

    <PRE>
    Codabar
    Code 128
    Code 39
    EAN-13
    EAN-8
    FIM A,B,C
    Interleaved 2 of 5
    Intelligent Mail
    PostNet
    UPC-A
    UPC-E
    </PRE>

    When creating a barcode use the BarCodeType property to specify the
    symbology which should be used to encode the data. Use the DataPipeline
    and DataField properties to specify the database field which contains
    the data to be encoded.
    <Keywords DBBarcode>}

  {@TppDBBarCode.DataField

    Specifies the field in the DataPipeline which contains the data to be 
    encoded.}

  {@TppDBBarCode.DataPipeline

    The DataPipeline property determines where the component obtains the
    data to encode. Each DataPipeline contains a set of fields. The field
    which will be used by the component is specified via the DataField
    property.}

  TppDBBarCode = class(TppCustomBarCode)
    protected
      function  GetData: String; override;
      procedure SetCaption(Value: String); override;
      procedure SetDataField(const Value: String); override;

    public
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      function  IsDataAware: Boolean; override;

    published
      property Anchors;
      property AddOnCode;
      property AlignBarCode;
      property AutoEncode;
      property AutoSizeFont;
      property BarCodeType;
      property BarColor;
      property BarWidth stored False;
      property BearerBars;
      property Border;
      property CalcCheckDigit;
      property DataField;
      property DataPipeline;
      property Orientation;
      property ParentDataPipeline;
      property PrintHumanReadable;
      property WideBarRatio stored False;

      property Alignment;
      property AutoSize default True;
      property Color;
      property Font;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property ReprintOnOverFlow;
      property Transparent;
      property UserName;
      property Visible;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;

    end; {class, TppDBBarCode}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppBarCodeRTTI }
  TraTppBarCodeRTTI = class(TraTppComponentRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppBarCodeRTTI}


implementation

uses
  ppPrintr, ppPrnDev, ppViewr;


{******************************************************************************
 *
 **  C U S T O M   B A R C O D E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.Create}

constructor TppCustomBarCode.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FIsUpdating := 1;    // set this first, then set it to 0 at the bottom

  FAutoEncode := False;
  FAutoSizeFont := True;
  FAddOnCode := '';
  FBarCodeType := bcCode39;
  FBarCodeImage := nil;
  FData := '';
  FDrawCommand := nil;
  FBarColor := clBlack;
  FBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
  FBearerBars := False;
  FCalcCheckDigit := True;
  Color := clWhite;
  FOrientation := orLeftToRight;
  FPrintHumanReadable := True;
  FWideBarRatio := ppToMMThousandths(3, utInches, pprtHorizontal, nil);

  {assign default properties}
  Font.Name := 'Courier New';
  FData := 'Barcode';

  SetMMWidth(ppToMMThousandths(1.53,  utInches, pprtHorizontal, nil));
  SetMMHeight(ppToMMThousandths(0.5083, utInches, pprtVertical, nil));

  AutoSize := True;

  {need to set this last}
  FCodeOK := True;
  FIsUpdating := 0;

  DrawCommandClass := TppDrawBarCode;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.Destroy}

destructor TppCustomBarCode.Destroy;
begin

  FDrawCommand.Free;

  FBarCodeImage.Free;

  inherited Destroy;
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetDefaultPropHint }

function TppCustomBarCode.GetDefaultPropHint: String;
begin
  Result := ppLoadStr(694); {'Data to be encoded'}
end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.PropertiesToDrawCommand }

procedure TppCustomBarCode.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawBarCode: TppDrawBarCode;


begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawBarCode) then Exit;

  lDrawBarCode := TppDrawBarCode(aDrawCommand);

  {create print object}
  lDrawBarCode.Alignment         := Alignment;
  lDrawBarCode.AlignBarCode      := FAlignBarCode;
  lDrawBarCode.AddOnCode         := FAddOnCode;
  lDrawBarCode.AutoEncode        := FAutoEncode;
  lDrawBarCode.AutoSize          := AutoSize;
  lDrawBarCode.AutoSizeFont      := AutoSizeFont;
  lDrawBarCode.BarCodeType       := FBarCodeType;
  lDrawBarCode.BarColor          := FBarColor;
  lDrawBarCode.BarWidth          := FBarWidth;
  lDrawBarCode.BearerBars        := FBearerBars;
  lDrawBarCode.CalcCheckDigit    := FCalcCheckDigit;
  lDrawBarCode.Color             := Color;
  lDrawBarCode.Data              := GetData;
  lDrawBarCode.CodeOK            := IsValidData(lDrawBarCode.Data);
  lDrawBarCode.Font              := Font;
  lDrawBarCode.Orientation       := FOrientation;
  lDrawBarCode.PrintHumanReadable:= FPrintHumanReadable;
  lDrawBarCode.Transparent       := Transparent;
  lDrawBarCode.WideBarRatio      := WideBarRatio;

  {set size last}
  lDrawBarCode.Left   := PrintPosRect.Left;
  lDrawBarCode.Top    := PrintPosRect.Top;

  {calc height and width - do this last}
  lDrawBarCode.Height := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawBarCode.Width  := PrintPosRect.Right  - PrintPosRect.Left;

  //lDrawBarCode.CalcDrawCommandSize(GetPrinter);

end; {procedure, PropertiesToDrawCommand}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.BeginUpdate }

procedure TppCustomBarCode.BeginUpdate;
begin
  Inc(FIsUpdating);
  
end; {procedure, BeginUpdate}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.EndUpdate }

procedure TppCustomBarCode.EndUpdate;
begin

  if FIsUpdating > 0 then
    Dec(FIsUpdating);

  if FIsUpdating = 0 then
    if AutoSize then
      AdjustBounds
    else
      InvalidateDesignControl;

end; {procedure, EndUpdate}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.CalcSize }

procedure TppCustomBarCode.CalcSize(aDeviceClass: TppDeviceClass; aDrawCommand: TppDrawBarCode);
var
  lPosRect: TppRect;
  lCanvas: TCanvas;
  lPrinter: TppPrinter;
  lBitmap: TBitmap;
begin

  {set print position}
  lPosRect.Left   := 0;
  lPosRect.Top    := 0;
  lPosRect.Bottom := mmHeight;
  lPosRect.Right  := mmWidth;

  PrintPosRect := lPosRect;

  {assign draw command properties}
  PropertiesToDrawCommand(aDrawCommand);

  aDrawCommand.DrawLeft   := 0;
  aDrawCommand.DrawTop    := 0;
  aDrawCommand.DrawRight  := spWidth;
  aDrawCommand.DrawBottom := spHeight;

  if (aDeviceClass.InheritsFrom(TppScreenDevice)) then
    lPrinter := nil
  else
    lPrinter := GetPrinter;

  lBitmap := nil;

  try
    {calc size for either the screen or printer}
    if lPrinter = nil then
      begin
        lBitmap := TBitmap.Create;
        lCanvas := lBitmap.Canvas;
      end
    else
      lCanvas := lPrinter.Canvas;

    {calc barcode size}
    aDrawCommand.CalcBarCodeSize(lCanvas);

  finally
    lBitmap.Free;

  end;

end;

{------------------------------------------------------------------------------}
{ TppCustomBarCode.AdjustBounds }

procedure TppCustomBarCode.AdjustBounds;
var
  lPrinter: TppPrinter;
  llPortraitWidth: Longint;
  llPortraitHeight: Longint;

begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FIsUpdating > 0) then Exit;

  if AutoSize then
    begin

      if FDrawCommand = nil then
        FDrawCommand := TppDrawBarCode.Create(nil);

      {calc actual size required for the printer}
      CalcSize(TppPrinterDevice, FDrawCommand);


      {adjust control size}
     if FDrawCommand.CodeOk then
        begin

          {convert size from printer to screen}
          lPrinter := GetPrinter;
          llPortraitWidth  := ppToMMThousandths(FDrawCommand.PortraitWidth, utPrinterPixels, pprtHorizontal, lPrinter);
          llPortraitHeight := ppToMMThousandths(FDrawCommand.PortraitHeight, utPrinterPixels, pprtVertical, lPrinter);

          if FOrientation in [orLeftToRight, orRightToLeft] then
            begin
              FAutoWidth  :=  llPortraitWidth;
              FAutoHeight :=  llPortraitHeight;
            end
          else
            begin
              FAutoWidth  :=  llPortraitHeight;
              FAutoHeight :=  llPortraitWidth;
            end;

          mmSetBounds(mmLeft, mmTop, FAutoWidth, FAutoHeight);

        end;

  end;
  
  InvalidateDesignControl;

end; {procedure, AdjustBounds}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.BoundsChange}

procedure TppCustomBarCode.BoundsChange;
begin


{  if AutoSize and ((FAutoWidth <> mmWidth) or (FAutoHeight <> mmHeight)) and
     not (pppcPasting in DesignState) then
    AdjustBounds
  else }
    inherited BoundsChange;
    
end; {procedure, BoundsChange}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.FontChanged }

procedure TppCustomBarCode.FontChanged(Sender: TObject);
begin
  if BarColor <> Font.Color then
    SetBarColor(Font.Color);

  inherited FontChanged(Sender);

end; {FontChanged}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.DisplayMessage }

procedure TppCustomBarCode.DisplayMessage(aMessage: String);
begin
  if (csLoading in ComponentState) or (csReading in ComponentState) then Exit;

  if Printing then Exit;

  MessageDlg(aMessage, mtInformation, [mbOK], 0);


end; {procedure, DisplayMessage}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetData }

function TppCustomBarCode.GetData: string;
begin
  Result := FData;
end; {function, GetData}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetDefaultData }

function TppCustomBarCode.GetDefaultData: string;
begin

  case FBarCodeType of

      bcCode39 :

        if IsDataAware then
          Result := 'DBBarCode'
        else
          Result := 'BarCode';

      bcCode128 : Result := Char(210) + '1234' + Char(205) + ' abcd';

      bcEAN_13  : Result := '0012345678905';

      bcEAN_8 : Result := '20123451';

      bcInt2of5 : 
        if FCalcCheckDigit then
          Result := '0123456789'
        else
          Result := '01234567';

      bcIntelligentMail:  Result := '0123456709498765432101234567891';

      bcPostNet : Result := '012345678';

      bcUPC_A :

        if FCalcCheckDigit then
          Result := '01234567890'
        else
          Result := '012345678905';

      bcUPC_E :
        if FCalcCheckDigit then
          Result := '012345'
        else
          Result := '0123456';

      bcFIM :
        Result := 'A';

      bcCodabar :
        Result := 'A01234B';

      bcMSI :
        Result := '0139725';

      else
        Result := ''

    end; {case }

end; {function, GetDefaultData}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetAddOnCode }

procedure TppCustomBarCode.SetAddOnCode(Value: string);
begin

  if (FAddOnCode = Value) then Exit;

  {message: 'Only UPC and EAN barcodes can have add-on codes'}
  if (Value <> '') and (not (FBarCodeType in cPOSBarCodes)) then
    DisplayMessage(ppLoadStr(423))

  {message: 'Add-on codes must be either 2 or 5 digits'}
  else if not (Length(Value) in [0,2,5]) then
    DisplayMessage(ppLoadStr(424))

  else
    begin
      BeforePropertyChange('AddOnCode');
      FAddOnCode := Value;
      AdjustBounds;
      PropertyChange;
    end;

end; {procedure, SetAddOnCode}

procedure TppCustomBarCode.SetAlignBarCode(const Value: TppAlignHorizontalType);
begin
  if (FAlignBarCode = Value) then Exit;

  BeforePropertyChange('AlignBarcode');

  FAlignBarCode := Value;

  AdjustBounds;

  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetAutoEncode }

procedure TppCustomBarCode.SetAutoEncode(Value : boolean);
begin
  if Value = FAutoEncode then Exit;
{ this condition needs to be here, because AutoEncode is by default FALSE, but we need
  it to be TRUE if the code being loaded is Code 128 without control characters }
  if (csReading in ComponentState)  or (csLoading in ComponentState) then
  begin
    FAutoEncode := Value;
    Exit;
  end;
  if (Value = TRUE) and (FBarCodeType <> bcCode128) then
  begin
    // NOTE:  Create message here!
    // Only Code 128 can be auto-encoded.
  end
  else
  begin
    BeforePropertyChange('AutoEncode');
    FAutoEncode := Value;
    AdjustBounds;
    PropertyChange;
  end;
end; {procedure, SetAutoEncode}

{@TppCustomBarCode.SetAutoSize

 The AutoSize property will automatically size the bar code to certain
 proportions based a number of calculations.  The first factor is the
 BarWidth property; the width of the component will be the BarWidth property
 times the actual number of bars and spaces. The height of the component will
 be based on the standard accepted height to width ratio for each symbology.

 If you set AutoSize to false, you can size the component as you see fit.
 However, there is no guarantee that the resulting code will fit in the space
 you allot.}

procedure TppCustomBarCode.SetAutoSize(Value: Boolean);
begin
  // GF!
  // Change message to:  Postnet and FIM barcodes...
  {message: 'PostNet barcodes must have AutoSize = True'}
  if (Value = False) and (FBarCodeType in [bcIntelligentMail, bcPostNet, bcFIM]) then
    DisplayMessage(ppLoadStr(425))
  else
    inherited SetAutoSize(Value);

end; {procedure, SetAutoSize}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetAutoSizeFont }

procedure TppCustomBarCode.SetAutoSizeFont(Value: Boolean);
begin
  if Value = FAutoSizeFont then Exit;

  // GF!
// Note:  The following message should now read "EAN and UPC..."

  {message: 'EAN-13 and UPC-A barcodes must have AutoSizeFont = True'}
  if (Value = False) and (FBarCodeType in cPOSBarCodes) then
    DisplayMessage(ppLoadStr(426))

  else
    begin
      BeforePropertyChange('AutoSizeFont');
      FAutoSizeFont := Value;
      AdjustBounds;
      PropertyChange;
    end;

end; {procedure, SetAutoSizeFont}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetBarCodeType }

procedure TppCustomBarCode.SetBarCodeType(Value: TppBarCodeType);
begin

  if (Value = FBarCodeType) then Exit;

  BeforePropertyChange('BarCodeType');
  BeginUpdate;

  try
    FBarCodeType := Value;

    if (csReading in ComponentState)  or (csLoading in ComponentState) then Exit;

    FData   := GetDefaultData;

    FCodeOk := True;

    if FBarCodeType in [bcIntelligentMail, bcPostNet, bcFIM] then
      begin

        AutoSize := True;
        PrintHumanReadable := False;

      end

    else if FBarCodeType in cPOSBarCodes then
      FAutoSizeFont := True

    else if FBarCodeType = bcCode128 then
      AutoEncode := True;



    case FBarCodeType of
      bcCode128         : FBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
      bcCode39, bcMSI   : FBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
      bcEAN_13, bcUPC_A,
      bcEAN_8, bcUPC_E : FBarWidth := ppToMMThousandths(0.013, utInches, pprtHorizontal, nil);
      bcInt2of5         : FBarWidth := ppToMMThousandths(0.015, utInches, pprtHorizontal, nil);
      bcIntelligentMail,
      bcPostnet         : FBarWidth := ppToMMThousandths(0.020, utInches, pprtHorizontal, nil);
      bcFIM             : FBarWidth := ppToMMThousandths(0.031 {1/32"}, utInches, pprtHorizontal, nil);
      bcCodabar         : FBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
    end;


    AdjustBounds;

  finally

    EndUpdate;
    PropertyChange;

  end;

end; {procedure, SetBarCodeType}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetBarColor }

procedure TppCustomBarCode.SetBarColor(Value: TColor);

begin

  if (FBarColor = Value) then Exit;

  BeforePropertyChange('BarColor');

  FBarColor := Value;

  if Font.Color <> FBarColor then
    Font.Color := FBarColor;
    
  InvalidateDesignControl;
  PropertyChange;


end; {procedure, SetBarColor}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetBarWidth }

function TppCustomBarCode.GetBarWidth: Single;
begin
   Result := FromMMThousandths(FBarWidth, Units, pprtHorizontal);
end; {function, GetBarWidth}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetCaption }

function TppCustomBarCode.GetCaption: String;
begin

  Result := GetData;

end; {function GetCaption}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetBarWidth }

procedure TppCustomBarCode.SetBarWidth(Value: Single);
var
  llValue: Longint;
  llMin, llMax: Longint;
  lfMin, lfMax: Single;
  lsMessage: String;

begin


  lsMessage := '';
  llValue :=  ToMMThousandths(Value, Units, pprtHorizontal);

  if (llValue = FBarWidth) then Exit;

  if not (csLoading in ComponentState) then
    begin

      if ppInInches(llValue) < 0.004 then
        begin
          {message: 'BarWidth must be at least 0.004'}
          llMin     := ToMMThousandths(0.004, utInches, pprtHorizontal);
          lfMin     := FromMMThousandths(llMin, Units, pprtHorizontal);
          lsMessage := ppLoadStr(427);
          lsMessage := ppSetMessageParameters(lsMessage);
          lsMessage := Format(lsMessage, [FloatToStr(lfMin)]);
        end

      else if ppInInches(llValue) > 0.10 then
        begin
          {message: 'BarWidth cannot exceeed 0.10'}
          llMax     := ToMMThousandths(0.10, utInches, pprtHorizontal);
          lfMax     := FromMMThousandths(llMax, Units, pprtHorizontal);
          lsMessage := ppLoadStr(428);
          lsMessage := ppSetMessageParameters(lsMessage);
          lsMessage := Format(lsMessage, [FloatToStr(lfMax)]);
        end

    end;

  if lsMessage <> '' then
    DisplayMessage(lsMessage)
  else
    begin
      BeforePropertyChange('BarWidth');
      FBarWidth := llValue;
      AdjustBounds;
      PropertyChange;

    end;

end; {procedure, SetBarWidth}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetBearerBars }

procedure TppCustomBarCode.SetBearerBars(Value: Boolean);
begin

  if (FBearerBars = Value)  then Exit;

  {message: 'Only Interleaved 2 of 5 barcodes can have bearer bars'}
  if (Value = True) and (FBarCodeType <> bcInt2of5) then
    DisplayMessage(ppLoadStr(429))
  else
    begin
      BeforePropertyChange('BearerBars');
      FBearerBars := Value;
      AdjustBounds;
      PropertyChange;

    end;

end; {procedure, SetBearerBars}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetCalcCheckDigit }

procedure TppCustomBarCode.SetCalcCheckDigit(Value: Boolean);
begin

  if (Value = FCalcCheckDigit) then Exit;

  BeforePropertyChange('CalcCheckDigit');

  FCalcCheckDigit := Value;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  FCodeOk := IsValidData(FData);

  AdjustBounds;
  PropertyChange;

end; {procedure, SetCalcCheckDigit}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetCaption }

procedure TppCustomBarCode.SetCaption(Value: string);
begin
  SetData(Value);
end;  {procedure, SetCaption}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetData }

procedure TppCustomBarCode.SetData(Value: string);
begin

  if (FData = Value) then Exit;

  BeforePropertyChange('Data');

  FData := Value;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  FCodeOk := IsValidData(Value);

  AdjustBounds;

  if not IsDataAware then
    PropertyChange;

end; {procedure, SetData}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetFont }

procedure TppCustomBarCode.SetFont(Value: TFont);
begin

  if (pppcCreating in DesignState) then Exit;

  inherited SetFont(Value);

end; {procedure, SetFont}


{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetOrientation }

procedure TppCustomBarCode.SetOrientation(Value: TppBarCodeOrientation);
begin

  if (FOrientation = Value) then Exit;

  BeforePropertyChange('Orientation');

  FOrientation := Value;

  AdjustBounds;

  PropertyChange;

end; {procedure, SetOrientation}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetPrintHumanReadable }

procedure TppCustomBarCode.SetPrintHumanReadable(Value: Boolean);
begin
  if (FPrintHumanReadable = Value) then Exit;

  BeforePropertyChange('PrintHumanReadable');

  FPrintHumanReadable := Value;

  AdjustBounds;

  PropertyChange;

end; {procedure, SetPrintHumanReadable}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetWideBarRatio }

function TppCustomBarCode.GetWideBarRatio: Single;
begin
  {hard-code to inches, since this is not a physical measurement, we're just
   storing it in thousandths of mm  so that it can be successfully streamed in D1}
  Result := FromMMThousandths(FWideBarRatio, utInches, pprtHorizontal);
end; {function, GetWideBarRatio}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.SetWideBarRatio }

procedure TppCustomBarCode.SetWideBarRatio(Value: Single);
begin

  if (WideBarRatio = Value) or (Value <= 0) then Exit;

  BeforePropertyChange('WideBarRatio');

  FWideBarRatio := ToMMThousandths(Value, utInches, pprtHorizontal);

  AdjustBounds;

  PropertyChange;

end; {procedure, SetWideBarRatio}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.IsValidData }

function TppCustomBarCode.IsValidData(aData: String): Boolean;
  const
    AlphaNumeric: TppAnsiCharSet = ['A'..'Z','a'..'z','0'..'9',' ','$','%','+','-','.','/'];
    CodabarSet : TppAnsiCharSet = ['A'..'D', 'a'..'d','0'..'9', '-', '$', ':', '/', '.', '+'];

  var
    lsMessage: String;
    liChar: Integer;
    lTestSet:  TppAnsiCharSet;

    function IsNumeric(aString: string; aDashOk: Boolean): Boolean;

    var
      liChar  : Integer;
      AcceptSet: TppAnsiCharSet;

    begin
      Result := True;
      AcceptSet := ['0'..'9'];
      if aDashOk then
        AcceptSet := AcceptSet + ['-'];
      for liChar := 1 to Length(aString) do
        if not ppCharInSet(aString[liChar], AcceptSet) then
          Result := False;
    end;

    function CountDashes(aString: string): Integer;

    var
      liChar: Integer;

    begin
      Result := 0;
      for liChar := 1 to Length(aString) do
        if aString[liChar] = '-' then
          Inc(Result);
    end;

  function MatchesSet(aString: string; aSet: TppAnsiCharSet): Boolean;
  var
    liChar  : Integer;

  begin
    Result := True;
    liChar := 1;
    while (liChar <= Length(aString)) and (Result) do
    begin
      if not ppCharInSet(aString[liChar], aSet) then
        Result := False;
      Inc(liChar);
    end;

  end;


  begin

    Result := False;

    lsMessage := '';

    if aData = '' then Exit;


    case FBarCodeType of
      bcCode39 :
        begin
          {message: 'Code 39 barcodes can only contain "A"-"Z", "0"-"9", "$", "%", "+", "-", ".", "/" or " "'}
          {note: first and last character may be '*'}
          lTestSet :=  AlphaNumeric + ['*'];
          if not ( ppCharInSet(aData[1], lTestSet) and ppCharInSet(aData[Length(aData)], lTestSet) and
                 (MatchesSet(Copy(aData, 2, Length(aData)-2), AlphaNumeric)) ) then
            begin
              // strings are in ppIDE.res
              lsMessage := ppLoadStr(430);

              // if string cannot be loaded from res file, return hard coded string
              if lsMessage = '' then
                lsMessage := 'Code 39 barcodes can only contain "A"-"Z", "0"-"9", "$", "%", "+", "-", ".", "/" or " "';
            end;
        end;

      bcEAN_13 :
        begin
          {message: 'EAN-13 barcodes must be 12 digits (13 with check digit)'}
          if (Length(aData) < 12) or (Length(aData) > 13) then
            begin
              lsMessage := ppLoadStr(431);
              if lsMessage = '' then
                lsMessage := 'EAN-13 barcodes must be 12 digits (13 with check digit)';
            end

          {message: 'EAN-13 barcodes must be 13 digits including the check digit'}
          else if (Length(aData) = 12) and (FCalcCheckDigit = False) then
            begin
              lsMessage := ppLoadStr(432);
              if lsMessage = '' then
                lsMessage := 'EAN-13 barcodes must be 13 digits including the check digit';
            end

          {message: 'EAN-13 barcodes must be numeric'}
          else if not IsNumeric(aData, False) then
            begin
              lsMessage := ppLoadStr(433);
              if lsMessage = '' then
                lsMessage := 'EAN-13 barcodes must be numeric';
            end;
        end;

      bcEAN_8 :
        begin
          {message: 'EAN-8 barcodes must be 7 digits (8 with check digit)'}
          if (Length(aData) < 7) or (Length(aData) > 8) then
            begin
              lsMessage := ppLoadStr(645);
              if lsMessage = '' then
                lsMessage := 'EAN-8 barcodes must be 7 digits (8 with check digit)';
            end

          {message: 'EAN-8 barcodes must be 8 digits including the check digit'}
          else if (Length(aData) = 7) and (FCalcCheckDigit = False) then
            begin
              lsMessage := ppLoadStr(646);
              if lsMessage = '' then
                lsMessage := 'EAN-8 barcodes must be 8 digits including the check digit';
            end

          {message: 'EAN-8 barcodes must be numeric'}
          else if not IsNumeric(aData, False) then
            begin
              lsMessage := ppLoadStr(647);
              if lsMessage = '' then
                lsMessage := 'EAN-8 barcodes must be numeric';
            end;

        end;

      bcInt2of5 :
        begin
          {message: 'Interleaved 2 of 5 barcodes must be numeric'}
          if not IsNumeric(aData,False) then
            begin
              lsMessage := ppLoadStr(434);
              if lsMessage = '' then
                lsMessage := 'Interleaved 2 of 5 barcodes must be numeric';

            end

          else if Odd(Length(aData)) and not FCalcCheckDigit then
            begin
              {message: 'Interleaved 2 of 5 must have an even number of digits'}
              lsMessage := ppLoadStr(435);
              if lsMessage = '' then
                lsMessage := 'Interleaved 2 of 5 must have an even number of digits';

            end;
        end;

      bcIntelligentMail, bcPostNet :
      begin
        {message: 'PostNet barcodes must be numeric'}
        if not IsNumeric(aData,True) then
          begin
            lsMessage := ppLoadStr(436);
            if lsMessage = '' then
              lsMessage := 'PostNet barcodes must be numeric';
          end;
      end;

      bcUPC_A :
        begin
          {message: 'UPC-A barcodes must be 11 digits (12 with check digit)'}
          if (Length(aData) < 11) or (Length(aData) > 12) then
            begin
              lsMessage := ppLoadStr(438);
              if lsMessage = '' then
                lsMessage := 'UPC-A barcodes must be 11 digits (12 with check digit)';
            end

          {message: 'UPC-A barcodes must be 12 digits including the check digit'}
          else if (Length(aData) = 11) and (FCalcCheckDigit = False) then
            begin
              lsMessage := ppLoadStr(439);
              if lsMessage = '' then
                lsMessage := 'UPC-A barcodes must be 12 digits including the check digit';
            end

          {message: 'UPC-A barcodes must be numeric'}
          else if not IsNumeric(aData,False) then
            begin
              lsMessage := ppLoadStr(440);
              if lsMessage = '' then
                lsMessage := 'UPC-A barcodes must be numeric';
            end;

        end;

      bcUPC_E :
        begin
          {message: 'UPC-E barcodes must be 6 digits (7 with check digit)'}
          if (Length(aData) < 6) or (Length(aData) > 7) then
            begin
              lsMessage := ppLoadStr(648);
              if lsMessage = '' then
                lsMessage := 'UPC-E barcodes must be 6 digits (7 with check digit)';
            end


          {message: 'UPC-E barcodes must be 7 digits including the check digit'}
          else if (Length(aData) = 6) and (FCalcCheckDigit = False) then
            begin
              lsMessage := ppLoadStr(649);
              if lsMessage = '' then
                lsMessage := 'UPC-E barcodes must be 7 digits including the check digit';
            end

          {message: 'UPC-E barcodes must be numeric'}
          else if not IsNumeric(aData,False) then
            begin
              lsMessage := ppLoadStr(650);
              if lsMessage = '' then
                lsMessage := 'UPC-E barcodes must be numeric';
            end;

        end;

      bcFIM :
        begin
          {message: 'The only valid choices for FIM codes are A, B, or C'}
          if (Length(aData) <> 1) or (not ppCharInSet(Uppercase(aData)[1], ['A','B','C']))  then
            begin
              lsMessage := ppLoadStr(651);
              if lsMessage = '' then
                lsMessage := 'The only valid choices for FIM codes are A, B, or C';
            end;
        end;

      bcCodabar :
        begin
          {message: 'Codabar can only encode 0-9, A, B, C, D, -, $, :, /, ., and +'}
          if not MatchesSet(aData, CodabarSet) then
            begin
              lsMessage := ppLoadStr(652);
              if lsMessage = '' then
                lsMessage := 'Codabar can only encode 0-9, A, B, C, D, -, $, :, /, ., and +';
            end

          {message: 'A Codabar symbol must start and end with A, B, C, or D.'}
          else if not (ppCharInSet(aData[1], ['A'..'D','a'..'d']) and ppCharInSet(aData[Length(aData)], ['A'..'D','a'..'d'])) then
            begin
              lsMessage := ppLoadStr(653);
              if lsMessage = '' then
                lsMessage := 'A Codabar symbol must start and end with A, B, C, or D';
            end

          else
            begin
              liChar := 2;

              while (liChar <= Length(aData) - 1) and (lsMessage = '') do
                begin
                  {message: 'Codabar can only encode 0-9, A, B, C, D, -, $, :, /, ., and +'
                            'They cannot appear anywhere in the middle of the data.'}
                  if ppCharInSet(aData[liChar], ['A'..'D','a'..'d']) then
                    begin
                      lsMessage := ppLoadStr(654) + ' '+ ppLoadStr(655);
                      if lsMessage = '' then
                        lsMessage := 'Codabar can only encode 0-9, A, B, C, D, -, $, :, /, .';
                    end
                  else
                    Inc(liChar);
                end;
            end;

        end;
      bcMSI:
        begin
             {message: MSI barcodes can only contain nummerics
                       the message should be in the language resource }
                //** translation : MSI Barcodes can only encode 0-9 **//
             if not IsNumeric(aData,False) then
               begin
                lsMessage := 'MSI Barcodes must be numeric';
               end;
        end;

    end;

    Result := (lsMessage = '');

    if not Result then
      DisplayMessage(lsMessage);


end; {procedure, IsValidData}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.DefineProperties}

procedure TppCustomBarCode.DefineProperties(Filer: TFiler);
var
  lAncestor: TppCustomBarCode;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppCustomBarCode) then
    lAncestor := TppCustomBarCode(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('mmBarWidth', ReadBarWidth, WriteBarWidth, FBarWidth <> lAncestor.FBarWidth);
      Filer.DefineProperty('mmWideBarRatio', ReadWideBarRatio, WriteWideBarRatio, FWideBarRatio <> lAncestor.FWideBarRatio);
    end
  else
    begin
      Filer.DefineProperty('mmBarWidth', ReadBarWidth, WriteBarWidth, True);
      Filer.DefineProperty('mmWideBarRatio', ReadWideBarRatio, WriteWideBarRatio, True);
    end;

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.ReadBarWidth }

procedure TppCustomBarCode.ReadBarWidth(Reader: TReader);
begin
  FBarWidth := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppCustomBarCode.WriteBarWidth}

procedure TppCustomBarCode.WriteBarWidth(Writer: TWriter);
begin
  Writer.WriteInteger(FBarWidth);
end;

{------------------------------------------------------------------------------}
{ TppCustomBarCode.ReadWideBarRatio }

procedure TppCustomBarCode.ReadWideBarRatio(Reader: TReader);
begin
  FWideBarRatio := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppCustomBarCode.WriteWideBarRatio}

procedure TppCustomBarCode.WriteWideBarRatio(Writer: TWriter);
begin
  Writer.WriteInteger(FWideBarRatio);
end;

{******************************************************************************
 *
 **  B A R C O D E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBarCode.Create }

constructor TppBarCode.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  DefaultPropName := 'Data';
  DefaultPropEditType := etEdit;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBarCode.SetBarCodeType }

{procedure TppBarCode.SetBarCodeType(Value: TppBarCodeType);
begin

  inherited SetBarCodeType(Value);

  if (FBarCodeType = bcFIM) then
    DefaultPropEditType := etValueList
  else
    DefaultPropEditType := etEdit;

end; {procedure, SetBarCodeType}


{------------------------------------------------------------------------------}
{ TppBarCode.GetDefaultPropEnumNames }

{procedure TppBarCode.GetDefaultPropEnumNames(aList: TStrings);
begin




end; {procedure, GetDefaultPropEnumNames}



{******************************************************************************
 *
 **  D B   B A R C O D E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBBarCode.Notify }

procedure TppDBBarCode.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation in [ppopDataChange, ppopRemove]) and (pppcDesigning in DesignState) and not(Printing) then
    Data := GetData;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDBBarCode.IsDataAware }

function TppDBBarCode.IsDataAware: Boolean;
begin
  Result := True;
end; {function, IsDataAware}


{------------------------------------------------------------------------------}
{ TppDBBarCode.SetCaption }

procedure TppDBBarCode.SetCaption(Value: String);
begin

  {this will take of adjust bounds etc.}
  SetData(GetData);

end; {procedure, SetCaption}


{------------------------------------------------------------------------------}
{ TppDBBarCode.SetDataField }

procedure TppDBBarCode.SetDataField(const Value: String);
begin

  inherited SetDataField(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  {this will set caption}
  Notify(DataPipeline, ppopDataChange);

  PropertyChange;


end; {procedure, SetDataField}

{@TppDBBarCode.GetData

 Run-time and read-only. Contains the data as retrieved from the database,
 which will be encoded.}

function TppDBBarCode.GetData: string;
var
  lsText: String;
  lDataType: TppDataType;
  lValue: Variant;

begin

  if CheckForPipelineData then
    begin

      try
        lDataType := DataPipeline.GetFieldDataType(DataField);
      except
        lDataType := dtString;
      end;

      try

        lValue := DataPipeline.GetFieldValue(DataField);

        if (lValue <> Null) then
          lsText := ppFormat('', lDataType, lValue)
        else
          lsText := '';

      except on EDataError    do
        lsText := '';
             on EConvertError do
        lsText := '';
             on EVariantError do
        lsText := '';

      end; {try, except }

    end {get data }


  else if (Printing) then
    lsText := ''

  else {must be designing}

    begin

      {display default data}
      lsText := GetDefaultData;

    end;

  Result := lsText;

end; {function, GetData}
{******************************************************************************
 *
 *
 *
 ** R T T I
 *
 *
 *
{******************************************************************************}

{******************************************************************************
 *
 ** B A R C O D E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppBarCodeRTTI.RefClass }

class function TraTppBarCodeRTTI.RefClass: TClass;
begin
  Result := TppBarCode;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppBarCodeRTTI.GetPropList }

class procedure TraTppBarCodeRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppBarCodeRTTI.GetPropRec }

class function TraTppBarCodeRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AddOnCode') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'AutoEncode') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'AutoSizeFont') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'BarCodeType') = 0) then
    EnumPropToRec(aPropName, 'TppBarCodeType', False, aPropRec)

  else if (CompareText(aPropName, 'BarColor') = 0) then
    EnumPropToRec(aPropName, 'TColor', False, aPropRec)

  else if (CompareText(aPropName, 'BarWidth') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'BearerBars') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'CalcCheckDigit') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Data') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'Orientation') = 0) then
    EnumPropToRec(aPropName, 'TppBarCodeOrientation', False, aPropRec)

  else if (CompareText(aPropName, 'PrintHumanReadable') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'WideBarRatio') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppBarCodeRTTI.GetPropValue }

class function TraTppBarCodeRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AddOnCode') = 0) then
    String(aValue) := TppBarCode(aObject).AddOnCode

  else if (CompareText(aPropName, 'AutoEncode') = 0) then
    Boolean(aValue) := TppBarCode(aObject).AutoEncode

  else if (CompareText(aPropName, 'AutoSizeFont') = 0) then
    Boolean(aValue) := TppBarCode(aObject).AutoSizeFont

  else if (CompareText(aPropName, 'BarCodeType') = 0) then
    TppBarCodeType(aValue) := TppBarCode(aObject).BarCodeType

  else if (CompareText(aPropName, 'BarColor') = 0) then
    Integer(aValue) := Ord(TppBarCode(aObject).BarColor)

  else if (CompareText(aPropName, 'BarWidth') = 0) then
    Single(aValue) := TppBarCode(aObject).BarWidth

  else if (CompareText(aPropName, 'BearerBars') = 0) then
    Boolean(aValue) := TppBarCode(aObject).BearerBars

  else if (CompareText(aPropName, 'CalcCheckDigit') = 0) then
    Boolean(aValue) := TppBarCode(aObject).CalcCheckDigit

  else if (CompareText(aPropName, 'Data') = 0) then
    String(aValue) := TppBarCode(aObject).Data

  else if (CompareText(aPropName, 'PrintHumanReadable') = 0) then
    Boolean(aValue) := TppBarCode(aObject).PrintHumanReadable

  else if (CompareText(aPropName, 'WideBarRatio') = 0) then
    Single(aValue) := TppBarCode(aObject).WideBarRatio

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppBarCodeRTTI.SetPropValue }

class function TraTppBarCodeRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AddOnCode') = 0) then
    TppBarCode(aObject).AddOnCode := String(aValue)

  else if (CompareText(aPropName, 'AutoEncode') = 0) then
    TppBarCode(aObject).AutoEncode := Boolean(aValue)

  else if (CompareText(aPropName, 'AutoSizeFont') = 0) then
    TppBarCode(aObject).AutoSizeFont := Boolean(aValue)

  else if (CompareText(aPropName, 'BarCodeType') = 0) then
    TppBarCode(aObject).BarCodeType := TppBarCodeType(aValue)

  else if (CompareText(aPropName, 'BarColor') = 0) then
    TppBarCode(aObject).BarColor := TColor(aValue)

  else if (CompareText(aPropName, 'BarWidth') = 0) then
    TppBarCode(aObject).BarWidth := Single(aValue)

  else if (CompareText(aPropName, 'BearerBars') = 0) then
    TppBarCode(aObject).BearerBars := Boolean(aValue)

  else if (CompareText(aPropName, 'CalcCheckDigit') = 0) then
    TppBarCode(aObject).CalcCheckDigit := Boolean(aValue)

  else if (CompareText(aPropName, 'Data') = 0) then
    TppBarCode(aObject).Data := String(aValue)

  else if (CompareText(aPropName, 'PrintHumanReadable') = 0) then
    TppBarCode(aObject).PrintHumanReadable := Boolean(aValue)

  else if (CompareText(aPropName, 'WideBarRatio') = 0) then
    TppBarCode(aObject).WideBarRatio := Single(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  raRegisterRTTI(TraTppBarCodeRTTI);

finalization

  raUnRegisterRTTI(TraTppBarCodeRTTI);

end.
