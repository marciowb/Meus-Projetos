{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daDataDictionaryBuilder;

{$I ppIfDef.pas}

interface

uses
  {$IFDEF Delphi6} Variants,{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus, 
  ppComm, ppClass, ppTreeVw, ppDB, ppTypes, ppUtils, ppDsgnDB, ppForms, ppDBPipe, ppDsIntf,
  daDB, daDataView, daQueryDataView, daSQL, daJoinPanel, ppIniStorage;

type

  TdaDDEditPage = class;

  { TdaDataDictionaryBuilderForm }
  TdaDataDictionaryBuilderForm = class(TppComponentDesigner)
      pgcMain: TPageControl;
      stbStatus: TStatusBar;
      procedure FormCreate(Sender: TObject);
      procedure FormActivate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure pgcMainChange(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormDeactivate(Sender: TObject);

    private
      FActivePage: Integer;
      FBringingForward: Boolean;
      FDataDictionary: TppDataDictionary;
      FEditPage: TdaDDEditPage;
      FPages: TList;
      FProcessing: Boolean;
      FSession: TdaSession;
      FSQL: TdaSQL;
      FWalkieTalkie: TppCommunicator;

      procedure ActivatePage;
      procedure CreatePages;
      procedure FreePages;
      procedure LoadStateInfo;
      procedure LoadPageStates;
      procedure PageStartProcessEvent(Sender: TObject);
      procedure PageEndProcessEvent(Sender: TObject);
      procedure SaveStateInfo;
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary);
      procedure WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);

    protected
      procedure SetComponent(aComponent: TComponent); override;

    public
      procedure BringForward;
      procedure SelectionChanged(aSelection: TppDesignerSelectionList); override;
      function  ValidSettings: Boolean; override;

      property DataDictionary: TppDataDictionary read FDataDictionary write SetDataDictionary;

  end; {class, TdaDataDictionaryBuilderForm}


  { TdaDDEditPage }
  TdaDDEditPage = class(TppCommunicator)
    private
      FModified: Boolean;
      FDataDictionary: TppDataDictionary;
      FDataPipeline: TppDataPipeline;
      FFieldNames: TStringList;
      FInitialized: Boolean;
      FOnStartProcess: TNotifyEvent;
      FOnEndProcess: TNotifyEvent;
      FSQL: TdaSQL;
      FSession: TdaSession;
      FSettingControls: Boolean;
      FTabSheet: TTabSheet;

      procedure FreeControls;
      procedure GetTableNames(aTableNames: TStrings);
      function  OpenDataSet(aDataSet: TdaDataSet): Boolean;
      procedure RemoveEndUserTables(aTableNames: TStrings);
      procedure SetSession(aSession: TdaSession);
      procedure StripOffOwnerNames(aTableNames: TStrings);
      function  TableNameToSQLString(const aTableName: String): String;

    protected
      function  BooleanToText(aBoolean: Boolean): String;
      procedure CreateControls; virtual; abstract;
      procedure DataToControls; virtual; abstract;
      procedure DataToItem(aItem: TListItem); virtual;
      procedure DoOnStartProcess;
      procedure DoOnEndProcess;
      procedure HideEditControls; virtual; abstract;
      function  OutOfSync: Boolean; virtual; abstract;
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary); virtual;
      procedure SetSortDescription; virtual; abstract;


      property Initialized: Boolean read FInitialized;
      property SettingControls: Boolean read FSettingControls;
      property TabSheet: TTabSheet read FTabSheet;

    public
      constructor CreatePage(aOwner: TComponent; aPageControl: TPageControl; aSession: TdaSession; aDataDictionary: TppDataDictionary; aSQL: TdaSQL); virtual;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      class function PageName: String; virtual;

      procedure Activate; virtual;
      procedure Reset;
      function  Valid: Boolean; virtual; abstract;

      property DataDictionary: TppDataDictionary read FDataDictionary write SetDataDictionary;
      property DataPipeline: TppDataPipeline read FDataPipeline;
      property Modified: Boolean read FModified;
      property OnStartProcess: TNotifyEvent read FOnStartProcess write FOnStartProcess;
      property OnEndProcess: TNotifyEvent read FOnEndProcess write FOnEndProcess;
      property Session: TdaSession read FSession write SetSession;

  end; {class, TdaDDEditPage}

  { TdaDDListViewPage }
  TdaDDListViewPage = class(TdaDDEditPage)
    private
      FAdding: Boolean;
      FAlwaysRowSelect: Boolean;
      FCancelDialog: TppCustomCancelDialog;
      FColumnSizes: TList;
      FLastItem: TListItem;
      FListView: TppListView;
      FEmpty: Boolean;
      FPopupMenu: TPopupMenu;
      FSaving: Boolean;
      FSortMode: Integer;
      FStop: Boolean;

      procedure CancelDialogCancelEvent(Sender: TObject);
      procedure CancelDialogDestroyEvent(Sender: TObject);
      procedure CreateCancelDialog(const aCaption, aMessage: String);
      procedure DeleteMenuClickEvent(Sender: TObject);
      procedure FreeCancelDialog;
      procedure GenerateMenuClickEvent(Sender: TObject);
      procedure ListViewChangingEvent(Sender: TObject; Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
      procedure ListViewClickEvent(Sender: TObject);
      procedure ListViewColumnClickEvent(Sender: TObject; Column: TListColumn);
      procedure ListViewCompareEvent(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
      procedure ListViewSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
      function  SaveChanges(aItem: TListItem): Boolean;
      procedure SynchronizeMenuClickEvent(Sender: TObject);

    protected
      property ListView: TppListView read FListView;
      property PopupMenu: TPopupMenu read FPopupMenu;

      procedure AddMenuClickEvent(Sender: TObject); virtual;
      procedure CancelMenuClickEvent(Sender: TObject); virtual;
      procedure ChangeEvent(Sender: TObject); virtual;
      function  GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; virtual; abstract;
      function  SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; virtual; abstract;
      procedure CreateControls; override;
      procedure DataToControls; override;
      function  EmptyEntry: Boolean; virtual; abstract;
      function  GenerateMessage: String; virtual; abstract;
      procedure ListViewColumnResizeEvent(aListView: TListView; aColumn: TListColumn); virtual;
      procedure ListViewDblClickEvent(Sender: TObject); virtual;
      procedure ListViewScrollEvent(Sender: TObject); virtual;
      function  LocateRecord(aItem: TListItem): Boolean; virtual; abstract;
      procedure UpdateRecord; virtual; abstract;
      function  OutOfSync: Boolean; override;
      procedure PopupMenuPopupEvent(Sender: TObject); virtual;
      procedure SaveMenuClickEvent(Sender: TObject); virtual;
      procedure SelectItem(aItem: TListItem; aSelected: Boolean); virtual; abstract;
      procedure SetSortDescription; override;
      function  SynchronizeMessage: String; virtual; abstract;
      function  ValidateEntry(aItem: TListItem): Boolean; virtual; abstract;

    public
      constructor CreatePage(aOwner: TComponent; aPageControl: TPageControl; aSession: TdaSession; aDataDictionary: TppDataDictionary; aSQL: TdaSQL); override;
      destructor Destroy; override;

      procedure Activate; override;
      procedure LoadStateInfo(aIniStorage: TppIniStorage);
      procedure SaveStateInfo(aIniStorage: TppIniStorage);
      function  Valid: Boolean; override;

      property SortMode: Integer read FSortMode write FSortMode;

  end; {class, TdaDDListViewPage}

  { TdaDDTablePage }
  TdaDDTablePage = class(TdaDDListViewPage)
    private
      FedtTableName: TEdit;
      FedtTableAlias: TEdit;

    protected
      function  GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; override;
      function  SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; override;
      procedure CreateControls; override;
      function  EmptyEntry: Boolean; override;
      function  GenerateMessage: String; override;
      procedure HideEditControls; override;
      function  LocateRecord(aItem: TListItem): Boolean; override;
      procedure UpdateRecord; override;
      procedure SelectItem(aItem: TListItem; aSelected: Boolean); override;
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary); override;
      function  SynchronizeMessage: String; override;
      function  ValidateEntry(aItem: TListItem): Boolean; override;

    public
      class function PageName: String; override;

  end; {class, TdaDDTablePage}

  { TdaDDFieldPage }
  TdaDDFieldPage = class(TdaDDListViewPage)
    private
      FedtTableName: TEdit;
      FedtFieldName: TEdit;
      FedtFieldAlias: TEdit;
      FcbxDataType: TComboBox;
      FcbxSelectable: TCheckBox;
      FcbxSearchable: TCheckBox;
      FcbxSortable: TCheckBox;
      FcbxAutoSearch: TCheckBox;
      FcbxMandatory: TCheckBox;

    protected
      function  GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; override;
      function  SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; override;
      procedure CreateControls; override;
      function  EmptyEntry: Boolean; override;
      function  GenerateMessage: String; override;
      procedure HideEditControls; override;
      function  LocateRecord(aItem: TListItem): Boolean; override;
      procedure UpdateRecord; override;
      procedure SelectItem(aItem: TListItem; aSelected: Boolean); override;
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary); override;
      function  SynchronizeMessage: String; override;
      function  ValidateEntry(aItem: TListItem): Boolean; override;

    public
      class function PageName: String; override;

  end; {class, TdaDDFieldPage}

  { TdaDDJoinPage }
  TdaDDJoinPage = class(TdaDDListViewPage)
    private
      FCancelButton: TButton;
      FSaveButton: TButton;
      FTopPanel: TPanel;
      FMiddlePanel: TPanel;
      FBottomPanel: TPanel;
      FJoinPanel: TdaJoinPanel;

      procedure ModifyMenuClickEvent(Sender: TObject);

    protected
      procedure AddMenuClickEvent(Sender: TObject); override;
      procedure CancelMenuClickEvent(Sender: TObject); override;
      procedure ChangeEvent(Sender: TObject); override;
      function  GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; override;
      function  SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean; override;
      procedure CreateControls; override;
      function  EmptyEntry: Boolean; override;
      function  GenerateMessage: String; override;
      procedure HideEditControls; override;
      procedure ListViewColumnResizeEvent(aListView: TListView; aColumn: TListColumn); override;
      procedure ListViewDblClickEvent(Sender: TObject); override;
      procedure ListViewScrollEvent(Sender: TObject); override;
      function  LocateRecord(aItem: TListItem): Boolean; override;
      procedure PopupMenuPopupEvent(Sender: TObject); override;
      procedure UpdateRecord; override;
      procedure SaveMenuClickEvent(Sender: TObject); override;
      procedure SelectItem(aItem: TListItem; aSelected: Boolean); override;
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary); override;
      function  SynchronizeMessage: String; override;
      function  ValidateEntry(aItem: TListItem): Boolean; override;

    public
      class function PageName: String; override;

      destructor Destroy; override;

  end; {class, TdaDDJoinPage}

var
  daDataDictionaryBuilderForm: TdaDataDictionaryBuilderForm;

implementation

{$R *.DFM}

{******************************************************************************
 *
 ** Q U E R Y   E D I T O R   F O R M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.FormCreate }

procedure TdaDataDictionaryBuilderForm.FormCreate(Sender: TObject);
begin

  FActivePage := -1;
  FBringingForward := False;
  FEditPage := nil;
  FPages := TList.Create;
  FProcessing := False;
  FDataDictionary := nil;
  FSession := nil;
  FWalkieTalkie := TppCommunicator.Create(Self);

  FWalkieTalkie.OnNotify := WalkieTalkieNotifyEvent;

  LoadStateInfo;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.FormDestroy }

procedure TdaDataDictionaryBuilderForm.FormDestroy(Sender: TObject);
begin

  if (FDataDictionary <> nil) then
    FDataDictionary.ComponentDesigner := nil;

  FreePages;

  FPages.Free;
  FSession.Free;
  FWalkieTalkie.Free;

end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.PageStartProcessEvent }

procedure TdaDataDictionaryBuilderForm.PageStartProcessEvent(Sender: TObject);
begin
  Cursor := crHourGlass;

  FProcessing := True;

  pgcMain.Enabled := False;
end; {procedure, PageStartProcessEvent}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.PageEndProcessEvent }

procedure TdaDataDictionaryBuilderForm.PageEndProcessEvent(Sender: TObject);
begin
  FProcessing := False;

  BringForward;

  pgcMain.Enabled := True;

  Cursor := crDefault;
end; {procedure, PageEndProcessEvent}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.FreePages }

procedure TdaDataDictionaryBuilderForm.FreePages;
var
  liIndex: Integer;
begin

  if (FPages = nil) then Exit;

  for liIndex := 0 to FPages.Count - 1 do
    TObject(FPages[liIndex]).Free;

  FPages.Clear;

  FSQL.Free;
  FSQL := nil;
  
end; {procedure, FreePages}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.BringForward }

procedure TdaDataDictionaryBuilderForm.BringForward;
begin
  FBringingForward := True;

  BringToFront;

  FBringingForward := False;
end; {procedure, BringForward}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.Notification }

procedure TdaDataDictionaryBuilderForm.WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FSession) then
    FSession := nil

  else if (aCommunicator = FDataDictionary) then
    begin
      inherited SetComponent(nil);

      FDataDictionary := nil;
    end;

end;  {procedure, WalkieTalkieNotifyEvent}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.CreatePages }

procedure TdaDataDictionaryBuilderForm.CreatePages;
var
  liIndex: Integer;
begin

  FSQL := TdaSQL.Create(Self);
  FSQL.DataDictionary := FDataDictionary;
  FSQL.DatabaseName := FDataDictionary.BuilderSettings.DatabaseName;
  FSQL.DatabaseType := FSession.GetDatabaseType(FDataDictionary.BuilderSettings.DatabaseName);
  FSQL.Session := FSession;

  FPages.Add(TdaDDTablePage.CreatePage(Self, pgcMain, FSession, FDataDictionary, FSQL));
  FPages.Add(TdaDDFieldPage.CreatePage(Self, pgcMain, FSession, FDataDictionary, FSQL));

  if (FDataDictionary <> nil) and FDataDictionary.AutoJoin then
    FPages.Add(TdaDDJoinPage.CreatePage(Self, pgcMain, FSession, FDataDictionary, FSQL));

  for liIndex := 0 to FPages.Count - 1 do
    begin
      TdaDDEditPage(FPages[liIndex]).OnStartProcess := PageStartProcessEvent;
      TdaDDEditPage(FPages[liIndex]).OnEndProcess := PageEndProcessEvent;
    end;

end;  {procedure, CreatePages}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.FormActivate }

procedure TdaDataDictionaryBuilderForm.FormActivate(Sender: TObject);
begin

  if (FBringingForward) or (FProcessing) then Exit;
  
  FreePages;

  if not(ValidSettings) then
    begin
      stbStatus.SimpleText := FDataDictionary.ErrorMessage;

      pgcMain.Enabled := False;

      Exit;
    end
  else
    begin
      stbStatus.SimpleText := 'Ready.';

      pgcMain.Enabled := True;
    end;

  {create pages for first time}
  CreatePages;

  LoadPageStates;

  {create or free joins page depending on AutoJoin}
  if not(FDataDictionary.AutoJoin) and (FPages.Count = 3) then
    begin
      TdaDDEditPage(FPages[2]).Free;

      FPages.Delete(2);

      FActivePage := 0;
    end

  else if (FDataDictionary.AutoJoin) and (FPages.Count = 2) then
    FPages.Add(TdaDDJoinPage.CreatePage(Self, pgcMain, FSession, FDataDictionary, FSQL));


  if (FActivePage >= FPages.Count) then
    FActivePage := 0;

  pgcMain.ActivePage := TdaDDEditPage(FPages[FActivePage]).TabSheet;

  ActivatePage;

end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.FormClose }

procedure TdaDataDictionaryBuilderForm.FormDeactivate(Sender: TObject);
begin
  pgcMain.Enabled := False;
end; {procedure, FormDeactivate}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.FormClose }

procedure TdaDataDictionaryBuilderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  
  SaveStateInfo;
end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.ActivatePage }

procedure TdaDataDictionaryBuilderForm.ActivatePage;
begin

  FEditPage := TdaDDEditPage(pgcMain.ActivePage.Tag);

  FEditPage.Activate;

end; {procedure, ActivatePage}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.pgcMainChange }

procedure TdaDataDictionaryBuilderForm.pgcMainChange(Sender: TObject);
begin
  FActivePage := pgcMain.ActivePage.PageIndex;
  
  ActivatePage;
end; {procedure, pgcMainChange}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.SetComponent }

procedure TdaDataDictionaryBuilderForm.SetComponent(aComponent: TComponent);
begin

  inherited SetComponent(aComponent);

  if (aComponent is TppDataDictionary) then
    SetDataDictionary(TppDataDictionary(aComponent));

end; {procedure, SetComponent}


{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.SetDataDictionary }

procedure TdaDataDictionaryBuilderForm.SetDataDictionary(aDataDictionary: TppDataDictionary);
var
  liIndex: Integer;
  lEditPage: TdaDDEditPage;
  lSessionClass: TdaSessionClass;
begin

  if (FDataDictionary <> nil) then
    FDataDictionary.RemoveEventNotify(FWalkieTalkie);

  FDataDictionary := aDataDictionary;

  if (FDataDictionary <> nil) then
    FDataDictionary.AddEventNotify(FWalkieTalkie);

  if (FSession <> nil) then
    FSession.Free;

  lSessionClass := daGetSessionClass(FDataDictionary.BuilderSettings.SessionType);

  if (lSessionClass = nil) then Exit;

  FSession := lSessionClass.Create(Self);
  FSession.DataOwner := FDataDictionary.Owner;
  FSession.AddNotify(FWalkieTalkie);

  if (FPages <> nil) then
    for liIndex := 0 to FPages.Count - 1 do
      begin
        lEditPage := TdaDDEditPage(FPages[liIndex]);

        lEditPage.DataDictionary := FDataDictionary;
        lEditPage.Session := FSession;
      end;

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.ValidSettings }

function TdaDataDictionaryBuilderForm.ValidSettings: Boolean;
var
  lTableNames: TStrings;
  lSessionClass: TdaSessionClass;
begin

  Result := False;

  SetErrorMessage('');

  if (FDataDictionary = nil) then
    begin
      SetErrorMessage('DataDictionary property is not assigned.');

      Exit;
    end;

  if not(FDataDictionary.ValidSettings) then
    begin
      SetErrorMessage(FDataDictionary.ErrorMessage);

      Exit;
    end;

  if (FDataDictionary.BuilderSettings.SessionType = '') then
    begin
      SetErrorMessage('DataDictionary.BuilderSettings.SessionType is not assigned.');

      Exit;
    end;

  if (FDataDictionary.BuilderSettings.DatabaseName = '') then
    begin
      SetErrorMessage('DataDictionary.BuilderSettings.DatabaseName is not assigned.');

      Exit;
    end;

  if (FSession = nil) then
    begin
      lSessionClass := daGetSessionClass(FDataDictionary.BuilderSettings.SessionType);

      if (lSessionClass = nil) then
        begin
          SetErrorMessage('Session class could not be found for SessionType: ' + FDataDictionary.BuilderSettings.SessionType);

          Exit;
        end;

      FSession := lSessionClass.Create(Self);
      FSession.DataOwner := FDataDictionary.Owner;
      FSession.AddNotify(FWalkieTalkie);
    end;

  lTableNames := TStringList.Create;

  try
    try
      FSession.GetTableNames(FDataDictionary.BuilderSettings.DatabaseName, lTableNames);
    except
      SetErrorMessage('Could not connect to the database: ' + FDataDictionary.BuilderSettings.DatabaseName);
    end;
  finally
    lTableNames.Free;
  end;

  Result := True;

end; {function, ValidSettings}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.SelectionChanged }

procedure TdaDataDictionaryBuilderForm.SelectionChanged(aSelection: TppDesignerSelectionList);
begin


end;  {function, SelectionChanged}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.LoadStateInfo }

procedure TdaDataDictionaryBuilderForm.LoadStateInfo;
var
  lIniStorage: TppIniStorage;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
  liWindowState: Integer;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  liWindowState := lIniStorage.ReadInteger('Data Dictionary Builder', 'WindowState', Ord(wsNormal));

  if TWindowState(liWindowState) = wsNormal then
    begin
      liLeft   := lIniStorage.ReadInteger('Data Dictionary Builder', 'Left',   Left);
      liTop    := lIniStorage.ReadInteger('Data Dictionary Builder', 'Top',    Top);
      liWidth  := lIniStorage.ReadInteger('Data Dictionary Builder', 'Width',  Width);
      liHeight := lIniStorage.ReadInteger('Data Dictionary Builder', 'Height', Height);

      SetBounds(liLeft, liTop, liWidth, liHeight);
    end;

  if TWindowState(liWindowState) <> wsMinimized then
    WindowState :=  TWindowState(liWindowState);

  lIniStorage.Free;

end;  {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.LoadPageStates }

procedure TdaDataDictionaryBuilderForm.LoadPageStates;
var
  lIniStorage: TppIniStorage;
  liIndex: Integer;
  lPage: TdaDDListViewPage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  if (FActivePage = -1) then
    begin
      FActivePage := lIniStorage.ReadInteger('Data Dictionary Builder', 'Active Page', 0);

      if (FActivePage >= FPages.Count) then
        FActivePage := 0;
    end;

  for liIndex := 0 to FPages.Count - 1 do
    begin
      lPage := TdaDDListViewPage(FPages[liIndex]);

      lPage.LoadStateInfo(lIniStorage);
    end;

  lIniStorage.Free;

end; {procedure, LoadPageStates}

{------------------------------------------------------------------------------}
{ TdaDataDictionaryBuilderForm.SaveStateInfo }

procedure TdaDataDictionaryBuilderForm.SaveStateInfo;
var
  lIniStorage: TppIniStorage;
  liIndex: Integer;
  lPage: TdaDDListViewPage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lIniStorage.WriteInteger('Data Dictionary Builder', 'WindowState', Ord(WindowState));
  lIniStorage.WriteInteger('Data Dictionary Builder', 'Left',   Left);
  lIniStorage.WriteInteger('Data Dictionary Builder', 'Top',    Top);
  lIniStorage.WriteInteger('Data Dictionary Builder', 'Width',  Width);
  lIniStorage.WriteInteger('Data Dictionary Builder', 'Height', Height);

  lIniStorage.WriteInteger('Data Dictionary Builder', 'Active Page', pgcMain.ActivePage.TabIndex);

  for liIndex := 0 to FPages.Count - 1 do
    begin
      lPage := TdaDDListViewPage(FPages[liIndex]);

      lPage.SaveStateInfo(lIniStorage);
    end;

  lIniStorage.Free;

end; {procedure, SaveStateInfo}

{******************************************************************************
 *
 ** E D I T   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.CreatePage }

constructor TdaDDEditPage.CreatePage(aOwner: TComponent; aPageControl: TPageControl; aSession: TdaSession; aDataDictionary: TppDataDictionary; aSQL: TdaSQL);
begin

  inherited Create(aOwner);

  FOnStartProcess := nil;
  FOnEndProcess := nil;

  FDataDictionary := TppDataDictionary.Create(Self);

  FTabSheet := TTabSheet.Create(Self);
  FTabSheet.Parent := aPageControl;
  FTabSheet.PageControl := aPageControl;
  FTabSheet.Caption := PageName;
  FTabSheet.Tag := Integer(Self);

  FFieldNames := TStringList.Create;

  SetDataDictionary(aDataDictionary);

  FSession := aSession;
  FSQL := aSQL;
  
  FModified := False;

end; {constructor, CreatePage}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.Destroy }

destructor TdaDDEditPage.Destroy;
begin

  FFieldNames.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.Notify }

procedure TdaDDEditPage.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if not(aOperation = ppopRemove) then Exit;

  if (aCommunicator = FDataDictionary) then
    FDataDictionary := nil

  else if (aCommunicator = FSession) then
    FSession := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.DoOnStartProcess }

procedure TdaDDEditPage.DoOnStartProcess;
begin
  if Assigned(FOnStartProcess) then FOnStartProcess(Self);
end; {procedure, DoOnStartProcess}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.DoOnEndProcess }

procedure TdaDDEditPage.DoOnEndProcess;
begin
  if Assigned(FOnEndProcess) then FOnEndProcess(Self);
end; {procedure, DoOnEndProcess}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.SetSession }

procedure TdaDDEditPage.SetSession(aSession: TdaSession);
begin

  if (FSession <> nil) then
    FSession.RemoveNotify(Self);

  FSession := aSession;

  if (FSession <> nil) then
    FSession.AddNotify(Self);

end; {procedure, SetSession}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.SetDataDictionary }

procedure TdaDDEditPage.SetDataDictionary(aDataDictionary: TppDataDictionary);
begin

  {create local copy of data dictionary for retrieving table and field names}
  FDataDictionary.Assign(aDataDictionary);

  FDataDictionary.AutoJoin := False;
  FDataDictionary.ValidateFieldNames := False;
  FDataDictionary.ValidateTableNames := False;

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.PageName }

class function TdaDDEditPage.PageName: String;
begin
  Result := ClassName;
end; {class function, PageName}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.Activate }

procedure TdaDDEditPage.Activate;
begin

  if (FInitialized) and not(OutOfSync) then Exit;

  FSettingControls := True;

  if not(FInitialized) then
    begin
      CreateControls;

      SetSortDescription;

      DataToControls;

      FInitialized := True;
    end

  else if OutOfSync then
    DataToControls;

  FSettingControls := False;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.Reset }

procedure TdaDDEditPage.Reset;
begin

  FreeControls;

  FInitialized := False;

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.FreeControls }

procedure TdaDDEditPage.FreeControls;
var
  liIndex: Integer;
  lComponent: TComponent;
begin

  for liIndex := ComponentCount - 1 downto 0 do
    begin
      lComponent := Components[liIndex];

      lComponent.Free;
    end;

end; {procedure, FreeControls}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.DataToItem }

procedure TdaDDEditPage.DataToItem(aItem: TListItem);
var
  liIndex: Integer;
begin

  for liIndex := 0 to FFieldNames.Count - 1 do
    begin

      if (liIndex = 0) then
        aItem.Caption := DataPipeline.GetFieldAsString(FFieldNames[liIndex])

      else
        begin
          if ((liIndex - 1) = aItem.SubItems.Count) then
            aItem.SubItems.Add('');

          aItem.SubItems[liIndex - 1] := DataPipeline.GetFieldAsString(FFieldNames[liIndex]);
        end;
    end;

end; {procedure, DataToItem}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.BooleanToText }

function TdaDDEditPage.BooleanToText(aBoolean: Boolean): String;
begin
  if (aBoolean) then
    Result := 'T'
  else
    Result := 'F';
end; {procedure, BooleanToText}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.OpenDataSet }

function TdaDDEditPage.OpenDataSet(aDataSet: TdaDataSet): Boolean;
var
  lsMessage: String;
  lsMessage1: String;
  lsMessage2: String;
begin

  Result := False;

  try
    aDataSet.Active := True;
  except
    on E:Exception do
      begin
        {message: Unable to open table: <name>.}
        lsMessage1 := ppLoadStr(839);
        lsMessage1 := ppSetMessageParameters(lsMessage1);
        lsMessage1 := Format(lsMessage1, [aDataSet.DataName]);

        {message: Error: <errormessage>}
        lsMessage2 := ppLoadStr(840);
        lsMessage2 := ppSetMessageParameters(lsMessage2);
        lsMessage2 := Format(lsMessage2, [E.Message]);

        lsMessage := lsMessage1 + #13#10 + #13#10 + lsMessage2;

        MessageDlg(lsMessage, mtError, [mbOK], 0);

        aDataSet.Free;

        Exit;
      end;
  end; {try, except}

  Result := True;

end; {function, OpenDataSet}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.GetTableNames }

procedure TdaDDEditPage.GetTableNames(aTableNames: TStrings);
var
  lTableAliases: TStringList;
begin

  if not(Self is TdaDDTablePage) then
    begin
      lTableAliases := TStringList.Create;

      FDataDictionary.GetTableNames(aTableNames, lTableAliases);

      lTableAliases.Free;
      
      Exit;
    end;

  {get raw table names from session}
  FSession.GetTableNames(FDataDictionary.BuilderSettings.DatabaseName, aTableNames);

  {strip off owner names}
  StripOffOwnerNames(aTableNames);

  {remove end-user tables, if we can find them}
  RemoveEndUserTables(aTableNames);
  
end; {function, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.TableNameToSQLString }

function TdaDDEditPage.TableNameToSQLString(const aTableName: String): String;
var
  lsTableName: String;
  lsOwner: String;
  lbFileBased: Boolean;
begin

  lsTableName := aTableName;

  if (FDataDictionary.UseTableOwnerName) then
    begin
      ppStripOffTableName(aTableName, lsTableName, lsOwner, lbFileBased);

      if not(lbFileBased) and (Length(lsOwner) > 0) then
        begin
          FSQL.NameToSQLString(lsOwner);
          FSQL.NameToSQLString(lsTableName);

          lsTableName :=  lsOwner + '.' + lsTableName;
        end
        
      else
        FSQL.NameToSQLString(lsTableName);
    end

  else
    FSQL.NameToSQLString(lsTableName);


  Result := lsTableName;

end; {function, TableNameToSQLString}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.StripOffOwnerNames }

procedure TdaDDEditPage.StripOffOwnerNames(aTableNames: TStrings);
var
  liIndex: Integer;
  lsTableName: String;
  lsRawTableName: String;
  lsOwner: String;
  lbFileBased: Boolean;
begin

  if (FDataDictionary.UseTableOwnerName) then Exit;

  for liIndex := 0 to aTableNames.Count - 1 do
    begin
      lsRawTableName := aTableNames[liIndex];

      ppStripOffTableName(lsRawTableName, lsTableName, lsOwner, lbFileBased);

      if not(lbFileBased) then
        aTableNames[liIndex] := lsTableName;
    end;

end; {procedure, StripOffOwnerNames}

{------------------------------------------------------------------------------}
{ TdaDDEditPage.RemoveEndUserTables }

procedure TdaDDEditPage.RemoveEndUserTables(aTableNames: TStrings);
var
  lEndUserTables: TStringList;
  lsEndUserTable: String;
  lsTableName: String;
  liIndex: Integer;
  liIndex2: Integer;
  lsRawTableName: String;
  lsOwner: String;
  lbFileBased: Boolean;
  lbFound: Boolean;
begin

  lEndUserTables := TStringList.Create;

  lEndUserTables.Add('RB_TABLE');
  lEndUserTables.Add('RB_FIELD');
  lEndUserTables.Add('RB_JOIN');
  lEndUserTables.Add('RB_FOLDER');
  lEndUserTables.Add('RB_ITEM');

  lEndUserTables.Add('RBTABLE');
  lEndUserTables.Add('RBFIELD');
  lEndUserTables.Add('RBJOIN');
  lEndUserTables.Add('RBFOLDER');
  lEndUserTables.Add('RBITEM');

  for liIndex := 0 to lEndUserTables.Count - 1 do
    begin
      lsEndUserTable := lEndUserTables[liIndex];

      liIndex2 := 0;
      lbFound := False;

      while (liIndex2 < aTableNames.Count) and not(lbFound) do
        begin
          lsRawTableName := aTableNames[liIndex2];

          ppStripOffTableName(lsRawTableName, lsTableName, lsOwner, lbFileBased);

          if (CompareText(lsEndUserTable, lsTableName)  = 0) then
            begin
              aTableNames.Delete(liIndex2);

              lbFound := True;
            end
          else
            Inc(liIndex2);

        end;

    end;

  lEndUserTables.Free;

end; {procedure, RemoveEndUserTables}

{******************************************************************************
 *
 ** L I S T   V I E W   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.CreatePage }

constructor TdaDDListViewPage.CreatePage(aOwner: TComponent; aPageControl: TPageControl; aSession: TdaSession; aDataDictionary: TppDataDictionary; aSQL: TdaSQL);
begin

  inherited CreatePage(aOwner, aPageControl, aSession, aDataDictionary, aSQL);

  FAdding := False;
  FAlwaysRowSelect := False;
  FCancelDialog := nil;
  FColumnSizes := TList.Create;
  FEmpty := False;
  FLastItem := nil;
  FListView := nil;
  FPopupMenu := nil;
  FSaving := False;
  FSortMode := 1;

end; {constructor, CreatePage}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.Destroy }

destructor TdaDDListViewPage.Destroy;
begin

  FColumnSizes.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.LoadStateInfo }

procedure TdaDDListViewPage.LoadStateInfo(aIniStorage: TppIniStorage);
var
  lsColumnName: String;
  liIndex: Integer;
begin

  FSortMode := aIniStorage.ReadInteger('Data Dictionary Builder', PageName + ' Sort Mode', 1);

  FColumnSizes.Clear;

  for liIndex := 0 to FFieldNames.Count - 1 do
    begin
      lsColumnName := PageName + ' ' + FFieldNames[liIndex] + 'Width';

      FColumnSizes.Add(TObject(aIniStorage.ReadInteger('Data Dictionary Builder', lsColumnName, 200)));
    end;

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.SaveStateInfo }

procedure TdaDDListViewPage.SaveStateInfo(aIniStorage: TppIniStorage);
var
  lsColumnName: String;
  liIndex: Integer;
begin

  if (FListView = nil) or (FListView.Columns.Count = 0) or (FListView.Columns.Count <> FFieldNames.Count) then Exit;

  aIniStorage.WriteInteger('Data Dictionary Builder', PageName + ' Sort Mode', FSortMode);

  for liIndex := 0 to FFieldNames.Count - 1 do
    begin
      lsColumnName := PageName + ' ' + FFieldNames[liIndex] + 'Width';

      aIniStorage.WriteInteger('Data Dictionary Builder', lsColumnName, FListView.Columns[liIndex].Width);
    end;

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.Activate }

procedure TdaDDListViewPage.Activate;
begin

  inherited Activate;

  {select first row}
  if (FListView.Items.Count > 0) then
    begin
      FListView.Selected := nil;
      FListView.Selected := FListView.Items[0];
    end;

  HideEditControls;
  
end; {function, Activate}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.OutOfSync }

function TdaDDListViewPage.OutOfSync: Boolean;
begin
  Result := False;
end; {function, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.Valid }

function  TdaDDListViewPage.Valid: Boolean;
begin
  Result := True;
end; {function, Valid}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.CreateControls }

procedure TdaDDListViewPage.CreateControls;
var
  lColumn: TListColumn;
  liIndex: Integer;
  lMenuItem: TMenuItem;
begin

  if (FDataDictionary = nil) then Exit;


  FPopupMenu := TPopupMenu.Create(Self);
  
  TabSheet.PopupMenu := FPopupMenu;

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '&Add';
  lMenuItem.OnClick := AddMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '-';
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '&Save';
  lMenuItem.OnClick := SaveMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '&Cancel';
  lMenuItem.OnClick := CancelMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '-';
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '&Generate';
  lMenuItem.OnClick := GenerateMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '-';
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := 'S&ynchronize';
  lMenuItem.OnClick := SynchronizeMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '-';
  lMenuItem.OnClick := SynchronizeMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '&Delete';
  lMenuItem.OnClick := DeleteMenuClickEvent;
  FPopupMenu.Items.Add(lMenuItem);

  FPopupMenu.OnPopup := PopupMenuPopupEvent;

  FListView := TppListView.Create(Self);
  FListView.Parent := TabSheet;
  FListView.Align := alClient;
  FListView.ViewStyle := vsReport;
  FListView.ReadOnly := True;
  FListView.ColumnClick := True;
  FListView.MultiSelect := True;

  {forces rows to height of imagelist}
  FListView.SmallImages := TImageList.Create(Self);;
  FListView.SmallImages.Height := 20;
  FListView.SmallImages.Width := 3;

  {assign event handlers}
  FListView.OnColumnClick := ListViewColumnClickEvent;
  FListView.OnClick := ListViewClickEvent;
  FListView.OnDblClick := ListViewDblClickEvent;
  FListView.OnCompare := ListViewCompareEvent;
  FListView.OnChanging := ListViewChangingEvent;
  FListView.OnColumnResize := ListViewColumnResizeEvent;
  FListView.OnScroll := ListViewScrollEvent;
  FListView.OnSelectItem := ListViewSelectItemEvent;

  {create columns}
  for liIndex := 0 to FFieldNames.Count - 1 do
    begin
      lColumn := FListView.Columns.Add;
      lColumn.Width := Integer(FColumnSizes[liIndex]);
      lColumn.Caption := FFieldNames[liIndex];
    end;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.DataToControls }

procedure TdaDDListViewPage.DataToControls;
var
  lItem: TListItem;
  liIndex: Integer;
  lbCloseDataSource: Boolean;
  lbOpenDataSource: Boolean;
begin

  if (DataPipeline = nil) then Exit;

  FSettingControls := True;

  {save datapipeline settings}
  lbCloseDataSource := TppDBPipeline(DataPipeline).CloseDataSource;
  lbOpenDataSource  := TppDBPipeline(DataPipeline).OpenDataSource;

  try
    {overide datapipeline settings}
    TppDBPipeline(DataPipeline).CloseDataSource := True;
    TppDBPipeline(DataPipeline).OpenDataSource  := True;

    {close and open the datapipeline to refresh the data}
    DataPipeline.Close;
    DataPipeline.Open;

  finally
    {restore datapipeline settings}
    TppDBPipeline(DataPipeline).CloseDataSource := lbCloseDataSource;
    TppDBPipeline(DataPipeline).OpenDataSource  := lbOpenDataSource;
    
  end;

  DataPipeline.First;

  FListView.Items.BeginUpdate;

  FListView.Items.Clear;

  while not(DataPipeline.EOF) do
    begin
      lItem := FListView.Items.Add;

      lItem.Caption := DataPipeline.GetFieldAsString(FFieldNames[0]);

      for liIndex := 1 to FFieldNames.Count - 1 do
        lItem.SubItems.Add(DataPipeline.GetFieldAsString(FFieldNames[liIndex]));

      DataPipeline.Next;
    end;

  FListView.Refresh;

  FListView.AlphaSort;

  FListView.Items.EndUpdate;

  FSettingControls := False;

end; {procedure, DataToControls}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.SaveChanges }

function TdaDDListViewPage.SaveChanges(aItem: TListItem): Boolean;
begin

  Result := True;

  if (aItem = nil) then Exit;

  if not(FModified) then Exit;


  FEmpty := EmptyEntry;

  if not(FEmpty) then
    Result := ValidateEntry(aItem);

  if not(Result) then Exit;


  if (FAdding) then
    begin
      if not(FEmpty) then
        begin
          FAdding := False;
          FModified := False;

          DataPipeline.Insert;

          UpdateRecord;

          DataPipeline.Post;
        end;
    end

  else if LocateRecord(aItem) then
    begin
      FModified := False;

      if (FEmpty) then
        DataPipeline.Delete
      else
        begin
         DataPipeline.Edit;

         UpdateRecord;

         DataPipeline.Post;
        end;
    end;

  {update item with data from controls}
  if not(FEmpty) then
    DataToItem(aItem);

end; {procedure, SaveChanges}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewClickEvent }

procedure TdaDDListViewPage.ListViewClickEvent(Sender: TObject);
var
  lPoint: TPoint;
  lItem: TListItem;
begin

  GetCursorPos(lPoint);

  lPoint := FListView.ScreenToClient(lPoint);

  lItem := FListView.GetItemAt(lPoint.X, lPoint.Y);

  if (lItem = nil) then
    begin
      lItem := FListView.GetItemAt(2, lPoint.Y);

      FListView.Selected := lItem;
    end;

  if (FListView.SelCount > 1) then
    HideEditControls;

end; {procedure, ListViewClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.PopupMenuPopupEvent }

procedure TdaDDListViewPage.PopupMenuPopupEvent(Sender: TObject);
var
  liIndex: Integer;
begin

  for liIndex :=  0 to FPopupMenu.Items.Count - 1 do
    begin
      if (CompareText('&Save', FPopupMenu.Items[liIndex].Caption) = 0) or
         (CompareText('&Cancel', FPopupMenu.Items[liIndex].Caption) = 0) then
        FPopupMenu.Items[liIndex].Enabled := (FAdding or FModified)

      else if (CompareText('&Delete', FPopupMenu.Items[liIndex].Caption) = 0) or
              (CompareText('&Modify', FPopupMenu.Items[liIndex].Caption) = 0) then
        FPopupMenu.Items[liIndex].Enabled := (FListView.SelCount > 0) and not(FAdding or FModified)

      else
        FPopupMenu.Items[liIndex].Enabled := not(FAdding or FModified);

    end;

end; {procedure, PopupMenuPopupEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ChangeEvent }

procedure TdaDDListViewPage.ChangeEvent(Sender: TObject);
var
  lItem: TListItem;
  liIndex: Integer;
  lsOriginalValue: String;
  lsCurrentValue: String;
begin

  if FSaving then Exit;
  if FSettingControls then Exit;

  lItem := FListView.Selected;

  if (lItem = nil) then Exit;

  liIndex := TComponent(Sender).Tag;

  if (liIndex = -1) then
    lsOriginalValue := lItem.Caption
  else
    lsOriginalValue := lItem.SubItems[liIndex];

  if (Sender is TEdit) then
    lsCurrentValue := TEdit(Sender).Text

  else if (Sender is TCheckBox) then
    lsCurrentValue := BooleanToText(TCheckBox(Sender).Checked)

  else if (Sender is TComboBox) then
    lsCurrentValue := TComboBox(Sender).Items[TComboBox(Sender).ItemIndex];

  FModified := (lsCurrentValue <> lsOriginalValue);

end; {procedure, ChangeEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.AddMenuClickEvent }

procedure TdaDDListViewPage.AddMenuClickEvent(Sender: TObject);
var
  lItem: TListItem;
  liIndex: Integer;
begin

  FListView.Items.BeginUpdate;

  lItem := FListView.Selected;

  if (lItem <> nil) then
    lItem := FListView.Items.Insert(lItem.Index)
  else
    lItem := FListView.Items.Add;

  for liIndex := 1 to FFieldNames.Count - 1 do
    lItem.SubItems.Add('');

  FListView.Selected := nil;

  FAdding := True;

  FLastItem := lItem;

  FListView.Selected := lItem;

  FModified := True;

  FListView.Items.EndUpdate;

end; {procedure, AddMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.CancelMenuClickEvent }

procedure TdaDDListViewPage.CancelMenuClickEvent(Sender: TObject);
var
  lbFreeItem: Boolean;
begin

  {update item with data from controls}
  FSaving := True;

  lbFreeItem := FAdding;

  SaveChanges(FLastItem);

  FAdding := False;
  FModified := False;
  
  if lbFreeItem then
    FLastItem.Free;

  FSaving := False;

end; {function, CancelMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.SaveMenuClickEvent }

procedure TdaDDListViewPage.SaveMenuClickEvent(Sender: TObject);
begin

  FSaving := True;

  SaveChanges(FLastItem);

  if not(FAdding) then
    begin
      FLastItem := nil;

      HideEditControls;
    end;

  FSaving := False;

end; {function, SaveMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.GenerateMenuClickEvent }

procedure TdaDDListViewPage.GenerateMenuClickEvent(Sender: TObject);
var
  lbChanges: Boolean;
begin

  if (DataPipeline = nil) then Exit;

  DoOnStartProcess;

  HideEditControls;

  lbChanges := False;

  try
    CreateCancelDialog('Generate', GenerateMessage);

    {add records which do not have matching items}
    if GenerateItems(DataPipeline, FListView.Items) then
      lbChanges := True;

  finally
    FreeCancelDialog;
  end;

  if lbChanges then
    DataToControls;

  DoOnEndProcess;

end; {procedure, GenerateMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.SynchronizeMenuClickEvent }

procedure TdaDDListViewPage.SynchronizeMenuClickEvent(Sender: TObject);
var
  lbChanges: Boolean;
begin

  if (DataPipeline = nil) then Exit;

  DoOnStartProcess;

  HideEditControls;

  lbChanges := False;

  try
    CreateCancelDialog('Synchronize', SynchronizeMessage);

    {remove items which do not have matching records}
    if SynchronizeItems(DataPipeline, FListView.Items) then
      lbChanges := True;

  finally
    FreeCancelDialog;
  end;

  if lbChanges then
    DataToControls;
    
  DoOnEndProcess;

end; {procedure, SynchronizeMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.DeleteMenuClickEvent }

procedure TdaDDListViewPage.DeleteMenuClickEvent(Sender: TObject);
var
  liIndex: Integer;
  lItem: TListItem;
  lbChanges: Boolean;
begin

  if (DataPipeline = nil) then Exit;

  DoOnStartProcess;

  HideEditControls;

  lbChanges := False;

  for liIndex := 0 to FListView.Items.Count - 1 do
    begin
      lItem := FListView.Items[liIndex];

      if lItem.Selected and LocateRecord(lItem) then
        begin
          DataPipeline.Delete;

          lbChanges := True;
        end;
    end;

  if (lbChanges) then
    begin
      DataToControls;

      SelectItem(nil, False);
    end;

  DoOnEndProcess;

end; {procedure, DeleteMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.CreateCancelDialog }

procedure TdaDDListViewPage.CreateCancelDialog(const aCaption, aMessage: String);
var
  lFormClass: TFormClass;
  lPoint: TPoint;
begin

  lFormClass := ppGetFormClass(TppCustomCancelDialog);

  FCancelDialog := TppCustomCancelDialog(lFormClass.Create(Application));

  FCancelDialog.AllowPrintCancel := True;
  FCancelDialog.Caption := aCaption;
  FCancelDialog.Position := poDesigned;
  FCancelDialog.PrintProgress := aMessage;
  FCancelDialog.ppOnCancel := CancelDialogCancelEvent;
  FCancelDialog.ppOnDestroy := CancelDialogDestroyEvent;

  lPoint := FListView.ClientToScreen(Point(FListView.Left, FListView.Top));

  FCancelDialog.Left := lPoint.X + ((FListView.Width - FCancelDialog.Width) div 2);
  FCancelDialog.Top := lPoint.Y + ((FListView.Height - FCancelDialog.Height) div 2);

  FStop := False;

  FCancelDialog.Show;

end; {procedure, CreateCancelDialog}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.FreeCancelDialog }

procedure TdaDDListViewPage.FreeCancelDialog;
begin

  if (FCancelDialog <> nil) then
    FCancelDialog.Free;

end; {procedure, FreeCancelDialog}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.CancelDialogCancelEvent }

procedure TdaDDListViewPage.CancelDialogCancelEvent(Sender: TObject);
begin
  FStop := True;
end; {procedure, CancelDialogCancelEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.CancelDialogDestroyEvent }

procedure TdaDDListViewPage.CancelDialogDestroyEvent(Sender: TObject);
begin
  FCancelDialog := nil;
end; {procedure, CancelDialogDestroyEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewChangingEvent }

procedure TdaDDListViewPage.ListViewChangingEvent(Sender: TObject; Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin

  if (FSettingControls) or (FSaving) or (csDestroying in ComponentState) then Exit;


  if (FModified) and (Item = FLastItem) then
    AllowChange := False

  else if (Item <> FLastItem) then
    begin
      FSaving := True;

      FEmpty := EmptyEntry;

      if FAdding then
         begin
           if FEmpty or not(SaveChanges(FLastItem)) then
             AllowChange := False;
         end

      else if FModified then
        begin
          if (FEmpty) and LocateRecord(FLastItem) then
            begin
              DataPipeline.Delete;

              FLastItem.Free;
            end

          else if not(SaveChanges(FLastItem)) then
            AllowChange := False;
        end;

      FSaving := False;
    end;


end; {procedure, ListViewChangingEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewSelectItemEvent }

procedure TdaDDListViewPage.ListViewSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
begin

  if (csDestroying in ComponentState) then Exit;

  if (FSettingControls) then
    begin
      FLastItem := nil;
      
      Exit;
    end;

  if not(FAlwaysRowSelect) then
    if (FListView.SelCount < 2) then
      FListView.RowSelect := False
    else
      FListView.RowSelect := True;
    
  if (FListView.SelCount = 1) then
    FLastItem := Item
  else
    FLastItem := nil;

  SelectItem(Item, Selected);

end; {procedure, ListViewSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewColumnResizeEvent }

procedure TdaDDListViewPage.ListViewColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
begin
  ListViewSelectItemEvent(Self, FListView.Selected, True);
end; {procedure, ListViewColumnResizeEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewScrollEvent }

procedure TdaDDListViewPage.ListViewScrollEvent(Sender: TObject);
begin
  HideEditControls;
end; {procedure, ListViewScrollEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewCompareEvent }

procedure TdaDDListViewPage.ListViewCompareEvent(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  liIndex: Integer;
begin

  case FSortMode of
     1: Compare := CompareText(Item1.Caption, Item2.Caption);
    -1: Compare := CompareText(Item2.Caption, Item1.Caption);
  else
    liIndex := Abs(FSortMode) - 2;

    if (FSortMode > 0) then
      Compare := CompareText(Item1.SubItems[liIndex], Item2.SubItems[liIndex])
    else
      Compare := CompareText(Item2.SubItems[liIndex], Item1.SubItems[liIndex]);
  end;

end; {procedure, ListViewCompareEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.SetSortDescription }

procedure TdaDDListViewPage.SetSortDescription;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FFieldNames.Count - 1 do
    FListView.Columns[liIndex].Caption := FFieldNames[liIndex];

  liIndex := Abs(FSortMode) - 1;

  if (FSortMode < 0) then
    FListView.Columns[liIndex].Caption := FFieldNames[liIndex] + ' (z > a)';
    
end; {procedure, SetSortDescription}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewColumnClickEvent }

procedure TdaDDListViewPage.ListViewColumnClickEvent(Sender: TObject; Column: TListColumn);
begin

  if (FSortMode = (Column.Index + 1)) then
    FSortMode := FSortMode * -1
  else
    FSortMode := Column.Index + 1;

  SetSortDescription;

  FListView.AlphaSort;

end; {procedure, ListViewColumnClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDListViewPage.ListViewDblClickEvent }

procedure TdaDDListViewPage.ListViewDblClickEvent(Sender: TObject);
begin


end; {procedure, ListViewDblClickEvent}

{******************************************************************************
 *
 ** T A B L E   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.PageName }

class function TdaDDTablePage.PageName: String;
begin
  Result := 'Tables'
end; {class function, PageName}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.SetDataDictionary }

procedure TdaDDTablePage.SetDataDictionary(aDataDictionary: TppDataDictionary);
begin

  inherited SetDataDictionary(aDataDictionary);

  if (DataDictionary <> nil) then
    begin
      FFieldNames.Add(DataDictionary.TableFieldNames.TableName);
      FFieldNames.Add(DataDictionary.TableFieldNames.TableAlias);

      FDataPipeline := DataDictionary.TablePipeline;
    end;

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.CreateControls }

procedure TdaDDTablePage.CreateControls;
begin

  inherited CreateControls;

  FedtTableName := TEdit.Create(Self);
  FedtTableName.Parent := TabSheet;
  FedtTableName.OnChange := ChangeEvent;
  FedtTableName.Visible := False;
  FedtTableName.Tag := -1;

  FedtTableAlias := TEdit.Create(Self);
  FedtTableAlias.Parent := TabSheet;
  FedtTableAlias.OnChange := ChangeEvent;
  FedtTableAlias.Visible := False;
  FedtTableAlias.Tag := 0;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.HideEditControls }

procedure TdaDDTablePage.HideEditControls;
begin
  FedtTableName.Visible := False;
  FedtTableAlias.Visible := False;
end; {procedure, HideEditControls}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.SelectItem }

procedure TdaDDTablePage.SelectItem(aItem: TListItem; aSelected: Boolean);
begin

  {hide controls}
  if (aItem = nil) or not(aSelected) or (FListView.SelCount > 1) then
    HideEditControls
  else
    begin
      FedtTableName.Text := aItem.Caption;
      FedtTableName.Left := 6;
      FedtTableName.Top := aItem.Top + 3;
      FedtTableName.Width := FListView.Columns[0].Width - 4;
      FedtTableName.Visible := True;

      FedtTableAlias.Text := aItem.SubItems[0];
      FedtTableAlias.Left := FListView.Columns[0].Width + 5;
      FedtTableAlias.Top := aItem.Top + 3;
      FedtTableAlias.Width := FListView.Columns[1].Width - 4;
      FedtTableAlias.Visible := True;

      if FAdding then
        FedtTableName.SetFocus
      else
         begin
           FedtTableAlias.SetFocus;
           FedtTableAlias.SelectAll;
         end;
    end;

end; {procedure, SelectItem}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.LocateRecord }

function TdaDDTablePage.LocateRecord(aItem: TListItem): Boolean;
var
  lsTableName: String;
begin

  Result := False;

  if (DataPipeline = nil) then Exit;

  lsTableName := aItem.Caption;

  Result := DataPipeline.Locate(FFieldNames[0], lsTableName, [pploCaseInsensitive]);

end; {function, LocateRecord}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.UpdateRecord }

procedure TdaDDTablePage.UpdateRecord;
begin
  DataPipeline.SetFieldValue(FFieldNames[0], FedtTableName.Text);
  DataPipeline.SetFieldValue(FFieldNames[1], FedtTableAlias.Text);
end; {function, UpdateRecord}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.EmptyEntry }

function TdaDDTablePage.EmptyEntry: Boolean;
begin
  Result := (Length(FedtTableName.Text) = 0) and (Length(FedtTableAlias.Text) = 0);
end; {function, EmptyEntry}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.ValidateEntry }

function TdaDDTablePage.ValidateEntry(aItem: TListItem): Boolean;
begin

  if (DataPipeline = nil) then
    Result := False

  else if (Length(FedtTableName.Text) = 0) or (Length(FedtTableAlias.Text) = 0) then
    Result := False

  else if FAdding and DataPipeline.Locate(FFieldNames[0], FedtTableName.Text, [pploCaseInsensitive]) then
    Result := False

  else if FAdding and DataPipeline.Locate(FFieldNames[1], FedtTableAlias.Text, [pploCaseInsensitive]) then
    Result := False

  else if not(FAdding) and (aItem.Caption <> FedtTableName.Text) and DataPipeline.Locate(FFieldNames[0], FedtTableName.Text, [pploCaseInsensitive]) then
    Result := False

  else if not(FAdding) and (aItem.SubItems[0] <> FedtTableAlias.Text) and DataPipeline.Locate(FFieldNames[1], FedtTableAlias.Text, [pploCaseInsensitive]) then
    Result := False

  else
    Result := True;

end; {function, ValidateEntry}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.GenerateMessage }

function TdaDDTablePage.GenerateMessage: String;
begin
  Result := 'Creating table entries for tables which appear in the database: ' + FDataDictionary.BuilderSettings.DatabaseName;
end; {function, GenerateMessage}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.SynchronizeMessage }

function TdaDDTablePage.SynchronizeMessage: String;
begin
  Result := 'Deleting table entries for tables which do not appear in the database: ' + FDataDictionary.BuilderSettings.DatabaseName;
end; {class function, SynchronizeMessage}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.SynchronizeItems }

function TdaDDTablePage.SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean;
var
  liIndex: Integer;
  lItem: TListItem;
  lsTableName: String;
  lDataTables: TStrings;
begin

  Result := False;

  if (FSession = nil) or (FDataDictionary = nil) then Exit;

  lDataTables := TStringList.Create;

  GetTableNames(lDataTables);

  liIndex := 0;

  while (liIndex < aListItems.Count) and not(FStop) do
    begin
      lItem := aListItems[liIndex];

      lsTableName := lItem.Caption;

      if (lDataTables.IndexOf(lsTableName) = -1) then
        begin
          if (aDataPipeline.Locate(FFieldNames[0], lsTableName, [pploCaseInsensitive])) then
            begin
              aDataPipeline.Delete;

              Result := True;
            end;
        end;

      Inc(liIndex);

      Application.ProcessMessages;
    end;

  lDataTables.Free;

end; {function, SynchronizeItems}

{------------------------------------------------------------------------------}
{ TdaDDTablePage.GenerateItems }

function TdaDDTablePage.GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean;
var
  liIndex: Integer;
  lsTableName: String;
  lDataTables: TStrings;
  lsTableAlias: String;
  lsOwnerName: String;
  lbFileBased: Boolean;
begin

  Result := False;

  if (FSession = nil) or (FDataDictionary = nil) then Exit;

  lDataTables := TStringList.Create;

  GetTableNames(lDataTables);

  TStringList(lDataTables).Sort;

  liIndex := 0;

  while (liIndex < lDataTables.Count) and not(FStop) do
    begin
      lsTableName := lDataTables[liIndex];

      ppStripOffTableName(lsTableName, lsTableAlias, lsOwnerName, lbFileBased);

      if not(aDataPipeline.Locate(FFieldNames[0], lsTableName, [pploCaseInsensitive])) then
        begin
          aDataPipeline.Insert;
          aDataPipeline.SetFieldValue(FFieldNames[0], lsTableName);

          lsTableAlias := ppStripUnderscores(lsTableAlias);
          lsTableAlias := ppCapitalize(lsTableAlias);

          aDataPipeline.SetFieldValue(FFieldNames[1], lsTableAlias);
          aDataPipeline.Post;

          Result := True;
        end;

      Inc(liIndex);
      
      Application.ProcessMessages;
    end;

  lDataTables.Free;

end; {procedure, GenerateItems}

{******************************************************************************
 *
 ** F I E L D   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.PageName }

class function TdaDDFieldPage.PageName: String;
begin
  Result := 'Fields'
end; {class function, PageName}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.SetDataDictionary }

procedure TdaDDFieldPage.SetDataDictionary(aDataDictionary: TppDataDictionary);
begin

  inherited SetDataDictionary(aDataDictionary);

  if (DataDictionary <> nil) then
    begin
      FFieldNames.Add(DataDictionary.FieldFieldNames.TableName);
      FFieldNames.Add(DataDictionary.FieldFieldNames.FieldName);
      FFieldNames.Add(DataDictionary.FieldFieldNames.FieldAlias);
      FFieldNames.Add(DataDictionary.FieldFieldNames.DataType);
      FFieldNames.Add(DataDictionary.FieldFieldNames.Selectable);
      FFieldNames.Add(DataDictionary.FieldFieldNames.Searchable);
      FFieldNames.Add(DataDictionary.FieldFieldNames.Sortable);
      FFieldNames.Add(DataDictionary.FieldFieldNames.AutoSearch);
      FFieldNames.Add(DataDictionary.FieldFieldNames.Mandatory);

      FDataPipeline := DataDictionary.FieldPipeline;
    end;

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.CreateControls }

procedure TdaDDFieldPage.CreateControls;
var
  lDataType: TppDataType;
begin

  inherited CreateControls;

  FedtTableName := TEdit.Create(Self);
  FedtTableName.Parent := TabSheet;
  FedtTableName.OnChange := ChangeEvent;
  FedtTableName.Visible := False;
  FedtTableName.Tag := -1;

  FedtFieldName := TEdit.Create(Self);
  FedtFieldName.Parent := TabSheet;
  FedtFieldName.OnChange := ChangeEvent;
  FedtFieldName.Visible := False;
  FedtFieldName.Tag := 0;

  FedtFieldAlias := TEdit.Create(Self);
  FedtFieldAlias.Parent := TabSheet;
  FedtFieldAlias.OnChange := ChangeEvent;
  FedtFieldAlias.Visible := False;
  FedtFieldAlias.Tag := 1;

  FcbxDataType := TComboBox.Create(Self);
  FcbxDataType.Parent := TabSheet;
  FcbxDataType.Style := csDropDownList;
  FcbxDataType.OnClick := ChangeEvent;
  FcbxDataType.Width := 25;
  FcbxDataType.Visible := False;
  FcbxDataType.Tag := 2;

  for lDataType := Low(TppDataType) to High(TppDataType) do
    FcbxDataType.Items.Add(ppGetEnumName(TypeInfo(TppDataType), Ord(lDataType)));

  FcbxSelectable := TCheckBox.Create(Self);
  FcbxSelectable.Parent := TabSheet;
  FcbxSelectable.Color := clWhite;
  FcbxSelectable.OnClick := ChangeEvent;
  FcbxSelectable.Width := 17;
  FcbxSelectable.Visible := False;
  FcbxSelectable.Tag := 3;

  FcbxSearchable := TCheckBox.Create(Self);
  FcbxSearchable.Parent := TabSheet;
  FcbxSearchable.Color := clWhite;
  FcbxSearchable.OnClick := ChangeEvent;
  FcbxSearchable.Width := 17;
  FcbxSearchable.Visible := False;
  FcbxSearchable.Tag := 4;

  FcbxSortable := TCheckBox.Create(Self);
  FcbxSortable.Parent := TabSheet;
  FcbxSortable.Color := clWhite;
  FcbxSortable.OnClick := ChangeEvent;
  FcbxSortable.Width := 17;
  FcbxSortable.Visible := False;
  FcbxSortable.Tag := 5;

  FcbxAutoSearch := TCheckBox.Create(Self);
  FcbxAutoSearch.Parent := TabSheet;
  FcbxAutoSearch.Color := clWhite;
  FcbxAutoSearch.OnClick := ChangeEvent;
  FcbxAutoSearch.Width := 17;
  FcbxAutoSearch.Visible := False;
  FcbxAutoSearch.Tag := 6;

  FcbxMandatory := TCheckBox.Create(Self);
  FcbxMandatory.Parent := TabSheet;
  FcbxMandatory.Color := clWhite;
  FcbxMandatory.OnClick := ChangeEvent;
  FcbxMandatory.Width := 17;
  FcbxMandatory.Visible := False;
  FcbxMandatory.Tag := 7;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.HideEditControls }

procedure TdaDDFieldPage.HideEditControls;
begin
  FedtTableName.Visible := False;
  FedtFieldName.Visible := False;
  FedtFieldAlias.Visible := False;
  FcbxDataType.Visible := False;
  FcbxSelectable.Visible := False;
  FcbxSearchable.Visible := False;
  FcbxSortable.Visible := False;
  FcbxAutoSearch.Visible := False;
  FcbxMandatory.Visible := False;
end; {procedure, HideEditControls}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.SelectItem }

procedure TdaDDFieldPage.SelectItem(aItem: TListItem; aSelected: Boolean);
var
  liLeft: Integer;
begin

  {hide controls}
  if (aItem = nil) or not(aSelected) or (FListView.SelCount > 1) then
    HideEditControls

  else
    begin

      if FAdding then
        begin
          aItem.SubItems[2] := 'T';
          aItem.SubItems[3] := 'T';
          aItem.SubItems[4] := 'T';
          aItem.SubItems[5] := 'F';
          aItem.SubItems[6] := 'F';
        end;

      FedtTableName.Text := aItem.Caption;
      FedtTableName.Left := 6;
      FedtTableName.Top := aItem.Top + 3;
      FedtTableName.Width := FListView.Columns[0].Width - 4;
      FedtTableName.Visible := True;

      liLeft := FListView.Columns[0].Width + 5;


      FedtFieldName.Text := aItem.SubItems[0];
      FedtFieldName.Left := liLeft;
      FedtFieldName.Top := aItem.Top + 3;
      FedtFieldName.Width := FListView.Columns[1].Width - 4;
      FedtFieldName.Visible := True;

      liLeft := liLeft + FListView.Columns[1].Width;


      FedtFieldAlias.Text := aItem.SubItems[1];
      FedtFieldAlias.Left := liLeft;
      FedtFieldAlias.Top := aItem.Top + 3;
      FedtFieldAlias.Width := FListView.Columns[2].Width - 4;
      FedtFieldAlias.Visible := True;

      liLeft := liLeft + FListView.Columns[2].Width;


      FcbxDataType.ItemIndex := ppGetEnumValue(TypeInfo(TppDataType), aItem.SubItems[2]);
      FcbxDataType.Left := liLeft;
      FcbxDataType.Top := aItem.Top + 3;
      FcbxDataType.Width := FListView.Columns[3].Width - 4;
      FcbxDataType.Visible := True;

      liLeft := liLeft + FListView.Columns[3].Width;


      FcbxSelectable.Checked := (aItem.SubItems[3] = 'T');
      FcbxSelectable.Left := liLeft;
      FcbxSelectable.Top := aItem.Top + 6;
      {FcbxSelectable.Width := FListView.Columns[4].Width - 4;}
      FcbxSelectable.Visible := True;

      liLeft := liLeft + FListView.Columns[4].Width;


      FcbxSearchable.Checked := (aItem.SubItems[4] = 'T');
      FcbxSearchable.Left := liLeft;
      FcbxSearchable.Top := aItem.Top + 6;
      {FcbxSearchable.Width := FListView.Columns[5].Width - 4;}
      FcbxSearchable.Visible := True;

      liLeft := liLeft + FListView.Columns[5].Width;


      FcbxSortable.Checked := (aItem.SubItems[5] = 'T');
      FcbxSortable.Left := liLeft;
      FcbxSortable.Top := aItem.Top + 6;
      {FcbxSortable.Width := FListView.Columns[6].Width - 4;}
      FcbxSortable.Visible := True;

      liLeft := liLeft + FListView.Columns[6].Width;


      FcbxAutoSearch.Checked := (aItem.SubItems[6] = 'T');
      FcbxAutoSearch.Left := liLeft;
      FcbxAutoSearch.Top := aItem.Top + 6;
      {FcbxAutoSearch.Width := FListView.Columns[7].Width - 4;}
      FcbxAutoSearch.Visible := True;

      liLeft := liLeft + FListView.Columns[7].Width;


      FcbxMandatory.Checked := (aItem.SubItems[7] = 'T');
      FcbxMandatory.Left := liLeft;
      FcbxMandatory.Top := aItem.Top + 6;
      {FcbxMandatory.Width := FListView.Columns[8].Width - 4;}
      FcbxMandatory.Visible := True;

      if FAdding then
        FedtTableName.SetFocus
      else
        begin
          FedtFieldAlias.SetFocus;
          FedtFieldAlias.SelectAll;
        end;

    end;

end; {procedure, SelectItem}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.LocateRecord }

function TdaDDFieldPage.LocateRecord(aItem: TListItem): Boolean;
var
  lsTableName: String;
  lsFieldName: String;
begin

  Result := False;

  if (DataPipeline = nil) then Exit;

  lsTableName := aItem.Caption;
  lsFieldName := aItem.SubItems[0];

  Result := DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName, lsFieldName]), [pploCaseInsensitive]);

end; {function, LocateRecord}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.UpdateRecord }

procedure TdaDDFieldPage.UpdateRecord;
begin
  DataPipeline.SetFieldValue(FFieldNames[0], FedtTableName.Text);
  DataPipeline.SetFieldValue(FFieldNames[1], FedtFieldName.Text);
  DataPipeline.SetFieldValue(FFieldNames[2], FedtFieldAlias.Text);
  DataPipeline.SetFieldValue(FFieldNames[3], FcbxDataType.Items[FcbxDataType.ItemIndex]);
  DataPipeline.SetFieldValue(FFieldNames[4], BooleanToText(FcbxSelectable.Checked));
  DataPipeline.SetFieldValue(FFieldNames[5], BooleanToText(FcbxSearchable.Checked));
  DataPipeline.SetFieldValue(FFieldNames[6], BooleanToText(FcbxSortable.Checked));
  DataPipeline.SetFieldValue(FFieldNames[7], BooleanToText(FcbxAutoSearch.Checked));
  DataPipeline.SetFieldValue(FFieldNames[8], BooleanToText(FcbxMandatory.Checked));
end; {function, UpdateRecord}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.EmptyEntry }

function TdaDDFieldPage.EmptyEntry: Boolean;
begin
  Result := (Length(FedtTableName.Text) = 0) and (Length(FedtFieldName.Text) = 0) and (Length(FedtFieldAlias.Text) = 0);
end; {function, EmptyEntry}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.ValidateEntry }

function TdaDDFieldPage.ValidateEntry(aItem: TListItem): Boolean;
begin

  if (DataPipeline = nil) then
    Result := False

  else if (Length(FedtTableName.Text) = 0) then
    Result := False

  else if (Length(FedtFieldName.Text) = 0) then
    Result := False

  else if (Length(FedtFieldAlias.Text) = 0) then
    Result := False

  else if FAdding and DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([FedtTableName.Text, FedtFieldName.Text]), [pploCaseInsensitive]) then
    Result := False

  else if FAdding and DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[2], VarArrayOf([FedtTableName.Text, FedtFieldAlias.Text]), [pploCaseInsensitive]) then
    Result := False

  else if not(FAdding) and (aItem.Caption <> FedtTableName.Text) and DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([FedtTableName.Text, FedtFieldName.Text]), [pploCaseInsensitive]) then
    Result := False

  else if not(FAdding) and (aItem.SubItems[0] <> FedtFieldName.Text) and DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([FedtTableName.Text, FedtFieldName.Text]), [pploCaseInsensitive]) then
    Result := False

  else if not(FAdding) and (aItem.SubItems[1] <> FedtFieldAlias.Text) and DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[2], VarArrayOf([FedtTableName.Text, FedtFieldAlias.Text]), [pploCaseInsensitive]) then
    Result := False

  else
    Result := True;

end; {function, ValidateEntry}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.GenerateMessage }

function TdaDDFieldPage.GenerateMessage: String;
begin
  Result := 'Creating field entries for fields which appear in the database: ' + FDataDictionary.BuilderSettings.DatabaseName;
end; {function, GenerateMessage}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.SynchronizeMessage }

function TdaDDFieldPage.SynchronizeMessage: String;
begin
  Result := 'Deleting field entries for fields which do not appear in the database: ' + FDataDictionary.BuilderSettings.DatabaseName;
end; {class function, SynchronizeMessage}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.SynchronizeItems }

function TdaDDFieldPage.SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean;
var
  lDataTables: TStrings;
  lDataSet: TdaDataSet;
  liIndex: Integer;
  liIndex2: Integer;
  lbFound: Boolean;
  lsTableName: String;
  lsDataName: String;
  lsFieldName: String;
begin

  Result := False;

  if (FSession = nil) or (FDataDictionary = nil) then Exit;

  lDataTables := TStringList.Create;

  GetTableNames(lDataTables);

  {loop through all items, retrieving tablename and fieldname }
  liIndex := 0;

  while (liIndex < aListItems.Count) and not(FStop) do
    begin
      lsTableName := aListItems[liIndex].Caption;
      lsFieldName := aListItems[liIndex].SubItems[0];

      {search for matching table name in FDataTables, if not found, delete record from data pipeline}
      if (lDataTables.IndexOf(lsTableName) = -1) then
        begin
          if (aDataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName, lsFieldName]), [pploCaseInsensitive])) then
            begin
              aDataPipeline.Delete;

              Result := True;
            end;
        end

      {else if table name found, then search for matching field name in fields property of dataset}
      else
        begin
          lDataSet := FSession.CreateDataSet(Self, FDataDictionary.BuilderSettings.DatabaseName);
          lsDataName := TableNameToSQLString(lsTableName);
          lDataSet.DataName := lsDataName;

          if OpenDataSet(lDataSet) then
            begin
              {find field}
              liIndex2 := 0;
              lbFound := False;

              while not(lbFound) and (liIndex2 < lDataSet.FieldCount) and not(FStop) do
                begin
                  if (CompareText(lsFieldName, lDataSet.Fields[liIndex2].FieldName) = 0) then
                    lbFound := True
                  else
                    Inc(liIndex2);

                  Application.ProcessMessages;
                end;

              {if field not found, delete record from datapipeline}
              if not(lbFound) then
                begin
                  if (aDataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName, lsFieldName]), [pploCaseInsensitive])) then
                    begin
                      aDataPipeline.Delete;

                      Result := True;
                    end;
                end;

              lDataSet.Free;
            end;

        end;

      Inc(liIndex);

      Application.ProcessMessages;
    end;

  lDataTables.Free;

end; {function, SynchronizeItems}

{------------------------------------------------------------------------------}
{ TdaDDFieldPage.GenerateItems }

function TdaDDFieldPage.GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean;
var
  lDataTables: TStrings;
  lDataSet: TdaDataSet;
  liIndex: Integer;
  liIndex2: Integer;
  lsDataName: String;
  lsTableName: String;
  lsFieldName: String;
  lDataType: TppDataType;
  lsDataType: String;
begin

  Result := False;

  if (FSession = nil) or (FDataDictionary = nil) then Exit;

  lDataTables := TStringList.Create;

  GetTableNames(lDataTables);

  {loop through all data tables}
  liIndex := 0;

  while (liIndex < lDataTables.Count) and not(FStop) do
    begin
      lsTableName := lDataTables[liIndex];
      lsDataName := TableNameToSQLString(lsTableName);

      lDataSet := FSession.CreateDataSet(Self, FDataDictionary.BuilderSettings.DatabaseName);
      lDataSet.DataName := lsDataName;
      
      if not(OpenDataSet(lDataSet)) then
        begin
          Inc(liIndex);

          Continue;
        end;

      {loop through fields for each table}
      liIndex2 := 0;

      while (liIndex2 < lDataSet.FieldCount) and not(FStop) do
        begin
          lsFieldName := lDataSet.Fields[liIndex2].FieldName;
          lDataType := lDataSet.Fields[liIndex2].DataType;
          lsDataType := ppGetEnumName(TypeInfo(TppDataType), Ord(lDataType));

          {attempt to locate tablename and fieldname in datapipeline}
          if not(aDataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName, lsFieldName]), [pploCaseInsensitive])) then
            begin
              aDataPipeline.Insert;

              aDataPipeline.SetFieldValue(FFieldNames[0], lsTableName);
              aDataPipeline.SetFieldValue(FFieldNames[1], lsFieldName);

              lsFieldName := ppStripUnderscores(lsFieldName);
              lsFieldName := ppCapitalize(lsFieldName);

              aDataPipeline.SetFieldValue(FFieldNames[2], lsFieldName);

              aDataPipeline.SetFieldValue(FFieldNames[3], lsDataType);
              aDataPipeline.SetFieldValue(FFieldNames[4], 'T');

              if lDataType in [dtMemo, dtGraphic, dtBLOB] then
                begin
                  aDataPipeline.SetFieldValue(FFieldNames[5], 'F');
                  aDataPipeline.SetFieldValue(FFieldNames[6], 'F');
                end
              else
                begin
                  aDataPipeline.SetFieldValue(FFieldNames[5], 'T');
                  aDataPipeline.SetFieldValue(FFieldNames[6], 'T');
                end;

              aDataPipeline.SetFieldValue(FFieldNames[7], 'F');
              aDataPipeline.SetFieldValue(FFieldNames[8], 'F');

              aDataPipeline.Post;

              Result := True;
            end;

          Inc(liIndex2);

          Application.ProcessMessages;
        end; {for, each field}


      Inc(liIndex);

      Application.ProcessMessages;

      lDataSet.Free;

    end; {for, each table}

  lDataTables.Free;

end; {procedure, GenerateItems}

{******************************************************************************
 *
 ** J O I N   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.Destroy }

destructor TdaDDJoinPage.Destroy;
begin

  FDataDictionary.Free;
  FJoinPanel.Free;

  inherited Destroy;

end; {class function, Destroy}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.PageName }

class function TdaDDJoinPage.PageName: String;
begin
  Result := 'Joins'
end; {class function, PageName}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.SetDataDictionary }

procedure TdaDDJoinPage.SetDataDictionary(aDataDictionary: TppDataDictionary);
begin

  inherited SetDataDictionary(aDataDictionary);

  if (DataDictionary <> nil) then
    begin
      FFieldNames.Add(DataDictionary.JoinFieldNames.TableName1);
      FFieldNames.Add(DataDictionary.JoinFieldNames.TableName2);
      FFieldNames.Add(DataDictionary.JoinFieldNames.JoinType);
      FFieldNames.Add(DataDictionary.JoinFieldNames.FieldNames1);
      FFieldNames.Add(DataDictionary.JoinFieldNames.Operators);
      FFieldNames.Add(DataDictionary.JoinFieldNames.FieldNames2);

      FDataPipeline := DataDictionary.JoinPipeline;
    end;

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.ListViewColumnResizeEvent }

procedure TdaDDJoinPage.ListViewColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
begin

end; {procedure, ListViewColumnResizeEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.ListViewScrollEvent }

procedure TdaDDJoinPage.ListViewScrollEvent(Sender: TObject);
begin
  
end; {procedure, ListViewScrollEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.CreateControls }

procedure TdaDDJoinPage.CreateControls;
var
  lMenuItem: TMenuItem;
begin

  inherited CreateControls;

  lMenuItem := TMenuItem.Create(FPopupMenu);
  lMenuItem.Caption := '&Modify';
  lMenuItem.OnClick := ModifyMenuClickEvent;
  FPopupMenu.Items.Insert(1, lMenuItem);

  FAlwaysRowSelect := True;
  FListView.RowSelect := True;

  FTopPanel := TPanel.Create(Self);
  FTopPanel.Parent := TabSheet;
  FListView.Parent := FTopPanel;
  FTopPanel.Align := alClient;

  FMiddlePanel := TPanel.Create(Self);
  FMiddlePanel.Parent := TabSheet;
  FMiddlePanel.Height := 34;
  FMiddlePanel.Align := alBottom;
  FMiddlePanel.BevelOuter := bvNone;
  FMiddlePanel.Visible := False;

  FSaveButton := TButton.Create(Self);
  FSaveButton.Parent := FMiddlePanel;
  FSaveButton.Caption := 'Save';
  FSaveButton.Enabled := False;
  FSaveButton.Left := 352;
  FSaveButton.Top := 4;
  FSaveButton.OnClick := SaveMenuClickEvent;

  FCancelButton := TButton.Create(Self);
  FCancelButton.Parent := FMiddlePanel;
  FCancelButton.Caption := 'Cancel';
  FCancelButton.Enabled := False;
  FCancelButton.Left := 435;
  FCancelButton.Top := 4;
  FCancelButton.OnClick := CancelMenuClickEvent;

  FBottomPanel := TPanel.Create(Self);
  FBottomPanel.Parent := TabSheet;
  FBottomPanel.Height := 375;
  FBottomPanel.Align := alBottom;
  FBottomPanel.BevelOuter := bvNone;
  FBottomPanel.Visible := False;

  FJoinPanel := TdaJoinPanel.CreatePanel(Self, FBottomPanel, nil, nil, FSQL);

  FJoinPanel.OnModify := ChangeEvent;

  FJoinPanel.Initialize;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.HideEditControls }

procedure TdaDDJoinPage.HideEditControls;
begin
  FMiddlePanel.Visible := False;
  FBottomPanel.Visible := False;
end; {procedure, HideEditControls}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.SelectItem }

procedure TdaDDJoinPage.SelectItem(aItem: TListItem; aSelected: Boolean);
begin

  {hide controls}
  if (aItem = nil) or not(aSelected) or (FListView.SelCount > 1) then
    HideEditControls

  else
    begin
      if FAdding then
        begin
          FSQL.CreateJoinObjects(aItem.Caption, aItem.SubItems[0], aItem.SubItems[1], aItem.SubItems[2], aItem.SubItems[3], aItem.SubItems[4]);

          FJoinPanel.Update;

          FMiddlePanel.Visible := True;
          FBottomPanel.Visible := True;
        end;
    end;

end; {procedure, SelectItem}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.LocateRecord }

function TdaDDJoinPage.LocateRecord(aItem: TListItem): Boolean;
var
  lsTableName1: String;
  lsTableName2: String;
begin

  Result := False;

  if (DataPipeline = nil) then Exit;

  lsTableName1 := aItem.Caption;
  lsTableName2 := aItem.SubItems[0];

  Result := DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName1, lsTableName2]), [pploCaseInsensitive]);

end; {function, LocateRecord}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.ChangeEvent }

procedure TdaDDJoinPage.ChangeEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  if FSaving then Exit;
  if FSettingControls then Exit;

  lItem := FListView.Selected;

  if (lItem = nil) then Exit;

  FModified := FJoinPanel.Modified;

  FSaveButton.Enabled := (FJoinPanel.JoinCount > 0);
  FCancelButton.Enabled := True;

end; {procedure, ChangeEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.UpdateRecord }

procedure TdaDDJoinPage.UpdateRecord;
begin
  DataPipeline.SetFieldValue(FFieldNames[0], FSQL.SelectTables[0].RawTableName);
  DataPipeline.SetFieldValue(FFieldNames[1], FSQL.SelectTables[1].RawTableName);
  DataPipeline.SetFieldValue(FFieldNames[2], FSQL.SelectTables[1].JoinTypeString);
  DataPipeline.SetFieldValue(FFieldNames[3], FSQL.SelectTables[1].JoinFieldNames2);
  DataPipeline.SetFieldValue(FFieldNames[4], FSQL.SelectTables[1].JoinOperators);
  DataPipeline.SetFieldValue(FFieldNames[5], FSQL.SelectTables[1].JoinFieldNames1);
end; {function, UpdateRecord}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.EmptyEntry }

function TdaDDJoinPage.EmptyEntry: Boolean;
begin
  Result := (FJoinPanel.JoinCount = 0);
end; {function, EmptyEntry}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.ValidateEntry }

function TdaDDJoinPage.ValidateEntry(aItem: TListItem): Boolean;
var
  lsTableName1: String;
  lsTableName2: String;
begin

  lsTableName1 := FJoinPanel.Table1.RawTableName;
  lsTableName2 := FJoinPanel.Table2.RawTableName;

  if (DataPipeline = nil) then
    Result := False

  else if (FJoinPanel.JoinCount = 0) then
    Result := False

  else if FAdding and DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName1, lsTableName2]), [pploCaseInsensitive]) then
    Result := False

  else if not(FAdding) and not(DataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName1, lsTableName2]), [pploCaseInsensitive])) then
    Result := False

  else
    Result := True;

end; {function, ValidateEntry}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.ListViewDblClickEvent }

procedure TdaDDJoinPage.ListViewDblClickEvent(Sender: TObject);
begin

  if not(FModified) then
    ModifyMenuClickEvent(Sender);

end; {procedure, ListViewDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.PopupMenuPopupEvent }

procedure TdaDDJoinPage.PopupMenuPopupEvent(Sender: TObject);
begin

  inherited PopupMenuPopupEvent(Sender);

  FPopupMenu.Items[8].Enabled := False;

end; {procedure, PopupMenuPopupEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.AddMenuClickEvent }

procedure TdaDDJoinPage.AddMenuClickEvent(Sender: TObject);
begin

  inherited AddMenuClickEvent(Sender);

  FCancelButton.Enabled := True;

end; {function, AddMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.ModifyMenuClickEvent }

procedure TdaDDJoinPage.ModifyMenuClickEvent(Sender: TObject);
var
  lSaveCursor: TCursor;
begin

  if (FLastItem = nil) then Exit;

  FModified := True;

  lSaveCursor := Screen.Cursor;
  
  Screen.Cursor := crHourGlass;

  try
    FSQL.CreateJoinObjects(FLastItem.Caption, FLastItem.SubItems[0], FLastItem.SubItems[1], FLastItem.SubItems[2], FLastItem.SubItems[3], FLastItem.SubItems[4]);

    FJoinPanel.Update;
  finally
    Screen.Cursor := lSaveCursor;
  end;

  FMiddlePanel.Visible := True;
  FBottomPanel.Visible := True;

  FLastItem.MakeVisible(False);
  
  FCancelButton.Enabled := True;

end; {function, ModifyMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.SaveMenuClickEvent }

procedure TdaDDJoinPage.SaveMenuClickEvent(Sender: TObject);
begin

  if not(ValidateEntry(FLastItem)) then Exit;

  FBottomPanel.Visible := False;
  FMiddlePanel.Visible := False;

  {transfer the join conditions to the table in the SQL object}
  FJoinPanel.Finalize;

  if (FAdding) then
    begin
      FAdding := False;
      FModified := False;

      DataPipeline.Insert;

      UpdateRecord;

      DataPipeline.Post;

      DataToItem(FLastItem);
    end

  else if LocateRecord(FLastItem) then
    begin
      DataPipeline.Edit;

      UpdateRecord;

      DataPipeline.Post;

      DataToItem(FLastItem);
    end;

  FSaveButton.Enabled := False;
  FCancelButton.Enabled := False;

  FAdding := False;
  FModified := False;

  FListView.SetFocus;

end; {function, SaveMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.CancelMenuClickEvent }

procedure TdaDDJoinPage.CancelMenuClickEvent(Sender: TObject);
begin

  if (FAdding) then
    FLastItem.Free;

  FAdding := False;
  FModified := False;

  FBottomPanel.Visible := False;
  FMiddlePanel.Visible := False;

  FSaveButton.Enabled := False;
  FCancelButton.Enabled := False;
 
  FListView.SetFocus;

end; {function, CancelMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.GenerateMessage }

function TdaDDJoinPage.GenerateMessage: String;
begin
  Result := 'Creating join entries where fields have matching names and data types between tables in the database: ' + FDataDictionary.BuilderSettings.DatabaseName;
end; {function, GenerateMessage}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.SynchronizeMessage }

function TdaDDJoinPage.SynchronizeMessage: String;
begin
  Result := 'Deleting join entries where table or field names do not appear in the database: ' + FDataDictionary.BuilderSettings.DatabaseName;
end; {class function, SynchronizeMessage}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.SynchronizeItems }

function TdaDDJoinPage.SynchronizeItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean;
begin
  Result := True;
end; {procedure, SynchronizeItems}

{------------------------------------------------------------------------------}
{ TdaDDJoinPage.GenerateItems }

function TdaDDJoinPage.GenerateItems(aDataPipeline: TppDataPipeline; aListItems: TListItems): Boolean;
var
  lDataTables: TStrings;
  liIndex1: Integer;
  liIndex2: Integer;
  liIndex3: Integer;
  liIndex4: Integer;
  lDataSet1: TdaDataSet;
  lDataSet2: TdaDataSet;
  lsTableName1: String;
  lsDataName1: String;
  lsTableName2: String;
  lsDataName2: String;
  lsFieldName1: String;
  lsFieldName2: String;
  lsOperators: String;
  lsJoinType: String;
  lFieldNames1: TStrings;
  lFieldNames2: TStrings;
  lOperators: TStrings;
  lbFound: Boolean;
begin

  Result := False;

  if (FSession = nil) or (FDataDictionary = nil) then Exit;

  lDataTables := TStringList.Create;

  GetTableNames(lDataTables);

  lFieldNames1 := TStringList.Create;
  lFieldNames2 := TStringList.Create;
  lOperators := TStringList.Create;

  {loop through all data tables}
  liIndex1 := 0;

  while (liIndex1 < lDataTables.Count) and not(FStop) do
    begin
      lsTableName1 := lDataTables[liIndex1];
      lsDataName1 := TableNameToSQLString(lsTableName1);

      lDataSet1 := FSession.CreateDataSet(Self, FDataDictionary.BuilderSettings.DatabaseName);
      lDataSet1.DataName := lsDataName1;

      if not(OpenDataSet(lDataSet1)) then
        begin
          Inc(liIndex1);

          Continue;
        end;

      {loop through remaining data tables}
      liIndex2 := liIndex1 + 1;

      while (liIndex2 < lDataTables.Count) and not(FStop) do
        begin
          lsTableName2 := lDataTables[liIndex2];
          lsDataName2 := TableNameToSQLString(lsTableName2);

          lDataSet2 := FSession.CreateDataSet(Self, FDataDictionary.BuilderSettings.DatabaseName);
          lDataSet2.DataName := lsDataName2;

          if not(OpenDataSet(lDataSet2)) then
            begin
              Inc(liIndex2);
              
              Continue;
            end;

          lFieldNames1.Clear;
          lFieldNames2.Clear;
          lOperators.Clear;

          {loop through fields for table1}
          liIndex3 := 0;

          while (liIndex3 < lDataSet1.FieldCount) and not(FStop) do
            begin
              lsFieldName1 := lDataSet1.Fields[liIndex3].FieldName;

              lbFound := False;
              liIndex4 := 0;

             {attempt to find field in table2}
              while not(lbFound) and (liIndex4 < lDataSet2.FieldCount) and not(FStop) do
                begin
                  lsFieldName2 := lDataSet2.Fields[liIndex4].FieldName;

                  if (lsFieldName1 = lsFieldName2) then
                    begin
                      lbFound := True;
                      lFieldNames1.Add(lsFieldName1);
                      lFieldNames2.Add(lsFieldName2);
                      lOperators.Add('=');
                    end
                  else
                    Inc(liIndex4);

                  Application.ProcessMessages;

                end; {while, field not found in table2}


              Inc(liIndex3);

              Application.ProcessMessages;

            end; {each table1 field}

          if (lFieldNames1.Count > 0) and not(aDataPipeline.Locate(FFieldNames[0] + ';' + FFieldNames[1], VarArrayOf([lsTableName1, lsTableName2]), [pploCaseInsensitive])) then
            begin
              lsFieldName1 := ppCombineStrings(lFieldNames1);
              lsFieldName2 := ppCombineStrings(lFieldNames2);
              lsOperators := ppCombineStrings(lOperators);
              lsJoinType := daJoinTypeToString(dajtInner);

              aDataPipeline.Insert;

              aDataPipeline.SetFieldValue(FFieldNames[0], lsTableName1);
              aDataPipeline.SetFieldValue(FFieldNames[1], lsTableName2);
              aDataPipeline.SetFieldValue(FFieldNames[2], lsJoinType);
              aDataPipeline.SetFieldValue(FFieldNames[3], lsFieldName1);
              aDataPipeline.SetFieldValue(FFieldNames[4], lsOperators);
              aDataPipeline.SetFieldValue(FFieldNames[5], lsFieldName2);

              aDataPipeline.Post;

              Result := True;
            end;


          Inc(liIndex2);

          Application.ProcessMessages;

          lDataSet2.Free;

        end; {each remaining table}


      Inc(liIndex1);

      Application.ProcessMessages;

      lDataSet1.Free;

    end; {each, table}

  lDataTables.Free;

end; {function, GenerateItems}







end.
