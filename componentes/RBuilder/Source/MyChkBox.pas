{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit myChkBox;

interface

uses
  Windows,
  Classes,  {contains TComponent class}
  Forms,    {contains the global Screen object, used to size the component initially}
  SysUtils, {contains LoadStr, also used in the CreatePopupMenu procedure}
  Controls, {contains declaration of mrOK, used for the CheckBox Settings dialog}
  Graphics,

  ppCtrls,  {contains declaration of TppCustomComponent, from which the CheckBox component descends}
  ppDevice,     {contains declaration of TppDrawCommand, used in PropertiesToDrawCommand}
  ppClass,  {contains ppRegisterComponent which registers the component with the
                          ReportBuilder Report Designer}
  ppDB,     {contains declaration of TppDataPipeline, used for the data-aware CheckBox}
  ppDrwCmd, {contains declaration of TppDrawText, used in PropertiesToDrawCommand}
  ppTypes,  {contains declaration of ReportBuilder enumerated types}
  ppPrnabl, {contains TppPrintable, CustomComponent ancestor}
  ppRTTI,
  ppEnum;

{define Wingdings ASCII codes used to represent check marks}
const
  cEmptyBox       = #168;
  cCheckMarkInBox = #254;
  cCheckMark      = #252;
  cXMark          = #251;
  cXInBox         = #253;

type

  {enumerated type which describes different check box styles}
  TmyCheckStyleType = (csCheckInBox, csXInBox, csCheckMark, csXMark);

  { TmyCustomCheckBox contains most of the functionality needed for this component.
    It is common to code a 'custom' ancestor, which enscapsulates the implementation
    for a certain type of component. You can then create descendants of this
    custom class and avoid unnecessary redundancy.  In this case, TmyCustomCheckBox
    has been created as the ancestor for TmyCheckBox and TmyDBCheckBox.

    TmyCheckBox publishes the Checked property and defines the CheckStyle property
    as the default (which tells the Report Designer to display a drop-down combo box
    in the Edit toolbar and assign the CheckStyle property based on user selections from
    this combo box.)  The choices for this combo-box are supplied in the
    GetDefaultPropEnumNames procedure of TmyCheckBox.

    TmyDBCheckBox publishes DataField and DataPipeline, and overrides the IsDataAware
    function to return True.  The Report Designer automatically displays a drop-down
    combo box of field names for data-aware controls.  TmyDBCheckBox implements a
    speedmenu option called Settings... which gives the user access to a dialog
    where they can set the CheckStyle, BooleanTrue and BooleanFalse properties.}

  { TmyCustomCheckBox }
  TmyCustomCheckBox = class(TppCustomComponent)
    private
      FChecked: Boolean;
      FStyle: TmyCheckStyleType;

      procedure SetChecked(Value: Boolean);
      procedure SetStyle(aStyle: TmyCheckStyleType);
      procedure SetCheckBoxColor(aColor: TColor);

      function GetCheckBoxColor: TColor;

    protected
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

      function  GetChecked: Boolean; virtual;
      
      property Checked: Boolean read GetChecked write SetChecked default True;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  HasFont: Boolean; override;
      function  GetCheckCharacter: Char;
      procedure GetForegroundColor(var aColor: TColor; var aIsClear: Boolean); override;
      procedure SetForegroundColor(aColor: TColor; aIsClear: Boolean); override;

      property CheckBoxColor: TColor read GetCheckBoxColor write SetCheckBoxColor;
      property Style: TmyCheckStyleType read FStyle write SetStyle default csCheckInBox;

  end; {class, TmyCustomCheckBox}

  
  { TmyCheckBox }
  TmyCheckBox = class(TmyCustomCheckBox)
    private

    protected
      function  GetDefaultPropHint: String; override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure GetDefaultPropEnumNames(aList: TStrings); override;

    published
      {inherited from TmyCustomCheckBox}
      property Checked;
      property Style;

      {inherited from TmyPrintable}
      property Anchors;
      property Color;
      property CheckBoxColor;
      property Height;
      property Left;
      property ReprintOnOverFlow;
      property Top;
      property Transparent;
      property Visible;
      property Width;

      {events - inherited from TmyPrintable}
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property OnPrint;

  end; {class, TmyCheckBox}


  { TmyDBCheckBox }
  TmyDBCheckBox = class(TmyCustomCheckBox)
    private
      FBooleanFalse: String;
      FBooleanTrue: String;

      procedure SetBooleanFalse(const Value: String);
      procedure SetBooleanTrue(const Value: String);

    protected
      function  GetChecked: Boolean; override;

    public
      constructor Create(aOwner: TComponent); override;

      function  IsDataAware: Boolean; override;

      property Checked;

    published
      {inherited from TmyCustomCheckBox}
      property Color;
      property CheckBoxColor;
      property BooleanFalse: String read FBooleanFalse write SetBooleanFalse;
      property BooleanTrue: String read FBooleanTrue write SetBooleanTrue;
      property Style;

      {inherited from TmyPrintable}
      property Anchors;
      property DataPipeline;
      property DataField;
      property Height;
      property Left;
      property ReprintOnOverFlow;
      property Top;
      property Transparent;
      property Visible;
      property Width;

      {events - inherited from TmyPrintable}
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property OnPrint;

  end; {class, TmyDBCheckBox}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  { TraTmyCustomCheckBoxRTTI }
  TraTmyCustomCheckBoxRTTI = class(TraTppComponentRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTmyCustomCheckBoxRTTI}

  { TraTmyCheckBoxRTTI }
  TraTmyCheckBoxRTTI = class(TraTmyCustomCheckBoxRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTmyCheckBoxRTTI}


implementation


{include resource file containing bitmap used to represent component in the Report Designer}
{$R myChkBox.res}


{******************************************************************************
 *
 ** C U S T O M   C H E C K   B O X
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.Create }

constructor TmyCustomCheckBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  {indicate that a DrawText drawcommand should be created when the component needs to print}
  DrawCommandClass := TppDrawText;

  FChecked := True;
  FStyle := csCheckInBox;

  {default size to quarter inch by quarter inch}
  spHeight := Round(0.25 * Screen.PixelsPerInch);
  spWidth := Round(0.25 * Screen.PixelsPerInch);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.Destroy }

destructor TmyCustomCheckBox.Destroy;
begin

  {not currently used for anything, but the minute you take it out
   you'll discover some object you need to free}

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.GetChecked }

function TmyCustomCheckBox.GetChecked: Boolean;
begin
  Result := FChecked;
  
end; {function, GetChecked}

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.HasFont }

function TmyCustomCheckBox.HasFont: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.SetStyle }

procedure TmyCustomCheckBox.SetStyle(aStyle: TmyCheckStyleType);
begin

  if (FStyle = aStyle) then Exit;

  BeforePropertyChange('Style');  // setup Undo support
  FStyle := aStyle;

  {notify report designer}
  PropertyChange;             // finalize undo and notify designer

  {redraw design control}
  InvalidateDesignControl;

end; {procedure, SetStyle}

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.SetCheckBoxColor }

procedure TmyCustomCheckBox.SetCheckBoxColor(aColor: TColor);
begin

  if (aColor = Font.Color) then Exit;


  BeforePropertyChange('CheckBoxColor');  // setup Undo support

  Font.Color := aColor;
  
  PropertyChange;  // complete Undo and notify designer


end;

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.GetCheckBoxColor }

function TmyCustomCheckBox.GetCheckBoxColor: TColor;
begin
  Result := Font.Color;
end;

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.SetChecked }

procedure TmyCustomCheckBox.SetChecked(Value: Boolean);
begin

  if (Value = FChecked) then Exit;
  
  BeforePropertyChange('Checked');  // setup Undo support

  FChecked := Value;

  {notify report designer}
  PropertyChange;                 // complete Undo and notify designer


  {notify report engine}
  Reset;

  {redraw design control}
  InvalidateDesignControl;
end;

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.SetForegroundColor
  - this method is used by the design tools }

procedure TmyCustomCheckBox.SetForegroundColor(aColor: TColor; aIsClear: Boolean);
begin

  SetCheckBoxColor(aColor);  //simple pass thru

end;


{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.GetCheckCharacter }

function TmyCustomCheckBox.GetCheckCharacter: Char;
begin

  {return the Wingdingss character which will represent the check box}
  Result := #32;

  if GetChecked then
    begin
      case FStyle of
        csCheckMark:   Result := cCheckMark;
        csCheckInBox:  Result := cCheckMarkInBox;
        csXMark:       Result := cXMark;
        csXInBox:      Result := cXInBox;
      end; {case}
    end
  else
    begin
      if (FStyle in [csCheckInBox, csXInBox]) then
        Result := cEmptyBox;
    end;
end; {function, GetCheckCharacter}

{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.GetForegroundColor
  - used by the design tools}

procedure TmyCustomCheckBox.GetForegroundColor(var aColor: TColor; var aIsClear: Boolean);
begin

  aColor   := GetCheckBoxColor;
  aIsClear := False;

end;


{------------------------------------------------------------------------------}
{ TmyCustomCheckBox.PropertiesToDrawCommand }

procedure TmyCustomCheckBox.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawText: TppDrawText;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  {make sure the drawcommand is of the appropriate class}
  if not(aDrawCommand is TppDrawText) then Exit;

  lDrawText := TppDrawText(aDrawCommand);

  {set the position of the text on the page}
  lDrawText.Left    := PrintPosRect.Left;
  lDrawText.Top     := PrintPosRect.Top;
  lDrawText.Height  := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawText.Width   := PrintPosRect.Right - PrintPosRect.Left;

  {set the drawtext properties so the visual represention of the check box will
   be correct when the command is rendered by the receiving Device (ScreenDevice
   for Print Preview form, PrinterDevice when printing to printer, etc.)}
  lDrawText.Alignment    := taLeftJustify;
  lDrawText.AutoSize     := True;
  lDrawText.Color        := Color;
  lDrawText.Font.Color   := Font.Color;
  lDrawText.Font.CharSet := SYMBOL_CHARSET;
  lDrawText.Font.Name    := 'Wingdings';
  lDrawText.Font.Height  := spHeight;
  lDrawText.Text         := String(GetCheckCharacter);

  lDrawText.Transparent  := Transparent;
  lDrawText.WordWrap     := False;

end; 

{******************************************************************************
 *
 ** C H E C K   B O X
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyCheckBox.Create }

constructor TmyCheckBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  {define default property, which tells the Report Designer to use a drop-down
   list}
  DefaultPropName     := 'Style';
  DefaultPropEditType := etValueList;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TmyCheckBox.GetDefaultPropHint }

function TmyCheckBox.GetDefaultPropHint: String;
begin
  {hint displayed when user gets hint for Edit toolbar combo-box}
  Result := 'Checkbox Styles';
end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TmyCheckBox.GetDefaultPropEnumNames }

procedure TmyCheckBox.GetDefaultPropEnumNames(aList: TStrings);
begin

  {options displayed when user clicks on Edit toolbar combo-box}
  aList.Clear;

  aList.Add('Checkmark and Box');
  aList.Add('X and Box');
  aList.Add('Checkmark only');
  aList.Add('X only');

end; {procedure, GetDefaultPropEnumNames}

{******************************************************************************
 *
 ** D B   C H E C K   B O X
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyDBCheckBox.Create }

constructor TmyDBCheckBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FBooleanTrue := 'True';
  FBooleanFalse := 'False';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TmyDBCheckBox.IsDataAware }

function TmyDBCheckBox.IsDataAware: Boolean;
begin
  {Report Designer will display list of datafields in Edit toolbar}
  Result := True;
end; {function, IsDataAware}


{------------------------------------------------------------------------------}
{ TmyDBCheckBox.SetBooleanFalse }

procedure TmyDBCheckBox.SetBooleanFalse(const Value: String);
begin
  if (Printing) then Exit;

  FBooleanFalse := Value;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

  {redraw design control}
  InvalidateDesignControl;

end; {procedure, SetBooleanFalse}

{------------------------------------------------------------------------------}
{ TmyDBCheckBox.SetBooleanTrue }

procedure TmyDBCheckBox.SetBooleanTrue(const Value: String);
begin
  if (Printing) then Exit;

  FBooleanTrue := Value;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

  {redraw design control}
  InvalidateDesignControl;

end; {procedure, SetBooleanTrue}  {returns whether check box should be checked or not}

{------------------------------------------------------------------------------}
{ TmyDBCheckBox.GetChecked }

function TmyDBCheckBox.GetChecked: Boolean;
begin

  Result := False;

  try

    if (DataPipeline <> nil) then
      begin

        if (FBooleanTrue <> '') then
          Result := (DataPipeline.GetFieldAsString(DataField) = FBooleanTrue)

        else if (FBooleanFalse <> '') then
          Result := (DataPipeline.GetFieldAsString(DataField) <> FBooleanFalse)

        else
          Result := (DataPipeline.GetFieldAsString(DataField) <> '');

      end;

  except on EDataError do
    Result := False;
  end;

end; {function, GetChecked}


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
 ** C U S T O M   C H E C K B O X   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTmyCustomCheckBoxRTTI.RefClass }

class function TraTmyCustomCheckBoxRTTI.RefClass: TClass;
begin
  Result := TmyCustomCheckBox;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTmyCustomCheckBoxRTTI.GetPropList }

class procedure TraTmyCustomCheckBoxRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTmyCustomCheckBoxRTTI.GetPropRec }

class function TraTmyCustomCheckBoxRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Style') = 0) then
    EnumPropToRec(aPropName, 'TmyCheckStyleType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTmyCustomCheckBoxRTTI.GetPropValue }

class function TraTmyCustomCheckBoxRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Style') = 0) then
    TmyCheckStyleType(aValue) := TmyCustomCheckBox(aObject).Style

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTmyCustomCheckBoxRTTI.SetPropValue }

class function TraTmyCustomCheckBoxRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Style') = 0) then
    TmyCustomCheckBox(aObject).Style := TmyCheckStyleType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {function, SetPropValue}

{******************************************************************************
 *
 ** C H E C K B O X   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTmyCheckBoxRTTI.Ref}

class function TraTmyCheckBoxRTTI.RefClass: TClass;
begin
  Result := TmyCheckBox;
end; {function, RefClass}

{------------------------------------------------------------------------------}
{ TraTmyCheckBoxRTTI.GetPropList }

class procedure TraTmyCheckBoxRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTmyCheckBoxRTTI.GetPropRec }

class function TraTmyCheckBoxRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Checked') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTmyCheckBoxRTTI.GetPropValue }

class function TraTmyCheckBoxRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Checked') = 0) then
    Boolean(aValue) := TmyCheckBox(aObject).Checked

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTmyCheckBoxRTTI.SetPropValue }

class function TraTmyCheckBoxRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Checked') = 0) then
    TmyCheckBox(aObject).Checked := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {function, SetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  {register the component, the parameters are:

     Component Class Name,   class name of component
     Toolbar Name,           name of Toolbar on which component should appear
     Position,               position of component on toolbar
     HintIndex,              (used by the built-in ReportBuilder components) Loads the Language string
                             of the specified index as the hint
     Hint,                   Hint text which appears when mouse is positioned over component on Toolbar
     HInstance,              not used for Delphi .Net}


  RegisterClass(TmyCheckBox);
  RegisterClass(TmyDBCheckBox);

  raRegisterEnum('TmyCheckStyleType', TypeInfo(TmyCheckStyleType));

  raRegisterRTTI(TraTmyCustomCheckBoxRTTI);
  raRegisterRTTI(TraTmyCheckBoxRTTI);

  ppRegisterComponent(TmyCheckBox, 'Standard Components', 10, 0, 'CheckBox', 0);
  ppRegisterComponent(TmyDBCheckBox, 'Data Components', 10, 0, 'DBCheckBox', 0);

 
finalization

  ppUnRegisterComponent(TmyDBCheckBox);
  ppUnRegisterComponent(TmyCheckBox);

  raUnRegisterRTTI(TraTmyCheckBoxRTTI);
  raUnRegisterRTTI(TraTmyCustomCheckBoxRTTI);

  raUnRegisterEnum('TmyCheckStyleType');

  UnRegisterClass(TmyDBCheckBox);
  UnRegisterClass(TmyCheckBox);

end.
