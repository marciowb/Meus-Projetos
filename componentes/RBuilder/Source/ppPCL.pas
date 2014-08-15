{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                    BBBBB   }

unit ppPCL;

interface

uses
  SysUtils;

type

  {This unit contains support for common PCL language commands as defined by
   the HP PCL language specification.

   Use the Report.OnPrinterDeviceStateChange event in conjunction with the
   Printer.SendEscape method to send PCL commands to the printer.

   The TppPCL class provides access to a set of command groups. Each group
   provides access to specific commands.

   The following command groups have been defined

     - TppPCLJobControl
     - TppPCLPageControl
     - TppPCLCursorPositioning
     - TppPCLFontSelection

   Additional groups can be added as needed. Please follow the standards set
   by this unit and email additions/corrections/suggestions to
   support@digital-metaphors.com.

   }

  TppPCLJobControl = class;
  TppPCLJobControlClass = class of TppPCLJobControl;
  TppPCLPageControl = class;
  TppPCLPageControlClass = class of TppPCLPageControl;
  TppPCLCursorPositioning = class;
  TppPCLCursorPositioningClass = class of TppPCLCursorPositioning;
  TppPCLFontSelection = class;
  TppPCLFontSelectionClass = class of TppPCLFontSelection;

  {@TppPCL

   Provides access to common PCL language commands as defined by
   the HP PCL language specification.

   Use the Report.OnPrinterDeviceStateChange event in conjunction with the
   Printer.SendEscape method to send PCL commands to the printer.

   <CODE>

     myPrinter.SendEscape(TppPCL.JobControl.NumberOfCopies(3))

   </CODE>

   This class defines a set of PCL command groups:

     - JobControl
     - PageControl
     - CursorPositioning
     - FontSelection

   Additional groups can be added as needed. Please follow the standards set
   by this unit and email additions/corrections/suggestions to
   support@digital-metaphors.com.}

  TppPCL = class
  public
    class function JobControl: TppPCLJObControlClass;
    class function PageControl: TppPCLPageControlClass;
    class function FontSelection: TppPCLFontSelectionClass;
    class function CursorPositioning: TppPCLCursorPositioningClass;
  end;

   
  {@TppPCLCommandBase

    Abstract. Ancestor of all PCL Commands.
  }
  TppPCLCommandBase = class
  public
    class function EscapeChar: Char;
  end;

  {@TppPCLCommandGroupBase

    Abstract. Ancestor of all PCL Command Groups.

   Descendants support common PCL language command groups defined by
   the HP PCL language specification.

   Use the Report.OnPrinterDeviceStateChange event in conjunction with the
   Printer.SendEscape method to send PCL commands to the printer.

   Descendants include

     - TppJobControl
     - TppPageControl
     - TppCursorPositioning
     - TppFontSelection

   Each descendant includes a set of class functions that can return PCL codes.

   <CODE>

     myPrinter.SendEscape(TppPCLJobControl.NumberOfCopies(3))

   </CODE>

   Additional descendants can be added as needed. Please follow the standards set
   by the ppPCL unit and email additions/corrections/suggestions to
   support@digital-metaphors.com.

  }
  
  TppPCLCommandGroupBase = class(TppPCLCommandBase)

  end;


  {@TppPCLDuplex

    Defines commands for selecting the duplex mode
  }
  
  TppPCLDuplex = class(TppPCLCommandBase)
  public
    class function GetCommandForId(aDuplexId: Integer): String;
    class function Simplex: string;
    class function Duplex_LongEdgeBinding: string;
    class function Duplex_ShortEdgeBinding: string;
  end;


  {@TppPCLDuplexPageSideSelection
  
      Defines commands for causing a form feed and specifying which side
      of the paper to print.

      - SelectNextSide
      - SelectFrontSide
      - SelectBackSide
  }
  TppPCLDuplexPageSideSelection = class(TppPCLCommandBase)
  public
    class function GetCommandForId(aDuplexId: Integer): String;
    class function SelectNextSide: string;
    class function SelectFrontSide: string;
    class function SelectBackSide: string;
  end;


  TppPCLDuplexClass = class of TppPCLDuplex;
  TppPCLDuplexPageSideSelectionClass = class of TppPCLDuplexPageSideSelection;

  {@TppPCLJobControl

     Defines common PCL commands for controlling a print job. Job control commands
     are typically sent at the beginning of a print job.

     Job Control includes

       - PrinterReset
       - NumberOfCopies
       - Duplex
       - OutputBin
       - UnitOfMeasure
       - JobSeparation
       - UniversalExitLanguage
  }
  TppPCLJobControl = class(TppPCLCommandGroupBase)
  public
    class function PrinterReset: string;
    class function UniversalExitLanguage: string;
    class function NumberOfCopies(aValue: Integer): string;
    class function Duplex: TppPCLDuplexClass;
    class function DuplexPageSideSelection: TppPCLDuplexPageSideSelectionClass;
    class function JobSeparation: string;
    class function LeftOffsetRegistration(aDecipoints: Integer): string;
    class function TopOffsetRegistration(aDecipoints: Integer): string;
    class function UnitOfMeasure(aValue: Integer): string;
    class function OutputBin(aValue: Integer): string;
  end;


  {@TppPCLPaperSize

    Defines commands for controlling the page orientation.

      - Portrait
      - Landscale
      - ReversePortrait
      - RevereseLandscape

  }
  TppPCLPageOrientation = class(TppPCLCommandBase)
  public
    class function Portrait: string;
    class function GetCommandForId(aOrientationId: Integer): String;
    class function Landscape: string;
    class function ReversePortrait: string;
    class function ReverseLandscape: string;
  end;


  {@TppPCLPaperSize

    Defines commands for specifying the paper size.
  
  }
  TppPCLPaperSize = class(TppPCLCommandBase)
  public
    class function A5: string;
    class function A3: string;
    class function Executive: string;
    class function GetCommandForId(aPaperId: Integer): String;
    class function Letter: string;
    class function Legal: string;
    class function A4: string;
    class function CustomPaper: string;
    class function International_DL: string;
    class function Monarch: string;
    class function Commercial_10: string;
    class function International_B5: string;
    class function International_C5: string;
    class function Ledger: string;
  end;


  {@TppPCLPaperSource

    Defines commands for selecting the paper source.
  }
  TppPCLPaperSource = class(TppPCLCommandBase)
  public
    class function AutoSelect: string;
    class function Alternate: string;
    class function EnvelopeFeeder: string;
    class function Current: string;
    class function ManualPaper: string;
    class function GetCommandForId(aSourceId: Integer): String;
    class function ManualEnvelope: string;
    class function Main: string;
    class function OptionalLargePaper: string;
    class function Tray1: string;

  end;


  TppPCLPageOrientationClass = class of TppPCLPageOrientation;
  TppPCLPaperSizeClass = class of TppPCLPaperSize;
  TppPCLPaperSourceClass = class of TppPCLPaperSource;

  {@TppPCLPageControl

     Defines common PCL commands for controlling a page. Page control commands
     can be sent once at the beginning of a print job and optionally at the
     beginning of each page.

     Page Control includes

       - Orientation
       - PaperSize
       - PaperSource
       - LineSpacing
       - TextLength
       - LeftMargin
       - TopMargin
       - HorizontalMotionIndex
       - VerticalMotionIndex

  }
  TppPCLPageControl = class(TppPCLCommandGroupBase)
  public
    class function ClearHorizontalMargins: string;
    class function Orientation: TppPCLPageOrientationClass;
    class function PaperSize: TppPCLPaperSizeClass;
    class function PaperSource: TppPCLPaperSourceClass;
    class function PrintDirection(aDegreesOfRotation: Integer): string;
    class function LineSpacing(aLinesPerInch: Integer): string;
    class function HorizontalMotionIndex(a120thInchIncrements: Integer): string;
    class function LeftMargin(aColumnNumber: Integer): string;
    class function PerforationSkip(aSkip: Boolean): string;
    class function RightMargin(aColumnNumber: Integer): string;
    class function TopMargin(aNumberOfLines: Integer): string;
    class function VerticalMotionIndex(a48thInchIncrements: Integer): string;
    class function TextLength(aNumberOfLines: Integer): string;
  end;

  {TppPCLCursorPositioning

     Defines common PCL commands for cursor positioning. Includes commands
     for absolute and relative cursor positioning in units of either
     Columns/Rows, Decipoints, or PCLUnits.

       - FormFeed
       - CarriageReturn
       - BackSpace
       - LineSpacing
       - Space
       - LineFeed
       - TopMargin

       - Position_ColumnRow
       - Position_ColumnRow_Relative
       - Position_Decipoints
       - Position_Decipoints_Relative
       - Position_PCLUnits
       - Position_PCLUnits_Relative
  }

  TppPCLCursorPositioning = class(TppPCLCommandGroupBase)
  protected
    class function IntToStr_Signed(aValue: Integer): string;
  public
    class function BackSpace: string;
    class function CarriageReturn: string;
    class function FormFeed: string;
    class function HalfLineFeed: string;
    class function HorizontalTab: string;
    class function LineFeed: string;
    class function PopCursorPos: string;
    class function Position_ColumnRow(aColumns, aRows: Integer): string;
    class function Position_ColumnRow_Relative(aColumns, aRows: Integer): string;
    class function Position_Decipoints(aDecipointsX, aDecipointsY: Integer): string;
    class function Position_Decipoints_Relative(aDecipointsX, aDecipointsY: Integer): string;
    class function Position_PCLUnits(aPCLUnitsX, aPCLUnitsY: Integer): string;
    class function Position_PCLUnits_Relative(aPCLUnitsX, aPCLUnitsY: Integer): string;
    class function PushCursorPos: string;
    class function Space: string;
    class function XPos_Columns(aColumns: Integer): string;
    class function XPos_Columns_Relative(aColumns: Integer): string;
    class function XPos_Decipoints(aDecipoints: Integer): string;
    class function XPos_Decipoints_Relative(aDecipoints: Integer): string;
    class function XPos_PCLUnits(aPCLUnits: Integer): string;
    class function XPos_PCLUnits_Relative(aPCLUnits: Integer): string;
    class function YPos_PCLUnits_Relative(aPCLUnits: Integer): string;
    class function YPos_PCLUnits(aPCLUnits: Integer): string;
    class function YPos_Decipoints(aDecipoints: Integer): string;
    class function YPos_Decipoints_Relative(aDecipoints: Integer): string;
    class function YPos_Rows(aRows: Integer): string;
    class function YPos_Rows_Relative(aRows: Integer): string;
  end;

  {@TppPCLFontCommandBase

    Abstract. Ancestor of font selection commands.
  }
  TppPCLFontCommandBase = class(TppPCLCommandBase)
  protected
    class function FontSelectionChar: Char; virtual;
  end;

  {@TppPCLFontSpacing

    Defines commands for selecting Fixed and Proportional font spacing.}

  TppPCLFontSpacing = class(TppPCLFontCommandBase)
  protected
  public
    class function Fixed: string;
    class function Proportional: string;
    class function GetCommandForId(aSpacingID: Integer): String;
  end;

  {TppPCLFontSpacing_Secondary}
  TppPCLFontSpacing_Secondary = class(TppPCLFontSpacing)
  protected
    class function FontSelectionChar: Char; override;
  end;


  {@TppPCLFontStyle

    Defines commands for specifying the font style including

      - Upright
      - Italic
      - Condensed
      - Expanded
      - Shadowed

  }
  TppPCLFontStyle = class(TppPCLFontCommandBase)
  protected
  public
    class function GetCommandForId(aSpacingID: Integer): String;
    class function Upright: string;
    class function Italic: string;
    class function Condensed: string;
    class function ExtraCondensed: string;
    class function Condensed_Italic: string;
    class function Expanded: string;
    class function Outline: string;
    class function Inlined: string;
    class function Outline_Shadowed: string;
    class function Shadowed: string;
  end;

  {TppPCLFontStyle_Secondary}
  TppPCLFontStyle_Secondary = class(TppPCLFontStyle)
  protected
    class function FontSelectionChar: Char; override;
  end;

  {@TppPCLFontStrokeWeight

    Defines commands for specifying the font stroke weight including

       - Thin
       - Light
       - Medium
       - Bold
       - ExtraBold
       - Black
  }
  TppPCLFontStrokeWeight = class(TppPCLFontCommandBase)
  protected
  public
    class function GetCommandForId(aStrokeID: Integer): String;
    class function UltraThin: string;
    class function ExtraThin: string;
    class function Thin: string;
    class function ExtraLight: string;
    class function Light: string;
    class function DemiLight: string;
    class function SemiLight: string;
    class function Medium: string;
    class function SemiBold: string;
    class function DemiBold: string;
    class function Bold: string;
    class function ExtraBold: string;
    class function Black: string;
    class function ExtraBlack: string;
    class function UltraBlack: string;
  end;

 {TppPCLFontStrokeWeight_Secondary}
  TppPCLFontStrokeWeight_Secondary = class(TppPCLFontStrokeWeight)
  protected
    class function FontSelectionChar: Char; override;
  end;

  {@TppPCLFontTypeFaceSelection

    Defines commands for specifying the font type face including

      Courier
      Helvetica
      Script
      Arial

  }
  TppPCLFontTypeFaceSelection = class(TppPCLFontCommandBase)
  protected
  public
    class function GetCommandForId(aStrokeID: Integer): String;
    class function LinePrinter: string;
    class function Courier: string;
    class function Courier_Scalable: string;
    class function CG_Times: string;
    class function Univers: string;
    class function Helvetica: string;
    class function Gothic: string;
    class function Script: string;
    class function Prestige: string;
    class function Arial: string;
  end;

  {TppPCLFontTypeFaceSelectionSecondary}
  TppPCLFontTypeFaceSelectionSecondary = class(TppPCLFontTypeFaceSelection)
  protected
    class function FontSelectionChar: Char; override;
  end;

  TppPCLFontSpacingClass = class of TppPCLFontSpacing;
  TppPCLFontStyleClass = class of TppPCLFontStyle;
  TppPCLFontStrokeWeightClass = class of TppPCLFontStrokeWeight;
  TppPCLFontTypeFaceSelectionClass = class of TppPCLFontTypeFaceSelection;


  {@TppPCLFontSelection

     Defines common PCL commands for font selection. Font selection commands
     operate on either the primary or secondary font.

     Includes commands for

     - Height_Primary, Height_Secondary
     - Pitch_Primary, Pitch_Secondary
     - Spacing_Primary, Spacing_Secondary
     - StrokeWeight_Primary, StrokeWeight_Secondary
     - Style_Primary, Style_Secondary
     - SymbolSet_Primary, SymbolSet_Secondary
     - TypeFace_Primary, TypeFace_Secondary

  }
  TppPCLFontSelection = class(TppPCLCommandGroupBase)
  public
    class function Height_Primary(aPoints: Single): string;
    class function Height_Secondary(aPoints: Single): string;
    class function Pitch_Primary(aCharsPerInch: Single): string;
    class function Pitch_Secondary(aCharsPerInch: Single): string;
    class function Spacing_Primary: TppPCLFontSpacingClass;
    class function Spacing_Secondary: TppPCLFontSpacingClass;
    class function StrokeWeight_Primary: TppPCLFontStrokeWeightClass;
    class function StrokeWeight_Secondary: TppPCLFontStrokeWeightClass;
    class function Style_Primary: TppPCLFontStyleClass;
    class function Style_Secondary: TppPCLFontStyleClass;
    class function SymbolSet_Primary(aSymbolSetId: string): String;
    class function SymbolSet_Secondary(aSymbolSetId: string): String;
    class function TypeFace_Primary: TppPCLFontTypeFaceSelectionClass;
    class function TypeFace_Primary_Secondary: TppPCLFontTypeFaceSelectionClass;
  end;



implementation



{******************************************************************************
 *
 ** P C L 
 *
{******************************************************************************}

{@TppPCL.JobControl

  Provides access to print job commands. Job control commands are typically
  sent at the beginning of a print job.}

class function TppPCL.JobControl: TppPCLJObControlClass;
begin
  Result := TppPCLJobControl;
end;

{@TppPCL.PageControl

  Provides access to page commands. Page control commands can be sent once at
  the beginning of a print job and optionally at the beginning of each page.}

class function TppPCL.PageControl: TppPCLPageControlClass;
begin
  Result := TppPCLPageControl;
end;

{@TppPCL.FontSelection

  Provides access to font selection commands. Font selection commands operate
  on either the primary or secondary font.}

class function TppPCL.FontSelection: TppPCLFontSelectionClass;
begin
  Result := TppPCLFontSelection;
end;

{@TppPCL.CursorPositioning

  Provides access to cursor positioning commands. Includes commands
  for absolute and relative cursor positioning in units of either
  Columns/Rows, Decipoints, or PCLUnits.}

class function TppPCL.CursorPositioning: TppPCLCursorPositioningClass;
begin
  Result := TppPCLCursorPositioning;
end;




{******************************************************************************
 *
 ** P C L   C o m m a n d   B a s e
 *
{******************************************************************************}


class function TppPCLCommandBase.EscapeChar: Char;
begin
  Result := #27;
end;


{******************************************************************************
 *
 ** P C L   D u p l e x
 *
{******************************************************************************}


class function TppPCLDuplex.GetCommandForId(aDuplexId: Integer): String;
begin
  Result := EscapeChar + '&l' + IntToStr(aDuplexId) + 'S';
end;

class function TppPCLDuplex.Simplex: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLDuplex.Duplex_LongEdgeBinding: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLDuplex.Duplex_ShortEdgeBinding: string;
begin
  Result := GetCommandForId(2);
end;


{******************************************************************************
 *
 ** P C L   D u p l e x P a g e   S i d e   S e l e c t i o n
 *
{******************************************************************************}

class function TppPCLDuplexPageSideSelection.GetCommandForId(aDuplexId: Integer): String;
begin
  Result := EscapeChar + '&a' + IntToStr(aDuplexId) + 'G';
end;

class function TppPCLDuplexPageSideSelection.SelectNextSide: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLDuplexPageSideSelection.SelectFrontSide: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLDuplexPageSideSelection.SelectBackSide: string;
begin
  Result := GetCommandForId(2);
end;


{******************************************************************************
 *
 ** P C L   J o b   C o n t r o l
 *
{******************************************************************************}

class function TppPCLJobControl.PrinterReset: string;
begin
  Result := EscapeChar + 'E';
end;

class function TppPCLJobControl.UniversalExitLanguage: string;
begin
  Result := EscapeChar + '%-12345X';
  
end;

class function TppPCLJobControl.NumberOfCopies(aValue: Integer): string;
begin
  Result := EscapeChar + '&l' + IntToStr(aValue) + 'X';

end;

class function TppPCLJobControl.Duplex: TppPCLDuplexClass;
begin
  Result := TppPCLDuplex;

end;

class function TppPCLJobControl.DuplexPageSideSelection: TppPCLDuplexPageSideSelectionClass;
begin
  Result := TppPCLDuplexPageSideSelection;

end;

class function TppPCLJobControl.JobSeparation: string;
begin
  Result := EscapeChar + '&l1T';

end;

class function TppPCLJobControl.LeftOffsetRegistration(aDecipoints: Integer): string;
begin
  Result := EscapeChar + '&l' + IntToStr(aDecipoints) + 'U';
end;

class function TppPCLJobControl.TopOffsetRegistration(aDecipoints: Integer):
    string;
begin
  Result := EscapeChar + '&l' + IntToStr(aDecipoints) + 'Z';
end;

class function TppPCLJobControl.UnitOfMeasure(aValue: Integer): string;
begin
  Result := EscapeChar + '&u' + IntToStr(aValue) + 'D';

end;

class function TppPCLJobControl.OutputBin(aValue: Integer): string;
begin
  Result := EscapeChar + '&l' + IntToStr(aValue) + 'G';

end;

{******************************************************************************
 *
 ** P C L   P a g e   O r i e n t a t i o n
 *
{******************************************************************************}


class function TppPCLPageOrientation.GetCommandForId(aOrientationId: Integer): String;
begin
  Result := EscapeChar + '&l' + IntToStr(aOrientationId) + 'O';
end;

class function TppPCLPageOrientation.Portrait: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLPageOrientation.Landscape: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLPageOrientation.ReversePortrait: string;
begin
  Result := GetCommandForId(2);
end;

class function TppPCLPageOrientation.ReverseLandscape: string;
begin
  Result := GetCommandForId(3);
end;

{******************************************************************************
 *
 ** P C L   P a p e r   S i z e
 *
{******************************************************************************}

class function TppPCLPaperSize.A5: string;
begin
  Result := GetCommandForId(25);
end;

class function TppPCLPaperSize.A3: string;
begin
  Result := GetCommandForId(27);
end;

class function TppPCLPaperSize.Executive: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLPaperSize.Letter: string;
begin
  Result := GetCommandForId(2);
end;

class function TppPCLPaperSize.GetCommandForId(aPaperId: Integer): String;
begin
  Result := EscapeChar + '&l' + IntToStr(aPaperId) + 'A';
end;

class function TppPCLPaperSize.Legal: string;
begin
  Result := GetCommandForId(3);
end;

class function TppPCLPaperSize.A4: string;
begin
  Result := GetCommandForId(26);
end;

class function TppPCLPaperSize.CustomPaper: string;
begin
  Result := GetCommandForId(101);
end;

class function TppPCLPaperSize.International_DL: string;
begin
  Result := GetCommandForId(90);
end;

class function TppPCLPaperSize.Monarch: string;
begin
  Result := GetCommandForId(80);
end;

class function TppPCLPaperSize.Commercial_10: string;
begin
  Result := GetCommandForId(81);
end;

class function TppPCLPaperSize.International_B5: string;
begin
  Result := GetCommandForId(100);
end;

class function TppPCLPaperSize.International_C5: string;
begin
  Result := GetCommandForId(91);
end;

class function TppPCLPaperSize.Ledger: string;
begin
  Result := GetCommandForId(6);
end;

{******************************************************************************
 *
 ** P C L   P a p e r   S o u r c e
 *
{******************************************************************************}


class function TppPCLPaperSource.GetCommandForId(aSourceId: Integer): String;
begin
  Result := EscapeChar + '&l' + IntToStr(aSourceId) + 'H';
end;

class function TppPCLPaperSource.Current: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLPaperSource.Main: string;
begin
  Result := GetCommandForId(1);

end;

class function TppPCLPaperSource.ManualPaper: string;
begin
  Result := GetCommandForId(2);

end;

class function TppPCLPaperSource.ManualEnvelope: string;
begin
  Result := GetCommandForId(3);

end;

class function TppPCLPaperSource.Alternate: string;
begin
  Result := GetCommandForId(4);

end;

class function TppPCLPaperSource.OptionalLargePaper: string;
begin
  Result := GetCommandForId(5);

end;

class function TppPCLPaperSource.EnvelopeFeeder: string;
begin
  Result := GetCommandForId(6);

end;

class function TppPCLPaperSource.AutoSelect: string;
begin
  Result := GetCommandForId(7);

end;

class function TppPCLPaperSource.Tray1: string;
begin
  Result := GetCommandForId(8);

end;


{******************************************************************************
 *
 ** P C L   P a g e    C o n t r o l
 *
{******************************************************************************}


class function TppPCLPageControl.ClearHorizontalMargins: string;
begin
  Result := EscapeChar + '9';
 
end;

class function TppPCLPageControl.Orientation: TppPCLPageOrientationClass;
begin
  Result := TppPCLPageOrientation;
end;

class function TppPCLPageControl.PaperSize: TppPCLPaperSizeClass;
begin
  Result := TppPCLPaperSize;
end;

class function TppPCLPageControl.PaperSource: TppPCLPaperSourceClass;
begin
  Result := TppPCLPaperSource;
end;

class function TppPCLPageControl.PrintDirection(aDegreesOfRotation: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aDegreesOfRotation) + 'P';

end;

class function TppPCLPageControl.LineSpacing(aLinesPerInch: Integer): string;
begin
  Result := EscapeChar + '&l' + IntToStr(aLinesPerInch) + 'D';

end;

class function TppPCLPageControl.HorizontalMotionIndex(a120thInchIncrements: Integer): string;
begin
  Result := EscapeChar + '&k' + IntToStr(a120thInchIncrements) + 'H';

end;

class function TppPCLPageControl.LeftMargin(aColumnNumber: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aColumnNumber) + 'L';

end;

class function TppPCLPageControl.PerforationSkip(aSkip: Boolean): string;
begin
  Result := EscapeChar + '&l' + IntToStr(Ord(aSkip)) + 'L';

end;

class function TppPCLPageControl.RightMargin(aColumnNumber: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aColumnNumber) + 'M';

end;

class function TppPCLPageControl.TopMargin(aNumberOfLines: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aNumberOfLines) + 'E';

end;

class function TppPCLPageControl.VerticalMotionIndex(a48thInchIncrements: Integer): string;
begin
  Result := EscapeChar + '&l' + IntToStr(a48thInchIncrements) + 'C';

end;

class function TppPCLPageControl.TextLength(aNumberOfLines: Integer): string;
begin
  Result := EscapeChar + '&l' + IntToStr(aNumberOfLines) + 'F';

end;

{******************************************************************************
 *
 ** P C L   C u r s o r   P o s i t i o n i n g
 *
{******************************************************************************}


class function TppPCLCursorPositioning.FormFeed: string;
begin
  Result := 'FF';
end;

class function TppPCLCursorPositioning.CarriageReturn: string;
begin
  Result := 'CR';
end;

class function TppPCLCursorPositioning.BackSpace: string;
begin
  Result := 'BS';
end;

class function TppPCLCursorPositioning.IntToStr_Signed(aValue: Integer): string;
begin

  if aValue >= 0 then
    Result := '+'
  else
    Result := '-';

  Result := Result + IntToStr(aValue);
  
end;

class function TppPCLCursorPositioning.PushCursorPos: string;
begin
  Result := EscapeChar + '&f0S';
end;

class function TppPCLCursorPositioning.HorizontalTab: string;
begin
  Result := 'HT';
end;

class function TppPCLCursorPositioning.Space: string;
begin
  Result := 'SP';
end;

class function TppPCLCursorPositioning.LineFeed: string;
begin
  Result := 'LF';
end;

class function TppPCLCursorPositioning.HalfLineFeed: string;
begin
  Result := EscapeChar + '=';
end;

class function TppPCLCursorPositioning.XPos_Columns_Relative(aColumns:
    Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr_Signed(aColumns) + 'C';
end;

class function TppPCLCursorPositioning.Position_ColumnRow(aColumns, aRows: Integer): string;
begin
  Result := XPos_Columns(aColumns) + YPos_Rows(aRows);
end;

class function TppPCLCursorPositioning.XPos_Decipoints_Relative(aDecipoints: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr_Signed(aDecipoints) + 'H';
end;

class function TppPCLCursorPositioning.XPos_PCLUnits_Relative(aPCLUnits: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr_Signed(aPCLUnits) + 'X';
end;

class function TppPCLCursorPositioning.XPos_Decipoints(aDecipoints: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aDecipoints) + 'H';
end;

class function TppPCLCursorPositioning.XPos_Columns(aColumns: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aColumns) + 'C';
end;

class function TppPCLCursorPositioning.XPos_PCLUnits(aPCLUnits: Integer): string;
begin
  Result := EscapeChar + '*p' + IntToStr(aPCLUnits) + 'X';
end;

class function TppPCLCursorPositioning.PopCursorPos: string;
begin
  Result := EscapeChar + '&f1S';
end;

class function TppPCLCursorPositioning.Position_PCLUnits(aPCLUnitsX, aPCLUnitsY: Integer): string;
begin
  Result := XPos_PCLUnits(aPCLUnitsX) + YPos_PCLUnits(aPCLUnitsY);
end;

class function TppPCLCursorPositioning.Position_Decipoints(aDecipointsX, aDecipointsY: Integer): string;
begin
  Result := XPos_Decipoints(aDecipointsX) + YPos_Decipoints(aDecipointsY);
end;

class function TppPCLCursorPositioning.Position_PCLUnits_Relative(aPCLUnitsX, aPCLUnitsY: Integer): string;
begin
  Result := XPos_PCLUnits_Relative(aPCLUnitsX) + YPos_PCLUnits_Relative(aPCLUnitsY);
end;

class function TppPCLCursorPositioning.Position_Decipoints_Relative(aDecipointsX, aDecipointsY: Integer): string;
begin
  Result := XPos_Decipoints_Relative(aDecipointsX) + YPos_Decipoints_Relative(aDecipointsY);
end;

class function TppPCLCursorPositioning.Position_ColumnRow_Relative(aColumns, aRows: Integer): string;
begin
  Result := XPos_Columns_Relative(aRows) + YPos_Rows_Relative(aColumns);
end;


class function TppPCLCursorPositioning.YPos_Rows_Relative(aRows: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr_Signed(aRows) + 'R';
end;

class function TppPCLCursorPositioning.YPos_PCLUnits_Relative(aPCLUnits: Integer): string;
begin
  Result := EscapeChar + '*p' + IntToStr_Signed(aPCLUnits) + 'Y';
end;

class function TppPCLCursorPositioning.YPos_PCLUnits(aPCLUnits: Integer): string;
begin
  Result := EscapeChar + '*p' + IntToStr(aPCLUnits) + 'Y';
end;

class function TppPCLCursorPositioning.YPos_Decipoints(aDecipoints: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aDecipoints) + 'V';
end;

class function TppPCLCursorPositioning.YPos_Decipoints_Relative(aDecipoints: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr_Signed(aDecipoints) + 'V';
end;

class function TppPCLCursorPositioning.YPos_Rows(aRows: Integer): string;
begin
  Result := EscapeChar + '&a' + IntToStr(aRows) + 'R';
end;

{******************************************************************************
 *
 ** P C L   F o n t    S e l e c t i o n
 *
{******************************************************************************}

class function TppPCLFontSelection.Height_Primary(aPoints: Single): string;
begin
  Result := EscapeChar  + '(' + FloatToStr(aPoints) + 'V';
end;

class function TppPCLFontSelection.Height_Secondary(aPoints: Single): string;
begin
  Result := EscapeChar  + ')' + FloatToStr(aPoints) + 'V';
end;

class function TppPCLFontSelection.Pitch_Primary(aCharsPerInch: Single): string;
begin
  Result := EscapeChar  + '(' + FloatToStr(aCharsPerInch) + 'H';
end;

class function TppPCLFontSelection.Pitch_Secondary(aCharsPerInch: Single): string;
begin
  Result := EscapeChar  + ')' + FloatToStr(aCharsPerInch) + 'H';
end;

class function TppPCLFontSelection.Spacing_Primary: TppPCLFontSpacingClass;
begin
  Result := TppPCLFontSpacing;
end;

class function TppPCLFontSelection.Spacing_Secondary: TppPCLFontSpacingClass;
begin
  Result := TppPCLFontSpacing_Secondary;
end;

class function TppPCLFontSelection.StrokeWeight_Primary: TppPCLFontStrokeWeightClass;
begin
  Result := TppPCLFontStrokeWeight;
end;

class function TppPCLFontSelection.StrokeWeight_Secondary: TppPCLFontStrokeWeightClass;
begin
  Result := TppPCLFontStrokeWeight_Secondary;
end;

class function TppPCLFontSelection.Style_Primary: TppPCLFontStyleClass;
begin
  Result := TppPCLFontStyle;
end;

class function TppPCLFontSelection.Style_Secondary: TppPCLFontStyleClass;
begin
  Result := TppPCLFontStyle_Secondary;
end;

class function TppPCLFontSelection.SymbolSet_Primary(aSymbolSetId: string): String;
begin
  Result := EscapeChar + '(' + aSymbolSetId;
end;

class function TppPCLFontSelection.SymbolSet_Secondary(aSymbolSetId: string): String;
begin
  Result := EscapeChar + ')' + aSymbolSetId;
end;

class function TppPCLFontSelection.TypeFace_Primary: TppPCLFontTypeFaceSelectionClass;
begin
  Result := TppPCLFontTypeFaceSelection;
end;

class function TppPCLFontSelection.TypeFace_Primary_Secondary: TppPCLFontTypeFaceSelectionClass;
begin
  Result := TppPCLFontTypeFaceSelectionSecondary;
end;

{******************************************************************************
 *
 ** P C L   F o n t   S p a c i n g
 *
{******************************************************************************}

class function TppPCLFontSpacing.Fixed: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLFontSpacing.Proportional: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLFontSpacing.GetCommandForId(aSpacingID: Integer): String;
begin
  Result := EscapeChar + FontSelectionChar + 's' + IntToStr(aSpacingID) + 'P';
end;

class function TppPCLFontSpacing_Secondary.FontSelectionChar: Char;
begin
  Result := ')';
end;

{******************************************************************************
 *
 ** P C L   F o n t   C o m m a n d   B a s e
 *
{******************************************************************************}

class function TppPCLFontCommandBase.FontSelectionChar: Char;
begin
  Result := '(';
end;

{******************************************************************************
 *
 ** P C L   F o n t   S t y l e
 *
{******************************************************************************}


class function TppPCLFontStyle.GetCommandForId(aSpacingID: Integer): String;
begin
  Result := EscapeChar + FontSelectionChar + 's' + IntToStr(aSpacingID) + 'S';
end;

class function TppPCLFontStyle.Upright: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLFontStyle.Italic: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLFontStyle.Condensed: string;
begin
  Result := GetCommandForId(4);
end;

class function TppPCLFontStyle.ExtraCondensed: string;
begin
  Result := GetCommandForId(8);
end;

class function TppPCLFontStyle.Condensed_Italic: string;
begin
  Result := GetCommandForId(5);
end;

class function TppPCLFontStyle.Expanded: string;
begin
  Result := GetCommandForId(24);
end;

class function TppPCLFontStyle.Outline: string;
begin
  Result := GetCommandForId(32);
end;

class function TppPCLFontStyle.Inlined: string;
begin
  Result := GetCommandForId(64);
end;

class function TppPCLFontStyle.Outline_Shadowed: string;
begin
  Result := GetCommandForId(160);
end;

class function TppPCLFontStyle.Shadowed: string;
begin
  Result := GetCommandForId(128);
end;

{******************************************************************************
 *
 ** P C L   F o n t   S t y l e  S e c o n d a r y
 *
{******************************************************************************}

class function TppPCLFontStyle_Secondary.FontSelectionChar: Char;
begin
  Result := ')';
end;

{******************************************************************************
 *
 ** P C L   F o n t  S  t r o k e   W e i g h t
 *
{******************************************************************************}


class function TppPCLFontStrokeWeight.GetCommandForId(aStrokeID: Integer): String;
begin
  Result := EscapeChar + FontSelectionChar + 's' + IntToStr(aStrokeID) + 'B';
end;

class function TppPCLFontStrokeWeight.UltraThin: string;
begin
  Result := GetCommandForId(-7);
end;

class function TppPCLFontStrokeWeight.ExtraThin: string;
begin
  Result := GetCommandForId(-6);
end;

class function TppPCLFontStrokeWeight.Thin: string;
begin
  Result := GetCommandForId(-5);
end;

class function TppPCLFontStrokeWeight.ExtraLight: string;
begin
  Result := GetCommandForId(-4);
end;

class function TppPCLFontStrokeWeight.Light: string;
begin
  Result := GetCommandForId(-3);
end;

class function TppPCLFontStrokeWeight.DemiLight: string;
begin
  Result := GetCommandForId(-2);
end;

class function TppPCLFontStrokeWeight.SemiLight: string;
begin
  Result := GetCommandForId(-1);
end;

class function TppPCLFontStrokeWeight.Medium: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLFontStrokeWeight.SemiBold: string;
begin
  Result := GetCommandForId(1);
end;

class function TppPCLFontStrokeWeight.DemiBold: string;
begin
  Result := GetCommandForId(2);
end;

class function TppPCLFontStrokeWeight.Bold: string;
begin
  Result := GetCommandForId(3);
end;

class function TppPCLFontStrokeWeight.ExtraBold: string;
begin
  Result := GetCommandForId(4);
end;

class function TppPCLFontStrokeWeight.Black: string;
begin
  Result := GetCommandForId(5);
end;

class function TppPCLFontStrokeWeight.ExtraBlack: string;
begin
  Result := GetCommandForId(6);
end;

class function TppPCLFontStrokeWeight.UltraBlack: string;
begin
  Result := GetCommandForId(7);
end;

class function TppPCLFontStrokeWeight_Secondary.FontSelectionChar: Char;
begin
  Result := ')';
end;

{******************************************************************************
 *
 ** P C L   F o n t  T y p e F a c e  S e l e c t i o n
 *
{******************************************************************************}

class function TppPCLFontTypeFaceSelection.GetCommandForId(aStrokeID: Integer): String;
begin
  Result := EscapeChar + FontSelectionChar + 's' + IntToStr(aStrokeID) + 'T';
end;

class function TppPCLFontTypeFaceSelection.LinePrinter: string;
begin
  Result := GetCommandForId(0);
end;

class function TppPCLFontTypeFaceSelection.Courier: string;
begin
  Result := GetCommandForId(3);
end;

class function TppPCLFontTypeFaceSelection.Courier_Scalable: string;
begin
  Result := GetCommandForId(4099);
end;

class function TppPCLFontTypeFaceSelection.CG_Times: string;
begin
  Result := GetCommandForId(4101);
end;

class function TppPCLFontTypeFaceSelection.Univers: string;
begin
  Result := GetCommandForId(4148);
end;

class function TppPCLFontTypeFaceSelection.Helvetica: string;
begin
  Result := GetCommandForId(4);
end;

class function TppPCLFontTypeFaceSelection.Gothic: string;
begin
  Result := GetCommandForId(6);
end;

class function TppPCLFontTypeFaceSelection.Script: string;
begin
  Result := GetCommandForId(7);
end;

class function TppPCLFontTypeFaceSelection.Prestige: string;
begin
  Result := GetCommandForId(8);
end;

class function TppPCLFontTypeFaceSelection.Arial: string;
begin
  Result := GetCommandForId(16602);
end;

{******************************************************************************
 *
 ** P C L   F o n t  T y p e F a c e  S e l e c t i o n  S e c o n d a r y
 *
{******************************************************************************}


class function TppPCLFontTypeFaceSelectionSecondary.FontSelectionChar: Char;
begin
  Result := ')';
end;



end.
