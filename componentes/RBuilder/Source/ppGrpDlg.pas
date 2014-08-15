{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppGrpDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes,
  Graphics,
  Forms,
  Controls,
  Buttons,
  StdCtrls,
  Dialogs,
  SysUtils,
  ExtCtrls,
  Mask,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils,
  ppIniStorage;

type

  {@TppGroupDialog }
  TppGroupDialog = class(TppCustomGroupDialog)
    lstGroups: TListBox;
    btnAdd: TButton;
    btnInsert: TButton;
    btnDelete: TButton;
    gbxBreakOn: TGroupBox;
    gbxOnGroupBreak: TGroupBox;
    lblNewColumnThreshold: TLabel;
    lblNewPageThreshold: TLabel;
    edtNewColumnThreshold: TEdit;
    edtNewPageThreshold: TEdit;
    cbxReprintOnColumn: TCheckBox;
    cbxReprintOnPage: TCheckBox;
    bvlWindow: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    cbxKeepTogether: TCheckBox;
    cbxNewColumn: TCheckBox;
    cbxResetPageNo: TCheckBox;
    cbxNewPage: TCheckBox;
    rdbCustomField: TRadioButton;
    rdbDataField: TRadioButton;
    cbxBreakDescriptions: TComboBox;
    cbxNewFile: TCheckBox;
    cbxStartOnOddPage: TCheckBox;
    cbxEmailFile: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure lstFieldsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cbxBreakDescriptionsChange(Sender: TObject);
    procedure lstGroupsClick(Sender: TObject);
    procedure lstGroupsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstGroupsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure cbxEmailFileClick(Sender: TObject);
    procedure cbxNewFileClick(Sender: TObject);
    procedure cbxStartOnOddPageClick(Sender: TObject);
    procedure cbxNewPageClick(Sender: TObject);
    procedure cbxResetPageNoClick(Sender: TObject);
    procedure cbxReprintOnPageClick(Sender: TObject);
    procedure edtNewPageThresholdChange(Sender: TObject);
    procedure rdbBreakOnClick(Sender: TObject);
    procedure cbxNewColumnClick(Sender: TObject);
    procedure cbxReprintOnColumnClick(Sender: TObject);
    procedure edtNewColumnThresholdChange(Sender: TObject);
    procedure cbxKeepTogetherClick(Sender: TObject);

  private
    FCustomFieldDescriptions: TStringList;
    FCustomFieldNames: TStringList;
    FDataFieldNames: TStringList;
    FDataFieldDescriptions: TStringList;
    FMinHeight: Integer;
    FMinWidth: Integer;
    FSpacer: Integer;

    procedure ActivateControls(aValue: Boolean);
    procedure CreateNewGroup(aIndex: Integer);
    function  GetBreakDescription(aIndex: Integer): String;
    procedure LoadStateInfo;
    procedure SaveStateInfo;
    procedure SetBreakDescription(aBreakDescription: String);
    procedure UpdateDescriptions;

    procedure AddGroupToReport(aGroupOptions: TObject);
    procedure GetFieldForAlias(const FieldAlias: String; var aDataPipeline: TObject; var aDataField: String);

  protected
    procedure Activate; override;
    procedure LanguageChanged; override;
    procedure ReportAssigned; override;

    function GetFieldAliases: TStrings; override;
    procedure SetFieldAliases(aFieldAliases: TStrings); override;

  end; {class, TppGroupDialog}


var
  ppGroupDialog: TppGroupDialog;

implementation

uses
  ppClass, ppBands, ppDB, ppClasUt;

{$R *.DFM}

type

 {@TppGroupOptions }
  TppGroupOptions = class(TObject)
    public
      BreakDescription: String;
      BreakName: String;
      BreakType: TppBreakType;
      DataPipeline: TppDataPipeline;
      Group: TppGroup;
      KeepTogether: Boolean;
      NewColumn: Boolean;
      NewColumnThreshold: Single;
      NewPage: Boolean;               
      NewPageThreshold: Single;
      ReprintOnColumn: Boolean;
      ReprintOnPage: Boolean;
      ResetPageNo: Boolean;
      NewFile: Boolean;
      EmailFile: Boolean;
      StartOnOddPage: Boolean;
  end; {class, TGroupOptions}

{------------------------------------------------------------------------------}
{ TppGroupDialog.FormCreate }

procedure TppGroupDialog.FormCreate(Sender: TObject);
begin
  FDataFieldNames          := TStringList.Create;
  FCustomFieldNames        := TStringList.Create;
  FDataFieldDescriptions   := TStringList.Create;
  FCustomFieldDescriptions := TStringList.Create;

  FDataFieldNames.Sorted          := False;
  FCustomFieldNames.Sorted        := False;
  FDataFieldDescriptions.Sorted   := False;
  FCustomFieldDescriptions.Sorted := False;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppGroupDialog.FormClose }

procedure TppGroupDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var
  liGroup : Integer;

begin

  SaveStateInfo;

  {destroy group options objects}
  for liGroup := 0 to lstGroups.Items.Count-1 do
    TppGroupOptions(lstGroups.Items.Objects[liGroup]).Free;

  lstGroups.Items.Clear;

  FDataFieldNames.Free;
  FCustomFieldNames.Free;
  FDataFieldDescriptions.Free;
  FCustomFieldDescriptions.Free;

  Action := caFree;

end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ TppGroupDialog.LoadStateInfo }

procedure TppGroupDialog.LoadStateInfo;
var
  lIniStorage: TppIniStorage;
  liLeft: Integer;
  liTop: Integer;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;
  CalcScreenCenter(liLeft, liTop);

  try
    Top :=  lIniStorage.ReadInteger('GroupDialog', 'FormTop', liTop);
    Left :=  lIniStorage.ReadInteger('GroupDialog', 'FormLeft', liLeft);
    Width := lIniStorage.ReadInteger('GroupDialog', 'FormWidth', FMinWidth);
    Height := lIniStorage.ReadInteger('GroupDialog', 'FormHeight', FMinHeight);
  finally
    lIniStorage.Free;
  end;

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppGroupDialog.SaveStateInfo }

procedure TppGroupDialog.SaveStateInfo;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try
    lIniStorage.WriteInteger('GroupDialog', 'FormTop', Top);
    lIniStorage.WriteInteger('GroupDialog', 'FormLeft', Left);
    lIniStorage.WriteInteger('GroupDialog', 'FormWidth', Width);
    lIniStorage.WriteInteger('GroupDialog', 'FormHeight', Height);
  finally
    lIniStorage.Free;
  end;

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TppGroupDialog.Activate }

procedure TppGroupDialog.Activate;
var
  liGroups: Integer;
  liGroup: Integer;
  lGroup: TppGroup;
  lGroupOptions: TppGroupOptions;
  lsFieldAlias: String;
  lsFieldName: String;
  lDataPipeline: TObject;
  liField: Integer;
  lReport: TppCustomReport;

begin

  if (Report = nil) or not (Report is TppCustomReport) then Exit;

  lReport := TppCustomReport(Report);

  {get group break descriptions}
  ppGetCustomTextComponents(lReport, FCustomFieldNames, False);
  ppGetCustomTextComponents(lReport, FCustomFieldDescriptions, True);

  if (FieldAliases.Count = 0) then
    begin
      cbxBreakDescriptions.Sorted := True;

      ppGetFields(lReport, FDataFieldNames, False);
      ppGetFields(lReport, FDataFieldDescriptions, True)
    end

  else {use field aliases }
    begin
      cbxBreakDescriptions.Sorted := False;

      for liField := 0 to FDataFieldDescriptions.Count - 1 do
        begin
          lsFieldAlias := FDataFieldDescriptions[liField];

          GetFieldForAlias(lsFieldAlias, lDataPipeline, lsFieldName);

          FDataFieldNames.AddObject(lsFieldName, lDataPipeline);
        end;

    end;

  {save group settings, load group list box}
  lstGroups.Clear;

  liGroups := lReport.GroupCount - 1 ;

  for liGroup := 0 to liGroups do
    begin

      lGroupOptions := TppGroupOptions.Create;

      lGroup := lReport.Groups[liGroup];

      lGroupOptions.BreakName          := lGroup.BreakName;
      lGroupOptions.BreakType          := lGroup.BreakType;
      lGroupOptions.DataPipeline       := lGroup.DataPipeline;
      lGroupOptions.Group              := lGroup;
      lGroupOptions.NewPage            := lGroup.NewPage;
      lGroupOptions.NewPageThreshold   := lGroup.NewPageThreshold;
      lGroupOptions.KeepTogether       := lGroup.KeepTogether;
      lGroupOptions.NewColumn          := lGroup.NewColumn;
      lGroupOptions.NewColumnThreshold := lGroup.NewColumnThreshold;
      lGroupOptions.ReprintOnColumn    := lGroup.ReprintOnSubsequentColumn;
      lGroupOptions.ReprintOnPage      := lGroup.ReprintOnSubsequentPage;
      lGroupOptions.ResetPageNo        := lGroup.ResetPageNo;
      lGroupOptions.NewFile            := lGroup.GroupFileSettings.NewFile;
      lGroupOptions.EmailFile          := lGroup.GroupFileSettings.EmailFile;
      lGroupOptions.StartOnOddPage     := lGroup.StartOnOddPage;

      lstGroups.Items.AddObject(lGroup.Description, lGroupOptions);

    end;

  UpdateDescriptions;

  if (lstGroups.Items.Count > 0) then
    ActivateControls(True)
  else
    ActivateControls(False);

  {initialize list box and associated group options}
  if (lstGroups.Items.Count > 0) then
    begin
      lstGroups.ItemIndex := 0;
      lstGroupsClick(Self);
    end

  else {initialize to empty}
    begin

      btnAdd.Enabled := True;
      btnDelete.Enabled := False;

      {there are fields to group on from the pipeline}
      if (FDataFieldNames.Count > 0) then
        begin
          rdbDataField.Enabled := True;
          rdbDataField.Checked := True;
          cbxBreakDescriptions.Items.Assign(FDataFieldDescriptions);

          {there also are custom fields in the report or not}
          if (FCustomFieldDescriptions.Count > 0) then
            rdbCustomField.Enabled := True
          else
            rdbCustomField.Enabled := False;

        end

      {there are no fields in the pipe, there are custom fields in the report}
      else if (FCustomFieldDescriptions.Count > 0) then
        begin
          rdbDataField.Enabled := False;
          rdbDataField.Checked := False;

          rdbCustomField.Enabled := True;
          rdbCustomField.Checked := True;
          cbxBreakDescriptions.Items.Assign(FCustomFieldDescriptions);
        end

      {there are no fields at all to group on}  
      else
        begin
          rdbDataField.Enabled := False;
          rdbDataField.Checked := False;

          rdbCustomField.Enabled := False;
          rdbCustomField.Checked := False;

          btnAdd.Enabled := False;
          btnDelete.Enabled := False;
        end;

      {default control values}
      lstGroups.ItemIndex := -1;
      cbxBreakDescriptions.ItemIndex := 0;
      cbxReprintOnColumn.Checked := True;
      cbxReprintOnPage.Checked := True;

    end;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppGroupDialog.ActivateControls }

procedure TppGroupDialog.ActivateControls(aValue: Boolean);
begin

    edtNewColumnThreshold.Enabled := aValue;
    lblNewColumnThreshold.Enabled := aValue;

    edtNewPageThreshold.Enabled := aValue;
    lblNewPageThreshold.Enabled := aValue;


    if aValue then
      begin
        edtNewColumnThreshold.Color := clWhite;
        edtNewColumnThreshold.BorderStyle := bsSingle;

        edtNewPageThreshold.Color := clWhite;
        edtNewPageThreshold.BorderStyle := bsSingle;
      end

    else
      begin
        edtNewColumnThreshold.Color := clBtnFace;
        edtNewColumnThreshold.BorderStyle := bsNone;

        edtNewPageThreshold.Color := clBtnFace;
        edtNewPageThreshold.BorderStyle := bsNone;
      end;

    cbxNewPage.Enabled := aValue;
    cbxNewColumn.Enabled := aValue;
    cbxKeepTogether.Enabled := aValue;
    cbxReprintOnPage.Enabled := aValue;
    cbxReprintOnColumn.Enabled := aValue;
    cbxNewFile.Enabled := aValue;
    cbxEmailFile.Enabled := aValue;
    cbxStartOnOddPage.Enabled := aValue;
    cbxResetPageNo.Enabled := False;


    if (FDataFieldNames.Count = 0) and (FCustomFieldNames.Count = 0) then
      begin
        btnAdd.Enabled := False;
        btnInsert.Enabled := False;
      end

    else
      begin
        btnInsert.Enabled := aValue;
        btnDelete.Enabled := aValue;
      end;

end; {procedure, ActivateControls}

{------------------------------------------------------------------------------}
{ TppGroupDialog.ReportAssigned }

procedure TppGroupDialog.ReportAssigned;
var
  lReport: TppCustomReport;
begin

  if (Report = nil) or not (Report is TppCustomReport) then Exit;

  lReport := TppCustomReport(Report);

  FSpacer := Trunc(ppFromMMThousandths(2381, utScreenPixels, pprtVertical, nil));

  {need to hide the column threshold label and edit box, and reprint on new column chkbox}
  if (lReport.Columns <= 1) then
    begin

      FMinHeight := Trunc(ppFromMMThousandths(109273, utScreenPixels, pprtVertical, nil));

      lblNewColumnThreshold.Visible := False;

      edtNewColumnThreshold.Visible := False;

      cbxReprintOnColumn.Visible := False;

      cbxNewColumn.Visible := False;

      cbxNewFile.Top := cbxNewPage.Top;

      cbxEmailFile.Top := cbxResetPageNo.Top;

      gbxOnGroupBreak.Height := lblNewPageThreshold.Top + lblNewPageThreshold.Height + FSpacer;

      cbxKeepTogether.Top := gbxOnGroupBreak.Top + gbxOnGroupBreak.Height + FSpacer;

      cbxReprintOnPage.Top := cbxKeepTogether.Top + cbxKeepTogether.Height + FSpacer;

      bvlWindow.Height := cbxReprintOnPage.Top + cbxReprintOnPage.Height + FSpacer;

      btnOK.Top := bvlWindow.Height + FSpacer;

      btnCancel.Top := bvlWindow.Height + FSpacer;

    end

  else
    begin
      FMinHeight := Trunc(ppFromMMThousandths(118798, utScreenPixels, pprtVertical, nil));

    end;

  Constraints.MinHeight := FMinHeight;

  ClientHeight := btnOK.Top + btnOK.Height + FSpacer;
  ClientWidth := btnCancel.Left + btnCancel.Width + FSpacer;

  lstGroups.Anchors := [akLeft, akTop, akRight, akBottom];

  gbxBreakOn.Anchors := [akLeft, akRight, akBottom];

  gbxOnGroupBreak.Anchors := [akLeft, akRight, akBottom];

  cbxKeepTogether.Anchors := [akLeft, akBottom];

  cbxReprintOnPage.Anchors := [akLeft, akBottom];

  cbxNewFile.Anchors := [akLeft, akBottom];

  cbxEmailFile.Anchors := [akLeft, akBottom];

  cbxStartOnOddPage.Anchors := [akLeft, akBottom];

  cbxReprintOnColumn.Anchors := [akLeft, akBottom];

  bvlWindow.Anchors := [akLeft, akRight, akTop, akBottom];

  btnOK.Anchors := [akRight, akBottom];

  btnCancel.Anchors := [akRight, akBottom];

  btnAdd.Anchors := [akTop, akRight];

  btnInsert.Anchors := [akTop, akRight];

  btnDelete.Anchors := [akTop, akRight];

  cbxBreakDescriptions.Anchors := [akRight, akLeft, akTop];

  LoadStateInfo;

end; {procedure, ReportAssigned}

{------------------------------------------------------------------------------}
{ TppGroupDialog.GetFieldAliases }

function TppGroupDialog.GetFieldAliases: TStrings;
begin
  Result := FDataFieldDescriptions;
end; {procedure, GetFieldAliases}

{------------------------------------------------------------------------------}
{ TppGroupDialog.SetFieldAliases }

procedure TppGroupDialog.SetFieldAliases(aFieldAliases: TStrings);
begin
  FDataFieldDescriptions.Assign(aFieldAliases);
end; {procedure, SetFieldAliases}

{------------------------------------------------------------------------------}
{ TppGroupDialog.GetFieldForAlias }

procedure TppGroupDialog.GetFieldForAlias(const FieldAlias: String;
                                             var aDataPipeline: TObject; var aDataField: String);
begin
  DoGetFieldForAlias(FieldAlias, aDataPipeline, aDataField);
end; {procedure, GetFieldForAlias}

{------------------------------------------------------------------------------}
{ TppGroupDialog.spbOKClick }

procedure TppGroupDialog.btnOKClick(Sender: TObject);
var
  liGroups: Integer;
  liGroup: Integer;
  lGroup: TppGroup;
  lGroupOptions: TppGroupOptions;
  lReport: TppCustomReport;
begin

  lReport := TppCustomReport(Report);

  lReport.BeginUpdate;

  liGroups := lstGroups.Items.Count;

  {process each group in list box}
  for liGroup := 0 to liGroups - 1 do
    begin

      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liGroup]);

      {create new group}
      if (lGroupOptions.Group = nil) then
        AddGroupToReport(lGroupOptions);

      lGroup := lGroupOptions.Group;

      {set group position}
      lReport.SetGroupPosition(lGroup, liGroup);

      {set group properties}
      lGroup.BreakName                   := lGroupOptions.BreakName;
      lGroup.BreakType                   := lGroupOptions.BreakType;
      lGroup.DataPipeline                := lGroupOptions.DataPipeline;
      lGroup.KeepTogether                := lGroupOptions.KeepTogether;
      lGroup.NewColumn                   := lGroupOptions.NewColumn;
      lGroup.NewColumnThreshold          := lGroupOptions.NewColumnThreshold;
      lGroup.NewPage                     := lGroupOptions.NewPage;
      lGroup.NewPageThreshold            := lGroupOptions.NewPageThreshold;
      lGroup.ReprintOnSubsequentColumn   := lGroupOptions.ReprintOnColumn;
      lGroup.ReprintOnSubsequentPage     := lGroupOptions.ReprintOnPage;
      lGroup.ResetPageNo                 := lGroupOptions.ResetPageNo;
      lGroup.GroupFileSettings.NewFile   := lGroupOptions.NewFile;
      lGroup.GroupFileSettings.EmailFile := lGroupOptions.EmailFile;
      lGroup.StartOnOddPage              := lGroupOptions.StartOnOddPage;

    end; {for, each group}

  {set liGroups to number of groups in report writer}
  liGroups := lReport.GroupCount - 1;

  {delete any groups beyond current list}
  for liGroup :=  liGroups downto lstGroups.Items.Count do
    lReport.Groups[liGroup].Free;

  lReport.EndUpdate;

end;  {procedure, spbOKClick }


{------------------------------------------------------------------------------}
{ TppGroupDialog.AddGroupToReport}

procedure TppGroupDialog.AddGroupToReport(aGroupOptions: TObject);
var
  lReport: TppCustomReport;
  lGroup: TppGroup;
  lGroupBand: TppGroupBand;
  lGroupOptions: TppGroupOptions;

begin

  if (Report = nil) then Exit;

  lGroupOptions := TppGroupOptions(aGroupOptions);

  lReport := TppCustomReport(Report);

  {add group to report}
  lGroup := TppGroup(ppComponentCreate(lReport, TppGroup));

  lGroup.Report := lReport;

  lGroup.BreakType    :=  lGroupOptions.BreakType;
  lGroup.BreakName    :=  lGroupOptions.BreakName;
  lGroup.DataPipeline :=  lGroupOptions.DataPipeline;

  {add group header and footer bands }
  lGroupBand := TppGroupBand(ppComponentCreate(lReport,TppGroupHeaderBand));
  lGroupBand.Group := lGroup;

  lGroupBand := TppGroupBand(ppComponentCreate(lReport,TppGroupFooterBand));
  lGroupBand.Group := lGroup;

  {add new object reference to the group options}
  lGroupOptions.Group := lGroup;


end; {procedure, AddGroupToReport}

{------------------------------------------------------------------------------}
{ TppGroupDialog.lstFieldsMouseDown - set dragging}

procedure TppGroupDialog.lstFieldsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lPoint   : TPoint;
  liIndex  : Integer;
  lbExists : Boolean;

begin
  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;

  liIndex  := lstGroups.ItemAtPos(lPoint, lbExists);

  if (liIndex <> -1) then
    lstGroups.BeginDrag(False);
end;


{------------------------------------------------------------------------------}
{ TppGroupDialog.lstGroupsDragOver }

procedure TppGroupDialog.lstGroupsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  lPoint     : TPoint;
  liIndex    : Integer;
  lbSelected : Boolean;
  lbExists   : Boolean;

begin
  lPoint.X := X;
  lPoint.Y := Y;

  lbExists := True;

  liIndex := lstGroups.ItemAtPos(lPoint, lbExists);
  
  if (liIndex <> -1) then
    begin
      lbSelected := lstGroups.Selected[liIndex];
      if not(lbSelected) then
        Accept := True
      else
        Accept := False;
    end
  else
    Accept := False;

end; {procedure, lstGroupsDragOver}

{------------------------------------------------------------------------------}
{ TppGroupDialog.lstGroupsEndDrag }

procedure TppGroupDialog.lstGroupsEndDrag(Sender, Target: TObject; X, Y: Integer);
var
  lPoint : TPoint;
  lbExists : Boolean;
  liIndex : Integer;
  liGroup : Integer;

  begin
  if (Target <> nil) then
    begin
      {move selection to new position}
      lPoint.X := X;
      lPoint.Y := Y;
      lbExists := True;
      
      liIndex := lstGroups.ItemAtPos(lPoint, lbExists);

      for liGroup := 0 to lstGroups.Items.Count - 1  do
        if lstGroups.Selected[liGroup] then
            lstGroups.Items.Move(liGroup,liIndex);

      {re-number group descriptions}
      UpdateDescriptions;

      lstGroups.ItemIndex := liIndex;

    end;

end;  {procedure, lstGroupsEndDrag}


{------------------------------------------------------------------------------}
{ TppGroupDialog.lstGroupsClick }

procedure TppGroupDialog.lstGroupsClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[lstGroups.ItemIndex]);


  {set group option values}
  rdbDataField.Checked   := (lGroupOptions.BreakType = btDataField);
  rdbCustomField.Checked := (lGroupOptions.BreakType = btCustomField);

  if lGroupOptions.BreakType = btDataField then
    cbxBreakDescriptions.Items.Assign(FDataFieldDescriptions)
  else
    cbxBreakDescriptions.Items.Assign(FCustomFieldDescriptions);


  {set cbxBreakDescription to current item}
  liIndex := cbxBreakDescriptions.Items.IndexOf(GetBreakDescription(lstGroups.ItemIndex));

  cbxBreakDescriptions.ItemIndex := liIndex;


  {set controls based on group properties}
  cbxNewColumn.Checked        := lGroupOptions.NewColumn;

  if edtNewColumnThreshold.Enabled then
    edtNewColumnThreshold.Text  := FloatToStrF(lGroupOptions.NewColumnThreshold, ffGeneral,  7, 0);

  cbxNewPage.Checked          := lGroupOptions.NewPage;
  cbxNewFile.Checked          := lGroupOptions.NewFile;
  cbxEmailFile.Checked        := lGroupOptions.EmailFile;
  cbxStartOnOddPage.Checked   := lGroupOptions.StartOnOddPage;

  if edtNewPageThreshold.Enabled then
    edtNewPageThreshold.Text    := FloatToStrF(lGroupOptions.NewPageThreshold, ffGeneral,  7, 0);

  cbxReprintOnColumn.Checked  := lGroupOptions.ReprintOnColumn;
  cbxReprintOnPage.Checked    := lGroupOptions.ReprintOnPage;


  {enable/disable reset page no. option}
  cbxResetPageNo.Checked := lGroupOptions.ResetPageNo;
  cbxResetPageNo.Enabled := cbxNewPage.Checked;

  cbxKeepTogether.Checked := lGroupOptions.KeepTogether;
  cbxKeepTogether.Enabled := not(cbxNewPage.Checked);

  {enable/disable new column threshold option}
  if lGroupOptions.NewColumn then
    begin
      edtNewColumnThreshold.Font.Color := clBtnFace;
      edtNewColumnThreshold.Enabled := False;
      edtNewColumnThreshold.BorderStyle := bsNone;
    end
  else
    begin
      edtNewColumnThreshold.Font.Color := clBlack;
      edtNewColumnThreshold.Enabled := True;
      edtNewColumnThreshold.BorderStyle := bsSingle;
    end;

  {enable/disable new page threshold option}
  if lGroupOptions.NewPage then
    begin
      edtNewPageThreshold.Font.Color := clBtnFace;
      edtNewPageThreshold.Enabled := False;
      edtNewPageThreshold.BorderStyle := bsNone;
    end
  else
    begin
      edtNewPageThreshold.Font.Color := clBlack;
      edtNewPageThreshold.Enabled := True;
      edtNewPageThreshold.BorderStyle := bsSingle;
    end;

end; {procedure, lstGroupsClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxBreakDescriptionsChange }

procedure TppGroupDialog.cbxBreakDescriptionsChange(Sender: TObject);
var
  lsBreakDescription : String;
  liIndex : Integer;
begin

  lsBreakDescription := cbxBreakDescriptions.Items[cbxBreakDescriptions.ItemIndex];

  liIndex := lstGroups.ItemIndex;

  if (liIndex > -1) and (liIndex <= lstGroups.Items.Count - 1) then
    SetBreakDescription(lsBreakDescription);

  lstGroups.ItemIndex := liIndex;

end; {procedure, cbxBreakDescriptionsChange}

{------------------------------------------------------------------------------}
{ TppGroupDialog.spbDeleteClick }

procedure TppGroupDialog.btnDeleteClick(Sender: TObject);
var
  liIndex : Integer;
  liItems : Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex <= lstGroups.Items.Count) and (lstGroups.Items.Count > 0)then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);
      lGroupOptions.Free;
      lstGroups.Items.Delete(liIndex);
    end;

  UpdateDescriptions;

  liItems := lstGroups.Items.Count;

  Inc(liIndex);

  if (liItems > 0) then
    begin
      if (liIndex >= liItems) then
        lstGroups.ItemIndex := liItems - 1
      else
        lstGroups.ItemIndex := liIndex;

      lstGroupsClick(Self);
    end
  else
    lstGroups.ItemIndex := -1;

  if (lstGroups.Items.Count = 0) then
    ActivateControls(False);

end; {procedure, spbDeleteClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.spbAddClick }

procedure TppGroupDialog.btnAddClick(Sender: TObject);
begin

  ActivateControls(True);

  if cbxBreakDescriptions.Items.Count = 0 then
    begin

      if rdbDataField.Checked then
        MessageDlg(ppLoadStr(329), mtInformation,[mbOK],0)
      else
        MessageDlg(ppLoadStr(330), mtInformation,[mbOK],0);

      if (FDataFieldNames.Count = 0) and (FCustomFieldNames.Count = 0) and (lstGroups.Items.Count = 0) then
        ActivateControls(False);

    end

  else
    begin
      CreateNewGroup(lstGroups.Items.Count);

      lstGroups.ItemIndex := lstGroups.Items.Count - 1;

      {update controls to reflect group property values}
      lstGroupsClick(Self);
    end;

end; {procedure, spbAddClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.spbInsertClick }

procedure TppGroupDialog.btnInsertClick(Sender: TObject);
var
  liIndex: Integer;
begin

  ActivateControls(True);

  liIndex := lstGroups.ItemIndex;

  if (rdbDataField.Checked and (FDataFieldNames.Count > 0)) or (rdbCustomField.Checked and (FCustomFieldNames.Count > 0)) then
    begin
      if (liIndex >= 0) and (liIndex <= lstGroups.Items.Count) then
        CreateNewGroup(liIndex);
    end

  else
    begin

      if rdbDataField.Checked then
        MessageDlg(ppLoadStr(329), mtInformation,[mbOK],0)
      else
        MessageDlg(ppLoadStr(330), mtInformation,[mbOK],0);

      if (lstGroups.Items.Count = 0) then
        ActivateControls(False);
    end;

  lstGroups.ItemIndex := liIndex;

  {update controls to reflect group property values}
  if (liIndex > 0) then
    lstGroupsClick(Self);

end; {procedure, spbInsertClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.CreateNewGroup }

procedure TppGroupDialog.CreateNewGroup(aIndex: Integer);
var
  lsBreakDescription: String;
  lGroupOptions: TppGroupOptions;
  liBreakIndex: Integer;
begin
  lGroupOptions := TppGroupOptions.Create;

  lGroupOptions.Group := nil;

  {assign breakname property}
  lsBreakDescription := cbxBreakDescriptions.Items[cbxBreakDescriptions.ItemIndex];

  if rdbDataField.Checked then
    begin
      lGroupOptions.BreakType := btDataField;
      liBreakIndex := FDataFieldDescriptions.IndexOf(lsBreakDescription);
      lGroupOptions.BreakName := FDataFieldNames[liBreakIndex];
      lGroupOptions.DataPipeline := TppDataPipeline(FDataFieldNames.Objects[liBreakIndex]);
    end
  else
    begin
      lGroupOptions.BreakType := btCustomField;
      liBreakIndex := FCustomFieldDescriptions.IndexOf(lsBreakDescription);
      lGroupOptions.BreakName := FCustomFieldNames[liBreakIndex];
      lGroupOptions.DataPipeline := nil;
    end;

  {default remaining properties}
  lGroupOptions.KeepTogether        := True;
  lGroupOptions.NewColumn           := False;
  lGroupOptions.NewColumnThreshold  := 0;
  lGroupOptions.NewPage             := False;
  lGroupOptions.NewPageThreshold    := 0;
  lGroupOptions.ResetPageNo         := False;
  lGroupOptions.ReprintOnColumn     := True;
  lGroupOptions.ReprintOnPage       := True;
  lGroupOptions.NewFile             := False;
  lGroupOptions.EmailFile           := False;

  lstGroups.Items.InsertObject(aIndex, ':' + lsBreakDescription, lGroupOptions);

  UpdateDescriptions;

end; {procedure, CreateNewGroup}

{------------------------------------------------------------------------------}
{ TppGroupDialog.UpdateDescriptions }

procedure TppGroupDialog.UpdateDescriptions;
var
  liGroups : Integer;
  liGroup : Integer;
begin

  liGroups := lstGroups.Items.Count - 1;

  {assign the group description}
  for liGroup := 0 to liGroups do
    begin
      lstGroups.Items[liGroup] := ppLoadStr(331) +
                                  '[' + IntToStr(liGroup) + ']:' +
                                  GetBreakDescription(liGroup);
    end;


end; {procedure, UpdateDescriptions}

{------------------------------------------------------------------------------}
{ TppGroupDialog.SetBreakDescription }

procedure TppGroupDialog.SetBreakDescription(aBreakDescription: String);
var
  lsGroup : String;
  liGroupIndex : Integer;
  liBreakIndex: Integer;
  lGroupOptions: TppGroupOptions;
begin
  liGroupIndex := lstGroups.ItemIndex;

  lsGroup := lstGroups.Items[liGroupIndex];

  {extract break description from full description}
  lsGroup := Copy(lsGroup, 1, Pos(':',lsGroup));

  {recreate the group description}
  lstGroups.Items[liGroupIndex] := lsGroup + aBreakDescription;

  lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liGroupIndex]);

  {assign breakname property}
  if lGroupOptions.BreakType = btDataField then
    begin
      liBreakIndex := FDataFieldDescriptions.IndexOf(aBreakDescription);
      lGroupOptions.BreakName := FDataFieldNames[liBreakIndex];
      lGroupOptions.DataPipeline := TppDataPipeline(FDataFieldNames.Objects[liBreakIndex]);
    end
  else
    begin
      liBreakIndex := FCustomFieldDescriptions.IndexOf(aBreakDescription);
      lGroupOptions.BreakName := FCustomFieldNames[liBreakIndex];
      lGroupOptions.DataPipeline := nil;
    end;

end; {procedure, SetBreakDescription}

{------------------------------------------------------------------------------}
{ TppGroupDialog.GetBreakDescription }

function TppGroupDialog.GetBreakDescription(aIndex: Integer): String;
var
  liBreakIndex: Integer;
  lGroupOptions: TppGroupOptions;
  lsDesc: String;
begin

  lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[aIndex]);

  if lGroupOptions.BreakType = btDataField then
    begin
      if (lGroupOptions.DataPipeline <> nil) then
        lsDesc := lGroupOptions.DataPipeline.UserName + '.' + lGroupOptions.BreakName
      else
        lsDesc := '';

      liBreakIndex := FDataFieldDescriptions.IndexOf(lsDesc);

      if (liBreakIndex = -1) then
        liBreakIndex := FDataFieldNames.IndexOf(lGroupOptions.BreakName);

      if (liBreakIndex >= 0) then
        Result := FDataFieldDescriptions[liBreakIndex]
      else
        Result := lGroupOptions.BreakName;
    end
  else
    begin
      liBreakIndex := FCustomFieldNames.IndexOf(lGroupOptions.BreakName);

      if liBreakIndex >= 0 then
        Result := FCustomFieldDescriptions[liBreakIndex]
      else
        Result := lGroupOptions.BreakName;
    end;

end; {function, GetBreakDescription}

{------------------------------------------------------------------------------}
{ TppGroupDialog.rdbBreakOnClick }

procedure TppGroupDialog.rdbBreakOnClick(Sender: TObject);
var
  liIndex: Integer;
  lGroupOptions: TppGroupOptions;
begin

  {set the group descriptions based on the type selected}
  if rdbDataField.Checked then
    cbxBreakDescriptions.Items.Assign(FDataFieldDescriptions)
  else
    cbxBreakDescriptions.Items.Assign(FCustomFieldDescriptions);

  {default the item index}
  if cbxBreakDescriptions.Items.Count > 0 then
    cbxBreakDescriptions.ItemIndex := 0
  else
    cbxBreakDescriptions.ItemIndex := -1;


  {update the group's breaktype property if necessary}
  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      if rdbDataField.Checked and (lGroupOptions.BreakType <> btDataField) and
         (FDataFieldDescriptions.Count > 0) then
        begin
          lGroupOptions.BreakType := btDataField;
          SetBreakDescription(FDataFieldDescriptions[0]);
        end

      else if rdbCustomField.Checked and (lGroupOptions.BreakType <> btCustomField) then
        begin
          lGroupOptions.BreakType := btCustomField;

          if (FCustomFieldDescriptions.Count > 0) then
            SetBreakDescription(FCustomFieldDescriptions[0]);
        end;

    end; {if, valid index}

  {restore focus to the list box}
  lstGroups.ItemIndex := liIndex;

end; {procedure, rdbBreakOnClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxNewColumnClick }

procedure TppGroupDialog.cbxNewColumnClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  if cbxNewColumn.Checked then
    begin
      cbxKeepTogether.Enabled           := False;
      cbxKeepTogether.Checked           := False;

      lblNewColumnThreshold.Enabled     := False;
      edtNewColumnThreshold.Enabled     := False;
      edtNewColumnThreshold.Text        := FloatToStrF( 0.0, ffGeneral,  7, 0);
      edtNewColumnThreshold.Color       := clBtnFace;
      edtNewColumnThreshold.BorderStyle := bsNone;
    end
  else
    begin

      if not(cbxNewPage.Checked) then
        begin
          cbxKeepTogether.Enabled           := True;
          cbxKeepTogether.Checked           := True;
        end;

      lblNewColumnThreshold.Enabled     := True;
      edtNewColumnThreshold.Enabled     := True;
      edtNewColumnThreshold.Color       := clWhite;
      edtNewColumnThreshold.BorderStyle := bsSingle;
   end;

  liIndex := lstGroups.ItemIndex;

  if liIndex >= 0 then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.NewColumn := cbxNewColumn.Checked;

      if lGroupOptions.NewColumn then
        lGroupOptions.NewColumnThreshold := 0;

    end;

end;  {procedure, cbxNewColumnClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.edtNewColumnThresholdChange }

procedure TppGroupDialog.edtNewColumnThresholdChange(Sender: TObject);
var
  liIndex: Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

 if (liIndex >= 0) then
   begin
     lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

     try
       if (edtNewPageThreshold.Text = '') then
         lGroupOptions.NewColumnThreshold := 0
       else
         lGroupOptions.NewColumnThreshold := StrToFloat(edtNewColumnThreshold.Text);

     except on EConvertError do
       begin
         MessageDlg(ppLoadStr(332), mtWarning, [mbOK], 0);
         edtNewColumnThreshold.Text := FloatToStrF(lGroupOptions.NewColumnThreshold, ffGeneral,  7, 0);
         edtNewColumnThreshold.SelectAll;
       end;

     end; {try, except}

   end; {if, valid index}

end; {procedure, edtNewColumnThresholdChange}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxNewPageClick }

procedure TppGroupDialog.cbxNewPageClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  lGroupOptions := nil;
  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) then
    lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

  if cbxNewPage.Checked then
    begin
      cbxResetPageNo.Enabled := True;

      cbxKeepTogether.Enabled := False;
      cbxKeepTogether.Checked := False;

      lblNewPageThreshold.Enabled := False;
      edtNewPageThreshold.Text := FloatToStrF(0.0, ffGeneral,  7, 0);
      edtNewPageThreshold.Enabled := False;
      edtNewPageThreshold.Color := clBtnFace;
      edtNewPageThreshold.BorderStyle := bsNone;
    end
  else
    begin
      cbxResetPageNo.Checked := False;
      cbxResetPageNo.Enabled := False;
      cbxNewFile.Checked := False;
      cbxEmailFile.Checked := False;
      cbxStartOnOddPage.Checked := False;

      if not(cbxNewColumn.Checked) then
        begin
          cbxKeepTogether.Enabled := True;

          if (lGroupOptions <> nil) then
            cbxKeepTogether.Checked := lGroupOptions.KeepTogether

          else
            cbxKeepTogether.Checked := True;
        end;

      lblNewPageThreshold.Enabled     := True;
      edtNewPageThreshold.Enabled     := True;
      edtNewPageThreshold.Color       := clWhite;
      edtNewPageThreshold.BorderStyle := bsSingle;
   end;

  if (lGroupOptions <> nil) then
    begin
      lGroupOptions.NewPage := cbxNewPage.Checked;

      if lGroupOptions.NewPage then
        lGroupOptions.NewPageThreshold := 0;
    end;

end;  {procedure, cbxNewPageClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.edtNewPageThresholdChange }

procedure TppGroupDialog.edtNewPageThresholdChange(Sender: TObject);
var
  liIndex: Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

 if (liIndex >= 0) then
   begin
     lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

     try

       if (edtNewPageThreshold.Text = '') then
         lGroupOptions.NewPageThreshold := 0
       else
         lGroupOptions.NewPageThreshold := StrToFloat(edtNewPageThreshold.Text);

     except on EConvertError do
       begin
         MessageDlg(ppLoadStr(332), mtWarning, [mbOK], 0);
         edtNewPageThreshold.Text := FloatToStrF(lGroupOptions.NewPageThreshold, ffGeneral,  7, 0);
         edtNewPageThreshold.SelectAll;
       end;

     end; {try, except}

   end; {if, valid index}

end; {procedure, edtNewPageThresholdChange}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxResetPageNoClick }

procedure TppGroupDialog.cbxResetPageNoClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.ResetPageNo := cbxResetPageNo.Checked;
    end;

end;  {procedure, cbxResetPageNoClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxNewFileClick }

procedure TppGroupDialog.cbxNewFileClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  if cbxNewFile.Checked then
    cbxNewPage.Checked := True;

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.NewFile := cbxNewFile.Checked;
    end;

end; {procedure, cbxNewFileClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxEmailFileClick }

procedure TppGroupDialog.cbxEmailFileClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  if cbxEmailFile.Checked then
    begin
      cbxNewPage.Checked := True;
      cbxNewFile.Checked := True;
    end;

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.EmailFile := cbxEmailFile.Checked;
    end;

end; {procedure, cbxEmailFileClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxStartOnOddPageClick }

procedure TppGroupDialog.cbxStartOnOddPageClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  if cbxStartOnOddPage.Checked then
    cbxNewPage.Checked := True;

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.StartOnOddPage := cbxStartOnOddPage.Checked;
    end;

end; {procedure, cbxStartOnOddPageClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxReprintOnColumnClick }

procedure TppGroupDialog.cbxReprintOnColumnClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.ReprintOnColumn := cbxReprintOnColumn.Checked;
    end;

end; {procedure, cbxReprintOnColumnClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxKeepTogetherClick }

procedure TppGroupDialog.cbxKeepTogetherClick(Sender: TObject);
var
  liIndex : Integer;
  liIndex2: Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.KeepTogether := cbxKeepTogether.Checked;

      {currently, if an inner group has keep together of true, then
       no outer group options can be keep together}
      if lGroupOptions.KeepTogether then

        for liIndex2 := 0 to liIndex - 1 do
          begin
            lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex2]);

            if lGroupOptions.KeepTogether then
              lGroupOptions.KeepTogether := False;
           end;

    end;

end; {procedure, cbxKeepTogetherClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.cbxReprintOnPageClick }

procedure TppGroupDialog.cbxReprintOnPageClick(Sender: TObject);
var
  liIndex : Integer;
  lGroupOptions: TppGroupOptions;
begin

  liIndex := lstGroups.ItemIndex;

  if (liIndex >= 0) and (liIndex < lstGroups.Items.Count) then
    begin
      lGroupOptions := TppGroupOptions(lstGroups.Items.Objects[liIndex]);

      lGroupOptions.ReprintOnPage := cbxReprintOnPage.Checked;
    end;

end; {procedure, cbxReprintOnPageClick}

{------------------------------------------------------------------------------}
{ TppGroupDialog.LanguageChanged }

procedure TppGroupDialog.LanguageChanged;
var
  liNewLeft: Integer;
  liSpacer: Integer;
begin

  Caption := ppLoadStr(204);

  gbxBreakOn.Caption := ppLoadStr(201);
  rdbDataField.Caption := ppLoadStr(203);
  rdbCustomField.Caption := ppLoadStr(202);
  lblNewColumnThreshold.Caption := ppLoadStr(421);
  lblNewPageThreshold.Caption := ppLoadStr(205);
  cbxResetPageNo.Caption := ppLoadStr(209);
  cbxKeepTogether.Caption := ppLoadStr(506);
  cbxNewColumn.Caption := ppLoadStr(420);
  cbxNewPage.Caption := ppLoadStr(210);
  gbxOnGroupBreak.Caption := ppLoadStr(206);
  cbxReprintOnPage.Caption := ppLoadStr(208);
  cbxReprintOnColumn.Caption := ppLoadStr(422);
  cbxNewFile.Caption := ppLoadStr(1163);
  cbxEmailFile.Caption := 'Email new file'; //TODO Localize
  cbxStartOnOddPage.Caption := ppLoadStr(1164);

  {compute widths so that controls don't occupy space for blank characters}
  cbxNewPage.Width := Canvas.TextWidth(cbxNewPage.Caption) + 25;

  cbxNewColumn.Width := Canvas.TextWidth(cbxNewColumn.Caption) + 20;

  cbxResetPageNo.Width := Canvas.TextWidth(cbxResetPageNo.Caption) + 25;

  cbxKeepTogether.Width := Canvas.TextWidth(cbxKeepTogether.Caption) + 25;

  cbxReprintOnPage.Width := Canvas.TextWidth(cbxReprintOnPage.Caption) + 25;

  cbxReprintOnColumn.Width := Canvas.TextWidth(cbxReprintOnColumn.Caption) + 25;

  {set the minimum size on the form based upon the largest possible string in it}
  if (Canvas.TextWidth(cbxReprintOnColumn.Caption) > Canvas.TextWidth(cbxReprintOnPage.Caption)) then
    Constraints.MinWidth := Canvas.TextWidth(cbxReprintOnColumn.Caption) + 80
  else
    Constraints.MinWidth := Canvas.TextWidth(cbxReprintOnPage.Caption) + 80;

  btnAdd.Caption := ppLoadStr(260);
  btnDelete.Caption := ppLoadStr(124);
  btnInsert.Caption := ppLoadStr(265);

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  {adjust positions for width of captions}
  liSpacer := Round(Screen.PixelsPerInch * 0.1333);

  rdbDataField.Width := Self.Canvas.TextWidth(rdbDataField.Caption) + 27;
  rdbCustomField.Width := Self.Canvas.TextWidth(rdbCustomField.Caption) + 27;

  if (rdbDataField.Width <> 71) then
    rdbCustomField.Left := rdbCustomField.Left + (rdbDataField.Width - 71);

  liNewLeft := lblNewPageThreshold.Left + lblNewPageThreshold.Width + liSpacer;

  if (lblNewColumnThreshold.Left + lblNewColumnThreshold.Width + liSpacer) > liNewLeft then
    liNewLeft := lblNewColumnThreshold.Left + lblNewColumnThreshold.Width + liSpacer;

  edtNewPageThreshold.Left := liNewLeft;
  edtNewColumnThreshold.Left := liNewLeft;

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomGroupDialog, TppGroupDialog);

finalization

  ppUnRegisterForm(TppCustomGroupDialog);

end.
