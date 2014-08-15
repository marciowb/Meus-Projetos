///This file contains the definition of TFlexCelImport, that is the class used to read or write Excel files.
unit UFlexCelImport;

{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface

uses
  SysUtils, Classes, UExcelAdapter,
  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}
  UFlxMessages, UFlxFormats, UTextDelim,
  {$IFDEF FLX_FPC}LResources,{$ENDIF}
  UFlxUtils, Graphics;

type
  ///<summary>A component for manipulating an Excel file by code.</summary>
  TFlexCelImport = class(TComponent)
  private
    FActiveFileName: TFileName;
    function GetIsFormula(Row, Column: integer): boolean;
    function GetAutoRowHeight(Row: integer): boolean;
    procedure SetAutoRowHeight(Row: integer; const Value: boolean);
    function GetCellFormat(Row, Col: integer): integer;
    procedure SetCellFormat(Row, Col: integer; const Value: integer);
    function GetCell(Row, Col: integer): TXlsCellValue;
    procedure SetCell(Row, Col: integer; const Value: TXlsCellValue);
    function GetColorPalette(index: TColorPaletteRange): LongWord;
    procedure SetColorPalette(index: TColorPaletteRange; const Value: LongWord);
    function GetColorPaletteCount: integer;
    function GetColumnFormat(aColumn: integer): integer;
    function GetRowFormat(aRow: integer): integer;
    procedure SetColumnFormat(aColumn: integer; const Value: integer);
    procedure SetRowFormat(aRow: integer; const Value: integer);
    function GetFontListCount: integer;
    function GetFormatListCount: integer;
    function GetFlxFontList(index: integer): TFlxFont;
    function GetFlxFormatList(index: integer): TFlxFormat;
    procedure SetFlxFormatList(index: integer; Value: TFlxFormat);
    procedure SetFlxFontList(index: integer; Value: TFlxFont);
    function GetCellFormatDef1(aRow, aCol: integer): TFlxFormat;
    function GetColByIndex(Row, ColIndex: integer): integer;
    function GetColIndexCount(Row: integer): integer;
    function GetColIndex(Row, Col: integer): integer;
    function GetDefaultColWidth: integer;
    function GetDefaultRowHeight: integer;
    function GetShowGridLines: boolean;
    procedure SetShowGridLines(const Value: boolean);
    function GetShowGridHeaders: boolean;
    procedure SetShowGridHeaders(const Value: boolean);
    function GetPrintGridLines: boolean;
    procedure SetPrintGridLines(const Value: boolean);
    function GetPictureName(aPos: integer): UTF16String;
    function GetPicturesCount: integer;
    function GetCellMergedBounds(aRow, aCol: integer): TXlsCellRange;
    function GetPrintMargins: TXlsMargins;
    procedure SetPrintMargins(const Value: TXlsMargins);
    function GetPageFooter: UTF16String;
    function GetPageHeader: UTF16String;

    function GetPrintNumberOfHorizontalPages: word;
    function GetPrintNumberOfVerticalPages: word;
    function GetPrintScale: integer;
    function GetPrintOptions: byte;
    function GetPrintToFit: boolean;
    procedure SetPageFooter(const Value: UTF16String);
    procedure SetPageHeader(const Value: UTF16String);
    procedure SetPrintNumberOfHorizontalPages(const Value: word);
    procedure SetPrintNumberOfVerticalPages(const Value: word);
    procedure SetPrintScale(const Value: integer);
    procedure SetPrintToFit(const Value: boolean);
    procedure SetPrintOptions(const Value: byte);
    function GetCellFormula(aRow, aCol: integer): UTF16String;
    procedure SetCellFormula(aRow, aCol: integer; const Value: UTF16String);
    procedure FindOnePart(const Text: UTF16String; const P1, P2, P3: integer; out Part: UTF16String);
    function GetSheetZoom: integer;
    procedure SetSheetZoom(const Value: integer);
    function GetActiveSheetVisible: TXlsSheetVisible;
    procedure SetActiveSheetVisible(const Value: TXlsSheetVisible);
    function GetExcelNameCount: integer;
    function GetRangeC1(index: integer): integer;
    function GetRangeC2(index: integer): integer;
    function GetRangeName(index: integer): UTF16String;
    function GetRangeR1(index: integer): integer;
    function GetRangeR2(index: integer): integer;
    function GetRangeSheet(index: integer): integer;
    function GetCellMergedList(index: integer): TXlsCellRange;
    function GetRTFRuns(Row, Col: integer): TRTFRunList;
    procedure SetRTFRuns(Row, Col: integer; const Value: TRTFRunlist);
    procedure SetRangeC1(index: integer; const Value: integer);
    procedure SetRangeC2(index: integer; const Value: integer);
    procedure SetRangeR1(index: integer; const Value: integer);
    procedure SetRangeR2(index: integer; const Value: integer);
    function GetOptions1904Dates: boolean;
    function GetOptionsPrecisionAsDisplayed: boolean;
    function GetOptionsR1C1: boolean;
    function GetOptionsSaveExternalLinkValues: boolean;
    procedure SetOptions1904Dates(const Value: boolean);
    procedure SetOptionsPrecisionAsDisplayed(const Value: boolean);
    procedure SetOptionsR1C1(const Value: boolean);
    procedure SetOptionsSaveExternalLinkValues(const Value: boolean);
    function GetPrintCopies: integer;
    function GetPrintPaperSize: TExcelPaperSize;
    function GetPrintXResolution: integer;
    function GetPrintYResolution: integer;
    procedure SetPrintCopies(const Value: integer);
    procedure SetPrinterDriverSettings(
      const Value: TPrinterDriverSettings);
    procedure SetPrintPaperSize(const Value: TExcelPaperSize);
    procedure SetPrintXResolution(const Value: integer);
    procedure SetPrintYResolution(const Value: integer);
    function GetPrinterDriverSettings: TPrinterDriverSettings;

    function GetOutlineSummaryColsRightOfDetail: boolean;
    function GetOutlineSummaryRowsBelowDetail: boolean;
    function GetOutlineAutomaticStyles: boolean;
    procedure SetOutlineSummaryColsRightOfDetail(const Value: boolean);
    procedure SetOutlineSummaryRowsBelowDetail(const Value: boolean);
    procedure SetOutlineAutomaticStyles(const Value: boolean);
    function GetInvalidateFormulas: boolean;
    procedure SetInvalidateFormulas(const Value: boolean);

  private
    Workbook: TExcelFile;
    FAdapter: TExcelAdapter;
    procedure SetAdapter(const Value: TExcelAdapter);
    function GetCellValue(Row, Col: integer): variant;
    procedure SetCellValue(Row, Col: integer; const Value: variant);
    function GetActiveSheet: integer;
    procedure SetActiveSheet(const Value: integer);
    function GetSheetCount: integer;
    function GetMaxRow: integer;
    function GetMaxCol: integer;
    function GetComments(Row, Pos: integer): variant;
    procedure SetComments(Row, Pos: integer; const Value: variant);
    function GetCommentsCount(Row: integer): integer;
    function GetActiveSheetName: UTF16String;
    procedure SetActiveSheetName(const Value: UTF16String);
    function GetActiveSheetCodeName: UTF16String;
    procedure SetActiveSheetCodeName(const Value: UTF16String);
    function GetColumnWidth(aCol: integer): integer;
    function GetRowHeight(aRow: integer): integer;
    procedure SetColumnWidth(aCol: integer; Value: integer);
    procedure SetRowHeight(aRow: integer; Value: integer);

    function GetRowHidden(const aRow: integer): boolean;
    function GetColumnHidden(const aCol: integer): boolean;
    procedure SetRowHidden(const aRow: integer; const Value: boolean);
    procedure SetColumnHidden(const aCol: integer; const Value: boolean);
    function GetIsXltTemplate: boolean;
    procedure SetIsXltTemplate(const Value: boolean);
    function GetPrintHCentered: boolean;
    function GetPrintVCentered: boolean;
    procedure SetPrintHCentered(const Value: boolean);
    procedure SetPrintVCentered(const Value: boolean);

    { Private declarations }
  protected
    /// <summary>
    /// This method is inherited from TComponent.Notification.
    /// </summary>                                            
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
  public
    /// <summary>
    /// GetWorkbook will return the internal XlsAdapter instance used by FlexCelImport. You should not use this value.
    /// </summary>
    function GetWorkbook: TExcelFile;

    /// <summary>
    /// Do not call Destroy directly in an application. Instead, call Free.
    /// Free verifies that the component is not nil, and only then calls Destroy.
    /// </summary>
    destructor Destroy;override;

    /// <summary>
    /// This method will create an empty Excel file, that you can fill with the API.<para></para>
    /// 
    /// </summary>
    /// <remarks>
    /// The workbook created will be in English, will have 3 sheets called &quot;Sheet1&quot; to &quot;Sheet3&quot;
    /// and will have empty properties (Author, Description, etc).<para></para>
    /// If you want to have a more personalized file when you call NewFile (for example with a given Author,
    /// or the sheets names on your language), it is very easy. Just edit and/or replace the file
    /// &quot;EmptySheet.xls&quot; with your own. Then recompile FlexCel, and your new file will be linked
    /// in.
    /// </remarks>
    /// <param name="SheetCount">Number of sheets for the new file. If you don't specify this value, 3
    ///                          sheets will be used.</param>                                                      
    procedure NewFile(const SheetCount: integer=3);

    /// <summary>
    /// This opens an Excel file for reading/writing. If you are using a <see cref="TXlsTemplateStore" text="TemplateStore" />,
    /// the file will be read from there.
    /// </summary>
    /// <param name="FileName">\File to open.</param>                                                                       
    procedure OpenFile(const FileName: TFileName);

    
    /// <summary>
    /// This method will create a new worksheet and load a text file into it.
    /// </summary>
    /// <remarks>
    /// If you need more control, for example to import a text file beginning on cell C4 of an existing
    /// worksheet, you should use the LoadFromTextDelim global method (on unit &quot;UTextDelim&quot;).
    /// </remarks>
    /// <param name="FileName">\File to Open.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <example>
    /// To open a CSV file (Comma Separated Values):
    /// <code>
    /// OpenText('Filename', ',' );
    /// </code>
    /// 
    /// To open a CSV file (Comma Separated Values) that uses &quot;;&quot; instead of &quot;,&quot; to
    /// separate the fields:
    /// <code>
    /// //This is the way CSV is saved on countries where the &quot;,&quot; and not the &quot;.&quot; is the decimal separator.
    /// OpenText('Filename', ';' );
    /// </code>
    /// 
    /// To open a Tab Delimited file:
    /// <code>
    /// OpenText('Filename', #9 );
    /// </code>
    /// 
    /// </example>                                                                                                             
    procedure OpenText(const FileName: TFileName; const Delimiter: Char);overload;

    /// <summary>
    /// This method will create a new worksheet and load a text file into it.
    /// </summary>
    /// <remarks>
    /// If you need more control, for example to import a text file beginning on cell C4 of an existing
    /// worksheet, you should use the LoadFromTextDelim global method (on unit &quot;UTextDelim&quot;).
    /// </remarks>
    /// <param name="FileName">\File to Open.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <param name="ColumnFormats">An array of formats that you can supply so FlexCel knows which kind of
    ///                             data a column contains. For each column in the ColumnFormats array, you
    ///                             can specify\:
    ///                             * xct_General\: Try to convert it to a number, a date, etc.
    ///                             * xct_Text \: Keep the column as text, even if it can be converted to a
    ///                               number or other things.
    ///                             * xct_Skip\: Do not import this column.\
    /// </param>
    /// <example>
    /// To open a CSV file (Comma Separated Values):
    /// <code>
    /// OpenText('Filename', ',' );
    /// </code>
    /// 
    /// To open a CSV file (Comma Separated Values) that uses &quot;;&quot; instead of &quot;,&quot; to
    /// separate the fields:
    /// <code>
    /// //This is the way CSV is saved on countries where the &quot;,&quot; and not the &quot;.&quot; is the decimal separator.
    /// OpenText('Filename', ';' );
    /// </code>
    /// 
    /// To open a Tab Delimited file:
    /// <code>
    /// OpenText('Filename', #9 );
    /// </code>
    /// 
    /// To open a Tab Delimited file, ignore the first column, try to convert the second to number, dates,
    /// etc, keep the third as text even if it is a number, and try to convert all the other columns to
    /// numbers, dates, etc:
    /// <code>
    /// OpenText('Filename', #9,[xct_skip, xct_General, xct_Text] )
    /// </code>
    /// 
    /// </example>                                                                                                             
    procedure OpenText(const FileName: TFileName; const Delimiter: Char; const ColumnFormats: array of XLSColumnImportTypes);overload;


    /// <summary>
    /// This method is similar to OpenFile, but it reads a stream instead of a file.
    /// </summary>
    /// <param name="DataStream">Stream with the Excel file. Make sure it is at the correct position
    ///                          (normally 0), since FlexCel will try to read the file from the current
    ///                          position.</param>                                                     
    procedure LoadFromStream(const DataStream: TStream);

    /// <summary>
    /// This method is similar to OpenText, but it reads the data from a stream instead of a file.
    /// </summary>
    /// <param name="DataStream">Stream with the Excel file. Make sure it is at the correct position
    ///                          (normally 0), since FlexCel will try to read the file from the current
    ///                          position.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>                         
    procedure LoadFromTextStream(const DataStream: TStream; const Delimiter: Char);overload;

    /// <summary>
    /// This method is similar to OpenText, but it reads the data from a stream instead of a file.
    /// </summary>
    /// <param name="DataStream">Stream with the Excel file. Make sure it is at the correct position
    ///                          (normally 0), since FlexCel will try to read the file from the current
    ///                          position.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <param name="ColumnFormats">An array of formats that you can supply so FlexCel knows which kind of
    ///                             data a column contains. For each column in the ColumnFormats array, you
    ///                             can specify\:
    ///                             * xct_General\: Try to convert it to a number, a date, etc.
    ///                             * xct_Text \: Keep the column as text, even if it can be converted to a
    ///                               number or other things.
    ///                             * xct_Skip\: Do not import this column.</param>                        
    procedure LoadFromTextStream(const DataStream: TStream; const Delimiter: Char; const ColumnFormats: array of XLSColumnImportTypes);overload;

   {$IFDEF DELPHI2008UP}
    /// <summary>
    /// This method is similar to OpenText, but it reads the data from a stream instead of a file.<para></para>
    /// <b>NOTE:</b> This overload of this method (using TEncoding) is only available in Delphi 2009 or
    /// newer.<para></para>
    /// </summary>
    /// <param name="DataStream">Stream with the Excel file. Make sure it is at the correct position
    ///                          (normally 0), since FlexCel will try to read the file from the current
    ///                          position.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <param name="ColumnFormats">An array of formats that you can supply so FlexCel knows which kind of
    ///                             data a column contains. For each column in the ColumnFormats array, you
    ///                             can specify\:
    ///                             * xct_General\: Try to convert it to a number, a date, etc.
    ///                             * xct_Text \: Keep the column as text, even if it can be converted to a
    ///                               number or other things.
    ///                             * xct_Skip\: Do not import this column.\
    ///</param>
    /// <param name="Encoding">Encoding used in the file you are trying to read. For example it might
    ///                          be Encoding.UTF8</param>
    /// <param name="DetectBOM">Indicates whether to look for byte order marks at the beginning of the
    ///                           file.<para></para></param>
    procedure LoadFromTextStream(const DataStream: TStream; const Delimiter: Char; const ColumnFormats: array of XLSColumnImportTypes; const Encoding: TEncoding; const DetectBOM: boolean);overload;
    {$ENDIF}

    /// <summary>
    /// This method saves the file with the specified filename on Excel format.
    /// </summary>
    /// <remarks>
    /// If Adapter.AllowOverwritingFiles is not true in the adapter, you need to delete the file before
    /// saving it.
    /// </remarks>
    /// <param name="FileName">Name of the file you want to save.</param>                              
    procedure Save(const FileName: TFileName);

    /// <summary>
    /// This method saves the file to the specified stream.
    /// </summary>
    /// <param name="DataStream">Stream where to save the data.</param>
    procedure SaveToStream(const DataStream: TStream);

    /// <summary>
    /// Saves the file as Text.
    /// </summary>
    /// <remarks>
    /// If you need more control on what to save, for example to save only a range, you should use the
    /// SaveRangeAsTextDelim global method (on unit UTextDelim).<para></para>
    /// <para></para>
    /// When saving a string that contains the delimiter, it will automatically quote the string, by adding
    /// the character &quot; at the beginning and at the end of it. If the string contains a Quote character
    /// (&quot;) , it will be doubled.
    /// </remarks>
    /// <param name="FileName">\File to Save.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <example>
    /// To save a CSV file (Comma Separated Values):
    /// <code>
    /// SaveAsText('Filename', ',' );
    /// </code>
    ///
    /// To save a CSV file (Comma Separated Values) using &quot;;&quot; instead of &quot;,&quot; to separate
    /// the fields:
    /// <code>
    /// //This is the way CSV is saved on countries where the &quot;,&quot; and not the &quot;.&quot; is the decimal separator.
    /// SaveAsText('Filename', ';' );
    /// </code>
    ///
    /// To save a Tab Delimited file:
    /// <code>
    /// SaveAsText('Filename', #9 );
    /// </code>
    ///
    /// </example>
    procedure SaveAsText(const FileName: TFileName; const Delimiter: Char); {$IFDEF DELPHI2008UP}overload;{$ENDIF}


{$IFDEF DELPHI2008UP}
    /// <summary>
    /// Saves the file as Text.
    /// </summary>
    /// <remarks>
    /// If you need more control on what to save, for example to save only a range, you should use the
    /// SaveRangeAsTextDelim global method (on unit UTextDelim).<para></para>
    /// <para></para>
    /// When saving a string that contains the delimiter, it will automatically quote the string, by adding
    /// the character &quot; at the beginning and at the end of it. If the string contains a Quote character
    /// (&quot;) , it will be doubled.
    /// </remarks>
    /// <param name="FileName">\File to Save.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <param name="Encoding">The encoding to use (UTF8, ASCII, etc) It defaults to ASCII if not specified.</param>
    /// <param name="IncludeBOM">Specifies if a BOM (Byte Order Mark) should be written at the beginning of the file. If ommited, no BOM will be written.</param>
    procedure SaveAsText(const FileName: TFileName; const Delimiter: Char; const Encoding: TEncoding; const IncludeBOM: boolean); overload;
{$ENDIF}

    /// <summary>
    /// Saves the file as Text to a stream.
    /// </summary>
    /// <remarks>
    /// This method is similar to SaveAsText, but the data will be saved to a stream instead of a file. See
    /// SaveAsText for examples.
    /// </remarks>
    /// <param name="DataStream">Stream where to save the file.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    procedure SaveToStreamAsText(const DataStream: TStream; const Delimiter: Char); {$IFDEF DELPHI2008UP}overload;{$ENDIF}

{$IFDEF DELPHI2008UP}
    /// <summary>
    /// Saves the file as Text to a stream.
    /// </summary>
    /// <remarks>
    /// This method is similar to SaveAsText, but the data will be saved to a stream instead of a file. See
    /// SaveAsText for examples.
    /// </remarks>
    /// <param name="DataStream">Stream where to save the file.</param>
    /// <param name="Delimiter">The character used to separate fields.</param>
    /// <param name="Encoding">The encoding to use (UTF8, ASCII, etc) It defaults to ASCII if not specified.</param>
    /// <param name="IncludeBOM">Specifies if a BOM (Byte Order Mark) should be written at the beginning of the file. If ommited, no BOM will be written.</param>
    procedure SaveToStreamAsText(const DataStream: TStream; const Delimiter: Char; const Encoding: TEncoding; const IncludeBOM: boolean); overload;
{$ENDIF}

    /// <summary>
    /// Closes an open Excel Workbook.
    /// </summary>
    /// <remarks>
    /// Use this when you are done editing the file. It's not really necessary to use it, as the open file
    /// will be closed when you destroy the module or open another file, but might help to save resources.<para></para>
    /// Remember, FlexCelImport keeps the entire workbook on memory, so if you are done using it, you should
    /// free the memory.
    /// </remarks>
    procedure CloseFile;

    /// <summary>
    /// Number of sheets in the workbook.
    /// </summary>                        
    property SheetCount: integer read GetSheetCount;
    /// <summary>
    /// The Active Sheet.
    /// </summary>
    /// <remarks>
    /// When working with FlexCel, you always have one active sheet where all commands apply (setting a cell,
    /// adding an image, etc.)<para></para>
    /// By changing this property, you can modify the sheet you are working on.<para></para>
    /// <para></para>
    /// \Note that this property is 1-Based, that is, the first sheet is 1, the second 2 and so on until
    /// SheetCount<para></para>
    /// Read this property to get the active sheet, write this property to set it.<para></para>
    /// </remarks>
    /// <example>
    /// The following code will write a value in cell a1 in the first sheet, and then other in the second
    /// sheet.
    /// 
    /// <code lang="delphi">
    /// FlexCelImport.ActiveSheet := 1;
    /// FlexCelImport.CellValue[1,1] := 'This cell is in the first sheet!';
    /// </code>
    /// <code>
    /// FlexCelImport.ActiveSheet := 2;
    /// FlexCelImport.CellValue[1,1] := 'This cell is in the second sheet!';
    /// </code>
    /// 
    /// </example>                                                                                           
    property ActiveSheet:integer read GetActiveSheet write SetActiveSheet ;

    /// <summary>
    /// This is the name of the active sheet, you can read it or change it.
    /// </summary>
    /// <remarks>
    /// This name must be unique in the file. It can be up to 31 characters long, and it can't contain the
    /// characters &quot;/&quot;, &quot;\\&quot;, &quot;?&quot;, &quot;[&quot;, &quot;]&quot;, &quot;*&quot;
    /// or &quot;:&quot;<para></para>
    /// </remarks>
    property ActiveSheetName: UTF16String read GetActiveSheetName write SetActiveSheetName;

		/// <summary>
		/// Returns the codename of a sheet, that is an unique identifier assigned to the sheet when it is created.
    /// </summary>
    /// <remarks>
		/// Codenames are useful because they never change once the file is created, and they are what macros reference.
		/// </remarks>
    property ActiveSheetCodeName: UTF16String read GetActiveSheetCodeName write SetActiveSheetCodeName;

    /// <summary>
    /// Sets the visibility of the active sheet.
    /// </summary>
    /// <remarks>
    /// A sheet can be hidden, visible or &quot;very hidden&quot;. Very hidden sheets can not be made visible
    /// from Excel itself, they can only be shown with a macro or through OLE automation. 
    /// </remarks>
    property ActiveSheetVisible: TXlsSheetVisible read GetActiveSheetVisible write SetActiveSheetVisible;

		/// <summary>
		/// Inserts and copies sheet &quot;CopyFromShet&quot;, SheetCount times before InsertBeforeSheet. To
		/// insert empty sheets, set CopyFromSheet=0.
		/// </summary>
		/// <param name="CopyFromSheet">The sheet index of the sheet we are copying from (1 based). Set it to
		///                             0 to insert Empty sheets.</param>
		/// <param name="InsertBeforeSheet">The sheet before which we will insert (1 based)</param>
		/// <param name="SheetCount">The number of sheets to insert.</param>
    procedure InsertAndCopySheets(const CopyFromSheet, InsertBeforeSheet, SheetCount: integer);

    /// <summary>
    /// Inserts a number of empty sheets at the specified position.<para></para>
    /// 
    /// </summary>
    /// <param name="InsertBeforeSheet">Sheet before which we will insert the sheets.</param>
    /// <param name="SheetCount">Number of sheets to insert.</param>                         
    procedure InsertEmptySheets(const InsertBeforeSheet, SheetCount: integer);

    /// <summary>
    /// Clears all data on the active sheet, but does not delete it.
    /// </summary>
    /// <remarks>
    /// Different from DeleteSheet this method will only clear the
    /// contents of the sheet, but it will remain in place.
    /// </remarks>
    procedure ClearSheet;

    /// <summary>
    /// Deletes the active sheet and SheetCount-1 sheets more to the right.
    /// </summary>
    /// <remarks>
    /// This method will change all formula references to the deleted sheets to invalid.<para></para>
    /// If you just want to clear the contents of the sheet but leave it in place, use ClearSheet.
    /// </remarks>
    /// <param name="aSheetCount">Number of sheets to delete.</param>                                
    procedure DeleteSheet(aSheetCount: integer);

    /// <summary>
    /// Number of used rows on the active sheet.
    /// </summary>
    property MaxRow: integer read GetMaxRow;

    /// <summary>
    /// Number of used columns on the active sheet.
    /// </summary>
    property MaxCol: integer read GetMaxCol;

    /// <summary>
    /// True when the row contains no cells.
    /// </summary>
    /// <remarks>
    /// IsEmptyRow will return true if all cells on a given row are empty. If there is anything, even a
    /// formatted cell with no value, this function will return false.
    /// </remarks>
    /// <param name="aRow">Row you want to know is empty (1 based)</param>
    /// <returns>
    /// True if the row contains no cells.
    /// </returns>
    function IsEmptyRow(const aRow: integer): boolean;

    /// <summary>
    /// Value of a given cell.
    /// </summary>
    /// <remarks>
    /// By accessing this property, you can read or change the contents of any cell.<para></para>
    /// <para></para>
    /// To read or change the cell format, use CellFormat property.<para></para>
    /// <para></para>
    /// To read or change both the cell format and the value, together, use Cell property.<para></para>
    /// <para></para>
    /// If you have a string with a value and want to enter it in Excel on the best possible way (if it is a
    /// date, as a date, if it is a number as a number, etc) take a look to SetCellString<para></para>
    /// <para></para>
    /// If you want a formatted string instead of it's raw value, take a look at XlsFormatValue<para></para>
    /// </remarks>
    /// <param name="Row">Row of the cell (1 based)</param>
    /// <param name="Col">Column of the cell (1 based)</param>                                              
    property CellValue[Row, Col: integer]: variant read GetCellValue write SetCellValue;

    /// <summary>
    /// Use this property to read or write rich format on a cell.
    /// </summary>
    /// <remarks>
    /// In Excel, when the content of a cell is a string, you can do some basic formatting on parts of it.<para></para>
    /// <para></para>
    /// For example, you could have a string &quot;<textattr color="Blue"><b>Bold</b></textattr> and <textattr color="Red">
    /// <i>Italic</i></textattr>&quot; inside a cell.<para></para>
    /// The formatting information you can change is only the font, you can not for example have 2 different
    /// background colors on the same cell.<para></para>
    /// <para></para>
    /// FlexCel allows you to access this information through the RTFRuns property.<para></para>
    /// RTFRuns returns an array, where each entry is a record indicating the character number where the font
    /// starts to apply, and the font to apply. (Character numbers start at 1)<para></para>
    /// <para></para>
    /// On the example string &quot;<textattr color="Blue"><b><c>Bold</c></b></textattr> and <textattr color="Red"><i>Italic</i></textattr>&quot;
    /// you would have 3 RTFRun records in the array:<para></para>
    /// <para></para>
    /// The first one starts at character 1 and has a bold blue font.<para></para>
    /// The second one start at character 6 and has a normal font.<para></para>
    /// The third starts at character 9 and has a red italic font.<para></para>
    /// 
    /// </remarks>
    /// <example>
    /// This example will enter the string &quot;Bold and Italic&quot; on cell A1.
    /// 
    /// <code lang="delphi">
    /// procedure TMainForm.Button6Click(Sender: TObject);
    /// var
    ///   RTFList: TRTFRunList;
    ///   Fnt: TFlxFont;
    /// begin
    ///   FlexCelImport1.NewFile();
    /// 
    ///   //Set the cell content
    ///   FlexCelImport1.CellValue[1,1]:='Bold and Italic';
    /// 
    ///   //Create the RTFRun array.
    ///   SetLength(RTFList, 3);
    ///   RTFList[0].FirstChar := 1; //start at character 0.
    ///   Fnt:= FlexCelImport1.FontList[0];
    ///   Fnt.Style := [flsBold];
    ///   Fnt.ColorIndex := FlexCelImport1.NearestColorIndex(clBlue);
    ///   RTFList[0].FontIndex := FlexCelImport1.AddFont(Fnt);
    /// 
    ///   RTFList[1].FirstChar := 6;
    ///   Fnt:= FlexCelImport1.FontList[0];
    ///   RTFList[1].FontIndex := FlexCelImport1.AddFont(Fnt);
    /// 
    ///   RTFList[2].FirstChar := 9;
    ///   Fnt:= FlexCelImport1.FontList[0];
    ///   Fnt.Style := [flsItalic];
    ///   Fnt.ColorIndex := FlexCelImport1.NearestColorIndex(clRed);
    ///   RTFList[2].FontIndex := FlexCelImport1.AddFont(Fnt);
    /// 
    ///   //Apply the formatting to cell A1.
    ///   FlexCelImport1.RTFRuns[1,1] := RTFList;
    /// 
    ///   XLSAdapter1.AllowOverwritingFiles := true;
    ///   FlexCelImport1.Save('c:\\test.xls');
    /// end;
    /// </code>
    /// </example>                                                                                                                               
    property RTFRuns[Row, Col: integer]: TRTFRunList read GetRTFRuns write SetRTFRuns;

    /// <summary>
    /// Cell Format for a given cell
    /// </summary>
    /// <remarks>
    /// This returns/set the Format number (XF) of a cell. For example, to copy the format on cell A1 to B2
    /// you should write:
    /// 
    /// <code lang="delphi">
    /// FlexCelImport.CellFormat[2,2]:=FlexCelImport.CellFormat[1,1];
    /// </code>
    /// 
    /// You can create new formats using the AddFormat function.<para></para>
    /// Please refer to the API documentation for a more in depth explanation of XF format indexes.<para></para>
    /// 
    /// </remarks>
    property CellFormat[Row, Col: integer]: integer read GetCellFormat write SetCellFormat;

    /// <summary>
    /// Converts a string to the best Excel datatype, and the enters it into a cell.
    /// </summary>
    /// <remarks>
    /// When using CellValue to set a cell value, you have to know the datatype you want to enter. That is,
    /// if you have a string s:=&quot;1/1/2002&quot; and call <c>CellValue[1,1]:=s;</c> The cell A1 will end
    /// up with a string &quot;1/1/2002&quot; and not with a date. The same if you have a string holding a
    /// number.<para></para>
    /// <para></para>
    /// SetCellString tries to solve this problem. When you call SetCellString(1,1,s) FlexCel will evaluate:
    ///
    ///   1. If s contains a valid number: If it does, it will enter the number into the cell, and not the
    ///      string s.
    ///
    ///   2. If s contains a boolean: If s equals the words &quot;TRUE&quot; or &quot;FALSE&quot; (or
    ///      whatever you define on the constants TxtTrue and TxtFalse) it will enter the boolean into the cell
    ///
    ///   3. If s contains a date: If s is a valid date (according to your windows settings) it will enter a
    ///      number into the cell and format the cell as a date. (see Using FlexCelImport )
    ///
    ///   4. In any other case, it will enter the string s into the cell.
    ///
    /// There is an overloaded version of this method, that lets you specify the original format you want for
    /// the cell.
    /// </remarks>
    /// <param name="Row">Row for the cell. (1 based)</param>
    /// <param name="Col">Column for the cell (1 based)</param>
    /// <param name="Text">String with the value you want to enter.</param>
    procedure SetCellString(Row, Col: integer; const Text: UTF16String);overload;

    /// <summary>
    /// Converts a string to the best Excel datatype, and the enters it into a cell.
    /// </summary>
    /// <remarks>
    /// When using CellValue to set a cell value, you have to know the datatype you want to enter. That is,
    /// if you have a string s:=&quot;1/1/2002&quot; and call <c>CellValue[1,1]:=s;</c> The cell A1 will end
    /// up with a string &quot;1/1/2002&quot; and not with a date. The same if you have a string holding a
    /// number.<para></para>
    /// <para></para>
    /// SetCellString tries to solve this problem. When you call SetCellString(1,1,s) FlexCel will evaluate:
    ///
    ///   1. If s contains a valid number: If it does, it will enter the number into the cell, and not the
    ///      string s.
    ///
    ///   2. If s contains a boolean: If s equals the words &quot;TRUE&quot; or &quot;FALSE&quot; (or
    ///      whatever you define on the constants TxtTrue and TxtFalse) it will enter the boolean into the cell
    ///
    ///   3. If s contains a date: If s is a valid date (according to your windows settings) it will enter a
    ///      number into the cell and format the cell as a date. (see Using FlexCelImport )
    ///
    ///   4. In any other case, it will enter the string s into the cell.
    ///
    /// </remarks>
    /// <param name="Row">Row for the cell. (1 based)</param>
    /// <param name="Col">Column for the cell (1 based)</param>
    /// <param name="Text">String with the value you want to enter.</param>
    /// <param name="Fm">Original format for the cell.</param>
    procedure SetCellString(Row, Col: integer; const Text: UTF16String; const Fm: TFlxFormat);overload;

    /// <summary>
    /// True if the cell contains a formula.
    /// </summary>
    /// <remarks>
    /// You can use for example this property to make cells containing formulas read only. 
    /// </remarks>                                                                         
    property IsFormula[Row, Column: integer]: boolean read GetIsFormula;

    /// <summary>
    /// \Returns or sets the Cell value and format of the cell at the same time.
    /// </summary>
    /// <remarks>
    /// This method is equivalent to calling CellValue and CellFormat together, but it is actually a little
    /// faster.<para></para>
    /// <para></para>
    /// In code:
    /// <code lang="delphi">
    /// Cv:=Cell[1,1];
    /// </code>
    ///
    /// Is functionally the same as
    /// <code lang="delphi">
    /// Cv.Value:=CellValue[1,1];
    /// Cv.Format:=CellFormat[1,1];
    /// </code>
    ///
    /// </remarks>
    property Cell[Row, Col: integer]: TXlsCellValue read GetCell write SetCell;

    /// <summary>
    /// Formula on a cell, as a string.
    /// </summary>
    /// <remarks>
    /// If the cell has a formula, it returns it on text format.<para></para>
    /// <para></para>
    /// Formulas should start with a &quot;=&quot; sign, <textattr color="Red"><b>and should always use &quot;,&quot;
    /// as the parameter separator and &quot;.&quot; as decimal separator</b></textattr>. While localized
    /// Excel versions use &quot;;&quot; to separate between parameters, we use the English locale, so your
    /// application will work the same no matter the computer regional settings. Also, all function names
    /// should be in English, no matter what version of Excel you have installed.<para></para>
    /// <para></para>
    /// If in doubt of how a function is names in English or what the exact syntax should be, you can always
    /// write the formula in Excel, open it with FlexCel and read the formula of the cell.<para></para>
    /// 
    /// </remarks>
    /// <example>
    /// This will assign a formula to cell A1:
    /// 
    /// <code lang="delphi">
    /// FlexCelImport.CellFormula[1,1] := '=sum($C$1, D4, 47, COUNT(A1:A2,A6,3))+count(A1:A5, 5)';
    /// </code>
    /// </example>                                                                                                   
    property CellFormula[aRow, aCol: integer]: UTF16String read GetCellFormula write SetCellFormula;

    /// <summary>
    /// Enters a Formula into a cell.
    /// </summary>
    /// <remarks>
    /// This method is similar to CellFormula , but it also allows you to specify the formula result along
    /// with the formula itself.
    /// </remarks>
    /// <param name="aRow">Row for the formula (1 based)</param>
    /// <param name="aCol">Column for the formula (1 based)</param>
    /// <param name="Formula">String containing the formula you want to enter. This string must start
    ///                       with &quot;=&quot;</param>
    /// <param name="FormulaResult">The result of the formula. If you don't know it, use CellFormula instead
    ///                             of this method to enter the formula.</param>                            
    procedure AssignCellFormulaX(const aRow, aCol: integer; const Formula: UTF16String; const FormulaResult: variant);

    /// <summary>
    /// Read this property to learn if you have modified since you opened it in FlexCel.<para></para>
    /// 
    /// </summary>
    /// <remarks>
    /// FlexCel keeps track of if you have modified the file or not in order to know if to invalidate the
    /// formulas when saving. If the file has not been modified, it will save all the formula values back as
    /// they were. If there have been any modifications in the file, it will invalidate all formula results.
    /// </remarks>                                                                                          
    property InvalidateFormulas: boolean read GetInvalidateFormulas write SetInvalidateFormulas;


    /// <summary>
    /// Column position given an index on the array of used columns.
    /// </summary>
    /// <remarks>
    /// FlexCel allows you two way to access the cells in a sheet. You can do it by specifying row and column
    /// (with The Cell property) or by specifying the row and the cell position in the list of used cells for
    /// that row. Using the cell position is faster when you want to read all used cells in a sheet. (and
    /// only the used cells)<para></para>
    /// <para></para>
    /// This property returns the column position for an index on the array of columns. Use this together
    /// with ColIndex and ColIndexCount to loop all used cells of a Row.
    /// </remarks>
    /// <example>
    /// Let's imagine that you have 3 used cells on row 2: B2, D2 and IV2<para></para>
    /// You can use this loop to copy all the values and formats from Row 2 to row 3:
    /// 
    /// <code lang="delphi">
    /// for i:=0 to FImport.ColIndexCount[2]-1 do
    ///   FImport.Cell[3, ColByIndex[2, i]] := FImport.Cell[2, ColByIndex[2, i]];
    /// </code>
    /// 
    /// This will work much faster than using
    /// 
    /// <code lang="delphi">
    /// for i:=1 to FImport.MaxCol do //MaxCol is 255!
    ///   FImport.Cell[3, i] := FImport.Cell[2, i];
    /// </code>
    /// </example>                                                                                           
    property ColByIndex[Row, ColIndex: integer]: integer read GetColByIndex;

    /// <summary>
    /// Index on the array of used columns for a given column position.
    /// </summary>
    /// <remarks>
    /// \Returns the ColumnIndex on the used Columns array given a Row and a Column.<para></para>
    /// For more information, see ColByIndex
    /// </remarks>                                                                               
    property ColIndex[Row, Col: integer]: integer read GetColIndex;

    /// <summary>
    /// Total used columns on a row.
    /// </summary>
    /// <remarks>
    /// You can use this together with ColIndex and ColByIndex to loop between all used cells.<para></para>
    /// For more information, see ColByIndex 
    /// </remarks>                                                                                         
    property ColIndexCount[Row: integer]: integer read GetColIndexCount;

    
    /// <summary>
    /// Associates an index into a color palette with a real color.
    /// </summary>
    /// <remarks>
    /// Excel versions up to 2003 have only a palette of 54 colors that you can use. Internally, those colors
    /// are stores as an index to a color palette, and most properties in FlexCel return this index.<para></para>
    /// <para></para>
    /// Using this property, you can map that index to a real color like clBlue or clRed.<para></para>
    /// <para></para>
    /// \Note that while this limit of 54 colors was removed in Excel 2007, you can still use color indexes
    /// instead of real colors in 2007.<para></para>
    /// <para></para>
    /// For an in-depth explanation of the Excel color palette, see Using the API documentation.<para></para>
    /// 
    /// </remarks>
    /// <param name="Index">Index goes between 1 and ColorPaletteCount, and it specifies the index in the
    ///                     color palette. </param>                                                              

    property ColorPalette[index: TColorPaletteRange]: LongWord read GetColorPalette write SetColorPalette;
    /// <summary>
    /// The number of entries on the color palette.
    /// </summary>
    /// <remarks>
    /// Use this to know the number of colors allowed in the Excel color palette.<para></para>
    /// Refer to ColorPalette and the API documentation for more information.
    /// </remarks>

    property ColorPaletteCount: integer read GetColorPaletteCount;

    /// <summary>
    /// \Returns a list of the colors in the Excel palette that are actually used in your file.
    /// </summary>
    /// <remarks>
    /// You can use this as an entry to NearestColorIndex to modify the palette, or you can modify it
    /// yourself with the information returned.
    /// </remarks>
    /// <returns>
    /// A boolean Array that contains true for the colors in use, or false otherwise.
    /// </returns>
    function GetUsedPaletteColors: BooleanArray;

		/// <summary>
		/// Returns the most similar entry on the excel palette for a given color.
		/// </summary>
    /// <remarks>
		/// If UsedColors is not nil, it will try to modify the Excel color palette
		/// to get a better match on the color, modifying among the not used colors.
		/// Note that modifying the standard palette
		/// might result on a file that is not easy to edit on Excel later, since it does not have the standard Excel colors.
    /// </remarks>
		/// <param name="aColor">Color we want to use.</param>
		/// <returns>Most similar color on the Excel palette.</returns>
    function NearestColorIndex(const aColor: TColor): integer; overload;

 		/// <summary>
		/// Returns the most similar entry on the excel palette for a given color.
		/// </summary>
    /// <remarks>
		/// If UsedColors is not nil, it will try to modify the Excel color palette
		/// to get a better match on the color, modifying among the not used colors.
		/// Note that modifying the standard palette
		/// might result on a file that is not easy to edit on Excel later, since it does not have the standard Excel colors.
    /// </remarks>
		/// <param name="aColor">Color we want to use.</param>
		/// <param name="UsedColors">If nil, this method will just return the color that is nearest to the one you specified.
    /// When not nil, FlexCel will look in the list of available colors, set one of them with the color you specified, adn then returnt that color.
		/// To get a list of used colors for the first call, use <see cref="GetUsedPaletteColors"/>.
		/// After the first call, keep using the same UsedColors structure and do not call GetUsedPaletteColors again, to avoid overwriting colors
		/// that are not yet inserted into the xls file with new ones. You can call GetUsedPaletteColors only after you added the format with <see cref="AddFormat"/>
		/// </param>
		/// <returns>Most similar color on the Excel palette.</returns>
    function NearestColorIndex(const aColor: TColor; const UsedColors: BooleanArray): integer; overload;

    /// <summary>
    /// Adds a new format to the global format list.
    /// </summary>
    /// <remarks>
    /// This function adds a new XF record to the global format list and returns its id.<para></para>
    /// If the format already exists, it won't be added again and the function will return the id of the
    /// existing XF.<para></para>
    /// <para></para>
    /// For example if you have:
    /// <code lang="delphi">
    /// Fmt:=FlexCelImport1.FormatList[15];
    /// Fmt.Font.Name:='Courier';
    /// </code>
    ///
    /// and <c>FlexCelImport1.AddFormat(Fmt)</c> returns 33, then calling <c>FlexCelImport1.AddFormat(Fmt)</c>
    /// again will return 33 again, and no new format will be added.<para></para>
    /// <para></para>
    /// But while this code is valid:
    /// <code lang="delphi">
    /// FlexCelImport.CellFormat[1,1]:=FlexCelImport1.AddFormat(Fmt);
    /// FlexCelImport.CellFormat[2,1]:=FlexCelImport1.AddFormat(Fmt);
    /// FlexCelImport.CellFormat[3,1]:=FlexCelImport1.AddFormat(Fmt);
    /// FlexCelImport.CellFormat[4,1]:=FlexCelImport1.AddFormat(Fmt);
    /// </code>
    ///
    /// It is more efficient to write
    /// <code lang="delphi">
    /// XF:= FlexCelImport1.AddFormat(Fmt);
    /// FlexCelImport.CellFormat[1,1]:=XF;
    /// FlexCelImport.CellFormat[2,1]:=XF:
    /// FlexCelImport.CellFormat[3,1]:=XF;
    /// FlexCelImport.CellFormat[4,1]:=XF;
    /// </code>
    ///
    /// To create a new format from scratch, you can use GetDefaultFormat<para></para>
    ///
    /// </remarks>
    /// <param name="Fmt">TFlxFormat you want to add.</param>
    function AddFormat (const Fmt: TFlxFormat): integer;

    /// <summary>
    /// Adds a new font to the excel font list. If it already exists,
    /// it doesn't add a new one, so you can use this method for
    /// searching too.
    /// </summary>
    /// <remarks>
    /// You do not normally need to use AddFont, fonts are
    /// automatically added when using AddFormat<para></para>
    /// This method might be used when manually managing fonts.
    /// </remarks>
    /// <param name="Fmt">Font to add to the list.</param>
    /// <returns>
    /// The position on the list for the added font.
    /// </returns>
    function AddFont (const Fmt: TFlxFont): integer;

    //**************************************************************************************************
    //DefaultFormat does not work on C++Builder!!! That's why we provide GetDefaultFormat for them.
    //Same happens with FormatList. It looks we can't return a TFlxFormat or TFlxFont on a property :-(
    //As on Delphi 2006 we have BCB and Delphi on the same IDE, we can no longer use BCB symbol to know when we are running BCB
    //So, all the following properties are deprecated on D2006, and should be replaced by the Set/Get methods. (that will work on delphi/bcb)

    {$IFNDEF BCB}
    {$IFDEF ConditionalExpressions}{$if CompilerVersion < 18}
    /// <summary>
    /// This property has been deprecated. Use GetFontList and SetFontList instead.
    /// </summary>
    /// <remarks>
    /// Due to issues with BCB, this method should be no longer used. (And is not available on Delphi 2005
    /// and newer)
    /// </remarks>
    /// <property name="flag" value="Deprecated" />
    property FontList[index: integer]: TFlxFont read GetFlxFontList write SetFlxFontList; //deprecated {$IFDEF FLX_HAS_DEPRECATED_COMMENTS}'Use Get/SetFontList instead.'{$ENDIF};

    /// <summary>
    /// This property has been deprecated. Use GetFormatList and SetFormatList instead.
    /// </summary>
    /// <remarks>
    /// Due to issues with BCB, this method should be no longer used. (And is not available on Delphi 2005
    /// and newer)
    /// </remarks>
    /// <property name="flag" value="Deprecated" />
    property FormatList[index: integer]: TFlxFormat read GetFlxFormatList write SetFlxFormatList; //deprecated {$IFDEF FLX_HAS_DEPRECATED_COMMENTS}'Use Get/SetFormatList instead.'{$ENDIF};

    /// <summary>
    /// This method has been deprecated. Use GetCellFormatDef instead.
    /// </summary>
    /// <remarks>
    /// Due to issues with BCB, this method should be no longer used. (And is not available on Delphi 2005
    /// and newer)
    /// </remarks>
    /// <property name="flag" value="Deprecated" />
    property CellFormatDef[aRow, aCol: integer]: TFlxFormat read GetCellFormatDef1; //deprecated {$IFDEF FLX_HAS_DEPRECATED_COMMENTS}'Use GetCellFormatDef instead.'{$ENDIF};

    /// <summary>
    /// This method has been deprecated. Use GetDefaultFormat instead.
    /// </summary>
    /// <remarks>
    /// Due to issues with BCB, this method should be no longer used. (And is not available on Delphi 2005
    /// and newer)
    /// </remarks>
    /// <property name="flag" value="Deprecated" />
    function DefaultFormat: TFlxFormat;
    {$IFEND}{$ENDIF} //Delphi < 2006
    {$ENDIF}

    /// <summary>
    /// \Returns the default format for an empty cell.
    /// </summary>
    /// <remarks>
    /// Use this function when you want to create new formats not based on existing ones.
    /// </remarks>
    /// <param name="aRow">Row of the cell (1 based).</param>
    /// <param name="aCol">Column of the cell (1 based).</param>
    /// <param name="F">TFlxFormat structure where the value will be returned.</param>
    /// <example>
    /// To create a cell format colored with the color nearest to clBlue, you could use:
    ///
    /// <code lang="delphi">
    /// FlexCelImport.GetCellFormatDef(row, col, F);
    /// F.FillPattern.FgColorIndex := F.NearestColorIndex(clBlue);
    /// NewFormat := FlexCelImport.AddFormat(F);
    ///  FlexCelImport.SetCellFormat(row, col, NewFormat);
    /// </code>
    ///
    /// </example>
    procedure GetCellFormatDef(const aRow, aCol: integer; out F: TFlxFormat);

    /// <summary>
    /// \Returns a TFlxFormat structure where you can read the borders/color/font/etc for an existing XF
    /// format index (0 based).
    /// </summary>
    /// <remarks>
    /// You can use this method to get a cell format definition (TFlxFormat) from its XF index. To add a new
    /// format to the list use the <see cref="AddFormat" /> function.
    /// </remarks>
    /// <param name="index">XF definition (0 based)</param>
    /// <param name="F">Variable where the format definition will be returned.</param>
    procedure GetFormatList(const index:integer; out F:TFlxFormat);

    /// <summary>
    /// \Returns the font definition for a given font index. (0 based)
    /// </summary>
    /// <remarks>
    /// You will normally not need this method, but it could be used together with FontListCount and AddFont
    /// to manage the fonts on a file on a low level way.<para></para>
    /// <para></para>
    /// For example, if you wanted to change all the fonts on a file from Arial to Times New Roman, you could
    /// iterate over this FontList and change them with SetFontList
    /// </remarks>
    /// <param name="index">Index in the Font list (0 based).</param>
    /// <param name="F">Variable where the font definition will be returned.</param>
    procedure GetFontList(const index: integer; out F: TFlxFont);

    /// <summary>
    /// Changes a style on the global list of styles on an Excel file.
    /// </summary>
    /// <remarks>
    /// You should normally not need to use this method. You could use it to alter a style for all the cells
    /// on a workbook.
    /// </remarks>
    /// <param name="index">Index to the XF you want to modify (0 based).</param>
    /// <param name="Value">New definition for the format.</param>
    procedure SetFormatList(index: integer; Value: TFlxFormat);

    /// <summary>
    /// Changes a font entry on the font list for the workbook.
    /// </summary>
    /// <remarks>
    /// You would not normally need this method, but it could be used with GetFontList to for example change
    /// all fonts in a file from Arial to Times New Roman.
    /// </remarks>
    /// <param name="index">Index to the entry in the font list that you wish to modify (0 based).</param>
    /// <param name="Value">New font definition.</param>
    procedure SetFontList(index: integer; Value: TFlxFont);

    /// <summary>
    /// \Returns the Excel standard format for an empty cell.
    /// </summary>
    /// <remarks>
    /// You can use the format returned by this methods as a base to create your own formats.
    /// </remarks>
    /// <param name="F">Variable where the default format will be returned.</param>
    /// <example>
    /// To create a cell format colored with the color nearest to clBlue, you could use:
    ///
    /// <code lang="delphi">
    /// FlexCelImport.GetDefaultFormat(F);
    /// F.FillPattern.FgColorIndex := F.NearestColorIndex(clBlue);
    /// NewFormat := FlexCelImport.AddFormat(F);
    /// </code>
    ///
    /// </example>
    procedure GetDefaultFormat(out F:TFlxFormat);
    
    /// <summary>
    /// Total number of XF structures on the workbook
    /// </summary>
    /// <remarks>
    /// Use this property together with GetFormatList to manage the XF structures on the file. 
    /// </remarks>                                                                             
    property FormatListCount: integer read GetFormatListCount;

    /// <summary>
    /// Number of fonts in the workbook font list.
    /// </summary>
    /// <remarks>
    /// You can use this property together with GetFontList and SetFontList to iterate over the fonts of a
    /// \file.<para></para>
    /// </remarks>
    property FontListCount: integer read GetFontListCount;

    /// <summary>
    /// Gets or sets the current Column width, in Excel internal units. (Character width of &quot;font 0&quot;
    /// / 256)
    /// </summary>
    /// <remarks>
    /// There is a constant
    /// &quot;ColMult&quot; defined on UFlxMessages that you can use to get the size in pixels.<para></para>
    /// <para></para>
    /// \Note that this method will return the real width of the column, even if it is hidden. You might have
    /// to use ColumnHidden to know the width the user is seeing.
    /// </remarks>
    /// <param name="aCol">Column you want to read or change (1 based)</param>
    /// <example>
    /// The following code will return the column width of column &quot;B&quot; in pixels:
    /// <code lang="delphi">
    ///   ColWidthInPixels := Round(FlexCelImport.ColWidth[2] / ColMult);
    /// </code>
    ///
    /// And the following code will set the column width of column &quot;B&quot; to 100 pixels:
    /// <code lang="delphi">
    ///   FlexCelImport.ColWidth[2] := Round(100.0 * ColMult);
    /// </code>
    ///
    /// </example>
    property ColumnWidth[aCol: integer]: integer read GetColumnWidth write SetColumnWidth;

    /// <summary>
    /// Gets or sets the current Row Height, in Excel internal units. (1/20th of a point)
    /// </summary>
    /// <remarks>
    /// There is a constant
    /// &quot;RowMult&quot; defined on UFlxMessages that you can use to get the size in pixels.<para></para>
    /// <para></para>
    /// \Note that this method will return the real height of the row, even if it is hidden. You might have
    /// to use RowHidden to know the height the user is seeing.
    /// </remarks>
    /// <param name="aRow">Row you want to read or change (1 based).</param>
    /// <example>
    /// The following code will return the height of row &quot;2&quot; in pixels:
    /// <code lang="delphi">
    /// RowHeightInPixels := Round(FlexCelImport.RowHeight[2] / RowMult);
    /// </code>
    ///
    /// And the following code will set the row height at row &quot;2&quot; to 100 pixels:
    /// <code lang="delphi">
    ///   FlexCelImport.RowHeight[2] := Round(100.0 * RowMult);
    /// </code>
    ///
    /// </example>
    property RowHeight[aRow: integer]: integer read GetRowHeight write SetRowHeight;

    /// <summary>
    /// Gets/Sets if a column is hidden or not. 
    /// </summary>
    property ColumnHidden[const aCol: integer]: boolean read GetColumnHidden write SetColumnHidden;

    /// <summary>
    /// Gets or sets if a row is hidden or visible.
    /// </summary>
    property RowHidden[const aRow: integer]: boolean read GetRowHidden write SetRowHidden;

    /// <summary>
    /// True if Excel AutoFit is on.
    /// </summary>
    /// <remarks>
    /// By default, Excel rows auto adapt their size to the font size. If you set the row height manually, it
    /// will remain fixed to this size until you set AutoFit (Menu-&gt;Format-&gt;Row-&gt;AutoFit) back.<para></para>
    /// <para></para>
    /// Read this property to know if the row has AutoFit or if it has a fixed size. Write to it to set the
    /// auto fit state.<para></para>
    /// <para></para>
    /// \Note that by default FlexCel will not autofit the rows even if they are set to autofit. Excel will
    /// do it when you open the file. If you want to manually autofit the rows (for example to display them
    /// on a FlexCelGrid) you need to call AutoFitRow
    /// </remarks>                                                                                                   
    property AutoRowHeight[Row: integer]: boolean read GetAutoRowHeight write SetAutoRowHeight;

    /// <summary>
    /// Default row height
    /// </summary>
    /// <remarks>
    /// This read-only property returns the default row height on Excel internal units. There is a constant
    /// &quot;RowMult&quot; defined on UFlxMessages that you can multiply to get the size in pixels.<para></para>
    /// <para></para>
    /// See RowHeight for an example on how to convert between pixels and Excel internal units.
    /// </remarks>
    property DefaultRowHeight: integer read GetDefaultRowHeight;

    /// <summary>
    /// Default column width
    /// </summary>
    /// <remarks>
    /// This read-only property returns the default column width on Excel internal units. There is a constant
    /// &quot;ColMult&quot; defined on UFlxMessages that you can multiply to get the size in pixels.<para></para>
    /// <para></para>
    /// See ColWidth for an example on how to convert between pixels and Excel internal units.<para></para>
    /// </remarks>
    property DefaultColWidth: integer read GetDefaultColWidth;

    /// <summary>
    /// This is the XF format index associated to a column.
    /// </summary>
    /// <remarks>
    /// When a column is empty and has no format, this method will return -1.
    /// </remarks>
    property ColumnFormat[aColumn: integer]: integer read GetColumnFormat write SetColumnFormat;

    /// <summary>
    /// This is the XF format index associated to a row.<para></para>
    /// </summary>
    /// <remarks>
    /// When a column is empty and has no format, this method will return -1.
    /// </remarks>
    property RowFormat[aRow: integer]: integer read GetRowFormat write SetRowFormat;

    /// <summary>
    /// When the cell at (aRow, aCol)is a merged cell, this method will return the first and last cell on the
    /// merged range.
    /// </summary>
    /// <remarks>
    /// If the cell is not merged, this method will return the cell itself.<para></para>
    /// <para></para>
    /// </remarks>
    /// <param name="aRow">Row of the cell (1 based)</param>
    /// <param name="aCol">Column of the cell (1 based)</param>
    /// <example>
    /// If you have a merged cell in range A1: B2, calling CellMergedBounds on any of the cells: A1, B1, A2,
    /// B2 will return A1:B2.<para></para>
    ///
    /// </example>
    property CellMergedBounds[aRow, aCol: integer]: TXlsCellRange read GetCellMergedBounds;

    
    /// <summary>
    /// Merges multiple cells into one.
    /// </summary>
    /// <remarks>
    /// This method might return a bigger range than the one you specify. For example, if you have a merged
    /// cell (A1:C1), calling MergeCells(1,2,2,2) will merge the cell with the existing one, returning ONE
    /// merged cell (A1:C2), and not (B1:B2)<para></para>
    /// <para></para>
    /// Other thing to consider, is that Excel honors individual linestyles inside a merged cell. That is,
    /// you can have only the first 2 columns of the merged cell with a line and the others without.
    /// Normally, after merging the cells, you will want to set the format on all cells in the range to make
    /// them all similar. FlexCel does not do it by default, to give you the choice.
    /// </remarks>
    /// <param name="FirstRow">First row you want to merge (1 based).</param>
    /// <param name="FirstCol">First column you want to merge (1 based).</param>
    /// <param name="LastRow">Last row you want to merge (1 based).</param>
    /// <param name="LastCol">Last column you want to merge (1 based).</param>                              
    procedure MergeCells(const FirstRow, FirstCol, LastRow, LastCol: integer);

    /// <summary>
    /// Unmerges the range of cells.
    /// </summary>
    /// <remarks>
    /// The coordinates have to be exact, if there is no merged cell
    /// with the exact coordinates, nothing will be done.
    /// </remarks>
    /// <param name="FirstRow">First row of the merged cell.</param>
    /// <param name="FirstCol">First column of the merged cell.</param>
    /// <param name="LastRow">Last row of the merged cell.</param>
    /// <param name="LastCol">Last column of the merged cell.</param>  
    procedure UnMergeCells(const FirstRow, FirstCol, LastRow, LastCol: integer);

    /// <summary>
    /// For using with CellMergedList on a loop: for i:=0 to CellMergedListCount-1 do CellMergedList[i]...
    /// </summary>
    function CellMergedListCount: integer;

    /// <summary>
    /// \Returns the Merged cell at position index on the mergedcell
    /// list
    /// </summary>
    /// <remarks>
    /// You can use this property together with CellMergedListCount to
    /// iterate over the merged cells of a sheet.
    /// </remarks>
    property CellMergedList[index: integer]: TXlsCellRange read GetCellMergedList;

    /// <summary>
    /// Copies a range of rows aCount times, inserting it into a new location
    /// </summary>
		/// <remarks>
		/// This method is one of the most important on FlexCel API, and it allows you to copy ranges of cells from one place to another,
		/// adapting the formulas, images and everything as Excel would do it.
		/// </remarks>
    /// <param name="FirstRow">First row to copy.</param>
    /// <param name="LastRow">Last row to copy.</param>
    /// <param name="DestRow">Row where the copied cells will be inserted.</param>
    /// <param name="aCount">Number of times that the source range will be copied.</param>
    procedure InsertAndCopyRows(const FirstRow, LastRow, DestRow, aCount: integer);

    /// <summary>
    /// Copies a range of columns aCount times, inserting it into a new location
    /// </summary>
		/// <remarks>
		/// This method is one of the most important on FlexCel API, and it allows you to copy ranges of cells from one place to another,
		/// adapting the formulas, images and everything as Excel would do it.
		/// </remarks>
    /// <param name="FirstCol">First column to copy.</param>
    /// <param name="LastCol">Last column to copy.</param>
    /// <param name="DestCol">Column where the copied cells will be inserted.</param>
    /// <param name="aCount">Number of times that the source range will be copied.</param>
    procedure InsertAndCopyCols(const FirstCol, LastCol, DestCol, aCount: integer);

    /// <summary>
    /// Deletes a range of rows
    /// </summary>
    /// <remarks>
    /// This method deletes aCount rows from the Active sheet starting with aRow
    /// </remarks>
    /// <param name="aRow">First row to delete.</param>
    /// <param name="aCount">Number of rows to delete.</param>
    procedure DeleteRows(const aRow, aCount: integer);

    /// <summary>
    /// Deletes a range of columns
    /// </summary>
    /// <remarks>
    /// This method deletes aCount columns from the Active sheet starting with aCol
    /// </remarks>
    /// <param name="aCol">First column to delete.</param>
    /// <param name="aCount">Number of columns to delete.</param>
    procedure DeleteCols(const aCol, aCount: integer);

    /// <summary>
    /// The number of named ranges in the workbook.
    /// </summary>
    /// <remarks>
    /// You can use this property together with RangeName, RangeSheet
    /// and RangeR1, RangeC1, RangeR2, RangeC2 to iterate over the
    /// named ranges on a sheet.
    /// </remarks>
    property RangeCount: integer read GetExcelNameCount;

    /// <summary>
    /// \Returns the name of the named range at position index.
    /// </summary>
    /// <remarks>
    /// Index is 1 based<para></para>
    /// <para></para>
    /// You can iterate over all existing ranges with some code like this:
    ///
    /// <code lang="delphi">
    /// for i:= 1 to FlexCelImport.RangeCount do
    /// begin
    ///   if FlexCelImport.RangeName[i] = 'MyRange' then ShowMessage('Range starts at Row ' + IntToStr(FlexCelImport.RangeR1 [i]));
    /// end;
    /// </code>
    /// </remarks>
    property RangeName[index: integer]: UTF16String read GetRangeName;

    /// <summary>
    /// \Returns the first row for a named range, and allows you to modify it.
    /// </summary>
    /// <remarks>
    /// Index is 1 based. You can use RangeName (index) to know which name this range represents.<para></para>
    /// <para></para>
    /// \Note that ranges might be complex and not just rectangular blocks. For example, &quot;=a1 + 3&quot;
    /// is a valid definition for a named range. In those cases, the value of this property is not defined.
    /// </remarks>
    property RangeR1[index: integer]: integer read GetRangeR1 write SetRangeR1;

    /// <summary>
    /// \Returns the second column for a named range, and allows you to modify it.
    /// </summary>
    /// <remarks>
    /// Index is 1 based. You can use RangeName (index) to know which name this range represents.<para></para>
    /// <para></para>
    /// \Note that ranges might be complex and not just rectangular blocks. For example, &quot;=a1 + 3&quot;
    /// is a valid definition for a named range. In those cases, the value of this property is not defined.<para></para>
    /// 
    /// </remarks>                                                                                                      
    property RangeR2[index: integer]: integer read GetRangeR2 write SetRangeR2;

    /// <summary>
    /// \Returns the first column for a named range, and allows you to modify it.
    /// </summary>
    /// <remarks>
    /// Index is 1 based. You can use RangeName (index) to know which name this range represents.<para></para>
    /// <para></para>
    /// \Note that ranges might be complex and not just rectangular blocks. For example, &quot;=a1 + 3&quot;
    /// is a valid definition for a named range. In those cases, the value of this property is not defined.
    /// </remarks>                                                                                            
    property RangeC1[index: integer]: integer read GetRangeC1 write SetRangeC1;

    /// <summary>
    /// \Returns the second column for a named range, and allows you to modify it.
    /// </summary>
    /// <remarks>
    /// Index is 1 based. You can use RangeName (index) to know which name this range represents.<para></para>
    /// <para></para>
    /// \Note that ranges might be complex and not just rectangular blocks. For example, &quot;=a1 + 3&quot;
    /// is a valid definition for a named range. In those cases, the value of this property is not defined.
    /// </remarks>
    property RangeC2[index: integer]: integer read GetRangeC2 write SetRangeC2;

    /// <summary>
    /// \Returns the sheet where the range is located.<para></para>
    /// A value of 0 means that the range is global to all the workbook.
    /// </summary>
    /// <remarks>
    /// Index is 1 based. You can use RangeName (index) to know which name this range represents.
    /// </remarks>
    property RangeSheet[index: integer]: integer read GetRangeSheet;

    /// <summary>
    /// Modifies or adds a Named Range. If the named range exists, it will be modified, else it will be added.
    /// If the range is not user defined (like "Print_Range")
    /// it will have a one-char name, and the value is one of the constants: InternalNameRange_...
    /// Look at the example for more information.
    /// </summary>
    /// <example>
    /// This will create a range for repeating the first 2 columns and rows on each printed page (on sheet 1):
    /// <code>
    /// var
    ///   NamedRange: TXlsNamedRange;
    /// begin
    ///   FlexCelImport1.NewFile;
    ///
    ///   InitializeNamedRange(NamedRange);  //To clear it.
    ///   NamedRange.Name:=InternalNameRange_Print_Titles;
    ///   NamedRange.RangeFormula:='=1:2,A:B';
    ///   NamedRange.OptionFlags:=0;
    ///   NamedRange.NameSheetIndex:=1;
    ///   FlexCelImport1.SetNamedRange(NamedRange);
    ///   deletefile('test.xls');
    ///   FlexCelImport1.Save('test.xls');
    /// end;
    /// </code>
    /// Note that in this example in particular (Print_Titles), the range has to have full rows/columns, as this is what Excel expects.
    /// You can not also write "A1:IV2,A1:B65536" in the formula, "A:B" is preferred because it will keep
    /// working in Excel 2007 (That has more columns and rows).
    /// </example>
    /// <param name="NamedRange">Data of the named range. </param>
    procedure SetNamedRange(var NamedRange: TXlsNamedRange);

    /// <summary>
    /// Number of comments on the worksheet.
    /// </summary>
    /// <remarks>
    /// You can use this property together with Comments to iterate
    /// over all the cell comments on a sheet.
    /// </remarks>
    property CommentsCount[Row: integer]: integer read GetCommentsCount;

    /// <summary>
    /// Comment at the Index position
    /// </summary>
    /// <remarks>
    /// With this property you can read or change any specific comment.<para></para>
    /// Use it together with CommentsCount to iterate over all the cell comments on a sheet.<para></para>
    ///
    /// </remarks>
    property Comments[Row, Pos: integer]: variant read GetComments write SetComments;

    /// <summary>
    /// \Returns the comment at cell (Row, Column)
    /// </summary>
    /// <remarks>
    /// Use this method to read the comment at a given cell.
    /// </remarks>
    /// <param name="Row">Row of the cell where the comment is.</param>
    /// <param name="Col">Column of the cell where the comment is.</param>
    function GetCellComment(Row, Col: integer): UTF16String;

    /// <summary>
    /// Assigns/deletes the comment on a given cell.
    /// </summary>
    /// <remarks>
    /// If you assign an empty string, the comment on the cell will be deleted.<para></para>
    /// <para></para>
    /// In this version of the method the box for the comment will be standard size, the same Excel creates
    /// by default.<para></para>
    /// 
    /// </remarks>
    /// <param name="Row">Row of the cell with the comment (1 based).</param>
    /// <param name="Col">Column of the cell with the comment (1 based).</param>
    /// <param name="Value">String with the comment.</param>                                               
    procedure SetCellComment(Row, Col: integer; const Value: UTF16String); overload;

    /// <summary>
    /// Assigns/deletes the comment on a given cell.
    /// </summary>
    /// <remarks>
    /// If you assign an empty string, the comment on the cell will be deleted.<para></para>
    /// <para></para>
    /// On this version of the method, you can also specify the size for the yellow box including the
    /// comment.
    /// <param name="Row">Row of the cell with the comment (1 based).</param>
    /// <param name="Col">Column of the cell with the comment (1 based).</param>
    /// <param name="Value">String with the comment.</param>
    /// <param name="Properties">This parameter lets you specify the properties of the comment box that
    ///                          displays when you hover over the cell.<para></para>Only the Col1, dx1,
    ///                          Row1, dy1, Col2, dx2, Row2, dy2 members of Properties have meaning. The
    ///                          FileName member is not used here.
    ///
    ///                          * Col1,Row1, Col2 and Row2 are the starting/ending cells for the box.
    ///                          <para></para>* dx1 and dx2 are the x offset from the starting/ending cells,
    ///                            and they are measured as a 1/1024 part of the cell.For example\:
    ///                            * \  a box starting on Col1=3 and dx1=0 will start at the beginning of
    ///                              column 3
    ///                            * a box starting on Col1=3 and dx1=512 will start at the middle of column
    ///                              3
    ///                            * a box starting on Col1=3 and dx1=1023 will start at the last pixel of
    ///                              column 3
    ///                          <para></para>* dy1 and dy2 are the y offset from the starting/ending cells,
    ///                            and they are measured as a 1/255 part of the cell. (dy=127 means the middle
    ///                            of the cell)</param>
    /// <para></para>
    ///  </remarks>
    procedure SetCellComment(Row, Col: integer; const Value: UTF16String; const Properties: TImageProperties); overload;

    /// <summary>
    /// Number of images on the active sheet.
    /// </summary>
    /// <remarks>
    /// Use this together with PictureName, AssignPicture and GetPicture to iterate over all the images on a
    /// sheet.<para></para>
    ///
    /// </remarks>
    property PicturesCount: integer read GetPicturesCount;

    /// <summary>
    /// Picture Name for a given index
    /// </summary>
    /// <remarks>
    /// This is the name of the image number aPos. (aPos goes between 0 and PicturesCount-1)<para></para>
    /// <para></para>
    /// You can name images from Excel by selecting them and then typing a name in the name box:<para></para>
    /// <para></para>
    /// <img name="imgnamebox" />
    /// </remarks>
    property PictureName[aPos: integer]: UTF16String read GetPictureName;

    /// <summary>
    /// Assigns a New image to an existing one
    /// </summary>
    /// <remarks>
    /// This method changes an image on the worksheet. Note that with this procedure you can change an
    /// existing image, not insert new ones. For inserting new images, use AddPicture.
    /// </remarks>
    /// <param name="aPos">Position of the image in the list. Goes between 0 and PicturesCount\-1</param>
    /// <param name="Pic">This is the raw data for the image. </param>
    /// <param name="PicType">This is the image type for the new image. Picture might be PNG, JPEG, WMF or
    ///                       EMF</param>
    procedure AssignPicture(const aPos: integer; const Pic: ByteArray; const PicType: TXlsImgTypes);overload;

    /// <summary>
    /// Assigns a New image to an existing one.
    /// </summary>
    /// <remarks>
    /// This method changes an image on the worksheet. Note that with this procedure you can change an
    /// existing image, not insert new ones. For inserting new images, use AddPicture.
    /// </remarks>
    /// <param name="aPos">Position of the image in the list. Goes between 0 and PicturesCount\-1</param>
    /// <param name="Pic">This is the raw data for the image. </param>
    /// <param name="PicType">This is the image type for the new image. Picture might be PNG, JPEG, WMF or
    ///                       EMF</param>
    /// <param name="Row">Row where the imaged will be moved.</param>
    /// <param name="Col">Column where the imaged will be moved.</param>
    /// <param name="dh">Delta x of image respective to Col, on 1/1024 of a cell. 0 means totally at
    ///                  the left, 512 on half of the cell, 1024 means at the left of next cell.</param>
    /// <param name="dw">Delta y of image respective to Row, on 1/255 of a cell. 0 means totally at
    ///                  the top, 128 on half of the cell, 255 means at the top of next cell. </param>
    /// <param name="ImgHeight">Height of the image in Excel internal units (1/20th of a point)</param>
    /// <param name="ImgWidth">Width of the image in Excel internal units (Character width of &quot;font 0&quot;
    ///                        / 256)</param>
    /// <param name="Anchor">How the image will behave when inserting, deleting, moving or copying rows
    ///                      and columns.<para></para><para></para></param>                                     
    procedure AssignPicture(const aPos: integer; const Pic: ByteArray; const PicType: TXlsImgTypes; const Row, Col, dh, dw, ImgHeight, ImgWidth: integer; const Anchor: TFlxAnchorType=at_MoveAndDontResize);overload;

    /// <summary>
    /// Changes the properties of an existing image.
    /// </summary>
    /// <remarks>
    /// You can use this method to resize or move an image on a sheet.
    /// </remarks>
    /// <param name="aPos">Position of the image in the list. Goes between 0 and PicturesCount\-1</param>
    /// <param name="Row">Row where the imaged will be moved.</param>
    /// <param name="Col">Column where the imaged will be moved.</param>
    /// <param name="dh">Delta x of image respective to Col, 1/1024 of a cell. 0 means totally at the
    ///                  left, 512 on half of the cell, 1024 means at the left of next cell.</param>
    /// <param name="dw">Delta y of image respective to Row, on 1/255 of a cell. 0 means totally at
    ///                  the top, 128 on half of the cell, 255 means at the top of next cell. </param>
    /// <param name="ImgHeight">New height of the image in pixels.</param>
    /// <param name="ImgWidth">New width of the image in pixels.</param>
    /// <param name="Anchor">How the image will behave when inserting, deleting, moving or copying rows
    ///                      and columns.<para></para><para></para></param>                              
    procedure AssignPictureProperties(const aPos: integer; const Row, Col, dh, dw, ImgHeight, ImgWidth: integer; const Anchor: TFlxAnchorType=at_MoveAndDontResize);

    /// <summary>
    /// Retrieves an image from a sheet.
    /// </summary>
    /// <remarks>
    /// \Returns a stream with the data for the image at pos aPos. For bitmapped images (JPEG, PNG and BMP)
    /// this is the actual data for the image. If you save the stream to a file, it will open with an image
    /// editor.<para></para>
    /// <para></para>
    /// For Metafiles (WMF, EFM, PIC) this is a 34 bits Header plus the image data.<para></para>
    /// <para></para>
    /// Byte 32 of the header is 0 if the data is compressed (using zlib algorithm), or other value if it is
    /// not.<para></para>
    /// You can use the methods SaveImgStreamToGraphic and SaveImgStreamToDiskImage in UXlsPictures to
    /// convert the returned stream into a real image.
    /// </remarks>
    /// <param name="aPos">Position of the image in the image list.</param>
    /// <param name="Pic">Stream where FlexCel will save the image.</param>
    /// <param name="PicType">FlexCel will return the type of image here.</param>
    /// <param name="ClientAnchor">FlexCel will use this variable to return the anchor of the image.</param>
    procedure GetPicture(const aPos: integer; const Pic: TStream; out PicType: TXlsImgTypes; out ClientAnchor: TClientAnchor);

    /// <summary>
    /// Deletes an image on the active sheet.
    /// </summary>
    /// <remarks>
    /// Deletes the image number INDEX (0-based) from the array of images. Different from ClearPicture , this
    /// method actually deletes the image.
    /// </remarks>
    /// <param name="Index">Index of the image to delete (0 based)</param>
    procedure DeletePicture(const Index: integer);

    /// <summary>
    /// Clears an image on the active sheet.
    /// </summary>
    /// <remarks>
    /// Replaces the image number INDEX (0-based) from the array of images with a blank bitmap. It is
    /// different from DeletePicture in that it doesn't delete the image, just makes it blank.
    /// </remarks>
    /// <param name="Index">Index of the image to clear (0 based)</param>
    procedure ClearPicture(const Index: integer);

    /// <summary>
    /// Inserts a new picture on the active sheet.
    /// </summary>
    /// <param name="Pic">This is the raw data for the image as an array of bytes. </param>
    /// <param name="PicType">This is the image type for the new image. Picture might be PNG, JPEG, WMF
    ///                       or EMF.</param>
    /// <param name="Properties">Position of the image on the sheet. You have to set the first and last
    ///                          columns and rows where the image will be placed, the offset from the row
    ///                          and column (dx and dy), and optionally a filename for the image. Note that
    ///                          the filename property won't show on Excel. See <see cref="Excel Internal Units" />
    ///                          for an explanation of dx and dy.</param>
    /// <param name="Anchor">How the image will behave when inserting, deleting, moving or copying rows and
    ///                      columns.</param>                                                                      
    procedure AddPicture(const Pic: ByteArray; const PicType: TXlsImgTypes; const Properties: TImageProperties; const Anchor: TFlxAnchorType=at_MoveAndDontResize);  overload;

    /// <summary>
    /// Inserts a new picture on the active sheet.
    /// </summary>
    /// <param name="Pic">This is the raw data for the image as a stream. Make sure the position of
    ///                   the stream is at the beginning of the data. </param>
    /// <param name="PicType">This is the image type for the new image. Picture might be PNG, JPEG, WMF
    ///                       or EMF.</param>
    /// <param name="Properties">Position of the image on the sheet. You have to set the first and last
    ///                          columns and rows where the image will be placed, the offset from the row
    ///                          and column (dx and dy), and optionally a filename for the image. Note that
    ///                          the filename property won't show on Excel. See <see cref="Excel Internal Units" />
    ///                          for an explanation of dx and dy.</param>
    /// <param name="Anchor">How the image will behave when inserting, deleting, moving or copying rows
    ///                      and columns.</param>                                                                  
    procedure AddPicture(const Pic: TStream; const PicType: TXlsImgTypes; const Properties: TImageProperties; const Anchor: TFlxAnchorType=at_MoveAndDontResize); overload;

    /// <summary>
    /// Inserts a new picture on the active sheet.
    /// </summary>
    /// <param name="Pic">This is the raw data for the image as an array of bytes.</param>
    /// <param name="PicType">This is the image type for the new image. Picture might be PNG, JPEG, WMF or
    ///                       EMF.</param>
    /// <param name="Row">Row where you want to insert the picture.</param>
    /// <param name="Col">Column where you want to insert the picture.</param>
    /// <param name="dh">Offset in the row for the picture. See <see cref="Excel Internal Units" />
    ///                  for more information.</param>
    /// <param name="dw">Offset in the column for the picture. See <see cref="Excel Internal Units" />
    ///                  for more information.</param>
    /// <param name="ImgHeight">Height of the image in pixels.</param>
    /// <param name="ImgWidth">Width of the image in pixels.</param>
    /// <param name="Anchor">How the image will behave when inserting, deleting, moving or copying rows
    ///                      and columns.</param>
    procedure AddPicture(const Pic: ByteArray; const PicType: TXlsImgTypes; const Row, Col, dh, dw, ImgHeight, ImgWidth: integer; const Anchor: TFlxAnchorType=at_MoveAndDontResize);  overload;

    /// <summary>
    /// Inserts a new picture on the active sheet.
    /// </summary>
    /// <param name="Pic">This is the raw data for the image as a stream. Make sure the position of
    ///                   the stream is at the beginning of the data. </param>
    /// <param name="PicType">This is the image type for the new image. Picture might be PNG, JPEG, WMF or
    ///                       EMF.</param>
    /// <param name="Row">Row where you want to insert the picture.</param>
    /// <param name="Col">Column where you want to insert the picture.</param>
    /// <param name="dh">Offset in the row for the picture. See <see cref="Excel Internal Units" />
    ///                  for more information.</param>
    /// <param name="dw">Offset in the column for the picture. See <see cref="Excel Internal Units" />
    ///                  for more information.</param>
    /// <param name="ImgHeight">Height of the image in pixels.</param>
    /// <param name="ImgWidth">Width of the image in pixels.</param>
    /// <param name="Anchor">How the image will behave when inserting, deleting, moving or copying rows
    ///                      and columns.</param>
    procedure AddPicture(const Pic: TStream; const PicType: TXlsImgTypes; const Row, Col, dh, dw, ImgHeight, ImgWidth: integer; const Anchor: TFlxAnchorType=at_MoveAndDontResize);  overload;

    /// <summary>
    /// Header to print on each page.
    /// </summary>
    /// <remarks>
    /// Accessing this property you can read/set the page header for the active sheet.<para></para>
    /// <para></para>
    /// The page header has 3 sections, one at the left, one centered and one at the right.<para></para>
    /// <para></para>
    /// The left section begins with &quot;&amp;L&quot;, the centered section with &quot;&amp;C&quot; and the
    /// right section with &quot;&amp;R&quot;<para></para>
    /// <para></para>
    /// For example, to write &quot;bye&quot; on the left section and &quot;hello&quot; on the right section,
    /// you would assign a string &quot;&amp;Lbye&amp;RHello&quot; to the header.<para></para>
    /// <para></para>
    /// You can also insert personalized codes, for example to write the date of printing. Some of them are:
    /// <xtable width="35%" columnwidths="30c%">
    /// Value                       Meaning
    /// --------------------------  ---------------------------------------------------------------------
    /// &amp;P                      Current Page
    /// &amp;N                      Page Count
    /// &amp;D                      Date
    /// &amp;T                      Time
    /// &amp;F                      FileName
    /// &amp;Z                      FilePath (Only Excel XP)
    /// &amp;A                      Label (Sheet Name)
    /// &amp;Number                 Font size. (For example, &amp;22 is a 22 dots font)
    /// &amp;&quot;FontName&quot;   Font name (For example &amp;&quot;Arial&quot; changes to font arial)
    /// &amp;U                      Underline
    /// &amp;E                      Double underline
    /// &amp;S                      Overstrike
    /// &amp;Y                      Subindex
    /// &amp;X                      Superindex
    /// </xtable>
    /// 
    /// You can easily know what codes you need by studying an existing sheet. Create a sheet on Excel, set
    /// the header to whatever you want, and use the code on the first example to read the resulting string. 
    /// </remarks>                                                                                           
    property PageHeader: UTF16String read GetPageHeader write SetPageHeader;

    /// <summary>
    /// Footer to print on each page.
    /// </summary>
    /// <remarks>
    /// See <see cref="TFlexCelImport.PageHeader" text="PageHeader" /> for an explanation of the available
    /// options. 
    /// </remarks>                                                                                        
    property PageFooter: UTF16String read GetPageFooter write SetPageFooter;

    /// <summary>
    /// Splits a string containing an Excel header/footer into 3
    /// \members, the right middle and left parts.
    /// </summary>
    /// <remarks>
    /// This method is for internal use, you shouldn't need to use
    /// it.
    /// </remarks>
    /// <param name="Text">Text to split.</param>
    /// <param name="Left">Will return the left section.</param>
    /// <param name="Center">Will return the center section.</param>
    /// <param name="Right">Will return the right section.</param>
    procedure FillPageHeaderFooter(const Text: UTF16String; out Left, Center, Right: UTF16String);

    /// <summary>
    /// True if showing grid lines.
    /// </summary>
    /// <remarks>
    /// This is true if the spreadsheet is showing grid lines, false if not. You can read or write to this
    /// property.<para></para>
    /// </remarks>                                                                                        
    property ShowGridLines: boolean read GetShowGridLines write SetShowGridLines;

    /// <summary>
    /// True if grid lines will be printed.
    /// </summary>
    /// <remarks>
    /// Read or write this property to control if the grid lines will
    /// be printed when printing the sheet. By default on a new sheet
    /// this property is false.
    /// </remarks>

    property PrintGridLines: boolean read GetPrintGridLines write SetPrintGridLines;

    /// <summary>
    /// If true, Excel will show the A, B, C and 1, 2, 3 row and
    /// column headers.
    /// </summary>
    /// <remarks>
    /// This is the same as the option in Excel.
    /// </remarks>
    property ShowGridHeaders: boolean read GetShowGridHeaders write SetShowGridHeaders;

    /// <summary>
    /// \Returns/ set the zoom for a sheet.
    /// </summary>
    /// <remarks>
    /// Use this property to read/write a sheet zoom. Valid values
    /// for this property are on the range 10-400.
    /// Remember that each sheet of a workbook can be saved with a
    /// different zoom, and this property, as all others, affects the active sheet.
    /// </remarks>
    property SheetZoom: integer read GetSheetZoom write SetSheetZoom;

    /// <summary>
    /// Internal use.
    /// </summary>
    function CanOptimizeRead:boolean;

    /// <summary>
    /// True if a spreadsheet has been loaded.
    /// </summary>
    /// <remarks>
    /// When this property is false there is no file loaded on the
    /// component, and any attempt to read or write to the
    /// FlexCelImport will raise an exception.
    /// </remarks>
    function IsLoaded: boolean;

    /// <summary>
    /// The name of the loaded file.
    /// </summary>
    /// <remarks>
    /// Read this property to find out the filename actually loaded
    /// on a FlexCelImport component. If there is no open file, this
    /// property returns an empty string.
    /// </remarks>
    property ActiveFileName: TFileName read FActiveFileName;

    /// <summary>
    /// Copies a range of cells or all the used range to the clipboard.
    /// </summary>
    /// <remarks>
    /// Information is copied in native Excel format and as Tabbed-delimited text. If you don't specify a
    /// cell range, all the used range will be copied.<para></para>
    /// For limitations on clipboard operations, see Using FlexCel API pdf documentation. 
    /// </remarks>                                                                                       
    procedure CopyToClipboard;overload;

    /// <summary>
    /// Copies a range of cells or all the used range to the clipboard.
    /// </summary>
    /// <remarks>
    /// Information is copied in native Excel format and as Tabbed-delimited text. If you don't specify a
    /// cell range, all the used range will be copied.<para></para>
    /// For limitations on clipboard operations, see Using FlexCel API pdf documentation.
    /// </remarks>
    /// <param name="Range">Range of cells to copy to the clipboard.</param>                             
    procedure CopyToClipboard(Range: TXlsCellRange); overload;

    /// <summary>
    /// This method will paste data from the clipboard into a FlexCel sheet, beginning at the specified row
    /// and column.
    /// </summary>
    /// <remarks>
    /// If the clipboard has native Excel format (you copied the info using Excel or FlexCel), the data will
    /// be pasted on native format. If not, the data will be pasted as tabbed text. For a more in depth
    /// discussion of native copy and paste, please read the &quot;Using FlexCel API&quot; pdf document and
    /// take a look at the &quot;Copy and Paste&quot; demo.<para></para>
    /// </remarks>
    /// <param name="Row">Row where to paste the clipboard (1\-based)</param>
    /// <param name="Col">Column where to paste the clipboard (1\-based)</param>
    procedure PasteFromClipboard(const Row, Col: integer);

    /// <summary>
    /// Deletes the Horizontal page breaks at the specified row
    /// </summary>
    /// <remarks>
    /// If there is no page break on the row, nothing will happen and no exception will be raised
    /// </remarks>
    /// <param name="aRow">Row where the page break is.</param>                                  
    procedure DeleteHPageBreak(const aRow: word);
    
    /// <summary>
    /// Deletes the Vertical page breaks at the specified column.
    /// </summary>
    /// <remarks>
    /// If there is no page break on the column, nothing will happen and no exception will be raised
    /// </remarks>
    /// <param name="aCol">Column where the page break is.</param>                                  
    procedure DeleteVPageBreak(const aCol: word);

		/// <summary>
		/// Inserts an Horizontal Page Break at the specified row.
		/// </summary>
		/// <param name="aRow">Row where to insert the page break.</param>
    procedure InsertHPageBreak(const aRow: word);

		/// <summary>
		/// Inserts a Vertical Page Break at the specified column.
		/// </summary>
		/// <param name="aCol">Column where to insert the page break.</param>
    procedure InsertVPageBreak(const aCol: word);

    /// <summary>
    /// True if there is a page break at the specified row
    /// </summary>
    /// <remarks>
    /// Read this function to know it there is a page break on a row.
    /// </remarks>
    /// <param name="Row">Row you want to test for a page break.</param>
    function HasHPageBreak(const Row: integer): boolean;

    /// <summary>
    /// True if there is a page break at the specified column
    /// </summary>
    /// <remarks>
    /// Read this function to know it there is a page break on a column.
    /// </remarks>
    /// <param name="Col">Column you want to test for a page break.</param>
    function HasVPageBreak(const Col: integer): boolean;

    /// <summary>
    /// Margins used when printing the sheet
    /// </summary>
    /// <remarks>
    /// Read or write this property to control the margins on the printed page. All numbers are on inches.
    /// </remarks>                                                                                        
    property PrintMargins: TXlsMargins read GetPrintMargins write SetPrintMargins;

		/// <summary>
		/// When true the sheet will print horizontally centered on the page.
		/// </summary>
    property PrintHCentered: boolean read GetPrintHCentered write SetPrintHCentered;

		/// <summary>
		/// When true the sheet will print vertically centered on the page.
		/// </summary>
    property PrintVCentered: boolean read GetPrintVCentered write SetPrintVCentered;

    /// <summary>
    /// Specifies whether to use the PrintScale or the PrintNumberOfHorizontalPages and
    /// PrintNumberOfVerticalPages properties to scale the printed page.
    /// </summary>
    /// <remarks>
    /// When False, PrintScale will be used to scale the printed page.<para></para>
    /// <para></para>
    /// When True, PrintNumberOfHorizontalPages and PrintNumberOfVerticalPages will be used.
    /// </remarks>                                                                          
    property PrintToFit: boolean read GetPrintToFit write SetPrintToFit;

    /// <summary>
    /// Miscellaneous printing options.
    /// </summary>
    /// <remarks>
    /// A lot of simple printing options are defined inside this property as bits inside the number. You can
    /// use the following constants or'ed together to set the options::
    ///
    /// <code lang="delphi">
    ///   fpo_LeftToRight = $01; //Print over, then down
    ///   fpo_Orientation = $02; //0= landscape, 1=portrait
    ///   fpo_NoPls = $04; //if 1, then PaperSize, Scale, Res, VRes, Copies, and Landscape data have not been obtained from the printer, so they are not valid.
    ///   fpo_NoColor = $08; //1= Black and white
    ///   fpo_Draft = $10; //1= Draft quality
    ///   fpo_Notes = $20; //1= Print Notes
    ///   fpo_NoOrient = $40; //1=orientation not set
    ///   fpo_UsePage = $80; //1=use custom starting page number.
    /// </code>
    ///
    /// </remarks>
    /// <example>
    ///  To set the printing orientation to landscape or portrait, you can use the following code:
    /// <code lang="delphi">
    /// if Landscape then
    /// begin
    ///    Xls.PrintOptions := TPrintOptions(integer(Xls.PrintOptions) and (not (integer(TPrintOptions.Orientation) or integer(TPrintOptions.NoPls)));
    /// end
    /// else
    /// begin
    ///    //ALWAYS SET NOPLS TO 0 BEFORE CHANGING THE OTHER OPTIONS.
    ///    Xls.PrintOptions := TPrintOptions(integer(Xls.PrintOptions) and (not integer(TPrintOptions.NoPls)));
    ///    Xls.PrintOptions := TPrintOptions(integer(Xls.PrintOptions) or integer(TPrintOptions.Orientation));
    ///  end;
    /// </code>
    /// </example>
    property PrintOptions: byte read GetPrintOptions write SetPrintOptions;

    /// <summary>
    /// Scale to print the page.
    /// </summary>
    /// <remarks>
    /// This number should be between 10 and 400, and is the scale in % that will be used to print the page.
    /// By default on a new sheet, this is 100%<para></para>
    /// <para></para>
    /// When PrintToFit is true, this property has no effect.<para></para>
    ///
    /// </remarks>
    property PrintScale: integer read GetPrintScale write SetPrintScale;

    /// <summary>
    /// Number of horizontal pages to fit the printing.
    /// </summary>
    /// <remarks>
    /// When PrintToFit is true, the sheet will be scaled to fit on
    /// at most PrintNumberOfHorizontalPages x
    /// PrintNumberOfVerticalPages <para></para>
    /// Some restrictions apply: The final scale will never be larger
    /// than 100% or smaller than 10%, even it the resulting number
    /// of pages is more than the specified. <para></para>
    /// When PrintToFit is false, this property has no effect and
    /// PrintScale is used instead. 
    /// </remarks>                                                     
    property PrintNumberOfHorizontalPages: word read GetPrintNumberOfHorizontalPages write SetPrintNumberOfHorizontalPages;

    /// <summary>
    /// Number of vertical pages to fit the printing.
    /// </summary>
    /// <remarks>
    /// When PrintToFit is true, the sheet will be scaled to fit on
    /// at most PrintNumberOfHorizontalPages x
    /// PrintNumberOfVerticalPages <para></para>
    /// Some restrictions apply: The final scale will never be larger
    /// than 100% or smaller than 10%, even it the resulting number
    /// of pages is more than the specified.  <para></para>
    /// When PrintToFit is false, this property has no effect and
    /// PrintScale is used instead. 
    /// </remarks>                                                     
    property PrintNumberOfVerticalPages: word read GetPrintNumberOfVerticalPages write SetPrintNumberOfVerticalPages;

    /// <summary>
    /// Pre-defined standard paper size.
    /// </summary>
    /// <remarks>
    /// If you want to set up a printer specific paper size, see
    /// PrinterDriverSettings 
    /// </remarks>                                                
    property PrintPaperSize: TExcelPaperSize read GetPrintPaperSize write SetPrintPaperSize;

    /// <summary>
    /// Number of copies to print.
    /// </summary>
    /// <remarks>
    /// This setting corresponds with the same setting in &quot;Page Settings&quot; in Excel.<para></para>
    /// </remarks>
    property PrintCopies: integer read GetPrintCopies write SetPrintCopies;

    /// <summary>
    /// Horizontal printer resolution in DPI.
    /// </summary>
    /// <remarks>
    /// This is the same setting you can set from &quot;Page Setup&quot; in Excel.<para></para>
    /// </remarks>                                                                             
    property PrintXResolution: integer read GetPrintXResolution write SetPrintXResolution;

    /// <summary>
    /// Vertical printer resolution in DPI.
    /// </summary>
    /// <remarks>
    /// This is the same setting you can set from &quot;Page Setup&quot; in Excel. 
    /// </remarks>                                                                 
    property PrintYResolution: integer read GetPrintYResolution write SetPrintYResolution;

    /// <summary>
    /// Reads and writes the printer driver settings of a file. This property is used to copy printer driver
    /// information from one file to other.
    /// </summary>
    /// <remarks>
    /// Excel stores printer settings in two places:
    /// 
    ///   1. <b>Standard printer settings</b>: You can set/read this with PrintPaperSize , PrintScale ,
    ///      PrintOptions (Landscape inside printOptions only), PrintXResolution , PrintYResolution and
    ///      PrintCopies
    /// 
    ///   2. <b>Printer driver settings</b>: You can access this with PrinterDriverSettings.
    /// 
    /// <b>NOTE THAT THOSE PLACES STORE DUPLICATED INFORMATION</b>. For example, Excel stores the PageSize on
    /// both Standard printer settings and Printer driver settings.<para></para>
    /// <para></para>
    /// Always that a value is stored on both places, Standard printer settings takes preference.<para></para>
    /// <para></para>
    /// If you set PaperSize=A4 on standard settings and PaperSize=A5 on driver settings, A4 will be used.<para></para>
    /// <para></para>
    /// Look at the example to see how to copy printer driver settings from one file to other.
    /// </remarks>
    /// <example>
    /// To copy the printer driver information from an empty template to the working file, use:
    /// <code lang="delphi">
    /// Xls1.PrinterDriverSettings := Xls2.PrinterDriverSettings;
    /// </code>
    /// 
    /// If you have defined a printer specific paper size, and you want to use it, you should call
    /// <code lang="delphi">
    /// Xls1.PrintPaperSize := Xls2.PrintPaperSize;
    /// </code>
    /// 
    /// </example>                                                                                                     
    property PrinterDriverSettings: TPrinterDriverSettings read GetPrinterDriverSettings write SetPrinterDriverSettings;

    /// <summary>
    /// The count of hyperlinks on the active sheet.
    /// </summary>                                  
    function HyperLinkCount: integer;

    /// <summary>
    /// \Returns the hyperlink at position index on the list.
    /// </summary>
    /// <param name="HyperLinkIndex">Index of the hyperlink (1 based).</param>
    function GetHyperLink(const HyperLinkIndex:integer):THyperLink; 

    /// <summary>
    /// Modifies an existing Hyperlink.
    /// </summary>
    /// <remarks>
    /// Use AddHyperLink to add a new one.
    /// </remarks>
    /// <param name="HyperLinkIndex">Index of the hyperlink (1 based).</param>
    /// <param name="value">Hyperlink description. </param>
    procedure SetHyperLink(const HyperLinkIndex:integer; const value: THyperLink);

		/// <summary>
		/// \Returns the cell range a hyperlink refers to.
		/// </summary>
		/// <remarks>
		/// While normally hyperlinks refer to a single cell, you can make them point to a range. This method
		/// will return the first and last cell of the range that the hyperlink applies to.
		/// </remarks>
		/// <param name="hyperLinkIndex">Index of the hyperlink (1 based).</param>                           
    function GetHyperLinkCellRange(const HyperLinkIndex: integer):TXlsCellRange;

		/// <summary>
		/// Changes the cells an hyperlink is linked to.
		/// </summary>
		/// <param name="hyperLinkIndex">Index of the hyperlink (1 based).</param>
		/// <param name="cellRange">Range of cells the hyperlink will refer to.</param>
    procedure SetHyperLinkCellRange(const HyperLinkIndex: integer; const CellRange:TXlsCellRange );

		/// <summary>
		/// Adds a new hyperlink to the Active sheet. Use SetHyperLink to modify an existing one.
		/// </summary>
		/// <param name="cellRange">Range of cells the hyperlink will refer to.</param>
		/// <param name="value">Description of the hyperlink.</param>
    procedure AddHyperLink(const CellRange: TXlsCellRange; const value: THyperLink);

		/// <summary>
		/// Deletes an existing hyperlink.
		/// </summary>
		/// <param name="hyperLinkIndex">Index of the hyperlink (1 based).</param>
    procedure DeleteHyperLink(const HyperLinkIndex: integer);

    /// <summary>
    /// \Returns the Outline level for a row.
    /// </summary>
    /// <remarks>
    /// It is a number between 0 and 7 that specifies the level on the outline.<para></para>
    /// <para></para>
    /// You can group columns with Tools-&gt;Group and Outline menu from Excel, or with SetRowOutlineLevel
    /// from FlexCel.
    /// </remarks>
    /// <param name="aRow">Row index (1 based)</param>                                                    
    function GetRowOutlineLevel(const aRow: integer): integer;

    /// <summary>
    /// Sets the Outline level for a row range.
    /// </summary>
    /// <remarks>
    /// Use this method to group rows in a sheet, the same way you do it from Excel with Tools-&gt;Group and
    /// Outline menu.
    /// </remarks>
    /// <param name="FirstRow">Row index of the first row on the range. (1 based)</param>
    /// <param name="LastRow">Row index of the last row on the range. (1 based)</param>
    /// <param name="Level">Outline level. must be between 0 and 7. </param>
    procedure SetRowOutlineLevel(const FirstRow, LastRow, Level: integer);

		/// <summary>
		/// \Returns the Outline level for a column.
		/// </summary>
		/// <remarks>
		/// It is a number between 0 and 7 that specifies the level on the outline.<para></para>
		/// <para></para>
		/// You can group columns with Tools-&gt;Group and Outline menu from Excel, or with SetRowOutlineLevel
		/// from FlexCel.
		/// </remarks>
		/// <param name="aCol">Column index (1 based)</param>                                                 
    function GetColOutlineLevel(const aCol: integer):integer;

    /// <summary>
    /// Sets the Outline level for a column range.
    /// </summary>
    /// <remarks>
    /// Use this method to group rows in a sheet, the same way you do it from Excel with Tools-&gt;Group and
    /// Outline menu.
    /// </remarks>
    /// <param name="FirstCol">Column index of the first column on the range. (1 based)</param>
    /// <param name="LastCol">Column index of the last column on the range. (1 based)</param>
    /// <param name="Level">Outline level. must be between 0 and 7. </param>
    procedure SetColOutlineLevel(const FirstCol, LastCol, Level: integer);

    /// <summary>
    /// Determines whether the summary rows should be below or above
    /// details on outline.
    /// </summary>
    /// <remarks>
    /// This property corresponds with the setting in Excel. 
    /// </remarks>                                                    
    property OutlineSummaryRowsBelowDetail: boolean read GetOutlineSummaryRowsBelowDetail write SetOutlineSummaryRowsBelowDetail;

    /// <summary>
    /// Determines whether the summary columns should be right to or
    /// left to the details on outline.
    /// </summary>
    /// <remarks>
    /// This property corresponds with the setting in Excel.
    /// </remarks>
    property OutlineSummaryColsRightOfDetail: boolean read GetOutlineSummaryColsRightOfDetail write SetOutlineSummaryColsRightOfDetail;

    /// <summary>
    /// This handles the setting of Automatic Styles inside the
    /// outline options.
    /// </summary>
    /// <remarks>
    /// You can change the Automatic Styles setting on outlines with
    /// this property.
    /// </remarks>                                                    
    property OutlineAutomaticStyles: boolean read GetOutlineAutomaticStyles write SetOutlineAutomaticStyles;

    /// <summary>
    /// Sets and Gets the value of the Dates 1904 setting for this
    /// \file.
    /// </summary>
    /// <remarks>
    /// Excel has 2 different date systems. On windows systems it
    /// uses 1900 based dates, and on Macintosh systems it uses 1904
    /// dates. You can change this on Excel under Options, and this
    /// property allows you to know and change which format is being
    /// used.
    /// </remarks>                                                    
    property Options1904Dates: boolean read GetOptions1904Dates write SetOptions1904Dates;

    /// <summary>
    /// Sets and Gets the value of the R1C1 setting for this file.
    /// </summary>
    /// <remarks>
    /// Use this property to know or change the reference system used
    /// in Excel.
    /// </remarks>                                                     
    property OptionsR1C1: boolean read GetOptionsR1C1 write SetOptionsR1C1;

    /// <summary>
    /// Sets and Gets the value of the SaveExternal Link Values
    /// setting for this file.
    /// </summary>
    /// <remarks>
    /// This property has the value of the corresponding option on
    /// Excel options. 
    /// </remarks>                                                  
    property OptionsSaveExternalLinkValues: boolean read GetOptionsSaveExternalLinkValues write SetOptionsSaveExternalLinkValues;

    /// <summary>
    /// Sets and Gets the value of the Precision as displayed setting
    /// for this file.
    /// </summary>
    /// <remarks>
    /// This property has the value of the corresponding option on
    /// Excel options.
    /// </remarks>
    property OptionsPrecisionAsDisplayed: boolean read GetOptionsPrecisionAsDisplayed write SetOptionsPrecisionAsDisplayed;

		/// <summary>
		/// Determines if the file is a template (xlt format instead of xls). Both file formats are nearly identical, but there is an extra record
		/// needed so the file is a proper xlt template.
		/// </summary>
    property IsXltTemplate: boolean read GetIsXltTemplate write SetIsXltTemplate;

    /// <summary>
    /// Freezes the panes on the active sheet.
    /// </summary>
    /// <remarks>
    /// This command is equivalent to Menu-&gt;Window-&gt;Freeze Panes. It will freeze the rows and columns
    /// above and to the left from cell. Note that because Excel works this way, when you SplitWindow the
    /// panes are suppressed and vice-versa See also GetFrozenPanes.
    /// </remarks>
    /// <param name="Row">Row where to freeze the pane. Use 0 to unfreeze any exiting pane.</param>
    /// <param name="Col">Column where to freeze the pane. Use 0 to unfreeze any exiting pane.</param>     
    procedure FreezePanes(const Row, Col: integer);

    /// <summary>
    /// \Returns the cell that is freezing the window.
    /// </summary>
    /// <remarks>
    /// If the window is not frozen, this method will return the cell &quot;A1&quot;
    /// </remarks>
    /// <param name="Row">Row of the cell.</param>
    /// <param name="Col">Column of the cell.</param>
    /// <seealso cref="FreezePanes"/>
    procedure GetFrozenPanes(out Row, Col: integer);

    /// <summary>
    /// This command is equivalent to Menu-&gt;Window-&gt;Split.
    /// </summary>
    /// <remarks>
    /// It will split the window in 4 regions. Note that because Excel works this way, when you FreezePanes
    /// (TCellAddress) the windows are unsplitted and vice-versa See also GetSplitWindow
    /// </remarks>
    /// <param name="xOffset">Offset from the left on 1/20 of a point. Zero for no vertical split. (A point
    ///                       is 1/72 of an inch)</param>
    /// <param name="yOffset">Offset from the top on 1/20 of a point. Zero for no horizontal split. (A point
    ///                       is 1/72 of an inch)</param>
    procedure SplitWindow(const xOffset, yOffset: integer);

    /// <summary>
    /// \Returns the horizontal and vertical offsets for the split windows.
    /// </summary>
    /// <remarks>
    /// Zero means no split. See also SplitWindow
    /// </remarks>
    /// <param name="xOffset">Offset from the left on 1/20 of a point. Zero for no vertical split. (A point
    ///                       is 1/72 of an inch)</param>
    /// <param name="yOffset">Offset from the top on 1/20 of a point. Zero for no vertical split. (A point
    ///                       is 1/72 of an inch)</param>                                                  
    procedure GetSplitWindow(out xOffset, yOffset: integer);

    /// <summary>
    /// Autofits a range of rows so they adapt their height to show all the text inside. Note that due to GDI+ / GDI incompatibilities,
    /// the height calculated by FlexCel will not be exactly the same than the one calculated by Excel. So when you open this workbook
    /// in Excel, Excel will re calculate the row heights to what it believe is best. You can change this behaviour specifying keepHeightAutomatic = false.
    /// </summary>
    /// <param name="row1">First row to autofit.</param>
    /// <param name="row2">Last row to autofit.</param>
    /// <param name="AutofitNotAutofittingRows">When you are autofitting a range of rows, some rows might not be
    /// set to Autofit in Excel. When this parameter is true, those rows will be autofitted anyway.</param>
    /// <param name="keepHeightAutomatic">If true, rows will be still autoheight when you open the file in Excel, so Excel
    /// will recalculate the values, probably changing the page breaks. If you set it to false, rows will be fixed in size,
    /// and when you open it on Excel they will remain so.</param>
    /// <param name="adjustment">You will normally want to set this parameter to 1, which means that autofit will be made with standard measurements.
    /// If you set it to for example 1.1, then rows will be adjusted to 110% percent of what their calculated height was.
    /// Use this parameter to fine-tune autofiting, if for example rows are too small when opening the file in Excel.</param>
    procedure AutofitRow(const row1, row2: integer; const AutofitNotAutofittingRows: Boolean; const keepHeightAutomatic: Boolean; const adjustment: extended);overload;

    /// <summary>
    /// Autofits a row so it adapts its height to show all the text inside. It does not matter if the row is set to Autofit or not in Excel.
    /// Note that due to GDI+ / GDI incompatibilities,
    /// the height calculated by FlexCel will not be exactly the same than the one calculated by Excel. So when you open this workbook
    /// in Excel, Excel will re calculate the row heights to what it believe is best. You can change this behaviour specifying keepHeightAutomatic = false.
    /// </summary>
    /// <param name="row">Row to Autofit.</param>
    /// <param name="keepHeightAutomatic">If true, rows will be still autoheight when you open the file in Excel, so Excel
    /// will recalculate the values, probably changing the page breaks. If you set it to false, rows will be fixed in size,
    /// and when you open it on Excel they will remain so.</param>
    /// <param name="adjustment">You will normally want to set this parameter to 1, which means that autofit will be made with standard measurements.
    /// If you set it to for example 1.1, then rows will be adjusted to 110% percent of what their calculated height was.
    /// Use this parameter to fine-tune autofiting, if for example rows are too small when opening the file in Excel.</param>
    procedure AutofitRow(const row: integer; const keepHeightAutomatic: Boolean; const adjustment: extended);overload;

    /// <summary>
    /// Autofits a column so it adapts its width to show all the text inside.
    /// </summary>
    /// <param name="col">Column to Autofit.</param>
    /// <param name="ignoreStrings">When true, strings will not be considered for the autofit. Only numbers will.</param>
    /// <param name="adjustment">You will normally want to set this parameter to 1, which means that autofit will be made with standard measurements.
    /// If you set it to for example 1.1, then columns will be adjusted to 110% percent of what their calculated width was.
    /// Use this parameter to fine-tune autofiting, if for example columns are too small when opening the file in Excel.</param>
    procedure AutofitCol(const Col: integer; const IgnoreStrings: Boolean; const Adjustment: extended);overload;

    /// <summary>
    /// Autofits a range of columns so they adapt their width to show all the text inside.
    /// </summary>
    /// <param name="col1">First column to Autofit.</param>
    /// <param name="col2">Last column to Autofit.</param>
    /// <param name="ignoreStrings">When true, strings will not be considered for the autofit. Only numbers will.</param>
    /// <param name="adjustment">You will normally want to set this parameter to 1, which means that autofit will be made with standard measurements.
    /// If you set it to for example 1.1, then columns will be adjusted to 110% percent of what their calculated width was.
    /// Use this parameter to fine-tune autofiting, if for example columns are too small when opening the file in Excel.</param>
    procedure AutofitCol(const Col1, Col2: integer; const IgnoreStrings: Boolean; const Adjustment: extended);overload;

    /// <summary>
    /// Autofits all rhe rows on all sheets on a workbook that are set to autofit so they adapt their height to show all the text inside.
    /// Note that due to GDI+ / GDI incompatibilities,
    /// the heights calculated by FlexCel will not be exactly the same than the ones calculated by Excel. So when you open this workbook
    /// in Excel, Excel might re calculate the row heights to what it believe is best. You can change this behaviour specifying keepSizesAutomatic = false.
    /// </summary>
    /// <param name="AutofitNotAutofittingRows">When you are autofitting a range of rows, some rows might not be
    /// set to Autofit in Excel. When this parameter is true, those rows will be autofitted anyway.</param>
    /// <param name="keepSizesAutomatic">
    /// When true, no modifications will be done to the "autofit" status of the rows. When false, all rows will be marked as "no autofit", so when you open this file
    /// in Excel it will not be resized by Excel, and the printing/export to pdf from Excel will be the same as FlexCel.
    /// </param>
    /// <param name="adjustment">You will normally want to set this parameter to 1, which means that autofit will be made with standard measurements.
    /// If you set it to for example 1.1, then rows will be adjusted to 110% percent of what their calculated height was.
    /// Use this parameter to fine-tune autofiting, if for example rows are too small when opening the file in Excel.</param>
    procedure AutofitRowsOnWorkbook(const AutofitNotAutofittingRows: Boolean; const KeepSizesAutomatic: Boolean; const Adjustment: extended);

		/// <summary>
		/// Converts a Double on Excel format for dates (Ole Automation Format) into a DateTime.
    /// It takes in account 1904 or 1904 dates in the open file.
		/// </summary>
		/// <param name="Date">Double you want to convert.</param>
		/// <returns>The value as DateTime.</returns>
    function FromOADate(const Date: double): TDateTime;

		/// <summary>
		/// Converts a DateTime into a Double on Excel format for dates (Ole Automation Format).
		/// </summary>
		/// <param name="Date">DateTime you want to convert.</param>
    /// It takes in account 1904 or 1904 dates in the open file.
		/// <returns>The value as a double on Excel format.</returns>
    function ToOADate(const Date: TDateTime): double;

    /// <summary>
    /// Sets the AutoFilter in the Active sheet to point ot the range specified.
    /// </summary>
    /// <param name="row">Row where the AutoFilter will be placed (1 based).</param>
    /// <param name="col1">First column for the AutoFilter range (1 based).</param>
    /// <param name="col2">Last column for the AutoFilter range (1 based).</param>
    procedure SetAutoFilter(const row: Int32; const col1: Int32; const col2: Int32);overload;

    /// <summary>
    /// Sets an AutoFilter in a cell range. Note that the bottom coordinate of the range will be ignored, since AutoFilters
    /// use only one row.
    /// </summary>
    /// <param name="range">Range to set the AutoFilter. If range is null, this method does nothing. The bottom coordinate on range will not be used.</param>
    procedure SetAutoFilter(const range: TXlsCellRange);overload;

    /// <summary>
    /// Removes the AutoFilter from the active sheet. If there is no AutoFilter in the sheet, this method does nothing.
    /// </summary>
    procedure RemoveAutoFilter();

    /// <summary>
    /// Returns true if the active sheet has any AutoFilter defined.
    /// </summary>
    /// <returns>True if the active sheet has an AutoFilter, false otherwise.</returns>
    function HasAutoFilter(): Boolean;overload;

    /// <summary>
    /// Returns true if a cell has an AutoFilter.
    /// </summary>
    /// <param name="row">Row of the cell we want to find out. (1 based)</param>
    /// <param name="col">Column of the cell we want to find out. (1 based)</param>
    /// <returns>True if the cell has an AutoFilter, false otherwise.</returns>
    function HasAutoFilter(const row: Int32; const col: Int32): Boolean;overload;

    /// <summary>
    /// Returns the range of cells with AutoFilter in the Active sheet, or null if there is not AutoFilter. The "Bottom"
    /// coordinate of the returned range has no meaning, only Top, left and right are used. (since AutoFilters only have one row).
    /// </summary>
    /// <returns></returns>
    function GetAutoFilterRange(): TXlsCellRange;


  published
    /// <summary>
    /// Adapter this component will use to access the actual file.
    /// </summary>
    /// <remarks>
    /// This property is connected with a TXLSAdapter you must drop into the Datamodule.<para></para>
    /// <para></para>
    /// The Adapter component is the one doing the real work, and this way you can change the kind of file
    /// generated just by modifying the associated adapter.
    /// </remarks>
    property Adapter: TExcelAdapter read FAdapter write SetAdapter;
    { Published declarations }
  end;

implementation
{ TFlexCelImport }

procedure TFlexCelImport.CloseFile;
begin
  FActiveFileName:='';
  if Workbook=nil then exit;
  try
    Workbook.CloseFile;
  except
    //nothing;
  end; //Except
  try
    Workbook.Disconnect;
  except
    //nothing;
  end; //Except
  FreeAndNil(Workbook);
end;

procedure TFlexCelImport.DeleteRows(const aRow, aCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteRows(aRow, aCount);
end;

procedure TFlexCelImport.DeleteCols(const aCol, aCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteCols(aCol, aCount);
end;

destructor TFlexCelImport.Destroy;
begin
  CloseFile;
  inherited;
end;

function TFlexCelImport.GetActiveSheet: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ActiveSheet;
end;

function TFlexCelImport.GetCellValue(Row, Col: integer): variant;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.CellValue[Row, Col];
end;

function TFlexCelImport.GetComments(Row, Pos: integer): variant;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.CommentText[Row, Pos];
end;

function TFlexCelImport.GetCommentsCount(Row: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CommentsCount[Row];
end;

function TFlexCelImport.GetMaxRow: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.MaxRow;
end;

function TFlexCelImport.GetMaxCol: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.MaxCol;
end;

function TFlexCelImport.GetSheetCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.SheetCount;
end;

function TFlexCelImport.GetActiveSheetName: UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.ActiveSheetName;
end;

function TFlexCelImport.GetActiveSheetCodeName: UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.ActiveSheetCodeName;
end;

procedure TFlexCelImport.InsertAndCopyRows(const FirstRow, LastRow,
  DestRow, aCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InsertAndCopyRows(FirstRow, LastRow, DestRow, aCount, False);
end;

procedure TFlexCelImport.InsertAndCopyCols(const FirstCol, LastCol,
  DestCol, aCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InsertAndCopyCols(FirstCol, LastCol, DestCol, aCount, False);
end;

function TFlexCelImport.IsLoaded: boolean;
begin
  Result:= Workbook<>nil;
end;

procedure TFlexCelImport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FAdapter then
        FAdapter:= nil;
  end;
end;

procedure TFlexCelImport.OpenFile(const FileName: TFileName);
begin
  if FAdapter=nil then raise Exception.Create(ErrNoAdapter);
  CloseFile;
  Workbook:=FAdapter.GetWorkbook;
  try
    Workbook.Connect;
    Workbook.OpenFileAndSearch(FileName);
    FActiveFileName:=FileName;
    if Workbook.ActiveSheet<=Workbook.SheetCount then
       Workbook.SelectSheet(Workbook.ActiveSheet)
       else Workbook.SelectSheet(1);
  except
    CloseFile;
    raise;
  end;
end;

procedure TFlexCelImport.Save(const FileName: TFileName);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.Save(true, FileName, nil);
  FActiveFileName:=FileName;
end;

procedure TFlexCelImport.SaveToStream(const DataStream: TStream);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.Save(true, '', nil, nil, DataStream);
end;

procedure TFlexCelImport.SetActiveSheet(const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ActiveSheet:=Value;
  Workbook.SelectSheet(Value);
end;

procedure TFlexCelImport.SetAdapter(const Value: TExcelAdapter);
begin
  FAdapter := Value;
end;

procedure TFlexCelImport.SetCellValue(Row, Col: integer;
  const Value: variant);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.CellValue[Row, Col]:= Value;
end;

procedure TFlexCelImport.SetComments(Row, Pos: integer;
  const Value: variant);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AssignComment(Row, Pos, Value);
end;

procedure TFlexCelImport.SetActiveSheetName(const Value: UTF16String);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ActiveSheetName:=Value;

end;

procedure TFlexCelImport.SetActiveSheetCodeName(const Value: UTF16String);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ActiveSheetCodeName:=Value;

end;

function TFlexCelImport.IsEmptyRow(const aRow: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.IsEmptyRow(aRow);
end;

function TFlexCelImport.GetColumnWidth(aCol: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ColumnWidth[aCol];
end;

function TFlexCelImport.GetRowHeight(aRow: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RowHeight[aRow];
end;

procedure TFlexCelImport.SetColumnWidth(aCol: integer; Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ColumnWidth[aCol]:=Value;
end;

procedure TFlexCelImport.SetRowHeight(aRow: integer; Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RowHeight[aRow]:=Value;
end;

function TFlexCelImport.GetColumnHidden(const aCol: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ColumnHidden[aCol];
end;

function TFlexCelImport.GetRowHidden(const aRow: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RowHidden[aRow];
end;

procedure TFlexCelImport.SetColumnHidden(const aCol: integer; const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ColumnHidden[aCol]:=Value;
end;

procedure TFlexCelImport.SetRowHidden(const aRow: integer;const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RowHidden[aRow]:=Value;
end;

function TFlexCelImport.GetIsFormula(Row, Column: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CellValueX[Row, Column].IsFormula;
end;


function TFlexCelImport.GetIsXltTemplate: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.IsXltTemplate;
end;

function TFlexCelImport.GetAutoFilterRange: TXlsCellRange;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result := Workbook.GetAutoFilterRange;
end;

function TFlexCelImport.GetAutoRowHeight(Row: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.AutoRowHeight[Row];
end;

procedure TFlexCelImport.SetAutoFilter(const range: TXlsCellRange);
begin
  SetAutoFilter(range.Top, range.Left, range.Right);
end;

procedure TFlexCelImport.SetAutoFilter(const row, col1, col2: Int32);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetAutoFilter(row, col1, col2);
end;

procedure TFlexCelImport.SetAutoRowHeight(Row: integer; const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AutoRowHeight[Row]:=Value;
end;

function TFlexCelImport.GetCellFormat(Row, Col: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CellValueX[Row, Col].XF;
end;

procedure TFlexCelImport.SetCellFormat(Row, Col: integer;
  const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.CellFormat[Row, Col]:=Value;
end;

function TFlexCelImport.GetCell(Row, Col: integer): TXlsCellValue;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CellValueX[Row, Col];
end;

procedure TFlexCelImport.SetCell(Row, Col: integer;
  const Value: TXlsCellValue);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.CellValueX[Row, Col]:=Value;
end;

function TFlexCelImport.GetColorPalette(index: TColorPaletteRange): LongWord;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.ColorPalette[Index];
end;

function TFlexCelImport.GetUsedPaletteColors: BooleanArray;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.GetUsedPaletteColors;
end;

procedure TFlexCelImport.SetColorPalette(index: TColorPaletteRange;
  const Value: LongWord);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ColorPalette[Index]:=Value;
end;

function TFlexCelImport.GetColorPaletteCount: integer;
begin
  Result:=56;
end;


function TFlexCelImport.GetColumnFormat(aColumn: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ColumnFormat[aColumn];
end;

function TFlexCelImport.GetRowFormat(aRow: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RowFormat[aRow];
end;

procedure TFlexCelImport.SetColumnFormat(aColumn: integer;
  const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ColumnFormat[aColumn]:=Value;
end;

procedure TFlexCelImport.SetRowFormat(aRow: integer; const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RowFormat[aRow]:=Value;
end;

function TFlexCelImport.GetFontListCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.FontListCount;
end;

function TFlexCelImport.GetFormatListCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.FormatListCount;
end;

function TFlexCelImport.GetFlxFormatList(index: integer): TFlxFormat;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  if (Index<0) or (Index>=GetFormatListCount) then
    raise Exception.CreateFmt(ErrIndexOutBounds,[index,'FormatList',0,GetFormatListCount-1]);
  Result:=Workbook.FormatList[index];
end;

procedure TFlexCelImport.SetFlxFormatList(index: integer; Value: TFlxFormat);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  if (Index<0) or (Index>=GetFormatListCount) then
    raise Exception.CreateFmt(ErrIndexOutBounds,[index,'FormatList',0,GetFormatListCount-1]);
  Workbook.FormatList[index]:=Value;
end;

function TFlexCelImport.GetFlxFontList(index: integer): TFlxFont;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  if (Index<0) or (Index>=GetFontListCount) then
    raise Exception.CreateFmt(ErrIndexOutBounds,[index,'FontList',0,GetFontListCount-1]);
  Result:=Workbook.FontList[index];
end;

procedure TFlexCelImport.SetFlxFontList(index: integer; Value: TFlxFont);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  if (Index<0) or (Index>=GetFontListCount) then
    raise Exception.CreateFmt(ErrIndexOutBounds,[index,'FontList',0,GetFontListCount-1]);
  Workbook.FontList[index]:=Value;
end;

function TFlexCelImport.GetCellFormatDef1(aRow, aCol: integer): TFlxFormat;
var
  XF: integer;
begin
  XF:= CellFormat[aRow, aCol];
  if XF<0 then
  begin

    XF:=RowFormat[aRow];
    if XF<=0 then XF:=ColumnFormat[aCol];
  end;
  if (XF<0) then XF:=15;
  Result:=GetFlxFormatList(XF);
end;

function TFlexCelImport.AddFormat(const Fmt: TFlxFormat): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.AddFormat(Fmt);
end;

function TFlexCelImport.AddFont(const Fmt: TFlxFont): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.AddFont(Fmt);
end;

function TFlexCelImport.GetColByIndex(Row, ColIndex: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  if (ColIndex<=0) or (ColIndex>ColIndexCount[Row]) then
    raise Exception.CreateFmt(ErrIndexOutBounds,[ColIndex,'ColByIndex',1,ColIndexCount[Row]]);
  Result:=Workbook.ColByIndex(Row, ColIndex);
end;

function TFlexCelImport.GetColIndexCount(Row: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ColIndexCount(Row);
end;

function TFlexCelImport.GetColIndex(Row, Col: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ColIndex(Row, Col);
end;

function TFlexCelImport.GetDefaultColWidth: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.DefaultColWidth;
end;

function TFlexCelImport.GetDefaultRowHeight: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.DefaultRowHeight;
end;

function TFlexCelImport.GetShowGridLines: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ShowGridLines;
end;

procedure TFlexCelImport.SetShowGridLines(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ShowGridLines:=Value;
end;

procedure TFlexCelImport.SetShowGridHeaders(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ShowGridHeaders:=Value;
end;

function TFlexCelImport.GetShowGridHeaders: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.ShowGridHeaders;
end;

function TFlexCelImport.GetPrintGridLines: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintGridLines;
end;

function TFlexCelImport.GetPrintHCentered: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintHCentered;
end;

procedure TFlexCelImport.SetPrintGridLines(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintGridLines:=Value;
end;

procedure TFlexCelImport.SetPrintHCentered(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintHCentered := Value;
end;

function TFlexCelImport.GetPictureName(aPos: integer): UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PictureName[-1, aPos];
end;

function TFlexCelImport.GetPicturesCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PicturesCount[-1];
end;

procedure TFlexCelImport.AssignPicture(const aPos: integer;
  const Pic: ByteArray; const PicType: TXlsImgTypes);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AssignPicture(-1, aPos, Pic, PicType);
end;

procedure TFlexCelImport.AssignPicture(const aPos: integer;
  const Pic: ByteArray; const PicType: TXlsImgTypes; const Row, Col, dh, dw,
  ImgHeight, ImgWidth: integer; const Anchor: TFlxAnchorType);
begin
  AssignPicture(aPos, Pic, PicType);
  AssignPictureProperties(aPos, Row, Col, dh, dw, ImgHeight, ImgWidth, Anchor);
end;

procedure TFlexCelImport.AssignPictureProperties(const aPos, Row, Col, dh,
  dw, ImgHeight, ImgWidth: integer; const Anchor: TFlxAnchorType);
var
  Props: TImageProperties;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  CalcImgCells(Workbook, Row, Col, dh, dw, ImgHeight, ImgWidth, Props);
  Workbook.AssignPictureProperties(-1, aPos, Props, Anchor);
end;


procedure TFlexCelImport.GetPicture(const aPos: integer;
  const Pic: TStream; out PicType: TXlsImgTypes;
  out ClientAnchor: TClientAnchor);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.GetPicture(-1, aPos, Pic, PicType, ClientAnchor);
end;

function TFlexCelImport.CanOptimizeRead: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CanOptimizeRead;
end;


function TFlexCelImport.GetCellMergedBounds(aRow, aCol: integer): TXlsCellRange;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CellMergedBounds[aRow, aCol];
end;

procedure TFlexCelImport.MergeCells(const FirstRow, FirstCol, LastRow, LastCol: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.MergeCells(FirstRow, FirstCol, LastRow, LastCol);
end;

procedure TFlexCelImport.UnMergeCells(const FirstRow, FirstCol, LastRow, LastCol: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.UnMergeCells(FirstRow, FirstCol, LastRow, LastCol);
end;

function TFlexCelImport.GetCellMergedList(index: integer): TXlsCellRange;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CellMergedList[index];
end;

function TFlexCelImport.CellMergedListCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.CellMergedListCount;
end;


procedure TFlexCelImport.CopyToClipboard;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.CopyToClipboard;
end;

procedure TFlexCelImport.CopyToClipboard(Range: TXlsCellRange);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.CopyToClipboard(Range);
end;

procedure TFlexCelImport.PasteFromClipboard(const Row, Col: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PasteFromClipboard(Row, Col);
end;

procedure TFlexCelImport.RemoveAutoFilter;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RemoveAutoFilter;
end;

procedure TFlexCelImport.LoadFromStream(const DataStream: TStream);
begin
  if FAdapter=nil then raise Exception.Create(ErrNoAdapter);
  CloseFile;
  Workbook:=FAdapter.GetWorkbook;
  try
    Workbook.Connect;
    Workbook.LoadFromStream(DataStream);
  except
    CloseFile;
    raise;
  end;
end;

procedure TFlexCelImport.SetCellString(Row, Col: integer; const Text: UTF16String);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetCellString(Row, Col, Text);
end;

procedure TFlexCelImport.SetCellString(Row, Col: integer; const Text: UTF16String; const Fm: TFlxFormat);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetCellString(Row, Col, Text, Fm);
end;

procedure TFlexCelImport.SaveAsText(const FileName: TFileName; const Delimiter: Char);
var
  DataStream: TFileStream;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  DataStream:=TFileStream.Create(FileName, fmCreate);
  try
    SaveToStreamAsText(DataStream, Delimiter);
  finally
    FreeAndNil(DataStream);
  end; //finally
  FActiveFileName:=FileName;
end;

{$IFDEF DELPHI2008UP}
procedure TFlexCelImport.SaveAsText(const FileName: TFileName; const Delimiter: Char; const Encoding: TEncoding; const IncludeBOM: boolean);
var
  DataStream: TFileStream;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  DataStream:=TFileStream.Create(FileName, fmCreate);
  try
    SaveToStreamAsText(DataStream, Delimiter, Encoding, IncludeBOM);
  finally
    FreeAndNil(DataStream);
  end; //finally
  FActiveFileName:=FileName;
end;
{$ENDIF}

procedure TFlexCelImport.SaveToStreamAsText(const DataStream: TStream; const Delimiter: Char);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  SaveAsTextDelim(DataStream, Workbook, Delimiter);
end;

{$IFDEF DELPHI2008UP}
procedure TFlexCelImport.SaveToStreamAsText(const DataStream: TStream; const Delimiter: Char; const Encoding: TEncoding; const IncludeBOM: boolean);
var
  BOM: TBytes;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  if IncludeBOM then
  begin
    BOM := Encoding.GetPreamble;
    DataStream.Write(BOM[0], Length(BOM));
  end;
  SaveAsTextDelim(DataStream, Workbook, Delimiter, Encoding);
end;
{$ENDIF}

procedure TFlexCelImport.NewFile(const SheetCount: integer=3);
begin
  if FAdapter=nil then raise Exception.Create(ErrNoAdapter);
  CloseFile;
  Workbook:=FAdapter.GetWorkbook;
  try
    Workbook.Connect;
    Workbook.NewFile(SheetCount);
    if Workbook.ActiveSheet<=Workbook.SheetCount then
       Workbook.SelectSheet(Workbook.ActiveSheet)
       else Workbook.SelectSheet(1);
  except
    CloseFile;
    raise;
  end;
end;

procedure TFlexCelImport.LoadFromTextStream(const DataStream: TStream;
  const Delimiter: Char; const ColumnFormats: array of XLSColumnImportTypes);
begin
  NewFile;
  LoadFromTextDelim(DataStream, Workbook, Delimiter, 1, 1, ColumnFormats);
end;

{$IFDEF DELPHI2008UP}
procedure TFlexCelImport.LoadFromTextStream(const DataStream: TStream;
  const Delimiter: Char; const ColumnFormats: array of XLSColumnImportTypes; const Encoding: TEncoding; const DetectBOM: boolean);
begin
  NewFile;
  LoadFromTextDelim(DataStream, Workbook, Delimiter, 1, 1, ColumnFormats, Encoding, DetectBOM);
end;
{$ENDIF}

procedure TFlexCelImport.LoadFromTextStream(const DataStream: TStream;
  const Delimiter: Char);
begin
  LoadFromTextStream(DataStream, Delimiter, []);
end;

{$IFDEF DELPHI2008UP}
procedure TFlexCelImport.OpenText(const FileName: TFileName; const Delimiter: char; const ColumnFormats: array of XLSColumnImportTypes);
var
  DataStream: TStreamReader;
begin
  DataStream:=TStreamReader.Create(SearchPathStr(Adapter.BasePathToOpen, FileName), true);
  try
    NewFile;
    LoadFromTextDelim(DataStream, Workbook, Delimiter, 1, 1, ColumnFormats);
  finally
    FreeAndNil(DataStream);
  end; //finally
  FActiveFileName:=FileName;
end;

{$ELSE}

procedure TFlexCelImport.OpenText(const FileName: TFileName; const Delimiter: Char; const ColumnFormats: array of XLSColumnImportTypes);
var
  DataStream: TFileStream;
begin
  DataStream:=TFileStream.Create(SearchPathStr(Adapter.BasePathToOpen, FileName), fmOpenRead or fmShareDenyNone);
  try
    LoadFromTextStream(DataStream, Delimiter, ColumnFormats);
  finally
    FreeAndNil(DataStream);
  end; //finally
  FActiveFileName:=FileName;
end;
{$ENDIF}

procedure TFlexCelImport.OpenText(const FileName: TFileName; const Delimiter: Char);
begin
  OpenText(FileName, Delimiter,[]);
end;

function TFlexCelImport.HasAutoFilter: Boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result := Workbook.HasAutoFilter;
end;

function TFlexCelImport.HasAutoFilter(const row, col: Int32): Boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result := Workbook.HasAutoFilter(row, col);
end;

function TFlexCelImport.HasHPageBreak(const Row: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.HasHPageBreak(Row);
end;

function TFlexCelImport.HasVPageBreak(const Col: integer): boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.HasVPageBreak(Col);
end;

function TFlexCelImport.GetPrintMargins: TXlsMargins;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.Margins;
end;

procedure TFlexCelImport.SetPrintMargins(const Value: TXlsMargins);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.Margins:=Value;
end;

procedure TFlexCelImport.InsertHPageBreak(const aRow: word);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InsertHPageBreak(aRow);
end;

procedure TFlexCelImport.InsertVPageBreak(const aCol: word);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InsertVPageBreak(aCol);
end;

procedure TFlexCelImport.DeleteHPageBreak(const aRow: word);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteHPageBreak(aRow);
end;

procedure TFlexCelImport.DeleteVPageBreak(const aCol: word);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteVPageBreak(aCol);
end;

function TFlexCelImport.GetPageFooter: UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PageFooter;
end;

function TFlexCelImport.GetPageHeader: UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PageHeader;
end;

function TFlexCelImport.GetPrintNumberOfHorizontalPages: word;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintNumberOfHorizontalPages;
end;

function TFlexCelImport.GetPrintNumberOfVerticalPages: word;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintNumberOfVerticalPages;
end;

function TFlexCelImport.GetPrintScale: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintScale;
end;

function TFlexCelImport.GetPrintOptions: byte;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintOptions;
end;

function TFlexCelImport.GetPrintToFit: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintToFit;
end;

function TFlexCelImport.GetPrintVCentered: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintVCentered;
end;

procedure TFlexCelImport.SetPageFooter(const Value: UTF16String);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PageFooter:=Value;
end;

procedure TFlexCelImport.SetPageHeader(const Value: UTF16String);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PageHeader:=Value;
end;

procedure TFlexCelImport.SetPrintNumberOfHorizontalPages(
  const Value: word);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintNumberOfHorizontalPages:=Value;
end;

procedure TFlexCelImport.SetPrintNumberOfVerticalPages(const Value: word);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintNumberOfVerticalPages:=Value;
end;

procedure TFlexCelImport.SetPrintScale(const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintScale:=Value;
end;

procedure TFlexCelImport.SetPrintOptions(const Value: byte);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintOptions:=Value;
end;

procedure TFlexCelImport.SetPrintToFit(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintToFit:=Value;
end;


procedure TFlexCelImport.SetPrintVCentered(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
 Workbook.PrintVCentered := value;
end;

function TFlexCelImport.GetCellFormula(aRow, aCol: integer): UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.CellFormula[aRow, aCol];
end;

procedure TFlexCelImport.SetCellFormula(aRow, aCol: integer;
  const Value: UTF16String);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.CellFormula[aRow, aCol]:= Value;
end;

{$IFNDEF BCB}
{$IFDEF ConditionalExpressions}{$if CompilerVersion < 18}
function TFlexCelImport.DefaultFormat: TFlxFormat;
begin
  GetDefaultFormat(Result);
end;
{$IFEND}{$ENDIF} //Delphi 2006 or above
{$ENDIF}

procedure TFlexCelImport.GetDefaultFormat(out F:TFlxFormat);
begin
  F:=GetFlxFormatList($F);
end;

procedure TFlexCelImport.AddPicture(const Pic: ByteArray; const PicType: TXlsImgTypes;
  const Properties: TImageProperties; const Anchor: TFlxAnchorType);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AddImage(Pic, PicType, Properties, Anchor);
end;

procedure TFlexCelImport.AddPicture(const Pic: TStream;
  const PicType: TXlsImgTypes; const Properties: TImageProperties;
  const Anchor: TFlxAnchorType);
var
  s: ByteArray;
begin
  SetLength(s, Pic.Size);
  Pic.ReadBuffer(s[0], Pic.Size);
  AddPicture(s, PicType, Properties, Anchor);
end;

procedure TFlexCelImport.AddPicture(const Pic: TStream;
  const PicType: TXlsImgTypes; const Row, Col, dh, dw, ImgHeight,
  ImgWidth: integer; const Anchor: TFlxAnchorType);
var
  s: ByteArray;
begin
  SetLength(s, Pic.Size);
  Pic.ReadBuffer(s[0], Pic.Size);
  AddPicture(s, PicType, Row, Col, dh, dw, ImgHeight, ImgWidth, Anchor);
end;

procedure TFlexCelImport.AddPicture(const Pic: ByteArray;
  const PicType: TXlsImgTypes; const Row, Col, dh, dw, ImgHeight,
  ImgWidth: integer; const Anchor: TFlxAnchorType);
var
  Props: TImageProperties;
begin
  CalcImgCells(Workbook, Row, Col, dh, dw, ImgHeight, ImgWidth, Props);
  AddPicture(Pic, PicType, Props, Anchor);
end;

procedure TFlexCelImport.ClearPicture(const Index: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ClearImage(Index);
end;

procedure TFlexCelImport.DeletePicture(const Index: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteImage(Index);
end;

procedure TFlexCelImport.FindOnePart(const Text: UTF16String; const P1, P2, P3:integer; out Part: UTF16String);
var
  En: integer;
begin
  if P1>0 then
  begin
    En:=Length(Text)+1;
    if (P2>P1) and (P2<En) then En:=P2;
    if (P3>P1) and (P3<En) then En:=P3;
    Part:=Copy(Text,P1+2, En-(P1+2));
  end else Part:='';
  {
   * We can't do this here. If we do, and for example we have a header: &10&D (font 10, date), it will be
   * replaced with &1020/01/2004 which would mean font=1020. Also, if f.e. SheetName="Hoja&D", the &1 would be later replaced with a date.
  Part:=StringReplace(Part,'&A', ActiveSheetName, [rfReplaceAll, rfIgnoreCase]);
  Part:=StringReplace(Part,'&D', DateToStr(now), [rfReplaceAll, rfIgnoreCase]);
  Part:=StringReplace(Part,'&T', TimeToStr(now), [rfReplaceAll, rfIgnoreCase]);
  Part:=StringReplace(Part,'&P', IntToStr(PageNumber), [rfReplaceAll, rfIgnoreCase]);
  Part:=StringReplace(Part,'&N', IntToStr(PageCount), [rfReplaceAll, rfIgnoreCase]);
  Part:=StringReplace(Part,'&F', ExtractFileName(FActiveFileName), [rfReplaceAll, rfIgnoreCase]);
  Part:=StringReplace(Part,'&Z', ExtractFilePath(FActiveFileName), [rfReplaceAll, rfIgnoreCase]);
  }
end;

procedure TFlexCelImport.FillPageHeaderFooter(const Text: UTF16String; out Left, Center, Right: UTF16String);
var
  Pl, Pc, Pr: integer;
  aText: UTF16String;
begin
  if (copy(Text,1,2)<>'&L') and (copy(Text,1,2)<>'&R') and (copy(Text,1,2)<>'&C')then
    aText:='&C'+Text else aText:=Text;
  Pl:=pos('&L', aText);
  Pc:=pos('&C', aText);
  Pr:=pos('&R', aText);
  FindOnePart(aText, Pl, Pc, Pr, Left);
  FindOnePart(aText, Pc, Pl, Pr, Center);
  FindOnePart(aText, Pr, Pl, Pc, Right);
end;


function TFlexCelImport.GetSheetZoom: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.SheetZoom;
end;

procedure TFlexCelImport.SetSheetZoom(const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SheetZoom:=Value;
end;

function TFlexCelImport.GetCellComment(Row, Col: integer): UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.GetCellComment(Row, Col);
end;

procedure TFlexCelImport.SetCellComment(Row, Col: integer;
  const Value: UTF16String; const Properties: TImageProperties);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetCellComment(Row, Col, Value, Properties);
end;

procedure TFlexCelImport.SetCellComment(Row, Col: integer;
  const Value: UTF16String);
var
  Properties: TImageProperties;
  Cr: TXlsCellRange;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Cr:=Workbook.CellMergedBounds[Row, Col];
  CalcImgCells(Workbook, Row-1, Col+Cr.Right-Cr.Left+1, 8, 14, 75 , 130, Properties);
  SetCellComment(Row, Col, Value, Properties);
end;

function TFlexCelImport.NearestColorIndex(const aColor: TColor): integer;
begin
  Result := NearestColorIndex(aColor, nil);
end;

function TFlexCelImport.NearestColorIndex(const aColor: TColor; const UsedColors: BooleanArray): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= MatchNearestColor(Workbook, aColor, UsedColors);
end;

procedure TFlexCelImport.AssignCellFormulaX(const aRow, aCol: integer;
  const Formula: UTF16String; const FormulaResult: variant);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetCellFormulaX(aRow, aCol, Formula, FormulaResult);
end;

function TFlexCelImport.GetActiveSheetVisible: TXlsSheetVisible;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:= Workbook.ActiveSheetVisible;
end;

procedure TFlexCelImport.SetActiveSheetVisible(
  const Value: TXlsSheetVisible);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ActiveSheetVisible:=Value;
end;

procedure TFlexCelImport.InsertAndCopySheets(const CopyFromSheet,
  InsertBeforeSheet, SheetCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InsertAndCopySheets(CopyFromSheet, InsertBeforeSheet, SheetCount);
end;

procedure TFlexCelImport.InsertEmptySheets(const InsertBeforeSheet,
  SheetCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InsertAndCopySheets(-1, InsertBeforeSheet, SheetCount);
end;

function TFlexCelImport.GetExcelNameCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeCount;
end;

function TFlexCelImport.GetRangeC1(index: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeC1[index];
end;

function TFlexCelImport.GetRangeC2(index: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeC2[index];
end;

function TFlexCelImport.GetRangeName(index: integer): UTF16String;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeName[index];
end;

function TFlexCelImport.GetRangeR1(index: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeR1[index];
end;

function TFlexCelImport.GetRangeR2(index: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeR2[index];
end;

function TFlexCelImport.GetRangeSheet(index: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.RangeSheet[index];
end;

procedure TFlexCelImport.ClearSheet;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.ClearSheet;
end;

procedure TFlexCelImport.DeleteSheet(aSheetCount: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteSheet(aSheetCount);
end;

function TFlexCelImport.GetRTFRuns(Row, Col: integer): TRTFRunList;
var
  v: TXlsCellValue;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.GetCellValueX2(Row, Col, v , Result);
end;

procedure TFlexCelImport.SetRTFRuns(Row, Col: integer; const Value: TRTFRunList);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AssignCellValueX2(Row, Col, Cell[Row, Col] ,Value);
end;

function TFlexCelImport.GetWorkbook: TExcelFile;
begin
  GetWorkbook:=Workbook;
end;

procedure TFlexCelImport.AddHyperLink(const CellRange: TXlsCellRange;
  const value: THyperLink);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AddHyperLink(CellRange, value);
end;

procedure TFlexCelImport.DeleteHyperLink(const HyperLinkIndex: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.DeleteHyperLink(HyperLinkIndex);
end;

function TFlexCelImport.GetHyperLink(const HyperLinkIndex: integer): THyperLink;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.GetHyperLink(HyperLinkIndex)
end;

function TFlexCelImport.GetHyperLinkCellRange(const HyperLinkIndex: integer): TXlsCellRange;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.GetHyperLinkCellRange(HyperLinkIndex);
end;

function TFlexCelImport.HyperLinkCount: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.HyperLinkCount;
end;

procedure TFlexCelImport.SetHyperLink(const HyperLinkIndex: integer;const value: THyperLink);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetHyperLink(HyperLinkIndex, value);
end;

procedure TFlexCelImport.SetHyperLinkCellRange(
  const HyperLinkIndex: integer; const CellRange: TXlsCellRange);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetHyperLinkCellRange(HyperLinkIndex, CellRange);
end;

procedure TFlexCelImport.GetCellFormatDef(const aRow, aCol: integer; out F: TFlxFormat);
begin
  F:= GetCellFormatDef1(aRow, aCol);
end;

procedure TFlexCelImport.GetFormatList(const index: integer; out F: TFlxFormat);
begin
  F:=GetFlxFormatList(index);
end;

procedure TFlexCelImport.GetFontList(const index: integer;
  out F: TFlxFont);
begin
  F:=GetFlxFontList(index);
end;

procedure TFlexCelImport.SetFontList(index: integer; Value: TFlxFont);
begin
  SetFlxFontList(index, Value);
end;

procedure TFlexCelImport.SetFormatList(index: integer; Value: TFlxFormat);
begin
  SetFlxFormatList(index, Value);
end;

procedure TFlexCelImport.SetRangeC1(index: integer; const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RangeC1[index]:=Value;
end;

procedure TFlexCelImport.SetRangeC2(index: integer; const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RangeC2[index]:=Value;
end;

procedure TFlexCelImport.SetRangeR1(index: integer; const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RangeR1[index]:=Value;
end;

procedure TFlexCelImport.SetRangeR2(index: integer; const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.RangeR2[index]:=Value;
end;

function TFlexCelImport.GetColOutlineLevel(const aCol: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.GetColOutlineLevel(aCol);
end;

function TFlexCelImport.GetRowOutlineLevel(const aRow: integer): integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.GetRowOutlineLevel(aRow);
end;

procedure TFlexCelImport.SetColOutlineLevel(const FirstCol, LastCol,
  Level: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetColOutlineLevel(FirstCol, LastCol, Level);
end;

procedure TFlexCelImport.SetRowOutlineLevel(const FirstRow, LastRow,
  Level: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SetRowOutlineLevel(FirstRow, LastRow, Level);
end;

function TFlexCelImport.GetOptions1904Dates: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.Options1904Dates;
end;

function TFlexCelImport.GetOptionsPrecisionAsDisplayed: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.OptionsPrecisionAsDisplayed;
end;

function TFlexCelImport.GetOptionsR1C1: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.OptionsR1C1;
end;

function TFlexCelImport.GetOptionsSaveExternalLinkValues: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.OptionsSaveExternalLinkValues;
end;

procedure TFlexCelImport.SetOptions1904Dates(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.Options1904Dates:=Value;
end;

procedure TFlexCelImport.SetOptionsPrecisionAsDisplayed(
  const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.OptionsPrecisionAsDisplayed:=Value;
end;

procedure TFlexCelImport.SetOptionsR1C1(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.OptionsR1C1:=Value;
end;

procedure TFlexCelImport.SetOptionsSaveExternalLinkValues(
  const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.OptionsSaveExternalLinkValues:=Value;
end;

function TFlexCelImport.GetPrintCopies: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintCopies;
end;

function TFlexCelImport.GetPrintPaperSize: TExcelPaperSize;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintPaperSize;
end;

function TFlexCelImport.GetPrintXResolution: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintXResolution;
end;

function TFlexCelImport.GetPrintYResolution: integer;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrintYResolution;
end;

function TFlexCelImport.GetPrinterDriverSettings: TPrinterDriverSettings;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.PrinterDriverSettings;
end;

procedure TFlexCelImport.SetPrintCopies(const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintCopies:=Value;
end;

procedure TFlexCelImport.SetPrinterDriverSettings(
  const Value: TPrinterDriverSettings);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrinterDriverSettings:=Value;
end;

procedure TFlexCelImport.SetPrintPaperSize(const Value: TExcelPaperSize);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintPaperSize:=Value;
end;

procedure TFlexCelImport.SetPrintXResolution(const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintXResolution:=Value;
end;

procedure TFlexCelImport.SetPrintYResolution(const Value: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.PrintYResolution:=Value;
end;


procedure TFlexCelImport.FreezePanes(const Row, Col: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.FreezePanes(Row, Col);
end;

function TFlexCelImport.ToOADate(const Date: TDateTime): double;
begin
  if Workbook.Options1904Dates then
    Result := Double(Date) - Date1904Diff
  else
    Result := Double(Date);
end;

procedure TFlexCelImport.GetFrozenPanes(out Row, Col: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.GetFrozenPanes(Row, Col);
end;

procedure TFlexCelImport.GetSplitWindow(out xOffset, yOffset: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.GetSplitWindow(xOffset, yOffset);
end;

procedure TFlexCelImport.SplitWindow(const xOffset, yOffset: integer);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.SplitWindow(xOffset, yOffset);
end;

function TFlexCelImport.FromOADate(const Date: double): TDateTime;
begin
  if Workbook.Options1904Dates then
    Result := TDateTime(Date) + Date1904Diff
  else
    Result := TDateTime(Date);
end;

procedure TFlexCelImport.SetNamedRange(var NamedRange: TXlsNamedRange);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AddRange(NamedRange);
end;

function TFlexCelImport.GetOutlineSummaryColsRightOfDetail: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.OutlineSummaryColsRightOfDetail;
end;

function TFlexCelImport.GetOutlineSummaryRowsBelowDetail: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.OutlineAutomaticStyles;
end;

procedure TFlexCelImport.SetOutlineSummaryColsRightOfDetail(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.OutlineSummaryColsRightOfDetail := value;
end;

procedure TFlexCelImport.SetOutlineSummaryRowsBelowDetail(const Value: boolean);
begin
  Workbook.OutlineSummaryRowsBelowDetail := value;
end;

function TFlexCelImport.GetOutlineAutomaticStyles: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result:=Workbook.OutlineAutomaticStyles;
end;

procedure TFlexCelImport.SetOutlineAutomaticStyles(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.OutlineAutomaticStyles:=Value;
end;

procedure TFlexCelImport.AutofitCol(const Col: integer;
  const IgnoreStrings: Boolean; const Adjustment: extended);
begin
  AutofitCol(col, col, IgnoreStrings, Adjustment);
end;

procedure TFlexCelImport.AutofitCol(const Col1, Col2: integer;
  const IgnoreStrings: Boolean; const Adjustment: extended);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AutofitCol(col1, col2, ignoreStrings, adjustment);
end;

procedure TFlexCelImport.AutofitRowsOnWorkbook(
  const AutofitNotAutofittingRows, KeepSizesAutomatic: Boolean;
  const Adjustment: extended);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
	Workbook.AutofitRowsOnWorkbook(autofitNotAutofittingRows, keepSizesAutomatic, adjustment);
end;

procedure TFlexCelImport.AutofitRow(const row1, row2: integer;
  const AutofitNotAutofittingRows, keepHeightAutomatic: Boolean;
  const adjustment: extended);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.AutofitRow(row1, row2, AutofitNotAutofittingRows, keepHeightAutomatic, adjustment);
end;

procedure TFlexCelImport.AutofitRow(const row: integer;
  const keepHeightAutomatic: Boolean; const adjustment: extended);
begin
  AutofitRow(row, row, true, keepHeightAutomatic, adjustment);
end;

function TFlexCelImport.GetInvalidateFormulas: boolean;
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Result := Workbook.InvalidateFormulas;
end;

procedure TFlexCelImport.SetInvalidateFormulas(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.InvalidateFormulas := value;
end;


procedure TFlexCelImport.SetIsXltTemplate(const Value: boolean);
begin
  if Workbook=nil then raise Exception.Create(ErrNoOpenFile);
  Workbook.IsXltTemplate := value;
end;

end.
