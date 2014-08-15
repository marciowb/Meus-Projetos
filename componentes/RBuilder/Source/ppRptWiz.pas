{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppRptWiz;
        
interface

{$I ppIfDef.pas}
     
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Printers, Buttons, TypInfo,
  ppTypes, ppUtils, ppComm, ppClass, ppReport, ppBands, ppCtrls, ppStrtch, ppDB,
  ppMemo, ppClasUt, ppWizard, ppRWzDlg, ppVar, ppMetaBitmap, ppMetaRW;

type

  {forward declarations}
  TppReportLayout = class;
  TppReportStyle = class;

  {enumerated types}
  TppReportStyleType = (rsBold, rsCasual, rsCompact, rsCorporate, rsFormal, rsSoftGray);

  TppReportLayoutType = (rlVertical, rlTabular, rlStepped, rlBlock, rlOutline1,
                         rlOutline2, rlAlignLeft1, rlAlignLeft2);

  TppLayoutLineType = (llNone, llRail, llDoubleRail, llTop, llBottom, llFrame, llFrameComponents);

  {@TppBlankReportWizard }
  TppBlankReportWizard = class(TppCustomReportWizard)
    private
      FReport: TppCustomReport;

    protected
      function  GetReport: TObject; override;
      function  GetReportName: String; override;

    public
      constructor Create(aOwner: TComponent); override;

      function Execute: Boolean; override;

      class function ClassDescription: String; override;
      class function ClassBitmap: THandle; override;
      class function DisplaysDialog: Boolean; override;
      
  end; {class, TppBlankReportWizard}

  {@TppReportWizard }
  TppReportWizard = class(TppCustomReportWizard)
    private
      FAdjustFieldWidth: Boolean;
      FForm: TppReportWizardDialog;
      FFields: TStringList;
      FGroupFields: TStringList;
      FLayout: TppReportLayoutType;
      FDataNames: TStrings;
      FOrientation: TPrinterOrientation;
      FReport: TppCustomReport;
      FReportName: String;
      FReportLayout: TppReportLayout;
      FReportStyle: TppReportStyle;
      FSelectedFields: TStringList;
      FStyle: TppReportStyleType;

      function  AddField(aField: TppField): Integer;
      function  AddGroup(aField: TppField): Integer;
      procedure CloseQueryEvent(Sender: TObject; var CanClose: Boolean);
      function  GetField(Index: Integer): TppField;
      function  GetFieldCount: Integer;
      function  GetGroup(Index: Integer): TppField;
      function  GetGroupCount: Integer;
      function  RemoveGroup(aField: TppField): Integer;
      function  RemoveField(aField: TppField): Integer;
      procedure SetLayout(aLayout: TppReportLayoutType);
      procedure SetOrientation(aOrientation: TPrinterOrientation);
      procedure SetStyle(aStyle: TppReportStyleType);

    protected
      function  GetReport: TObject; override;
      function  GetReportName: String; override;

      {report creation routines}
      procedure AdjustFieldWidths(FieldList: TStringList; TotalWidth: Integer; aBand: TppBand);
      procedure CreateBands;
      function  CreateLayout(aLayoutType: TppReportLayoutType): TppReportLayout;
      function  CreateStyle(aStyleType: TppReportStyleType): TppReportStyle;
      function  CreateComponent(const aClassName: String; aOwner: TComponent): TComponent;
      procedure CreateDataControls;
      procedure CreateFooter;
      procedure CreateGroups;
      function  CreateLabel(aBand: TppBand; const aCaption: String): TppLabel;
      procedure CreateTitle;
      procedure GetFields(aSelectedFields: TStringList; aGroupFields: TStringList;
                          var aTotalWidth, aMaxFieldWidth, aMaxLabelWidth: Integer; var aFieldsOver: Boolean);
      procedure PositionControls;
      procedure PositionControlsHorizontal(FieldList: TStringList; MaxFieldWidth: Integer;
                                           DetailBand: TppBand; HeaderBand: TppBand;
                                           TotalIndent: Integer; FieldsOver: Boolean);
      procedure PositionControlsVertical(FieldList: TStringList; MaxLabelWidth: Integer;
                                         DetailBand: TppBand; HeaderBand: TppBand);
      procedure PositionGroupControls(GroupMapList: TStringList; Indent: Integer; var TotalIndent: Integer);
      procedure SetComponentSize(aComponent: TppComponent);
      procedure SetDataName(aDataName: String); override;
      procedure WizardToReport;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;
      class function ClassBitmap: THandle; override;

      function Execute: Boolean; override;

      {user interface routines}
      procedure AddAllFieldsToSelection;
      procedure AddFieldToSelection;
      procedure AddGroupToSelection;
      procedure AdvancePage(aIncrement: Integer);
      procedure ChangeFieldPosition(aIncrement: Integer);
      procedure ChangeGroupPosition(aIncrement: Integer);
      procedure DrawGroupImage;
      procedure InitControls;
      procedure MoveSelectedFields(aSource, aTarget: TListBox; aAllFields: Boolean);
      procedure MoveSelectedGroups(aSource, aTarget: TListBox; aAllFields: Boolean);
      procedure RemoveAllFieldsFromSelection;
      procedure RemoveFieldFromSelection;
      procedure RemoveGroupFromSelection;
      procedure SelectDataName;
      procedure SetFieldSelectButtons;
      procedure SetGroupSelectButtons;
      procedure SetPagingButtons;
      procedure UpdateGroups;

      property AdjustFieldWidth: Boolean read FAdjustFieldWidth write FAdjustFieldWidth;
      property DataNames: TStrings read FDataNames;
      property Fields[Index: Integer]: TppField read GetField;
      property FieldCount: Integer read GetFieldCount;
      property Groups[Index: Integer]: TppField read GetGroup;
      property GroupCount: Integer read GetGroupCount;
      property Layout: TppReportLayoutType read FLayout write SetLayout;
      property Orientation: TPrinterOrientation read FOrientation write SetOrientation;
      property ReportName: String read FReportName write FReportName;
      property Style: TppReportStyleType read FStyle write SetStyle;

  end; {class, TppReportWizard}

  {******************************************************************************
   *
   ** S T Y L E   C L A S S E S
   *
  {******************************************************************************}

  {@TppBandStyle }
  TppBandStyle = class(TComponent)
    private
       FColor: TColor;
      FFont: TFont;
      FLine: Boolean;
      FLinePenColor: TColor;
      FLinePenWidth: Integer;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      property Color: TColor read FColor write FColor;
      property Font: TFont read FFont write FFont;
      property Line: Boolean read FLine write FLine;
      property LinePenColor: TColor read FLinePenColor write FLinePenColor;
      property LinePenWidth: Integer read FLinePenWidth write FLinePenWidth;
  end; {class, TppBandStyle}

  {@TppReportStyle }
  TppReportStyle = class(TComponent)
    private
      FBandClassList: TList;
      FBandStyleList: TList;
      FReport: TppCustomReport;

      procedure AddBandStyle(aBand: TppBand; aBandStyle: TppBandStyle);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Apply(aReport: TppCustomReport);
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); virtual;
      function  StyleForBand(aBand: TppBand): TppBandStyle;

  end; {class, TppReportStyle}

  TppBoldStyle = class(TppReportStyle)
    public
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); override;
  end;

  TppCasualStyle = class(TppReportStyle)
    public
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); override;
 end;

  TppCompactStyle = class(TppReportStyle)
    public
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); override;
  end;

  TppCorporateStyle = class(TppReportStyle)
    public
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); override;
  end;

  TppFormalStyle = class(TppReportStyle)
    public
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); override;
  end;

  TppSoftGrayStyle = class(TppReportStyle)
    public
      procedure SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand); override;
  end;

  {******************************************************************************
   *
   ** L A Y O U T   C L A S S E S
   *
  {******************************************************************************}

  {@TppBandLayout }
  TppBandLayout = class(TComponent)
    private
      FLineStyle: TppLayoutLineType;
      FIndentOffset: Integer;

    public
      property LineStyle: TppLayoutLineType read FLineStyle write FLineStyle;
      property IndentOffset: Integer read FIndentOffset write FIndentOffset;

  end; {class, TppBandLayout}

  {@TppReportLayout }
  TppReportLayout = class(TComponent)
    private
      FBandList: TList;
      FBandLayoutList: TList;
      FGroupHeaders: Boolean;
      FColumnHeaderTopOffset: Integer;
      FColumnHeaderBand: TppBand;
      FIndent: Boolean;
      FReport: TppCustomReport;

      procedure AddBandLayout(aBand: TppBand; aBandLayout: TppBandLayout);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Apply(aReport: TppCustomReport);
      procedure FrameComponents(aBand: TppBand);
      function  LayoutForBand(aBand: TppBand): TppBandLayout;
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); virtual;

      property GroupHeaders: Boolean read FGroupHeaders write FGroupHeaders default True;
      property ColumnHeaderBand: TppBand read FColumnHeaderBand write FColumnHeaderBand;
      property ColumnHeaderTopOffset: Integer read FColumnHeaderTopOffset write FColumnHeaderTopOffset;
      property Indent: Boolean read FIndent write FIndent default True;

  end; {class, TppReportLayout}

  TppTabularLayout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppVerticalLayout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppSteppedLayout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppBlockLayout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppOutline1Layout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppOutline2Layout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppAlignLeft1Layout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppAlignLeft2Layout = class(TppReportLayout)
    public
      procedure SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand); override;
  end;

  TppLayoutFactoryClass = class of TppLayoutFactory;

  {@TppLayoutFactory }
  TppLayoutFactory = class
    private
      class function ContainsRTFData(aField: TppField): Boolean;
    public

    {general purpose routine}
    class function CreateComponentForField(aReport: TppCustomReport; aBand: TppBand; aField: TppField; aFont: TFont): TppComponent;  virtual;
    class function CreateFrameForComponent(aReport: TppCustomReport; aComponent: TppComponent): TppShape;  virtual;
    class function CreateLabelForField(aReport: TppCustomReport; aBand: TppBand; aField: TppField; aFont: TFont): TppLabel;  virtual;
    class function DataTypeToComponentClass(aField: TppField): TComponentClass;  virtual;
    class procedure SetComponentSize(aComponent: TppComponent); virtual;

  end;

var
  gcLayoutFactory: TppLayoutFactoryClass;

implementation


uses
  ppPrintr,
  ppRichTx;

{******************************************************************************
 *
 ** G E N E R A L   P U R P O S E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLayoutFactory.DataTypeToComponentClass }

class function TppLayoutFactory.DataTypeToComponentClass(aField: TppField): TComponentClass;
begin

  case aField.DataType of

    dtMemo:
      begin
        if ContainsRTFData(aField) then
          Result := TppDBRichText
        else
          Result := TppDBMemo;
      end;

    dtGraphic, dtBLOB:
      begin
        if ContainsRTFData(aField) then
          Result := TppDBRichText
        else
          Result := TppDBImage;
      end;

   else
     Result := TppDBText;

  end; {case, FieldType}

end; {class function, DataTypeToComponentClass}

class function TppLayoutFactory.ContainsRTFData(aField: TppField): Boolean;
const
  cRTFHeader = '{\rtf1';
begin

  if aField.DataPipeline.DataView <> nil then
    TdaDataView(aField.DataPipeline.DataView).Active := True;

  aField.DataPipeline.Open;
  Result := Pos(cRTFHeader, aField.AsString) = 1;   //Determine if the field contains RTF data
  aField.DataPipeline.Close;

end;

{------------------------------------------------------------------------------}
{ TppLayoutFactory.CreateComponentForField }

class function TppLayoutFactory.CreateComponentForField(aReport: TppCustomReport; aBand: TppBand; aField: TppField; aFont: TFont): TppComponent;
var
  lComponentClass: TComponentClass;
  lComponent: TppComponent;

begin

  {get the component class based on the data type}
  lComponentClass := gcLayoutFactory.DataTypeToComponentClass(aField);

  {create component}
  lComponent := TppComponent(ppComponentCreate(aReport, lComponentClass));

  lComponent.DSInclude([pppcCreating]);

  {assign component to band}
  lComponent.Band := aBand;

  lComponent.DataField    := aField.FieldName;
  lComponent.DataPipeline := aField.DataPipeline;

  if lComponent.HasFont then
    begin
      lComponent.Font := aFont;
      lComponent.SetBackgroundColor(clWhite,True);
    end;


  {set the component's size}
  TppLayoutFactoryClass.SetComponentSize(lComponent);

  {save reference to component}
  aField.ReportComponent := lComponent;

  lComponent.DSExclude([pppcCreating]);

  Result := lComponent;

end; {class function, CreateComponentForField}

{------------------------------------------------------------------------------}
{ TppLayoutFactory.SetComponentSize }

class procedure TppLayoutFactory.SetComponentSize(aComponent: TppComponent);
var
  liDisplayWidth: Integer;
  lAlignment: TAlignment;
begin

  if aComponent.HasFont then
    begin

      if (aComponent.DataPipeline <> nil) and (aComponent.DataField <> '') then
        begin
          liDisplayWidth := aComponent.DataPipeline.GetFieldDisplayWidth(aComponent.DataField);

          lAlignment := aComponent.DataPipeline.GetFieldAlignment(aComponent.DataField);
        end
      else
        begin
          liDisplayWidth := Length(aComponent.Text);

          lAlignment := taLeftJustify;
        end;

      aComponent.spWidth   := liDisplayWidth * ppGetSpTextWidth(aComponent.Font, 'O') + 4;
      aComponent.spHeight  := ppGetSpTextHeight(aComponent.Font, 'W');
      aComponent.Alignment := lAlignment;

    end;

  if (aComponent is TppCustomImage) then
    begin
      TppCustomImage(aComponent).Stretch := True;
      aComponent.spWidth  := 50;
      aComponent.spHeight := 50;
    end

  else if (aComponent is TppCustomMemo) then
    begin
      aComponent.spWidth := 150;
      aComponent.spHeight := 50;
    end

  else if (aComponent is TppCustomRichText) then
    begin
      TppCustomRichText(aComponent).Stretch := True;
      aComponent.spWidth := 185;
      aComponent.spHeight := 90;
    end;


end; {class procedure, SetComponentSize}

{------------------------------------------------------------------------------}
{ TppLayoutFactory.CreateLabelForField }

class function TppLayoutFactory.CreateLabelForField(aReport: TppCustomReport; aBand: TppBand; aField: TppField; aFont: TFont): TppLabel;
begin

  {create the label}
  Result := TppLabel(ppComponentCreate(aReport, TppLabel));
  Result.DSInclude([pppcCreating]);
  Result.Band := aBand;

  Result.AutoSize := False;
  Result.Caption  := aField.FieldAlias;

  Result.Alignment := aField.Alignment;
  Result.Font := aFont;
  Result.Font.Style := Result.Font.Style;
  Result.SetBackgroundColor(clWhite,True);

  {size the label}
  Result.spHeight := ppGetSpTextHeight(Result.Font, Result.Caption);
  Result.spWidth  := ppGetSpTextWidth(Result.Font, Result.Caption) + 4;

  {store reference to label component in the field}
  aField.ReportLabel := Result;

  Result.DSExclude([pppcCreating]);

end; {class function, CreateLabelForField}

{------------------------------------------------------------------------------}
{ TppLayoutFactory.CreateFrameForComponent }

class function TppLayoutFactory.CreateFrameForComponent(aReport: TppCustomReport; aComponent: TppComponent): TppShape;
begin

  Result := TppShape(ppComponentCreate(aReport, TppShape));
  Result.DSInclude([pppcCreating]);
  Result.Band  := aComponent.Band;
  Result.spLeft   := aComponent.spLeft - 2;
  Result.spTop    := aComponent.spTop - 2;
  Result.spHeight := aComponent.spHeight + 4;
  Result.spWidth  := aComponent.spWidth + 4;
  Result.SetBackgroundColor(clWhite, True);
  Result.SendToBack;
  Result.DSExclude([pppcCreating]);

end; {class function, CreateFrameForComponent}


{******************************************************************************
 *
 ** B L A N K   R E P O R T   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.Create }

constructor TppBlankReportWizard.Create(aOwner: TComponent);
begin
  FReport := nil;
end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.ClassDescription }

class function TppBlankReportWizard.ClassDescription: String;
begin
  Result := ppLoadStr(579); {'Report'}
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.ClassBitmap }

class function TppBlankReportWizard.ClassBitmap: THandle;
begin
 Result := ppBitmapFromResource('PPBLANKREPORTWIZARD');
end; {class function, ClassBitmap}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.DisplaysDialog }

class function TppBlankReportWizard.DisplaysDialog: Boolean;
begin
  Result := False;
end; {class function, DisplaysDialog}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.Execute }

function TppBlankReportWizard.Execute: Boolean;
begin

  Result := False;

  DoOnCreateReport('', TObject(FReport));

  if (FReport = nil) then Exit;

  Result := True;

end; {function, Execute}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.GetReport }

function TppBlankReportWizard.GetReport: TObject;
begin
  Result := FReport;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppBlankReportWizard.GetReportName }

function TppBlankReportWizard.GetReportName: String;
begin
  if (FReport <> nil) then
    Result := FReport.Template.Description
  else
    Result := '';
end; {function, GetReport}

{******************************************************************************
 *
 ** R E P O R T   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportWizard.Create }

constructor TppReportWizard.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAdjustFieldWidth := True;
  FFields := TStringList.Create;
  FForm := nil;
  FGroupFields := TStringList.Create;
  FLayout := rlTabular;
  FDataNames := TStringList.Create;
  FOrientation := poPortrait;
  FReport := nil;
  FReportName := '';
  FReportLayout := nil;
  FReportStyle := nil;
  FSelectedFields := TStringList.Create;
  FStyle := rsCorporate;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportWizard.Destroy }

destructor TppReportWizard.Destroy;
begin

  FDataNames.Free;
  FGroupFields.Free;
  FFields.Free;
  FSelectedFields.Free;

  FForm.Free;
  
  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportWizard.ClassDescription }

class function TppReportWizard.ClassDescription: String;
begin
  Result := ppLoadStr(620); {'Report Wizard'}
end; {constructor, ClassDescription}

{------------------------------------------------------------------------------}
{ TppReportWizard.ClassBitmap }

class function TppReportWizard.ClassBitmap: THandle;
begin
  Result :=ppBitmapFromResource('PPREPORTWIZARD');
end; {constructor, ClassBitmap}

{------------------------------------------------------------------------------}
{ TppReportWizard.Execute }

function TppReportWizard.Execute: Boolean;
begin

  try

    FDataNames.Clear;

    DoOnGetDataNames(FDataNames);

    FDataNames.Insert(0, ppLoadStr(343)); {'<None>'}

    if (FForm = nil) then
      begin
        Application.CreateForm(TppReportWizardDialog, FForm);

        FForm.Wizard := Self;

        FForm.LanguageChanged;
        
        FForm.OnCloseQuery := CloseQueryEvent;
      end;

    InitControls;

    if (FForm.ShowModal = mrOK) then
      begin
        Result := True;

        DoOnCreateReport(DataName, TObject(FReport));

        if (FReport = nil) then Exit;

        FReport.CreateDefaultBands;
        
        {create report from wizard settings}
        WizardToReport;

        if FForm.rdbPreview.Checked then
          NextAction := ppnaPreview
          
        else if FForm.rdbDesign.Checked then
          NextAction := ppnaDesign;

      end
    else
      Result := False;

  finally

     FForm.Free;
     FForm := nil;

  end; {try, finally}

end; {procedure, Execute}

{------------------------------------------------------------------------------}
{ TppReportWizard.GetReport }

function TppReportWizard.GetReport: TObject;
begin
  Result := FReport;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppReportWizard.GetReportName }

function TppReportWizard.GetReportName: String;
begin
  Result := FReportName;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppReportWizard.CloseQueryEvent }

procedure TppReportWizard.CloseQueryEvent(Sender: TObject; var CanClose: Boolean);
begin
  if FForm.ModalResult = mrCancel then Exit;

  {very important that the Sender be this component and NOT the form}
  DoOnValidateName(Self, FReportName, CanClose);

end; {procedure, CloseQueryEvent}

{------------------------------------------------------------------------------}
{ TppReportWizard.InitControls }

procedure TppReportWizard.InitControls;
var
  liIndex: Integer;

begin
  FForm.nbkWizard.PageIndex := 0;

  {initialize static images}
  FForm.imgSelectFields.Picture.Bitmap.Handle := ppBitmapFromResource('PPWZRFIELD');

//  ppDrawMetaBitmap(TppWizardFieldsBitmap, FForm.imgSelectFields.Picture.Bitmap);
  ppDrawMetaBitmap(TppGroupsPageBitmap, FForm.imgGroups.Picture.Bitmap);

  {initialize data view names}
  FForm.rdbLayoutVertical.Tag := Ord(rlVertical);
  FForm.rdbLayoutTabular.Tag  := Ord(rlTabular);

  FForm.rdbSimplePortrait.Tag  := Ord(poPortrait);
  FForm.rdbSimpleLandscape.Tag := Ord(poLandscape);

  FForm.rdbLayoutStepped.Tag    := Ord(rlStepped);
  FForm.rdbLayoutBlock.Tag      := Ord(rlBlock);
  FForm.rdbLayoutOutline1.Tag   := Ord(rlOutline1);
  FForm.rdbLayoutOutline2.Tag   := Ord(rlOutline2);
  FForm.rdbLayoutAlignLeft1.Tag := Ord(rlAlignLeft1);
  FForm.rdbLayoutAlignLeft2.Tag := Ord(rlAlignLeft2);

  FForm.rdbGroupPortrait.Tag  := Ord(poPortrait);
  FForm.rdbGroupLandscape.Tag := Ord(poLandscape);

  {initialize style images}
  SetStyle(rsCorporate);

  FForm.lbxStyles.ItemIndex := Ord(FStyle);

  FForm.cbxDataName.Items := FDataNames;

  liIndex := FForm.cbxDataName.Items.IndexOf(DataName);

  if (liIndex <> -1) then
    begin
      FForm.cbxDataName.ItemIndex := liIndex;

      SetDataName(DataName);
    end
  else
    begin
      if (FForm.cbxDataName.Items.Count > 1) then
        begin
          FForm.cbxDataName.ItemIndex := 1;

          SetDataName(FForm.cbxDataName.Items[1]);
        end;
    end;

  SetLayout(rlTabular);

  SetOrientation(poPortrait);

  SetPagingButtons;

  FForm.lblDescription.Visible := AskForName;
  FForm.edtDescription.Visible := AskForName;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.AddField }

function TppReportWizard.AddField(aField: TppField): Integer;
begin
  Result := FSelectedFields.AddObject(aField.FieldAlias, aField);
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.AddGroup }

function TppReportWizard.AddGroup(aField: TppField): Integer;
begin
  Result := FGroupFields.AddObject(aField.FieldAlias, aField);
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.RemoveField }

function TppReportWizard.RemoveField(aField: TppField): Integer;
var
  liField: Integer;

begin
  liField := FSelectedFields.IndexOfObject(aField);

  if liField >= 0 then
    FSelectedFields.Delete(liField);

  Result := liField;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.RemoveGroup }

function TppReportWizard.RemoveGroup(aField: TppField): Integer;
var
  liField: Integer;

begin
  liField := FGroupFields.IndexOfObject(aField);

  if liField >= 0 then
    FGroupFields.Delete(liField);

  Result := liField;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.GetField }

function TppReportWizard.GetField(Index: Integer): TppField;
begin
  Result := TppField(FSelectedFields.Objects[Index]);
end; {procedure, GetField}

{------------------------------------------------------------------------------}
{ TppReportWizard.GetFieldCount }

function TppReportWizard.GetFieldCount: Integer;
begin
  Result := FSelectedFields.Count;
end; {procedure, GetFieldCount}

{------------------------------------------------------------------------------}
{ TppReportWizard.GetGroup }

function TppReportWizard.GetGroup(Index: Integer): TppField;
begin
  Result := TppField(FGroupFields.Objects[Index]);
end; {procedure, GetGroup}

{------------------------------------------------------------------------------}
{ TppReportWizard.GetGroupCount }

function TppReportWizard.GetGroupCount: Integer;
begin
  Result := FGroupFields.Count;
end; {procedure, GetGroupCount}

{------------------------------------------------------------------------------}
{ TppReportWizard.SelectDataName }

procedure TppReportWizard.SelectDataName;
begin
  SetDataName(FForm.cbxDataName.Items[FForm.cbxDataName.ItemIndex]);
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetDataName }

procedure TppReportWizard.SetDataName(aDataName: String);
begin

  inherited SetDataName(aDataName);

  FSelectedFields.Clear;
  FFields.Clear;

  DoOnGetFields(DataName, FFields);

  if (FForm <> nil) then
    begin
      {reset list boxes}
      FForm.lbxFieldsAvailable.Clear;
      FForm.lbxFieldsSelected.Clear;
      FForm.lbxFieldsAvailable.Items := FFields;
      FForm.lbxFieldsAvailable.ItemIndex := 0;

      SetFieldSelectButtons;
    end;

  UpdateGroups;
  
end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TppReportWizard.SetLayout }

procedure TppReportWizard.SetLayout(aLayout: TppReportLayoutType);
var
  lClass: TppMetaBitmapClass;
begin

  case aLayout of
    rlVertical:       lClass := TppVerticalLayoutBitmap;
    rlTabular:        lClass := TppTabularLayoutBitmap;
    rlStepped:        lClass := TppSteppedLayoutBitmap;
    rlBlock:          lClass := TppBlockLayoutBitmap;
    rlOutline1:       lClass := TppOutline1LayoutBitmap;
    rlOutline2:       lClass := TppOutline2LayoutBitmap;
    rlAlignLeft1:     lClass := TppAlignLeft1LayoutBitmap;
  else {rlAlignLeft2:}
       lClass := TppAlignLeft2LayoutBitmap;
  end;

  if (FGroupFields.Count = 0) then
    ppDrawMetaBitmap(lClass, FForm.imgSimpleLayout.Picture.Bitmap)
  else
    ppDrawMetaBitmap(lClass, FForm.imgGroupLayout.Picture.Bitmap );

  FLayout := aLayout;
  
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetOrientation }

procedure TppReportWizard.SetOrientation(aOrientation: TPrinterOrientation);
var
  lClass: TppMetaBitmapClass;
begin
  FOrientation := aOrientation;

  case aOrientation of
    poPortrait:
      lClass := TppPortraitBitmap;
    poLandscape:
      lClass := TppLandscapeBitmap;
    else
      lClass := nil;
  end;

  if (FGroupFields.Count = 0) then
    ppDrawMetaBitmap(lClass, FForm.imgSimpleOrientation.Picture.Bitmap)
  else
    ppDrawMetaBitmap(lClass, FForm.imgGroupOrientation.Picture.Bitmap);

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetStyle }

procedure TppReportWizard.SetStyle(aStyle: TppReportStyleType);
var
  lClass: TppMetaBitmapClass;
begin

  case aStyle of
    rsBold:       lClass := TppBoldStyleBitmap;
    rsCasual:     lClass := TppCasualStyleBitmap;
    rsCompact:    lClass := TppCompactStyleBitmap;
    rsCorporate:  lClass := TppCorporateStyleBitmap;
    rsFormal:     lClass := TppFormalStyleBitmap;
  else {rsSoftGray:}
    lClass := TppSoftGrayStyleBitmap;
  end;

  ppDrawMetaBitmap(lClass, FForm.imgStyle.Picture.Bitmap);

  FStyle := aStyle;
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.AddFieldToSelection }

procedure TppReportWizard.AddFieldToSelection;
begin

  if (FForm = nil) then Exit;

  MoveSelectedFields(FForm.lbxFieldsAvailable, FForm.lbxFieldsSelected, False);

end; {procedure, AddFieldToSelection}

{------------------------------------------------------------------------------}
{ TppReportWizard.AddAllFieldsToSelection }

procedure TppReportWizard.AddAllFieldsToSelection;
begin

  if (FForm = nil) then Exit;

  MoveSelectedFields(FForm.lbxFieldsAvailable, FForm.lbxFieldsSelected, True);

end; {procedure, AddAllFieldsToSelection}

{------------------------------------------------------------------------------}
{ TppReportWizard.RemoveFieldFromSelection }

procedure TppReportWizard.RemoveFieldFromSelection;
begin

  if (FForm = nil) then Exit;

  MoveSelectedFields(FForm.lbxFieldsSelected, FForm.lbxFieldsAvailable, False);

end; {procedure, RemoveFieldFromSelection}

{------------------------------------------------------------------------------}
{ TppReportWizard.RemoveAllFieldsFromSelection }

procedure TppReportWizard.RemoveAllFieldsFromSelection;
begin

  if (FForm = nil) then Exit;

  MoveSelectedFields(FForm.lbxFieldsSelected, FForm.lbxFieldsAvailable, True);

end; {procedure, RemoveAllFieldsFromSelection}

{------------------------------------------------------------------------------}
{ TppReportWizard.MoveSelectedFields }

procedure TppReportWizard.MoveSelectedFields(aSource, aTarget: TListBox; aAllFields: Boolean);
var
  liIndex: Integer;
  lField: TppField;
  liPosition: Integer;
  lbLastItem: Boolean;
  liFirstIndex: Integer;
  liLastIndex: Integer;
  liSourceIndex: Integer;
  liTargetIndex: Integer;
begin

  liFirstIndex := -1;
  liLastIndex := 0;

  for liIndex := 0 to aSource.Items.Count - 1 do
    begin

      if aAllFields or aSource.Selected[liIndex] then
        begin
          lField := TppField(aSource.Items.Objects[liIndex]);

          liPosition := FSelectedFields.IndexOf(lField.FieldAlias);

          if (liPosition = -1) then
            AddField(lField)
          else
            begin
              lField.SelectOrder := -1;
              lField.GroupOrder := -1;

              RemoveField(lField);
            end;

          if (liFirstIndex = -1) then
            liFirstIndex := liIndex;

          liLastIndex := liIndex;
        end;

    end;

  lbLastItem := (liLastIndex = aSource.Items.Count - 1);
  liSourceIndex := liFirstIndex;
  liTargetIndex := 0;

  liIndex := 0;

  while (liIndex < aSource.Items.Count) do
    begin

      if aAllFields or aSource.Selected[liIndex] then
        begin
          lField := TppField(aSource.Items.Objects[liIndex]);

          aSource.Items.Delete(liIndex);

          liTargetIndex := aTarget.Items.AddObject(lField.FieldAlias, lField);

          lField.SelectOrder := liTargetIndex;
        end
      else
        Inc(liIndex);

    end;

  SetFieldSelectButtons;

  aTarget.ItemIndex := liTargetIndex;

  if (aSource.Items.Count > 0) then
    begin
      if lbLastItem then
        aSource.ItemIndex := aSource.Items.Count - 1
      else
        aSource.ItemIndex := liSourceIndex;

      aSource.Selected[aSource.ItemIndex] := True;
    end;

  aSource.SetFocus;

end; {procedure, MoveSelectedFields}

{------------------------------------------------------------------------------}
{ TppReportWizard.AddGroupToSelection }

procedure TppReportWizard.AddGroupToSelection;
begin

  if (FForm = nil) then Exit;

  MoveSelectedGroups(FForm.lbxGroupFieldsAvailable, FForm.lbxGroupFieldsSelected, False);

end; {procedure, AddGroupToSelection}

{------------------------------------------------------------------------------}
{ TppReportWizard.RemoveGroupFromSelection }

procedure TppReportWizard.RemoveGroupFromSelection;
begin

  if (FForm = nil) then Exit;

  MoveSelectedGroups(FForm.lbxGroupFieldsSelected, FForm.lbxGroupFieldsAvailable, False);

end; {procedure, RemoveGroupFromSelection}

{------------------------------------------------------------------------------}
{ TppReportWizard.MoveSelectedGroups }

procedure TppReportWizard.MoveSelectedGroups(aSource, aTarget: TListBox; aAllFields: Boolean);
var
  liIndex: Integer;
  lField: TppField;
  liPosition: Integer;
  liFirstIndex: Integer;
  liLastIndex: Integer;
  liSourceIndex: Integer;
  liTargetIndex: Integer;
begin

  liFirstIndex := -1;
  liLastIndex := 0;

  for liIndex := 0 to aSource.Items.Count - 1 do
    begin

      if aAllFields or aSource.Selected[liIndex] then
        begin
          lField := TppField(aSource.Items.Objects[liIndex]);

          liPosition := FGroupFields.IndexOf(lField.FieldAlias);

          if (liPosition = -1) then
            AddGroup(lField)
          else
            begin
              lField.GroupOrder := -1;

              RemoveGroup(lField);
            end;

          if (liFirstIndex = -1) then
            liFirstIndex := liIndex;

          liLastIndex := liIndex;
        end;

    end;


  if (liLastIndex = aSource.Items.Count - 1) then
    liSourceIndex := 0
  else
    liSourceIndex := liFirstIndex;

  liTargetIndex := 0;
  liIndex := 0;

  while liIndex < aSource.Items.Count do
    begin

      if aAllFields or aSource.Selected[liIndex] then
        begin
          lField := TppField(aSource.Items.Objects[liIndex]);

          aSource.Items.Delete(liIndex);

          liTargetIndex := aTarget.Items.AddObject(lField.FieldAlias, lField);

          if (aSource = FForm.lbxGroupFieldsAvailable) then
            lField.GroupOrder := liTargetIndex;
        end
      else
        Inc(liIndex);

    end;

  DrawGroupImage;

  SetGroupSelectButtons;

  aTarget.ItemIndex := liTargetIndex;

  if (aSource.Items.Count > 0) then
    begin
      aSource.ItemIndex := liSourceIndex;
      aSource.Selected[liSourceIndex] := True;
    end;

  aSource.SetFocus;

end; {procedure, MoveSelectedGroups}

{------------------------------------------------------------------------------}
{ TppReportWizard.DrawGroupImage }

procedure TppReportWizard.DrawGroupImage;
var
  lFrame: TRect;
  liCorner: Integer;
  lFields: TStringList;
  lsField: String;
  liLeft: Integer;
  liTop: Integer;
  liField: Integer;
  liLineHeight: Integer;
  liWidth: Integer;
  lbOutOfSpace: Boolean;
  liInterGroup: Integer;
  liIndent: Integer;
  lbGroups: Boolean;
  liGroupOffsetLeft: Integer;
  liGroupOffsetTop: Integer;
begin
  liTop := 0;
  liLeft := 0;
  liInterGroup := 0;
  liIndent := 0;

  {refresh static image}
  ppDrawMetaBitmap(TppGroupsPageBitmap, FForm.imgGroups.Picture.Bitmap);

  lFields := TStringList.Create;

  with FForm.imgGroups.Picture.Bitmap.Canvas do
    begin
      Brush.Style := bsClear;

      Font.Size := 8;
      Font.Color := clBlue;
      Font.Style := [fsBold];

      {draw frame around group fields}
      lFrame.Left   := 16;
      lFrame.Top    := 12;
      lFrame.Right  := 224;
      lFrame.Bottom := 254;

      lFields.Assign(FForm.lbxGroupFieldsSelected.Items);

      lbGroups := (lFields.Count > 0);
      liGroupOffsetLeft := 0;
      liGroupOffsetTop := 0;

      if lbGroups then
        begin
          liLeft := lFrame.Left;
          liTop := lFrame.Top;
          liInterGroup := 5;
          liIndent := 7;
        end;


      for liField := 0 to lFields.Count - 1 do
        begin
        
          Inc(liGroupOffsetLeft, liIndent);
          Inc(liGroupOffsetTop, 25 + liInterGroup);

          if liField = 0 then
            liCorner := 7
          else
            liCorner := 0;

          with lFrame do
            begin
              MoveTo(liLeft, liTop);
              LineTo(Right - liCorner, liTop);
              MoveTo(liLeft, liTop);
              LineTo(liLeft, liTop + 25);
              LineTo(Right, liTop + 25);
              LineTo(Right, liTop + liCorner);
            end;

          TextOut(liLeft + 2, liTop + 2, lFields[liField]);

          liTop := liTop + 25 + liInterGroup;
          liLeft := liLeft + liIndent;

        end;

      Font.Color := clBlack;
      Font.Style := [];

      {draw frame around non-group fields}
      lFrame.Left   := lFrame.Left + liGroupOffsetLeft;
      lFrame.Top    := lFrame.Top + liGroupOffsetTop;

      if not(lbGroups) then
        liCorner := 7
      else
        liCorner := 0;

      with lFrame do
        begin
          MoveTo(Left, Top);
          LineTo(Right - liCorner, Top);
          MoveTo(Left, Top);
          LineTo(Left, Bottom);
          LineTo(Right, Bottom);
          LineTo(Right, Top + liCorner);
        end;

      {draw non-group fields}
      lFields.Assign(FForm.lbxGroupFieldsAvailable.Items);

      liTop := lFrame.Top + 2;
      liLeft := lFrame.Left + 3;
      liLineHeight := TextHeight('W') + 4;
      lbOutOfSpace := ((liTop + liLineHeight) > lFrame.Bottom);
      liField := 0;

      while (liField < lFields.Count) and not(lbOutOfSpace) do
        begin
          lsField := lFields[liField];
          
          if liField < lFields.Count - 1 then
            lsField := lsField + ', ';

          liWidth := TextWidth(lsField);

          if (liLeft + liWidth > lFrame.Right) then
            begin
              liTop := liTop + liLineHeight;
              liLeft := lFrame.Left + 2;

              if liTop + liLineHeight > lFrame.Bottom then
                lbOutOfSpace := True;

            end;

          TextOut(liLeft, liTop, lsField);

          liLeft := liLeft + liWidth;

          Inc(liField);
        end;

    end;

  lFields.Free;
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetFieldSelectButtons }

procedure TppReportWizard.SetFieldSelectButtons;
var
  lbFieldsAvailable,
  lbFieldsSelected: Boolean;
begin

  lbFieldsAvailable := (FForm.lbxFieldsAvailable.Items.Count > 0);
  lbFieldsSelected := (FForm.lbxFieldsSelected.Items.Count > 0);

  FForm.spbSelectField.Enabled := lbFieldsAvailable;
  FForm.spbSelectAllFields.Enabled := lbFieldsAvailable;

  FForm.spbDeselectField.Enabled := lbFieldsSelected;
  FForm.spbDeselectAllFields.Enabled := lbFieldsSelected;
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetGroupSelectButtons }

procedure TppReportWizard.SetGroupSelectButtons;
var
  lbFieldsAvailable,
  lbFieldsSelected: Boolean;
begin

  lbFieldsAvailable := (FForm.lbxGroupFieldsAvailable.Items.Count > 0);
  lbFieldsSelected := (FForm.lbxGroupFieldsSelected.Items.Count > 0);

  FForm.spbSelectGroupField.Enabled := lbFieldsAvailable;
  FForm.spbDeselectGroupField.Enabled := lbFieldsSelected;
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.UpdateGroups }

procedure TppReportWizard.UpdateGroups;
var
  lField: TppField;
  liField: Integer;
begin

  FGroupFields.Clear;

  if (FForm = nil) then Exit;

  {reset list boxes}
  FForm.lbxGroupFieldsAvailable.Clear;
  FForm.lbxGroupFieldsSelected.Clear;

  for liField := 0 to FFields.Count - 1 do
    begin
      lField := TppField(FFields.Objects[liField]);

      if lField.Sortable and (FSelectedFields.IndexOf(lField.FieldAlias) <> -1) then
        FForm.lbxGroupFieldsAvailable.Items.AddObject(lField.FieldAlias, lField);

    end;

  DrawGroupImage;

  SetGroupSelectButtons;

  FForm.lbxGroupFieldsAvailable.ItemIndex := 0;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.ChangeGroupPosition }

procedure TppReportWizard.ChangeGroupPosition(aIncrement: Integer);
var
  liIndex: Integer;
  liNewIndex: Integer;
  lField: TppField;
begin

  with FForm.lbxGroupFieldsSelected do
    begin
      liIndex := ItemIndex;

      liNewIndex := liIndex + aIncrement;

      if (liNewIndex >= 0) and (liNewIndex < Items.Count) then
        begin
          Items.Move(liIndex, liNewIndex);

          ItemIndex := liNewIndex;

          lField := TppField(Items.Objects[liNewIndex]);

          lField.GroupOrder := liNewIndex;

          DrawGroupImage;
        end;

    end; {with, lbxGroupFieldsSelected}

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.ChangeFieldPosition }

procedure TppReportWizard.ChangeFieldPosition(aIncrement: Integer);
var
  liIndex: Integer;
  liNewIndex: Integer;
  lField: TppField;
begin

  with FForm.lbxFieldsSelected do
    begin
      liIndex := ItemIndex;

      liNewIndex := liIndex + aIncrement;

      if (liNewIndex >= 0) and (liNewIndex < Items.Count) then
        begin
          Items.Move(liIndex, liNewIndex);

          ItemIndex := liNewIndex;

          lField := TppField(Items.Objects[liNewIndex]);

          lField.SelectOrder := liNewIndex;
        end;

    end; {with, lbxFieldsSelected}

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetPagingButtons }

procedure TppReportWizard.SetPagingButtons;
begin

  with FForm do
    begin
      if (nbkWizard.PageIndex = 0) then
        btnBack.Enabled := False
      else
        btnBack.Enabled := True;

      if nbkWizard.PageIndex = (nbkWizard.Pages.Count - 1) then
        btnNext.Enabled := False
      else
        btnNext.Enabled := True;
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.AdvancePage }

procedure TppReportWizard.AdvancePage(aIncrement: Integer);
var
  liPageIndex: Integer;
  lbAdvancePage: Boolean;
  lsMessage: String;
begin

  if (FForm = nil) then Exit;

  liPageIndex := FForm.nbkWizard.PageIndex;

  liPageIndex := liPageIndex + aIncrement;

  lbAdvancePage := True;

  {navigate to next logical page}
  case liPageIndex of
    1:
      begin
        if (FSelectedFields.Count > 0) then
          begin
            UpdateGroups;
            FLayout := rlTabular;
          end
        else
          begin
            {message: Fields must be selected before continuing.}
            lsMessage := ppLoadStr(608);

            MessageDlg(lsMessage, mtInformation, [mbOK], 0);
            
            lbAdvancePage := False
          end;
      end;

    2:
      if (FGroupFields.Count > 0) then
        begin
          liPageIndex := liPageIndex + aIncrement;

          if (Integer(Ord(FLayout)) < 2) then
            begin
              SetLayout(rlStepped);

              SetOrientation(FOrientation);
            end;
        end;

    3:
      if (FGroupFields.Count = 0) then
        liPageIndex := liPageIndex + aIncrement;

    5:
      FForm.edtDescription.Text := DataName + '-1 Report';

  end; {case}


  {set the page}
  if lbAdvancePage then
    begin
      FForm.nbkWizard.PageIndex := liPageIndex;

      case liPageIndex of
        0: FForm.cbxDataName.SetFocus;
        1: FForm.lbxGroupFieldsAvailable.SetFocus;
        2: FForm.gbxSimpleLayout.SetFocus;
        3: FForm.gbxGroupLayout.SetFocus;
        4: FForm.lbxStyles.SetFocus;
        5:
          if AskForName then
            FForm.edtDescription.SetFocus
          else
            FForm.rdbPreview.SetFocus;

      end; {case, liPageIndex}

      SetPagingButtons;
    end;

end;

{******************************************************************************
 *
 ** W I Z A R D   T O   R E P O R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportWizard.WizardToReport }

procedure TppReportWizard.WizardToReport;
begin

  FReport.BeginUpdate;

  try
    FReport.PrinterSetup.Orientation := FOrientation;

    CreateBands;

    CreateGroups;

    FReportStyle := CreateStyle(FStyle);

    FReportLayout := CreateLayout(FLayout);

    CreateTitle;

    CreateFooter;

    CreateDataControls;

    PositionControls;

    FReportLayout.Apply(FReport);

    FReportStyle.Apply(FReport);

    FReportStyle.Free;

    FReportLayout.Free;
  finally
    FReport.EndUpdate;
    FReport.Modified := True;
  end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateBands }

procedure TppReportWizard.CreateBands;
var
  lBand: TppBand;
begin

  lBand := FReport.GetBand(btTitle, 0);

  if (lBand = nil) then
    begin
      lBand := TppBand(ppComponentCreate(FReport, TppTitleBand));
      lBand.Report := FReport;
    end
  else
    lBand.spHeight := 50;

  {if subreport, put footer in summary band, free header and footer bands}
  if (FReport is TppChildReport) then
    begin
      lBand := FReport.GetBand(btSummary, 0);

      if (lBand = nil) then
        begin
          lBand := TppBand(ppComponentCreate(FReport, TppSummaryBand));
          lBand.Report := FReport;
        end
      else
        lBand.spHeight := 50;

      FReport.GetBand(btHeader, 0).Free;
      FReport.GetBand(btFooter, 0).Free;
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateTitle }

procedure TppReportWizard.CreateTitle;
var
  lLabel: TppLabel;
  lBand: TppBand;
  lsName: String;
begin
  {create title band}
  lBand :=  FReport.GetBand(btTitle, 0);

  lsName := FReport.Template.Description;

  if (lsName = '') then
    lsName := DataName;

  if (lsName = '') then
    lsName := FReport.UserName;

  lLabel := CreateLabel(lBand, lsName);
  lLabel.spTop  := 5;
  lLabel.spLeft := 5;
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateFooter }

procedure TppReportWizard.CreateFooter;
var
  lVar: TppSystemVariable;
  lBand: TppBand;
  lStyle: TppBandStyle;
begin

  {if subreport, put footer in summary band}
  if (FReport is TppChildReport) then
    lBand := FReport.GetBand(btSummary, 0)
  else
    lBand := FReport.GetBand(btFooter, 0);

  lStyle := FReportStyle.StyleForBand(lBand);

  lVar := TppSystemVariable(ppComponentCreate(FReport, TppSystemVariable));

  lVar.Band := lBand;
  lVar.spTop  := 5;
  lVar.spLeft := 5;
  lVar.VarType := vtPrintDateTime;
  lVar.Font := lStyle.Font;
  lVar.Transparent := True;

  lVar := TppSystemVariable(ppComponentCreate(FReport, TppSystemVariable));
  lVar.Band := lBand;
  lVar.spTop  := 5;
  lVar.spLeft  := 10;

  lVar.VarType  := vtPageNoDesc;
  lVar.Alignment := taRightJustify;
  lVar.Font := lStyle.Font;
  lVar.Transparent := True;
  lVar.spLeft := (lBand.spWidth - lVar.spWidth) - 5;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateGroups }

procedure TppReportWizard.CreateGroups;
var
  lGroup: TppGroup;
  lGroupHeader: TppGroupHeaderBand;
  lGroupFooter: TppGroupFooterBand;
  liGroup: Integer;
  lField: TppField;
begin

  for liGroup := 0 to FGroupFields.Count - 1 do
    begin
      lField := TppField(FGroupFields.Objects[liGroup]);

      {create group & bands}
      lGroup := TppGroup(ppComponentCreate(FReport, TppGroup));
      lGroup.Report := FReport;

      lGroupFooter := TppGroupFooterBand(ppComponentCreate(FReport, TppGroupFooterBand));
      lGroupHeader := TppGroupHeaderBand(ppComponentCreate(FReport, TppGroupHeaderBand));
      lGroupHeader.spHeight := 50;

      {assign data field and pipeline}
      lGroup.BreakName := lField.FieldName;
      lGroup.DataPipeline := lField.DataPipeline;

      {assign group & bands}
      lGroupFooter.Group := lGroup;
      lGroupHeader.Group := lGroup;

      {save reference to this field's group}
      lField.ReportComponent := TppCommunicator(lGroup);
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateDataControls }

procedure TppReportWizard.CreateDataControls;
var
  lComponentClass: TComponentClass;
  lBand: TppBand;
  lDetailBand: TppBand;
  lComponent: TppComponent;
  lField: TppField;
  liField: Integer;
  lLabel: TppLabel;
begin

  lDetailBand := FReport.GetBand(btDetail, 0);

  for liField := 0 to FSelectedFields.Count - 1 do
    begin
      {get the field map}
      lField := TppField(FSelectedFields.Objects[liField]);

      {get the component class based on the data type}
      lComponentClass := gcLayoutFactory.DataTypeToComponentClass(lField);

      {create component}
      lComponent := TppComponent(ppComponentCreate(FReport, lComponentClass));

      {default to transparent}
      if lComponent.HasFont then
        lComponent.SetBackGroundColor(clWhite, True);


      {assign to group header or detail band}
      if (FReportLayout.GroupHeaders) and (lField.GroupOrder <> -1) then
          lBand := TppGroup(lField.ReportComponent).HeaderBand

      else
        begin
          lBand := lDetailBand;

          if (lField.GroupOrder <> -1) and (lComponent is TppDBText) then
            TppDBText(lComponent).SuppressRepeatedValues := True;

        end;

      {assign component to band}
      lComponent.Band := lBand;

      lComponent.DataField    := lField.FieldName;
      lComponent.DataPipeline := lField.DataPipeline;

      {set the component's size}
      SetComponentSize(lComponent);

      {create label for component}
      if (FReportLayout.GroupHeaders) and (lField.GroupOrder <> -1) then
        lLabel := nil
      else
        lLabel := CreateLabel(FReportLayout.ColumnHeaderBand, lField.FieldAlias);

      {save reference to component}
      lField.ReportComponent := lComponent;
      lField.ReportLabel := lLabel;

      if (lLabel <> nil) then
        if (lComponent.spWidth > lLabel.spWidth) then
          lField.ColumnWidth := lComponent.spWidth
        else
          begin
            lComponent.spWidth := lLabel.spWidth;
            lField.ColumnWidth := lLabel.spWidth;
          end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.PositionControls }

procedure TppReportWizard.PositionControls;
var
  lFields: TStringList;
  lGroups: TStringList;
  lHeaderBand: TppBand;
  lDetailBand: TppBand;
  liIndent: Integer;
  liTotalIndent: Integer;
  liMaxFieldWidth: Integer;
  liMaxLabelWidth: Integer;
  liTotalWidth: Integer;
  lbFieldsOver: Boolean;
begin
  lHeaderBand := FReportLayout.ColumnHeaderBand;
  lDetailBand := FReport.GetBand(btDetail, 0);

  {collect field and group maps}
  lFields := TStringList.Create;
  lGroups := TStringList.Create;
  liTotalWidth := 0;
  liMaxFieldWidth := 0;
  liMaxLabelWidth := 0;
  lbFieldsOver := False;

  GetFields(lFields, lGroups, liTotalWidth, liMaxFieldWidth, liMaxLabelWidth, lbFieldsOver);

  {recalc control widths to fit in band}
  if lbFieldsOver and FAdjustFieldWidth then
    AdjustFieldWidths(lFields, liTotalWidth, lDetailBand);

  {put fields in selection and group order}
  lFields.Sort;
  lGroups.Sort;

  {position group band components}
  liIndent := 20;
  liTotalIndent := 0;
  PositionGroupControls(lGroups, liIndent, liTotalIndent);

  if (FLayout = rlVertical) then
    PositionControlsVertical(lFields, liMaxLabelWidth, lDetailBand, lHeaderBand)

  else
    PositionControlsHorizontal(lFields, liMaxFieldWidth, lDetailBand, lHeaderBand,
                               liTotalIndent, lbFieldsOver);


  lFields.Free;
  lGroups.Free;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.PositionControlsVertical }


procedure TppReportWizard.PositionControlsVertical(FieldList: TStringList; MaxLabelWidth: Integer;
                                                   DetailBand: TppBand; HeaderBand: TppBand);
var
  liTop: Integer;
  liLeft: Integer;
  liField: Integer;
  lComponent: TppComponent;
  lLabel: TppLabel;
  lField: TppField;
  liSpacer: Integer;
begin
  liTop := 10;
  liLeft := MaxLabelWidth + 10;
  liSpacer := 5;

  {position detail band components}
  for liField := 0 to FieldList.Count - 1 do
    begin
      lField := TppField(FieldList.Objects[liField]);

      lComponent := TppComponent(lField.ReportComponent);
      lComponent.spLeft := liLeft;
      lComponent.spTop  := liTop;

      lLabel := TppLabel(lField.ReportLabel);
      lLabel.spTop := liTop;
      lLabel.spLeft := liSpacer;

      liTop := lComponent.spTop + lComponent.spHeight + liSpacer;

      if (liTop > DetailBand.spHeight) then
        DetailBand.spHeight := liTop + liSpacer;

    end; {for, each field map}

end; {procedure, PositionControlsVertical}

{------------------------------------------------------------------------------}
{ TppReportWizard.PositionControlsHorizontal }

procedure TppReportWizard.PositionControlsHorizontal(FieldList: TStringList;
                                                     MaxFieldWidth: Integer;
                                                     DetailBand: TppBand; HeaderBand: TppBand;
                                                     TotalIndent: Integer; FieldsOver: Boolean);
var
  liTop: Integer;
  liHeaderTop: Integer;
  liMaxBottom: Integer;
  liStartPosition: Integer;
  liCurrentPosition: Integer;
  lField: TppField;
  lComponent: TppComponent;
  lLabel: TppLabel;
  liSpacer: Integer;
  liField: Integer;
  liWidth: Integer;
  liChange: Integer;
begin

  liTop := 2;
  liHeaderTop := FReportLayout.ColumnHeaderTopOffset;
  liMaxBottom := 0;
  liSpacer := 5;

  if TotalIndent = 0 then
    liStartPosition := 5
  else
    liStartPosition := TotalIndent;
    
  liCurrentPosition := liStartPosition;

  {position detail band components (going from left to right)}
  for liField := 0 to FieldList.Count - 1 do
    begin
      lField := TppField(FieldList.Objects[liField]);

      lComponent := TppComponent(lField.ReportComponent);
      lComponent.spLeft := liCurrentPosition;
      lComponent.spTop  := liTop;

      {create label}
      lLabel := TppLabel(lField.ReportLabel);
      lLabel.spLeft := liCurrentPosition;
      lLabel.spTop  := liHeaderTop;

      lLabel.Alignment := lComponent.Alignment;

      if FAdjustFieldWidth and FieldsOver then
        begin
          lComponent.spWidth := lField.ColumnWidth;
          lLabel.spWidth := lField.ColumnWidth;
        end;

      {determine width of this column}
      if (lComponent.spWidth > lLabel.spWidth) then
        liWidth := lComponent.spWidth
      else
        liWidth := lLabel.spWidth;

      liCurrentPosition := liCurrentPosition + liWidth + liSpacer;

      {update band height, if necessary}
      if ((lComponent.spTop + lComponent.spHeight) > liMaxBottom) then
        liMaxBottom := lComponent.spTop + lComponent.spHeight;

      {does this control fit on this row?}
      if (liCurrentPosition > (DetailBand.spWidth + liSpacer)) then
        begin
          liChange := (liMaxBottom + 3) - liTop;
          liTop := liMaxBottom + 3;
          liHeaderTop := liHeaderTop + liChange;
          liCurrentPosition := liStartPosition;

          {move current control to next row}
          lComponent.spLeft := liCurrentPosition;
          lComponent.spTop  := liTop;

          lLabel.spTop  := liHeaderTop;
          lLabel.spLeft := liCurrentPosition;

          liCurrentPosition := liCurrentPosition + liWidth + liSpacer;
        end;

      {adjust right-aligned controls}
      if (lLabel.spWidth > lComponent.spWidth) and (lComponent.Alignment = taRightJustify) then
        lComponent.spLeft := lComponent.spLeft + (lLabel.spWidth - lComponent.spWidth);

      {update band height, if necessary}
      if (lComponent.spTop + lComponent.spHeight) > liMaxBottom then
        liMaxBottom := lComponent.spTop + lComponent.spHeight;

      if (liMaxBottom > DetailBand.spHeight) then
        DetailBand.spHeight := liMaxBottom + 5;

    end; {for, each field map}

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.PositionGroupControls }

procedure TppReportWizard.PositionGroupControls(GroupMapList: TStringList; Indent: Integer; var TotalIndent: Integer);
var
  liField: Integer;
  lField: TppField;
  lComponent: TppComponent;
begin

  for liField := 0 to GroupMapList.Count - 1 do
    begin
      lField := TppField(GroupMapList.Objects[liField]);

      lComponent := TppComponent(lField.ReportComponent);

      if FReportLayout.Indent then
        lComponent.spLeft := (Indent * liField) + 5
      else
        lComponent.spLeft := 5;

      lComponent.spTop := 2;

      if (lComponent.Band = FReportLayout.ColumnHeaderBand) then
        FReportLayout.ColumnHeaderTopOffset := lComponent.spTop + lComponent.spHeight + 5;

      TotalIndent := lComponent.spLeft;
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.GetFields }

procedure TppReportWizard.GetFields(aSelectedFields: TStringList; aGroupFields: TStringList;
                                    var aTotalWidth: Integer;
                                    var aMaxFieldWidth: Integer;
                                    var aMaxLabelWidth: Integer;
                                    var aFieldsOver: Boolean);
var
  liField: Integer;
  lField: TppField;
  liOrder: Integer;
  liFieldWidth: Integer;
  liLabelWidth: Integer;
  lDetailBand: TppBand;
  liSpacer: Integer;
begin

  liSpacer := 5;

  for liField := 0 to FSelectedFields.Count - 1 do
    begin
      lField := TppField(FSelectedFields.Objects[liField]);

      if (FReportLayout.GroupHeaders) and (lField.GroupOrder <> -1) then
        aGroupFields.AddObject(Format('%8d',[lField.GroupOrder]), lField)

      else
        begin

          if (lField.GroupOrder = -1) then
            liOrder := lField.SelectOrder + FReport.GroupCount
          else
            liOrder := lField.GroupOrder;

          aSelectedFields.AddObject(Format('%8d',[liOrder]), lField);

          {determine max width}
          liFieldWidth := TppComponent(lField.ReportComponent).spWidth;
          liLabelWidth := TppLabel(lField.ReportLabel).spWidth;

          if (liFieldWidth > aMaxFieldWidth) then
            aMaxFieldWidth := liFieldWidth;

          if liLabelWidth > aMaxLabelWidth then
            aMaxLabelWidth := liLabelWidth;

          if liFieldWidth > liLabelWidth then
            Inc(aTotalWidth, liFieldWidth + liSpacer)
          else
            Inc(aTotalWidth, liLabelWidth + liSpacer);

        end;

    end;  {for, each Field}

  {remove spacer for last column}
  if (aTotalWidth > 0) then
    aTotalWidth := aTotalWidth - liSpacer;

  {determine if controls fit in band}
  if (FLayout = rlVertical) then
    aFieldsOver := False
  else
    begin
      lDetailBand := FReport.GetBand(btDetail, 0);

      aFieldsOver := ((aTotalWidth + (5 * (aSelectedFields.Count - 1))) > lDetailBand.spWidth);
    end;

end; {procedure, GetFields}

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateLabel }

function TppReportWizard.CreateLabel(aBand: TppBand; const aCaption: String): TppLabel;
var
  lStyle: TppBandStyle;

begin

  {create the label}
  Result := TppLabel(ppComponentCreate(FReport, TppLabel));
  Result.Band := aBand;

  Result.AutoSize := False;
  Result.Caption := aCaption;

  lStyle := FReportStyle.StyleForBand(aBand);

  if (lStyle = nil) then Exit;

  Result.Font := lStyle.Font;
  Result.Font.Style  := Result.Font.Style + [fsBold];
  Result.Transparent := True;
  
  {size the label}
  Result.spHeight := ppGetSpTextHeight(Result.Font, aCaption);
  Result.spWidth  := ppGetSpTextWidth(Result.Font, aCaption) + 4;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.SetComponentSize }

procedure TppReportWizard.SetComponentSize(aComponent: TppComponent);
var
  lBandStyle: TppBandStyle;
  liDisplayWidth: Integer;
  lAlignment: TAlignment;
begin

  if aComponent.HasFont then
    begin

      if (aComponent.DataPipeline <> nil) and (aComponent.DataField <> '') then
        begin
          liDisplayWidth := aComponent.DataPipeline.GetFieldDisplayWidth(aComponent.DataField);

          lAlignment :=aComponent.DataPipeline.GetFieldAlignment(aComponent.DataField);
        end
      else
        begin
          liDisplayWidth := Length(aComponent.Text);

          lAlignment := taLeftJustify;
        end;

      lBandStyle := FReportStyle.StyleForBand(aComponent.Band);
      aComponent.spWidth   := liDisplayWidth * ppGetSpTextWidth(lBandStyle.Font,'0') + 4;
      aComponent.spHeight  := ppGetSpTextHeight(lBandStyle.Font,'W') + 2;
      aComponent.Alignment := lAlignment;
    end;

  if (aComponent is TppCustomImage) then
    begin
      TppCustomImage(aComponent).Stretch := True;
      aComponent.spWidth  := 50;
      aComponent.spHeight := 50;
    end

  else if (aComponent is TppCustomMemo) then
    begin
      aComponent.spWidth := 150;
      aComponent.spHeight := 50;
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.AdjustFieldWidths }

procedure TppReportWizard.AdjustFieldWidths(FieldList: TStringList; TotalWidth: Integer; aBand: TppBand);
var
  liFields: Integer;
  liField: Integer;
  liMinWidth: Integer;
  liOver: Integer;
  leRatio: Extended;
  liFieldWidth: Integer;
  liLabelWidth: Integer;
  liWidth: Integer;
  lField: TppField;
begin
  liMinWidth := 5;

  liOver := (TotalWidth - aBand.spWidth);

  if (liOver <= 0) then Exit;

  {provide for some margin on the right}
  liOver := liOver + 15;
  
  liFields := FieldList.Count;

  for liField := 0 to liFields - 1 do
    begin
      lField := TppField(FieldList.Objects[liField]);

      liFieldWidth := TppComponent(lField.ReportComponent).spWidth;
      liLabelWidth := TppLabel(lField.ReportLabel).spWidth;

      if liFieldWidth > liLabelWidth then
        liWidth := liFieldWidth
      else
        liWidth := liLabelWidth;

      leRatio := liWidth / TotalWidth;

      liWidth := liWidth - Round((liOver * leRatio) + 0.5);

      if (liWidth >= liMinWidth) then
        lField.ColumnWidth := liWidth
      else
        lField.ColumnWidth := liMinWidth;

    end;

end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateComponent }

function TppReportWizard.CreateComponent(const aClassName: String; aOwner: TComponent): TComponent;
var
  lClass: TComponentClass;
begin
  {get class reference for the class name}
  lClass := TComponentClass(GetClass(aClassName));

  {instantiate a component of the selected type}
  if (lClass <> nil) then
    Result := lClass.Create(aOwner)

  else
    Result := nil;
end;


{------------------------------------------------------------------------------}
{ TppReportWizard.CreateStyle }

function TppReportWizard.CreateStyle(aStyleType: TppReportStyleType): TppReportStyle;
var
  lsEnumName: String;
  lsStyleClass: String;
begin
  lsEnumName := ppGetEnumName(TypeInfo(TppReportStyleType), Ord(aStyleType));
  lsStyleClass := 'Tpp' + Copy(lsEnumName,3,Length(lsEnumName)) + 'Style';

  Result := TppReportStyle(CreateComponent(lsStyleClass, FReport));
end;

{------------------------------------------------------------------------------}
{ TppReportWizard.CreateLayout }

function TppReportWizard.CreateLayout(aLayoutType: TppReportLayoutType): TppReportLayout;
var
  lsEnumName: String;
  lsLayoutClass: String;
begin
  lsEnumName := ppGetEnumName(TypeInfo(TppReportLayoutType), Ord(aLayoutType));
  lsLayoutClass := 'Tpp' + Copy(lsEnumName,3,Length(lsEnumName)) + 'Layout';

  Result := TppReportLayout(CreateComponent(lsLayoutClass, FReport));
end;


{******************************************************************************
 *
 ** R E P O R T   S T Y L E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBandStyle.Create }

constructor TppBandStyle.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FColor := clWhite;
  FFont := TFont.Create;
  FLine := False;
  FLinePenColor := clBlack;
  FLinePenWidth := 1;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBandStyle.Destroy }

destructor TppBandStyle.Destroy;
begin
  FFont.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{ TppReportStyle.Create }

constructor TppReportStyle.Create(aOwner: TComponent);
var
  liBand: Integer;
  liBands: Integer;
  lBand: TppBand;
  lStyle: TppBandStyle;
begin
  inherited Create(aOwner);

  FBandClassList := TList.Create;
  FBandStyleList := TList.Create;

  if not(aOwner is TppCustomReport) then Exit;

  FReport := TppCustomReport(aOwner);

  liBands := FReport.BandCount;

  for liBand := 0 to liBands - 1 do
   begin
     lBand := FReport.Bands[liBand];

     if FBandClassList.IndexOf(lBand.ClassType) = -1 then
       begin
         lStyle := TppBandStyle.Create(FReport);

         AddBandStyle(lBand, lStyle);

         SetStyleAttributes(lStyle, lBand);
       end;

   end;

end;

{------------------------------------------------------------------------------}
{ TppReportStyle.Destroy }

destructor TppReportStyle.Destroy;
var
  liBandStyle: Integer;
  liBandStyles: Integer;
begin
  liBandStyles := FBandStyleList.Count;

  for liBandStyle := 0 to liBandStyles - 1 do
    TppBandStyle(FBandStyleList[liBandStyle]).Free;

  FBandStyleList.Free;
  FBandClassList.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{ TppReportStyle.SetStyleAttributes }

procedure TppReportStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

end;

{------------------------------------------------------------------------------}
{ TppReportStyle.AddBandStyle }

procedure TppReportStyle.AddBandStyle(aBand: TppBand; aBandStyle: TppBandStyle);
begin
  if (FBandClassList.IndexOf(aBand.ClassType) = -1) then
    begin
      FBandClassList.Add(aBand.ClassType);
      FBandStyleList.Add(aBandStyle);
    end;
end;

{------------------------------------------------------------------------------}
{ TppReportStyle.StyleForBand }

function TppReportStyle.StyleForBand(aBand: TppBand): TppBandStyle;
var
  liIndex: Integer;
begin
  liIndex := FBandClassList.IndexOf(aBand.ClassType);

  if (liIndex > -1) then
    Result := TppBandStyle(FBandStyleList[liIndex])
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppReportStyle.Apply }

procedure TppReportStyle.Apply(aReport: TppCustomReport);
var
  liBands: Integer;
  liBand: Integer;
  lBand: TppBand;
  lStyle: TppBandStyle;
  liComponent: Integer;
  liComponents: Integer;
  lComponent: TppComponent;
  lShape: TppShape;
begin

  liBands := aReport.BandCount;

  for liBand := 0 to liBands - 1 do
    begin

      lBand := aReport.Bands[liBand];

      lStyle := StyleForBand(lBand);

      liComponents := lBand.ObjectCount;

      for liComponent := 0 to liComponents - 1 do
        begin
          lComponent := lBand.Objects[liComponent];

          if lComponent.HasFont and not(lComponent is TppLabel) then
            lComponent.Font := lStyle.Font;

          if (lComponent is TppLine) then
            begin
              TppLine(lComponent).Pen.Color := lStyle.LinePenColor;
              TppLine(lComponent).Pen.Width := lStyle.LinePenWidth;
            end;

          if (lStyle.Color <> clWhite) then
            begin

              if (lComponent is TppCustomText) then
                TppCustomText(lComponent).Transparent := True

              else if (lComponent is TppCustomMemo) then
                TppCustomMemo(lComponent).Transparent := True;

            end;

        end;

      if (lStyle.Color <> clWhite) then
        begin
          lShape :=  TppShape(ppComponentCreate(aReport, TppShape));
          lShape.Pen.Color := lStyle.Color;
          lShape.Brush.Color := lStyle.Color;
          lShape.spWidth := lBand.spWidth;
          lShape.spHeight := lBand.spHeight;
          lShape.Band := lBand;
          lShape.SendToBack;
         end;

    end;

end; {procedure, Apply}

{------------------------------------------------------------------------------}
{ TppBoldStyle.SetStyleAttributes }

procedure TppBoldStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

  with aBandStyle do
    begin

  {set default values}
  Font.Name := 'TIMES NEW ROMAN';
  Font.Size := 10;
  Font.Style := [fsBold];
  Font.Color := clBlack;

  Line := False;
  LinePenWidth := 1;
  LinePenColor := clBlack;

      {set values based on band}
  if ((aBand is TppTitleBand) and (aBand.Report is TppChildReport)) or (aBand is TppHeaderBand) then
    begin
      Font.Name := 'ARIAL';

      Line := True;
      LinePenWidth := 2;
      LinePenColor := clMaroon;
    end

  else if (aBand is TppTitleBand) then
    begin
      Font.Size := 20;
      Font.Color := clMaroon;
    end

  else if (aBand is TppHeaderBand) then
    begin
      Font.Name := 'ARIAL';

      Line := True;
      LinePenWidth := 2;
      LinePenColor := clMaroon;
    end

  else if ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) or (aBand is TppFooterBand)  then
    begin
      Line := True;
      LinePenWidth := 3;
    end

  else if (aBand is TppDetailBand) then
    begin
      Font.Size := 9;
    end;

  end; {with, aBandStyle}

end; {procedure, SetStyleAttributes}

{------------------------------------------------------------------------------}
{ TppCasualStyle.SetStyleAttributes }

procedure TppCasualStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

  with aBandStyle do
    begin

  {set default values}
  Font.Name := 'ARIAL';
  Font.Size := 10;
  Font.Color := clBlack;

  Line := False;
  LinePenWidth := 2;
  LinePenColor := clTeal;

  {set values based on band}
  if ((aBand is TppTitleBand) and (aBand.Report is TppChildReport)) or (aBand is TppHeaderBand) then
    begin
      Font.Name := 'ARIAL';
      Font.Style := [fsBold];

      Line := True;
    end

  else if (aBand is TppTitleBand) then
    begin
      Font.Size := 24;
      Font.Color := clTeal;
      Font.Style := [fsBold];
    end

  else if ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) or (aBand is TppFooterBand)  then
    begin
      Font.Size := 9;

      Line := True;
      LinePenWidth := 5;
    end

  else if (aBand is TppDetailBand) then
    begin
      {use defaults}
    end;

  end; {with, aBandStyle}

end; {procedure, SetStyleAttributes}

{------------------------------------------------------------------------------}
{ TppCompactStyle.SetStyleAttributes }

procedure TppCompactStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

  with aBandStyle do
    begin

  {set default values}
  Font.Name := 'HAETTENSCHWEILER';
  Font.Size := 10;
  Font.Color := clBlack;

  Line := False;
  LinePenWidth := 2;
  LinePenColor := clBlack;

  {set values based on band}
  if ((aBand is TppTitleBand) and (aBand.Report is TppChildReport)) or (aBand is TppHeaderBand) then
    begin
      Font.Size := 14;
      Font.Style := [];

      Line := True;
    end

  else if (aBand is TppTitleBand) then
    begin
      Font.Size := 28;
      Font.Style := [];
    end

  else if ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) or (aBand is TppFooterBand)  then
    begin
      Font.Name := 'ARIAL';
      Font.Size := 8;

      Line := True;
      LinePenColor := clGray;
      LinePenWidth := 1;
    end

  else if (aBand is TppDetailBand) then
    begin
      Font.Name := 'ARIAL';
      Font.Size := 8;
    end;

  end; {with, aBandStyle}

end; {procedure, SetStyleAttributes}

{------------------------------------------------------------------------------}
{ TppCorporateStyle.SetStyleAttributes }

procedure TppCorporateStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

  with aBandStyle do
    begin

  {set default values}
  Font.Name := 'TIMES NEW ROMAN';
  Font.Size := 9;
  Font.Color := clNavy;

  Line := False;
  LinePenWidth := 2;
  LinePenColor := clNavy;

  {set values based on band}
  if ((aBand is TppTitleBand) and (aBand.Report is TppChildReport)) or (aBand is TppHeaderBand) then
    begin
      Font.Size := 11;
      Font.Style := [fsBold, fsItalic];

      Line := True;
    end

  else if (aBand is TppTitleBand) then
    begin
      Font.Size := 20;
      Font.Style := [fsBold, fsItalic];
    end

  else if ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) or (aBand is TppFooterBand)  then
    begin
      Font.Size := 9;

      Line := True;
      LinePenColor := clGray;
      LinePenWidth := 2;
    end

  else if (aBand is TppDetailBand) then
    begin
      Font.Name := 'ARIAL';
      Font.Size := 8;
      Font.Color := clBlack;
    end;

  end; {with, aBandStyle}

end; {procedure, SetStyleAttributes}

{------------------------------------------------------------------------------}
{ TppFormalStyle.SetStyleAttributes }

procedure TppFormalStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

  with aBandStyle do
    begin

  {set default values}
  Font.Name := 'TIMES NEW ROMAN';
  Font.Size := 8;
  Font.Color := clBlack;

  Line := False;
  LinePenWidth := 2;
  LinePenColor := clBlack;

  {set values based on band}
  if ((aBand is TppTitleBand) and (aBand.Report is TppChildReport)) or (aBand is TppHeaderBand) then
    begin
      Font.Size := 10;
      Font.Style := [fsBold];

      Line := True;
    end

  else if (aBand is TppTitleBand) then
    begin
      Font.Size := 24;
    end

  else if ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) or (aBand is TppFooterBand)  then
    begin
      Line := True;
      LinePenColor := clGray;
      LinePenWidth := 1;
    end

  else if (aBand is TppDetailBand) then
    begin
      {use defaults}
    end;

  end; {with, aBandStyle}

end; {procedure, SetStyleAttributes}

{------------------------------------------------------------------------------}
{ TppSoftGrayStyle.SetStyleAttributes }

procedure TppSoftGrayStyle.SetStyleAttributes(aBandStyle: TppBandStyle; aBand: TppBand);
begin

  with aBandStyle do
    begin

  {set default values}
  Font.Name := 'ARIAL';
  Font.Size := 9;
  Font.Color := clBlack;

  Line := False;
  LinePenWidth := 3;
  LinePenColor := clGray;

  {set values based on band}
  if ((aBand is TppTitleBand) and (aBand.Report is TppChildReport)) or (aBand is TppHeaderBand) then
    begin
      Font.Style := [fsBold];

      Line := True;
    end

  else if (aBand is TppTitleBand) then
    begin
      Color := clSilver;

      Font.Size := 24;
      Font.Style := [fsBold];
      Font.Color := clWhite;
    end

  else if ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) or (aBand is TppFooterBand)  then
    begin
      Color := clSilver;

      Font.Style := [fsBold];

      Line := True;
      LinePenWidth := 3;
    end

  else if (aBand is TppDetailBand) then
    begin
      Font.Name := 'TIMES NEW ROMAN';
      Font.Size := 11;
    end;

  end; {with, aBandStyle}

end; {procedure, SetStyleAttributes}


{******************************************************************************
 *
 ** L A Y O U T   C L A S S E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportLayout.Create }

constructor TppReportLayout.Create(aOwner: TComponent);
var
  liBand: Integer;
  liBands: Integer;
  lBand: TppBand;
  lBandLayout: TppBandLayout;
begin
  inherited Create(aOwner);

  FBandList := TList.Create;
  FBandLayoutList := TList.Create;
  FColumnHeaderBand := nil;
  FColumnHeaderTopOffset := 5;
  FGroupHeaders := False;
  FIndent := False;

  if not(aOwner is TppCustomReport) then Exit;

  FReport := TppCustomReport(aOwner);

  if (FReport = nil) then Exit;

  liBands := FReport.BandCount;

  for liBand := 0 to liBands - 1 do
    begin
      lBand := FReport.Bands[liBand];

      lBandLayout := TppBandLayout.Create(FReport);
      lBandLayout.LineStyle := llNone;

      SetLayoutAttributes(lBandLayout, lBand);

      AddBandLayout(lBand, lBandLayout);
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportLayout.Destroy }

destructor TppReportLayout.Destroy;
var
  liBandLayout: Integer;
  liBandLayouts: Integer;
begin
  liBandLayouts := FBandLayoutList.Count;

  for liBandLayout := 0 to liBandLayouts - 1 do
    TppBandLayout(FBandLayoutList[liBandLayout]).Free;

  FBandLayoutList.Free;
  FBandList.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{ TppReportLayout.SetLayoutAttributes }

procedure TppReportLayout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
begin

end;

{------------------------------------------------------------------------------}
{ TppReportLayout.AddBandLayout }

procedure TppReportLayout.AddBandLayout(aBand: TppBand; aBandLayout: TppBandLayout);
begin
  FBandList.Add(aBand);
  FBandLayoutList.Add(aBandLayout);
end;

{------------------------------------------------------------------------------}
{ TppReportLayout.LayoutForBand }

function TppReportLayout.LayoutForBand(aBand: TppBand): TppBandLayout;
var
  liIndex: Integer;
begin
  liIndex := FBandList.IndexOf(aBand);

  if (liIndex > -1) then
    Result := TppBandLayout(FBandLayoutList[liIndex])
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppReportLayout.Apply }

procedure TppReportLayout.Apply(aReport: TppCustomReport);
var
  liBands: Integer;
  liBand: Integer;
  lBand: TppBand;
  lBandLayout: TppBandLayout;
  liComponent: Integer;
  liComponents: Integer;
  lComponent: TppComponent;
  lLine: TppLine;
  lShape: TppShape;
  liMinTop: Integer;
  liMaxBottom: Integer;
  liMinLeft: Integer;
  liWidth: Integer;
begin

  liBands := aReport.BandCount;

  for liBand := 0 to liBands - 1 do
    begin

      lBand := aReport.Bands[liBand];

      lBandLayout := LayoutForBand(lBand);

      liComponents := lBand.ObjectCount;
      liMinTop    := lBand.spHeight;
      liMaxBottom := 0;
      liMinLeft   := lBand.spWidth;

      {calc component positions}
      for liComponent := 0 to liComponents - 1 do
        begin
          lComponent := lBand.Objects[liComponent];

          {calculate maxbottom, mintop and minleft for this row}
          if (lComponent.spTop + lComponent.spHeight) > liMaxBottom then
            liMaxBottom := lComponent.spTop + lComponent.spHeight;

          if (lComponent.spTop < liMinTop) then
            liMinTop := lComponent.spTop;

          if (lComponent.spLeft < liMinLeft) then
            liMinLeft := lComponent.spLeft;

        end; {for, each component}

    if (liMaxBottom > 0) then
      lBand.spHeight := liMaxBottom + 5
    else
      lBand.spHeight := 0;

    if lBandLayout.LineStyle = llFrameComponents then
      FrameComponents(lBand);

    if (lBand = FColumnHeaderBand) then
      liMinTop := FColumnHeaderTopOffset;

    liWidth := lBand.spWidth - liMinLeft - 5;

    {create formatting}
     case lBandLayout.LineStyle of

        llRail:
          begin
            lLine := TppLine(ppComponentCreate(aReport, TppLine));
            lLine.Band := lBand;
            lLine.Style := lsSingle;
            lLine.spWidth := liWidth;
            lLine.spTop := liMinTop;
            lLine.spLeft := liMinLeft;
            lLine.SendToBack;

            lLine := TppLine(ppComponentCreate(aReport, TppLine));
            lLine.Band := lBand;
            lLine.Style := lsSingle;
            lLine.spWidth := liWidth;
            lLine.spTop := liMaxBottom;
            lLine.spLeft := liMinLeft;
            lLine.SendToBack;
          end;

        llDoubleRail:
          begin
            lLine := TppLine(ppComponentCreate(aReport, TppLine));
            lLine.Band := lBand;
            lLine.Style := lsDouble;
            lLine.spWidth := liWidth;
            lLine.spTop := liMinTop;
            lLine.spLeft := liMinLeft;
            lLine.SendToBack;

            lLine := TppLine(ppComponentCreate(aReport, TppLine));
            lLine.Band := lBand;
            lLine.Style := lsDouble;
            lLine.spWidth := liWidth;
            lLine.spTop := liMaxBottom;
            lLine.spLeft := liMinLeft;
            lLine.SendToBack;
          end;

        llTop:
          begin
            lLine := TppLine(ppComponentCreate(aReport, TppLine));
            lLine.Band := lBand;
            lLine.Style := lsSingle;
            lLine.spWidth := liWidth;
            lLine.spTop := liMinTop;
            lLine.spLeft := liMinLeft;
            lLine.SendToBack;
          end;

        llBottom:
          begin
            lLine := TppLine(ppComponentCreate(aReport, TppLine));
            lLine.Band := lBand;
            lLine.Style := lsSingle;
            lLine.spWidth := liWidth;
            lLine.spTop := liMaxBottom;
            lLine.spLeft := liMinLeft;
            lLine.SendToBack;
          end;

        llFrame:
          begin
            lShape := TppShape(ppComponentCreate(aReport, TppShape));
            lShape.Band := lBand;
            lShape.spWidth := liWidth;
            lShape.spTop := liMinTop;
            lShape.spLeft := liMinLeft;
            lShape.spHeight := liMaxBottom - liMinTop;
            lShape.SendToBack;
          end;

      end; {case, LineStyle}

    end; {for, each band}

end; {procedure, Apply}

{------------------------------------------------------------------------------}
{ TppReportLayout.FrameComponents }

procedure TppReportLayout.FrameComponents(aBand: TppBand);
var
  liComponents: Integer;
  liComponent: Integer;
  lComponent: TppComponent;
  liRight: Integer;
  liNextLeft: Integer;
  liPreviousRight: Integer;
  lLeftToRight: TStringList;
  lShape: TppShape;
  lsTopLeft: String;
  liTop: Integer;
begin
  liNextLeft := 0;
  liPreviousRight := 0;

  liComponents := aBand.ObjectCount;

  lLeftToRight := TStringList.Create;

  {get component positions}
  for liComponent := 0 to liComponents - 1 do
    begin
      lComponent := aBand.Objects[liComponent];

      lsTopLeft := Format('%8d',[lComponent.spTop]) + Format('%8d',[lComponent.spLeft]);

      lLeftToRight.AddObject(lsTopLeft, lComponent);
    end;

  lLeftToRight.Sort;

  liTop := -1;

  {put shapes around each component}
  for liComponent := 0 to liComponents - 1 do
    begin
      lComponent := TppComponent(lLeftToRight.Objects[liComponent]);

      if liComponent <> liComponents - 1 then
        liNextLeft := TppComponent(lLeftToRight.Objects[liComponent + 1]).spLeft;

      if (liNextLeft < lComponent.spLeft) then
        liNextLeft := lComponent.spLeft + lComponent.spWidth + 2
      else if (liNextLeft = lComponent.spLeft) then
        liNextLeft := lComponent.spLeft + lComponent.spWidth + 4;

      if (lComponent.spTop <> liTop) then
        begin
          liPreviousRight := 2;
          liTop := lComponent.spTop;
        end;

      lShape := TppShape(ppComponentCreate(FReport, TppShape));
      lShape.Band := aBand;
      lShape.spTop := lComponent.spTop - 2;
      lShape.spHeight := lComponent.spHeight + 4;
      lShape.spLeft := liPreviousRight;
      liRight := lComponent.spLeft + lComponent.spWidth + ((liNextLeft - (lComponent.spLeft + lComponent.spWidth)) div 2);
      lShape.spWidth := (liRight - lShape.spLeft) + 1;
      lShape.SendToBack;

      liPreviousRight := liRight

    end; {for, each component}

  lLeftToRight.Free;

end; {procedure, FrameComponents}

{------------------------------------------------------------------------------}
{ TppTabularLayout.Create }

procedure TppTabularLayout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
begin

  GroupHeaders := False;
  Indent := False;

  if (aBand is TppTitleBand) and (aBand.Report is TppChildReport) then
    begin
      aBandLayout.LineStyle := llBottom;
      ColumnHeaderBand := aBand;
      ColumnHeaderTopOffset := 41;
    end

  else if (aBand is TppHeaderBand) then
    begin
      aBandLayout.LineStyle := llBottom;
      ColumnHeaderBand := aBand;
    end

  else if (aBand is TppDetailBand) then
    {do nothing}

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom;

end; {constructor, SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppVerticalLayout.Create }

procedure TppVerticalLayout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
begin
  GroupHeaders := False;
  Indent := False;

  if (aBand is TppTitleBand) and (aBand.Report is TppChildReport) then
    {do nothing}

  else if (aBand is TppHeaderBand) then
    {do nothing}

  else if (aBand is TppDetailBand) then
    begin
      aBandLayout.LineStyle := llTop;
      ColumnHeaderBand := aBand;
    end

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom;

end; {procedure SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppSteppedLayout.Create }

procedure TppSteppedLayout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
begin
  GroupHeaders := True;
  Indent := True;

  if (aBand is TppTitleBand) and (aBand.Report is TppChildReport) then
    begin
      aBandLayout.LineStyle := llRail;
      ColumnHeaderBand := aBand;
      ColumnHeaderTopOffset := 41;
    end

  else if (aBand is TppTitleBand) then
    aBandLayout.LineStyle := llTop

  else if (aBand is TppHeaderBand) then
    begin
      aBandLayout.LineStyle := llRail;
      ColumnHeaderBand := aBand;
    end

  else if (aBand is TppDetailBand) then
    {do nothing}

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom;

end; {procedure, SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppBlockLayout.Create }

procedure TppBlockLayout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
begin
  GroupHeaders := False;
  Indent := False;

  if (aBand is TppTitleBand) and (aBand.Report is TppChildReport) then
    begin
      aBandLayout.LineStyle := llRail;
      ColumnHeaderBand := aBand;
      ColumnHeaderTopOffset := 41;
    end

  else if (aBand is TppTitleBand) then
    aBandLayout.LineStyle := llTop

  else if (aBand is TppHeaderBand) then
    begin
      aBandLayout.LineStyle := llRail;
      ColumnHeaderBand := aBand;
    end

  else if (aBand is TppDetailBand) then
    aBandLayout.LineStyle := llFrameComponents

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom;

end; {procedure, SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppOutline1Layout.Create }

procedure TppOutline1Layout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
var
  liLastGroup: Integer;
begin
  GroupHeaders := True;
  Indent := True;

  if (aBand is TppTitleBand) then
    aBandLayout.LineStyle := llDoubleRail

  else if (aBand is TppHeaderBand) then
    {do nothing}

  else if (aBand is TppDetailBand) then
    {do nothing}

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom

  else if (aBand is TppGroupHeaderBand) then
    begin
      liLastGroup := FReport.GroupCount - 1;

      if (TppGroupHeaderBand(aBand).Group.GroupNo = liLastGroup) or (liLastGroup = 0) then
        begin
          aBandLayout.LineStyle := llRail;
          ColumnHeaderBand := aBand;
        end

      else if (TppGroupHeaderBand(aBand).Group.GroupNo = liLastGroup) then
        aBandLayout.LineStyle := llBottom;

    end;

end; {procedure, SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppOutline2Layout.Create }

procedure TppOutline2Layout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
var
  liLastGroup: Integer;
begin
  GroupHeaders := True;
  Indent := True;

  if (aBand is TppTitleBand) then
    aBandLayout.LineStyle := llRail

  else if (aBand is TppHeaderBand) then
    {do nothing}

  else if (aBand is TppDetailBand) then
    aBandLayout.LineStyle := llBottom

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom

  else if (aBand is TppGroupHeaderBand) then
    begin
      liLastGroup := FReport.GroupCount - 1;

      if (TppGroupHeaderBand(aBand).Group.GroupNo = liLastGroup) or (liLastGroup = 0) then
        begin
          aBandLayout.LineStyle := llTop;
          ColumnHeaderBand := aBand;
        end

      else if (TppGroupHeaderBand(aBand).Group.GroupNo = 0) then
        aBandLayout.LineStyle := llFrame;

    end;

end; {procedure, SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppAlignLeft1Layout.Create }

procedure TppAlignLeft1Layout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
var
  liLastGroup: Integer;
begin
  GroupHeaders := True;
  Indent := False;

  if (aBand is TppTitleBand) then
    aBandLayout.LineStyle := llDoubleRail

  else if (aBand is TppHeaderBand) then
    {do nothing}

  else if (aBand is TppDetailBand) then
    {do nothing}

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom

  else if (aBand is TppGroupHeaderBand) then
    begin
      liLastGroup := FReport.GroupCount - 1;

      if (TppGroupHeaderBand(aBand).Group.GroupNo = liLastGroup) or (liLastGroup = 0) then
        begin
          aBandLayout.LineStyle := llRail;
          ColumnHeaderBand := aBand;
        end

      else if (TppGroupHeaderBand(aBand).Group.GroupNo = 0) then
        aBandLayout.LineStyle := llBottom;

    end;

end; {procedure, SetLayoutAttributes}

{------------------------------------------------------------------------------}
{ TppAlignLeft2Layout.SetLayoutAttributes }

procedure TppAlignLeft2Layout.SetLayoutAttributes(aBandLayout: TppBandLayout; aBand: TppBand);
var
  liLastGroup: Integer;
begin
  GroupHeaders := True;
  Indent := False;

  if (aBand is TppTitleBand) then
    aBandLayout.LineStyle := llRail

  else if (aBand is TppHeaderBand) then
    {do nothing}

  else if (aBand is TppDetailBand) then
    aBandLayout.LineStyle := llBottom

  else if (aBand is TppFooterBand) or ((aBand is TppSummaryBand) and (aBand.Report is TppChildReport)) then
    aBandLayout.LineStyle := llBottom

  else if (aBand is TppGroupHeaderBand) then
    begin
      liLastGroup := FReport.GroupCount - 1;

      if (TppGroupHeaderBand(aBand).Group.GroupNo = liLastGroup) or (liLastGroup = 0) then
        begin
          aBandLayout.LineStyle := llTop;
          ColumnHeaderBand := aBand;
        end

      else if (TppGroupHeaderBand(aBand).Group.GroupNo = 0) then
        aBandLayout.LineStyle := llFrame;

    end;

end; {procedure, SetLayoutAttributes}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterDefaultReportWizard(TppReportWizard);
  ppRegisterDefaultBlankReportWizard(TppBlankReportWizard);

  {this is necessary to support the dynamic creation of these classes at run-time}
  RegisterClasses([TppBoldStyle, TppCasualStyle, TppCompactStyle, TppCorporateStyle,
                   TppFormalStyle, TppSoftGrayStyle,
                   TppTabularLayout, TppVerticalLayout, TppSteppedLayout, TppBlockLayout,
                   TppOutline1Layout, TppOutline2Layout, TppAlignLeft1Layout, TppAlignLeft2Layout]);

  gcLayoutFactory := TppLayoutFactory;

finalization
  gcLayoutFactory := nil;

  ppUnRegisterWizard(TppReportWizard);
  ppUnRegisterWizard(TppBlankReportWizard);

  UnRegisterClasses([TppBoldStyle, TppCasualStyle, TppCompactStyle, TppCorporateStyle,
                     TppFormalStyle, TppSoftGrayStyle,
                     TppTabularLayout, TppVerticalLayout, TppSteppedLayout, TppBlockLayout,
                     TppOutline1Layout, TppOutline2Layout, TppAlignLeft1Layout, TppAlignLeft2Layout]);

end.
