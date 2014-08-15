{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCTMain;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  SysUtils,
  Classes,
  Controls,
  Graphics,
  TypInfo,
  ExtCtrls,

  ppComm,
  ppRelatv,
  ppClass,
  ppStrtch,
  ppDevice,
  ppDB,
  ppTypes,
  ppUtils,
  ppCTCell,
  ppDrwCmd,
  ppPrintr,
  ppEnum,
  ppRTTI;

const
  ciTextMargin = 1588;
  
type

  TppElement = class;
  TppDimension = class;
  TppColumnDef = class;
  TppRowDef = class;
  TppValueDef = class;
  TppValueCaptionDef = class;
  TppSubTotal = class;
  TppGrandTotal = class;

  TppCrossTabChildType = (ctctColumnDef, ctctRowDef, ctctValueDef, ctctTotalDef,
                          ctctTotalCaptionDef, ctctSubTotal, ctctColumnGrandTotal,
                          ctctRowGrandTotal, ctctValueCaptionDef);

  TppCrossTabPaginationType = (ctptAcrossThenDown, ctptDownThenAcross);

  TppTotalType = (ctttAll, ctttRow, ctttColumn);

  TppNullOrderType = (ctnoFirst, ctnoLast);

  TppOnCalcDimensionValue = procedure(Sender: TObject; aDimension: TppDimension; var aValue: Variant) of object;
  TppOnCompareDimensionValues = procedure(Sender: TObject; aDimension: TppDimension; aValue1, aValue2: Variant; var aResult: Integer) of object;
  TppOnFormatCell = procedure(Sender: TObject; aElement: TppElement; aColumn, aRow: Integer) of object;
  TppOnGetDimensionCaption = procedure(Sender: TObject; aDimension: TppDimension; var aCaption: String) of object;
  TppOnGetDimensionName = procedure(Sender: TObject; aDimension: TppDimension; var aName: String) of object;
  TppOnGetDimensionText = procedure(Sender: TObject; aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String;
                                    aValue: Variant; var aText: String) of object;
  TppOnGetDimensionValue = procedure(Sender: TObject; aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean) of object;
  TppOnGetTotalCaptionText = procedure(Sender: TObject; aElement: TppElement; aColumn, aRow: Integer; var aText: String) of object;
  TppOnTraverseRecord = procedure(Sender: TObject; aDataPipeline: TppDataPipeline; var aSkipRecord: Boolean) of object;

  TppCrossTabSaveRec = record
    FDrawComponent: Boolean;
    FDrawShifter: Boolean;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;

    FCrossTabId: Integer;
    FStartColumn: Integer;
    FStartRow: Integer;
  end; {record, TppCrossTabSaveRec}

  {@TppCrossTab

    You can use a CrossTab component when you want to display calculated
    values in a multi-dimensional grid format. You can define three types
    of dimensions: Columns, Rows and Values.  To define a dimension, first
    assign the DataPipeline property.  You can then select fields from the
    data pipeline as dimension values. This is usually done by right-
    clicking over the Crosstab component in the report designer and
    selecting the Configure... menu option.  A diagram of the crosstab
    definition is then displayed.  Here you can specify column dimensions
    by dragging fields from the field list into the 'New Column' cell.  Row
    and Value dimensions can be created by dragging fields into the 'New 
    Row' and 'New Value' cells.  Once your dimensions are defined, you can
    configure the 'look and feel' of your crosstab by selecting the
    dimension in the diagram and then using the formatting controls in the
    dialog.

    When the crosstab is generated, the row and column dimensions that you
    define become the captions which appear on the outside edges of the 
    crosstab grid.  The unique field values for each dimension become the
    caption values.  The value dimensions which correlate to the given row
    and column values are displayed within the grid. If there are no
    corresponding values for a given column/row pair, a blank is displayed.  
    Pictured below is the crosstab grid resulting from the selection of one
    column (Year), one row (State) and one value (Sum of AmountPaid.) from
    a data pipeline connected to the DBDemos customer table.

    <IMAGE CrossTabPreview>

    Crosstabs are usually constructed visually in the Report Designer,
    however, you can create and define a crosstab in code using the
    SelectColumnDef, SelectRowDef and SelectValueDef routines.  These 
    routines return the resulting TppDimension component, so that you can
    further configure the dimension (i.e. set the Color, Font,
    DisplayFormat, etc.)

    You can gain control over the crosstab calculation engine by assigning
    event handlers to the OnTraverseRecord (usually used to skip records
    which you don't want in the resulting grid), OnGetDimensionValue,
    OnGetDimensionCaption and OnCalcDimensionValue events.  These events
    allow you to control the grid cell content which is created from the
    data.

    Extensive sample reports which show the various capabilities of the
    crosstab component are provided in the RBuilder\\Demos\\CrossTabs
    directory.}

  {@TppCrossTab.AfterCalc

    This event occurs after the Matrix has been generated, but before
    anything has been rendered.  This event can be used to make changes to
    the matrix before it is rendered.}

  {@TppCrossTab.BeforeCalc

    This event fires before the engine begins applying the crosstab
    definition to the data.  Changes to the crosstab definition can be made
    here.}

  {@TppCrossTab.Calculating

    Indicates whether the crosstab calculation engine is running.  Each time a
    crosstab is generated, the calculation engine builds a Matrix of the values
    resulting from the calculations.  Once the matrix is complete, control is
    returned to the crosstab component which may then render that portion of the
    matrix which fits on the current page.  Whether or not the matrix is
    actually rendered depends upon the value of the Draw property.}

  {@TppCrossTab.Clear

    Clears all row, column and value definitions.  If the crosstab engine
    has generated a Matrix, then this is cleared as well.}

  {@TppCrossTab.ColumnDefCount

    The number of column dimensions that the crosstab contains.}

  {@TppCrossTab.ColumnDefs

    ColumnDef stands for 'column definition'.  Column definitions contain
    not only the value of the dimension (in the FieldName and FieldAlias
    properties), but also properties which describe how the dimension will
    be rendered in the crosstab grid.}

  {@TppCrossTab.ColumnGrandTotalCount

    The number of columnar grand total definitions in the crosstab. Because
    there is one columnar grand total for each value dimension, this value
    is always the same as the ValueDefCount.}

  {@TppCrossTab.ColumnGrandTotals

    You can use this property to retrieve the columnar grand total
    definition which corrensponds with a given value.  The columnar grand
    total definition determines how the grand total caption and value will
    be rendered in the crosstab grid.

    Because there is only one column in which the columnar grand totals
    appear, there is only one caption for all of the columnar grand totals
    (entitled 'Grand Total'.)  This differs from row grand totals, which
    have a row in the crosstab grid for each total.  For this reason, only
    the first columnar grand total definition is used to determine how the 
    'Grand Total' caption will appear. The CaptionDef for all subsequent
    columnar grand totals is ignored.

    The following diagram shows a crosstab with one column dimension and
    three value dimensions.  Each grand total value has been given a
    different color.  Notice how there is only one caption for the grand
    total column.

<IMAGE ThreeColumnGrandTotals>}

  {@TppCrossTab.DataPipeline

    The data pipeline from which the crosstab will be calculated. All of
    the fields of this data pipeline can be used to create column, row and
    value dimensions within the crosstab. This can be done visually using
    the crosstab configuration dialog, or via code using the
    SelectColumnDef, SelectRowDef and SelectValueDef routines.

    Note: Unlike subreports, it is not necessary to provide a crosstab
    component with its own individual data pipeline component. You can
    assign the crosstab to the same data pipeline being used by the report,
    detail band or subreport.  When the crosstab calculates, the engine
    will automatically save the current record position, goto to the first
    record, traverse all of the records and then restore the record
    position and data pipeline state when the calculations are complete.}

  {@TppCrossTab.Draw

    Defaults to True. Determines whether the crosstab will actually be
    rendered in the report.

    It is sometimes useful to turn draw off and use the crosstab component
    as a way of providing calculations in a report.  For example, you could
    place a crosstab component in the title band, configure to calculate a
    total and then in the AfterCalc event, transfer the result of the 
    calculation from the Matrix to a label or variable component.  This
    would create the effect of a 'two-pass' total without requiring  the 
    Report.PassSettting property to be set to two-pass.

    Another reason for disabling the crosstab's native rendering is to
    provide the information from the Matrix in a format different from the
    standard rendering style.  For simple crosstabs, setting Draw to False 
    and using the AfterCalc event is an easy way to accomplish this.

    Note: Setting Draw to False will keep the crosstab from rendering.
    Setting Visible to False will keep the crosstab from both generating
    and rendering.   Therefore, you will need to make sure that the Visible
    property is set to True if you intend to use the techniques described
    above.}

  {@TppCrossTab.GridLines

    Determines whether the lines which border the various information in
    the crosstab grid will appear.}

  {@TppCrossTab.Matrix

    The matrix is the internal 'spreadsheet' which results when the
    crosstab engine applies the crosstab definitions to the data supplied
    by the DataPipeline.  The matrix contains column headers, row headers,
    value calculations, subtotals and grand totals.}

  {@TppCrossTab.Modified

    Whether or not the crosstab definition has been modified. Modification
    can be anything from creating a new row or column definition to
    changing the display format of a value definition.}

  {@TppCrossTab.OnCalcDimensionValue

    Fires each time a value dimension has been calculated.  The dimension is
    passed via the aDimension property.  The current calculated value of the
    dimension is passed in the aValue property.  Use this event to make changes
    to a value after it has been calculated. To skip unwanted values or make
    changes before the calculation occurs, use OnGetDimensionValue.

    Note: This event is triggered for ValueDef components only.}

  {@TppCrossTab.OnCompareDimensionValues

    For ColumnDef and RowDef Dimensions with a SortType of stNone, this event
    can be used to implement a custom sort order. During the calculation process,
    the crosstab engine fires this event whenever two dimension values need to
    be compared to determine their collation relationship.

    Use the Dimension, Value1, and Value2 parameters to implement custom
    comparision logic. Set the Result parameter to -1, 0, 1.

    Example:

    <code>
       if aValue1 < aValue2 then
         aResult := -1
       else aValue1 > aValue2 then
         aResult := 1
       else
         aResult := 0;
    </code>

  }

  {@TppCrossTab.OnFormatCell

    This event fires before the formatting is applied to a given cell.
    This event fires once for every cell in the crosstab matrix.  You can
    use this event to provide dynamic formatting behavior such as varying
    the color  of each column in the crosstab.}

  {@TppCrossTab.OnGetCaptionText

    This event is triggered when any captions (any text which appears on
    the outside edge of the matrix) are retrieved and formatted, but before
    those captions are added to of the rendered report page.}

  {@TppCrossTab.OnGetDimensionCaption

    This event is triggered for row and column dimensions when generating
    the captions which appear at the outside edges of the crosstab grid.
    By default the caption for a given row or column is the value of the
    associated field converted to a string.  An example caption for a
    dimension assigned to a 'Country' field would be 'USA'. Once a caption
    is retrieved, it is placed in the grid, sorted alphabetically relative
    to other captions at the same level.

    Note: This event is triggered row for ColumnDef and RowDef components
    only.}

  {@TppCrossTab.OnGetDimensionName

    This event is triggered when the field label for the dimension is
    created. The field label is usually the Field Alias and appears only
    once in the first row or column of the Matrix.  Field labels show which
    fields were used to generate the crosstab.}

  {@TppCrossTab.OnGetDimensionValue

    Fires each time a value is retrieved from a field associated with a
    value dimension.  The dimension is passed via the aDimension property.
    The field value is passed in the aValue property.  If the value is
    invalid for some reason, you can instruct the engine to skip the
    calculation entirely by setting the aSkip parameter to True.

    Use this event to make changes to a value before it is calculated.  To
    make changes after the calculation is complete use
    OnCalcDimensionValue.

    Note: This event is triggered for ValueDef components only.  If you
    want to skip entire records (skip all dimensions), use
    OnTraverseRecord.}

  {@TppCrossTab.OnGetTotalCaptionText

    Fires each time the text for a total caption (such as a caption for a
    grand total, or dimension subtotal) is retrieved from the matrix in
    order to render the crosstab to the current page.}

  {@TppCrossTab.OnGetTotalValueText

    Fires each time the text for a total value (such as a grand total, or
    dimension subtotal) is retrieved from the matrix in order to render the
    crosstab to the current page.}

  {@TppCrossTab.OnGetValueText

    Fires each time the text for a value is retrieved from the matrix in
    order to render the crosstab on the current page.}

  {@TppCrossTab.OnPrint

    Fires each time a crosstab is rendered for a given page.  This event
    fires before the matrix is generated.  However, when crosstabs overflow
    onto additional pages, this event will still fire, so check OverFlow
    before attempting to change the crosstab definition or the matrix from
    this event. If OverFlow is True, then the matrix will exist and the
    crosstab definition cannot be modified.  If OverFlow is false then the
    Matrix will not exist and the crosstab definition could be modified.

    In practice it is probably easier to use the BeforeCalc and AfterCalc
    events, since the state of the crosstab is more clearly defined.}

  {@TppCrossTab.OnTraverseRecord

    Fires each time the crosstab engine traverses a record.  If you would
    like to prevent a particular record from displaying in the crosstab
    matrix, set the aSkipRecord parameter to True.  If you would like to
    skip records where a dimension value is null, use the SkipNulls
    property of dimensions.}

  {@TppCrossTab.Pagination

    This property determines the order in which crosstabs which do fit on a
    single page will print. These are the possible values:

    <Table>
    Value	              Meaning
    ------------------  --------
    ctptAcrossThenDown	Print all of the pages across the top of the matrix,
                        then print the next 'row' of pages, etc., etc until the
                        matrix is completely printed.
    ctptDownThenAcross	Print all of the pages down the side of the
                        matrix, then print the next 'column' of pages, etc, etc
                        until the matrix is completely printed.
    </Table>}

  {@TppCrossTab.ParentWidth

    The ParentWidth property determines whether the crosstab component spans the
    width the band.  You can set this property to false and resize the crosstab
    in order to create 'side-by-side' crosstabs.}

  {@TppCrossTab.RowDefCount

    The number of row dimensions that the crosstab contains.}

  {@TppCrossTab.RowDefs

    RowDef stands for 'row definition'.  Row definitions contain not only the
    value of the dimension (in the FieldName and FieldAlias properties), but
    also properties which describe how the dimension will be rendered in the
    crosstab grid.}

  {@TppCrossTab.RowGrandTotalCount

    The number of row grand total definitions in the crosstab. Because there is
    one columnar grand total for each value dimension, this value is always the
    same as the ValueDefCount}

  {@TppCrossTab.RowGrandTotals

    You can use this property to retrieve the row grand total definition which
    corrensponds with a given value.  The row grand total definition determines
    how the grand total caption and value will be rendered in the crosstab grid.

    The following diagram shows a crosstab with one row dimension and three
    value dimensions.  Each grand total value has been given a different color.
    Notice how each row grand total has its own caption.

    <IMAGE ThreeRowGrandTotals>}

  {@TppCrossTab.Save

    The Save property controls whether the crosstab component will be included
    when printing to a text file.  The order the component will be saved
    in, in relation to other components within the band is determined by
    the SaveOrder property.}

  {@TppCrossTab.SaveLength

    When printing to a text file with the TextFileType set to
    ftFixedLength, the SaveLength property specifies the field size for the
    components text value.  If the component text value is greater than
    this length, it is truncated.  If the text value length is less than
    the SaveLength, then spaces are padded onto the value.  Spaces are
    padded on the left, right, or both(for centered) depending on the
    Alignment property of the component}

  {@TppCrossTab.SaveOrder

    When printing to a text file with the property determines the relative
    position of the textual components within the line of text for the band.}

  {@TppCrossTab.SaveHeaders

    Defaults to False.  Controls whether the header text of a crosstab will be
    exported to the text file when the Save property is set to True.  The
    header text includes row and column headers as well as total headers.}

  {@TppCrossTab.Style

    Determines the 'look and feel' of the crosstab.  The are two styles
    currently provided with the crosstab component 'Standard' and 'Repeated
    Captions'. The Repeated Captions style forces the crosstab to reprint the
    appropriate row and column captions when a crosstab does not fit on a single
    page.}

  {@TppCrossTab.ValueDefCount

    The number of value dimensions that the crosstab contains.}

  {@TppCrossTab.ValueDefs

    ValueDef stands for 'value definition'.  Value definitions contain not only
    the value of the dimension (in the FieldName and FieldAlias properties), but
    also properties which describe how the dimension will be rendered in the
    crosstab grid.

    While the column and row definitions determine the 'captions' which will
    appear on the outside edges of the crosstab grid, the value defintions
    determine the actual calculations which will appear in the crosstab.}

  {@TppCrossTab.Visible

    The Visible property determines whether the crosstab component will be
    printed.  It is usually best to set this property in the BeforePrint event
    of the band containing the crosstab.

    Note: If Visible is set to False, then the crosstab grid will not be
    generated.  If you want to hide the crosstab rendering, but still generate
    the crosstab grid, use the Draw property.}

  TppCrossTab = class(TppStretchable)
    private
      FAfterCalc: TNotifyEvent;
      FAssigning: Boolean;
      FAvailableDimensions: TStrings;
      FBeforeCalc: TNotifyEvent;
      FCalculating: Boolean;
      FClearing: Boolean;
      FColumnDefs: TList;
      FColumnGrandTotals: TList;
      FCrossTabId: Integer;
      FDraw: Boolean;
      FEngine: TObject;
      FGridLines: Boolean;
      FLastCalcId: Integer;
      FStatusTimer: TObject;
      FModified: Boolean;
      FOnCalcDimensionValue: TppOnCalcDimensionValue;
      FOnCompareDimensionValues: TppOnCompareDimensionValues;
      FOnDimensionChange: TNotifyEvent;
      FOnDimensionChange2: TNotifyEvent;
      FOnFormatCell: TppOnFormatCell;
      FOnGetCaptionText: TppOnGetDimensionText;
      FOnGetDimensionName: TppOnGetDimensionName;
      FOnGetDimensionCaption: TppOnGetDimensionCaption;
      FOnGetDimensionValue: TppOnGetDimensionValue;
      FOnGetTotalCaptionText: TppOnGetTotalCaptionText;
      FOnGetTotalValueText: TppOnGetDimensionText;
      FOnGetValueText: TppOnGetDimensionText;
      FOnTraverseRecord: TppOnTraverseRecord;
      FPagination: TppCrossTabPaginationType;
      FRenderer: TObject;
      FRowDefs: TList;
      FRowGrandTotals: TList;
      FSave: Boolean;
      FSaveLength: Integer;
      FSaveOrder: Integer;
      FSaveHeadings: Boolean;
      FStartColumn: Integer;
      FStartRow: Integer;
      FStyle: String;
      FValueDefs: TList;

      procedure DimensionAdded(aDimension: TppDimension);
      procedure DimensionRemoved(aDimension: TppDimension);
      function  GetColumnDef(aIndex: Integer): TppColumnDef;
      function  GetColumnDefCount: Integer;
      function  GetColumnGrandTotal(aIndex: Integer): TppGrandTotal;
      function  GetColumnGrandTotalCount: Integer;
      function  GetMatrix: TppMatrix;
      function  GetRowDef(aIndex: Integer): TppRowDef;
      function  GetRowDefCount: Integer;
      function  GetRowGrandTotal(aIndex: Integer): TppGrandTotal;
      function  GetRowGrandTotalCount: Integer;
      function  GetSaveOrder: TTabOrder;
      function  GetValueDef(aIndex: Integer): TppValueDef;
      function  GetValueDefCount: Integer;
      function  RestoreFieldToAvailableDimension(aDimension: TppDimension): Integer;
      procedure SetDraw(aValue: Boolean);
      procedure SetGridLines(aValue: Boolean);
      procedure SetModified(aValue: Boolean);
      procedure SetPagination(aValue: TppCrossTabPaginationType);
      procedure SetStyle(aValue: String);
      procedure ShowColumnGrandTotals(aValue: Boolean);
      procedure ShowRowGrandTotals(aValue: Boolean);
      procedure ShowColumnSubTotals(aValue: Boolean);
      procedure ShowRowSubTotals(aValue: Boolean);
      procedure ValueDefAdded(aValueDef: TppValueDef);
      procedure ValueDefMoved(aOldIndex, aNewIndex: Integer);
      procedure ValueDefRemoved(aValueDef: TppValueDef);

      {conversion for 5.10}
      procedure ReadCaption(Reader: TReader);
      procedure SetSave(Value: Boolean);
      procedure SetSaveLength(Value: Integer);
      procedure SetSaveOrder(Value: TTabOrder);

    protected
      function GetChildOwner: TComponent; override;
      procedure DefineProperties(Filer: TFiler); override;

      procedure SaveComponents(Proc: TGetChildProc); override;

      procedure CalcSpaceUsed; override;
      procedure CreateDrawCommand(aPage: TppPage); override;
      procedure DoOnDimensionChange;
      function  GetCaption: String; override;
      procedure SetBand(aBand: TppBand); override;
      procedure SetCaption(aCaption: String); override;
      procedure SetRegion(aComponent: TppComponent); override;
      procedure SetUnits(aUnits: TppUnitType); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      {overridden from relative}
      procedure AddChild(aChild: TppRelative); override;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); override;
      function  IndexOfChild(aChild: TppRelative): Integer; override;
      function  RemoveChild(aChild: TppRelative): Integer; override;

      procedure MoveChild(aChild: TppRelative; aNewIndex: Integer);

      procedure ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String); override;

      procedure Clear; override;
      function  HasColor: Boolean; override;
      function  HasFont: Boolean; override;
      function  IsDataAware: Boolean; override;
      procedure LanguageChanged; override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      function  Status: String;

      procedure CopyAvailableDimensions(aList: TStrings);
      function  DeselectColumnDef(aIndex: Integer): Integer;
      function  DeselectRowDef(aIndex: Integer): Integer;
      function  DeselectValueDef(aIndex: Integer): Integer;
      function  GetElement(aIndex: Integer): TppElement;
      function  IndexOfAvailableDimension(const aFieldAlias: String): Integer;
      function  IndexOfColumnGrandTotal(aGrandTotal: TppGrandTotal): Integer;
      function  IndexOfRowGrandTotal(aGrandTotal: TppGrandTotal): Integer;
      procedure InitAvailableDimensions;
      function  SelectColumnDef(aIndex: Integer): TppColumnDef;
      function  SelectRowDef(aIndex: Integer): TppRowDef;
      function  SelectValueDef(aIndex: Integer): TppValueDef;
      procedure ShowGrandTotals(aTotalType: TppTotalType; aValue: Boolean);
      procedure ShowSubTotals(aTotalType: TppTotalType; aValue: Boolean);
      function  VisibleColumnGrandTotalCount: Integer;
      function  VisibleRowGrandTotalCount: Integer;

      {event triggers}
      procedure DoAfterCalc;
      procedure DoBeforeCalc;
      procedure DoOnCalcDimensionValue(aDimension: TppDimension; var aValue: Variant);
      procedure DoOnCompareDimensionValues(aDimension: TppDimension; aValue1, aValue2: Variant; var Result: Integer);
      procedure DoOnFormatCell(aElement: TppElement; aColumn, aRow: Integer);
      procedure DoOnGetCaptionText(aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String; aValue: Variant; var aText: String);
      procedure DoOnGetDimensionCaption(aDimension: TppDimension; var aCaption: String);
      procedure DoOnGetDimensionName(aDimension: TppDimension; var aName: String);
      procedure DoOnGetDimensionValue(aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean);
      procedure DoOnGetTotalCaptionText(aElement: TppElement; aColumn, aRow: Integer; var aText: String);
      procedure DoOnGetTotalValueText(aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String; aValue: Variant; var aText: String);
      procedure DoOnGetValueText(aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String; aValue: Variant; var aText: String);
      procedure DoOnTraverseRecord(aDataPipeline: TppDataPipeline; var aSkipRecord: Boolean);

      property Assigning: Boolean read FAssigning;
      property Calculating: Boolean read FCalculating;
      property ColumnDefCount: Integer read GetColumnDefCount;
      property ColumnDefs[Index: Integer]: TppColumnDef read GetColumnDef;
      property ColumnGrandTotalCount: Integer read GetColumnGrandTotalCount;
      property ColumnGrandTotals[Index: Integer]: TppGrandTotal read GetColumnGrandTotal;
      property DataField;
      property Matrix: TppMatrix read GetMatrix;
      property Modified: Boolean read FModified write SetModified;
      property OnDimensionChange: TNotifyEvent read FOnDimensionChange write FOnDimensionChange;
      property OnDimensionChange2: TNotifyEvent read FOnDimensionChange2 write FOnDimensionChange2;
      property RowDefCount: Integer read GetRowDefCount;
      property RowDefs[Index: Integer]: TppRowDef read GetRowDef;
      property RowGrandTotalCount: Integer read GetRowGrandTotalCount;
      property RowGrandTotals[Index: Integer]: TppGrandTotal read GetRowGrandTotal;
      property ValueDefCount: Integer read GetValueDefCount;
      property ValueDefs[Index: Integer]: TppValueDef read GetValueDef;

    published
      property AfterCalc: TNotifyEvent read FAfterCalc write FAfterCalc;
      property Anchors;
      property BeforeCalc: TNotifyEvent read FBeforeCalc write FBeforeCalc;
      property BottomOffset;
      property DataPipeline;
      property Draw: Boolean read FDraw write SetDraw default True;
      property GridLines: Boolean read FGridLines write SetGridLines default True;
      property Height;
      property Left;
      property MinHeight;
      property OnCalcDimensionValue: TppOnCalcDimensionValue read FOnCalcDimensionValue write FOnCalcDimensionValue;
      property OnFormatCell: TppOnFormatCell read FOnFormatCell write FOnFormatCell;
      property OnGetCaptionText: TppOnGetDimensionText read FOnGetCaptionText write FOnGetCaptionText;
      property OnGetDimensionName: TppOnGetDimensionName read FOnGetDimensionName write FOnGetDimensionName;
      property OnGetDimensionCaption: TppOnGetDimensionCaption read FOnGetDimensionCaption write FOnGetDimensionCaption;
      property OnGetDimensionValue: TppOnGetDimensionValue read FOnGetDimensionValue write FOnGetDimensionValue;
      property OnGetTotalCaptionText: TppOnGetTotalCaptionText read FOnGetTotalCaptionText write FOnGetTotalCaptionText;
      property OnGetTotalValueText: TppOnGetDimensionText read FOnGetTotalValueText write FOnGetTotalValueText;
      property OnGetValueText: TppOnGetDimensionText read FOnGetValueText write FOnGetValueText;
      property OnPrint; {needed to redeclare OnPrint so that DocOMatic can parse it in this class}
      property OnCompareDimensionValues: TppOnCompareDimensionValues read FOnCompareDimensionValues write FOnCompareDimensionValues;
      property OnTraverseRecord: TppOnTraverseRecord read FOnTraverseRecord write FOnTraverseRecord;
      property OverFlowOffset;
      property ParentDataPipeline;
      property ParentWidth default True;
      property Pagination: TppCrossTabPaginationType read FPagination write SetPagination default ctptDownThenAcross;
      property Save: Boolean read FSave write SetSave default False;
      property SaveLength: Integer read FSaveLength write SetSaveLength default 0;
      property SaveOrder: TTabOrder read GetSaveOrder write SetSaveOrder default -1;
      property SaveHeadings: Boolean read FSaveHeadings write FSaveHeadings default False;
      property ShiftRelativeTo;
      property StopPosition;
      property Stretch;
      property Style: String read FStyle write SetStyle;
      property Top;
      property Visible;
      property Width;


  end; {class, TppCrossTab}

  {@TppElement

    An element represents the basic building block of a crosstab
    definition.  Elements store the Font, cell Color, text Alignment and
    the DisplayFormat to be used when rendering the element in the crosstab 
    grid.  The following diagram shows a simple crosstab definition, each
    of the elements is labeled.

    <IMAGE CrossTabElements>

    Each element in this crosstab definition has a corresponding element
    class descendent.  The properties or classes corresponding to each 
    description are listed below:

    <Table>
    Description	                 Property
    -----------                  --------
    Column Dimension	           CrossTab.ColumnDefs
    Row Dimension	               CrossTab.RowDefs
    Value Dimension Caption	     ValueDef.CaptionDef
    Value Dimension Value	       CrossTab.ValueDefs
    Column SubTotal Caption	     SubTotal.CaptionDef*
    Column SubTotal Value	       SubTotal.ValueDef*
    Row SubTotal Caption	       SubTotal.CaptionDef
    Row SubTotal Value	         SubTotal.ValueDef
    Column Grand Total Caption	 GrandTotal.CaptionDef
    Column Grand Total Value	   GrandTotal.TotalDef
    Row Grand Total Caption	     GrandTotal.CaptionDef
    Row Grand Total Value	       GrandTotal.TotalDef
     </Table>

     *Not pictured in diagram.}

  {@TppElement.Alignment

    The Alignment property determines how a value is positioned when rendered in
    the crosstab.

    <Table>
    Value	          Meaning
    --------------  -----------
    taCenter        Caption is centered.
    taLeftJustify	  Caption is left justified.
    taRightJustify	Caption is right justified.
    </Table>}

  {@TppElement.Color

    Determines the color of the cell for the associated definition component.}

  {@TppElement.DisplayFormat

    This property controls how a value is displayed in the crosstab.  It is used
    by all crosstab definition elements.}

  {@TppElement.Font

    The font to be used when rendering any cells in the crosstab grid which are
    associated with this element.}

  {@TppElement.Visible

    This property controls whether the element is included in the crosstab grid.
    This property applies to subtotal and grand totals, as these are the only
    crosstab definition components which can be hidden.}

  TppElement = class(TppRelative)
    private
      FAlignment: TAlignment;
      FColor: TColor;
      FDataType: TppDataType;
      FDisplayFormat: String;
      FElementIndex: Integer;
      FFont: TFont;
      FName: String;
      FOnChange: TNotifyEvent;
      FVisible: Boolean;

      FLeft: Integer;
      FTop: Integer;
      FHeight: Integer;
      FWidth: Integer;
      FTextHeight: Integer;
      FTextWidth: Integer;

      procedure SetAlignment(aAlignment: TAlignment);
      procedure SetColor(aColor: TColor);
      procedure SetFont(aFont: TFont);
      procedure SetVisible(aValue: Boolean);

    protected
      procedure DoOnChange;

      procedure SetDisplayFormat(const aFormat: String); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      constructor CreateWithName(aOwner: TComponent; const aName: String);
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      function  CrossTab: TppCrossTab;

      function  GetName: String; virtual;
      function  GetDesignName: String; virtual;
      function  GetDataType: TppDataType; virtual;
      function  HasDisplayFormat: Boolean;

      procedure Modified;

      function DrawRect: TRect;

      property Left: Integer read FLeft write FLeft;
      property Top: Integer read FTop write FTop;
      property Width: Integer read FWidth write FWidth;
      property Height: Integer read FHeight write FHeight;
      property ElementIndex: Integer read FElementIndex write FElementIndex;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
      property TextWidth: Integer read FTextWidth write FTextWidth;
      property TextHeight: Integer read FTextHeight write FTextHeight;

      property Alignment: TAlignment read FAlignment write SetAlignment;
      property Color: TColor read FColor write SetColor;
      property DisplayFormat: String read FDisplayFormat write SetDisplayFormat;
      property Font: TFont read FFont write SetFont;
      property Visible: Boolean read FVisible write SetVisible default True;

    published
      property ChildType;

  end; {class, TppElement}

  {@TppDimension

    A dimension is a field from the DataPipeline which will be used to
    generate column captions, row captions or calculated values within the
    crosstab.  The descendants of the dimension class and their
    corresponding properties in the crosstab component are listed below:

    <Table>
    Component       Property
    ----------      ----------
    ColumnDef       ColumnDefs
    RowDef          RowDefs
    ValueDef        ValueDefs
    </Table>}

  {@TppDimension.FieldAlias

    The 'user-friendly' name of the field.  This value is displayed in the
    crosstab design dialog and is also used when creating the field labels which
    appear at the top left of the crosstab.}

  {@TppDimension.FieldName

    Used to retrieve the value of a field when a dimension is used in the
    generation of the crosstab grid.}

  {@TppDimension.NullOrder

    Determines if null values are shown first or last.}

  {@TppDimension.SkipNulls

    Defaults to True.  When retrieving a value for a column, row or value
    dimension, this property indicates whether the value should be skipped when
    it is null.

    Normally when a null or empty string is retrieved for a row or column
    dimension field, '(blank)' is displayed as the caption in the crosstab.
    When a null value is retrieved by a value dimension, it is treated as a
    zero.  Setting SkipNulls to False will cause the caption or value to be
    included in the crosstab.}

  {@TppDimension.SortType

    Determines how a row or column dimension will be ordered in the crosstab
    grid. Defaults to soAscending. Can be set to stNone to turn off sorting and
    optionally define a custom sort order by implementing the
    Crosstab.OnCompareDimensionValues event.

    Note: The sort order is always based on the field value returned from
    the data pipeline for the given field.  DisplayFormats have no effect
    on how dimension values are placed within the crosstab grid.}

  {@TppDimension.SubTotalCount

    The number of subtotal components contained within the dimension.  This
    property is used for column and row dimensions only.  This value should
    always be the same as the number of value dimensions in the crosstab
    (CrossTab.ValueDefCount), since each subtotal component corresponds to an
    individual value dimension.}

  {@TppDimension.SubTotals

    Each row and column dimension has a subtotal component which corresponds
    with each value dimension in the crosstab. That is, if you had a crosstab
    with two value dimensions (Sum of Amount Paid and Count of Amount Paid, for
    instance) then every row and column dimension in the crosstab would have two
    subtotal components.  These components allow you to specify the formatting
    of both the caption and value of the subtotals displayed in the crosstab
    grid.

    The subtotal components are automatically created or freed by the crosstab
    component when row or column dimensions are added or removed, or value
    dimensions are added or removed.

    Columnar SubTotals
    In order to get a better idea of what subtotals look like in a completed
    crosstab, a three column crosstab is pictured below.  Notice how the outer
    two column dimension have associated subtotals, while the innermost
    dimension (here City) does not have a subtotal. Also notice how column
    subtotals have only one caption at the top of the column, even though there
    are multiple value dimesions in this crosstab. The dotted lines indicate
    that columns have been removed in order to fit the diagram in this help
    topic.

    <IMAGE ThreeColumnsTwoValues>

    Row SubTotals
    Here we have a crosstab with three row dimensions and two values.  Notice
    how rows are generated for each value dimension at the value and subtotal
    levels. Once again the dotted lines indicate that rows have been removed.

    <IMAGE ThreeRowsTwoValues>}

  TppDimension = class(TppElement)
    private
      FFieldName: String;
      FFieldAlias: String;
      FNullOrder: TppNullOrderType;
      FSkip: Boolean;
      FSkipNulls: Boolean;
      FSortType: TppSortOrderType;
      FSubTotals: TList;

      function  GetSubTotal(aIndex: Integer): TppSubTotal;
      function  GetSubTotalCount: Integer;
      procedure SetNullOrder(aNullOrder: TppNullOrderType);
      procedure SetSortType(aSortType: TppSortOrderType);
      function  GetSkip: Boolean;

    protected
      function GetChildOwner: TComponent; override;
      procedure SaveComponents(Proc: TGetChildProc); override;

      procedure SetSkipNulls(aValue: Boolean); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      procedure AddChild(aChild: TppRelative); override;
      function  IndexOfChild(aChild: TppRelative): Integer; override;
      function  RemoveChild(aChild: TppRelative): Integer; override;

      procedure MoveChild(aChild: TppRelative; aNewIndex: Integer);

      procedure Clear;
      function  GetIndex: Integer;
      procedure ShowSubTotals(aValue: Boolean);

      function  GetCaption: String; virtual;
      function  GetFieldDataType: TppDataType;
      function  GetDataType: TppDataType; override;
      function  GetName: String; override;
      function  GetValue: Variant; virtual;

      property NullOrder: TppNullOrderType read FNullOrder write SetNullOrder default ctnoLast;
      property SubTotalCount: Integer read GetSubTotalCount;
      property SubTotals[Index: Integer]: TppSubTotal read GetSubTotal;
      property Skip: Boolean read GetSkip;
      property SkipNulls: Boolean read FSkipNulls write SetSkipNulls default True;
      property SortType: TppSortOrderType read FSortType write SetSortType default soAscending;

    published
      property FieldAlias: String read FFieldAlias write FFieldAlias;
      property FieldName: String read FFieldName write FFieldName;

  end; {class, TppDimension}

  {@TppColumnDef

    ColumnDef stands for 'Column Definition'.  A column definition
    represents a single field whose values are to be translated into column
    captions in the crosstab grid.  A crosstab may contain multiple column
    dimensions, in which case the captions are nested within the resulting
    crosstab grid.  Column dimensions are nested based on the order in
    which they appear in the ColumnDefs property of the crosstab.  The
    definition in the first position is the 'outermost' column, while the
    definition appearing in the next position is nested within and so on.
    A crosstab grid with two column dimensions (City, then Year) is
    pictured below:

    <IMAGE TwoColumnPreview>

    Here the city is the outermost column (ColumnDefs[0]) and the year is
    the innermost column (ColumnDefs[1]).  Because there is more than one
    column dimension, a subtotal at the city level is displayed.  The
    dotted line indicates that the crosstab continues for other cities
    before the grand total column is reached.

    You can control the font and cell color for the captions generated from
    a column dimension using the Font and Color properties.}

  TppColumnDef = class(TppDimension)
    public
      constructor Create(aOwner: TComponent); override;

    published
      property Alignment default taLeftJustify;
      property Color;
      property DisplayFormat;
      property FieldAlias;
      property FieldName;
      property Font;
      property NullOrder;
      property SkipNulls;
      property SortType;

  end; {class, TppColumnDef}

  {@TppRowDef

    RowDef stands for 'Row Definition'.  A row definition represents a
    single field whose values are to be translated into row captions in the
    crosstab grid.  A crosstab may contain multiple row dimensions, in
    which case the captions are nested within the resulting crosstab grid.
    Row dimensions are nested based on the order in which they appear in
    the RowDefs property of the crosstab.  The definition in the first
    position is the 'outermost' row, while the definition appearing in the
    next position is nested within and so on.  A crosstab grid with two row
    dimensions (City, then Year) is pictured below:

    <IMAGE TwoRowPreview>

    Here the city is the outermost row (RowDefs[0]) and the year is the
    innermost row (RowDefs[1]).  Because there is more than one row
    dimension, a subtotal at the city level is displayed.  The dotted lines
    indicate that the crosstab continues for other cities before the grand
    total row is reached.

    You can control the font and cell color for the captions generated from
    a row dimension using the Font and Color properties.}

  TppRowDef = class(TppDimension)
    public
      constructor Create(aOwner: TComponent); override;

    published
      property Alignment default taLeftJustify;
      property Color;
      property DisplayFormat;
      property FieldAlias;
      property FieldName;
      property Font;
      property NullOrder;
      property SkipNulls;
      property SortType;

  end; {class, TppRowDef}

  {@TppValueDef

    ValueDef stands for 'Value Definition'.  A value definition represents a
    single field whose values are to be translated into calculated values within
    the crosstab grid.  The type of calculation is determined by the CalcType
    property.  The cell color, font and display format of the calculated values
    is determined by the Color, Font and DisplayFormat properties respectively.
    You can force a value dimension to skip any null values encountered during
    the crosstab generation via the SkipNulls property.

    A crosstab may contain multiple value dimensions, in which case the values
    are listed in separate rows of the crosstab grid.  Value dimensions are
    listed based on the order in which they appear in the ValueDefs property of
    the crosstab.  The definition in the first position appears in the first
    row, and so on.  A crosstab grid with two value dimensions (Sum of Amount
    Paid, then Count of Amount Paid) is pictured below:

    <IMAGE TwoValues>

    There are no row or column dimensions declared for this crosstab, so only
    the values, as calculated for the entire table, are listed.

    One potential use of the crosstab component is to define multiple
    calculations for a given data pipeline and then set the Draw property to
    false.  You can then retrieve the calculated values from the crosstab matrix
    while the report is generating and transfer them to a either label or
    variable components.  In this way you can use the crosstab as a calculation
    engine and display the resulting values in a custom format.}

  TppValueDef = class(TppDimension)
    private
      FCaptionDef: TppValueCaptionDef;

      function  GetCalcType: TppDBCalcType;
      function  GetSkipNulls: Boolean;
      procedure SetCalcType(aCalcType: TppDBCalcType);

    protected
      procedure SetDisplayFormat(const aFormat: String); override;
      procedure SetSkipNulls(aValue: Boolean); override;
      
      {overridden from relative}
      procedure SaveComponents(Proc: TGetChildProc); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      {overridden from relative}
      procedure AddChild(aChild: TppRelative); override;
      function  RemoveChild(aChild: TppRelative): Integer; override;

      procedure DoOnCalcValue(var aValue: Variant);

      function  GetDesignName: String; override;
      function  GetName: String; override;
      function  GetDataType: TppDataType; override;

      property CalcType: TppDBCalcType read GetCalcType write SetCalcType;
      property CaptionDef: TppValueCaptionDef read FCaptionDef;
      property SkipNulls: Boolean read GetSkipNulls write SetSkipNulls;

    published
      property Alignment default taRightJustify;
      property Color;
      property DisplayFormat;
      property FieldAlias;
      property FieldName;
      property Font;
  end; {class, TppValueDef}

  {@TppValueCaptionDef

    The component can be used to set the cell color, font and alignment of the
    caption associated with a given value dimension.  This component can also be
    used to set the CalcType and SkipNulls property of the value dimension.

    This component was created as a way of differentiating the formatting of
    value's caption versus the formating of the calculated values resulting from
    the value.  In other words, it allows you to set the value caption in one
    color font and alignment, while setting the value in another.  This is
    especially useful when you have multiple value dimension in a crosstab and
    need total control over the value captions displayed to the left of the
    values in the crosstab.}

  {@TppValueCaptionDef.CalcType

    The CalcType property of the value dimension is stored using this property.
    You do not need to set this property directly, but can simply set the
    CalcType of the value dimension and this property will automatically be
    updated.}

  {@TppValueCaptionDef.SkipNulls

    The SkipNulls property of the value dimension is stored using this property.
    You do not need to set this property directly, but can simply set the
    SkipNulls property of the value dimension and this property will
    automatically be updated.}

  {@TppValueDef.CalcType

    Calculations are performed for the set of records which match the given
    column and row cell.  If there are no column or row dimensions, then
    calculations are performed for every record provided via the data pipeline.

    <Table>
    Value	      Meaning
    ---------   --------
    dcCount	     Count number of records in each set.
    dcSum	Sum    field value for each set of records.
    dcMinimum	   Calculate minimum field value each set of records.
    dcMaximum	   Calculate maximum field value for each set of records.
    dcAverage	   Calculate average for each set of records.
    </Table>

    In order to see what is meant by 'set of records' let's list a table of
    data, and then calculate crosstab values from it.  Let's assume the data
    look's like:

    State	SaleDate	Total Sales
    Texas	1/1/2000	100,000
    Texas	2/1/2000	90,000
    California	1/1/2000	40,000
    California	2/1/2000	50,000

    Let's say we create a crosstab with one column dimension on state and two
    value dimensions, one on 'Sum of Total Sales' and one on 'Count of Total
    Sales'.  This crosstab would generate two 'sets of records' one for Texas
    and one for California, each set containing two records. The resulting
    crosstab would be:

    State	Data	Total
    California	Sum of Total Sales	190,000
            Count of Total Sales	2
    Texas	Sum of Total Sales	90,000
            Count of Total Sales	2}

  {@TppValueDef.CaptionDef

    The caption definition determines the cell color, font and alignment for the
    caption associated with a crosstab value dimension.}

  {@TppValueDef.SkipNulls

    Defaults to False.  Normally null field values are treated as zeros by the
    value dimension. If SkipNulls is set to True, the value dimension will not
    include the nulls in calculations. The result of SkipNulls can usually be
    seen only in dimensions which have a CalcType of Count or Average, since
    these actually track the retrieval of each field value.}

  TppValueCaptionDef = class(TppElement)
    private
      FCalcType: TppDBCalcType;
      FSkipNulls: Boolean;

      procedure SetCalcType(aCalcType: TppDBCalcType);
      procedure SetSkipNulls(aValue: Boolean);

    public
      constructor Create(aOwner: TComponent); override;

      procedure Assign(Source: TPersistent); override;

      function  GetDesignName: String; override;
      function  GetName: String; override;

    published
      property Alignment default taLeftJustify;
      property CalcType: TppDBCalcType read FCalcType write SetCalcType;
      property Color;
      property Font;
      property SkipNulls: Boolean read FSkipNulls write SetSkipNulls default True;
  end; {class, TppValueCaptionDef}

  {@TppTotalDef

    Controls the properties of subtotals and grand totals.}
    
  TppTotalDef = class(TppElement)
    public
      constructor Create(aOwner: TComponent); override;

      function  GetDesignName: String; override;
      function  GetName: String; override;
      function  GetDataType: TppDataType; override;

    published
      property Alignment default taRightJustify;
      property Color;
      property DisplayFormat;
      property Font;
      property Visible;
  end; {class, TppTotalDef}

  {@TppTotalCaptionDef

    Controls the caption properties for total dimensions.}

  TppTotalCaptionDef = class(TppElement)
    public
      constructor Create(aOwner: TComponent); override;

      function  GetName: String; override;

    published
      property Alignment default taLeftJustify;
      property Color;
      property Font;
      property Visible;
  end; {class, TppTotalCaptionDef}

  {@TppTotal

    The total component provides the means to control the formatting for both
    the caption and values associated with any total.  This is done via the
    CaptionDef and TotalDef properties respectively.  These properties contain
    standard Element components, which allow you to define the font, color,
    aligment and display format of the associate grid cells.  In addition, the
    total component allows you to hide individual totals via the Visible
    property.

    Totals include both subtotals and grand totals.  When there is more than one
    row or column dimension, subtotals are calculated for all but the
    'innermost' dimension.  When there is at least one column dimension, a
    columnar grand total is calculated.  When there is at least one row
    dimension, row grand totals are calculated.}

  {@TppTotal.CaptionDef

    Determines the font, color and alignment of the total caption.}

  {@TppTotal.TotalDef

    Determines the font, color, alignment and display format of the total
    values.}

  {@TppTotal.ValueDefIndex

    All totals are associated with a value dimension.  This property indicates
    the position in the crosstab ValueDefs array property where that value def
    can be found.}

  {@TppTotal.Visible

    Pass-thru to the Visible property of the CaptionDef and TotalDef.

    When a total is hidden via the Visible property, it is not included in the
    matrix generated by the crosstab engine.  If you want to use a crosstab to
    calculate values and then display those values in a different format than
    the crosstab allows, try using the CrossTab.Draw property.}

  TppTotal = class(TppRelative)
    private
      FCaptionDef: TppTotalCaptionDef;
      FTotalDef: TppTotalDef;

      function  GetValueDefIndex: Integer;
      function  GetVisible: Boolean;
      procedure SetVisible(aValue: Boolean);

    protected
      function GetChildOwner: TComponent; override;
      procedure SaveComponents(Proc: TGetChildProc); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      {overridden from relative}
      procedure AddChild(aChild: TppRelative); override;
      function  RemoveChild(aChild: TppRelative): Integer; override;

      function  CrossTab: TppCrossTab;
      function  GetValueDef: TppValueDef;

      property CaptionDef: TppTotalCaptionDef read FCaptionDef;
      property TotalDef: TppTotalDef read FTotalDef;
      property Visible: Boolean read GetVisible write SetVisible;

    published
      property ChildType;
      property ValueDefIndex: Integer read GetValueDefIndex;

  end; {class, TppTotal}

  {@TppSubTotal

    Used to control the formatting of the caption and values associated with a
    subtotal. The caption can be controlled via the CaptionDef property; the
    value can be controlled via the TotalDef property.}

  TppSubTotal = class(TppTotal)
    public
      constructor Create(aOwner: TComponent); override;

      function  GetDimension: TppDimension;
  end; {class, TppSubTotal}

  {@TppGrandTotal
  
    Used to control the formatting of the caption and values associated
    with a grand total. The caption can be controlled via the CaptionDef
    property, while the value can be controlled via the TotalDef property.}

  TppGrandTotal = class(TppTotal)
  end; {class, TppGrandTotal}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppCrossTabRTTI }
  TraTppCrossTabRTTI = class(TraTppStretchableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCrossTabRTTI}

  {@TraTppElementRTTI }
  TraTppElementRTTI = class(TraTppRelativeRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppElementRTTI}

  {@TraTppDimensionRTTI }
  TraTppDimensionRTTI = class(TraTppElementRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDimensionRTTI}

  {@TraTppValueDefRTTI }
  TraTppValueDefRTTI = class(TraTppDimensionRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppValueDefRTTI}

  {@TraTppTotalRTTI }
  TraTppTotalRTTI = class(TraTppRelativeRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppTotalRTTI}


implementation

uses
  ppCTEng, ppCTRend;
  
{------------------------------------------------------------------------------}
{ ctDataTypeToDisplayString }

function ctDataTypeToDisplayString(aDataType: TppDataType; const aDisplayFormat: String): String;
var
  lValue: Variant;
begin

  Result := '';
  
  if (aDisplayFormat = '') then
      case aDataType of
        dtInteger, dtLongint:  Result := '1000';
        dtSingle, dtDouble, dtExtended: Result := '1000.00';
        dtCurrency: Result := '1000';
        dtDate:     Result := DateToStr(EncodeDate(2000, 1, 1));
        dtTime:     Result := TimeToStr(EncodeTime(3, 30, 0, 0));
        dtDateTime: Result := DateToStr(EncodeDate(2000, 1, 1) + EncodeTime(3, 30, 0, 0));
      end
  else
    begin
      case aDataType of
        dtInteger, dtLongint:  lValue := 1000;
        dtSingle, dtDouble, dtExtended: lValue := 1000.00;
        dtCurrency: lValue := 1000;
        dtDate:     lValue := EncodeDate(2000, 1, 1);
        dtTime:     lValue := EncodeTime(3, 30, 0, 0);
        dtDateTime: lValue := EncodeDate(2000, 1, 1) + EncodeTime(3, 30, 0, 0);
      end;

      Result := ppFormat(aDisplayFormat, aDataType, lValue)
    end;

end; {function, ctDataTypeToDisplayString}

{------------------------------------------------------------------------------}
{ ctAssignChild }

procedure ctAssignChild(aChild: TppRelative; aOwner: TComponent; aParent: TppRelative);
var
  lNewChild: TppRelative;
  lClass: TppRelativeClass;
begin

  if (aChild = nil) then Exit;

  {get an instance of the class}
  lClass := TppRelativeClass(aChild.ClassType);

  {instantiate a data view of the selected type}
  if (lClass <> nil) then
    begin
      lNewChild := lClass.Create(aOwner);
      lNewChild.Assign(aChild);
      lNewChild.ChildType := aChild.ChildType;
      lNewChild.Parent := aParent;
    end;

end; {procedure, ctAssignChild}

{------------------------------------------------------------------------------}
{ ctAssignChildren }

procedure ctAssignChildren(aList: TList; aOwner: TComponent; aParent: TppRelative);
var
  liIndex: Integer;
  lChild: TppRelative;
begin

  for liIndex := 0 to aList.Count - 1 do
    begin
      lChild := TppRelative(aList[liIndex]);

      ctAssignChild(lChild, aOwner, aParent);
  end; {each, child}

end; {procedure, ctAssignChildren}

{------------------------------------------------------------------------------}
{ ctFreeChildren }

procedure ctFreeChildren(aList: TList);
var
  liIndex: Integer;
begin

  for liIndex := aList.Count - 1 downto 0 do
    TppRelative(aList[liIndex]).Free;

  aList.Clear;

end; {procedure, ctFreeChildren}

{******************************************************************************
 *
 **  S T A T U S   T I M E R
 *
{******************************************************************************}

type

  {@TppCrossTabStatusTimer }
  TppCrossTabStatusTimer = class(TTimer)
    private
      FCrossTab: TppCrossTab;

      procedure TimerEvent(Sender: TObject);

    public
      constructor CreateTimer(aInterval: Integer; aCrossTab: TppCrossTab);

  end;

{------------------------------------------------------------------------------}
{ TppCrossTabStatusTimer.Create }

constructor TppCrossTabStatusTimer.CreateTimer(aInterval: Integer; aCrossTab: TppCrossTab);
begin

  inherited Create(aCrossTab);

  FCrossTab := aCrossTab;

  Interval := aInterval;

  OnTimer := TimerEvent;
  
end; {constructor, CreateTimer}

{------------------------------------------------------------------------------}
{ TppCrossTabStatusTimer.TimerEvent }

procedure TppCrossTabStatusTimer.TimerEvent(Sender: TObject);
begin
  FCrossTab.SetPrintMessage(FCrossTab.Status);
end; {procedure, TimerEvent}

{******************************************************************************
 *
 ** C R O S S T A B
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTab.Create }

constructor TppCrossTab.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {set inherited properties}
  CacheRecordSize := SizeOf(TppCrossTabSaveRec);
  ParentWidth := True;
  spHeight := 19;
  Stretch := True;

  FAssigning := False;
  FAvailableDimensions := TStringList.Create;
  FCalculating := False;
  FClearing := False;
  FColumnDefs := TList.Create;
  FColumnGrandTotals := TList.Create;
  FCrossTabId := 0;
  FDraw := True;
  FEngine := TppCrossTabEngine.Create(Self);
  FLastCalcId := -1;
  FStatusTimer := nil;
  FModified := False;
  FRowGrandTotals := TList.Create;
  FGridLines := True;
  FOnCalcDimensionValue := nil;
  FOnDimensionChange := nil;
  FOnDimensionChange2 := nil;
  FOnFormatCell := nil;
  FOnGetCaptionText := nil;
  FOnGetDimensionName := nil;
  FOnGetDimensionCaption := nil;
  FOnGetDimensionValue := nil;
  FOnGetValueText := nil;
  FOnGetTotalCaptionText := nil;
  FOnGetTotalValueText := nil;
  FOnTraverseRecord := nil;
  FPagination := ctptDownThenAcross;
  FRenderer := nil;
  FRowDefs := TList.Create;
  FStyle := TppCrossTabRenderer.Description;
  FValueDefs := TList.Create;

  FSaveLength    := 0;
  FSaveOrder     := -1;
  FSaveHeadings  := False;

  {properties inherited from TppPrintable}
  DefaultPropName     := 'DataPipeline';
  DefaultPropEditType := etDataPipelineList;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCrossTab.Destroy }

destructor TppCrossTab.Destroy;
begin

  Clear;

  FAvailableDimensions.Free;
  FColumnDefs.Free;
  FColumnGrandTotals.Free;
  FEngine.Free;
  FRenderer.Free;
  FRowGrandTotals.Free;
  FRowDefs.Free;
  FValueDefs.Free;

  inherited Destroy;

end; {destructor, Destroy}


{@TppCrossTab.Assign
 Assigns the contents of one crosstab component to another.  This includes all
 row, column and value definitions as well as any event handler assignments.
 The routine has been implemented such that a complete and exact copy of the
 original is created.

 Not included in the Assign are any properties or objects which make up the
 'state' of the crosstab (such as the Matrix object.)}

procedure TppCrossTab.Assign(Source: TPersistent);
var
  lCrossTab: TppCrossTab;
begin

  if not(Source is TppCrossTab) then Exit;

  FAssigning := True;

  {free all child objects}
  Clear;

  lCrossTab := TppCrossTab(Source);

  SetDataPipeline(lCrossTab.DataPipeline);

  ctAssignChildren(lCrossTab.FColumnGrandTotals, Self, Self);
  ctAssignChildren(lCrossTab.FRowGrandTotals, Self, Self);
  ctAssignChildren(lCrossTab.FColumnDefs, Self, Self);
  ctAssignChildren(lCrossTab.FRowDefs, Self, Self);
  ctAssignChildren(lCrossTab.FValueDefs, Self, Self);

  FAfterCalc := lCrossTab.FAfterCalc;
  FBeforeCalc := lCrossTab.FBeforeCalc;
  FGridLines := lCrossTab.FGridLines;
  FOnCalcDimensionValue := lCrossTab.FOnCalcDimensionValue;;
  FOnGetDimensionName := lCrossTab.FOnGetDimensionName;;
  FOnGetDimensionCaption := lCrossTab.FOnGetDimensionCaption;;
  FOnGetDimensionValue := lCrossTab.FOnGetDimensionValue;;
  FOnTraverseRecord := lCrossTab.FOnTraverseRecord;

  FAssigning := False;

  FModified := False;
  
end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetChildOwner }

function TppCrossTab.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppCrossTab.DefineProperties }

procedure TppCrossTab.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  {used for conversion to 5.10}
  Filer.DefineProperty('Caption', ReadCaption, nil, False);

end; {procedure, DefineProperties}


{------------------------------------------------------------------------------}
{ TppCrossTab.ConvertDataFieldNames }

procedure TppCrossTab.ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
var
  liIndex: Integer;
begin

  if (aDataPipeline <> DataPipeline) then Exit;

  inherited ConvertDataFieldNames(aDataPipeline, aOldFieldName, aNewFieldName);

  for liIndex := 0 to ColumnDefCount - 1 do
    if (ppEqual(ColumnDefs[liIndex].FieldName, aOldFieldName)) then
      ColumnDefs[liIndex].FieldName := aNewFieldName;

  for liIndex := 0 to RowDefCount - 1 do
    if (ppEqual(RowDefs[liIndex].FieldName, aOldFieldName)) then
      RowDefs[liIndex].FieldName := aNewFieldName;

  for liIndex := 0 to ValueDefCount - 1 do
    if (ppEqual(ValueDefs[liIndex].FieldName, aOldFieldName)) then
      ValueDefs[liIndex].FieldName := aNewFieldName;
  
end; {procedure, ConvertDataFieldNames}


{------------------------------------------------------------------------------}
{ TppCrossTab.ReadCaption }

procedure TppCrossTab.ReadCaption(Reader: TReader);
begin
  Reader.ReadString;
end; {procedure, ReadCaption}

{------------------------------------------------------------------------------}
{ TppCrossTab.Status }

function TppCrossTab.Status: String;
begin

  if (FEngine <> nil) and (FCalculating) then
    Result := TppCrossTabEngine(FEngine).Status

  else if (FRenderer <> nil) then
    Result := TppCustomCrossTabRenderer(FRenderer).Status

  else
    Result := '';

end; {function, MessageTimerEvent}

{------------------------------------------------------------------------------}
{ TppCrossTab.SaveComponents }

procedure TppCrossTab.SaveComponents(Proc: TGetChildProc);
var
  liIndex: Integer;
begin

  inherited SaveComponents(Proc);

  for liIndex := 0 to (FColumnGrandTotals.Count - 1) do
    Proc(FColumnGrandTotals[liIndex]);

  for liIndex := 0 to (FRowGrandTotals.Count - 1) do
    Proc(FRowGrandTotals[liIndex]);

  for liIndex := 0 to (FColumnDefs.Count - 1) do
    Proc(FColumnDefs[liIndex]);

  for liIndex := 0 to (FRowDefs.Count - 1) do
    Proc(FRowDefs[liIndex]);

  for liIndex := 0 to (FValueDefs.Count - 1) do
    Proc(FValueDefs[liIndex]);

end; {procedure, SaveComponents}

{------------------------------------------------------------------------------}
{ TppCrossTab.Clear }

procedure TppCrossTab.Clear;
begin

  FClearing := True;

  FAvailableDimensions.Clear;

  ctFreeChildren(FColumnGrandTotals);
  ctFreeChildren(FRowGrandTotals);
  ctFreeChildren(FColumnDefs);
  ctFreeChildren(FRowDefs);
  ctFreeChildren(FValueDefs);

  TppCrossTabEngine(FEngine).Clear;
  
  FClearing := False;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppCrossTab.Notify }

procedure TppCrossTab.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  {when datapipeline changes, update the design control caption}
  if (aOperation in [ppopDataChange, ppopRemove]) and (pppcDesigning in DesignState) and not(Printing) then
    InvalidateDesignControl;


end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnFormatCell }

procedure TppCrossTab.DoOnFormatCell(aElement: TppElement; aColumn, aRow: Integer);
var
  lParams: TraParamList;
begin

  if Assigned(FOnFormatCell) then FOnFormatCell(Self, aElement, aColumn, aRow);

  lParams := TraTppCrossTabRTTI.GetParams('OnFormatCell');
  lParams.CreateValuePointer(0, aElement);
  lParams.CreateValuePointer(1, aColumn);
  lParams.CreateValuePointer(2, aRow);

  SendEventNotify(Self, ciCrossTabFormatCell, lParams);

  lParams.Free;

end; {procedure, DoOnFormatCell}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetCaptionText }

procedure TppCrossTab.DoOnGetCaptionText(aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String; aValue: Variant; var aText: String);
var
  lParams: TraParamList;
  lsDisplayFormat: String;
begin

  if Assigned(FOnGetCaptionText) then FOnGetCaptionText(Self, aElement, aColumn, aRow, aDisplayFormat, aValue, aText);

  lsDisplayFormat := aDisplayFormat;

  lParams := TraTppCrossTabRTTI.GetParams('OnGetCaptionText');
  lParams.CreateValuePointer(0, aElement);
  lParams.CreateValuePointer(1, aColumn);
  lParams.CreateValuePointer(2, aRow);
  lParams.CreateValuePointer(3, lsDisplayFormat);
  lParams.CreateValuePointer(4, aValue);
  lParams.CreateValuePointer(5, aText);

  SendEventNotify(Self, ciCrossTabGetCaptionText, lParams);

  lParams.Free;

end; {procedure, DoOnGetCaptionText}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetTotalCaptionText }

procedure TppCrossTab.DoOnGetTotalCaptionText(aElement: TppElement; aColumn, aRow: Integer; var aText: String);
var
  lParams: TraParamList;
begin

  if Assigned(FOnGetTotalCaptionText) then FOnGetTotalCaptionText(Self, aElement, aColumn, aRow, aText);

  lParams := TraTppCrossTabRTTI.GetParams('OnGetTotalCaptionText');
  lParams.CreateValuePointer(0, aElement);
  lParams.CreateValuePointer(1, aColumn);
  lParams.CreateValuePointer(2, aRow);
  lParams.CreateValuePointer(3, aText);

  SendEventNotify(Self, ciCrossTabGetTotalCaptionText, lParams);

  lParams.Free;

end; {procedure, DoOnGetTotalCaptionText}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetTotalValueText }

procedure TppCrossTab.DoOnGetTotalValueText(aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String; aValue: Variant; var aText: String);
var
  lParams: TraParamList;
  lsDisplayFormat: String;
begin

  if Assigned(FOnGetTotalValueText) then FOnGetTotalValueText(Self, aElement, aColumn, aRow, aDisplayFormat, aValue, aText);

  lsDisplayFormat := aDisplayFormat;

  lParams := TraTppCrossTabRTTI.GetParams('OnGetTotalValueText');
  lParams.CreateValuePointer(0, aElement);
  lParams.CreateValuePointer(1, aColumn);
  lParams.CreateValuePointer(2, aRow);
  lParams.CreateValuePointer(3, lsDisplayFormat);
  lParams.CreateValuePointer(4, aValue);
  lParams.CreateValuePointer(5, aText);

  SendEventNotify(Self, ciCrossTabGetTotalValueText, lParams);

  lParams.Free;

end; {procedure, DoOnGetTotalValueText}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetValueText }

procedure TppCrossTab.DoOnGetValueText(aElement: TppElement; aColumn, aRow: Integer; const aDisplayFormat: String; aValue: Variant; var aText: String);
var
  lParams: TraParamList;
  lsDisplayFormat: String;
begin

  if Assigned(FOnGetValueText) then FOnGetValueText(Self, aElement, aColumn, aRow, aDisplayFormat, aValue, aText);

  lsDisplayFormat := aDisplayFormat;

  lParams := TraTppCrossTabRTTI.GetParams('OnGetValueText');
  lParams.CreateValuePointer(0, aElement);
  lParams.CreateValuePointer(1, aColumn);
  lParams.CreateValuePointer(2, aRow);
  lParams.CreateValuePointer(3, lsDisplayFormat);
  lParams.CreateValuePointer(4, aValue);
  lParams.CreateValuePointer(5, aText);

  SendEventNotify(Self, ciCrossTabGetValueText, lParams);

  lParams.Free;

end; {procedure, DoOnGetValueText}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnCalcDimensionValue }

procedure TppCrossTab.DoOnCalcDimensionValue(aDimension: TppDimension; var aValue: Variant);
var
  lParams: TraParamList;
begin

  if Assigned(FOnCalcDimensionValue) then FOnCalcDimensionValue(Self, aDimension, aValue);

  lParams := TraTppCrossTabRTTI.GetParams('OnCalcDimensionValue');
  lParams.CreateValuePointer(0, aDimension);
  lParams.CreateValuePointer(1, aValue);

  SendEventNotify(Self, ciCrossTabCalcDimensionValue, lParams);

  lParams.Free;

end; {procedure, DoOnCalcDimensionValue}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetDimensionCaption }

procedure TppCrossTab.DoOnGetDimensionCaption(aDimension: TppDimension; var aCaption: String);
var
  lParams: TraParamList;
begin

  if Assigned(FOnGetDimensionCaption) then FOnGetDimensionCaption(Self, aDimension, aCaption);

  lParams := TraTppCrossTabRTTI.GetParams('OnGetDimensionCaption');
  lParams.CreateValuePointer(0, aDimension);
  lParams.CreateValuePointer(1, aCaption);

  SendEventNotify(Self, ciCrossTabGetDimensionCaption, lParams);

  lParams.Free;

end; {procedure, DoOnGetDimensionCaption}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetDimensionName }

procedure TppCrossTab.DoOnGetDimensionName(aDimension: TppDimension; var aName: String);
var
  lParams: TraParamList;
begin

  if Assigned(FOnGetDimensionName) then FOnGetDimensionName(Self, aDimension, aName);

  lParams := TraTppCrossTabRTTI.GetParams('OnGetDimensionName');
  lParams.CreateValuePointer(0, aDimension);
  lParams.CreateValuePointer(1, aName);

  SendEventNotify(Self, ciCrossTabGetDimensionName, lParams);

  lParams.Free;

end; {procedure, DoOnGetDimensionName}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnGetDimensionValue }

procedure TppCrossTab.DoOnGetDimensionValue(aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean);
var
  lParams: TraParamList;
begin

  if Assigned(FOnGetDimensionValue) then FOnGetDimensionValue(Self, aDimension, aValue, aSkip);

  lParams := TraTppCrossTabRTTI.GetParams('OnGetDimensionValue');
  lParams.CreateValuePointer(0, aDimension);
  lParams.CreateValuePointer(1, aValue);
  lParams.CreateValuePointer(2, aSkip);

  SendEventNotify(Self, ciCrossTabGetDimensionValue, lParams);

  lParams.Free;

end; {procedure, DoOnGetDimensionValue}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnTraverseRecord }

procedure TppCrossTab.DoOnTraverseRecord(aDataPipeline: TppDataPipeline; var aSkipRecord: Boolean);
var
  lParams: TraParamList;
begin

  if Assigned(FOnTraverseRecord) then FOnTraverseRecord(Self, aDataPipeline, aSkipRecord);

  lParams := TraTppCrossTabRTTI.GetParams('OnTraverseRecord');
  lParams.CreateValuePointer(0, aDataPipeline);
  lParams.CreateValuePointer(1, aSkipRecord);

  SendEventNotify(Self, ciCrossTabTraverseRecord, lParams);

  lParams.Free;

end; {procedure, DoOnTraverseRecord}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoBeforeCalc }

procedure TppCrossTab.DoBeforeCalc;
begin

  if Assigned(FBeforeCalc) then FBeforeCalc(Self);

  SendEventNotify(Self, ciCrossTabBeforeCalc, nil);

end; {procedure, DoBeforeCalc}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoAfterCalc }

procedure TppCrossTab.DoAfterCalc;
begin

  if Assigned(FAfterCalc) then FAfterCalc(Self);

  SendEventNotify(Self, ciCrossTabAfterCalc, nil);

end; {procedure, DoAfterCalc}



{------------------------------------------------------------------------------}
{ TppCrossTab.SetStyle }

procedure TppCrossTab.SetStyle(aValue: String);
var
  lClass: TppCrossTabRendererClass;

begin

  if (FStyle = aValue) then Exit;

  lClass := ppRendererClassForDescription(aValue);

  {backward compatibility }
  if (lClass = nil) then
    lClass := ppRendererClassForName(aValue);

  if (lClass = nil) then Exit;

  FStyle := lClass.Description;

  FRenderer.Free;
  FRenderer := nil;

  SetModified(True);

end; {procedure, SetStyle}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetGridLines }

procedure TppCrossTab.SetGridLines(aValue: Boolean);
begin

  FGridLines := aValue;

  SetModified(True);

end; {procedure, SetGridLines}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetPagination }

procedure TppCrossTab.SetPagination(aValue: TppCrossTabPaginationType);
begin

  FPagination := aValue;

  SetModified(True);

end; {procedure, SetPagination}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetDraw }

procedure TppCrossTab.SetDraw(aValue: Boolean);
begin

  FDraw := aValue;

  SetModified(True);

end; {procedure, SetDraw}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetModified }

procedure TppCrossTab.SetModified(aValue: Boolean);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  FModified := aValue;

  PropertyChange;

  Reset;

end; {procedure, SetModified}


{@TppCrossTab.AddChild
 This routine is called whenever the Parent property of a row, column or value
 dimension is set to the crosstab component.  This routine should not be called
 directly - use the SelectColumnDef, SelectRowDef or SelectValueDef routines
 instead.}

procedure TppCrossTab.AddChild(aChild: TppRelative);
begin

  case TppCrossTabChildType(aChild.ChildType) of

    ctctColumnGrandTotal: FColumnGrandTotals.Add(aChild);

    ctctRowGrandTotal: FRowGrandTotals.Add(aChild);

    ctctRowDef:
      begin
        FRowDefs.Add(aChild);

        DimensionAdded(TppDimension(aChild));

        DoOnDimensionChange;
      end;

    ctctColumnDef:
      begin
        FColumnDefs.Add(aChild);

        DimensionAdded(TppDimension(aChild));

        DoOnDimensionChange;
      end;

    ctctValueDef:
      begin
        FValueDefs.Add(aChild);

        ValueDefAdded(TppValueDef(aChild));

        DoOnDimensionChange;
      end;

    else
      inherited AddChild(aChild);
  end;

  SetModified(True);

end; {procedure, AddChild}


{@TppCrossTab.MoveChild
 You can move a crosstab definition component to a different position relative
 to the other definitions of the same type using this method.  For example, you
 could change acrosstab which as defined with two column dimensions in the order
 Year, then State by calling MoveChild and changing the order to State, then
 Year.  This is what the crosstab dialog does when you drag dimensions within
 the diagram.

 The definition components, and their associated array properties are listed
 below:

 Component	        Property
 ColumnDef	        ColumnDefs
 RowDef	                RowDefs
 ValueDef	        ValueDefs
 GrandTotal (Column)	ColumnGrandTotals
 GrandTotal (Row)	RowGrandTotals

 Note: You should not move the grand total components as these are automatically
 maintained in the same order as their corresponding value dimensions.  That is,
 if you move a value dimension to a new position, the corresponding column and
 row grand totals will automatically be moved to that new position as well.
 Manually moving grand total definitions can cause the crosstab to generate
 improperly.}

procedure TppCrossTab.MoveChild(aChild: TppRelative; aNewIndex: Integer);
var
  liCurrentIndex: Integer;
begin

  liCurrentIndex := IndexOfChild(aChild);

  case TppCrossTabChildType(aChild.ChildType) of

    ctctColumnGrandTotal: FColumnGrandTotals.Move(liCurrentIndex, aNewIndex);
    ctctRowGrandTotal: FRowGrandTotals.Move(liCurrentIndex, aNewIndex);

    ctctRowDef:
      begin
        FRowDefs.Move(liCurrentIndex, aNewIndex);

        DoOnDimensionChange;
      end;

    ctctColumnDef:
      begin
        FColumnDefs.Move(liCurrentIndex, aNewIndex);

        DoOnDimensionChange;
      end;

    ctctValueDef:
      begin
        FValueDefs.Move(liCurrentIndex, aNewIndex);

        ValueDefMoved(liCurrentIndex, aNewIndex);

        DoOnDimensionChange;
      end;

  end;

  SetModified(True);

end; {procedure, MoveChild}


{@TppCrossTab.InsertChild
 This method is called when the Parent property of a crosstab definition
 component is assigned to the crosstab. You should not call this method
 directly, but should call SelectColumnDef, SelectRowDef or SelectValueDef
 instead, and then call MoveChild to position the resulting definition object.}

procedure TppCrossTab.InsertChild(aPosition: Integer; aChild: TppRelative);
begin

  case TppCrossTabChildType(aChild.ChildType) of

    ctctRowDef:
      begin
        FRowDefs.Insert(aPosition, aChild);

        DimensionAdded(TppDimension(aChild));
      end;

    ctctColumnDef:
      begin
        FColumnDefs.Insert(aPosition, aChild);

        DimensionAdded(TppDimension(aChild));
      end;

    ctctValueDef:
      begin
        FValueDefs.Insert(aPosition, aChild);

        ValueDefAdded(TppValueDef(aChild));
      end;

  end;

  SetModified(True);

end; {procedure, InsertChild}


{@TppCrossTab.IndexOfChild
 Given a definition component, returns the position of the component in the
 corresponding array property of the crosstab.  If the definition is not found,
 -1 is returned.

 The definition components, and their associated array properties are listed
 below:

 Component	        Property
 ColumnDef	        ColumnDefs
 RowDef	                RowDefs
 ValueDef	        ValueDefs
 GrandTotal (Column)	ColumnGrandTotals
 GrandTotal (Row)	RowGrandTotals}

function TppCrossTab.IndexOfChild(aChild: TppRelative): Integer;
begin

  Result := -1;

  if (aChild = nil) then Exit;

  case TppCrossTabChildType(aChild.ChildType) of
    ctctColumnGrandTotal: Result := FColumnGrandTotals.IndexOf(aChild);
    ctctRowGrandTotal:    Result := FRowGrandTotals.IndexOf(aChild);
    ctctRowDef:           Result := FRowDefs.IndexOf(aChild);
    ctctColumnDef:        Result := FColumnDefs.IndexOf(aChild);
    ctctValueDef:         Result := FValueDefs.IndexOf(aChild);
  else
    Result := inherited IndexOfChild(aChild);
  end;

end; {procedure, IndexOfChild}


{@TppCrossTab.RemoveChild
 This routine is called whenever the Parent property of a row, column or value
 dimension is set to nil or to a different crosstab component.  This routine
 should not be called directly - use the DeselectColumnDef, DeselectRowDef or
 DeselectValueDef routines instead.}

function TppCrossTab.RemoveChild(aChild: TppRelative): Integer;
var
  liIndex: Integer;
begin

  liIndex := IndexOfChild(aChild);

  Result := liIndex;

  if (liIndex = -1) then Exit;

  case TppCrossTabChildType(aChild.ChildType) of

    ctctColumnGrandTotal: FColumnGrandTotals.Delete(liIndex);

    ctctRowGrandTotal: FRowGrandTotals.Delete(liIndex);

    ctctRowDef:
      begin
        DimensionRemoved(TppDimension(aChild));

        FRowDefs.Delete(liIndex);
      end;

    ctctColumnDef:
      begin
        DimensionRemoved(TppDimension(aChild));

        FColumnDefs.Delete(liIndex);
      end;

    ctctValueDef:
      begin
        ValueDefRemoved(TppValueDef(aChild));

        FValueDefs.Delete(liIndex);
      end;
      
    else
      Result := inherited RemoveChild(aChild);
  end;

  SetModified(True);

end; {procedure, RemoveChild}

{------------------------------------------------------------------------------}
{ TppCrossTab.DimensionAdded }

procedure TppCrossTab.DimensionAdded(aDimension: TppDimension);
var
  lSubTotal: TppSubTotal;
  liIndex: Integer;
begin

  if (csReading in ComponentState) or
     (csWriting in ComponentState) or
     (csLoading in ComponentState) or
     FAssigning or FClearing then Exit;

  {create subtotal for each value def}
  for liIndex := 0 to ValueDefCount - 1 do
    begin
      lSubTotal := TppSubTotal.Create(aDimension);
      lSubTotal.Parent := aDimension;

      lSubTotal.TotalDef.DisplayFormat := ValueDefs[liIndex].DisplayFormat;
    end;

end; {procedure, DimensionAdded}

{------------------------------------------------------------------------------}
{ TppCrossTab.DimensionRemoved }

procedure TppCrossTab.DimensionRemoved(aDimension: TppDimension);
var
  liIndex: Integer;
begin

  if (csReading in ComponentState) or
     (csWriting in ComponentState) or
     (csLoading in ComponentState) or
     (csDestroying in ComponentState) or
     FAssigning or FClearing then Exit;

  {free subtotal for each value def}
  for liIndex := 0 to aDimension.SubTotalCount - 1 do
    aDimension.SubTotals[0].Free;

end; {procedure, DimensionRemoved}

{------------------------------------------------------------------------------}
{ TppCrossTab.DoOnDimensionChange }

procedure TppCrossTab.DoOnDimensionChange;
begin
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;


  if FAssigning then Exit;

  if Assigned(FOnDimensionChange) then FOnDimensionChange(Self);
  if Assigned(FOnDimensionChange2) then FOnDimensionChange2(Self);
end; {procedure, DoOnDimensionChange}

{------------------------------------------------------------------------------}
{ TppCrossTab.ValueDefAdded }

procedure TppCrossTab.ValueDefAdded(aValueDef: TppValueDef);
var
  lGrandTotal: TppGrandTotal;
  lSubTotal: TppSubTotal;
  liIndex: Integer;
  lDimension: TppDimension;
  lbVisible: Boolean;
begin

  if (csReading in ComponentState) or
     (csWriting in ComponentState) or
     (csLoading in ComponentState) or
     FAssigning or FClearing then Exit;

  {add column grand total}
  if (ColumnGrandTotalCount > 0) then
    lbVisible := ColumnGrandTotals[0].CaptionDef.Visible
  else
    lbVisible := True;

  lGrandTotal := TppGrandTotal.Create(Self);
  lGrandTotal.ChildType := Ord(ctctColumnGrandTotal);
  lGrandTotal.CaptionDef.Alignment := taRightJustify;
  lGrandTotal.Visible := lbVisible;
  lGrandTotal.Parent := Self;

  {add row grand total}
  lGrandTotal := TppGrandTotal.Create(Self);
  lGrandTotal.ChildType := Ord(ctctRowGrandTotal);
  lGrandTotal.Parent := Self;

  {add subtotal for each column def}
  for liIndex := 0 to ColumnDefCount - 1 do
    begin
      lDimension := ColumnDefs[liIndex];

      if (lDimension.SubTotalCount > 0) then
        lbVisible := lDimension.SubTotals[0].CaptionDef.Visible
      else
        lbVisible := True;

      lSubTotal := TppSubTotal.Create(lDimension);
      lSubTotal.Visible := lbVisible;
      lSubTotal.Parent := lDimension;
    end;

  {add subtotal for each row def}
  for liIndex := 0 to RowDefCount - 1 do
    begin
      lDimension := RowDefs[liIndex];

      lSubTotal := TppSubTotal.Create(lDimension);
      lSubTotal.Parent := lDimension;
    end;

end; {procedure, ValueDefAdded}

{------------------------------------------------------------------------------}
{ TppCrossTab.ValueDefRemoved }

procedure TppCrossTab.ValueDefRemoved(aValueDef: TppValueDef);
var
  liIndex: Integer;
  liValueDefIndex: Integer;
begin

  if (csReading in ComponentState) or
     (csWriting in ComponentState) or
     (csLoading in ComponentState) or
     (csDestroying in ComponentState) or
     FAssigning or FClearing then Exit;

  liValueDefIndex := aValueDef.GetIndex;

  {remove grand total}
  ColumnGrandTotals[liValueDefIndex].Free;
  RowGrandTotals[liValueDefIndex].Free;

  {remove subtotal for each column def}
  for liIndex := 0 to ColumnDefCount - 1 do
    ColumnDefs[liIndex].SubTotals[liValueDefIndex].Free;

  {remove subtotal for each row def}
  for liIndex := 0 to RowDefCount - 1 do
    RowDefs[liIndex].SubTotals[liValueDefIndex].Free;

end; {procedure, ValueDefRemoved}

{------------------------------------------------------------------------------}
{ TppCrossTab.ValueDefMoved }

procedure TppCrossTab.ValueDefMoved(aOldIndex, aNewIndex: Integer);
var
  liIndex: Integer;
  lDimension: TppDimension;
begin

  {move grand total}
  MoveChild(ColumnGrandTotals[aOldIndex], aNewIndex);

  MoveChild(RowGrandTotals[aOldIndex], aNewIndex);

  {remove subtotal for each column def}
  for liIndex := 0 to ColumnDefCount - 1 do
    begin
      lDimension := ColumnDefs[liIndex];

      lDimension.MoveChild(lDimension.SubTotals[aOldIndex], aNewIndex);
    end;

  {remove subtotal for each row def}
  for liIndex := 0 to RowDefCount - 1 do
    begin
      lDimension := RowDefs[liIndex];

      lDimension.MoveChild(lDimension.SubTotals[aOldIndex], aNewIndex);
    end;

end; {procedure, ValueDefMoved}


{@TppCrossTab.VisibleColumnGrandTotalCount
 Returns either 1 if column grand totals are visible and 0 if column grand
 totals are hidden. This function is used by the crosstab engine when column
 grand totals have been hidden. }

function TppCrossTab.VisibleColumnGrandTotalCount: Integer;
begin

  Result := 0;

  if (ColumnDefCount = 0) then Exit;

  if ColumnGrandTotals[0].CaptionDef.Visible then
    Inc(Result);

end; {function, VisibleColumnGrandTotalCount}


{@TppCrossTab.IndexOfColumnGrandTotal
 Given a grand total component, returns the position of the grand total in the
 ColumnGrandTotals array property of the crosstab.  If the grand total is not
 found, -1 is returned. This routine can be used to distinguish column grand
 totals from row grand totals.}

function TppCrossTab.IndexOfColumnGrandTotal(aGrandTotal: TppGrandTotal): Integer;
begin
  Result := FColumnGrandTotals.IndexOf(aGrandTotal);
end; {function, IndexOfColumnGrandTotal}


{@TppCrossTab.VisibleRowGrandTotalCount
 Returns the number of row grand totals which are visible.  This function is
 used by the crosstab engine when individual row grand totals have been hidden.}

function TppCrossTab.VisibleRowGrandTotalCount: Integer;
var
  liIndex: Integer;
begin

  Result := 0;

  if (RowDefCount = 0) then Exit;

  for liIndex := 0 to ValueDefCount - 1 do
    if RowGrandTotals[liIndex].CaptionDef.Visible then
      Inc(Result);

end; {function, VisibleRowGrandTotalCount}


{@TppCrossTab.IndexOfRowGrandTotal
 Given a grand total component, returns the position of the grand total in the
 RowGrandTotals array property of the crosstab.  If the grand total is not
 found, -1 is returned. This routine can be used to distinguish row grand totals
 from column grand totals.}

function TppCrossTab.IndexOfRowGrandTotal(aGrandTotal: TppGrandTotal): Integer;
begin
  Result := FRowGrandTotals.IndexOf(aGrandTotal);
end; {function, IndexOfRowGrandTotal}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetColumnGrandTotal }

function TppCrossTab.GetColumnGrandTotal(aIndex: Integer): TppGrandTotal;
begin
  Result := TppGrandTotal(FColumnGrandTotals[aIndex]);
end; {function, GetGrandTotal}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetColumnGrandTotalCount }

function TppCrossTab.GetColumnGrandTotalCount: Integer;
begin
  Result := FColumnGrandTotals.Count;
end; {function, GetColumnGrandTotalCount}


{@TppCrossTab.ShowGrandTotals
 Sets the visibility of all row or column grand totals.

 Value	        Meaning
 ctttAll	Both row and column grand totals are hidden.
 ctttColumn	Column grand totals are hidden.
 ctttRow	Row grand totals are hidden.

 Note: When grand totals are hidden, they are not included in the matrix
 generated by the crosstab engine.}

procedure TppCrossTab.ShowGrandTotals(aTotalType: TppTotalType; aValue: Boolean);
begin

  case aTotalType of
    ctttAll:
      begin
        ShowColumnGrandTotals(aValue);
        ShowRowGrandTotals(aValue);
      end;

    ctttColumn: ShowColumnGrandTotals(aValue);

    ctttRow: ShowRowGrandTotals(aValue);
  end;

end; {procedure, ShowGrandTotals}


{@TppCrossTab.ShowSubTotals
 Sets the visibility of all row or column subtotals.

 Value	        Meaning
 ctttAll	Both row and column subtotals are hidden.
 ctttColumn	Column subtotals are hidden.
 ctttRow	Row subtotals are hidden.

 Note: When subtotals are hidden, they are not included in the matrix generated
 by the crosstab engine.}

procedure TppCrossTab.ShowSubTotals(aTotalType: TppTotalType; aValue: Boolean);
begin

  case aTotalType of
    ctttAll:
      begin
        ShowColumnSubTotals(aValue);
        ShowRowSubTotals(aValue);
      end;

    ctttColumn: ShowColumnSubTotals(aValue);

    ctttRow: ShowRowSubTotals(aValue);
  end;

end; {procedure, ShowSubTotals}

{------------------------------------------------------------------------------}
{ TppCrossTab.ShowColumnGrandTotals }

procedure TppCrossTab.ShowColumnGrandTotals(aValue: Boolean);
var
  liIndex: Integer;
begin

  if (ValueDefCount = 0) then Exit;

  for liIndex := 0 to ColumnGrandTotalCount - 1 do
    ColumnGrandTotals[liIndex].Visible := aValue;

end; {procedure, ShowColumnGrandTotals}

{------------------------------------------------------------------------------}
{ TppCrossTab.ShowRowGrandTotals }

procedure TppCrossTab.ShowRowGrandTotals(aValue: Boolean);
var
  liIndex: Integer;
begin

  if (ValueDefCount = 0) then Exit;

  for liIndex := 0 to RowGrandTotalCount - 1 do
    RowGrandTotals[liIndex].Visible := aValue;

end; {procedure, ShowRowGrandTotals}

{------------------------------------------------------------------------------}
{ TppCrossTab.ShowColumnSubTotals }

procedure TppCrossTab.ShowColumnSubTotals(aValue: Boolean);
var
  liIndex: Integer;
  liIndex2: Integer;
  lDimension: TppDimension;
begin

  if (ValueDefCount = 0) then Exit;

  for liIndex := 0 to ColumnDefCount - 2 do
    begin
      lDimension := ColumnDefs[liIndex];

      for liIndex2 := 0 to lDimension.SubTotalCount - 1 do
        lDimension.SubTotals[liIndex2].Visible := aValue;

    end;

end; {procedure, ShowColumnSubTotals}

{------------------------------------------------------------------------------}
{ TppCrossTab.ShowRowSubTotals }

procedure TppCrossTab.ShowRowSubTotals(aValue: Boolean);
var
  liIndex: Integer;
  liIndex2: Integer;
  lDimension: TppDimension;
begin

  if (ValueDefCount = 0) then Exit;

  for liIndex := 0 to RowDefCount - 2 do
    begin
      lDimension := RowDefs[liIndex];

      for liIndex2 := 0 to lDimension.SubTotalCount - 1 do
        lDimension.SubTotals[liIndex2].Visible := aValue;

    end;

end; {procedure, ShowRowSubTotals}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetRowGrandTotal }

function TppCrossTab.GetRowGrandTotal(aIndex: Integer): TppGrandTotal;
begin
  Result := TppGrandTotal(FRowGrandTotals[aIndex]);
end; {function, GetGrandTotal}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetRowGrandTotalCount }

function TppCrossTab.GetRowGrandTotalCount: Integer;
begin
  Result := FRowGrandTotals.Count;
end; {function, GetRowGrandTotalCount}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetColumnDef }

function TppCrossTab.GetColumnDef(aIndex: Integer): TppColumnDef;
begin
  Result := TppColumnDef(FColumnDefs[aIndex]);
end; {function, GetColumnDef}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetColumnDefCount }

function TppCrossTab.GetColumnDefCount: Integer;
begin
  Result := FColumnDefs.Count;
end; {function, GetColumnDefCount}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetRowDef }

function TppCrossTab.GetRowDef(aIndex: Integer): TppRowDef;
begin
  Result := TppRowDef(FRowDefs[aIndex]);
end; {function, GetRowDef}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetRowDefCount }

function TppCrossTab.GetRowDefCount: Integer;
begin
  Result := FRowDefs.Count;
end; {function, GetRowDefCount}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetValueDef }

function TppCrossTab.GetValueDef(aIndex: Integer): TppValueDef;
begin
  Result := TppValueDef(FValueDefs[aIndex]);
end; {function, GetValueDef}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetValueDefCount }

function TppCrossTab.GetValueDefCount: Integer;
begin
  Result := FValueDefs.Count;
end; {function, GetValueDefCount}


{@TppCrossTab.IndexOfAvailableDimension
 Returns the position in the available dimensions list of a given field alias.
 If the field alias is not found, -1 is returned.  This routine can be called
 before calling SelectColumnDef, SelectRowDef or SelectValueDef, each of which
 require the index value.

 'Available dimensions' are defined as all fields from the data pipeline which
 have not yet been selected as row or column dimensions of the crosstab.  When
 fields are selected as row or column dimensions, they are removed from this
 list.}

function TppCrossTab.IndexOfAvailableDimension(const aFieldAlias: String): Integer;
begin
  Result := FAvailableDimensions.IndexOf(aFieldAlias);
end; {function, IndexOfAvailableDimension}


{@TppCrossTab.InitAvailableDimensions
 Builds a list of available dimensions based on the fields from the DataPipeline
 and the currently selected column and row dimensions. If you are creating a
 crosstab component in code, this routine must be called before using the
 SelectColumnDef, SelectRowDef and SelectValueDef procedures.

 'Available dimensions' are defined as all fields from the data pipeline which
 have not yet been selected as row or column dimensions of the crosstab.  When
 fields are selected as row or column dimensions, they are removed from this
 list.}

procedure TppCrossTab.InitAvailableDimensions;
var
  liIndex: Integer;
  lField: TppField;
  liPosition: Integer;
  lColumnDef: TppColumnDef;
  lRowDef: TppRowDef;
begin

  {future: exclude BLOB fields from list}

  FAvailableDimensions.Clear;

  if (DataPipeline = nil) then Exit;

  {get all aliases}
  for liIndex := 0 to DataPipeline.FieldCount - 1 do
    begin
      lField := DataPipeline.Fields[liIndex];

      FAvailableDimensions.AddObject(lField.FieldAlias, lField);
    end;

  {remove column defs}
  for liIndex := 0 to ColumnDefCount - 1 do
    begin
      lColumnDef := ColumnDefs[liIndex];

      liPosition := FAvailableDimensions.IndexOf(lColumnDef.FieldAlias);

      if (liPosition <> -1) then
        begin
          FAvailableDimensions.Delete(liPosition);

          lColumnDef.Tag := DataPipeline.IndexOfFieldName(lColumnDef.FieldName);
        end;
    end;

  {remove row defs}
  for liIndex := 0 to RowDefCount - 1 do
    begin
      lRowDef := RowDefs[liIndex];

      liPosition := FAvailableDimensions.IndexOf(lRowDef.FieldAlias);

      if (liPosition <> -1) then
        begin
          FAvailableDimensions.Delete(liPosition);

          lRowDef.Tag := DataPipeline.IndexOfFieldName(lRowDef.FieldName);
        end;
    end;

end; {procedure, InitAvailableDimensions}

{------------------------------------------------------------------------------}
{@TppCrossTab.CopyAvailableDimensions
 Copies a list of the currently available fields to the list passed in the
 aList parameter.  The strings of the list contains the FieldAlias, the
 Objects property of the list contains a pointer to the actual TppField
 objects in the data pipeline.

 The 'available dimensions' are all of the fields from the data pipeline which
 have not yet been selected as row or column dimensions of the crosstab.  When
 fields are selected as row or column dimensions, they are removed from this
 list.

 Note: When fields are selected as value dimensions they are not removed from
 the available dimensions list.  Because multiple calculation types can be
 specified for the same field, it is valid to select the same field as a value
 dimension multiple times.}

procedure TppCrossTab.CopyAvailableDimensions(aList: TStrings);
begin
  aList.Assign(FAvailableDimensions);
end; {procedure, CopyAvailableDimensions}


{@TppCrossTab.SelectColumnDef
 This method selects the field from the available dimensions list and creates a
 corresponding column dimension in the crosstab. The resulting ColumnDef
 component is returned.  This component is appended to the list of ColumnDefs
 for the crosstab.  In order to change this position call MoveChild.

 Before calling SelectColumnDef, you can determine the appropriate Index value
 for a given field alias by calling the IndexOfAvailableDimension function.

 If you are creating a crosstab in code using the SelectColumnDef, SelectRowDef
 and SelectValueDef procedures, you must first assign a DataPipeline to the
 crosstab and then call InitAvailableDimensions.}

function TppCrossTab.SelectColumnDef(aIndex: Integer): TppColumnDef;
var
  lColumnDef: TppColumnDef;
  lField: TppField;
  lsFieldAlias: String;
begin

  lColumnDef := TppColumnDef.Create(Self);
  lColumnDef.Parent := Self;

  lsFieldAlias := FAvailableDimensions[aIndex];
  lField := DataPipeline.GetFieldForAlias(lsFieldAlias);

  lColumnDef.FieldAlias := lField.FieldAlias;
  lColumnDef.FieldName := lField.FieldName;
  lColumnDef.Tag := lField.Index;

  if (lField.DataType = dtBoolean) then
    lColumnDef.SortType := soDescending;

  FAvailableDimensions.Delete(aIndex);

  Result := lColumnDef;

  DoOnDimensionChange;

end; {function, SelectColumnDef}


{@TppCrossTab.SelectRowDef
 This method selects the field from the available dimensions list and creates a
 corresponding row dimension in the crosstab. The resulting RowDef component is
 returned.  This component is appended to the list of RowDefs for the crosstab.
 In order to change this position call MoveChild.

 Before calling SelectRowDef, you can determine the appropriate Index value for
 a given field alias by calling the IndexOfAvailableDimension function.

 If you are creating a crosstab in code using the SelectColumnDef, SelectRowDef
 and SelectValueDef procedures, you must first assign a DataPipeline to the
 crosstab and then call InitAvailableDimensions.}

function TppCrossTab.SelectRowDef(aIndex: Integer): TppRowDef;
var
  lRowDef: TppRowDef;
  lField: TppField;
  lsFieldAlias: String;
begin

  lRowDef := TppRowDef.Create(Self);
  lRowDef.Parent := Self;

  lsFieldAlias := FAvailableDimensions[aIndex];
  lField := DataPipeline.GetFieldForAlias(lsFieldAlias);

  lRowDef.FieldAlias := lField.FieldAlias;
  lRowDef.FieldName := lField.FieldName;
  lRowDef.Tag := lField.Index;

  if (lField.DataType = dtBoolean) then
    lRowDef.SortType := soDescending;

  FAvailableDimensions.Delete(aIndex);

  Result := lRowDef;

  DoOnDimensionChange;

end; {function, SelectRowDef}


{@TppCrossTab.SelectValueDef
 This method selects the field from the available dimensions list and creates a
 corresponding value dimension in the crosstab. The resulting ValueDef component
 is returned.  This component is appended to the list of ValueDefs for the
 crosstab.  In order to change this position call MoveChild.

 Before calling SelectValueDef, you can determine the appropriate Index value
 for a given field alias by calling the IndexOfAvailableDimension function.

 If you are creating a crosstab in code using the SelectColumnDef, SelectRowDef
 and SelectValueDef procedures, you must first assign a DataPipeline to the
 crosstab and then call InitAvailableDimensions.}

function TppCrossTab.SelectValueDef(aIndex: Integer): TppValueDef;
var
  lValueDef: TppValueDef;
begin

  lValueDef := TppValueDef.Create(Self);
  lValueDef.Parent := Self;

  lValueDef.FieldAlias := FAvailableDimensions[aIndex];
  lValueDef.FieldName := DataPipeline.FieldNameForFieldAlias(lValueDef.FieldAlias);

  if not(lValueDef.GetDataType in ppNumerics) then
    lValueDef.CalcType := dcCount;

  Result := lValueDef;

  DoOnDimensionChange;

end; {function, SelectValueDef}

{------------------------------------------------------------------------------}
{ TppCrossTab.RestoreFieldToAvailableDimension }

function TppCrossTab.RestoreFieldToAvailableDimension(aDimension: TppDimension): Integer;
var
  lField: TppField;
  liIndex: Integer;
  liFieldIndex: Integer;
  lCurrentField: TppField;
  liCurrentIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  if (DataPipeline = nil) then Exit;

  lField := DataPipeline.GetFieldForAlias(aDimension.FieldAlias);

  liFieldIndex := DataPipeline.IndexOfField(lField);

  if (liFieldIndex = -1) then Exit;
  
  liIndex := 0;
  lbFound := False;

  while (liIndex < FAvailableDimensions.Count) and not(lbFound) do
    begin
      lCurrentField := TppField(FAvailableDimensions.Objects[liIndex]);
      liCurrentIndex := DataPipeline.IndexOfField(lCurrentField);

      if (liFieldIndex < liCurrentIndex) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if (lbFound) then
    FAvailableDimensions.InsertObject(liIndex, lField.FieldAlias, lField)

  else if (liIndex = FAvailableDimensions.Count) then
    FAvailableDimensions.InsertObject(liIndex, lField.FieldAlias, lField);

  Result := liIndex;
  
end; {function, RestoreFieldToAvailableDimension}


{@TppCrossTab.DeselectColumnDef
 Deselects the column dimension indicated by the aIndex parameter and returns
 the field associated with the column to the available dimensions list.

 If the ColumnDef component was successfully removed and freed, then this
 routine returns the position in the list where the ColumnDef appeared,
 otherwise it returns -1.

 It is not necessary to create or free individual column definition components.
 Instead, you can call SelectColumnDef or DeselectColumnDef which will do the
 work for you.}

function TppCrossTab.DeselectColumnDef(aIndex: Integer): Integer;
var
  lColumnDef: TppDimension;
begin

  lColumnDef := ColumnDefs[aIndex];

  Result := RestoreFieldToAvailableDimension(lColumnDef);

  lColumnDef.Free;

  DoOnDimensionChange;

end; {function, DeselectColumnDef}


{@TppCrossTab.DeselectRowDef
 Deselects the row dimension indicated by the aIndex parameter and returns the
 field associated with the row to the available dimensions list.

 If the RowDef component was successfully removed and freed, then this routine
 returns the position in the list where the RowDef appeared, otherwise it
 returns -1.

 It is not necessary to create or free individual row definition components.
 Instead, you can call SelectRowDef or DeselectRowDef which will do the work for
 you.}

function TppCrossTab.DeselectRowDef(aIndex: Integer): Integer;
var
  lRowDef: TppDimension;
begin

  lRowDef := RowDefs[aIndex];

  Result := RestoreFieldToAvailableDimension(lRowDef);

  lRowDef.Free;

  DoOnDimensionChange;

end; {function, DeselectRowDef}


{@TppCrossTab.DeselectValueDef
 Deselects the value dimension indicated by the aIndex parameter.

 If the ValueDef component was successfully removed and freed, then this routine
 returns the position in the list where the ValueDef appeared, otherwise it
 returns -1.

 It is not necessary to create or free individual value definition components.
 Instead, you can call SelectValueDef or DeselectValueDef which will do the work
 for you.}

function TppCrossTab.DeselectValueDef(aIndex: Integer): Integer;
var
  lValueDef: TppDimension;
begin

  lValueDef := ValueDefs[aIndex];

  Result := FAvailableDimensions.IndexOf(lValueDef.FieldAlias);

  lValueDef.Free;

  DoOnDimensionChange;

end; {function, DeselectValueDef}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetBand }

procedure TppCrossTab.SetBand(aBand: TppBand);
begin

  inherited SetBand(aBand);

end; {procedure, SetBand}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetRegion }

procedure TppCrossTab.SetRegion(aComponent: TppComponent);
begin

  inherited SetRegion(aComponent);

end; {procedure, SetRegion}


{@TppCrossTab.GetCaption

  The name of the crosstab as displayed in the Report Designer.  The caption
  is provided so that you can give the crosstab a meaningful name and easily
  distinguish it from other components in the report layout.  The caption is
  not used in the generation of the crosstab matrix.}

function TppCrossTab.GetCaption: String;
begin

  if (GetDataPipeline = nil) then
    Result := UserName + ': ' + ppLoadStr(1134) {'No Data Pipeline assigned.'}
  else
    Result := UserName + ': ' + GetDataPipeline.UserName;
    
end; {function, GetCaption}

{@TppCrossTab.SetCaption

  The name of the crosstab as displayed in the Report Designer.  The caption
  is provided so that you can give the crosstab a meaningful name and easily
  distinguish it from other components in the report layout.  The caption is
  not used in the generation of the crosstab matrix.}

procedure TppCrossTab.SetCaption(aCaption: String);
begin

  inherited SetCaption(aCaption);

end; {procedure, SetCaption}

{------------------------------------------------------------------------------}
{ TppCrossTab.SetUnits }

procedure TppCrossTab.SetUnits(aUnits: TppUnitType);
begin

  inherited SetUnits(aUnits);

end; {procedure, SetUnits}

{------------------------------------------------------------------------------}
{ TppCrossTab.HasColor }

function  TppCrossTab.HasColor: Boolean;
begin
  Result := False;
end; {procedure, HasColor}

{------------------------------------------------------------------------------}
{ TppCrossTab.HasFont }

function  TppCrossTab.HasFont: Boolean;
begin
  Result := False;
end; {procedure, HasFont}

{------------------------------------------------------------------------------}
{ TppCrossTab.IsDataAware }

function  TppCrossTab.IsDataAware: Boolean;
begin
  Result := True;
end; {procedure, IsDataAware}

{------------------------------------------------------------------------------}
{ TppCrossTab.LanguageChanged }

procedure TppCrossTab.LanguageChanged;
begin

end; {procedure, LanguageChanged}


{@TppCrossTab.RestoreFromCache
 Called whenever the engine is starting a new page, and the Report.CachePages
 property is set false.  In this routine, the crosstab must restore it's 'state'
 as of the start of the current report page (Report.AbsolutePageNo).  The
 crosstab uses the cache to tracks the row and column position of the current
 crosstab rendering, as wells as a unique identifier for each instance of the
 crosstab in the report}

procedure TppCrossTab.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppCrossTabSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent     := lRec.FDrawComponent;
  DrawShifter       := lRec.FDrawShifter;
  ObjectIndex       := lRec.FObjectIndex;
  OverFlow          := lRec.FOverFlow;
  PartialGeneration := lRec.FPartialGeneration;

  FCrossTabId := lRec.FCrossTabId;
  FStartColumn := lRec.FStartColumn;
  FStartRow := lRec.FStartRow;

end; {procedure, RestoreFromCache}


{@TppCrossTab.SaveToCache
 Called whenever the engine is completing a new page, and the Report.CachePages
 property is set false.  In this routine, the crosstab must save it's 'state' as
 appropriate for the start of the next report page (Report.AbsolutePageNo).  The
 crosstab saves the row and column position of the current crosstab rendering,
 as wells as a unique identifier for current instance of the crosstab (used when
 a crosstab is generated several times within a report.)

 Note: The Matrix for a given instance of a crosstab is not cached, which means
 that when a crosstab appears multiple times in a report, it is regenerated each
 time you move between the various crosstabs in the print preview window.  For
 this reason, it is recommended that you set Report.CachePages to True, for
 reports which will contain multiple instances of the same crosstab.}

procedure TppCrossTab.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppCrossTabSaveRec;
begin

  lRec.FDrawComponent     := DrawComponent;
  lRec.FDrawShifter       := DrawShifter;
  lRec.FObjectIndex       := ObjectIndex;
  lRec.FOverFlow          := OverFlow;
  lRec.FPartialGeneration := PartialGeneration;

  lRec.FCrossTabId := FCrossTabId;
  lRec.FStartColumn := FStartColumn;
  lRec.FStartRow := FStartRow;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}


{@TppCrossTab.GetElement
 Before the crosstab grid (Matrix) is generated, all of the elements of the
 crosstab definition (column definitions, row definitions, value definitions,
 subtotals, etc.) are assembled into a master list.  Each element is assigned an
 index based on their position in the list.  As the matrix is generated,
 elements of crosstab definition are associated with cells in the matrix via
 this element index (see the ElementIndex property of the matrix.)}

function TppCrossTab.GetElement(aIndex: Integer): TppElement;
begin
  Result := TppCrossTabEngine(FEngine).Elements[aIndex];
end; {procedure, GetElement}

{------------------------------------------------------------------------------}
{ TppCrossTab.GetMatrix }

function TppCrossTab.GetMatrix: TppMatrix;
begin
  Result := TppCrossTabEngine(FEngine).Matrix;
end; {procedure, GetMatrix}

{------------------------------------------------------------------------------}
{ TppCrossTab.CalcSpaceUsed }

procedure TppCrossTab.CalcSpaceUsed;
var
  llHeightAvailable: Longint;
  llWidthAvailable: Longint;
  lMatrix: TppMatrix;
  liEndRow: Integer;
  liEndColumn: Integer;
  lClass: TppCrossTabRendererClass;
  lsSaveMessage: String;
begin

  if (ValueDefCount = 0) then
    begin
      OverFlow := False;
      SpaceUsed := 0;

      Exit;
    end;

  if (Stretch) and (ParentStretch) then
    begin
      llHeightAvailable := (PrintPosRect.Bottom - PrintPosRect.Top) - ToMMThousandths(Top, Units, pprtVertical);
      llWidthAvailable := mmWidth;
    end
  else
    begin
      llHeightAvailable := mmHeight;
      llWidthAvailable := mmWidth;
    end;

  if not(OverFlow) then
    begin
      Inc(FCrossTabId);

      FStartColumn := 0;
      FStartRow := 0;

      if (FCrossTabId <> FLastCalcId) then
        begin
          FLastCalcId := FCrossTabId;

          FCalculating := True;

          lsSaveMessage := GetPrintMessage;

          FStatusTimer := TppCrossTabStatusTimer.CreateTimer(250, Self);

          try
            TppCrossTabEngine(FEngine).Calc;
          finally
            FCalculating := False;

            if not(Draw) then
              begin
                SetPrintMessage(lsSaveMessage);

                FStatusTimer.Free;
                FStatusTimer := nil;
              end;
          end;

          if (FRenderer = nil) then
            begin
              lClass := ppRendererClassForDescription(FStyle);

              if (lClass <> nil) then
                FRenderer := lClass.Create(Self)
              else
                FRenderer := TppCrossTabRenderer.Create(Self);
            end;

          TppCustomCrossTabRenderer(FRenderer).Format := Draw;
        end;
    end;

  lMatrix := GetMatrix;

  if (lMatrix = nil) then
    begin
      OverFlow := False;
      SpaceUsed := 0;

      FStatusTimer.Free;
      FStatusTimer := nil;

      Exit;
    end;

  if Draw then
    begin
      TppCustomCrossTabRenderer(FRenderer).StartColumn := FStartColumn;
      TppCustomCrossTabRenderer(FRenderer).StartRow := FStartRow;

      try
        SpaceUsed := TppCustomCrossTabRenderer(FRenderer).CalcSpaceUsed(lMatrix, llHeightAvailable, llWidthAvailable, GetPrinter);

      finally
        if (FStatusTimer <> nil) then
          begin
            SetPrintMessage(lsSaveMessage);

            FStatusTimer.Free;
            FStatusTimer := nil;
          end;
      end;

      liEndColumn := TppCustomCrossTabRenderer(FRenderer).EndColumn;
      liEndRow := TppCustomCrossTabRenderer(FRenderer).EndRow;
    end
  else
    begin
      liEndColumn := lMatrix.ColumnCount - 1;
      liEndRow := lMatrix.RowCount - 1;
    end;

  if (liEndColumn = lMatrix.ColumnCount - 1) and (liEndRow = lMatrix.RowCount - 1) then
    OverFlow := False
  else
    begin
      OverFlow := True;

      case FPagination of

        ctptAcrossThenDown:
          begin
            if (liEndColumn = lMatrix.ColumnCount - 1) then
              begin
                FStartColumn := 0;
                FStartRow := liEndRow + 1;
              end
            else
              FStartColumn := liEndColumn + 1;
          end;

        ctptDownThenAcross:
          begin
            if (liEndRow = lMatrix.RowCount - 1) then
              begin
                FStartRow := 0;
                FStartColumn := liEndColumn + 1;
              end
             else
               FStartRow := liEndRow + 1;
          end;

      end;

    end;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCrossTab.CreateDrawCommand }

procedure TppCrossTab.CreateDrawCommand(aPage: TppPage);
var
  llStartLeft: Longint;
  llStartTop: Longint;
  lMatrix: TppMatrix;
begin

  if (SpaceUsed = 0) or not(Draw) then Exit;

  llStartLeft := PrintPosRect.Left;

  llStartTop := PrintPosRect.Top;
  
  lMatrix := TppCrossTabEngine(FEngine).Matrix;

  if (lMatrix <> nil) then
    TppCustomCrossTabRenderer(FRenderer).CreateDrawCommands(aPage, lMatrix, llStartLeft, llStartTop);

end; {procedure, CreateDrawCommand}

{------------------------------------------------------------------------------}
{ TppCustomText.DoOnCompareDimensionValues }

procedure TppCrossTab.DoOnCompareDimensionValues(aDimension: TppDimension; aValue1, aValue2: Variant; var Result: Integer);
var
  lParams: TraParamList;
begin
  if Assigned(FOnCompareDimensionValues) then FOnCompareDimensionValues(Self, aDimension, aValue1, aValue2, Result);

  lParams := TraTppCrossTabRTTI.GetParams('OnCompareDimensionValues');
  lParams.CreateValuePointer(0, aDimension);
  lParams.CreateValuePointer(1, aValue1);
  lParams.CreateValuePointer(2, aValue2);
  lParams.CreateValuePointer(3, Result);

  SendEventNotify(Self, ciCrossTabCompareDimensionValues, lParams);

  lParams.Free;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetSaveOrder }

function TppCrossTab.GetSaveOrder: TTabOrder;
begin
  if Band <> nil then
    Result := Band.IndexOfSave(Self)
  else
    Result := -1;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSave }

procedure TppCrossTab.SetSave(Value: Boolean);
begin
  if FSave <> Value then
    begin
      FSave := Value;

      if (csReading in ComponentState) then Exit;

      if FSave then
        Band.AddSave(Self)
      else
        Band.RemoveSave(Self);

      if (pppcDesigning in DesignState) then
        PropertyChange;

      Reset;

    end;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSaveLength }

procedure TppCrossTab.SetSaveLength(Value: Integer);
begin
  if FSaveLength <> Value then
    begin
      FSaveLength := Value;
      Reset;
    end;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSaveOrder }

procedure TppCrossTab.SetSaveOrder(Value: TTabOrder);
begin
  if csReading in ComponentState then
    FSaveOrder := Value
  else
    begin
      Band.MoveSave(Band.IndexOfSave(Self), Value);
      Reset;
    end;
end;

{******************************************************************************
 *
 ** E L E M E N T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppElement.Create }

constructor TppElement.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FFont := TFont.Create;
  FFont.Name := 'Arial';
  FFont.Size := 10;

  FAlignment := taCenter;
  FColor := clWhite;
  FDataType := dtString;
  FDisplayFormat := '';
  FName := '';
  FVisible := True;

end; {constructor, Create}


{@TppElement.CreateWithName
 Allows an element to be created with a predefined name.  The name passed in the
 aName parameter is then returned whenever the GetName method of the element is
 called.  This constructor is used for elements which are used in the crosstab
 design dialog.}

constructor TppElement.CreateWithName(aOwner: TComponent; const aName: String);
begin

  Create(aOwner);

  FName := aName;

end; {constructor, CreateWithName}

{------------------------------------------------------------------------------}
{ TppElement.Destroy }

destructor TppElement.Destroy;
begin

  FFont.Free;

  inherited Destroy;

end; {destructor, Destroy}


{@TppElement.Modified
 Whether or not the element has been modified in any way.  This procedure sets
 the CrossTab.Modified property to True when called.}

procedure TppElement.Modified;
var
  lCrossTab: TppCrossTab;
begin

  lCrossTab := CrossTab;

  if (lCrossTab <> nil) then
    lCrossTab.Modified := True;

end; {procedure, Modified}


{@TppElement.GetName
 The name which will be used as the field label in the crosstab grid. For row
 and column dimensions this is usually the field alias. For value dimensions
 this is usually the field alias plus a description of the calculation type.

 You can modify the result of this method via the OnGetDimensionName event of
 the crosstab.}

function TppElement.GetName: String;
begin
  Result := FName;
end; {destructor, GetName}


{@TppElement.GetDesignName
 The string to be displayed in the crosstab design dialog.}

function TppElement.GetDesignName: String;
begin
  Result := GetName;
end; {destructor, GetDesignName}


{@TppElement.GetDataType
 The data type of the field associated with a row or column dimension, or, in
 the case of a value dimension, the data type resulting from a calculation.}

function TppElement.GetDataType: TppDataType;
begin
  Result := FDataType;
end; {destructor, GetDataType}

{------------------------------------------------------------------------------}
{ TppElement.DrawRect }

function TppElement.DrawRect: TRect;
begin
  Result := Rect(FLeft, FTop, FLeft + FWidth, FTop + FHeight);
end; {destructor, DrawRect}


{@TppElement.CrossTab
 Indicates the crosstab component to which this element is assigned.}

function TppElement.CrossTab: TppCrossTab;
begin

  if Parent is TppCrossTab then
    Result := TppCrossTab(Parent)

  else if (Parent <> nil) and (Parent.Parent is TppCrossTab) then
    Result := TppCrossTab(Parent.Parent)

  else if (Parent <> nil) and (Parent.Parent <> nil) and (Parent.Parent.Parent is TppCrossTab) then
    Result := TppCrossTab(Parent.Parent.Parent)

  else
    Result := nil;

end; {function, CrossTab}


{@TppElement.HasDisplayFormat
 Whether or not the DisplayFormat is applicable to the element.  DisplayFormats
 are used by value dimensions, subtotal definitions and grand total defintions.}

function TppElement.HasDisplayFormat: Boolean;
begin
  Result := (GetPropInfo(ClassInfo, 'DisplayFormat') <> nil);
end; {procedure, HasDisplayFormat}


{@TppElement.Assign
 Copies the contents from element to another.  This includes any 'child'
 components contained source.}

procedure TppElement.Assign(Source: TPersistent);
var
  lElement: TppElement;
begin

  if (Source is TppElement) then
    begin
      lElement := TppElement(Source);

      FAlignment := lElement.Alignment;
      FColor := lElement.Color;
      FDisplayFormat := lElement.DisplayFormat;
      FFont.Assign(lElement.Font);
      FVisible := lElement.Visible;
    end
  else
    inherited Assign(Source);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppElement.DoOnChange }

procedure TppElement.DoOnChange;
begin
  if (csReading in ComponentState) or (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;

  if Assigned(FOnChange) then FOnChange(Self);
end; {procedure, DoOnChange}

{------------------------------------------------------------------------------}
{ TppElement.SetVisible }

procedure TppElement.SetVisible(aValue: Boolean);
begin

  FVisible := aValue;

  DoOnChange;

  Modified;

end; {procedure, SetVisible}

{------------------------------------------------------------------------------}
{ TppElement.SetDisplayFormat }

procedure TppElement.SetDisplayFormat(const aFormat: String);
begin

  FDisplayFormat := aFormat;

  DoOnChange;

  Modified;

end; {function, SetDisplayFormat}

{------------------------------------------------------------------------------}
{ TppElement.SetFont }

procedure TppElement.SetFont(aFont: TFont);
begin

  FFont.Assign(aFont);

  DoOnChange;

  Modified;

end; {function, SetFont}

{------------------------------------------------------------------------------}
{ TppElement.SetAlignment }

procedure TppElement.SetAlignment(aAlignment: TAlignment);
begin

  FAlignment := aAlignment;

  DoOnChange;

  Modified;

end; {function, SetAlignment}

{------------------------------------------------------------------------------}
{ TppElement.SetColor }

procedure TppElement.SetColor(aColor: TColor);
begin

  FColor := aColor;

  DoOnChange;

  Modified;

end; {function, SetColor}

{******************************************************************************
 *
 ** D I M E N S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDimension.Create }

constructor TppDimension.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FFieldAlias := '';
  FFieldName := '';
  FNullOrder := ctnoLast;
  FSkipNulls := True;
  FSortType := soAscending;
  FSubTotals := TList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDimension.Destroy }

destructor TppDimension.Destroy;
begin

  ctFreeChildren(FSubTotals);

  FSubTotals.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDimension.Assign }

procedure TppDimension.Assign(Source: TPersistent);
var
  lDimension: TppDimension;
begin

  inherited Assign(Source);
  
  if not(Source is TppDimension) then Exit;

  lDimension := TppDimension(Source);

  FFieldAlias := lDimension.FieldAlias;
  FFieldName := lDimension.FieldName;
  FNullOrder := lDimension.NullOrder;
  FSkipNulls := lDimension.SkipNulls;
  FSortType := lDimension.SortType;

  ctFreeChildren(FSubTotals);

  ctAssignChildren(lDimension.FSubTotals, Self, Self);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDimension.GetChildOwner }

function TppDimension.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppDimension.SaveComponents }

procedure TppDimension.SaveComponents(Proc: TGetChildProc);
var
  liIndex: Integer;
begin

  inherited SaveComponents(Proc);

  for liIndex := 0 to (FSubTotals.Count - 1) do
    Proc(SubTotals[liIndex]);

end; {procedure, SaveComponents}


{@TppDimension.AddChild
 This routine is called whenever the Parent property of a subtotal definition is
 set to the dimension component.  This routine should not be called directly -
 the crosstab component will automatically maintain a set of subtotal components
 for each dimension as the crosstab is modified.}

procedure TppDimension.AddChild(aChild: TppRelative);
begin

  case TppCrossTabChildType(aChild.ChildType) of
    ctctSubTotal: FSubTotals.Add(aChild);
    else
      inherited AddChild(aChild);
  end;

end; {procedure, AddChild}


{@TppDimension.IndexOfChild
 Given a subtotal component, returns the position of the component in the
 corresponding SubTotals array property.  If the subtotal is not found, -1 is
 returned.}

function TppDimension.IndexOfChild(aChild: TppRelative): Integer;
begin

  case TppCrossTabChildType(aChild.ChildType) of
    ctctSubTotal: Result := FSubTotals.IndexOf(aChild);
  else
    Result := inherited IndexOfChild(aChild);
  end;

end; {procedure, IndexOfChild}


{@TppDimension.RemoveChild
 The only childrend of a dimension are subtotal components. So this routine is
 called whenever the Parent property of a subtotal component is set to nil or to
 a different dimension component.  This routine should not be called directly.

 If you call the DeselectValueDef routine to remove a value dimension, all
 corresponding subtotals for all row and column dimensions will be automatically
 freed.  If you want to hide an individual subtotal defintion, use the Visible
 property.}

function TppDimension.RemoveChild(aChild: TppRelative): Integer;
var
  liIndex: Integer;
begin

  liIndex := IndexOfChild(aChild);

  Result := liIndex;

  if (liIndex = -1) then Exit;

  case TppCrossTabChildType(aChild.ChildType) of
    ctctSubTotal: FSubTotals.Delete(liIndex);
    else
      Result := inherited RemoveChild(aChild);
  end;

end; {procedure, RemoveChild}


{@TppDimension.MoveChild
 The dimension component has only type of child: the subtotal component.
 Subtotal components are automatically maintained by the crosstab - so it is not
 necessary to call this procedure.

 Subtotal components are maintained in the same order as the corresponding value
 dimensions. That is, if you had two value dimension (Sum of Amount Paid, then
 Count of Amount Paid) and you moved the Count of Amount Paid into the first
 position, then the crosstab would automatically reorder all of the subtotals
 for all of the row and column dimensions.  Calling this method directly could
 result in the crosstab generating improperly.}

procedure TppDimension.MoveChild(aChild: TppRelative; aNewIndex: Integer);
var
  liCurrentIndex: Integer;
begin

  liCurrentIndex := IndexOfChild(aChild);

  case TppCrossTabChildType(aChild.ChildType) of
    ctctSubTotal: FSubTotals.Move(liCurrentIndex, aNewIndex);
  end;

end; {procedure, MoveChild}

{------------------------------------------------------------------------------}
{ TppDimension.SetSortType }

procedure TppDimension.SetSortType(aSortType: TppSortOrderType);
begin

  FSortType := aSortType;

  DoOnChange;

  Modified;

end; {procedure, SetSortType}

{------------------------------------------------------------------------------}
{ TppDimension.SetNullOrder }

procedure TppDimension.SetNullOrder(aNullOrder: TppNullOrderType);
begin

  FNullOrder := aNullOrder;

  DoOnChange;

  Modified;

end; {procedure, SetNullOrder}

{------------------------------------------------------------------------------}
{ TppDimension.SetSkipNulls }

procedure TppDimension.SetSkipNulls(aValue: Boolean);
begin

  FSkipNulls := aValue;

  DoOnChange;

  Modified;

end; {procedure, SetSkipNulls}

{------------------------------------------------------------------------------}
{ TppDimension.GetSubTotal }

function TppDimension.GetSubTotal(aIndex: Integer): TppSubTotal;
begin
  Result := TppSubTotal(FSubTotals[aIndex]);
end; {function, GetSubTotal}

{------------------------------------------------------------------------------}
{ TppDimension.GetSubTotalCount }

function  TppDimension.GetSubTotalCount: Integer;
begin
  Result := FSubTotals.Count;
end; {function, GetSubTotalCount}


{@TppDimension.Clear
 Resets all property values to the default.  Also resets the property values of
 any contained 'child' components to their defaults.}

procedure TppDimension.Clear;
begin

  FFieldAlias := '';
  FFieldName := '';

end; {procedure, Clear}


{@TppDimension.GetIndex
 The position in the corresponding crosstab array property.  The crosstab array
 properties which contain dimension components are listed below:

 Component	        Property
 ColumnDef	        ColumnDefs
 RowDef	RowDefs
 ValueDef	        ValueDefs}

function TppDimension.GetIndex: Integer;
begin
  Result := -1;

  if (Parent <> nil) then
    Result := Parent.IndexOfChild(Self);
end; {procedure, GetIndex}

{------------------------------------------------------------------------------}
{ TppDimension.GetFieldDataType }

function TppDimension.GetFieldDataType: TppDataType;
var
  lDataPipeline: TppDataPipeline;
begin

  Result := dtNotKnown;

  if (FFieldName = '') then Exit;

  lDataPipeline := CrossTab.DataPipeline;

  if (lDataPipeline = nil) then Exit;

  Result := lDataPipeline.GetFieldDataType(FFieldName);

end; {procedure, GetFieldDataType}

{------------------------------------------------------------------------------}
{ TppDimension.GetDataType }

function TppDimension.GetDataType: TppDataType;
begin
  Result := GetFieldDataType;
end; {procedure, GetDataType}

{------------------------------------------------------------------------------}
{ TppDimension.GetName }

function TppDimension.GetName: String;
begin

  Result := FFieldAlias;

  CrossTab.DoOnGetDimensionName(Self, Result);

end; {function, GetName}


{@TppDimension.GetCaption
 The field value as retrieved from the DataPipeline of the crosstab using the
 FieldName of the dimension.  This caption can be modified via the
 OnGetDimensionCaption event of the crosstab.

 The caption is the value which appears on the outer edge of the crosstab and
 indicate the row and column value to which a certain calculation relates.}

function TppDimension.GetCaption: String;
var
  lDataPipeline: TppDataPipeline;
begin

  Result := '';

  lDataPipeline := TppCrossTab(Parent).DataPipeline;

  if (lDataPipeline = nil) or not(lDataPipeline.Active) then Exit;

  if (DisplayFormat <> '') and not(Self is TppValueDef) then
    Result := ppFormat(DisplayFormat, GetDataType, lDataPipeline.GetFieldValue(FFieldName))
  else
    Result := lDataPipeline.GetFieldAsString(FFieldName);

  CrossTab.DoOnGetDimensionCaption(Self, Result);

end; {function, GetCaption}

{------------------------------------------------------------------------------}
{ TppDimension.GetSkip }

function TppDimension.GetSkip: Boolean;
begin

  GetValue;

  Result := FSkip;
  
end; {function, GetSkip}


{@TppDimension.GetValue
 The field value as retrieved from the DataPipeline of the crosstab using the
 FieldName of the dimension.  This value can be modified via the
 OnGetDimensionValue event of the crosstab.

 Note: This method is used by ValueDef components only.}

function TppDimension.GetValue: Variant;
var
  lDataPipeline: TppDataPipeline;
begin

  Result := Null;

  lDataPipeline := TppCrossTab(Parent).DataPipeline;

  if (lDataPipeline <> nil) and (lDataPipeline.Active) then
    Result := lDataPipeline.GetFieldValue(FFieldName);

  FSkip := False;

  if FSkipNulls and (VarType(Result) = varNull) then
    FSkip := True;

  CrossTab.DoOnGetDimensionValue(Self, Result, FSkip);

end; {function, GetValue}


{@TppDimension.ShowSubTotals
 Sets the Visible property of all subtotal components within a dimension to
 either True or False.}

procedure TppDimension.ShowSubTotals(aValue: Boolean);
var
  liIndex: Integer;
begin
  for liIndex := 0 to SubTotalCount - 1 do
    SubTotals[liIndex].Visible := aValue;
end; {procedure, ShowSubTotals}

{******************************************************************************
 *
 ** C O L U M N   D E F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppColumnDef.Create }

constructor TppColumnDef.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctColumnDef);

  Alignment := taLeftJustify;

end; {constructor, Create}

{******************************************************************************
 *
 ** R O W   D E F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRowDef.Create }

constructor TppRowDef.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctRowDef);

  Alignment := taLeftJustify;

end; {constructor, Create}

{******************************************************************************
 *
 ** V A L U E   D E F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppValueDef.Create }

constructor TppValueDef.Create(aOwner: TComponent);
var
  lElement: TppElement;
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctValueDef);

  Alignment := taRightJustify;

  lElement := TppValueCaptionDef.Create(Self);
  lElement.Parent := Self;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppValueDef.Destroy }

destructor TppValueDef.Destroy;
begin

  FCaptionDef.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppValueDef.SetDisplayFormat }

procedure TppValueDef.SetDisplayFormat(const aFormat: String);
var
  lCrossTab: TppCrossTab;
  liIndex: Integer;
  liIndex2: Integer;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      inherited SetDisplayFormat(aFormat);

      Exit;
    end;

  lCrossTab := CrossTab;

  if (lCrossTab = nil) then Exit;

  liIndex := CrossTab.IndexOfChild(Self);

  lCrossTab.ColumnGrandTotals[liIndex].TotalDef.DisplayFormat := aFormat;
  lCrossTab.RowGrandTotals[liIndex].TotalDef.DisplayFormat := aFormat;

  for liIndex2 := 0 to lCrossTab.ColumnDefCount - 1 do
    lCrossTab.ColumnDefs[liIndex2].SubTotals[liIndex].TotalDef.DisplayFormat := aFormat;

  for liIndex2 := 0 to lCrossTab.RowDefCount - 1 do
    lCrossTab.RowDefs[liIndex2].SubTotals[liIndex].TotalDef.DisplayFormat := aFormat;
    
  inherited SetDisplayFormat(aFormat);

end; {procedure, SetDisplayFormat}

{------------------------------------------------------------------------------}
{ TppValueDef.GetSkipNulls }

function TppValueDef.GetSkipNulls: Boolean;
begin
  Result := FCaptionDef.SkipNulls;
end; {function, GetSkipNulls}

{------------------------------------------------------------------------------}
{ TppValueDef.SetSkipNulls }

procedure TppValueDef.SetSkipNulls(aValue: Boolean);
begin
  FCaptionDef.SkipNulls := aValue;
  DoOnChange;

  Modified;

end; {procedure, SetSkipNulls}

{------------------------------------------------------------------------------}
{ TppValueDef.GetCalcType }

function TppValueDef.GetCalcType: TppDBCalcType;
begin
  Result := FCaptionDef.CalcType;
end; {function, GetCalcType}

{------------------------------------------------------------------------------}
{ TppValueDef.SetCalcType }

procedure TppValueDef.SetCalcType(aCalcType: TppDBCalcType);
begin
  FCaptionDef.CalcType := aCalcType;

  DoOnChange;

  Modified;

end; {procedure, SetCalcType}

{------------------------------------------------------------------------------}
{ TppValueDef.Assign }

procedure TppValueDef.Assign(Source: TPersistent);
var
  lValueDef: TppValueDef;
begin

  inherited Assign(Source);

  if not(Source is TppValueDef) then Exit;

  lValueDef := TppValueDef(Source);

  FDisplayFormat := lValueDef.DisplayFormat;

  FCaptionDef.Assign(lValueDef.CaptionDef);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppValueDef.SaveComponents }

procedure TppValueDef.SaveComponents(Proc: TGetChildProc);
begin

  inherited SaveComponents(Proc);

  Proc(FCaptionDef);

end; {procedure, SaveComponents}


{@TppValueDef.AddChild
 The only child of a value dimension is a ValueCaptionDef.  This method is
 called automatically when a value dimension creates its ValueCaptionDef object.
 You should never need to call this method.}

procedure TppValueDef.AddChild(aChild: TppRelative);
begin

  if (aChild is TppValueCaptionDef) then
    FCaptionDef := TppValueCaptionDef(aChild)

  else
    inherited AddChild(aChild);

end; {procedure, AddChild}


{@TppValueDef.RemoveChild
 The only child of a value dimension is a ValueCaptionDef.  This method is
 called automatically when a value dimension frees its ValueCaptionDef object.
 You should never need to call this method.}

function TppValueDef.RemoveChild(aChild: TppRelative): Integer;
begin

  Result := 0;

  if (aChild is TppValueCaptionDef) then
    FCaptionDef := nil

  else
    Result := inherited RemoveChild(aChild);

end; {procedure, RemoveChild}

{------------------------------------------------------------------------------}
{ TppValueDef.GetDataType }

function TppValueDef.GetDataType: TppDataType;
begin

  if (CalcType = dcCount) then
    Result := dtInteger
  else
    Result := GetFieldDataType;

end; {function, GetDataType}

{------------------------------------------------------------------------------}
{ TppValueDef.GetName }

function TppValueDef.GetName: String;
begin

  Result := inherited GetName;

  {if event handler did not change default behavior, then continue}
  if (Result = FieldAlias) then
    begin
      case CalcType of
        dcCount:   Result := ppLoadStr(1028); {'Count'}
        dcSum:     Result := ppLoadStr(1029); {'Sum'}
        dcMinimum: Result := ppLoadStr(1030); {'Minimum'}
        dcMaximum: Result := ppLoadStr(1031); {'Maximum'}
        dcAverage: Result := ppLoadStr(1032); {'Average'}
      end;

      if (CalcType in [dcCount, dcSum]) then
        Result := Result + ' ' + ppLoadStr(16) + ' ' + FieldAlias {'of'}
      else
        Result := Result + ' ' + FieldAlias;

    end;

end; {function, GetName}

{------------------------------------------------------------------------------}
{ TppValueDef.GetDesignName }

function TppValueDef.GetDesignName: String;
begin
  Result := ctDataTypeToDisplayString(GetDataType, DisplayFormat);
end; {function, GetDesignName}


{@TppValueDef.DoOnCalcValue
 This method is called by the crosstab engine and triggers the
 OnCalcDimensionValue in the crosstab component.  You should never need to call
 this method.}

procedure TppValueDef.DoOnCalcValue(var aValue: Variant);
begin
  CrossTab.DoOnCalcDimensionValue(Self, aValue);
end; {procedure, DoOnCalcValue}

{******************************************************************************
 *
 ** T O T A L   D E F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTotalDef.Create }

constructor TppTotalDef.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctTotalDef);

  Alignment := taRightJustify;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTotalDef.GetName }

function TppTotalDef.GetName: String;
var
  lValueDef: TppValueDef;
  lDataType: TppDataType;
begin

  if (Parent is TppSubTotal) then
    begin
      lValueDef := TppSubTotal(Parent).GetValueDef;

      lDataType := lValueDef.GetDataType;

      Result := ctDataTypeToDisplayString(lDataType, DisplayFormat);
    end
    
  else if (Parent is TppGrandTotal) then
    begin
      lValueDef := TppGrandTotal(Parent).GetValueDef;

      lDataType := lValueDef.GetDataType;

      Result := ctDataTypeToDisplayString(lDataType, DisplayFormat);
    end;

end; {function, GetName}

{------------------------------------------------------------------------------}
{ TppTotalDef.GetDesignName }

function TppTotalDef.GetDesignName: String;
begin

  Result := GetName;
  
  if (Parent is TppSubTotal) then
    begin
      if (Parent.Parent is TppColumnDef) then
        Result := '<newline>' + Result;
    end

  else if (Parent is TppGrandTotal) then
    begin
      if (CrossTab.IndexOfColumnGrandTotal(TppGrandTotal(Parent)) <> -1) then
        Result := '<newline>' + Result;
    end;

end; {function, GetDesignName}

{------------------------------------------------------------------------------}
{ TppTotalDef.GetDataType }

function TppTotalDef.GetDataType: TppDataType;
var
  lSubTotal: TppSubTotal;
  lGrandTotal: TppGrandTotal;
begin

  Result := dtNotKnown;
  
  if (Parent is TppSubTotal) then
    begin
      lSubTotal := TppSubTotal(Parent);

      Result := lSubTotal.GetValueDef.GetDataType;
    end
  else if (Parent is TppGrandTotal) then
    begin
      lGrandTotal := TppGrandTotal(Parent);

      Result := lGrandTotal.GetValueDef.GetDataType;
    end;

end; {function, GetDataType}

{******************************************************************************
 *
 ** V A L U E   C A P T I O N   D E F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppValueCaptionDef.Create }

constructor TppValueCaptionDef.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctValueCaptionDef);

  Alignment := taLeftJustify;

  FCalcType := dcSum;
  FSkipNulls := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppValueCaptionDef.Assign }

procedure TppValueCaptionDef.Assign(Source: TPersistent);
var
  lValueCaptionDef: TppValueCaptionDef;
begin

  inherited Assign(Source);

  if not(Source is TppValueCaptionDef) then Exit;

  lValueCaptionDef := TppValueCaptionDef(Source);

  FCalcType := lValueCaptionDef.CalcType;
  FSkipNulls := lValueCaptionDef.SkipNulls;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppValueCaptionDef.SetCalcType }

procedure TppValueCaptionDef.SetCalcType(aCalcType: TppDBCalcType);
begin

  FCalcType := aCalcType;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  {if the field is not numeric, then 'Count' is the only valid CalcType}
  if (FCalcType <> dcCount) and not(TppValueDef(Parent).GetFieldDataType in ppNumerics) then
    FCalcType := dcCount;

  DoOnChange;

  Modified;

end; {procedure, SetCalcType}

{------------------------------------------------------------------------------}
{ TppValueCaptionDef.SetSkipNulls }

procedure TppValueCaptionDef.SetSkipNulls(aValue: Boolean);
begin

  FSkipNulls := aValue;

  DoOnChange;

  Modified;

end; {procedure, SetSkipNulls}

{------------------------------------------------------------------------------}
{ TppValueCaptionDef.GetName }

function TppValueCaptionDef.GetName: String;
begin
  Result := TppValueDef(Parent).GetName;
end; {function, GetName}

{------------------------------------------------------------------------------}
{ TppValueCaptionDef.GetDesignName }

function TppValueCaptionDef.GetDesignName: String;
begin
  Result := TppValueDef(Parent).GetName;
end; {function, GetDesignName}

{******************************************************************************
 *
 ** T O T A L   C A P T I O N   D E F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTotalCaptionDef.Create }

constructor TppTotalCaptionDef.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctTotalCaptionDef);

  Alignment := taLeftJustify;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTotalCaptionDef.GetName }

function TppTotalCaptionDef.GetName: String;
var
  lSubTotal: TppSubTotal;
  lGrandTotal: TppGrandTotal;
begin

  if (Parent is TppSubTotal) then
    begin
      lSubTotal := TppSubTotal(Parent);

      Result := lSubTotal.GetDimension.GetName + ' '+ ppLoadStr(75); {'Subtotal'}

      if (CrossTab.ValueDefCount > 1) and (lSubTotal.Parent is TppRowDef) then
        begin
          Result := Result + ' (' + lSubTotal.GetValueDef.GetName + ')';

          FAlignment := taLeftJustify;
        end;
    end
  else if (Parent is TppGrandTotal) then
    begin
      lGrandTotal := TppGrandTotal(Parent);

      Result := ppLoadStr(72); {'Grand Total'}

      if (CrossTab.ValueDefCount > 1) and (CrossTab.IndexOfRowGrandTotal(lGrandTotal) <> -1) then
        begin
          Result := Result + ' (' + lGrandTotal.GetValueDef.GetName + ')';

          FAlignment := taLeftJustify;
        end;
    end;

end; {function, GetName}

{******************************************************************************
 *
 ** T O T A L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTotal.Create }

constructor TppTotal.Create(aOwner: TComponent);
var
  lElement: TppElement;
begin

  inherited Create(aOwner);

  lElement := TppTotalCaptionDef.Create(Self);
  lElement.Parent := Self;

  lElement := TppTotalDef.Create(Self);
  lElement.Parent := Self;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTotal.Destroy }

destructor TppTotal.Destroy;
begin

  FCaptionDef.Free;
  FTotalDef.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppTotal.GetChildOwner }

function TppTotal.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppTotal.GetVisible }

function TppTotal.GetVisible: Boolean;
begin
  Result := FCaptionDef.Visible;
end; {function, GetVisible}

{------------------------------------------------------------------------------}
{ TppTotal.SetVisible }

procedure TppTotal.SetVisible(aValue: Boolean);
begin
  FCaptionDef.Visible := aValue;
  FTotalDef.Visible := aValue;
end; {procedure, SetVisible}


{@TppTotal.Assign
 Copies the contents of one total component to another, include the property
 values of the CaptionDef and TotalDef components}

procedure TppTotal.Assign(Source: TPersistent);
var
  lTotal: TppTotal;
begin

  if not(Source is TppTotal) then
    inherited Assign(Source);

  lTotal := TppTotal(Source);

  FCaptionDef.Assign(lTotal.CaptionDef);
  FTotalDef.Assign(lTotal.TotalDef);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppTotal.SaveComponents }

procedure TppTotal.SaveComponents(Proc: TGetChildProc);
begin

  inherited SaveComponents(Proc);

  Proc(FCaptionDef);
  Proc(FTotalDef);

end; {procedure, SaveComponents}


{@TppTotal.AddChild
 The only children of a total component are the TotalDef and CaptionDef
 components.  This method is called automatically when the total component
 creates these children.  You should never need to call this method.}

procedure TppTotal.AddChild(aChild: TppRelative);
begin

  if (aChild is TppTotalCaptionDef) then
    FCaptionDef := TppTotalCaptionDef(aChild)

  else if (aChild is TppTotalDef) then
    FTotalDef := TppTotalDef(aChild)

  else
    inherited AddChild(aChild);

end; {procedure, AddChild}


{@TppTotal.RemoveChild
 The only children of a total component are the TotalDef and CaptionDef
 components.  This method is called automatically when the total component frees
 these children.  You should never need to call this method.}

function TppTotal.RemoveChild(aChild: TppRelative): Integer;
begin

  Result := 0;

  if (aChild is TppTotalCaptionDef) then
    FCaptionDef := nil

  else if (aChild is TppTotalDef) then
    FTotalDef := nil

  else
    Result := inherited RemoveChild(aChild);

end; {procedure, RemoveChild}

{------------------------------------------------------------------------------}
{ TppTotal.GetValueDefIndex }

function TppTotal.GetValueDefIndex: Integer;
begin
  Result := Parent.IndexOfChild(Self);
end; {procedure, GetValueDefIndex}


{@TppTotal.GetValueDef
 Returns the ValueDef component with which the total corresponds.  Grand totals
 correspond to a value dimension only. Subtotals correspond to both a value
 dimension and a row or column dimension.}

function TppTotal.GetValueDef: TppValueDef;
var
  liIndex: Integer;
begin

  liIndex := ValueDefIndex;

   if (liIndex <> -1) then
    Result := CrossTab.ValueDefs[ValueDefIndex]
  else
    Result := nil;

end; {function, GetValueDef}


{@TppTotal.CrossTab
 Returns the crosstab component with which the total is associated.}

function TppTotal.CrossTab: TppCrossTab;
begin

  if Parent is TppCrossTab then
    Result := TppCrossTab(Parent)

  else if (Parent <> nil) and (Parent.Parent is TppCrossTab) then
    Result := TppCrossTab(Parent.Parent)

  else
    Result := nil;

end; {function, CrossTab}

{******************************************************************************
 *
 ** S U B T O T A L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubTotal.Create }

constructor TppSubTotal.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ChildType := Ord(ctctSubTotal);

end; {constructor, Create}


{@TppSubTotal.GetDimension
 Returns the row or column dimension with which a subtotal is associated.}

function TppSubTotal.GetDimension: TppDimension;
begin
  Result := TppDimension(Parent);
end; {function, GetDimension}

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
 ** C R O S S T A B   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.RefClass }

class function TraTppCrossTabRTTI.RefClass: TClass;
begin
  Result := TppCrossTab;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.GetPropList }

class procedure TraTppCrossTabRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.GetPropRec }

class function TraTppCrossTabRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if (CompareText(aPropName, 'BeforeCalc') = 0) then
    EventToRec(aPropName, ciCrossTabBeforeCalc, True, aPropRec)

  else if (CompareText(aPropName, 'AfterCalc') = 0) then
    EventToRec(aPropName, ciCrossTabAfterCalc, True, aPropRec)

  else if (CompareText(aPropName, 'OnCalcDimensionValue') = 0) then
    EventToRec(aPropName, ciCrossTabCalcDimensionValue, True, aPropRec)

  else if (CompareText(aPropName, 'OnCompareDimensionValues') = 0) then
    EventToRec(aPropName, ciCrossTabCompareDimensionValues, True, aPropRec)

  else if (CompareText(aPropName, 'OnFormatCell') = 0) then
    EventToRec(aPropName, ciCrossTabFormatCell, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetCaptionText') = 0) then
    EventToRec(aPropName, ciCrossTabGetCaptionText, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetDimensionName') = 0) then
    EventToRec(aPropName, ciCrossTabGetDimensionName, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetDimensionCaption') = 0) then
    EventToRec(aPropName, ciCrossTabGetDimensionCaption, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetDimensionValue') = 0) then
    EventToRec(aPropName, ciCrossTabGetDimensionValue, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetTotalCaptionText') = 0) then
    EventToRec(aPropName, ciCrossTabGetTotalCaptionText, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetTotalValueText') = 0) then
    EventToRec(aPropName, ciCrossTabGetTotalValueText, True, aPropRec)

  else if (CompareText(aPropName, 'OnGetValueText') = 0) then
    EventToRec(aPropName, ciCrossTabGetValueText, True, aPropRec)

  else if (CompareText(aPropName, 'OnTraverseRecord') = 0) then
    EventToRec(aPropName, ciCrossTabTraverseRecord, True, aPropRec)


  {properties}
  else if (CompareText(aPropName, 'Calculating') = 0) then
     PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'ColumnDefCount') = 0) then
     PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'ColumnDefs') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'ColumnGrandTotalCount') = 0) then
     PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'ColumnGrandTotals') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Matrix') = 0) then
     ClassPropToRec(aPropName, TppMatrix, True, aPropRec)

  else if (CompareText(aPropName, 'Modified') = 0) then
     PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'RowDefCount') = 0) then
     PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'RowDefs') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'RowGrandTotalCount') = 0) then
     PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'RowGrandTotals') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'ValueDefCount') = 0) then
     PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'ValueDefs') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Draw') = 0) then
     PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'GridLines') = 0) then
     PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Pagination') = 0) then
    EnumPropToRec(aPropName, 'TppCrossTabPaginationType', False, aPropRec)

  else if (CompareText(aPropName, 'Style') = 0) then
     PropToRec(aPropName, daString, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.GetParams }

class function TraTppCrossTabRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  {events}
  if (CompareText(aMethodName, 'OnCalcDimensionValue') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDimension', daClass, TppDimension, '', False, False);
      Result.AddParam('aValue', daVariant, nil, '', False, True);
    end
    
  else if (CompareText(aMethodName, 'OnCompareDimensionValues') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDimension', daClass, TppDimension, '', False, False);
      Result.AddParam('aValue1', daVariant, nil, '', False, False);
      Result.AddParam('aValue2', daVariant, nil, '', False, False);
      Result.AddParam('aResult', daInteger, nil, '', False, True);
    end

  else if (CompareText(aMethodName, 'OnFormatCell') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aElement', daClass, TppElement, '', False, False);
      Result.AddParam('aColumn', daInteger, nil, '', False, False);
      Result.AddParam('aRow', daInteger, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'OnGetCaptionText') = 0) or
          (CompareText(aMethodName, 'OnGetTotalValueText') = 0) or
          (CompareText(aMethodName, 'OnGetValueText') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aElement', daClass, TppElement, '', False, False);
      Result.AddParam('aColumn', daInteger, nil, '', False, False);
      Result.AddParam('aRow', daInteger, nil, '', False, False);
      Result.AddParam('aDisplayFormat', daString, nil, '', True, False);
      Result.AddParam('aValue', daVariant, nil, '', False, False);
      Result.AddParam('aText', daString, nil, '', False, True);
    end

  else if (CompareText(aMethodName, 'OnGetDimensionName') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDimension', daClass, TppDimension, '', False, False);
      Result.AddParam('aName', daString, nil, '', False, True);
    end

  else if (CompareText(aMethodName, 'OnGetDimensionCaption') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDimension', daClass, TppDimension, '', False, False);
      Result.AddParam('aCaption', daString, nil, '', False, True);
    end

  else if (CompareText(aMethodName, 'OnGetDimensionValue') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDimension', daClass, TppDimension, '', False, False);
      Result.AddParam('aValue', daVariant, nil, '', False, True);
      Result.AddParam('aSkip', daBoolean, nil, '', False, True);
    end

  else if (CompareText(aMethodName, 'OnGetTotalCaptionText') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aElement', daClass, TppElement, '', False, False);
      Result.AddParam('aColumn', daInteger, nil, '', False, False);
      Result.AddParam('aRow', daInteger, nil, '', False, False);
      Result.AddParam('aText', daString, nil, '', False, True);
    end

  else if (CompareText(aMethodName, 'OnTraverseRecord') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDataPipeline', daClass, TppDataPipeline, '', False, False);
      Result.AddParam('aSkipRecord', daBoolean, nil, '', False, True);
    end


  {properties}
  else if (CompareText(aMethodName, 'ColumnDefs') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppColumnDef, '', False, False);
    end

  else if (CompareText(aMethodName, 'ColumnGrandTotals') = 0) or
          (CompareText(aMethodName, 'RowGrandTotals') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppGrandTotal, '', False, False);
    end

  else if (CompareText(aMethodName, 'RowDefs') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppRowDef, '', False, False);
    end

  else if (CompareText(aMethodName, 'ValueDefs') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppValueDef, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.CallMethod }

class function TraTppCrossTabRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lCrossTab: TppCrossTab;
  liIndex: Integer;
  lColumn: TppColumnDef;
  lRow: TppRowDef;
  lValue: TppValueDef;
  lTotal: TppGrandTotal;
begin

  Result := True;
  
  lCrossTab := TppCrossTab(aObject);

  if (CompareText(aMethodName, 'ColumnDefs') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lColumn := lCrossTab.ColumnDefs[liIndex];

      aParams.SetParamValue(1, Integer(lColumn));
    end

  else if (CompareText(aMethodName, 'RowDefs') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lRow := lCrossTab.RowDefs[liIndex];

      aParams.SetParamValue(1, Integer(lRow));
    end

  else if (CompareText(aMethodName, 'ValueDefs') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lValue := lCrossTab.ValueDefs[liIndex];

      aParams.SetParamValue(1, Integer(lValue));
    end

  else if (CompareText(aMethodName, 'RowGrandTotals') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lTotal := lCrossTab.RowGrandTotals[liIndex];

      aParams.SetParamValue(1, Integer(lTotal));
    end

  else if (CompareText(aMethodName, 'ColumnGrandTotals') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lTotal := lCrossTab.ColumnGrandTotals[liIndex];

      aParams.SetParamValue(1, Integer(lTotal));
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.GetPropValue }

class function TraTppCrossTabRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Calculating') = 0) then
    Boolean(aValue) := TppCrossTab(aObject).Calculating

  else if (CompareText(aPropName, 'ColumnDefCount') = 0) then
    Integer(aValue) := TppCrossTab(aObject).ColumnDefCount

  else if (CompareText(aPropName, 'ColumnGrandTotalCount') = 0) then
    Integer(aValue) := TppCrossTab(aObject).ColumnGrandTotalCount

  else if (CompareText(aPropName, 'Matrix') = 0) then
    Integer(aValue) := Integer(TppCrossTab(aObject).Matrix)

  else if (CompareText(aPropName, 'Modified') = 0) then
    Boolean(aValue) := TppCrossTab(aObject).Modified

  else if (CompareText(aPropName, 'RowDefCount') = 0) then
    Integer(aValue) := TppCrossTab(aObject).RowDefCount

  else if (CompareText(aPropName, 'RowGrandTotalCount') = 0) then
    Integer(aValue) := TppCrossTab(aObject).RowGrandTotalCount

  else if (CompareText(aPropName, 'ValueDefCount') = 0) then
    Integer(aValue) := TppCrossTab(aObject).ValueDefCount

  else if (CompareText(aPropName, 'Draw') = 0) then
    Boolean(aValue) := TppCrossTab(aObject).Draw

  else if (CompareText(aPropName, 'GridLines') = 0) then
    Boolean(aValue) := TppCrossTab(aObject).GridLines

  else if (CompareText(aPropName, 'Pagination') = 0) then
    Integer(aValue) := Ord(TppCrossTab(aObject).Pagination)

  else if (CompareText(aPropName, 'Style') = 0) then
    String(aValue) := TppCrossTab(aObject).Style

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCrossTabRTTI.SetPropValue }

class function TraTppCrossTabRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Draw') = 0) then
    TppCrossTab(aObject).Draw := Boolean(aValue)

  else if (CompareText(aPropName, 'GridLines') = 0) then
    TppCrossTab(aObject).GridLines := Boolean(aValue)

  else if (CompareText(aPropName, 'Pagination') = 0) then
    TppCrossTab(aObject).Pagination := TppCrossTabPaginationType(aValue)

  else if (CompareText(aPropName, 'Style') = 0) then
    TppCrossTab(aObject).Style := String(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** E L E M E N T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.RefClass }

class function TraTppElementRTTI.RefClass: TClass;
begin
  Result := TppElement;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.GetPropList }

class procedure TraTppElementRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {parameters: Name, DataType, Class, IsPublished, IsReadOnly}
  aPropList.AddProp('Alignment');
  aPropList.AddProp('Color');
  aPropList.AddProp('DisplayFormat');
  aPropList.AddProp('ElementIndex');
  aPropList.AddProp('Font');
  aPropList.AddProp('Height');
  aPropList.AddProp('Left');
  aPropList.AddProp('Top');
  aPropList.AddProp('Width');
  aPropList.AddProp('TextHeight');
  aPropList.AddProp('TextWidth');
  aPropList.AddProp('Visible');

  {add public methods}
  aPropList.AddMethod('GetName');
  aPropList.AddMethod('GetDataType');
  aPropList.AddMethod('GetDesignName');
  aPropList.AddMethod('HasDisplayFormat');
  aPropList.AddMethod('Modified');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.GetPropRec }

class function TraTppElementRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;


  {methods}
  if (CompareText(aPropName, 'GetName') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetDataType') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetDesignName') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'HasDisplayFormat') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Modified') = 0) then
    MethodToRec(aPropName, False, aPropRec)


  {properties}
  else if (CompareText(aPropName, 'Alignment') = 0) then
    EnumPropToRec(aPropName, 'TAlignment', False, aPropRec)

  else if (CompareText(aPropName, 'Color') = 0) then
    EnumPropToRec(aPropName, 'TColor', False, aPropRec)

  else if (CompareText(aPropName, 'DisplayFormat') = 0) then
     PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'ElementIndex') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Font') = 0) then
    ClassPropToRec(aPropName, TFont, False, aPropRec)

  else if (CompareText(aPropName, 'Height') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Left') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Top') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Width') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'TextHeight') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'TextWidth') = 0) then
     PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Visible') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.GetParams }

class function TraTppElementRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  {methods}
  if (CompareText(aMethodName, 'GetName') = 0) or
     (CompareText(aMethodName, 'GetDesignName') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daString, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'GetDataType') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daEnum, nil, 'TppDataType', False, False);
    end

  else if (CompareText(aMethodName, 'HasDisplayFormat') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.CallMethod }

class function TraTppElementRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lElement: TppElement;
  lString: String;
  lBoolean: Boolean;
  lDataType: TppDataType;
begin

  Result := True;

  lElement := TppElement(aObject);

  if (CompareText(aMethodName, 'GetName') = 0) then
    begin
      lString := lElement.GetName;

      aParams.SetParamValue(0, lString);
    end

  else if (CompareText(aMethodName, 'GetDataType') = 0) then
    begin
      lDataType := lElement.GetDataType;

      aParams.SetParamValue(0, lDataType);
    end

  else if (CompareText(aMethodName, 'GetDesignName') = 0) then
    begin
      lString := lElement.GetDesignName;

      aParams.SetParamValue(0, lString);
    end

  else if (CompareText(aMethodName, 'HasDisplayFormat') = 0) then
    begin
      lBoolean := lElement.HasDisplayFormat;

      aParams.SetParamValue(0, lBoolean);
    end

  else if (CompareText(aMethodName, 'Modified') = 0) then
    lElement.Modified

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.GetPropValue }

class function TraTppElementRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Alignment') = 0) then
    Integer(aValue) := Ord(TppElement(aObject).Alignment)

  else if (CompareText(aPropName, 'Color') = 0) then
    Integer(aValue) := Ord(TppElement(aObject).Color)

  else if (CompareText(aPropName, 'DisplayFormat') = 0) then
    String(aValue) := TppElement(aObject).DisplayFormat

  else if (CompareText(aPropName, 'ElementIndex') = 0) then
    Integer(aValue) := TppElement(aObject).ElementIndex

  else if (CompareText(aPropName, 'Font') = 0) then
    Integer(aValue) := Integer(TppElement(aObject).Font)

  else if (CompareText(aPropName, 'Height') = 0) then
    Integer(aValue) := TppElement(aObject).Height

  else if (CompareText(aPropName, 'Left') = 0) then
    Integer(aValue) := TppElement(aObject).Left

  else if (CompareText(aPropName, 'Width') = 0) then
    Integer(aValue) := TppElement(aObject).Width

  else if (CompareText(aPropName, 'TextHeight') = 0) then
    Integer(aValue) := TppElement(aObject).TextHeight

  else if (CompareText(aPropName, 'TextWidth') = 0) then
    Integer(aValue) := TppElement(aObject).TextWidth

  else if (CompareText(aPropName, 'Visible') = 0) then
    Integer(aValue) := Ord(TppElement(aObject).Visible)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppElementRTTI.SetPropValue }

class function TraTppElementRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Alignment') = 0) then
    TppElement(aObject).Alignment := TAlignment(aValue)

  else if (CompareText(aPropName, 'Color') = 0) then
    TppElement(aObject).Color := TColor(aValue)

  else if (CompareText(aPropName, 'DisplayFormat') = 0) then
    TppElement(aObject).DisplayFormat := String(aValue)

  else if (CompareText(aPropName, 'ElementIndex') = 0) then
    TppElement(aObject).ElementIndex := Integer(aValue)

  else if (CompareText(aPropName, 'Font') = 0) then
    TppElement(aObject).Font := TFont(aValue)

  else if (CompareText(aPropName, 'Height') = 0) then
    TppElement(aObject).Height := Integer(aValue)

  else if (CompareText(aPropName, 'Left') = 0) then
    TppElement(aObject).Left := Integer(aValue)

  else if (CompareText(aPropName, 'Width') = 0) then
    TppElement(aObject).Width := Integer(aValue)

  else if (CompareText(aPropName, 'TextHeight') = 0) then
    TppElement(aObject).TextHeight := Integer(aValue)

  else if (CompareText(aPropName, 'TextWidth') = 0) then
    TppElement(aObject).TextWidth := Integer(aValue)

  else if (CompareText(aPropName, 'Visible') = 0) then
    TppElement(aObject).Visible := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** D I M E N S I O N   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.RefClass }

class function TraTppDimensionRTTI.RefClass: TClass;
begin
  Result := TppDimension;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.GetPropList }

class procedure TraTppDimensionRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('NullOrder');
  aPropList.AddProp('Skip');
  aPropList.AddProp('SkipNulls');
  aPropList.AddProp('SubTotalCount');
  aPropList.AddProp('SubTotals');
  aPropList.AddProp('SortType');

  {add public methods}
  aPropList.AddMethod('Clear');
  aPropList.AddMethod('GetCaption');
  aPropList.AddMethod('GetFieldDataType');
  aPropList.AddMethod('GetIndex');
  aPropList.AddMethod('GetValue');
  aPropList.AddMethod('ShowSubTotals');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.GetPropRec }

class function TraTppDimensionRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {methods}
  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'GetCaption') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetFieldDataType') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetValue') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'ShowSubTotals') = 0) then
    MethodToRec(aPropName, True, aPropRec)


  {properties}
  else if (CompareText(aPropName, 'NullOrder') = 0) then
    EnumPropToRec(aPropName, 'TppNullOrderType', False, aPropRec)

  else if (CompareText(aPropName, 'Skip') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'SkipNulls') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'SubTotalCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'SubTotals') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'SortType') = 0) then
    EnumPropToRec(aPropName, 'TppSortOrderType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.GetParams }

class function TraTppDimensionRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  {methods}
  if (CompareText(aMethodName, 'GetCaption') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daString, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'GetFieldDataType') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daEnum, nil, 'TppDataType', False, False);
    end

  else if (CompareText(aMethodName, 'GetIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daInteger, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'GetValue') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daVariant, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'ShowSubTotals') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aValue', daBoolean, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'SubTotals') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppSubTotal, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.CallMethod }

class function TraTppDimensionRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lDimension: TppDimension;
  lString: String;
  lBoolean: Boolean;
  lDataType: TppDataType;
  lInteger: Integer;
  lObject: Integer;
  lVariant: Variant;
  liIndex: Integer;
begin

  Result := True;

  lDimension := TppDimension(aObject);

  if (CompareText(aMethodName, 'Clear') = 0) then
    lDimension.Clear

  else if (CompareText(aMethodName, 'GetCaption') = 0) then
    begin
      lString := lDimension.GetCaption;

      aParams.SetParamValue(0, lString);
    end

  else if (CompareText(aMethodName, 'GetFieldDataType') = 0) then
    begin
      lDataType := lDimension.GetFieldDataType;

      aParams.SetParamValue(0, lDataType);
    end

  else if (CompareText(aMethodName, 'GetIndex') = 0) then
    begin
      lInteger := lDimension.GetIndex;

      aParams.SetParamValue(0, lInteger);
    end

  else if (CompareText(aMethodName, 'GetValue') = 0) then
    begin
      lVariant := lDimension.GetValue;

      aParams.SetParamValue(0, lVariant);
    end

  else if (CompareText(aMethodName, 'ShowSubTotals') = 0) then
    begin
      aParams.GetParamValue(0, lBoolean);

      lDimension.ShowSubTotals(lBoolean);
    end

  else if (CompareText(aMethodName, 'SubTotals') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lObject := Integer(lDimension.SubTotals[liIndex]);

      aParams.SetParamValue(1, lObject);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.GetPropValue }

class function TraTppDimensionRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'NullOrder') = 0) then
    TppNullOrderType(aValue) := TppDimension(aObject).NullOrder

  else if (CompareText(aPropName, 'Skip') = 0) then
    Boolean(aValue) := TppDimension(aObject).Skip

  else if (CompareText(aPropName, 'SkipNulls') = 0) then
    Boolean(aValue) := TppDimension(aObject).SkipNulls

  else if (CompareText(aPropName, 'SubTotalCount') = 0) then
    Integer(aValue) := TppDimension(aObject).SubTotalCount

  else if (CompareText(aPropName, 'SortType') = 0) then
    TppSortOrderType(aValue) := TppDimension(aObject).SortType

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDimensionRTTI.SetPropValue }

class function TraTppDimensionRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'NullOrder') = 0) then
    TppDimension(aObject).NullOrder := TppNullOrderType(aValue)

  else if (CompareText(aPropName, 'SkipNulls') = 0) then
    TppDimension(aObject).SkipNulls := Boolean(aValue)

  else if (CompareText(aPropName, 'SortType') = 0) then
    TppDimension(aObject).SortType := TppSortOrderType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** V A L U E  D E F   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppValueDefRTTI.RefClass }

class function TraTppValueDefRTTI.RefClass: TClass;
begin
  Result := TppValueDef;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppValueDefRTTI.GetPropList }

class procedure TraTppValueDefRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {parameters: Name, DataType, Class, IsPublished, IsReadOnly}
  aPropList.AddProp('CaptionDef');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppValueDefRTTI.GetPropRec }

class function TraTppValueDefRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {properties}
  if (CompareText(aPropName, 'CaptionDef') = 0) then
    ClassPropToRec(aPropName, TppValueCaptionDef, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppValueDefRTTI.GetPropValue }

class function TraTppValueDefRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CaptionDef') = 0) then
    Integer(aValue) := Integer(TppValueDef(aObject).CaptionDef)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{******************************************************************************
 *
 ** T O T A L   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppTotalRTTI.RefClass }

class function TraTppTotalRTTI.RefClass: TClass;
begin
  Result := TppTotal;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppTotalRTTI.GetPropList }

class procedure TraTppTotalRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props }
  aPropList.AddProp('CaptionDef');
  aPropList.AddProp('TotalDef');

  {add public methods}
  aPropList.AddMethod('CrossTab');
  aPropList.AddMethod('GetValueDef');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppTotalRTTI.GetPropRec }

class function TraTppTotalRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;


  {methods}
  if (CompareText(aPropName, 'CrossTab') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetValueDef') = 0) then
    MethodToRec(aPropName, True, aPropRec)


  {properties}
  else if (CompareText(aPropName, 'CaptionDef') = 0) then
    ClassPropToRec(aPropName, TppTotalCaptionDef, True, aPropRec)

  else if (CompareText(aPropName, 'TotalDef') = 0) then
    ClassPropToRec(aPropName, TppTotalDef, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppTotalRTTI.GetParams }

class function TraTppTotalRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  {methods}
  if (CompareText(aMethodName, 'CrossTab') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daClass, TppCrossTab, '', False, False);
    end

  else if (CompareText(aMethodName, 'GetValueDef') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daClass, TppValueDef, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppTotalRTTI.CallMethod }

class function TraTppTotalRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lTotal: TppTotal;
  lCrossTab: Integer;
  lValueDef: Integer;
begin

  Result := True;

  lTotal := TppTotal(aObject);

  if (CompareText(aMethodName, 'CrossTab') = 0) then
    begin
      lCrossTab := Integer(lTotal.CrossTab);

      aParams.SetParamValue(0, lCrossTab);
    end

  else if (CompareText(aMethodName, 'GetValueDef') = 0) then
    begin
      lValueDef := Integer(lTotal.GetValueDef);

      aParams.SetParamValue(0, lValueDef);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppTotalRTTI.GetPropValue }

class function TraTppTotalRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CaptionDef') = 0) then
    Integer(aValue) := Integer(TppTotal(aObject).CaptionDef)

  else if (CompareText(aPropName, 'TotalDef') = 0) then
    Integer(aValue) := Integer(TppTotal(aObject).TotalDef)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppColumnDef, TppRowDef, TppValueDef, TppGrandTotal, TppSubTotal,
                   TppTotalDef, TppTotalCaptionDef, TppValueCaptionDef]);

  ppRegisterComponent(TppCrossTab, 'Advanced Components', 2, 695, '', 0);

  raRegisterEnum('TppCrossTabPaginationType', TypeInfo(TppCrossTabPaginationType));
  raRegisterEnum('TppCrossTabChildType', TypeInfo(TppCrossTabChildType));
  raRegisterEnum('TppCrossTabPaginationType', TypeInfo(TppCrossTabPaginationType));
  raRegisterEnum('TppTotalType', TypeInfo(TppTotalType));
  raRegisterEnum('TppNullOrderType', TypeInfo(TppNullOrderType));

  raRegisterRTTI(TraTppCrossTabRTTI);
  raRegisterRTTI(TraTppElementRTTI);
  raRegisterRTTI(TraTppDimensionRTTI);
  raRegisterRTTI(TraTppValueDefRTTI);
  raRegisterRTTI(TraTppTotalRTTI);

finalization

  ppUnRegisterComponent(TppCrossTab);

  UnRegisterClasses([TppColumnDef, TppRowDef, TppValueDef, TppGrandTotal, TppSubTotal,
                     TppTotalDef, TppTotalCaptionDef, TppValueCaptionDef]);

  raUnRegisterEnum('TppCrossTabPaginationType');
  raUnRegisterEnum('TppCrossTabChildType');
  raUnRegisterEnum('TppCrossTabPaginationType');
  raUnRegisterEnum('TppTotalType');
  raUnRegisterEnum('TppNullOrderType');

  raUnRegisterRTTI(TraTppCrossTabRTTI);
  raUnRegisterRTTI(TraTppElementRTTI);
  raUnRegisterRTTI(TraTppDimensionRTTI);
  raUnRegisterRTTI(TraTppValueDefRTTI);
  raUnRegisterRTTI(TraTppTotalRTTI);

end.
