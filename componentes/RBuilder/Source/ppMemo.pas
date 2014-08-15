{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppMemo;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,

  ppClass,
  ppDB,
  ppDevice,
  ppStrtch,
  ppTypes,
  ppPrintr,
  ppUtils,
  ppPrnabl,
  ppDrwCmd,
  ppComm,
  ppRTTI;

type


  {@TppCustomMemo

    Ancestor from which all memo components descend. The standard memo
    components provided with ReportBuilder are:

            - TppDBMemo
            - TppMemo}

  {@TppCustomMemo.CharWrap

    Defaults to False. The CharWrap property determines if the individual
    characters of a word will be wrapped to the next line when a single word
    does fit within the width of the control.}

  {@TppCustomMemo.KeepTogether

    Defaults to False. The KeepTogether property controls the pagination of
    the memo when the contents cannot fit on the current page.  Normally
    the contents are printed to the bottom of the available page space and
    then continued on subsequents pages until complete.  If KeepTogether is
    True, the memo will advance to the next page when the contents do not
    fit.}

  {@TppCustomMemo.ForceJustifyLastLine

    Defaults to False. ForceJustifyLastLine determines whether the last line
    of a memo is justified. Applies only when TextAlignment is set
    to taFullJustified.}

  {@TppCustomMemo.Leading

    The Leading property (pronounced leding) controls the amount of space
    between lines in a TppMemo or TppDBMemo component. The default value is
    0.  Increasing the value of the Leading property will increase the
    amount of space between lines.  To space the lines less than the
    default, you may set Leading to a value less than zero.}

  {@TppCustomMemo.Lines

    The Lines property contains the lines of text that are printed by a
    memo report control..

    For a TppDBMemo, the Lines property is a run-time property only.}

    {@TppCustomMemo.PrintLines

    The PrintLines property contains the lines of text after they have been
    word-wrapped.  This property contains a valid value only after the band
    has printed.}

  {@TppCustomMemo.TabStopPositions

    The relative position of each tab stop specified in the ruler units of
    the report (these values should be in increasing order.) If a line of
    text contains more tabs then there are tab stop positions, tab
    positioning continues based on the windows default (eight characters of
    average width for the selected font.) If you specify only one tab stop,
    then that tab stop is used to position all of the tabs for the line.}

  {@TppCustomMemo.Save

    The Save property controls whether a textual component will be included
    when printing to a text file.  The order the component will be saved
    in, in relation to other components within the band is determined by
    the SaveOrder property.}

  {@TppCustomMemo.SaveLength

    When printing to a text file with the TextFileType set to
    ftFixedLength, the SaveLength property specifies the field size for the
    components text value.  If the component text value is greater than
    this length, it is truncated.  If the text value length is less than
    the SaveLength, then spaces are padded onto the value.  Spaces are
    padded on the left, right, or both(for centered) depending on the
    Alignment property of the component}

  {@TppCustomMemo.SaveOrder

    When printing to a text file with the property determines the relative
    position of the textual component within the line of text for the band.}

  TppCustomMemo = class(TppStretchable)
    private
      FAncestor: TppCustomMemo;
      FCharPos: Longint;
      FCharWrap: Boolean;
      FGetTabStopPositions: TStrings;
      FLeading: Longint;
      FLines: TStrings;
      FMemoStream: TMemoryStream;
      FPrintLines: TStrings;
      FSave: Boolean;
      FSaveLength: Integer;
      FSaveOrder: Integer;
      FTabStopPositions: TStrings;

      {read/write private 'fake' properties}
      procedure ReadLeading(Reader: TReader);
      procedure WriteLeading(Writer: TWriter);

      function  GetLeading: Single;
      function  GetSaveOrder: TTabOrder;
      function  GetScreenPixelLeading: Integer;
      function  GetTabStopPositions: TStrings;
      procedure SetCharWrap(Value: Boolean);
      procedure SetLeading(Value: Single);
      procedure SetSave(Value: Boolean);
      procedure SetSaveLength(Value: Integer);
      procedure SetSaveOrder(Value: TTabOrder);
      procedure SetTabStopPositions(Value: TStrings);

      {used for conversion to 3.0}
      procedure ReadPosition(Reader: TReader);

    protected
      procedure DefineProperties(Filer: TFiler); override;
      procedure FontChanged(Sender: TObject); override;
      function  GetLines: TStrings;
      function  GetMemo: TStrings; virtual;
      function  GetMemoStream: TMemoryStream; virtual;
      function  GetPrintLines: TStrings; virtual;
      procedure LoadMemo; virtual;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetMemo(Value: TStrings); virtual;
      procedure UpdateMemoStream;
      procedure WriteState(Writer: TWriter); override;


    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      function  AllowsJustification: Boolean; override;
      procedure CalcSpaceUsed; override;
      function  GetText: String; override;
      procedure SetText(Value: String); override;
      function  GetTextBuf: PChar; virtual;
      function  GetTheSaveOrder: TTabOrder;
      procedure Init; override;
      procedure LinesChanged;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      procedure UpdateSaveOrder(Value: TTabOrder);

      procedure Convert(aVersionNo: Integer); override;

      {Obsolete. Replaced by TextAlignment Property in version 5.1}
      property Alignment;


      property CharPos: Integer read FCharPos;
      property CharWrap: Boolean read FCharWrap write SetCharWrap;
      property Color;
      property Font;
      property Leading: Single read GetLeading write SetLeading stored False;
      property Lines: TStrings read GetMemo write SetMemo;
      property MemoStream: TMemoryStream read GetMemoStream;
      property mmLeading: Longint read FLeading;
      property PrintLines: TStrings read GetPrintLines;
      property spLeading: Integer read GetScreenPixelLeading;
      property TabStopPositions: TStrings read GetTabStopPositions write SetTabStopPositions;
      property ReprintOnOverFlow;
      property ShiftRelativeTo;
      property Stretch;
      property Text;
      property Transparent;
      property UserName;
      property Visible;

    published
      property ForceJustifyLastLine;
      property KeepTogether;
      property Save: Boolean read FSave write SetSave default False;
      property SaveLength: Integer read FSaveLength write SetSaveLength default 0;
      property SaveOrder: TTabOrder read GetSaveOrder write SetSaveOrder default -1;

  end; {class, TppCustomMemo}


{******************************************************************************
 *
 ** C U S T O M    M E M O   C L A S S E S
 *
{******************************************************************************}

  {@TppMemo

    The TppMemo component is a report control that prints multiple lines of
    text on a report.  The text of a memo is the value of its Lines
    property.  How the lines of  text align within the memo is determined
    by the value of the Alignment property.   The amount of space between
    the lines within the memo is determined by the value of the Leading
    property.  You can enable the height of the memo to stretch
    automatically by setting Stretch to True and the parent Band
    PrintHeight property to phDynamic.

    At design-time you can use the Report Designer's Format Bar to control
    the appearance of the report memo.  Use the Object Inspector to set the
    value of the Lines property. Press the right mouse button to access a
    speed menu and set other key properties for this control.}

  TppMemo = class(TppCustomMemo)
    protected
      procedure SetMemo(Value: TStrings); override;

    public
      constructor Create(AOwner: TComponent); override;

      {Obsolete. Replaced by TextAlignment Property in version 5.1}
      property Alignment;

    published
      property Anchors;
      property Border;
      property Caption;
      property CharWrap;
      property Color;
      property Font;
      property Leading;
      property Lines;
      property MinHeight;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property ReprintOnOverFlow;
      property ShiftRelativeTo;
      property Stretch;
      property TabStopPositions;
      property TextAlignment;
      property Transparent;
      property UserName;
      property Visible;

      {these properties saved in 'fake' properties}
      property BottomOffset stored False;
      property Height stored False;
      property Left stored False;
      property OverFlowOffset stored False;
      property Top stored False;
      property Width stored False;

  end; {class, TppMemo}


  {@TppDBMemo

    The TppDBMemo component is a data-aware report control that is used to
    print multiple lines of text from a database field, such as a BLOB
    field.  The database field that is printed is the value of the
    DataField property.  How the lines of  text align within the memo is
    determined by the value of the Alignment property.  The amount of space
    between the lines within the memo is determined by the value of the
    Leading property. You can force the height of the memo to stretch
    automatically by setting Stretch to True. (The parent Band's
    PrintHeight property must be set to phDynamic for stretching to take
    effect.)

    At design-time you can use the Report Designer's Format Bar to set the
    DataField property and to control the appearance of the report text.
    You can access the speedmenu by positioning the mouse cursor over the
    component and clicking the right mouse button.  The key properties for
    the component will be displayed.}

  {@TppDBMemo.OnGetMemo

    The OnGetMemo event fires before the data in the BLOB field is assigned
    to Lines property.  Use the OnGetMemo event when you want to manipulate
    the contents of the BLOB field and assign the resulting Lines manually.
    This would allow you to decompress a BLOB field and then assign the
    result to Lines.  If you create an OnGetMemo event handler, the DBMemo
    component will not attempt to assign the BLOB field to the Lines
    property at run-time.  In order suppress this same behavior at design-
    time, set the AutoDisplay property to False.}

  {@TppDBMemo.AutoDisplay

    The value of the AutoDisplay property determines whether to automatically
    display the contents of a BLOB in a database field in a TppDBMemo or
    TppDBImage component. If AutoDisplay is True (the default value), the
    component automatically displays new data when the underlying BLOB field
    changes (such as when moving to a new record). If AutoDisplay is False, the
    control clears whenever the underlying BLOB field changes.

    Note: You might want to change the value of AutoDisplay to False if the
    automatic loading of BLOB fields seems to take too long.}

  TppDBMemo = class(TppCustomMemo)
    private
      FAutoDisplay: Boolean;
      FOnGetMemo: TppMemoEvent;

      FAlreadyPrinted: Boolean;
      FPriorValue: String;
      FPriorValueSame: Boolean;
      FSuppressRepeatedValues: Boolean;

      procedure DoOnGetMemo(Sender: TObject; aLines: TStrings);
      procedure SetSuppressRepeatedValues(Value: Boolean);
      procedure UpdateValues;

    protected
      procedure SetDataField(const Value: String); override;

   public
      constructor Create(AOwner: TComponent); override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      function  IsDataAware: Boolean; override;
      procedure LoadMemo; override;

      procedure CalcSpaceUsed; override;
      procedure Clear; override;
      procedure Compute; override;
      procedure Init; override;
      function  IsCalc: Boolean; override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;

      property Alignment;
      property AlreadyPrinted: Boolean read FAlreadyPrinted write FAlreadyPrinted;
      property PriorValue: String read FPriorValue write FPriorValue;
      property PriorValueSame: Boolean read FPriorValueSame write FPriorValueSame;

    published
      property Anchors;
      property AutoDisplay: Boolean read FAutoDisplay write FAutoDisplay default True;
      property Border;
      property CharWrap;
      property Color;
      property DataField;
      property DataPipeline;
      property Font;
      property Leading;
      property MinHeight;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property OnGetMemo: TppMemoEvent read FOnGetMemo write FOnGetMemo;
      property ParentDataPipeline;
      property ReprintOnOverFlow;
      property ResetGroup;
      property ShiftRelativeTo;
      property Stretch;
      property SuppressRepeatedValues: Boolean read FSuppressRepeatedValues write SetSuppressRepeatedValues default False;
      property TabStopPositions;
      property TextAlignment;
      property Transparent;
      property UserName;
      property Visible;

      {these properties saved in 'fake' properties}
      property BottomOffset stored False;
      property Height stored False;
      property Left stored False;
      property OverFlowOffset stored False;
      property Top stored False;
      property Width stored False;

  end; {class, TppDBMemo}


{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppCustomMemoRTTI }
  TraTppCustomMemoRTTI = class(TraTppStretchableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCustomMemoRTTI}

  {@TraTppDBMemoRTTI }
  TraTppDBMemoRTTI = class(TraTppCustomMemoRTTI)
    public
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDBMemoRTTI}

  
implementation

uses
  ppRegion, ppPlainText, ppReport, ppSubRpt;

{******************************************************************************
 *
 ** C U S T O M   M E M O
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomMemo.Create }

constructor TppCustomMemo.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {init inherited properties}
  CacheRecordSize := SizeOf(TppCustomMemoSaveRec);
  DrawCommandClass := TppDrawText;

  FAncestor := nil;
  FCharPos           := 0;
  FCharWrap          := False;
  FLeading           := 0;
  FLines             := TStringList.Create;
  FMemoStream        := TMemoryStream.Create;
  FPrintLines        := TStringList.Create;
  FTabStopPositions  := TStringList.Create;
  FGetTabStopPositions := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomMemo.Destroy }

destructor TppCustomMemo.Destroy;
begin

  FLines.Free;
  FMemoStream.Free;
  FPrintLines.Free;
  FTabStopPositions.Free;
  FGetTabStopPositions.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomMemo.AllowsJustification }

function TppCustomMemo.AllowsJustification: Boolean;
begin
  {Should only be true for TppCustomMemo descendants}
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TppCustomMemo.Convert }

procedure TppCustomMemo.Convert(aVersionNo: Integer);
begin

  inherited Convert(aVersionNo);

  if (aVersionNo < 3000) then
    FLeading := ToMMThousandths(FLeading, utScreenPixels, pprtHorizontal);

end; {procedure, ConvertComponent}


{------------------------------------------------------------------------------}
{ TppCustomMemo.LinesChanged }

procedure TppCustomMemo.LinesChanged;
begin

  InvalidateDesignControl;

end; {procedure, LinesChanged}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetPrintLines }

function TppCustomMemo.GetPrintLines: TStrings;
begin

  Result := FPrintLines;

end; {function, GetPrintLines

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetTextBuf }

function TppCustomMemo.GetTextBuf: PChar;
begin

  GetMemoStream;

  if FMemoStream.Size = 0 then
    Result := nil

  else
    begin
      FMemoStream.Position := 0;

      Result := StrAlloc(FMemoStream.Size + 1);

      FMemoStream.Read(Result^, FMemoStream.Size);

      Result[FMemoStream.Size] := #0;
    end;

end; {function, GetTextBuf}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetLines }

function TppCustomMemo.GetLines: TStrings;
begin
  {enable descendants to get access to FLines }
  Result := FLines;
end; {function, GetLines}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetMemoStream }

function TppCustomMemo.GetMemoStream: TMemoryStream;
begin
  LoadMemo;
  Result := FMemoStream;
end; {function, GetMemoStream}

{------------------------------------------------------------------------------}
{ TppCustomMemo.UpdateMemoStream }

procedure TppCustomMemo.UpdateMemoStream;
begin

  {this routine allows descendants to load the memo stream without invoking
   the entire chain of LoadMemo routines}
   
  FMemoStream.Clear;

  ppStringsToStream(FLines, FMemoStream);

end; {procedure, UpdateMemoStream}

{------------------------------------------------------------------------------}
{ TppCustomMemo.LoadMemo }

procedure TppCustomMemo.LoadMemo;
begin

  {descendants can override this routine,
   call GetLines to access FLines, then call inherited to
   load FLines to FMemoStream}
  UpdateMemoStream;

  LinesChanged;

end; {function, LoadMemo}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetMemo }

function TppCustomMemo.GetMemo: TStrings;
begin
  LoadMemo;
  Result := FLines;
end; {function, GetMemo}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetText }

function TppCustomMemo.GetText: String;
begin
  Result := GetMemo.Text;

end; {function, GetText}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetText }

procedure TppCustomMemo.SetText(Value: String);
begin

  FLines.Text := Value;
  LoadMemo;

end; {function, SetText}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetMemo }

procedure TppCustomMemo.SetMemo(Value: TStrings);
begin

 FLines.Assign(Value);

 LoadMemo;

end; {procedure, SetMemo}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetSave }

procedure TppCustomMemo.SetSave(Value: Boolean);
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
    
end; {procedure, SetSave}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetSaveLength }

procedure TppCustomMemo.SetSaveLength(Value: Integer);
begin
  if FSaveLength <> Value then
    begin
      FSaveLength := Value;
      Reset;
    end;

end; {procedure, SetSaveLength}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetSaveOrder }

procedure TppCustomMemo.SetSaveOrder(Value: TTabOrder);
begin
  if csReading in ComponentState then
    FSaveOrder := Value
  else
    begin
      Band.MoveSave(Band.IndexOfSave(Self), Value);
      Reset;
    end;
end; {procedure, SetSaveOrder}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetTabStopPositions }

function TppCustomMemo.GetTabStopPositions: TStrings;
var
  lPrinter: TObject;
begin

  Result := FTabStopPositions;

  if (csLoading in ComponentState) then Exit;

  {note: when writing return FTabStopPositions, unless we have an ancestor who's
  tab stop position values are equivalent, then return FGetTabStopPositions
  to properly support form inheritance }
  if (csWriting in ComponentState) then
    if ((FAncestor = nil) or
          not FTabStopPositions.Equals(FAncestor.FTabStopPositions)) then Exit;


  FGetTabStopPositions.Assign(FTabStopPositions);

  if (Units = utPrinterPixels) and (Band <> nil) and (Band.Report <> nil) then
    lPrinter := Band.Report.Printer
  else
    lPrinter := nil;

  ppStringsFromMMThousandths(FGetTabStopPositions, Units, pprtHorizontal, lPrinter);

  Result := FGetTabStopPositions;

end; {procedure, GetTabStopPositions}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetTabStopPositions }

procedure TppCustomMemo.SetTabStopPositions(Value: TStrings);
var
  lPrinter: TObject;
begin
  BeforePropertyChange('TabStopPositions');

  FTabStopPositions.Assign(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;


  {set the value}
  if (Units = utPrinterPixels) and (Band <> nil) and (Band.Report <> nil) then
    lPrinter := Band.Report.Printer
  else
    lPrinter := nil;

  ppStringsToMMThousandths(FTabStopPositions, Units, pprtHorizontal, lPrinter);


  {repaint design control}
  InvalidateDesignControl;

  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetTabStopPositions}

{------------------------------------------------------------------------------}
{ TppCustomMemo.FontChanged }

procedure TppCustomMemo.FontChanged(Sender: TObject);
begin
  inherited FontChanged(Sender);

  {notify report engine}
  if Stretch then
    Reset;

end; {procedure, FontChanged}

{------------------------------------------------------------------------------}
{ TppCustomMemo.RestoreFromCache }

procedure TppCustomMemo.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppCustomMemoSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent     := lRec.FDrawComponent;
  DrawShifter       := lRec.FDrawShifter;
  KeptTogether      := lRec.FKeptTogether;
  ObjectIndex       := lRec.FObjectIndex;
  OverFlow          := lRec.FOverFlow;
  PartialGeneration := lRec.FPartialGeneration;

  FCharPos := lRec.FCharPos;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SaveToCache }

procedure TppCustomMemo.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppCustomMemoSaveRec;
begin

  lRec.FDrawComponent     := DrawComponent;
  lRec.FDrawShifter       := DrawShifter;
  lRec.FKeptTogether      := KeptTogether; 
  lRec.FObjectIndex       := ObjectIndex;
  lRec.FOverFlow          := OverFlow;
  lRec.FPartialGeneration := PartialGeneration;

  lRec.FCharPos := FCharPos;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppCustomMemo.Init }

procedure TppCustomMemo.Init;
begin

  inherited Init;

  FCharPos := 0;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppCustomMemo.PropertiesToDrawCommand }

procedure TppCustomMemo.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawText;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawText) then Exit;

  lDrawCommand := TppDrawText(aDrawCommand);

  {create print command}
  lDrawCommand.Alignment := Alignment;
  lDrawCommand.Color := Color;
  lDrawCommand.DataType := dtMemo;
  lDrawCommand.Left := PrintPosRect.Left;
  lDrawCommand.Top := PrintPosRect.Top;
  lDrawCommand.Height := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawCommand.Width := PrintPosRect.Right - PrintPosRect.Left;
  lDrawCommand.Font := Font;
  lDrawCommand.TextAlignment := TextAlignment;
  lDrawCommand.ForceJustifyLastLine := ForceJustifyLastLine;
  lDrawCommand.IsMemo := True;
  lDrawCommand.Leading := FLeading;
  lDrawCommand.Transparent := Transparent;
  lDrawCommand.WordWrap := True;
  lDrawCommand.TabStopPositions := FTabStopPositions;
  lDrawCommand.WrappedText := FPrintLines;
  lDrawCommand.Text := FPrintLines.Text;

  {assign print to file properties}

  lDrawCommand.BandSave := Band.Save;
  lDrawCommand.BandSaveNo := Band.Report.ReportBandCount;
  lDrawCommand.Component := Self;
  lDrawCommand.ComponentSave := Save;
  lDrawCommand.ComponentSaveNo := SaveOrder;
  lDrawCommand.SaveLength := SaveLength;

  if Band.Report is TppChildReport then
    lDrawCommand.ReportSaveNo := ((TppSubreport(Band.Report.Parent).Count + 1) + TppSubreport(Band.Report.Parent).ZOrder) *
                                   TppSubreport(Band.Report.Parent).Band.Report.ReportBandCount
  else
    lDrawCommand.ReportSaveNo := 0;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppCustomMemo.CalcSpaceUsed }

procedure TppCustomMemo.CalcSpaceUsed;
var
  llSpaceUsed: Longint;
  llSpaceAvailable: Longint;
  lsText: String;
  lPrinter: TppPrinter;
  llLineHeight: Longint;
  llTextLength: Longint;
  liSaveCharPos: Integer;
begin

  lPrinter := GetPrinter;

  if Stretch and ParentStretch then
    begin
      lsText := Lines.Text;
      llTextLength := Length(lsText);

      liSaveCharPos := FCharPos;

      TppPlainText.WordWrap(lsText, PrintPosRect, TextAlignment, False, Font, FCharWrap, FLeading, FTabStopPositions, lPrinter, FCharPos, FPrintLines);

      {calculate the currently available space}
      llSpaceAvailable := PrintPosRect.Bottom - PrintPosRect.Top;

      TppPlainText.MaxLinesFit(Font, FLeading, llSpaceAvailable, lPrinter, llLineHeight);

      llSpaceUsed := FPrintLines.Count * llLineHeight;

      if (FCharPos < llTextLength) and (FCharPos <> -1) then
        begin
          if (FPrintLines.Count = 0) then
            FCharPos := 0;

          OverFlow := True;
          SpaceUsed := llSpaceUsed;

          if ShouldKeepTogether then
            begin
              SpaceUsed := 0;
              KeptTogether := True;
              FCharPos := liSaveCharPos;
              FPrintLines.Clear;
            end;
        end
      else
        begin
          {memo is done printing, turn overflow off}
          OverFlow := False;

          if (FPrintLines.Count > 0) then
            SpaceUsed := llSpaceUsed;

          FCharPos := 0;

          if (KeptTogether) then
            KeptTogether := False;
        end; {if, need to calc startline, endline}

    end

  else {static memo }
    begin
      FCharPos := 0;

      TppPlainText.WordWrap(Lines.Text, PrintPosRect, TextAlignment, False, Font, FCharWrap, FLeading, FTabStopPositions, lPrinter, FCharPos, FPrintLines);

      SpaceUsed := mmHeight;
      OverFlow := False;
    end;

end; {function, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetLeading }

function TppCustomMemo.GetLeading: Single;
begin

  Result := FromMMThousandths(FLeading, Units, pprtVertical);

end; {function, GetLeading}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetLeading }

procedure TppCustomMemo.SetLeading(Value: Single);
begin

  {used for conversion to 3.0}
  if (csReading in ComponentState) then
    begin
      FLeading := Trunc(Value);
      Exit;
    end;

  BeforePropertyChange('Leading');
  
  FLeading := ToMMThousandths(Value, Units, pprtVertical);

  {repaint design control}
  InvalidateDesignControl;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetLeading}

{------------------------------------------------------------------------------}
{ TppCustomMemo.SetCharWrap }

procedure TppCustomMemo.SetCharWrap(Value: Boolean);
begin

  if (FCharWrap <> Value) then
    begin
      BeforePropertyChange('CharWrap');
      FCharWrap := Value;

      {repaint design control}
      InvalidateDesignControl;

      {notify report designer}
      PropertyChange;

      {notify report engine}
      Reset;
    end;

end; {procedure, SetCharWrap}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetSaveOrder }

function TppCustomMemo.GetSaveOrder: TTabOrder;
begin
  if Band <> nil then
    Result := Band.IndexOfSave(Self)
  else
    Result := -1;

end; {procedure, GetScreenPixelLeading}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetScreenPixelLeading }

function TppCustomMemo.GetScreenPixelLeading: Integer;
begin

  Result := Trunc(FromMMThousandths(FLeading, utScreenPixels, pprtHorizontal));

end; {procedure, GetScreenPixelLeading}

{------------------------------------------------------------------------------}
{ TppCustomMemo.DefineProperties - read/write private 'fake' properties }

procedure TppCustomMemo.WriteState(Writer: TWriter);
begin

  if (Writer.Ancestor is TppCustomMemo) then
    FAncestor := TppCustomMemo(Writer.Ancestor)
  else
    FAncestor := nil;

  inherited WriteState(Writer);

end; {procedure, WriteState}

{------------------------------------------------------------------------------}
{ TppCustomMemo.DefineProperties - read/write private 'fake' properties }

procedure TppCustomMemo.DefineProperties(Filer: TFiler);
begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppCustomMemo) then
    FAncestor := TppCustomMemo(Filer.Ancestor)
  else
    FAncestor := nil;

  if (FAncestor <> nil) then
    Filer.DefineProperty('mmLeading', ReadLeading, WriteLeading, FLeading <> FAncestor.FLeading)
  else
    Filer.DefineProperty('mmLeading', ReadLeading, WriteLeading, True);

   {used for conversion to 3.0}
  Filer.DefineProperty('Position', ReadPosition, nil, False);

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppCustomMemo.GetTheSaveOrder }

function TppCustomMemo.GetTheSaveOrder: TTabOrder;
begin
  Result := FSaveOrder;
end;

{------------------------------------------------------------------------------}
{ TppCustomMemo.ReadLeading }

procedure TppCustomMemo.ReadLeading(Reader: TReader);
begin
  FLeading := ppReadIntegerPropValue(Reader);
end; {procedure, ReadLeading}

{------------------------------------------------------------------------------}
{ TppCustomMemo.WriteLeading }

procedure TppCustomMemo.WriteLeading(Writer: TWriter);
begin
  Writer.WriteInteger(FLeading);

end; {procedure, WriteLeading}

{------------------------------------------------------------------------------}
{ TppCustomMemo.ReadPosition }

procedure TppCustomMemo.ReadPosition(Reader: TReader);
begin
  {eat the value}
  Reader.ReadInteger;
end; {procedure, ReadPosition}

{------------------------------------------------------------------------------}
{ TppCustomMemo.UpdateSaveOrder }

procedure TppCustomMemo.UpdateSaveOrder(Value: TTabOrder);
var
  liSaveIndex: Integer;
  liSaveCount: Integer;
begin

  {if save is not turned on, we're outta here}
  if not(FSave) then Exit;

  liSaveIndex := GetSaveOrder;
  liSaveCount := Band.SaveCount;

  {doctor value until it is valid}
  if Value < 0 then Value := 0;
  if (liSaveCount > 0) and (Value >= liSaveCount) then Value := liSaveCount - 1;

  if (Value <> liSaveIndex) then
    begin
      {remove from old position}
      if (liSaveIndex >= 0) then
        Band.RemoveSave(Self);

      {insert into new position}
      Band.InsertSave(Value, Self);
    end;

end; {procedure, UpdateSaveOrder}


{******************************************************************************
 *
 ** M E M O
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppMemo.Create }

constructor TppMemo.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  DefaultPropName     := 'Caption';
  DefaultPropEditType := etAutoEdit;

end;

{------------------------------------------------------------------------------}
{ TppMemo.SetMemo }

procedure TppMemo.SetMemo(Value: TStrings);

begin
  BeforePropertyChange('Lines');

  inherited SetMemo(Value);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetMemo}


{******************************************************************************
 *
 ** D B M E M O
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBMemo.Create }

constructor TppDBMemo.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  FAutoDisplay := True;
  FOnGetMemo := nil;

  FAlreadyPrinted := False;
  FPriorValue := '';
  FPriorValueSame := False;
  FSuppressRepeatedValues := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDBMemo.LoadMemo }

procedure TppDBMemo.LoadMemo;
var
  lLines: TStrings;
begin

  if not(FAutoDisplay) and not((Assigned(FOnGetMemo)) or (IsActiveNotify(ciMemoGetMemo))) then Exit;

  lLines := GetLines;
  lLines.Clear;

  {Assign field alias to caption if datapipeline is not nil.  Added 09/19/05}
  if (DataPipeline <> nil) then
    Caption := DataPipeline.FieldAliasForFieldName(DataField);

  if ((Assigned(FOnGetMemo)) or (IsActiveNotify(ciMemoGetMemo))) then
    DoOnGetMemo(Self, lLines)

  else if (CheckForPipelineData) then
    lLines.Text := DataPipeline.GetFieldAsString(DataField);

  inherited LoadMemo;

end; {procedure, LoadMemo}

{------------------------------------------------------------------------------}
{ TppDBMemo.DoOnGetMemo }

procedure TppDBMemo.DoOnGetMemo(Sender: TObject; aLines: TStrings);
var
  lParams: TraParamList;
begin

  if not Printing then Exit;

  if Assigned(FOnGetMemo) then
    FOnGetMemo(Sender, aLines);

  lParams := TraTppDBMemoRTTI.GetParams('OnGetMemo');
  lParams.CreateValuePointer(0, aLines);

  SendEventNotify(Self, ciMemoGetMemo, lParams);

  lParams.Free;

end; {procedure, DoOnGetMemo}

{------------------------------------------------------------------------------}
{ TppDBMemo.Notify }

procedure TppDBMemo.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (csDestroying in ComponentState) then Exit;

  if (aOperation in [ppopDataChange, ppopRemove]) and (pppcDesigning in DesignState) and not(Printing) then
    LoadMemo;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDBMemo.IsDataAware }

function TppDBMemo.IsDataAware: Boolean;
begin
  Result := True;
end; {function, IsDataAware}

{------------------------------------------------------------------------------}
{ TppDBMemo.SetDataField }

procedure TppDBMemo.SetDataField(const Value: string);
begin

  inherited SetDataField(Value);

  {display the text}
  LoadMemo;

  PropertyChange;

end; {procedure, SetDataField}

{------------------------------------------------------------------------------}
{ TppDBMemo.SetSuppressRepeatedValues }

procedure TppDBMemo.SetSuppressRepeatedValues(Value: Boolean);
begin

  if (FSuppressRepeatedValues <> Value) then
    begin
      FSuppressRepeatedValues := Value;

      Reset;

      PropertyChange;

      if (FSuppressRepeatedValues) then
        EventNotifies := EventNotifies + [ciTraversal]
      else
        EventNotifies := EventNotifies - [ciTraversal];
    end;

end; {procedure, SetSuppressRepeatedValues}

{------------------------------------------------------------------------------}
{ TppDBMemo.IsCalc }

function TppDBMemo.IsCalc: Boolean;
begin
  Result := FSuppressRepeatedValues;
end; {function, IsCalc}

{------------------------------------------------------------------------------}
{ TppDBMemo.Init }

procedure TppDBMemo.Init;
begin

  inherited Init;

  FAlreadyPrinted := False;
  FPriorValue := '';
  FPriorValueSame := False;

  if (FSuppressRepeatedValues) then
    Band.Report.Engine.AddEventNotify(Self);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppDBMemo.Clear }

procedure TppDBMemo.Clear;
begin

  inherited Clear;

  FAlreadyPrinted := False;
  FPriorValue := '';
  FPriorValueSame := False;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppDBMemo.Compute }

procedure TppDBMemo.Compute;
begin

  UpdateValues;

  ResetOnCompute := False;

end; {procedure, Compute}

{------------------------------------------------------------------------------}
{ TppDBMemo.UpdateValues }

procedure TppDBMemo.UpdateValues;
var
  lsValue: String;
begin

  lsValue := Text;

  if ResetOnCompute or (FPriorValue <> lsValue) then
    begin
      FPriorValue := lsValue;
      FPriorValueSame := False;
    end
  else
    FPriorValueSame := True;

end; {procedure, UpdateValues}

{------------------------------------------------------------------------------}
{ TppDBMemo.CalcSpaceUsed }

procedure TppDBMemo.CalcSpaceUsed;
var
  lbPrintIt: Boolean;
begin

  if not(FSuppressRepeatedValues) then
    inherited CalcSpaceUsed

  else
    begin
      lbPrintIt := False;

      if not(FPriorValueSame) or ((DataPipeline <> nil) and
                                  (ppdaFirstRecord in DataPipeline.State) and not(FAlreadyPrinted)) then

        begin
          FAlreadyPrinted := False;

          lbPrintIt := True;
        end

      else

        begin

          if (FSuppressRepeatedValues) then
            begin

            end

          else if (DrawComponent) then
            lbPrintIt := True;

        end;

      if lbPrintIt then
        FAlreadyPrinted := True
      else
        begin
          SpaceUsed := 0;

          DrawComponent := False;
        end;

      {must update values here, because DBMemo may print more
      several times before compute is called again}
      UpdateValues;

      if (lbPrintIt) then
        inherited CalcSpaceUsed;
    end;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppDBMemo.EventNotify }

procedure TppDBMemo.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aCommunicator = ResetGroup) and (aEventID = ciGroupAfterGroupBreak) then
    Clear()

  else if (aCommunicator = Band.Report.Engine) and (aEventID = ciTraversal) then
    Compute();

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppDBMemo.RestoreFromCache }

procedure TppDBMemo.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppDBMemoSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent := lRec.FDrawComponent;
  DrawShifter := lRec.FDrawShifter;
  KeptTogether := lRec.FKeptTogether;
  ObjectIndex := lRec.FObjectIndex;
  OverFlow := lRec.FOverFlow;
  PartialGeneration := lRec.FPartialGeneration;
  ResetOnCompute := lRec.FResetOnCompute;

  FAlreadyPrinted := lRec.FAlreadyPrinted;
  FCharPos := lRec.FCharPos;
  FPriorValueSame := lRec.FPriorValueSame;

  FPriorValue := Text;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppDBMemo.SaveToCache }

procedure TppDBMemo.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppDBMemoSaveRec;
begin

  lRec.FDrawComponent := DrawComponent;
  lRec.FDrawShifter := DrawShifter;
  lRec.FKeptTogether := KeptTogether;
  lRec.FObjectIndex := ObjectIndex;
  lRec.FOverFlow := OverFlow;
  lRec.FPartialGeneration := PartialGeneration;
  lRec.FResetOnCompute := ResetOnCompute;

  lRec.FAlreadyPrinted  := FAlreadyPrinted;
  lRec.FCharPos := FCharPos;
  lRec.FPriorValueSame  := FPriorValueSame;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

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
 ** C U S T O M   M E M O   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomMemoRTTI.RefClass }

class function TraTppCustomMemoRTTI.RefClass: TClass;
begin
  Result := TppCustomMemo;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomMemoRTTI.GetPropList }

class procedure TraTppCustomMemoRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Text');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomMemoRTTI.GetPropRec }

class function TraTppCustomMemoRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CharWrap') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Color') = 0) then
    EnumPropToRec(aPropName, 'TColor', False, aPropRec)

  else if (CompareText(aPropName, 'Leading') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'Lines') = 0) then
    ClassPropToRec(aPropName, TStrings, False, aPropRec)

  else if (CompareText(aPropName, 'MemoStream') = 0) then
    ClassPropToRec(aPropName, TMemoryStream, True, aPropRec)

  else if (CompareText(aPropName, 'mmLeading') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'PrintLines') = 0) then
    ClassPropToRec(aPropName, TStrings, True, aPropRec)

  else if (CompareText(aPropName, 'spLeading') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'TabStopPositions') = 0) then
    ClassPropToRec(aPropName, TStrings, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomMemoRTTI.GetPropValue }

class function TraTppCustomMemoRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CharWrap') = 0) then
    Boolean(aValue) := TppCustomMemo(aObject).CharWrap

  else if (CompareText(aPropName, 'Color') = 0) then
    Integer(aValue) := Ord(TppCustomMemo(aObject).Color)

  else if (CompareText(aPropName, 'Leading') = 0) then
    Single(aValue) := TppCustomMemo(aObject).Leading

  else if (CompareText(aPropName, 'Lines') = 0) then
    Integer(aValue) := Integer(TppCustomMemo(aObject).Lines)

  else if (CompareText(aPropName, 'MemoStream') = 0) then
    Integer(aValue) := Integer(TppCustomMemo(aObject).MemoStream)

  else if (CompareText(aPropName, 'mmLeading') = 0) then
    Integer(aValue) := TppCustomMemo(aObject).mmLeading

  else if (CompareText(aPropName, 'PrintLines') = 0) then
    Integer(aValue) := Integer(TppCustomMemo(aObject).PrintLines)

  else if (CompareText(aPropName, 'spLeading') = 0) then
    Integer(aValue) := TppCustomMemo(aObject).spLeading

  else if (CompareText(aPropName, 'TabStopPositions') = 0) then
     Integer(aValue) := Integer(TppCustomMemo(aObject).TabStopPositions)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCustomMemoRTTI.SetPropValue }

class function TraTppCustomMemoRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CharWrap') = 0) then
    TppCustomMemo(aObject).CharWrap := Boolean(aValue)

  else if (CompareText(aPropName, 'Color') = 0) then
    TppCustomMemo(aObject).Color := TColor(aValue)

  else if (CompareText(aPropName, 'Leading') = 0) then
    TppCustomMemo(aObject).Leading := Single(aValue)

  else if (CompareText(aPropName, 'Lines') = 0) then
    TppCustomMemo(aObject).Lines := TStrings(aValue)

  else if (CompareText(aPropName, 'TabStopPositions') = 0) then
    TppCustomMemo(aObject).TabStopPositions := TStrings(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{******************************************************************************
 *
 ** D B   M E M O   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDBMemoRTTI.RefClass }

class function TraTppDBMemoRTTI.RefClass: TClass;
begin
  Result := TppDBMemo;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDBMemoRTTI.GetParams }

class function TraTppDBMemoRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'OnGetMemo') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Lines', daClass, TStrings, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppDBMemoRTTI.GetPropList }

class procedure TraTppDBMemoRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDBMemoRTTI.GetPropRec }

class function TraTppDBMemoRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'OnGetMemo') = 0) then
    EventToRec(aPropName, ciMemoGetMemo, True, aPropRec)

  else if CompareText(aPropName, 'AutoDisplay') = 0 then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDBMemoRTTI.GetPropValue }

class function TraTppDBMemoRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'AutoDisplay') = 0 then
    Boolean(aValue) := TppDBMemo(aObject).AutoDisplay

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDBMemoRTTI.SetPropValue }

class function TraTppDBMemoRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'AutoDisplay') = 0 then
    TppDBMemo(aObject).AutoDisplay := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  raRegisterRTTI(TraTppCustomMemoRTTI);
  raRegisterRTTI(TraTppDBMemoRTTI);

finalization

  raUnRegisterRTTI(TraTppCustomMemoRTTI);
  raUnRegisterRTTI(TraTppDBMemoRTTI);

end.
