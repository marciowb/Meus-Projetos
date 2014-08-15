{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignToolActions;

interface

uses
  Windows,
  TypInfo,
  SysUtils,
  Classes,
  Controls,
  Graphics,
  ActnList,

  ppTypes,
  ppUtils,
  ppRTTI,
  ppUndo,
  ppCollectionBase,
  ppClass,
  ppDB,
  ppPrintr,

  ppDesignObserver,
  ppToolResources,
  ppDesignSelectionController,
  ppDesignControllers,
  ppDesignEventHub,
  ppIniStorage;

type

   {DesignToolActionManager
      - ActionLists[]
          - Action

      - DesignControllers
   }


  TppStandardActionType = (saNew, saOpen, saSave, saPageSetup, saPrint, saPreview, saCut, saCopy, saPaste);

  TppDesignToolActionListCollection = class;
  TppAlignActionList = class;
  TppDrawActionList = class;
  TppEditActionList = class;
  TppNudgeActionList = class;
  TppSizeActionList = class;
  TppStandardActionList = class;
  TppFormatActionList = class;


  {TppDesignToolActionManager}
  TppDesignToolActionManager = class(TppDesignObserver)
  private
    FActionLists: TppDesignToolActionListCollection;
    FAlignActions: TppAlignActionList;
    FDesignControllers: TppDesignControllers;
    FDrawActions: TppDrawActionList;
    FEditActions: TppEditActionList;
    FFormatActions: TppFormatActionList;
    FNudgeActions: TppNudgeActionList;
    FSizeActions: TppSizeActionList;
    FStandardActions: TppStandardActionList;

    procedure SetDesignControllers(const Value: TppDesignControllers);

  protected
    procedure SetReport(const Value: TppCustomReport); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure LanguageChanged; virtual;
    procedure LoadPreferences(aIniStorage: TppIniStorage);
    procedure SavePreferences(aIniStorage: TppIniStorage);
    procedure SelectionChanged;

    property ActionLists: TppDesignToolActionListCollection read FActionLists;

    property AlignActions: TppAlignActionList read FAlignActions;
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
    property DrawActions: TppDrawActionList read FDrawActions;
    property EditActions: TppEditActionList read FEditActions;
    property FormatActions: TppFormatActionList read FFormatActions;
    property NudgeActions: TppNudgeActionList read FNudgeActions;
    property SizeActions: TppSizeActionList read FSizeActions;
    property StandardActions: TppStandardActionList read FStandardActions;


  end;


  {TppDesignToolAction}
  TppDesignToolAction = class(TCustomAction)
  private
    FDesignControllers: TppDesignControllers;
    FEventHub: TppDesignEventHub;
    FReport: TppCustomReport;
    FIsUpdating: Boolean;

    function GetSelectionController: TppDesignSelectionController;

  protected
    procedure ehSelection_AfterChange(Sender, aEventParams: TObject);
    procedure SetDesignControllers(const Value: TppDesignControllers); virtual;
    procedure SetEventHub(aEventHub: TppDesignEventHub); virtual;
    procedure SetReport(const Value: TppCustomReport); virtual;
    
    procedure UpdateClients(aPropName: String; aPropValue: Variant); overload;
    procedure UpdateClients(aPropName: String; aPropValue: TObject); overload;

    property SelectionController: TppDesignSelectionController read GetSelectionController;
    property IsUpdating: Boolean read FIsUpdating write FIsUpdating;

  public
    constructor Create(aOwner: TComponent); override;
    procedure LanguageChanged; virtual;
    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;
    procedure SelectionChanged; virtual;
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
    property Report: TppCustomReport read FReport write SetReport;

  end;

  IppDesignToolActionLink = interface(IInterface)
  ['{AB36ADEC-E5C6-4753-A324-26E3E53F8284}']
    procedure UpdateClient(aPropName: String; aPropValue: Variant); overload;
    procedure UpdateClient(aPropName: String; aPropValue: TObject); overload;
  end;


  {TppDesignToolActionList}
  TppDesignToolActionList = class(TActionList)
  private
    FDesignControllers: TppDesignControllers;
    FReport: TppCustomReport;
    
    function GetSelectionController: TppDesignSelectionController;
    procedure SetDesignControllers(const Value: TppDesignControllers);
    procedure SetReport(const Value: TppCustomReport);

  protected
    property SelectionController: TppDesignSelectionController read GetSelectionController;

  public
    function GetActionForName(aActionName: String): TContainedAction;
    function IndexOfAction(aActionName: String): Integer;
    procedure LanguageChanged; virtual;
    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;
    procedure SelectionChanged; virtual;
    
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
    property Report: TppCustomReport read FReport write SetReport;

  end;

  TppDesignToolActionListClass = class of TppDesignToolActionList;

  {TppDesignToolActionListCollection}
  TppDesignToolActionListCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppDesignToolActionList;
    function GetItemForName(aName: String): TppDesignToolActionList;
  public
    function Add(aObject: TppDesignToolActionList): Integer;
    function IndexOf(aName: String): Integer; overload;
    function IndexOf(aObject: TppDesignToolActionList): Integer; overload;
    procedure Insert(aIndex: Integer; aObject: TppDesignToolActionList);
    procedure Remove(aObject: TppDesignToolActionList);
    property Items[Index: Integer]: TppDesignToolActionList read GetItemForIndex; default;
    property ItemsByName[Name: String]: TppDesignToolActionList read GetItemForName;
  end;

  {TppDesignToolActionListClassCollection}
  TppDesignToolActionListClassCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppDesignToolActionListClass;

  public
    function IndexOf(aClass: TppDesignToolActionListClass): Integer;
    procedure Add(aClass: TppDesignToolActionListClass);
    procedure Remove(aClass: TppDesignToolActionListClass);

    property Items[Index: Integer]: TppDesignToolActionListClass read GetItemForIndex; default;

  end;

  {TppNudgeAction}
  TppNudgeAction = class(TppDesignToolAction)
  private
    FDirection: TppDirectionType;

    procedure SetDirection(const Value: TppDirectionType);

  protected
    procedure UpdateHint;
    procedure UpdateImage;

  public
    procedure LanguageChanged; override;

    function Execute: Boolean; override;

    property Direction: TppDirectionType read FDirection write SetDirection;
  end;


  {TppNugdeActionList}
  TppNudgeActionList = class(TppDesignToolActionList)
  private
  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;

  end;

  {TppAlignAction}
  TppAlignAction = class(TppDesignToolAction)
  private
    FAlignType: TppAlignType;

    procedure SetAlignType(const Value: TppAlignType);

  protected
    procedure UpdateHint;
    procedure UpdateImage;

  public
    procedure LanguageChanged; override;

    function Execute: Boolean; override;

    property AlignType: TppAlignType read FAlignType write SetAlignType;
  end;

  {TppAlignActionList}
  TppAlignActionList = class(TppDesignToolActionList)
  private

  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;

  end;

  {TppSizeAction}
  TppSizeAction = class(TppDesignToolAction)
  private
    FSizeType: TppSizeType;

    procedure SetSizeType(const Value: TppSizeType);

  protected
    procedure UpdateHint;
    procedure UpdateImage;

  public
    procedure LanguageChanged; override;

    function Execute: Boolean; override;

    property SizeType: TppSizeType read FSizeType write SetSizeType;
  end;

  {TppSizeActionList}
  TppSizeActionList = class(TppDesignToolActionList)
  private

  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;

  end;

  TppColorAction = class;
  TppGradientAction = class;

  {TppDrawActionList}
  TppDrawActionList = class(TppDesignToolActionList)
  private
    FFillColorAction: TppColorAction;
    FGradientAction: TppGradientAction;
    FLineColorAction: TppColorAction;

  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;

    procedure LoadPreferences(aIniStorage: TppIniStorage); override;
    procedure SavePreferences(aIniStorage: TppIniStorage); override;

  end;

  TppFontNameAction = class;
  TppFontSizeAction = class;

  {TppFormatActionList}
  TppFormatActionList = class(TppDesignToolActionList)
  private
    FFontColorAction: TppColorAction;
    FFontNameAction: TppFontNameAction;
    FFontSizeAction: TppFontSizeAction;
    FHighlightColorAction: TppColorAction;

  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;

    procedure LoadPreferences(aIniStorage: TppIniStorage); override;
    procedure SavePreferences(aIniStorage: TppIniStorage); override;

  end;


  {TppStandardActionList}
  TppStandardActionList = class(TppDesignToolActionList)
  private

  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;

  end;

  TppDefaultPropValueListAction = class;
  TppDefaultPropValueList2Action = class;

  {TppEditActionList}
  TppEditActionList = class(TppDesignToolActionList)
  private
    FComboBoxAction: TppDefaultPropValueListAction;
    FComboBoxAction2: TppDefaultPropValueList2Action;

  protected
    procedure CreateActions;

  public
    constructor Create(aOwner: TComponent); override;
    procedure InitializeValueLists;

  end;


  {TppColorAction}
  TppColorAction = class(TppDesignToolAction)
  private
    FColor: TColor;
    FColorType: TppColorButtonType;
    FIsClear: Boolean;
    FOnExecuteAction: TNotifyEvent;

    function GetImageName: String;
    function GetImageMaskName: String;
    procedure ReplaceButtonImage(aColor: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetColorType(const Value: TppColorButtonType);
    procedure SetIsClear(const Value: Boolean);

  protected
    procedure UpdateHint;
    procedure UpdateImage;

  public
    procedure LanguageChanged; override;

    function Execute: Boolean; override;
    procedure SelectionChanged; override;

    property Color: TColor read FColor write SetColor;
    property ColorType: TppColorButtonType read FColorType write SetColorType;
    property IsClear: Boolean read FIsClear write SetIsClear;

    property OnExecuteAction: TNotifyEvent read FOnExecuteAction write FOnExecuteAction;
    
  end;

  {TppLineStyleAction}
  TppLineStyleAction = class(TppDesignToolAction)
  private
    FLineStyle: TPenStyle;

    procedure SetLineStyle(aLineStyle: TPenStyle);
    
  protected
    procedure UpdateImage;

  public
    constructor Create(aOwner: TComponent);  override;

    function Execute: Boolean; override;
    
    procedure SelectionChanged; override;

    property LineStyle: TPenStyle read FLineStyle write SetLineStyle;

  end;

  {TppLineThicknessAction}
  TppLineThicknessAction = class(TppDesignToolAction)
  private
    FDoubleLines: Boolean;
    FLineStyle: TppLineStyleType;
    FLineThickness: Single;

    procedure SetDoubleLines(const Value: Boolean);
    procedure SetLineStyle(aLineStyle: TppLineStyleType);
    procedure SetLineThickness(aLineThickness: Single);

  protected
    procedure SetReport(const Value: TppCustomReport); override;
    procedure UpdateImage;

  public
    constructor Create(aOwner: TComponent); override;
    function Execute: Boolean; override;
    procedure SelectionChanged; override;

  published
    property DoubleLines: Boolean read FDoubleLines write SetDoubleLines;
    property LineStyle: TppLineStyleType read FLineStyle write SetLineStyle;
    property LineThickness: Single read FLineThickness write SetLineThickness;
    
  end;

  {TppEditTextAction}
  TppEditTextAction = class(TppDesignToolAction)
  private
    FText: String;

    procedure SetText(const Value: String);

  public
  published
    property Text: String read FText write SetText;

  end;

  {TppComboBoxAction}
  TppComboBoxAction = class(TppEditTextAction)
  private
    FItems: TStringList;

  protected
    function GetItems: TStrings; virtual;
    procedure SetItems(const Value: TStrings); virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Items: TStrings read GetItems write SetItems;

  end;

  {TppDefaultPropEditAction}
  TppDefaultPropEditAction = class(TppEditTextAction)
  private
    FDefaultComponent: TppComponent;
  public
    function Execute: Boolean; override;
    procedure LanguageChanged; override;
    procedure SelectionChanged; override;
  end;
          
  {TppDefaultPropValueListAction}
  TppDefaultPropValueListAction = class(TppComboBoxAction)
  private
    FDefaultComponent: TppComponent;
  protected
    procedure InitializeValueList;
  public
    function Execute: Boolean; override;
    procedure LanguageChanged; override;
    procedure SelectionChanged; override;

  end;


  {TppFontNameAction}
  TppFontNameAction = class(TppEditTextAction)
  private
    FItems: TppFontList;
    FFont: TFont;

  protected
    function GetItems: TppFontList; virtual;
    function GetFontCharset(aFontName: String): TFontCharset;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function Execute: Boolean; override;
    procedure SelectionChanged; override;

  published
    property Items: TppFontList read GetItems;

  end;

  {TppFontSizeAction}
  TppFontSizeAction = class(TppComboBoxAction)
  protected
    procedure InitializeItemsList(aList: TStrings); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    function Execute: Boolean; override;
    procedure SelectionChanged; override;
  end;

  {TppStandardAction}
  TppStandardAction = class(TppDesignToolAction)
  private
    FActionType: TppStandardActionType;

    procedure SetActionType(const Value: TppStandardActionType);

  protected
    procedure UpdateImage;

  public
    function Execute: Boolean; override;

    procedure LanguageChanged; override;
    property ActionType: TppStandardActionType read FActionType write SetActionType;

  end;


  {TppTextAlignmentAction}
  TppTextAlignmentAction = class(TppDesignToolAction)  
  private
    FTextAlignment: TppTextAlignment;

    procedure SetTextAlignment(const Value: TppTextAlignment);

  protected
    procedure UpdateImage;

  public
    function Execute: Boolean; override;
    
    procedure LanguageChanged; override;
    procedure SelectionChanged; override;

  published
    property TextAlignment: TppTextAlignment read FTextAlignment write SetTextAlignment;
  end;
 
  {TppFontStyleAction}
  TppFontStyleAction = class(TppDesignToolAction)
  private
    FFontStyle: TFontStyle;

    procedure SetFontStyle(const Value: TFontStyle);

  protected
    procedure UpdateImage;

  public
    function Execute: Boolean; override;
    
    procedure LanguageChanged; override;
    procedure SelectionChanged; override;

  published
    property FontStyle: TFontStyle read FFontStyle write SetFontStyle;

  end;

  {TppAnchorAction}
  TppAnchorAction = class(TppDesignToolAction)
  private
    FAnchors: TppAnchors;

    procedure SetAnchors(const Value: TppAnchors);

  protected
  public
    constructor Create(aOwner: TComponent); override;

    function Execute: Boolean; override;
    
    procedure SelectionChanged; override;

  published
    property Anchors: TppAnchors read FAnchors write SetAnchors;

  end;

  {TppBorderAction}
  TppBorderAction = class(TppDesignToolAction)
  private
    FBorderPositions: TppBorderPositions;

    procedure SetBorderPositions(const Value: TppBorderPositions);

  protected
  public
    constructor Create(aOwner: TComponent); override;

    function Execute: Boolean; override;
    
    procedure SelectionChanged; override;

  published
    property BorderPositions: TppBorderPositions read FBorderPositions write SetBorderPositions;

  end;

  TppZOrderType = (zoBringForward, zoBringToFront, zoSendBackward, zoSendToBack);

  {TppZOrderAction}
  TppZOrderAction = class(TppDesignToolAction)
  private
    FZOrderType: TppZOrderType;

    procedure SetZOrderType(const Value: TppZOrderType);

  protected
    procedure UpdateImage;
  public
    constructor Create(aOwner: TComponent); override;

    function Execute: Boolean; override;
    procedure LanguageChanged; override;

  published
    property ZOrderType: TppZOrderType read FZOrderType write SetZOrderType;

  end;

  {TppDefaultPropValueListAction}
  TppDefaultPropValueList2Action = class(TppComboBoxAction)
  private
    FDefaultComponent: TppComponent;
  protected
    procedure InitializeValueList;
  public
    function Execute: Boolean; override;
    procedure LanguageChanged; override;
    procedure SelectionChanged; override;

  end;

  {TppDesignToolColors
    - provides a set of gobal custom colors that can be used by the color palettes }
  TppDesignToolColors = class
  public
    class function GetCustomColors: TStrings;
    class procedure LoadPreferences(aIniStorage: TppIniStorage);
    class procedure SavePreferences(aIniStorage: TppIniStorage);
    class procedure SetCustomColors(aCustomColors: TStrings);
  end;


   {TppGradientAction}
   TppGradientAction = class(TppDesignToolAction)
   private
     FGradient: TppGradient;

     procedure ReplaceButtonImage;
     procedure SetGradient(Value: TppGradient);

   protected
     procedure ehGradient_Change(Sender: TObject);
   public
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;

     function Execute: Boolean; override;
     procedure SelectionChanged; override;

   published
     property Gradient: TppGradient read FGradient write SetGradient;

   end;

implementation

var
  uCustomColors: TStringList;


function TppNudgeAction.Execute: Boolean;
begin

  if (SelectionController <> nil) then
    SelectionController.Nudge(FDirection);

  Result := True;

end;

procedure TppNudgeAction.LanguageChanged;
begin
  UpdateHint();
end;

procedure TppNudgeAction.SetDirection(const Value: TppDirectionType);
begin

  FDirection := Value;

  UpdateHint();
  UpdateImage();


end;

procedure TppNudgeAction.UpdateHint;
var
  liHintId: Integer;
begin
  liHintId := cNudgeHints[Ord(FDirection)];

  Hint := ppLoadStr(liHintId);

end;

procedure TppNudgeAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cNudgeResNames[Ord(FDirection)];

  ImageIndex := ToolImageList.AddTool(lsImageName);

end;


{******************************************************************************
 *
 **  Anchor Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAnchorBoxAction.Create}

constructor TppDesignToolAction.Create(aOwner: TComponent);
begin
  inherited;

  Enabled := False;

end;

procedure TppDesignToolAction.ehSelection_AfterChange(Sender, aEventParams: TObject);
begin
  SelectionChanged();
end;

function TppDesignToolAction.GetSelectionController: TppDesignSelectionController;
begin
  if (FDesignControllers <> nil) then
    Result := FDesignControllers.SelectionController
  else
    Result := nil;
end;

procedure TppDesignToolAction.LanguageChanged;
begin
  // update lang strings
end;

{------------------------------------------------------------------------------}
{ TppDesignToolAction.LoadPreferences}

procedure TppDesignToolAction.LoadPreferences(aIniStorage: TppIniStorage);
begin
  // descendants can add code here
end;

{------------------------------------------------------------------------------}
{ TppDesignToolAction.SavePreferences}

procedure TppDesignToolAction.SavePreferences(aIniStorage: TppIniStorage);
begin
  // descendants can add code here

end;

{------------------------------------------------------------------------------}
{TppDesignControllerBase.SelectionChanged}

procedure TppDesignToolAction.SelectionChanged;
begin
  // update status
end;

{------------------------------------------------------------------------------}
{TppDesignControllerBase.SetDesignControllers}

procedure TppDesignToolAction.SetDesignControllers(const Value: TppDesignControllers);
begin
  if FDesignControllers <> Value then
  begin
    FDesignControllers := Value;
  end;
end;

{------------------------------------------------------------------------------}
{TppDesignControllerBase.SetEventHub}

procedure TppDesignToolAction.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub <> nil) and not(csDestroying in FEventHub.ComponentState)  then
    begin
      FEventHub.SelectionEvents.mcAfterChange.RemoveNotify(ehSelection_AfterChange);
      FEventHub.ComponentEvents.mcAfterPropertyChange.RemoveNotify(ehSelection_AfterChange);
    end;

  FEventHub := aEventHub;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcAfterChange.AddNotify(ehSelection_AfterChange);
      FEventHub.ComponentEvents.mcAfterPropertyChange.AddNotify(ehSelection_AfterChange);
    end;

end;

{------------------------------------------------------------------------------}
{TppDesignControllerBase.SetReport}

procedure TppDesignToolAction.SetReport(const Value: TppCustomReport);
begin

  if (FReport <> Value) then
    begin
      FReport := Value;

      if (FReport <> nil) then
        FReport.FreeNotification(Self);

      if (FReport <> nil) and (FReport.MainReport <> nil) and (FReport.MainReport.DesignEventHub <> nil) then
        SetEventHub(TppDesignEventHub(FReport.MainReport.DesignEventHub))
      else
        SetEventHub(nil);

      Enabled := (FReport <> nil);

      UpdateClients('Enabled', Enabled);

    end;

end;

procedure TppDesignToolAction.UpdateClients(aPropName: String; aPropValue: Variant);
var
  liIndex: Integer;
  lIActionLink: IppDesignToolActionLink;
begin

  for liIndex := 0 to FClients.Count-1 do
    begin
      TComponent(FClients[liIndex]).GetInterface(IppDesignToolActionLink, lIActionLink);

      if (lIActionLink <> nil) then
       lIActionLink.UpdateClient(aPropName, aPropValue);

      Change;
    end;

end;

procedure TppDesignToolAction.UpdateClients(aPropName: String; aPropValue: TObject);
var
  liIndex: Integer;
  lIActionLink: IppDesignToolActionLink;
begin

  for liIndex := 0 to FClients.Count-1 do
    begin
      TComponent(FClients[liIndex]).GetInterface(IppDesignToolActionLink, lIActionLink);

      if (lIActionLink <> nil) then
       lIActionLink.UpdateClient(aPropName, aPropValue);

      Change;
    end;

end;


function TppDesignToolActionList.GetActionForName(aActionName: String):
    TContainedAction;
var
  liIndex: Integer;
begin

  liIndex := IndexOfAction(aActionName);

  if (liIndex >= 0) then
    Result :=  Actions[liIndex]
  else
    Result := nil;


end;

function TppDesignToolActionList.GetSelectionController: TppDesignSelectionController;
begin

  if (FDesignControllers <> nil) then
    Result := FDesignControllers.SelectionController
  else
    Result := nil;

end;

function TppDesignToolActionList.IndexOfAction(aActionName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < ActionCount) do
    if (Actions[liIndex].Name = aActionName) then
      lbFound := True
    else
      Inc(liIndex);

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{ TppDesignToolActionList }

procedure TppDesignToolActionList.LanguageChanged;
var
  liIndex: Integer;
begin

  for liIndex := 0 to ActionCount-1 do
    if (Actions[liIndex] is TppDesignToolAction) then
      TppDesignToolAction(Actions[liIndex]).LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppDesignToolActionList.LoadPreferences}

procedure TppDesignToolActionList.LoadPreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

  for liIndex := 0 to ActionCount-1 do
    if (Actions[liIndex] is TppDesignToolAction) then
      TppDesignToolAction(Actions[liIndex]).LoadPreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolActionList.SavePreferences}

procedure TppDesignToolActionList.SavePreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

  for liIndex := 0 to ActionCount-1 do
    if (Actions[liIndex] is TppDesignToolAction) then
      TppDesignToolAction(Actions[liIndex]).SavePreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolActionList.SelectionChanged}

procedure TppDesignToolActionList.SelectionChanged;
var
  liIndex: Integer;
begin

  for liIndex := 0 to ActionCount-1 do
    if (Actions[liIndex] is TppDesignToolAction) then
      TppDesignToolAction(Actions[liIndex]).SelectionChanged();
      
end;

procedure TppDesignToolActionList.SetDesignControllers(const Value: TppDesignControllers);
var
  liIndex: Integer;
begin

  if FDesignControllers <> Value then
    begin
      FDesignControllers := Value;

      for liIndex := 0 to ActionCount-1 do
        if (Actions[liIndex] is TppDesignToolAction) then
          TppDesignToolAction(Actions[liIndex]).DesignControllers := FDesignControllers;

    end;

end;

procedure TppDesignToolActionList.SetReport(const Value: TppCustomReport);
var
  liIndex: Integer;
begin

  if (FReport <> Value) then
    begin
      FReport := Value;
       for liIndex := 0 to ActionCount-1 do
          if (Actions[liIndex] is TppDesignToolAction) then
            TppDesignToolAction(Actions[liIndex]).Report := Value;
    end;

end;

constructor TppNudgeActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Nudge'; // do not localize

  Images := ToolImageList;

  CreateActions;

end;

procedure TppNudgeActionList.CreateActions;
var
  lDirection: TppDirectionType;
  lAction: TppNudgeAction;
begin

  for lDirection := Low(TppDirectionType) to High(TppDirectionType) do
    begin
      lAction := TppNudgeAction.Create(nil);
      lAction.Direction := lDirection;
      lAction.Name := cNudgeItemNames[Ord(lDirection)];
      lAction.ActionList := Self;
    end;

end;

{******************************************************************************
 *
 **  D e s i g n   T o o l   A c t i o n   L i s t   C o l l e c t i o n
 *
{******************************************************************************}

{ TppDesignToolActionListCollection }

function TppDesignToolActionListCollection.Add(aObject: TppDesignToolActionList): Integer;
begin
  Result := InnerList.Add(aObject);
end;

function TppDesignToolActionListCollection.GetItemForIndex(aIndex: Integer): TppDesignToolActionList;
begin
  Result := TppDesignToolActionList(InnerList[aIndex]);
end;

function TppDesignToolActionListCollection.GetItemForName(aName: String): TppDesignToolActionList;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aName);

  if liIndex >= 0 then
    Result := Items[liIndex]
  else
    Result := nil;

end;

function TppDesignToolActionListCollection.IndexOf(aName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < Count) do
    begin
      if (Items[liIndex].Name = aName) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1

end;

function TppDesignToolActionListCollection.IndexOf(aObject: TppDesignToolActionList): Integer;
begin
  Result := InnerList.IndexOf(aObject);
end;

procedure TppDesignToolActionListCollection.Insert(aIndex: Integer; aObject: TppDesignToolActionList);
begin
  InnerList.Insert(aIndex, aObject);

end;

procedure TppDesignToolActionListCollection.Remove(aObject: TppDesignToolActionList);
begin
  InnerList.Remove(aObject);
end;

{******************************************************************************
 *
 **  T o o l b a r   C l a s s  C o l l e c t i o n
 *
{******************************************************************************}


{ TppToolbarClassCollection }

procedure TppDesignToolActionListClassCollection.Add(aClass: TppDesignToolActionListClass);
begin
  InnerList.Add(TObject(aClass))
end;

function TppDesignToolActionListClassCollection.GetItemForIndex(aIndex: Integer): TppDesignToolActionListClass;
begin
  Result :=  TppDesignToolActionListClass(InnerList[aIndex]);

end;

function TppDesignToolActionListClassCollection.IndexOf(aClass: TppDesignToolActionListClass): Integer;
begin
  Result := InnerList.IndexOf(TObject(aClass));
end;

procedure TppDesignToolActionListClassCollection.Remove(aClass: TppDesignToolActionListClass);
begin
  InnerList.Remove(TObject(aClass));

end;

constructor TppDesignToolActionManager.Create(aOwner: TComponent);
begin
  inherited;

  FActionLists := TppDesignToolActionListCollection.Create;

  FAlignActions := TppAlignActionList.Create(nil);
  FDrawActions  := TppDrawActionList.Create(nil);
  FEditActions  := TppEditActionList.Create(nil);
  FFormatActions := TppFormatActionList.Create(nil);
  FNudgeActions := TppNudgeActionList.Create(nil);
  FSizeActions  := TppSizeActionList.Create(nil);
  FStandardActions := TppStandardActionList.Create(nil);


  FActionLists.Add(FAlignActions);
  FActionLists.Add(FDrawActions);
  FActionLists.Add(FEditActions);
  FActionLists.Add(FFormatActions);
  FActionLists.Add(FNudgeActions);
  FActionLists.Add(FSizeActions);
  FActionLists.Add(FStandardActions);

end;

destructor TppDesignToolActionManager.Destroy;
begin

  FActionLists.Remove(FAlignActions);
  FActionLists.Remove(FDrawActions);
  FActionLists.Remove(FEditActions);
  FActionLists.Remove(FFormatActions);
  FActionLists.Remove(FNudgeActions);
  FActionLists.Remove(FSizeActions);
  FActionLists.Remove(FStandardActions);

  FAlignActions.Free;
  FAlignActions := nil;

  FDrawActions.Free;
  FDrawActions := nil;

  FEditActions.Free;
  FEditActions := nil;

  FFormatActions.Free;
  FFormatActions := nil;

  FNudgeActions.Free;
  FNudgeActions := nil;

  FSizeActions.Free;
  FSizeActions := nil;

  FStandardActions.Free;
  FStandardActions := nil;

  FActionLists.Free;
  FActionLists := nil;


  inherited;

end;


procedure TppDesignToolActionManager.LanguageChanged;
var
  liIndex: Integer;
begin
  for liIndex := 0 to FActionLists.Count-1 do
    FActionLists[liIndex].LanguageChanged;

end;

{------------------------------------------------------------------------------}
{ TppToolbarManager.LoadToolbarPreferences}

procedure TppDesignToolActionManager.LoadPreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

  TppDesignToolColors.LoadPreferences(aIniStorage);

  for liIndex := 0 to FActionLists.Count-1 do
    FActionLists[liIndex].LoadPreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppToolbarManager.SaveToolbarPreferences}

procedure TppDesignToolActionManager.SavePreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

  for liIndex := 0 to FActionLists.Count-1 do
    FActionLists[liIndex].SavePreferences(aIniStorage);

  TppDesignToolColors.SavePreferences(aIniStorage);

end;  {procedure, SaveToolbarPreferences}

procedure TppDesignToolActionManager.SelectionChanged;
var
  liIndex: Integer;
begin
  for liIndex := 0 to FActionLists.Count-1 do
    FActionLists[liIndex].SelectionChanged;

end;

procedure TppDesignToolActionManager.SetDesignControllers(const Value: TppDesignControllers);
var
  liIndex: Integer;
begin
  if FDesignControllers <> Value then
    begin
      FDesignControllers := Value;
      for liIndex := 0 to FActionLists.Count-1 do
        FActionLists[liIndex].DesignControllers := FDesignControllers;
    end;
end;

procedure TppDesignToolActionManager.SetReport(const Value: TppCustomReport);
var
  liIndex: Integer;
begin

  if Report <> Value then
    begin
      for liIndex := 0 to FActionLists.Count-1 do
        FActionLists[liIndex].Report := Value;

    end;

  inherited;

end;

function TppAlignAction.Execute: Boolean;
begin

  SelectionController.Align(FAlignType);

  Result := True;

end;

procedure TppAlignAction.LanguageChanged;
begin
  UpdateHint();
end;

procedure TppAlignAction.SetAlignType(const Value: TppAlignType);
begin

  FAlignType := Value;

  UpdateHint();
  UpdateImage();


end;

procedure TppAlignAction.UpdateHint;
var
  liHintId: Integer;
begin
  liHintId := cAlignHints[Ord(FAlignType)];

  Hint := ppLoadStr(liHintId);

end;

procedure TppAlignAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cAlignResNames[Ord(FAlignType)];

  ImageIndex := ToolImageList.AddTool(lsImageName);

end;

constructor TppAlignActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Align'; // do not localize

  Images := ToolImageList;

  CreateActions;

end;

procedure TppAlignActionList.CreateActions;
var
  lAlignType: TppAlignType;
  lAction: TppAlignAction;
begin

  for lAlignType := Low(TppAlignType) to High(TppAlignType) do
    begin
      lAction := TppAlignAction.Create(nil);
      lAction.AlignType := lAlignType;
      lAction.Name := cAlignNames[Ord(lAlignType)];
      lAction.ActionList := Self;
    end;

end;

function TppSizeAction.Execute: Boolean;
begin

  SelectionController.Size(FSizeType);

  Result := True;

end;

procedure TppSizeAction.LanguageChanged;
begin
  UpdateHint();
end;

procedure TppSizeAction.SetSizeType(const Value: TppSizeType);
begin

  FSizeType := Value;

  UpdateHint();
  UpdateImage();


end;

procedure TppSizeAction.UpdateHint;
var
  liHintId: Integer;
begin
  liHintId := cSizeHints[Ord(FSizeType)];

  Hint := ppLoadStr(liHintId);

end;

procedure TppSizeAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cSizeResNames[Ord(FSizeType)];

  ImageIndex := ToolImageList.AddTool(lsImageName);

end;

constructor TppSizeActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Size';  // do not localize

  Images := ToolImageList;

  CreateActions;

end;

procedure TppSizeActionList.CreateActions;
var
  lSizeType: TppSizeType;
  lAction: TppSizeAction;
begin

  for lSizeType := Low(TppSizeType) to High(TppSizeType) do
    begin
      lAction := TppSizeAction.Create(nil);
      lAction.SizeType := lSizeType;
      lAction.Name := cSizeNames[Ord(lSizeType)];
      lAction.ActionList := Self;
    end;

end;


constructor TppStandardActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Standard';  // do not localize

  Images := ToolImageList;

  CreateActions;

end;

procedure TppStandardActionList.CreateActions;
var
  lActionType: TppStandardActionType;
  lAction: TppStandardAction;
begin

  for lActionType := Low(TppStandardActionType) to High(TppStandardActionType) do
    begin
      lAction := TppStandardAction.Create(nil);
      lAction.ActionType := lActionType;
      lAction.Name := cStandardItemNames[Ord(lActionType)];
      lAction.ActionList := Self;
    end;

end;



constructor TppDrawActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Draw';  // do not localize

  Images := ToolImageList;

  CreateActions;

end;

procedure TppDrawActionList.CreateActions;
var
  lLineStyleAction: TppLineStyleAction;
  lLineThicknessAction: TppLineThicknessAction;
begin

  FFillColorAction := TppColorAction.Create(nil);
  FFillColorAction.Name := cColorItemNames[Ord(ctFill)];
  FFillColorAction.ColorType := ctFill;
  FFillColorAction.ActionList := Self;

  FLineColorAction := TppColorAction.Create(nil);
  FLineColorAction.Name := cColorItemNames[Ord(ctLine)];
  FLineColorAction.ColorType := ctLine;
  FLineColorAction.ActionList := Self;

  lLineStyleAction := TppLineStyleAction.Create(nil);;
  lLineStyleAction.Name := 'LineStyle';  // do not localize
  lLineStyleAction.ActionList := Self;

  lLineThicknessAction := TppLineThicknessAction.Create(nil);;
  lLineThicknessAction.Name := 'LineThickness'; // do not localize
  lLineThicknessAction.ActionList := Self;

  FGradientAction := TppGradientAction.Create(nil);
  FGradientAction.Name := 'Gradient';
  FGradientAction.ActionList := Self;


end;

{------------------------------------------------------------------------------}
{ TppDrawActionList.LoadPreferences}

procedure TppDrawActionList.LoadPreferences(aIniStorage: TppIniStorage);
begin

  inherited;

  FGradientAction.Gradient.Style := TppGradientStyle(aIniStorage.ReadInteger('Draw', 'GradientStyle', Ord(gsHorizontal)));
  FGradientAction.Gradient.StartColor := aIniStorage.ReadInteger('Draw', 'GradientStartColor', clWhite);
  FGradientAction.Gradient.EndColor := aIniStorage.ReadInteger('Draw', 'GradientEndColor', clBlue);

  FFillColorAction.Color := aIniStorage.ReadInteger('Draw', 'FillColor', clWhite);
  FFillColorAction.IsClear := aIniStorage.ReadBool('Draw', 'FillIsClear', True);

  FLineColorAction.Color := aIniStorage.ReadInteger('Draw', 'LineColor', clWindowText);
  FLineColorAction.IsClear := aIniStorage.ReadBool('Draw', 'LineIsClear', False);

end;

{------------------------------------------------------------------------------}
{ TppDrawActionList.SavePreferences}

procedure TppDrawActionList.SavePreferences(aIniStorage: TppIniStorage);
begin

  inherited;

  aIniStorage.WriteInteger('Draw', 'GradientStyle', Ord(FGradientAction.Gradient.Style));
  aIniStorage.WriteInteger('Draw', 'GradientStartColor', Ord(FGradientAction.Gradient.StartColor));
  aIniStorage.WriteInteger('Draw', 'GradientEndColor', Ord(FGradientAction.Gradient.EndColor));

  aIniStorage.WriteInteger('Draw', 'FillColor', FFillColorAction.Color);
  aIniStorage.WriteBool('Draw', 'FillIsClear', FFillColorAction.IsClear);

  aIniStorage.WriteInteger('Draw', 'LineColor', FLineColorAction.Color);
  aIniStorage.WriteBool('Draw', 'LineIsClear', FLineColorAction.IsClear);

end;

function TppColorAction.Execute: Boolean;
begin

  Result := False;

  if Assigned(FOnExecuteAction) then  FOnExecuteAction(Self);

  if (SelectionController = nil) then Exit;

  case FColorType of
    ctFont: SelectionController.SetFontColor(FColor);
    ctHighlight: SelectionController.SetHighlightColor(FColor, FIsClear);
    ctLine: SelectionController.SetLineColor(FColor, FIsClear);
    ctFill: SelectionController.SetFillColor(FColor, FIsClear);
  end;

  Result := True;

end;

function TppColorAction.GetImageName: String;
begin
  Result := cColorResNames[Ord(FColorType)];
end;

function TppColorAction.GetImageMaskName: String;
begin
  Result := GetImageName + 'MASK';
end;

procedure TppColorAction.LanguageChanged;
begin
  UpdateHint();
end;

procedure TppColorAction.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;

  FColor := Value;

  ReplaceButtonImage(FColor);

  UpdateClients('Color', Value);

end;

procedure TppColorAction.UpdateHint;
var
  liHintId: Integer;
begin
  liHintId := cColorItemHints[Ord(FColorType)];

  Hint := ppLoadStr(liHintId);

end;

procedure TppColorAction.UpdateImage;
begin

//  ImageIndex := ToolImageList.IndexOfTool(GetImageName);

  ImageIndex := ToolImageList.AddToolWithMask(GetImageName, GetImageMaskName);

end;

procedure TppColorAction.SetColorType(const Value: TppColorButtonType);
begin
  FColorType := Value;
  UpdateImage();
  UpdateHint();
  UpdateClients('ColorType', Value);

end;

procedure TppColorAction.SetIsClear(const Value: Boolean);
begin

  if FIsClear <> Value then
    begin
      FIsClear := Value;
      UpdateClients('IsClear', Value);
    end;

end;

{------------------------------------------------------------------------------}
{ TppColorButton.ReplaceButtonImage}

procedure TppColorAction.ReplaceButtonImage(aColor: TColor);
var
  lBitmap: TBitmap;
  lMask: TBitmap;
begin

  lBitMap := TBitmap.Create;
  lBitMap.Handle := ppBitmapFromResource(GetImageName);

  lMask := TBitmap.Create;
  lMask.Handle := ppBitmapFromResource(GetImageMaskName);

  try
    lBitMap.Canvas.Brush.Style := bsSolid;

    if FIsClear then
      lBitMap.Canvas.Brush.Color := clBtnFace
    else
      lBitMap.Canvas.Brush.Color := aColor;

    lBitMap.Canvas.FillRect(Rect(0, 12, 16, 16));

   ToolImageList.Replace(ImageIndex, lBitMap, lMask);

  finally
    lMask.Free;
    lBitmap.Free;

  end;

end; {procedure, DrawButtonGlyph}

procedure TppColorAction.SelectionChanged;
var
  lColor: TColor;
  lbIsClear: Boolean;
begin

  case FColorType of
    ctFont:
      begin
        Enabled := (Report <> nil) and SelectionController.GetFontColor(lColor);
        lbIsClear := False;
      end;
    ctHighlight:
      Enabled := (Report <> nil) and SelectionController.GetHighlightColor(lColor, lbIsClear);
    ctLine:
      Enabled := (Report <> nil) and SelectionController.GetLineColor(lColor, lbIsClear);
    ctFill:
      Enabled := (Report <> nil) and SelectionController.GetFillColor(lColor, lbIsClear);
  end;

  // leave the existing color
{  if Enabled then
    begin
      SetColor(lColor);
      SetIsClear(lbIsClear);

    end;
}

end;


{------------------------------------------------------------------------------}
{ TppLineStyleAction.Create}

constructor TppLineStyleAction.Create(aOwner: TComponent);
begin
  inherited;

  UpdateImage();


end;

{------------------------------------------------------------------------------}
{ TppLineStyleAction.Execute}

function TppLineStyleAction.Execute: Boolean;
begin

  Result := True;

  if IsUpdating then Exit;

  SelectionController.SetLineStyle(FLineStyle);

end;

{------------------------------------------------------------------------------}
{ TppLineStyleAction.SelectionChanged}

procedure TppLineStyleAction.SelectionChanged;
var
  lLineStyle: TPenStyle;
begin

  IsUpdating := True;

  Enabled := (Report <> nil) and SelectionController.GetLineStyle(lLineStyle);

  if Enabled then
    SetLineStyle(lLineStyle);

  UpdateClients('Enabled', Enabled);


  IsUpdating := False;

end;

{------------------------------------------------------------------------------}
{ TppLineStyleAction.SetLineStyle}

procedure TppLineStyleAction.SetLineStyle(aLineStyle: TPenStyle);
begin
  FLineStyle := aLineStyle;

  UpdateClients('LineStyle', aLineStyle);

end; {procedure, SetCurrentLineStyle}

{------------------------------------------------------------------------------}
{ TppLineStyleAction.UpdateImage}

procedure TppLineStyleAction.UpdateImage;
begin

  ImageIndex := ToolImageList.AddTool('PPLINESTYLE');

end;


{******************************************************************************
 *
 **  Line Thickness Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLineThicknessAction.Create}

constructor TppLineThicknessAction.Create(aOwner: TComponent);
begin
  inherited;

  UpdateImage();

end;

{------------------------------------------------------------------------------}
{ TppLineThicknessAction.Execute}

function TppLineThicknessAction.Execute: Boolean;
begin

  Result := True;

  if IsUpdating then Exit;

  SelectionController.SetLineThickness(FLineThickness, FLineStyle);

end;

{------------------------------------------------------------------------------}
{ TppLineThicknessAction.SelectionChanged}

procedure TppLineThicknessAction.SelectionChanged;
var
  lLineStyle: TppLineStyleType;
  lLineThickness: Single;
  lAllowDoubleLines: Boolean;
begin
  IsUpdating := True;

  Enabled := (Report <> nil) and SelectionController.GetLineThickness(lLineThickness, lLineStyle, lAllowDoubleLines);

  if Enabled then
    begin
      SetLineThickness(lLineThickness);
      SetLineStyle(lLineStyle);
      SetDoubleLines(lAllowDoubleLines);
    end;

   UpdateClients('Enabled', Enabled);

  IsUpdating := False;

end;

{------------------------------------------------------------------------------}
{ TppLineThicknessAction.SetDoubleLines}

procedure TppLineThicknessAction.SetDoubleLines(const Value: Boolean);
begin

  if (FDoubleLines = Value) then Exit;
  
  FDoubleLines := Value;

  UpdateClients('DoubleLines', FDoubleLines);
    
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessAction.SetCurrentLineStyle}

procedure TppLineThicknessAction.SetLineStyle(aLineStyle: TppLineStyleType);
begin

  if (FLineStyle = aLineStyle) then Exit;

  FLineStyle := aLineStyle;

  UpdateClients('LineStyle', FLineStyle);

end; {procedure, SetLineStyle}

{------------------------------------------------------------------------------}
{ TppLineThicknessAction.SetLineThickness}

procedure TppLineThicknessAction.SetLineThickness(aLineThickness: Single);
begin

  if (FLineThickness = aLineThickness) then Exit;

  FLineThickness := aLineThickness;

  UpdateClients('LineThickness', FLineThickness);

end; {procedure, SetLineThickness}

{------------------------------------------------------------------------------}
{TppLineThicknessAction.SetReport}

procedure TppLineThicknessAction.SetReport(const Value: TppCustomReport);
begin

  if (FReport <> Value) then
    begin
      inherited;

    end;

end;


{------------------------------------------------------------------------------}
{ TppLineThicknessAction.UpdateImage}

procedure TppLineThicknessAction.UpdateImage;
begin

  ImageIndex := ToolImageList.AddTool('PPLINETHICKNESS');

end;



{------------------------------------------------------------------------------}
{ TppEditTextAction.SetText}

procedure TppEditTextAction.SetText(const Value: String);
begin

  if (FText = Value) then Exit;

  FText := Value;

  UpdateClients('Text', FText);

end;

{******************************************************************************
 *
 **  ComboBox Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppComboBoxAction.Create}

constructor TppComboBoxAction.Create(aOwner: TComponent);
begin
  inherited;

  FItems := TStringList.Create;

end;

{------------------------------------------------------------------------------}
{ TppComboBoxAction.Destroy}

destructor TppComboBoxAction.Destroy;
begin
  FItems.Free;

  inherited;
  
end;

function TppComboBoxAction.GetItems: TStrings;
begin
  Result := FItems;
end;

{------------------------------------------------------------------------------}
{ TppComboBoxAction.SetItems}

procedure TppComboBoxAction.SetItems(const Value: TStrings);
begin

  if (FItems = Value) then Exit;

  FItems.Assign(Value);

  UpdateClients('Items', FItems);
  UpdateClients('Strings', FItems);  // alternate prop name

end;


{------------------------------------------------------------------------------}
{ TppEditActionList.Create}

constructor TppEditActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Edit';  // do not localize

  Images := ToolImageList;

  CreateActions;

end;

{------------------------------------------------------------------------------}
{ TppEditActionList.CreateActions}

procedure TppEditActionList.CreateActions;
var
  lEditTextAction: TppDefaultPropEditAction;
begin

  lEditTextAction := TppDefaultPropEditAction.Create(nil);
  lEditTextAction.Name := 'EditText'; // do not localize
  lEditTextAction.ActionList := Self;
  lEditTextAction.Enabled := False;

  FComboBoxAction := TppDefaultPropValueListAction.Create(nil);
  FComboBoxAction.Name := 'ComboBox'; // do not localize
  FComboBoxAction.ActionList := Self;
  FComboBoxAction.Enabled := False;
  FComboBoxAction.Visible := False;

  FComboBoxAction2 := TppDefaultPropValueList2Action.Create(nil);
  FComboBoxAction2.Name := 'ComboBox2'; // do not localize
  FComboBoxAction2.ActionList := Self;
  FComboBoxAction2.Enabled := False;
  FComboBoxAction2.Visible := False;

end;

procedure TppEditActionList.InitializeValueLists;
begin
  FComboBoxAction.InitializeValueList;
  FComboBoxAction2.InitializeValueList;
end;

{******************************************************************************
 *
 **  Standard Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppStandardAction.Execute}

function TppStandardAction.Execute: Boolean;
begin

  case FActionType of
    saNew: DesignControllers.DocumentController.New(True {DisplayDialog});

    saOpen: DesignControllers.DocumentController.Open();

    saSave: DesignControllers.DocumentController.Save();

    saPageSetup: DesignControllers.DialogController.ShowPageSetupDialog();

    saPrint: DesignControllers.DocumentController.Print();

    saPreview: DesignControllers.DocumentController.Preview();

    saCut: DesignControllers.SelectionController.CutToClipboard();

    saCopy: DesignControllers.SelectionController.CopyToClipboard();

    saPaste: DesignControllers.SelectionController.PasteFromClipboard();

  end;

  Result := True;


end;

{------------------------------------------------------------------------------}
{ TppStandardAction.LanguageChanged}

procedure TppStandardAction.LanguageChanged;
var
  liHintIndex: Integer;
begin

  liHintIndex := cStandardItemHints[Ord(FActionType)];

  Hint := ppLoadStr(liHintIndex);

end;

{------------------------------------------------------------------------------}
{ TppStandardAction.SetActionType}

procedure TppStandardAction.SetActionType(const Value: TppStandardActionType);
begin

  FActionType := Value;
  UpdateImage();
  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppStandardAction.UpdateImage}

procedure TppStandardAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cStandardItemResNames[Ord(FActionType)];

  ImageIndex := ToolImageList.AddTool(lsImageName);


end;

{******************************************************************************
 *
 **  Text Alignment Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTextAlignmentAction.Execute}

function TppTextAlignmentAction.Execute: Boolean;
begin

  Result := inherited Execute;

  if IsUpdating then Exit;

  SelectionController.SetTextAlignment(FTextAlignment);

end;

{------------------------------------------------------------------------------}
{ TppTextAlignmentAction.LanguageChanged}

procedure TppTextAlignmentAction.LanguageChanged;
var
  liHintIndex: Integer;
begin

  liHintIndex := cTextAlignmentHints[Ord(FTextAlignment)];

  Hint := ppLoadStr(liHintIndex);

end;

{------------------------------------------------------------------------------}
{ TppTextAlignmentAction.SelectionChanged}

procedure TppTextAlignmentAction.SelectionChanged;
var
  lTextAlignment: TppTextAlignment;
begin

  IsUpdating := True;

  Enabled := (Report <> nil) and SelectionController.GetTextAlignment(lTextAlignment);

  if Enabled then
    Checked := FTextAlignment = lTextAlignment;

  IsUpdating := False;

end;

{------------------------------------------------------------------------------}
{ TppTextAlignmentAction.SetTextAlignment}

procedure TppTextAlignmentAction.SetTextAlignment(const Value: TppTextAlignment);
begin

  FTextAlignment := Value;

  UpdateClients('TextAlignment', Value);

  LanguageChanged();
  UpdateImage();

end;

{------------------------------------------------------------------------------}
{ TppTextAlignment.UpdateImage}

procedure TppTextAlignmentAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cTextAlignmentResNames[Ord(FTextAlignment)];

  ImageIndex := ToolImageList.AddTool(lsImageName);

end;




{------------------------------------------------------------------------------}
{ TppFontStyleAction.Execute}

function TppFontStyleAction.Execute: Boolean;
begin

  Result := inherited Execute;

  if IsUpdating then Exit;

//  Checked := not (Checked);
  
  if Checked then
    SelectionController.AddFontStyle(FFontStyle)
  else
    SelectionController.RemoveFontStyle(FFontStyle);

end;

{------------------------------------------------------------------------------}
{ TppFontStyleAction.LanguageChanged}

procedure TppFontStyleAction.LanguageChanged;
var
  liHintIndex: Integer;
begin

  liHintIndex := cFontStyleHints[Ord(FFontStyle)];

  Hint := ppLoadStr(liHintIndex);

end;

{------------------------------------------------------------------------------}
{ TppFontStyleAction.SelectionChanged}

procedure TppFontStyleAction.SelectionChanged;
var
  lFontStyles: TFontStyles;
begin

  IsUpdating := True;

  Enabled := (Report <> nil) and SelectionController.GetFontStyle(lFontStyles);

  if Enabled then
    Checked := (FFontStyle in lFontStyles);

  IsUpdating := False;

end;

{------------------------------------------------------------------------------}
{ TppFontStyleAction.SetFontStyle}

procedure TppFontStyleAction.SetFontStyle(const Value: TFontStyle);
begin

  FFontStyle := Value;

  UpdateImage();
  LanguageChanged();


end;

{------------------------------------------------------------------------------}
{ TppFontStyleAction.UpdateImage}

procedure TppFontStyleAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cFontStyleResNames[Ord(FFontStyle)];

  ImageIndex := ToolImageList.AddTool(lsImageName);

end;

{******************************************************************************
 *
 **  Anchor Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAnchorBoxAction.Create}

constructor TppAnchorAction.Create(aOwner: TComponent);
begin
  inherited;

  ImageIndex := ToolImageList.AddTool('PPANCHORS');

  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppAnchorAction.Execute}

function TppAnchorAction.Execute: Boolean;
begin

  Result := True;

  if IsUpdating then Exit;

  SelectionController.SetAnchors(FAnchors);

end;

{------------------------------------------------------------------------------}
{ TppAnchorAction.SelectionChanged}

procedure TppAnchorAction.SelectionChanged;
var
  lAnchors: TppAnchors;
begin

  IsUpdating := True;

  Enabled := (Report <> nil) and SelectionController.GetAnchors(lAnchors);

  if Enabled then
    SetAnchors(lAnchors);

  UpdateClients('Enabled', Enabled);

  IsUpdating := False;

end;

{------------------------------------------------------------------------------}
{ TppAnchorAction.SetAnchors}

procedure TppAnchorAction.SetAnchors(const Value: TppAnchors);
begin

  if (FAnchors <> Value) then
    begin
      FAnchors := Value;
      UpdateClients('Anchors', TypInfo.GetOrdProp(Self, 'Anchors'));
    end;

end;

{******************************************************************************
 *
 **  Anchor Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBorderAction.Create}

constructor TppBorderAction.Create(aOwner: TComponent);
begin
  inherited;

  ImageIndex := ToolImageList.AddTool('PPBORDER');

  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppBorderAction.Execute}

function TppBorderAction.Execute: Boolean;
begin

  Result := True;

  if IsUpdating then Exit;

  SelectionController.SetBorderPositions(FBorderPositions);

end;

{------------------------------------------------------------------------------}
{ TppBorderAction.SelectionChanged}

procedure TppBorderAction.SelectionChanged;
var
  lBorderPositions: TppBorderPositions;
begin

  IsUpdating := True;

  Enabled := (Report <> nil) and SelectionController.GetBorderPositions(lBorderPositions);

  if Enabled then
    SetBorderPositions(lBorderPositions);

  UpdateClients('Enabled', Enabled);

  IsUpdating := False;
    
end;

{------------------------------------------------------------------------------}
{ TppBorderAction.SetAnchors}

procedure TppBorderAction.SetBorderPositions(const Value: TppBorderPositions);
begin

  if FBorderPositions <> Value then
    begin
      FBorderPositions := Value;
      UpdateClients('BorderPositions', TypInfo.GetOrdProp(Self, 'BorderPositions'));
    end;

end;

{******************************************************************************
 *
 **  Z-Order Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppZOrderAction.Create}

constructor TppZOrderAction.Create(aOwner: TComponent);
begin
  inherited;

  ImageIndex := ToolImageList.AddTool('PPBORDER');

  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppZOrderAction.Execute}

function TppZOrderAction.Execute: Boolean;
begin

  case FZOrderType of
    zoBringForward: SelectionController.BringForward;
    zoBringToFront: SelectionController.BringToFront;
    zoSendBackward: SelectionController.SendBackward;
    zoSendToBack: SelectionController.SendToBack;
  end;

  Result := True;

end;

{------------------------------------------------------------------------------}
{ TppZOrderAction.LanguageChanged}

procedure TppZOrderAction.LanguageChanged;
var
  liHintIndex: Integer;
begin

  liHintIndex := cZOrderHints[Ord(FZOrderType)];

  Hint := ppLoadStr(liHintIndex);

end;

{------------------------------------------------------------------------------}
{ TppZOrderAction.SetAnchors}

procedure TppZOrderAction.SetZOrderType(const Value: TppZOrderType);
begin

  FZOrderType := Value;

  LanguageChanged();
  UpdateImage();


end;

{------------------------------------------------------------------------------}
{ TppFontStyle.UpdateImage}

procedure TppZOrderAction.UpdateImage;
var
  lsImageName: String;
begin

  lsImageName := cZOrderResNames[Ord(FZOrderType)];

  ImageIndex := ToolImageList.AddTool(lsImageName);

end;



constructor TppFormatActionList.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Format';  // do not localize

  Images := ToolImageList;

  CreateActions;

end;

procedure TppFormatActionList.CreateActions;
var
  lFontStyleAction: TppFontStyleAction;
  lTextAlignmentAction: TppTextAlignmentAction;
  lFontStyle: TFontStyle;
  lZOrderType: TppZOrderType;
  lTextAlignment: TppTextAlignment;
  lAnchorAction: TppAnchorAction;
  lBorderAction: TppBorderAction;
  lZOrderAction: TppZOrderAction;
begin

  FFontNameAction := TppFontNameAction.Create(nil);
  FFontNameAction.Name := 'FontName';
  FFontNameAction.ActionList := Self;

  FFontSizeAction := TppFontSizeAction.Create(nil);
  FFontSizeAction.Name := 'FontSize';
  FFontSizeAction.ActionList := Self;

  // font style actions: bold, italic, underline
  for lFontStyle := fsBold to fsUnderline do
    begin
      lFontStyleAction := TppFontStyleAction.Create(nil);
      lFontStyleAction.FontStyle := lFontStyle;
      lFontStyleAction.Name := cFontStyleNames[Ord(lFontStyle)];
      lFontStyleAction.AutoCheck := True;
      lFontStyleAction.ActionList := Self;
    end;

  // text aligment actions
  for lTextAlignment := Low(TppTextAlignment) to High(TppTextAlignment) do
    begin
      lTextAlignmentAction := TppTextAlignmentAction.Create(nil);
      lTextAlignmentAction.TextAlignment := lTextAlignment;
      lTextAlignmentAction.Name := cTextAlignmentNames[Ord(lTextAlignment)];
      lTextAlignmentAction.AutoCheck := True;
      lTextAlignmentAction.GroupIndex := 2;
      lTextAlignmentAction.ActionList := Self;
    end;

  // font color action
  FFontColorAction := TppColorAction.Create(nil);
  FFontColorAction.ColorType := ctFont;
  FFontColorAction.Name := 'FontColor';
  FFontColorAction.ActionList := Self;

  // highlight color action
  FHighlightColorAction := TppColorAction.Create(nil);
  FHighlightColorAction.ColorType := ctHighlight;
  FHighlightColorAction.Name := 'HighlightColor';
  FHighlightColorAction.ActionList := Self;

  lAnchorAction := TppAnchorAction.Create(nil);
  lAnchorAction.Name := 'Anchors';
  lAnchorAction.ActionList := Self;

  lBorderAction := TppBorderAction.Create(nil);
  lBorderAction.Name := 'Borders';
  lBorderAction.ActionList := Self;

  // z-order actions
  for lZOrderType := Low(TppZOrderType) to High(TppZOrderType) do
    begin
      lZOrderAction := TppZOrderAction.Create(nil);
      lZOrderAction.ZOrderType := lZOrderType;
      lZOrderAction.Name := cZOrderNames[Ord(lZOrderType)];
      lZOrderAction.AutoCheck := True;
      lZOrderAction.ActionList := Self;
    end;

end;

{------------------------------------------------------------------------------}
{ TppFormatToolbar.LoadPreferences}

procedure TppFormatActionList.LoadPreferences(aIniStorage: TppIniStorage);
begin

  inherited;

  FFontColorAction.Color := aIniStorage.ReadInteger('Format', 'FontColor', clWindowText);
  FFontColorAction.IsClear := aIniStorage.ReadBool('Format', 'FontIsClear', False);

  FHighlightColorAction.Color    := aIniStorage.ReadInteger('Format', 'HighlightColor', clWhite);
  FHighlightColorAction.IsClear := aIniStorage.ReadBool('Format', 'HighlightIsClear', True);

  FFontNameAction.Text := aIniStorage.ReadString('Format', 'DefaultFontName', 'Arial');
  FFontSizeAction.Text := aIniStorage.ReadString('Format', 'DefaultFontSize', '10');

end;

{------------------------------------------------------------------------------}
{ TppFormatToolbar.SavePreferences}

procedure TppFormatActionList.SavePreferences(aIniStorage: TppIniStorage);
begin

  inherited;

  aIniStorage.WriteInteger('Format', 'FontColor', FFontColorAction.Color);
  aIniStorage.WriteBool('Format', 'FontIsClear', FFontColorAction.IsClear);

  aIniStorage.WriteInteger('Format', 'HighlightColor', FHighlightColorAction.Color);
  aIniStorage.WriteBool('Format', 'HighlightIsClear', FHighlightColorAction.IsClear);

  aIniStorage.WriteString('Format', 'DefaultFontName', FFontNameAction.Text);
  aIniStorage.WriteString('Format', 'DefaultFontSize', FFontSizeAction.Text);
  
end;

{******************************************************************************
 *
 **  FontName Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFontNameAction.Create}

constructor TppFontNameAction.Create(aOwner: TComponent);
begin
  inherited;

  FFont := TFont.Create;

end;

{------------------------------------------------------------------------------}
{ TppFontNameAction.Destroy}

destructor TppFontNameAction.Destroy;
begin
  FFont.Free;
  FFont := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppFontNameAction.Execute}

function TppFontNameAction.Execute: Boolean;
begin

  Result := True;

  if IsUpdating then Exit;

  FFont.Name := Text;
  FFont.Charset := GetFontCharset(Text);

  SelectionController.SetFontName(FFont);

end;

{------------------------------------------------------------------------------}
{ TppFontNameAction.GetFontCharset}

function TppFontNameAction.GetFontCharset(aFontName: String): TFontCharset;
var
  liIndex: Integer;
begin

  liIndex := FItems.IndexOf(aFontName);

  if (liIndex >= 0) then
    Result := FItems.FontInfo[liIndex].CharSet
  else
    Result := DEFAULT_CHARSET;

end;

{------------------------------------------------------------------------------}
{ TppFontNameAction.GetItems}

function TppFontNameAction.GetItems: TppFontList;
begin

  SelectionController.GetFontList(FItems);

  Result := FItems;

end;

{------------------------------------------------------------------------------}
{ TppFontNameAction.SelectionChanged}

procedure TppFontNameAction.SelectionChanged;
begin

  IsUpdating := True;

  try
    if SelectionController.GetFontName(FFont) then
      Text := FFont.Name;
      
  finally
    IsUpdating := False;
  end;

end;


{******************************************************************************
 *
 **  FontSize Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFontSizeAction.Create}

constructor TppFontSizeAction.Create(aOwner: TComponent);
begin
  inherited;

  InitializeItemsList(Items);

end;

{------------------------------------------------------------------------------}
{ TppFontSizeAction.Execute}

function TppFontSizeAction.Execute: Boolean;
begin

  Result := True;

  if IsUpdating then Exit;

  SelectionController.SetFontSize(StrToInt(Text));


end;

{------------------------------------------------------------------------------}
{ TppFontSizeAction.InitializeItemsList}

procedure TppFontSizeAction.InitializeItemsList(aList: TStrings);
var
  liIndex: Integer;
begin

  for liIndex := 0 to High(cFontSizes) do
    aList.Add(IntToStr(cFontSizes[liIndex]));

end;

{------------------------------------------------------------------------------}
{ TppFontSizeAction.SelectionChanged}

procedure TppFontSizeAction.SelectionChanged;
var
  liSize: Integer;
begin

  IsUpdating := True;

  try
    if SelectionController.GetFontSize(liSize) then
      Text := IntToStr(liSize);
      
  finally
    IsUpdating := False;
  end;

end;

{******************************************************************************
 *
 **  Default Prop Edit Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDefaultPropEditAction.Execute}

function TppDefaultPropEditAction.Execute: Boolean;
var
  lsValue: String;
begin

  Result := True;

  if (FDefaultComponent = nil) then Exit;

  if IsUpdating then Exit;

  lsValue := Text;
  SelectionController.SetDefaultPropValue(lsValue);
  Text := lsValue;

end;

{------------------------------------------------------------------------------}
{ TppDefaultPropEditAction.LanguageChanged}

procedure TppDefaultPropEditAction.LanguageChanged;
begin
  if (FDefaultComponent <> nil) then
    Hint := FDefaultComponent.DefaultHint
  else
    Hint := '';
end;

{------------------------------------------------------------------------------}
{ TppDefaultPropEditAction.SelectionChanged}

procedure TppDefaultPropEditAction.SelectionChanged;
var
  lEditType: TppPropEditType;
  lsPropValue: String;
begin

  IsUpdating := True;

  if SelectionController.GetDefaultComponent(FDefaultComponent) then
    begin
      lEditType := FDefaultComponent.DefaultPropEditType;

      Enabled := (Report <> nil) and (lEditType in [etAutoEdit, etEdit]);
      Visible := not(lEditType in [etFieldList, etDataPipelineList, etValueList]);
    end
  else
    begin
      Text := '';
      Enabled := False;
      Visible := True;
    end;


  if Visible then
    begin
      LanguageChanged();

      if SelectionController.GetDefaultPropValue(lsPropValue) then
        Text := lsPropValue
      else
        Text := '';

    end;

    
  IsUpdating := False;


end;

{******************************************************************************
 *
 **  Default Prop Value List Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDefaultPropValueListAction.Execute}

function TppDefaultPropValueListAction.Execute: Boolean;
var
  lsValue: String;
begin

  Result := True;

  if IsUpdating then Exit;


  if (FDefaultComponent = nil) then Exit;

  lsValue := Text;
  SelectionController.SetDefaultPropValue(lsValue, Items);
//  Text := lsValue;


end;

{------------------------------------------------------------------------------}
{ TppDefaultPropValueListAction.InitializeValueList}

procedure TppDefaultPropValueListAction.InitializeValueList;
begin

  Items.Clear;

  if (FDefaultComponent = nil) then Exit;

  SelectionController.GetDefaultPropValueList(Items);

  UpdateClients('Items', FItems);
  UpdateClients('Strings', FItems);  // alternate prop name

end;

{------------------------------------------------------------------------------}
{ TppDefaultPropValueListAction.LanguageChanged}

procedure TppDefaultPropValueListAction.LanguageChanged;
begin
  if (FDefaultComponent <> nil) then
    Hint := FDefaultComponent.DefaultHint
  else
    Hint := '';
end;

{------------------------------------------------------------------------------}
{ TppDefaultPropValueListBoxAction.SelectionChanged}

procedure TppDefaultPropValueListAction.SelectionChanged;
var
  lEditType: TppPropEditType;
  lsPropValue: String;
begin

  IsUpdating := True;

  // determine visibility
  if SelectionController.GetDefaultComponent(FDefaultComponent) then
    begin
      lEditType := FDefaultComponent.DefaultPropEditType;

      Visible := lEditType in [etFieldList, etDataPipelineList, etValueList];
    end
  else
    Visible := False;


  // update value list and hint
  if Visible then
    begin

      InitializeValueList();

      LanguageChanged();

      if SelectionController.GetDefaultPropValue(lsPropValue, Items) then
        Text := lsPropValue;

    end;

  IsUpdating := False;

end;

{******************************************************************************
 *
 **  Default Prop Value List 2 Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDefaultPropValueList2Action.Execute}

function TppDefaultPropValueList2Action.Execute: Boolean;
var
  liIndex: Integer;
begin

  Result := True;

  if IsUpdating then Exit;
  
  if (FDefaultComponent <> nil) then
    begin
      liIndex := Items.IndexOf(Text);

      if (liIndex >= 0) then
        SelectionController.SetDataPipeline(TppDataPipeline(Items.Objects[liIndex]));
    end;

end;

{------------------------------------------------------------------------------}
{ TppDefaultPropValueList2Action.InitializeValueList}

procedure TppDefaultPropValueList2Action.InitializeValueList;
begin

  Items.Clear;

  if (FDefaultComponent = nil) then Exit;

  SelectionController.GetDataPipelineList(Items);

  UpdateClients('Items', FItems);
  UpdateClients('Strings', FItems);  // alternate prop name

end;

{------------------------------------------------------------------------------}
{ TppDefaultPropValueList2Action.LanguageChanged}

procedure TppDefaultPropValueList2Action.LanguageChanged;
begin

  ppLoadStr(606); {DataPipeline Name}

end;

{------------------------------------------------------------------------------}
{ TppDefaultPropValueList2Action.SelectionChanged}

procedure TppDefaultPropValueList2Action.SelectionChanged;
begin

  IsUpdating := True;

  // determine visibility
  if SelectionController.GetDefaultComponent(FDefaultComponent) then
    Visible := FDefaultComponent.DefaultPropEditType = etFieldList
  else
    Visible := False;


  // update value list and value
  if Visible then
    begin
      InitializeValueList();

      if (FDefaultComponent.DataPipeline <> nil) then
        Text := FDefaultComponent.DataPipeline.UserName
      else
        Text := '';

    end;

  IsUpdating := False;

end;

{******************************************************************************
 *
 **  D e s i g n   T o o l   C o l o r s   (nonelton)
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignToolColors.GetCustomColors}

class function TppDesignToolColors.GetCustomColors: TStrings;
begin

  if (uCustomColors = nil) then
    uCustomColors := TStringList.Create;

  Result := uCustomColors;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolColors.LoadPreferences}

class procedure TppDesignToolColors.LoadPreferences(aIniStorage: TppIniStorage);
begin

  GetCustomColors().CommaText := aIniStorage.ReadString('DesignToolColors', 'CustomColors', GetCustomColors.CommaText);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolColors.SavePreferences}

class procedure TppDesignToolColors.SavePreferences(aIniStorage: TppIniStorage);
begin

  aIniStorage.WriteString('DesignToolColors', 'CustomColors', GetCustomColors().CommaText);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolColors.SetCustomColors}

class procedure TppDesignToolColors.SetCustomColors(aCustomColors: TStrings);
begin
  GetCustomColors().Assign(aCustomColors);
end;

{******************************************************************************
 *
 **  Gradient Action
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGradientAction.Create}

constructor TppGradientAction.Create(aOwner: TComponent);
begin

  inherited;

   FGradient := TppGradient.Create(nil);

   FGradient.Style := gsHorizontal;
   FGradient.StartColor := clWhite;
   FGradient.EndColor := clBlue;

   // assign event-handler after setting the props above
   FGradient.OnChange := ehGradient_Change;

   ImageIndex := ToolImageList.AddTool('PPGRADIENT', clCream);

end;

{------------------------------------------------------------------------------}
{ TppGradientAction.Destroy}

destructor TppGradientAction.Destroy;
begin

  inherited;

  FGradient.Free;
  FGradient := nil;

end;

procedure TppGradientAction.ehGradient_Change(Sender: TObject);
begin
  ReplaceButtonImage();
  UpdateClients('Gradient', FGradient);

end;

{------------------------------------------------------------------------------}
{ TppGradientAction.Execute}

function TppGradientAction.Execute: Boolean;
begin

  if not(IsUpdating) and (SelectionController <> nil) then
    SelectionController.SetPropValue('Gradient', FGradient);

  Result := True;

end;

{------------------------------------------------------------------------------}
{ TppGradientPaletteButton.ReplaceButtonImage}

procedure TppGradientAction.ReplaceButtonImage;
var
  lBitmap: TBitmap;
begin

  lBitMap := TBitmap.Create;
  lBitMap.Width := ToolImageList.Width;
  lBitMap.Height := ToolImageList.Height;

  try
    lBitMap.Canvas.Brush.Style := bsSolid;
    lBitMap.Canvas.Brush.Color := clCream;
    lBitMap.Canvas.FillRect(Rect(0, 0,lBitMap.Width, lBitMap.Height));

    if (FGradient.Style <> gsNone) then
      TppGradient.FillGradient(lBitMap.Canvas, FGradient, Rect(0, 0, 15, 15))
    else
      begin
        lBitMap.Canvas.Brush.Color := clWhite;
        lBitMap.Canvas.FillRect(Rect(0, 0, 15, 15));
      end;

    ToolImageList.ReplaceMasked(ImageIndex, lBitMap, clCream);

  finally
    lBitmap.Free;

  end;

end;

{------------------------------------------------------------------------------}
{TppGradientAction.SelectionChanged}

procedure TppGradientAction.SelectionChanged;
var
  lGradient: TppGradient;
begin

//  IsUpdating := True;

  lGradient := nil;

  Enabled := (Report <> nil) and SelectionController.GetGradient(lGradient);

  // do not update the tool, when the selection changes
{   if Enabled then
     SetGradient(lGradient);

    UpdateClients('Enabled', Enabled);
}
//    IsUpdating := False;


end;

procedure TppGradientAction.SetGradient(Value: TppGradient);
begin
  FGradient.Assign(Value);

  ReplaceButtonImage();

  UpdateClients('Gradient', Value);

end;


initialization

finalization
  uCustomColors.Free;
  uCustomColors := nil;



end.
