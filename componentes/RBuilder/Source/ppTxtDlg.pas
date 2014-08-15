{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppTxtDlg;

interface

{$I ppIfDef.pas}


uses
  Windows,
  ComCtrls,
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
  Tabnotbk;

type
  TppSaveSetting = class;

  {@TppPrintToFileSetupDialog }

  TppPrintToFileSetupDialog = class(TppCustomPrintToFileSetupDialog)
    SaveDialog1: TSaveDialog;
    btnOK: TButton;
    btnCancel: TButton;
    pnlPrintToFile: TPanel;
    lblFileName: TLabel;
    edtTextFileName: TEdit;
    btnFile: TButton;
    cbxTextFileType: TComboBox;
    lblFileType: TLabel;
    lblBands: TLabel;
    lbxBands: TListBox;
    lblAvailableControls: TLabel;
    lbxItemsAvailable: TListBox;
    spbSelectItem: TSpeedButton;
    spbSelectAllItems: TSpeedButton;
    spbDeselectItem: TSpeedButton;
    spbDeselectAllItems: TSpeedButton;
    lbxItemsSelected: TListBox;
    lblSelectedControls: TLabel;
    spbMoveFieldUp: TSpeedButton;
    lblOrder: TLabel;
    spbMoveFieldDown: TSpeedButton;
    edtSaveLength: TEdit;
    lblSaveLength: TLabel;
    Bevel1: TBevel;
    lblFixedLength: TLabel;
    lblTabDelimited: TLabel;
    lblCommaDelimited: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbxItemsSelectedMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbxItemsSelectedDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbxItemsSelectedEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure spbDragUpClick(Sender: TObject);
    procedure spbDragDownClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure cbxTextFileTypeChange(Sender: TObject);
    procedure lbxBandsClick(Sender: TObject);
    procedure spbSelectItemClick(Sender: TObject);
    procedure spbSelectAllItemsClick(Sender: TObject);
    procedure spbDeselectItemClick(Sender: TObject);
    procedure spbDeselectAllItemsClick(Sender: TObject);
    procedure edtSaveLengthChange(Sender: TObject);
    procedure lbxItemsSelectedClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbxItemsAvailableDblClick(Sender: TObject);
    procedure lbxItemsSelectedDblClick(Sender: TObject);

  private
    FCreating: Boolean;
    FCurrentBand: Integer;
    FModified: Boolean;
    FPrintToFile: Boolean;
    FSavedCount: Integer;
    FTextFileName: String;
    FTextFileType: TppFileType;

    FBandList: TStringList;
    FComponentList: TStringList;

    procedure AdjustFormHeight;
    procedure ControlsToCurrentReport;
    procedure FreeSettings;
    procedure CurrentReportToControls;
    procedure SaveSettings;
    procedure SelectBand(aIndex: Integer);
    procedure SetTextFileName(Value: String);
    procedure SetTextFileType(Value: TppFileType);


  protected
    procedure AddItemToSelection;
    procedure AddAllItemsToSelection;
    procedure RemoveItemFromSelection;
    procedure RemoveAllItemsFromSelection;
    procedure MoveItems(Source: TListBox; StartItem: Integer; EndItem: Integer; Target: TListBox);
    procedure SetItemSelectButtons;

    procedure CurrentReportAssigned; override;
    procedure LanguageChanged; override;
    procedure ReportAssigned; override;

  end; {class, TppPrintToFileSetupDialog}


  {@TppSaveSetting }

  TppSaveSetting = class(TComponent)
  private
    FBand: TComponent;
    FComponent: TComponent;
    FComponentUserName: String;
    FSave: Boolean;
    FSaveLength: Integer;
    FSaveOrder: Integer;

  public
    constructor Create(aOwner: TComponent); override;

    property Band: TComponent read FBand write FBand;
    property Component: TComponent read FComponent write FComponent;
    property ComponentUserName: String read FComponentUserName write FComponentUserName;
    property Save: Boolean read FSave write FSave;
    property SaveOrder: Integer read FSaveOrder write FSaveOrder;
    property SaveLength: Integer read FSaveLength write FSaveLength;

  end; {class, TppSaveSetting}

var
  ppPrintToFileSetupDialog: TppPrintToFileSetupDialog;

implementation

uses
  ppClass, ppReport, ppCtrls, ppMemo, ppRTTI;

{$R *.DFM}

{******************************************************************************
 *
 ** EVENT HANDLERS
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.FormCreate }

procedure TppPrintToFileSetupDialog.FormCreate(Sender: TObject);
begin
  FCurrentBand := -1;
  FPrintToFile := True;
  FModified    := False;

  cbxTextFileType.ItemIndex := 0;

  FBandList := TStringList.Create;
  FComponentList := nil;

  FCreating := True;

end;


{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.FormDestroy }

procedure TppPrintToFileSetupDialog.FormDestroy(Sender: TObject);
begin

  FreeSettings;
  FBandList.Free;

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.FormClose }

procedure TppPrintToFileSetupDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.ReportAssigned }

procedure TppPrintToFileSetupDialog.ReportAssigned;
var
  lReport: TppReport;

begin

  if not (Report is TppReport) then Exit;

  lReport := TppReport(Report);

  {set report level properties}
  SetTextFileName(lReport.TextFileName);
  SetTextFileType(lReport.TextFileType);

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.CurrentReportAssigned }

procedure TppPrintToFileSetupDialog.CurrentReportAssigned;
begin

  if (CurrentReport = nil) or not (CurrentReport is TppCustomReport) then Exit;

  CurrentReportToControls;

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.SetTextFileName }

procedure TppPrintToFileSetupDialog.SetTextFileName(Value: String);
var
  liPos: Integer;

begin

  {assign a default extension of .txt if no extension specified }
  if Value <> '' then
    begin
      liPos := Pos('.',Value);

      if liPos = 0 then
        Value := Value + '.txt'
      else if liPos = Length(Value) then
        Value := Value + 'txt';
    end;

  FTextFileName := Value;

  edtTextFileName.Text := Value;

  if (FTextFileName <> '') then
    begin
      SaveDialog1.FileName := FTextFileName;
      SaveDialog1.InitialDir := ppStripOffPath(FTextFileName);
    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.SetTextFileType }

procedure TppPrintToFileSetupDialog.SetTextFileType(Value: TppFileType);
begin
  FTextFileType := Value;

  cbxTextFileType.ItemIndex := Ord(Value);

  AdjustFormHeight;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbOKClick }

procedure TppPrintToFileSetupDialog.btnOKClick(Sender: TObject);
var
  lReport: TppReport;

begin

  {note: execute this first because it set FSavedCount which is used below }
  ControlsToCurrentReport;

  {set report level properties}
  lReport := TppReport(Report);

  if not(lReport.AllowPrintToFile) and (FSavedCount > 0) then
    lReport.AllowPrintToFile := True;

  lReport.TextFileName     := FTextFileName;

  if (cbxTextFileType.ItemIndex > -1) then
    lReport.TextFileType := TppFileType(cbxTextFileType.ItemIndex);

 
end;  {procedure, spbOKClick }

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxBandsClick }

procedure TppPrintToFileSetupDialog.lbxBandsClick(Sender: TObject);
begin
  SelectBand(lbxBands.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbSelectItemClick }

procedure TppPrintToFileSetupDialog.spbSelectItemClick(Sender: TObject);
begin
  AddItemToSelection;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbSelectAllItemsClick }

procedure TppPrintToFileSetupDialog.spbSelectAllItemsClick(Sender: TObject);
begin
  AddAllItemsToSelection;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbDeselectItemClick }

procedure TppPrintToFileSetupDialog.spbDeselectItemClick(Sender: TObject);
begin
  RemoveItemFromSelection;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbDeselectAllItemsClick }

procedure TppPrintToFileSetupDialog.spbDeselectAllItemsClick(Sender: TObject);
begin
  RemoveAllItemsFromSelection;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxItemsAvailableDblClick }

procedure TppPrintToFileSetupDialog.lbxItemsAvailableDblClick(Sender: TObject);
begin
  AddItemToSelection;

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxItemsSelectedDblClick }

procedure TppPrintToFileSetupDialog.lbxItemsSelectedDblClick(Sender: TObject);
begin
  RemoveItemFromSelection;

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.btnFileClick }

procedure TppPrintToFileSetupDialog.btnFileClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    SetTextFileName(SaveDialog1.FileName);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.cbxTextFileTypeChange }

procedure TppPrintToFileSetupDialog.cbxTextFileTypeChange(Sender: TObject);
begin
  SetTextFileType(TppFileType(cbxTextFileType.ItemIndex));
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.edtSaveLengthChange }

procedure TppPrintToFileSetupDialog.edtSaveLengthChange(Sender: TObject);
var
  lSetting: TppSaveSetting;
begin
  if (lbxItemsSelected.ItemIndex >= 0) and (lbxItemsSelected.ItemIndex < lbxItemsSelected.Items.Count) then
    begin
      lSetting := TppSaveSetting(lbxItemsSelected.Items.Objects[lbxItemsSelected.ItemIndex]);
      lSetting.SaveLength := StrToIntDef(edtSaveLength.Text, 0);
    end;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxItemsSelectedClick }

procedure TppPrintToFileSetupDialog.lbxItemsSelectedClick(Sender: TObject);
var
  lSetting: TppSaveSetting;
begin

  if (FTextFileType = ftFixedLength) and (lbxItemsSelected.Items.Count > 0) then
    begin
      lSetting := TppSaveSetting(lbxItemsSelected.Items.Objects[lbxItemsSelected.ItemIndex]);
      edtSaveLength.Text := IntToStr(lSetting.SaveLength);

      {only set focus if form is visible}
      if Visible and Enabled then
        edtSaveLength.SetFocus;
    end;

end;

{******************************************************************************
 *
 ** M A I N   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.SelectBand }

procedure TppPrintToFileSetupDialog.SelectBand(aIndex: Integer);
var
  lSetting: TppSaveSetting;
  liComponent: Integer;
  liComponents: Integer;
  liIndex: Integer;
begin

  if (FCurrentBand <> -1) then
    SaveSettings;

  FCurrentBand := aIndex;

  lbxItemsAvailable.Items.Clear;
  lbxItemsSelected.Items.Clear;


  {get component list for this band}
  liIndex := FBandList.IndexOf(lbxBands.Items[aIndex]);
  FComponentList := TStringList(FBandList.Objects[liIndex]);


  {update list boxes for components}
  liComponents := FComponentList.Count;

  for liComponent := 0 to liComponents - 1 do
    begin

      lSetting := TppSaveSetting(FComponentList.Objects[liComponent]);

      {add setting to appropriate listbox}
      if (lSetting.Save) then
        lbxItemsSelected.Items.AddObject(lSetting.ComponentUserName, lSetting)

      else
        lbxItemsAvailable.Items.AddObject(lSetting.ComponentUserName, lSetting);

    end;

  lbxItemsAvailable.ItemIndex := 0;
  lbxItemsSelected.ItemIndex := 0;

  SetItemSelectButtons;

  if (FTextFileType = ftFixedLength) and (lbxItemsSelected.Items.Count > 0) then
    lbxItemsSelectedClick(Self);


end; {procedure, SelectBand}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.ControlsToCurrentReport }

procedure TppPrintToFileSetupDialog.ControlsToCurrentReport;
var
  lSetting: TppSaveSetting;
  lComponent: TComponent;
  liBand: Integer;
  liBands: Integer;
  liComponent: Integer;
  liComponents: Integer;
  liBandSavedCount: Integer;
  liIndex: Integer;
  lbSave: Boolean;
  liSaveOrder: Integer;
  liSaveLength: Integer;

begin

  {save settings for the currently selected band}
  SaveSettings;

  liBands := FBandList.Count;
  FSavedCount := 0;
  lSetting := nil;

  for liBand := 0 to liBands - 1 do
    begin
      {get the component list}
      liIndex := FBandList.IndexOf(lbxBands.Items[liBand]);
      FComponentList := TStringList(FBandList.Objects[liIndex]);

      {update save settings of components}
      liComponents := FComponentList.Count;

      liBandSavedCount := 0;

      for liComponent := 0 to liComponents - 1 do
        begin
          {get the save setting}
          lSetting := TppSaveSetting(FComponentList.Objects[liComponent]);

          {get the component}
          lComponent := lSetting.Component;

          lbSave := lSetting.Save;
          liSaveOrder := lSetting.SaveOrder;
          liSaveLength := lSetting.SaveLength;

          {assign the settings}
          if lbSave then
            begin
              TraRTTI.SetPropValue(lComponent, 'Save', lbSave);
              TraRTTI.SetPropValue(lComponent, 'SaveOrder', liSaveOrder);
              TraRTTI.SetPropValue(lComponent, 'SaveLength', liSaveLength);

              Inc(FSavedCount);
              Inc(liBandSavedCount);
            end
          else
            TraRTTI.SetPropValue(lComponent, 'Save', lbSave);

        end; {for, each component}

      {set the band save property}
      if (liComponents > 0) then
        TppBand(lSetting.Band).Save := (liBandSavedCount > 0);

    end; {for, each band}


end; {procedure, ControlsToReport}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.CurrentReportToControls }

procedure TppPrintToFileSetupDialog.CurrentReportToControls;
var
  lBand: TppBand;
  lReport: TppCustomReport;
  lComponent: TComponent;
  liComponent: Integer;
  liComponents: Integer;
  lsPosition: String;
  lSetting: TppSaveSetting;
  liBand: Integer;
  liBands: Integer;
  lsUserName: String;
  lbSave: Boolean;
  liSaveOrder: Integer;
  liSaveLength: Integer;
  lCTClass: TClass;
begin

  lReport := TppCustomReport(CurrentReport);

  liBands := lReport.BandCount;

  //Get a TppCrossTab class type reference
  lCTClass := GetClass('TppCrossTab');

  for liBand := 0 to liBands - 1 do
    begin

      lBand := lReport.Bands[liBand];

      {update list box}
      lbxBands.Items.AddObject(lBand.GetDescription, lBand);

      {create component list for this band}
      FComponentList := TStringList.Create;

      {update master list}
      FBandList.AddObject(lBand.GetDescription, FComponentList);

      {add save components to component list}
      liComponents := lBand.ObjectCount;

      for liComponent := 0 to liComponents - 1 do
        begin

        lComponent := lBand.Objects[liComponent];

          if (lComponent is TppCustomText) or (lComponent is TppCustomMemo)
             {$IFDEF Pro}or ((lCTClass <> nil) and (lComponent is lCTClass)){$ENDIF} then
            begin
              TraRTTI.GetPropValue(lComponent, 'UserName', lsUserName);
              TraRTTI.GetPropValue(lComponent, 'Save', lbSave);
              TraRTTI.GetPropValue(lComponent, 'SaveOrder', liSaveOrder);
              TraRTTI.GetPropValue(lComponent, 'SaveLength', liSaveLength);

              lSetting := TppSaveSetting.Create(Self);

              lSetting.Band              := lBand;
              lSetting.Component         := lComponent;
              lSetting.ComponentUserName := lsUserName;
              lSetting.Save              := lbSave;
              lSetting.SaveOrder         := liSaveOrder;
              lSetting.SaveLength        := liSaveLength;

              {convert SaveOrder to fixed length string}
              if lbSave then
                lsPosition  := Format('%8d',[liSaveOrder])
              else
                lsPosition := '99999999';

              FComponentList.AddObject(lsPosition, lSetting);
            end;

        end;

       FComponentList.Sort;

    end; {for, each band}

  lbxBands.ItemIndex := 0;

  SelectBand(lbxBands.ItemIndex);

end; {procedure, ReportToControls}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.SaveSettings }

procedure TppPrintToFileSetupDialog.SaveSettings;
var
  liComponents: Integer;
  liComponent: Integer;
  liIndex: Integer;
  lSetting: TppSaveSetting;
begin
  if (FCurrentBand = -1) then Exit;

  {get the component list}
  liIndex := FBandList.IndexOf(lbxBands.Items[FCurrentBand]);
  FComponentList := TStringList(FBandList.Objects[liIndex]);

  {update settings with new save status}
  liComponents := FComponentList.Count;

  for liComponent := 0 to liComponents - 1 do
    begin
      lSetting := TppSaveSetting(FComponentList.Objects[liComponent]);

      liIndex := lbxItemsSelected.Items.IndexOf(lSetting.ComponentUserName);

      lSetting.Save      := (liIndex <> -1);
      lSetting.SaveOrder := liIndex;

      {place order in component list string}
      if (liIndex >= 0) then
        FComponentList[liComponent] := Format('%8d',[liIndex])
      else
        FComponentList[liComponent] := '99999999';

    end;

  {sort the list, critical for the SaveOrder property assignments to work}
  FComponentList.Sort;

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.FreeSettings }

procedure TppPrintToFileSetupDialog.FreeSettings;
var
  liBand: Integer;
  liBands: Integer;
  liComponent: Integer;
  liComponents: Integer;
begin
  liBands := FBandList.Count;

  for liBand := 0 to liBands - 1 do
    begin
      FComponentList := TStringList(FBandList.Objects[liBand]);

      liComponents := FComponentList.Count;

      for liComponent := 0 to liComponents - 1 do
        TppSaveSetting(FComponentList.Objects[liComponent]).Free;

      FComponentList.Free;
    end;

end;


{******************************************************************************
 *
 ** L I S T   B O X   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.AddItemToSelection }

procedure TppPrintToFileSetupDialog.AddItemToSelection;
begin
  MoveItems(lbxItemsAvailable, lbxItemsAvailable.ItemIndex,
             lbxItemsAvailable.ItemIndex, lbxItemsSelected);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.AddAllItemsToSelection }

procedure TppPrintToFileSetupDialog.AddAllItemsToSelection;
begin
  MoveItems(lbxItemsAvailable, 0, lbxItemsAvailable.Items.Count - 1, lbxItemsSelected);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.RemoveItemFromSelection }

procedure TppPrintToFileSetupDialog.RemoveItemFromSelection;
begin
  MoveItems(lbxItemsSelected, lbxItemsSelected.ItemIndex,
            lbxItemsSelected.ItemIndex, lbxItemsAvailable);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.RemoveAllItemsFromSelection }

procedure TppPrintToFileSetupDialog.RemoveAllItemsFromSelection;
begin
  MoveItems(lbxItemsSelected, 0, lbxItemsSelected.Items.Count - 1, lbxItemsAvailable);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.MoveItems }

procedure TppPrintToFileSetupDialog.MoveItems(Source: TListBox; StartItem: Integer;
                                          EndItem: Integer; Target: TListBox);
var
  liItem: Integer;
  liSourceIndex: Integer;
  liTargetIndex: Integer;
  lbLastItem: Boolean;
  lsItem: String;
  lSetting: TppSaveSetting;
begin

  lbLastItem := Source.ItemIndex = Source.Items.Count - 1;
  liSourceIndex := Source.ItemIndex;
  liTargetIndex := 0;

  for liItem := StartItem to EndItem do
    begin
      lsItem := Source.Items[StartItem];
      lSetting := TppSaveSetting(Source.Items.Objects[StartItem]);

      liTargetIndex := Target.Items.AddObject(lsItem, lSetting);
      
      Source.Items.Delete(StartItem);
    end;

  SetItemSelectButtons;

  Target.ItemIndex := liTargetIndex;

  if lbLastItem then
    Source.ItemIndex := Source.Items.Count - 1
  else
    Source.ItemIndex := liSourceIndex;

  Source.SetFocus;

  lbxItemsSelectedClick(Self);

end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.SetItemSelectButtons }

procedure TppPrintToFileSetupDialog.SetItemSelectButtons;
var
  lbItemsAvailable,
  lbItemsSelected: Boolean;
begin
  lbItemsAvailable := (lbxItemsAvailable.Items.Count > 0);
  lbItemsSelected := (lbxItemsSelected.Items.Count > 0);

  spbSelectItem.Enabled := lbItemsAvailable;
  spbSelectAllItems.Enabled := lbItemsAvailable;

  spbDeselectItem.Enabled := lbItemsSelected;
  spbDeselectAllItems.Enabled := lbItemsSelected;

  edtSaveLength.Enabled := lbItemsSelected;

  if not lbItemsSelected then
    edtSaveLength.Text := '';

end;

{******************************************************************************
 *
 ** L I S T   I T E M   D R A G   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxFieldsSelectedMouseDown - set dragging}

procedure TppPrintToFileSetupDialog.lbxItemsSelectedMouseDown(Sender: TObject; Button: TMouseButton;
                                                  Shift: TShiftState; X, Y: Integer);
var
  lPoint   : TPoint;
  liIndex  : Integer;
  lbExists : Boolean;

begin
  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;
  
  liIndex  := lbxItemsSelected.ItemAtPos(lPoint, lbExists);

  if (liIndex <> -1) then
    lbxItemsSelected.BeginDrag(False);
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxFieldsSelectedDragOver }

procedure TppPrintToFileSetupDialog.lbxItemsSelectedDragOver(Sender, Source: TObject; X, Y: Integer;
                                                   State: TDragState; var Accept: Boolean);
var
  lPoint     : TPoint;
  liIndex    : Integer;
  lbSelected : Boolean;
  lbExists   : Boolean;

begin
  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;
  
  liIndex := lbxItemsSelected.ItemAtPos(lPoint, lbExists);

  if (liIndex <> -1) then
    begin
      lbSelected := lbxItemsSelected.Selected[liIndex];
      if not(lbSelected) then
        Accept := True
      else
        Accept := False;
    end
  else
    Accept := False;

end; {procedure, lbxFieldsSelectedDragOver}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.lbxFieldsSelectedEndDrag }

procedure TppPrintToFileSetupDialog.lbxItemsSelectedEndDrag(Sender, Target: TObject; X, Y: Integer);
var
  lPoint : TPoint;
  lbExists : Boolean;
  liIndex : Integer;
  liItem : Integer;

  begin
  if (Target = lbxItemsSelected) then
    begin
      {move selection to new position}
      lPoint.X := X;
      lPoint.Y := Y;
      lbExists := True;

      liIndex := lbxItemsSelected.ItemAtPos(lPoint, lbExists);

      for liItem := 0 to lbxItemsSelected.Items.Count - 1  do
        if lbxItemsSelected.Selected[liItem] then
            lbxItemsSelected.Items.Move(liItem,liIndex);

      lbxItemsSelected.ItemIndex := liIndex;

    end;

end;  {procedure, lbxFieldsSelectedEndDrag}

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbDragUpClick }

procedure TppPrintToFileSetupDialog.spbDragUpClick(Sender: TObject);
var
  liCurIndex: Integer;
begin
  liCurIndex := lbxItemsSelected.ItemIndex;

  if liCurIndex > 0 then
    begin
      lbxItemsSelected.Items.Move(liCurIndex,liCurIndex - 1);
      lbxItemsSelected.ItemIndex := liCurIndex - 1;
    end;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.spbDragDownClick }

procedure TppPrintToFileSetupDialog.spbDragDownClick(Sender: TObject);
var
  liCurIndex: Integer;
  liCount: Integer;
begin
  liCurIndex := lbxItemsSelected.ItemIndex;
  liCount := lbxItemsSelected.Items.Count - 1;

  if liCurIndex < liCount then
    begin
      lbxItemsSelected.Items.Move(liCurIndex,liCurIndex + 1);
      lbxItemsSelected.ItemIndex := liCurIndex + 1;
    end;
end;

{------------------------------------------------------------------------------}
{ TppPrintToFileSetupDialog.LanguageChanged}

procedure TppPrintToFileSetupDialog.LanguageChanged;
var
  liSaveIndex: Longint;
begin

  Caption := ppLoadStr(256);

  lblAvailableControls.Caption :=  ppLoadStr(249);
  lblBands.Caption             :=  ppLoadStr(250);
  lblFileName.Caption          :=  ppLoadStr(252);
  btnFile.Caption              :=  ppLoadStr(131);
  lblFileType.Caption          :=  ppLoadStr(253);
  lblOrder.Caption             :=  ppLoadStr(255);
  lblSaveLength.Caption        :=  ppLoadStr(257);
  lblSelectedControls.Caption  :=  ppLoadStr(258);

  liSaveIndex := cbxTextFileType.ItemIndex;
  cbxTextFileType.Items[0] :=  ppLoadStr(251);
  cbxTextFileType.Items[1] :=  ppLoadStr(259);
  cbxTextFileType.Items[2] :=  ppLoadStr(254);
  cbxTextFileType.ItemIndex := liSaveIndex;

  btnOK.Caption     := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}


{******************************************************************************
 *
 ** S A V E    S E T T I N G   C L A S S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSaveSetting.Create }

constructor TppSaveSetting.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FBand := nil;
  FComponent := nil;
  FComponentUserName := '';
  FSave := False;
  FSaveLength := 0;
  FSaveOrder := -1;

end;

procedure TppPrintToFileSetupDialog.AdjustFormHeight;
begin
  if FCreating then Exit;

  if (FTextFileType = ftFixedLength) then
    begin
      edtSaveLength.Visible := True;
      lblSaveLength.Visible := True;

      pnlPrintToFile.Height := edtSaveLength.Top + edtSaveLength.Height + Round(Screen.PixelsPerInch * 0.08);
    end

  else
    begin
      edtSaveLength.Visible := False;
      lblSaveLength.Visible := False;

      pnlPrintToFile.Height := edtSaveLength.Top;
    end;

  btnOK.Top := pnlPrintToFile.Top + pnlPrintToFile.Height + Round(Screen.PixelsPerInch * 0.08);
  btnCancel.Top := btnOK.Top;
  Height        := btnOK.Top + btnOK.Height + Round(Screen.PixelsPerInch * 0.45);

end;

procedure TppPrintToFileSetupDialog.FormActivate(Sender: TObject);
begin
  if FCreating then
    begin
      FCreating := False;

      AdjustFormHeight;
    end;

end;



{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomPrintToFileSetupDialog, TppPrintToFileSetupDialog);

finalization

  ppUnRegisterForm(TppCustomPrintToFileSetupDialog);

end.

