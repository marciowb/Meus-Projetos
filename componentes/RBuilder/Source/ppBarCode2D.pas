{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppBarCode2D;

interface

uses
  Classes,
  Graphics,
  StdCtrls,

  ppClass,
  ppComm,
  ppCtrls,
  ppDevice,
  ppEnum,
  ppDB,
  ppTypes,

  ppBarCode2DDrawCmd,
  ppSt2dBarC;

type


  {@TppCustom2DBarCode

    Base class for two-dimensional barcode components. Defines common
    properties used by stacked and matrix symbologies. Not all barcode symbologies
    will use all of the fields. For example, RelativeBarHeight only has meaning
    for stacked symbologies.

    Descendants are Tpp2DBarCode and TppDB2DBarCode. }

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

  {@TppCustom2DBarCode.AutoScale

    Controls whether or not the barcode is automatically sized.

    When this property is True, the barcode will calculate the size of the
    barcode based on the pixels per millimeter of the canvas that the barcode is
    being painted on. The normal size of a MaxiCode barcode is 25.50mm by
    24.37mm, about one inch square.

    If the scaling of the component needs be done manually, setting AutoScale to
    False and either specifying BarHeight and BarWidth or HorPixelsPerMM and
    VerPixelsPerMM will handle it. BarHeight and BarWidth are used to specify
    the size of a single hexagonal element in pixels. HorPixelsPerMM and
    VerPixelsPerMM are used to manually specify the number of pixels per
    millimeter. When the barcode is manually scaled, the values for BarHeight
    and BarWidth are checked first. If these are non-zero, they will be used to
    calculate the size of an element. If they are zero, HorPixelsPerMM and
    VerPixelsPerMM will be used. The checks are done independently. For example,
    BarHeight can be used with HorPixelsPerMM. }

  {@TppCustom2DBarCode.BackgroundColor

    Sets the background color for the barcode. }

  {@TppCustom2DBarCode.BarCodeType

    Allows selection of the desired bar code format. }

  {@TppCustom2DBarCode.BarHeight

    Specifies the height of a single element.

    In PDF417, if RelativeBarHeight is False, this value will be used to
    determine the bar height in pixels.

    In MaxiCode, this will value will be used to calculate the size of a hexagon
    when AutoScale is False. }

  {@TppCustom2DBarCode.BarWidth

    Sets the size of the smallest element in the barcode.

    For stacked bar symbologies like PDF417, BarWidth is used to indicate the
    width of the narrowest bar in the code.

    For MaxiCode, this value will be used to calculate the size of a hexagon
    when AutoScale is False. }

  {@TppCustom2DBarCode.CaptionLayout

    Positions the caption in relation to the barcode.

    The CaptionLayout property indicates where the caption will be position in
    relation to the barcode.

    Caution: A CaptionLayout of tlCenter will center the caption in the barcode.
    This may lead to an unusable barcode. }

  {@TppCustom2DBarCode.CarrierCountryCode

    Specifies the country code to be used in mode 2 and mode 3 barcodes.

    Country codes are three digit numeric values in acccordance with ISO 3166.
    The current list of country codes can be found on
    http://www.din.de/gremien/nas/nabd/iso3166ma/. }

  {@TppCustom2DBarCode.CarrierPostalCode

    Specifies the postal code to be used in mode 2 (numeric postal code) and
    mode 3 (alphanumeric postal codes) barcodes.

    Postal codes can either be nine numeric digits or six alphanumeric
    characters. Alphanumeric postal codes longer than six digits will be
    truncated.

    If the postal code is numeric and the barcode's mode is mode 3
    (alphanumeric) the barcode's mode will be changed automatically to numeric.
    If the postal code is alphanumeric and the barcode's mode is 2 (numeric),
    the mode will be changed automatically to alphanumeric. }

  {@TppCustom2DBarCode.CarrierServiceClass

    Specifies the service class used in mode 2 and mode 3 barcodes.

    The service class is a three digit numeric value that is determined by the
    carrier. }

  {@TppCustom2DBarCode.Data

    Specifies the data to be encoded.

    The data specified by this property will be encoded into the barcode. The
    data is analyzed so that the code will fit in the smallest number of
    codewords, and consequently, the smallest barcode, possible.

    If ExtendedSyntax is True, the tilde character (~) will be used to indicate
    special characters. }

  {@TppCustom2DBarCode.ECCLevel

    Specifies the Reed-Solomon error correction level to use.

    ecLevel0 denotes the least amount of error correction, with ecLevel8 being
    the maximum. scAuto will enable the bar code engine to use the optimal error
    correction for the amount of data. For the numbers of errors that can be
    detected and fixed, please see the PDF417 standards. }

  {@TppCustom2DBarCode.ExtendedSyntax

    Controls if escape characters can be embedded in the code.

    When extended syntax is disabled, the data is encoded directly without
    special interpretation of symbols. When ExtendedSyntax is True, the
    backslash character '\' is used to signal a special sequence. The meanings
    of the escaped sequences vary by barcode type.

    The PDF417 escape sequences are defined in the following table:

    <Table>
    Escape Sequence     Meaning
    ---------------     -------
    \ddd	              Insert the decimal character represented by ddd. There
                        must be three digits, with a value from 000 to 255.
    \Cddd	              Insert the codeword represented by ddd. There must be
                        three digits, with a value from 0 to 929.
    \Gdddddd	          Insert a switch to GLI dddddd. There must be six digits,
                        with a value from 000000 to 812799.
    \Xdd	              Insert the hexadecimal character value represented by dd.
                        There must be two hexadecimal digits, with a value from
                        00 to FF.
    \\	                Inserts a single backslash character.
    </Table>

    The MaxiCode escape sequences are defined in the following table:

    <Table>
    Escape Sequence	    Meaning
    ---------------     -------
    \ddd	              Insert the decimal character represented by ddd. There
                        must be three digits, from 000 to 255.
    \Cdd	              Insert the codeword represented by dd. There must be two
                        digits, from 00 to 63.
    \Edddddd	          Insert a switch to ECI dddddd. There must be six digits,
                        with a value from 000000 to 999999.
    \EOT	              Insert an EOT character (Decimal 4). This character is
                        frequently used to indicate the end of the message in a
                        MaxiCode symbol.
    \FS	                Insert the FS character (Decimal 28)
    \GS	                Insert the GS character (Decimal 29). This character is
                        frequently used to separate fields in a MaxiCode symbol
    \NS	                Insert the NS codeword (Codeword 31).
    \RS	                Insert the RS character (Decimal 30)
    \Xdd	              Insert the hexadecimal character value represented by dd.
                        There must be two hexadecimal digits, with a value from
                        00 to FF.
    \\	                Inserts a backslash character.
    </Table> }

  {@TppCustom2DBarCode.HorPixelsPerMM

    Manually controls the width of the barcode by specifying the horizontal
    pixels per millimeter.

    If AutoScale is False (implying manual sizing of the barcode), the BarWidth
    property is checked. If BarWidth is non-zero, its value will be used to
    specify the width of a single hexagonal element in pixels. If BarWidth is
    zero, HorPixelsPerMM will be used to determine the size of the barcode. }

  {@TppCustom2DBarCode.Mode

    Sets the error correction level and type of data encoded in the barcode.

    The mode property controls whether or not the barcode is encoding carrier
    data and the level of error correction used (see the following table).

    <Table>
    Mode	    Description
    ------    -----------
    cmMode2	  Structured carrier message with numeric postal code.
    cmMode3	  Structured carrier message with alphanumeric postal code.
    cmMode4	  Standard symbol with standard error correction.
    cmMode5	  Standard symbol with enhanced error correction.
    cmMode6	  Reader programming.
    </Table>

    Note: Mode 0 and mode 1 are obsolete.

    Modes 2 and 3 are used for package transport. The values of
    CarrierCountryCode, CarrierPostalCode and CarrierServiceClass are encoded in
    the primary message. The secondary message will contain the data specified
    in the Code property.

    Modes 4 and 5 use the full symbol to code the data in the Code parameter.
    The Carrier fields are not used.

    Mode 5 is the only mode that uses enhanced error correction on the secondary
    message. Enhanced error correction is always used on the primary message. In
    mode 5, only 77 codewords are available for data encodation. In the other
    modes, 93 codewords are available.

    Mode 6 indicates that the symbol is used to program the reader system. No
    data is actually transmitted in mode 6. }

  {@TppCustom2DBarCode.NumColumns

    Specifies the number of columns in the barcode.

    If the number of columns is zero, the barcode will attempt to automatically
    size itself to best fit the data. }

  {@TppCustom2DBarCode.NumRows

    Specifies the number of rows in the barcode.

    If the number of rows is zero, the barcode will attempt to automatically
    size it self to best fit the data. }

  {@TppCustom2dBarCode.PrintHumanReadable

    This property allows you to set whether the component will output the human
    readable version of the bar code (i.e. the actual letters or numbers). }

  {@TppCustom2DBarCode.QuietZone

    Sets the size of the quiet zone around the barcode.

    The quiet zone is an area around the barcode in which no data is written.
    This area allows for scanners to determine the size of the barcode. This is
    also referred to as a "Clear Area".

    For PDF417 barcodes, this size should be a minimum of 2 times the BarWidth.
    For MaxiCode barcodes, the quiet zone should be a minimum of either 1/33rd
    of the BarCodeHeight or 1/30th of the BarCodeWidth, whichever is larger. }

  {@TppCustom2DBarCode.RelativeBarHeight

    Adjusts bar heights to the size of the control.

    In stacked bar symbologies like PDF417, the height of a row is usually a
    multiple of the width of the narrowest bar (BarWidth). When this property is
    True, the bar height is calculated based on the available area in the
    control. }

  {@TppCustom2DBarCode.Truncated

    Controls if truncated PDF417 mode is used.

    Truncated PDF417 reduces the amount of space required for the barcode by
    removing the right hand indicators and by reducing the stop pattern to a
    single bar. Truncated PDF417 should only be used in situations where the
    label is unlikely to be damaged.

    Truncated PDF is fully compatible with PDF417. }

  {@TppCustom2DBarCode.VerPixelsPerMM

    Manually controls the height of the barcode by specifying the vertical
    pixels per millimeter.

    If AutoScale is False (implying manual sizing of the barcode), the BarHeight
    property is checked. If BarHeight is non-zero, its value will be used to
    specify the height of a single hexagonal element in pixels. If BarHeight is
    zero, VerPixelsPerMM will be used to determine the size of the barcode. }

  TppCustom2DBarCode = class(TppCustomComponent)
  private
    FBarCodeType: Tpp2DBarcodeType;
    FAlignBarcode: TppAlignHorizontalType;
    FAutoScale: Boolean;
    FBackgroundColor: TColor;
    FBarHeight: Integer;
    FBarWidth: Integer;
    FCaptionLayout: TTextLayout;
    FCarrierCountryCode: Integer;
    FCarrierPostalCode: string;
    FCarrierServiceClass: Integer;
    FData: string;
    FECCLevel: TStPDF417ECCLevels;
    FExtendedSyntax: Boolean;
    FHorPixelsPerMM: Extended;
    FMode: TStMaxiCodeMode;
    FNumColumns: Integer;
    FNumRows: Integer;
    FPrintHumanReadable: Boolean;
    FRelativeBarHeight: Boolean;
    FQuietZone: Integer;
    FTruncated: Boolean;
    FVerPixelsPerMM: Extended;

    procedure SetBackColor(Value: TColor);
    procedure SetBarCodeType(const Value: Tpp2DBarcodeType);
    procedure SetData(const Value: string);
    procedure SetBarHeight(const Value: Integer);
    procedure SetBarWidth(const Value: Integer);
    procedure SetCaptionLayout(const Value: TTextLayout);
    procedure SetECCLevel(const Value: TStPDF417ECCLevels);
    procedure SetExtendedSyntax(const Value: Boolean);
    procedure SetQuietZone(const Value: Integer);
    procedure SetRelativeBarHeight(const Value: Boolean);
    procedure SetNumColumns(const Value: Integer);
    procedure SetNumRows(const Value: Integer);
    procedure SetTruncated(const Value: Boolean);
    procedure SetAutoScale(const Value: Boolean);
    procedure SetCarrierCountryCode(const Value: Integer);
    procedure SetCarrierPostalCode(const Value: string);
    procedure SetCarrierServiceClass(const Value: Integer);
    procedure SetHorPixelsPerMM(const Value: Extended);
    procedure SetMode(const Value: TStMaxiCodeMode);
    procedure SetPrintHumanReadable(const Value: Boolean);
    procedure SetVerPixelsPerMM(const Value: Extended);
    procedure SetAlignBarcode(const Value: TppAlignHorizontalType);

  protected
    function  GetData: string; virtual;
    procedure AdjustBounds; override;
    function  GetCaption: String; override;
    function  GetDefaultData: string;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Initialize;
    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

    property AutoScale: Boolean read FAutoScale write SetAutoScale default True;
    property BackgroundColor: TColor read FBackgroundColor write SetBackColor default clWhite;
    property BarCodeType: Tpp2DBarcodeType read FBarCodeType write SetBarCodeType;
    property BarHeight: Integer read FBarHeight write SetBarHeight default 2;
    property BarWidth: Integer read FBarWidth write SetBarWidth default 2;
    property CaptionLayout: TTextLayout read FCaptionLayout write SetCaptionLayout default tlBottom;
    property CarrierCountryCode: Integer read FCarrierCountryCode write SetCarrierCountryCode default 0;
    property CarrierPostalCode: string read FCarrierPostalCode write SetCarrierPostalCode;
    property CarrierServiceClass: Integer read FCarrierServiceClass write SetCarrierServiceClass default 0;
    property Data: string read GetData write SetData;
    property ECCLevel: TStPDF417ECCLevels read FECCLevel write SetECCLevel default ecAuto;
    property ExtendedSyntax: Boolean read FExtendedSyntax write SetExtendedSyntax default True;
    property HorPixelsPerMM: Extended read FHorPixelsPerMM write SetHorPixelsPerMM;
    property Mode: TStMaxiCodeMode read FMode write SetMode default cmMode4;
    property NumColumns: Integer read FNumColumns write SetNumColumns default 0;
    property NumRows: Integer read FNumRows write SetNumRows default 0;
    property PrintHumanReadable: Boolean read FPrintHumanReadable write SetPrintHumanReadable default True;
    property QuietZone: Integer read FQuietZone write SetQuietZone default 8;
    property RelativeBarHeight: Boolean read FRelativeBarHeight write SetRelativeBarHeight default False;
    property Truncated: Boolean read FTruncated write SetTruncated default False;
    property VerPixelsPerMM: Extended read FVerPixelsPerMM write SetVerPixelsPerMM;

  published

    property AlignBarcode: TppAlignHorizontalType read FAlignBarcode write SetAlignBarcode;
    property Alignment;
    property AutoSize default True;
    property Border;
    property Color;
    property Font;
    property OnDrawCommandClick;
    property OnDrawCommandCreate;
    property ReprintOnOverFlow;
    property Transparent;
    property UserName;
    property Visible;

    property Height stored False;
    property Left stored False;
    property Top stored False;
    property Width stored False;

  end;

  {@Tpp2DBarCode

    Two-Dimentional barcode component currently supporting PDF417 and Maxicode
    barcode types. }

  Tpp2DBarCode = class(TppCustom2DBarCode)
  private

  protected
    function GetDefaultUserName: String; override;
  public
    constructor Create(aOwner: TComponent); override;

  published
    property AutoScale;
    property BackgroundColor;
    property BarCodeType;
    property BarHeight;
    property BarWidth;
    property CaptionLayout;
    property CarrierCountryCode;
    property CarrierPostalCode;
    property CarrierServiceClass;
    property Data;
    property ECCLevel;
    property ExtendedSyntax;
    property HorPixelsPerMM;
    property Mode;
    property NumColumns;
    property NumRows;
    property PrintHumanReadable;
    property QuietZone;
    property RelativeBarHeight;
    property Truncated;
    property VerPixelsPerMM;

  end;

  {@TppDB2DBarCode

    Two-Dimentional data aware barcode component currently supporting PDF417
    and Maxicode barcode types. }

  TppDB2DBarCode = class(TppCustom2DBarCode)
  private

  protected
    function  GetData: String; override;
    procedure SetCaption(Value: String); override;
    procedure SetDataField(const Value: String); override;

  public
    function  IsDataAware: Boolean; override;
    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

  published
    property AutoScale;
    property BackgroundColor;
    property BarCodeType;
    property BarHeight;
    property BarWidth;
    property CaptionLayout;
    property CarrierCountryCode;
    property CarrierPostalCode;
    property CarrierServiceClass;
    property DataPipeline;
    property DataField;
    property ECCLevel;
    property ExtendedSyntax;
    property HorPixelsPerMM;
    property Mode;
    property NumColumns;
    property NumRows;
    property ParentDataPipeline;
    property PrintHumanReadable;
    property QuietZone;
    property RelativeBarHeight;
    property Truncated;
    property VerPixelsPerMM;

  end;


implementation

uses
  SysUtils,
  Variants,
  ppUtils;

{******************************************************************************
 *
 ** C U S T O M   B A R C O D E
 *
{******************************************************************************}

constructor TppCustom2DBarCode.Create(aOwner: TComponent);
begin
  inherited;

  DrawCommandClass := TppDraw2DBarcode;

  FBackgroundColor := clWhite;
  FBarCodeType := bcPDF417;
  FBarHeight := 8;
  FBarWidth := 2;
  FData := GetDefaultData;
  FMode := cmMode4;
  FCaptionLayout := tlBottom;
  FCarrierCountryCode := 0;
  FCarrierServiceClass := 0;
  FAutoScale := True;
  FECCLevel := ecAuto;
  FExtendedSyntax := True;
  FNumColumns := 0;
  FNumRows := 0;
  FPrintHumanReadable := True;
  FQuietZone := 8;
  FRelativeBarHeight := False;
  FTruncated := False;

  AutoSize := True;
  Color := clBlack;

end;

destructor TppCustom2DBarCode.Destroy;
begin

  inherited;
  
end;

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.AdjustBounds}

procedure TppCustom2DBarCode.AdjustBounds;
var
  lDrawCommand: TppDraw2DBarCode;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (AutoSize) then
    begin
      lDrawCommand := TppDraw2DBarCode.Create(nil);

      try
        PropertiesToDrawCommand(lDrawCommand);

        // let barcode calc its own size
        lDrawCommand.CalcBarCodeSize;

        // apply calculated size
        SetMMWidth(lDrawCommand.Width);
        SetMMHeight(lDrawCommand.Height);

      finally
        lDrawCommand.Free;
      end;
    end;

  InValidateDesignControl;

end; {procedure, AdjustBounds}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetCaption }

function TppCustom2DBarCode.GetCaption: String;
begin
  if FPrintHumanReadable then
    Result := GetData
  else
    Result := '';

end; {function GetCaption}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.GetData}

function TppCustom2DBarCode.GetData: string;
begin
  Result := FData;

end; {function, GetData}

{------------------------------------------------------------------------------}
{ TppCustomBarCode.GetDefaultData }

function TppCustom2DBarCode.GetDefaultData: string;
begin
  if IsDataAware then
    Result := 'DB2DBarCode'
  else
    Result := '2DBarCode';

end; {function, GetDefaultData}

procedure TppCustom2DBarCode.Initialize;
begin
  CalcPrintPosition;
end;

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.PropertiesToDrawCommand}

procedure TppCustom2DBarCode.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDraw2DBarCode;
begin

  inherited;

  lDrawCommand := TppDraw2DBarCode(aDrawCommand);

  lDrawCommand.AlignBarcode := FAlignBarcode;
  lDrawCommand.AutoScale := FAutoScale;
  lDrawCommand.AutoSize := AutoSize;
  lDrawCommand.CarrierCountryCode := FCarrierCountryCode;
  lDrawCommand.CarrierPostalCode := FCarrierPostalCode;
  lDrawCommand.CarrierServiceClass := FCarrierServiceClass;
  lDrawCommand.ECCLevel := FECCLevel;
  lDrawCommand.HorPixelsPerMM := FHorPixelsPerMM;
  lDrawCommand.Mode := FMode;
  lDrawCommand.NumColumns := FNumColumns;
  lDrawCommand.NumRows := FNumRows;
  lDrawCommand.Truncated := FTruncated;
  lDrawCommand.Transparent := Transparent;
  lDrawCommand.Alignment := Alignment;
  lDrawCommand.BackgroundColor := FBackgroundColor;
  lDrawCommand.BarHeight := FBarHeight;
  lDrawCommand.BarWidth := FBarWidth;
  lDrawCommand.CaptionLayout := FCaptionLayout;
  lDrawCommand.ExtendedSyntax := FExtendedSyntax;
  lDrawCommand.RelativeBarHeight := FRelativeBarHeight;
  lDrawCommand.QuietZone := FQuietZone;
  lDrawCommand.Caption := Caption;
  lDrawCommand.Color := Color;
  lDrawCommand.Font.Assign(Font);
  lDrawCommand.BarCodeType := FBarCodeType;
  lDrawCommand.Data := GetData;
  lDrawCommand.VerPixelsPerMM := FVerPixelsPerMM;

  lDrawCommand.Left   := PrintPosRect.Left;
  lDrawCommand.Top    := PrintPosRect.Top;

  {calc height and width - do this last}
  lDrawCommand.Height := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawCommand.Width  := PrintPosRect.Right  - PrintPosRect.Left;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetAlignBarcode}

procedure TppCustom2DBarCode.SetAlignBarcode(const Value: TppAlignHorizontalType);
begin

  if (FAlignBarcode <> Value) then
    begin
      BeforePropertyChange('AlignBarcode');

      FAlignBarcode := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetAlignBarcode}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetAutoScale}

procedure TppCustom2DBarCode.SetAutoScale(const Value: Boolean);
begin

  if (FAutoScale <> Value) then
    begin
      BeforePropertyChange('AutoScale');

      FAutoScale := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetBackColor}

procedure TppCustom2DBarCode.SetBackColor(Value: TColor);
begin

  if (FBackgroundColor <> Value) then
    begin
      BeforePropertyChange('BackgroundColor');

      FBackgroundColor := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetBarCodeType}

procedure TppCustom2DBarCode.SetBarCodeType(const Value: Tpp2DBarcodeType);
begin

  if (FBarCodeType <> Value) then
    begin
      BeforePropertyChange('BarCodeType');

      FBarCodeType := Value;

      FData := GetDefaultData;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetBarHeight}

procedure TppCustom2DBarCode.SetBarHeight(const Value: Integer);
begin

  if (FBarHeight <> Value) then
    begin
      BeforePropertyChange('BarHeight');

      FBarHeight := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetBarWidth}

procedure TppCustom2DBarCode.SetBarWidth(const Value: Integer);
begin

  if (FBarWidth <> Value) then
    begin
      BeforePropertyChange('BarWidth');

      FBarWidth := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetCaptionLayout}

procedure TppCustom2DBarCode.SetCaptionLayout(const Value: TTextLayout);
begin

  if (FCaptionLayout <> Value) then
    begin
      BeforePropertyChange('CaptionLayout');

      FCaptionLayout := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetCarrierCountryCode}

procedure TppCustom2DBarCode.SetCarrierCountryCode(const Value: Integer);
begin

  if (FCarrierCountryCode <> Value) then
    begin
      BeforePropertyChange('CarrierCountryCode');

      FCarrierCountryCode := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetCarrierPostalCode}

procedure TppCustom2DBarCode.SetCarrierPostalCode(const Value: string);
begin

  if (FCarrierPostalCode <> Value) then
    begin
      BeforePropertyChange('CarrierPostalCode');

      FCarrierPostalCode := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetCarrierServiceClass}

procedure TppCustom2DBarCode.SetCarrierServiceClass(const Value: Integer);
begin

  if (FCarrierServiceClass <> Value) then
    begin
      BeforePropertyChange('CarrierServiceClass');

      FCarrierServiceClass := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetData}

procedure TppCustom2DBarCode.SetData(const Value: string);
begin

  if FData <> Value then
    begin
      BeforePropertyChange('Data');

      FData := Value;

      AdjustBounds;

      if not IsDataAware then
        PropertyChange;

  end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetECCLevel}

procedure TppCustom2DBarCode.SetECCLevel(const Value: TStPDF417ECCLevels);
begin

  if (FECCLevel <> Value) then
    begin
      BeforePropertyChange('ECCLevel');

      FECCLevel := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetExtendedSyntax}

procedure TppCustom2DBarCode.SetExtendedSyntax(const Value: Boolean);
begin

  if (FExtendedSyntax <> Value) then
    begin
      BeforePropertyChange('ExtendedSyntax');

      FExtendedSyntax := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetHorPixelsPerMM}

procedure TppCustom2DBarCode.SetHorPixelsPerMM(const Value: Extended);
begin

  if (FHorPixelsPerMM <> Value) then
    begin
      BeforePropertyChange('HorPixelsPerMM');

      FHorPixelsPerMM := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetMode}

procedure TppCustom2DBarCode.SetMode(const Value: TStMaxiCodeMode);
begin

  if (FMode <> Value) then
    begin
      BeforePropertyChange('Mode');

      FMode := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetMode}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetNumColumns}

procedure TppCustom2DBarCode.SetNumColumns(const Value: Integer);
begin

  if (FNumColumns <> Value) then
    begin
      BeforePropertyChange('NumColumns');

      FNumColumns := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetNumColumns}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetNumRows}

procedure TppCustom2DBarCode.SetNumRows(const Value: Integer);
begin

  if (FNumRows <> Value) then
    begin
      BeforePropertyChange('NumRows');

      FNumRows := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetNumRows}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetPrintHumanReadable}

procedure TppCustom2DBarCode.SetPrintHumanReadable(const Value: Boolean);
begin

  if (FPrintHumanReadable <> Value) then
    begin
      BeforePropertyChange('PrintHumanReadable');

      FPrintHumanReadable := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetPrintHumanReadable}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetQuietZone}

procedure TppCustom2DBarCode.SetQuietZone(const Value: Integer);
begin

  if (FQuietZone <> Value) then
    begin
      BeforePropertyChange('QuietZone');

      FQuietZone := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetQuietZone}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetRelativeBarHeight}

procedure TppCustom2DBarCode.SetRelativeBarHeight(const Value: Boolean);
begin

  if (FRelativeBarHeight <> Value) then
    begin
      BeforePropertyChange('RelativeBarHeight');

      FRelativeBarHeight := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetRelativeBarHeight}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetTruncated}

procedure TppCustom2DBarCode.SetTruncated(const Value: Boolean);
begin

  if (FTruncated <> Value) then
    begin
      BeforePropertyChange('Truncated');

      FTruncated := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetTruncated}

{------------------------------------------------------------------------------}
{@Tpp2DBarcode.SetVerPixelsPerMM}

procedure TppCustom2DBarCode.SetVerPixelsPerMM(const Value: Extended);
begin

  if (FVerPixelsPerMM <> Value) then
    begin
      BeforePropertyChange('VerPixelsPerMM');

      FVerPixelsPerMM := Value;

      AdjustBounds;

      PropertyChange;

    end;

end; {procedure, SetVerPixelsPerMM}


{******************************************************************************
 *
 **  D B   B A R C O D E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{@TppDB2DBarCode.GetData

 Run-time and read-only. Contains the data as retrieved from the database,
 which will be encoded.}

function TppDB2DBarCode.GetData: string;
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

{------------------------------------------------------------------------------}
{ TppDB2DBarCode.IsDataAware }

function TppDB2DBarCode.IsDataAware: Boolean;
begin
  Result := True;

end; {function, IsDataAware}

{------------------------------------------------------------------------------}
{ TppDB2DBarCode.Notify }

procedure TppDB2DBarCode.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation in [ppopDataChange, ppopRemove]) and (pppcDesigning in DesignState) {and not(Printing)} then
    Data := GetData;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDB2DBarCode.SetCaption }

procedure TppDB2DBarCode.SetCaption(Value: String);
begin

  {this will take of adjust bounds etc.}
  SetData(GetData);

end; {procedure, SetCaption}

{------------------------------------------------------------------------------}
{ TppDB2DBarCode.SetDataField }

procedure TppDB2DBarCode.SetDataField(const Value: String);
begin

  inherited SetDataField(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  {this will set caption}
  Notify(DataPipeline, ppopDataChange);

  PropertyChange;


end; {procedure, SetDataField}

{******************************************************************************
 *
 ** 2D B A R C O D E
 *
{******************************************************************************}

constructor Tpp2DBarCode.Create(aOwner: TComponent);
begin
  inherited;

  DefaultPropName := 'Data';
  DefaultPropEditType := etEdit;

end;

{------------------------------------------------------------------------------}
{ TppCommunicator.GetDefaultUserName }

function Tpp2DBarCode.GetDefaultUserName: String;
begin

  Result := 'Two' + Copy(Name, 4, Length(Name));

  if not(IsValidUserName(Result)) then
    Result := GetUniqueUserName(Self);

end; {function, GetDefaultUserName}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClass(Tpp2DBarcode);
  RegisterClass(TppDB2DBarcode);

finalization

  UnRegisterClass(Tpp2DBarcode);
  UnRegisterClass(TppDB2DBarcode);


end.
