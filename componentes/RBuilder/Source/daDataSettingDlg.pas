{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit daDataSettingDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,

  ppTypes,
  ppComm,
  ppForms,
  ppDB,
  ppUtils,
  ppJVTabBar,
  ppWizard,
  ppDsgnDB,

  daDataView,
  daDB;



type

  { TdaDataSettingsDialog }
  TdaDataSettingsDialog = class(TppCustomDataSettingsDialog)
    btnOK: TButton;
    btnCancel: TButton;
    lblSessionType: TLabel;
    cbxSessionType: TComboBox;
    lblDatabaseName: TLabel;
    cbxDatabaseName: TComboBox;
    lblDatabaseType: TLabel;
    cbxDatabaseType: TComboBox;
    ckbDataDictionary: TCheckBox;
    lblUseDataDictionary: TLabel;
    cbxDataDictionary: TComboBox;
    lblSQLType: TLabel;
    cbxSQLType: TComboBox;
    lblEditSQLAsText: TLabel;
    ckbEditSQLAsText: TCheckBox;
    bvlDataDictionary: TBevel;
    lblCollationType: TLabel;
    cbxCollationType: TComboBox;
    ckbCaseSensitive: TCheckBox;
    lblCaseSensitive: TLabel;
    lblGuidCollation: TLabel;
    cbxGuidCollationType: TComboBox;
    bvlCollation: TBevel;
    Notebook1: TNotebook;
    lblNullCollation: TLabel;
    cbxNullCollationType: TComboBox;
    procedure cbxSessionTypeChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure ckbDataDictionaryClick(Sender: TObject);
    procedure lblUseDataDictionaryClick(Sender: TObject);
    procedure lblEditSQLAsTextClick(Sender: TObject);
    procedure cbxDatabaseNameChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxDatabaseTypeChange(Sender: TObject);
    procedure lblCaseSensitiveClick(Sender: TObject);
    procedure cbxCollationTypeChange(Sender: TObject);
    procedure cbxGuidCollationTypeChange(Sender: TObject);
  private
    FDataSettings: TppDataSettings;
    FSession: TdaSession;
    FTabSet: TppJVTabBar;

    procedure BuildDatabaseNameList;
    procedure BuildDatabaseTypeList;
    procedure BuildCollationTypeList;
    procedure BuildGuidCollationTypeList;
    procedure BuildDataDictionaryList;
    procedure BuildNullCollationTypeList;
    procedure BuildSQLTypeList;
    function  GetDataDictionary: TppDataDictionary;
    function  GetDatabaseType: TppDatabaseType;
    function GetCollationType: TppCollationType;
    function GetGuidCollationType: TppGuidCollationType;
    function GetNullCollationType: TppNullCollationType;
    procedure SelectSession(const aSessionName: String);
    procedure SelectDatabaseName(const aDatabaseName: String);
    procedure SelectDatabaseType(aDatabaseType: TppDatabaseType);
    procedure SelectCollationType(aCollationType: TppCollationType);
    procedure SelectGuidCollationType(aGuidCollationType: TppGuidCollationType);
    procedure SelectNullCollationType(aNullCollationType: TppNullCollationType);


  protected
    procedure ehTabSet_TabSelected(Sender: TObject; Item: TppJvTabBarItem);
    function  GetDataSettings: TPersistent; override;
    procedure LanguageChanged; override;
    procedure SetDataSettings(aDataSettings: TPersistent); override;

  public
    procedure Initialize; override;

  end; {class, TdaDataSettingsDialog}

var
  daDataSettingsDialog: TdaDataSettingsDialog;

implementation

{$R *.DFM}

{******************************************************************************
 *
 **  F O R M   E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.FormCreate }

procedure TdaDataSettingsDialog.FormCreate(Sender: TObject);
begin
  FSession := nil;
  FDataSettings := nil;

  FTabSet := TppJVTabBar.Create(Self);
  FTabSet.Parent := Self;
  FTabSet.CloseButton := False;
  FTabSet.Top := Notebook1.Top - FTabSet.Height;
  FTabSet.AddTab('Connection');
  FTabSet.AddTab('SQL');
  FTabSet.OnTabSelected := ehTabSet_TabSelected;

  FTabSet.SelectedTab := FTabSet.Tabs[0];
  Notebook1.PageIndex := 0;

  {XP Theme support}
//  lblUseDataDictionary.Transparent := False;
//  lblDataConnection.Transparent := False;
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.FormDestroy }

procedure TdaDataSettingsDialog.FormDestroy(Sender: TObject);
begin
  FSession.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.cbxSessionTypeChange }

procedure TdaDataSettingsDialog.cbxSessionTypeChange(Sender: TObject);
begin
  SelectSession(cbxSessionType.Text);
end; {procedure, cbxSessionTypeChange}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.cbxDatabaseNameChange }

procedure TdaDataSettingsDialog.cbxDatabaseNameChange(Sender: TObject);
begin
  SelectDatabaseName(cbxDatabaseName.Text);
end; {procedure, cbxDatabaseNameChange}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.cbxDatabaseTypeChange }

procedure TdaDataSettingsDialog.cbxDatabaseTypeChange(Sender: TObject);
begin
  SelectDatabaseType(TppDatabaseType(cbxDatabaseType.Items.Objects[cbxDatabaseType.ItemIndex]));
end; {procedure, cbxDatabaseTypeChange}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.cbxCollationTypeChange }

procedure TdaDataSettingsDialog.cbxCollationTypeChange(Sender: TObject);
begin
  SelectCollationType(TppCollationType(cbxCollationType.Items.Objects[cbxCollationType.ItemIndex]));

end; {procedure, cbxCollationTypeChange}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.cbxGuidCollationTypeChange }

procedure TdaDataSettingsDialog.cbxGuidCollationTypeChange(Sender: TObject);
begin
  SelectGuidCollationType(TppGuidCollationType(cbxGuidCollationType.Items.Objects[cbxGuidCollationType.ItemIndex]));

end; {procedure, cbxGuidCollationTypeChange}


{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.ckbDataDictionaryClick }

procedure TdaDataSettingsDialog.ckbDataDictionaryClick(Sender: TObject);
begin
  cbxDataDictionary.Enabled := ckbDataDictionary.Checked;
end; {procedure, ckbDataDictionaryClick}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.lblUseDataDictionaryClick }

procedure TdaDataSettingsDialog.lblUseDataDictionaryClick(Sender: TObject);
begin
  ckbDataDictionary.Checked := not(ckbDataDictionary.Checked);
  cbxDataDictionary.Enabled := ckbDataDictionary.Checked;
end; {procedure, lblUseDataDictionaryClick}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.lblCaseSensitiveClick }
procedure TdaDataSettingsDialog.lblCaseSensitiveClick(Sender: TObject);
begin
  ckbCaseSensitive.Checked := not(ckbCaseSensitive.Checked);
end; {procedure, lblCaseSensitiveClick}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.lblEditSQLAsTextClick }

procedure TdaDataSettingsDialog.lblEditSQLAsTextClick(Sender: TObject);
begin
  ckbEditSQLAsText.Checked := not(ckbEditSQLAsText.Checked);
end; {procedure, lblEditSQLAsTextClick}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.btnOKClick }

procedure TdaDataSettingsDialog.btnOKClick(Sender: TObject);
begin
  FDataSettings.AllowEditSQL := ckbEditSQLAsText.Checked;
  FDataSettings.SessionType := cbxSessionType.Text;
  FDataSettings.DatabaseName := cbxDatabaseName.Text;
  FDataSettings.DatabaseType := GetDatabaseType;
  FDataSettings.CollationType := GetCollationType;
  FDataSettings.GuidCollationType := GetGuidCollationType;
  FDataSettings.NullCollationType := GetNullCollationType;
  FDataSettings.IsCaseSensitive := ckbCaseSensitive.Checked;
  FDataSettings.SQLType := TppSQLType(cbxSQLType.ItemIndex);
  FDataSettings.UseDataDictionary := ckbDataDictionary.Checked;
  FDataSettings.DataDictionary := GetDataDictionary;
end; {procedure, btnOKClick}

{******************************************************************************
 *
 **  R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SetDataSettings }

procedure TdaDataSettingsDialog.SetDataSettings(aDataSettings: TPersistent);
begin
  FDataSettings := TppDataSettings(aDataSettings);

  Initialize;
end; {procedure, SetDataSettings}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.GetDataSettings }

function TdaDataSettingsDialog.GetDataSettings: TPersistent;
begin
  Result := FDataSettings;
end; {function, GetDataSettings}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.Initialize }

procedure TdaDataSettingsDialog.Initialize;
var
  lbEnableDictionary: Boolean;
begin

  {get list of supported sessions}
  daGetDataViewSessionClasses(cbxSessionType.Items);

  BuildSQLTypeList;

  BuildCollationTypeList;
  BuildGuidCollationTypeList;
  BuildNullCollationTypeList;

  {set session name}
  SelectSession(FDataSettings.SessionType);

  {set database name}
  SelectDatabaseName(FDataSettings.DatabaseName);

  {set database type}
  SelectDatabaseType(FDataSettings.DatabaseType);

  SelectCollationType(FDataSettings.CollationType);
  SelectGuidCollationType(FDataSettings.GuidCollationType);
  SelectNullCollationType(FDataSettings.NullCollationType);

  ckbCaseSensitive.Checked := FDataSettings.IsCaseSensitive;

  {set SQL type}
  cbxSQLType.ItemIndex := Ord(FDataSettings.SQLType);

  ckbEditSQLAsText.Checked := FDataSettings.AllowEditSQL;

  {get list of any available data dictionary components}
  BuildDataDictionaryList;

  lbEnableDictionary := (cbxDataDictionary.Items.Count > 0);
  ckbDataDictionary.Enabled := lbEnableDictionary;
  lblUseDataDictionary.Enabled := lbEnableDictionary;

  if lbEnableDictionary then
    ckbDataDictionary.Checked := FDataSettings.UseDataDictionary
  else
    ckbDataDictionary.Checked := False;

  cbxDataDictionary.Enabled := ckbDataDictionary.Checked;

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.GetDatabaseType }

function TdaDataSettingsDialog.GetDatabaseType: TppDatabaseType;
begin

  if (cbxDatabaseType.ItemIndex = -1) then
    Result := dtOther
  else
    Result := TppDatabaseType(cbxDatabaseType.Items.Objects[cbxDatabaseType.ItemIndex]);

end; {function, GetDatabaseType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.GetCollationType }

function TdaDataSettingsDialog.GetCollationType: TppCollationType;
begin

  if (cbxCollationType.ItemIndex = -1) then
    Result := ctANSI
  else
    Result := TppCollationType(cbxCollationType.Items.Objects[cbxCollationType.ItemIndex]);

end; {function, GetCollationType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.GetGuidCollationType }

function TdaDataSettingsDialog.GetGuidCollationType: TppGuidCollationType;
begin

  if (cbxGuidCollationType.ItemIndex = -1) then
    Result := gcString
  else
    Result := TppGuidCollationType(cbxGuidCollationType.Items.Objects[cbxGuidCollationType.ItemIndex]);

end; {function, GetGuidCollationType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.GetDataDictionary }

function TdaDataSettingsDialog.GetDataDictionary: TppDataDictionary;
begin

  if ckbDataDictionary.Checked and (cbxDataDictionary.ItemIndex <> -1) then
    Result := TppDataDictionary(cbxDataDictionary.Items.Objects[cbxDataDictionary.ItemIndex])
  else
    Result := nil;

end; {function, GetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildDatabaseNameList }

procedure TdaDataSettingsDialog.BuildDatabaseNameList;
begin

  if (FSession = nil) then Exit;

  daGetDatabaseNames(TdaSessionClass(FSession.ClassType), cbxDatabaseName.Items, DataModule.Owner);

end; {procedure, BuildDatabaseNameList}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildDatabaseTypeList }

procedure TdaDataSettingsDialog.BuildDatabaseTypeList;
var
  lDatabaseType: TppDatabaseType;
  lsItem: String;
begin

  cbxDatabaseType.Items.Clear;

  if (FSession = nil) then Exit;

  for lDatabaseType := Low(TppDatabaseType) to High(TppDatabaseType) do
    begin
      if (lDatabaseType in FSession.ValidDatabaseTypes) then
        begin
          lsItem := ppGetEnumName(TypeInfo(TppDatabaseType), Ord(lDatabaseType));

          lsItem := Copy(lsItem, 3, Length(lsItem));

          cbxDatabaseType.Items.AddObject(lsItem, TObject(lDatabaseType));
        end;
    end;

end; {procedure, BuildDatabaseTypeList}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildDataDictionaryList }

procedure TdaDataSettingsDialog.BuildDataDictionaryList;
var
  lComponentList: TppCommunicatorPickList;
begin

  lComponentList := TppCommunicatorPickList.Create(TppCommunicator(DataModule), TppDataDictionary);

  cbxDataDictionary.Items.Assign(lComponentList);

  if FDataSettings.DataDictionary = nil then
    cbxDataDictionary.ItemIndex := 0
  else
    cbxDataDictionary.ItemIndex := cbxDataDictionary.Items.IndexOf(FDataSettings.DataDictionary.UserName);

  lComponentList.Free;

end; {procedure, BuildDataDictionaryList}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildSQLTypeList }

procedure TdaDataSettingsDialog.BuildSQLTypeList;
begin

  cbxSQLType.Items.Clear;

  cbxSQLType.Items.Add('Local SQL');
  cbxSQLType.Items.Add('SQL1');
  cbxSQLType.Items.Add('SQL2');

end; {procedure, BuildSQLTypeList}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildCollationTypeList }

procedure TdaDataSettingsDialog.BuildCollationTypeList;
begin

  cbxCollationType.Items.Clear;

  cbxCollationType.Items.AddObject('ANSI', TObject(Ord(ctANSI)));
  cbxCollationType.Items.AddObject('ASCII', TObject(Ord(ctASCII)));
  cbxCollationType.Items.AddObject('Binary', TObject(Ord(ctBinary)));
  cbxCollationType.Items.AddObject('Variant', TObject(Ord(ctVariant)));

end; {procedure, BuildCollationTypeList}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildGuidCollationTypeList }

procedure TdaDataSettingsDialog.BuildGuidCollationTypeList;
begin
  
  cbxGuidCollationType.Items.Clear;

  cbxGuidCollationType.Items.AddObject('MSSQLServer', TObject(Ord(gcMSSQLServer)));
  cbxGuidCollationType.Items.AddObject('MSAccess', TObject(Ord(gcMSAccess)));
  cbxGuidCollationType.Items.AddObject('GUID', TObject(Ord(gcGuid)));
  cbxGuidCollationType.Items.AddObject('String', TObject(Ord(gcString)));

end;

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.BuildNullCollationTypeList }

procedure TdaDataSettingsDialog.BuildNullCollationTypeList;
begin

  cbxNullCollationType.Items.Clear;

  cbxNullCollationType.Items.AddObject('NullsFirst', TObject(Ord(ncNullsFirst)));
  cbxNullCollationType.Items.AddObject('NullsLast', TObject(Ord(ncNullsLast)));

end; 
{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.ehTabSet_TabSelected }

procedure TdaDataSettingsDialog.ehTabSet_TabSelected(Sender: TObject; Item: TppJvTabBarItem);
begin

  Notebook1.PageIndex := Item.Index;

end;

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.GetNullCollationType }

function TdaDataSettingsDialog.GetNullCollationType: TppNullCollationType;
begin

  if (cbxNullCollationType.ItemIndex = -1) then
    Result := ncNullsFirst
  else
    Result := TppNullCollationType(cbxNullCollationType.Items.Objects[cbxNullCollationType.ItemIndex]);

end; {function, GetGuidCollationType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SelectSession }

procedure TdaDataSettingsDialog.SelectSession(const aSessionName: String);
var
  lSessionClass: TdaSessionClass;
begin

  if (FSession <> nil) and (CompareText(FSession.ClassName, aSessionName) = 0) then Exit;

  if (FSession <> nil) then
    begin
      FSession.Free;
      
      FSession := nil;
    end;

  lSessionClass := daGetSessionClass(aSessionName);

  if (lSessionClass <> nil) then
    begin
      FSession := lSessionClass.Create(Self);
      if (DataModule <> nil) then
        FSession.DataOwner := DataModule.Owner;
    end;

  BuildDatabaseTypeList;
  BuildDatabaseNameList;

  cbxSessionType.ItemIndex := cbxSessionType.Items.IndexOf(aSessionName);

  SelectDatabaseName('');

end; {procedure, SelectSession}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SelectDatabaseName }

procedure TdaDataSettingsDialog.SelectDatabaseName(const aDatabaseName: String);
var
  lDatabaseType: TppDatabaseType;
begin
  cbxDatabaseName.Text := '';
  cbxDatabaseName.ItemIndex := cbxDatabaseName.Items.IndexOf(aDatabaseName);

  if (FSession <> nil) then
    lDatabaseType := FSession.GetDatabaseType(aDatabaseName)
  else
    lDatabaseType := dtOther;

  SelectDatabaseType(lDatabaseType);

end; {procedure, SelectDatabaseName}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SelectDatabaseType }

procedure TdaDataSettingsDialog.SelectDatabaseType(aDatabaseType: TppDatabaseType);
var
  lbFound: Boolean;
  liIndex: Integer;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < cbxDatabaseType.Items.Count) do
    begin
      if (aDatabaseType = TppDatabaseType(cbxDatabaseType.Items.Objects[liIndex])) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if (lbFound) then
    cbxDatabaseType.ItemIndex := liIndex
  else
    cbxDatabaseType.ItemIndex := -1;

  if (FSession <> nil) then
    begin
      cbxSQLType.ItemIndex := Ord(FSession.DefaultSQLType(aDatabaseType));
      cbxCollationType.ItemIndex := Ord(FSession.DefaultCollationType(aDatabaseType));
      cbxGuidCollationType.ItemIndex := Ord(FSession.DefaultGuidCollationType(aDatabaseType));
      cbxNullCollationType.ItemIndex := Ord(FSession.DefaultNullCollationType(aDatabaseType));
      ckbCaseSensitive.Checked := FSession.DefaultIsCaseSensitive(aDatabaseType);
    end;

end; {procedure, SelectDatabaseType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SelectCollationType }

procedure TdaDataSettingsDialog.SelectCollationType(aCollationType: TppCollationType);
var
  lbFound: Boolean;
  liIndex: Integer;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < cbxCollationType.Items.Count) do
    begin
      if (aCollationType = TppCollationType(cbxCollationType.Items.Objects[liIndex])) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if (lbFound) then
    cbxCollationType.ItemIndex := liIndex
  else
    cbxCollationType.ItemIndex := -1;

end; {procedure, SelectCollationType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SelectGuidCollationType }

procedure TdaDataSettingsDialog.SelectGuidCollationType(aGuidCollationType: TppGuidCollationType);
var
  lbFound: Boolean;
  liIndex: Integer;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < cbxGuidCollationType.Items.Count) do
    begin
      if (aGuidCollationType = TppGuidCollationType(cbxGuidCollationType.Items.Objects[liIndex])) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if (lbFound) then
    cbxGuidCollationType.ItemIndex := liIndex
  else
    cbxGuidCollationType.ItemIndex := -1;

end; {procedure, SelectGuidCollationType}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.LanguageChanged }

procedure TdaDataSettingsDialog.LanguageChanged;
begin

  Caption := ppLoadStr(748); {Database Settings}

  lblSessionType.Caption := ppLoadStr(825); {Session Type}
  lblDatabaseName.Caption := ppLoadStr(747); {Database Name}
  lblSQLType.Caption := ppLoadStr(831); {SQL Type}
  lblUseDataDictionary.Caption := ppLoadStr(745); {Data Dictionary}
  lblEditSQLAsText.Caption := ppLoadStr(720);  {Allow Edit SQL As Text}
  lblDatabaseType.Caption := ppLoadStr(843); {Database Type}

  FTabSet.Tabs[0].Caption := ppLoadStr(1090); {Connection}
  FTabSet.Tabs[1].Caption := 'SQL';  // no need to localize
  lblCaseSensitive.Caption := ppLoadStr(860); {Case Sensitive}
  lblCollationType.Caption := ppLoadStr(861); {Collation Type}
  lblGuidCollation.Caption := ppLoadStr(862); {Guid Collation}
//  lblNullCollation.Caption := 'Null - ' ppLoadStr(862); {Null Collation}    // TODO Lang


  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.SelectNullCollationType }

procedure TdaDataSettingsDialog.SelectNullCollationType(aNullCollationType: TppNullCollationType);
var
  lbFound: Boolean;
  liIndex: Integer;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < cbxNullCollationType.Items.Count) do
    begin
      if (aNullCollationType = TppNullCollationType(cbxNullCollationType.Items.Objects[liIndex])) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if (lbFound) then
    cbxNullCollationType.ItemIndex := liIndex
  else
    cbxNullCollationType.ItemIndex := -1;

end; {procedure, SelectNullCollationType}











end.
