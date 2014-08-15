{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit dvDesign;

interface

uses
  Windows, ComCtrls,


  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Tabnotbk,
  ppDB, ppTypes,
  daDataView;

type
  TdvDesignDataDialog = class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    TabbedNotebook1: TTabbedNotebook;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbxSort1: TComboBox;
    cbxSort2: TComboBox;
    cbxSort3: TComboBox;
    spbSort3: TSpeedButton;
    spbSort2: TSpeedButton;
    spbSort1: TSpeedButton;
    spbSortAsc: TSpeedButton;
    spbSortDesc: TSpeedButton;
    pnlSearchPage: TPanel;
    lblSearch1: TLabel;
    lblSearch2: TLabel;
    lblSearch3: TLabel;
    edtSearch3: TEdit;
    edtSearch2: TEdit;
    edtSearch1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cbxSort1Change(Sender: TObject);
    procedure cbxSort2Change(Sender: TObject);
    procedure spbSort1Click(Sender: TObject);
    procedure spbSort2Click(Sender: TObject);
    procedure spbSort3Click(Sender: TObject);

  private
    FDataView:  TdaCustomDataView;
    FDataPipeline: TppDataPipeline;
    FSearchControls:  TList;
    FSearchLabels:  TList;
    FSortButtons:  TList;
    FSortControls:  TList;
    FEditMode: TppDataEditType;

    procedure ClearSorts(aSortNo: Integer);
    procedure ControlsToDataView;
    procedure DataViewToControls;
    procedure InitControls;
    procedure SetDataView(aDataView: TdaCustomDataView);
    procedure SortButtonClick(aSortButton: TSpeedButton);
    procedure SetEditMode(aEditMode: TppDataEditType);

  public
    property DataView: TdaCustomDataView read FDataView write SetDataView;
    property EditMode: TppDataEditType read FEditMode write SetEditMode;

  end;

var
  dvDesignDataDialog: TdvDesignDataDialog;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ FormCreate }

procedure TdvDesignDataDialog.FormCreate(Sender: TObject);
begin
  FDataView := nil;
  FSearchControls := TList.Create;
  FSearchLabels   := TList.Create;
  FSortButtons    := TList.Create;
  FSortControls   := TList.Create;

  InitControls;

end;

{------------------------------------------------------------------------------}
{ FormDestroy }

procedure TdvDesignDataDialog.FormDestroy(Sender: TObject);
begin
  FSearchControls.Free;
  FSearchLabels.Free;
  FSortButtons.Free;
  FSortControls.Free;
end;

{------------------------------------------------------------------------------}
{ OKClick }

procedure TdvDesignDataDialog.btnOKClick(Sender: TObject);
begin
  {save wizard info to dataview}
  ControlsToDataView;

end;

{------------------------------------------------------------------------------}
{ SetDataView }

procedure TdvDesignDataDialog.SetDataView(aDataView: TdaCustomDataView);
begin
  FDataView := aDataView;

  if FDataView = nil then Exit;

  SetEditMode(FDataView.EditMode);


  if FDataView.DataPipelineCount > 0 then
    FDataPipeline := aDataView.DataPipelines[0]
  else
    FDataPipeline := nil;

  {set controls based on data view}
  DataViewToControls;

end;

{------------------------------------------------------------------------------}
{ SetEditMode }

procedure TdvDesignDataDialog.SetEditMode(aEditMode: TppDataEditType);
begin

  if aEditMode = ppemSort then
    TabbedNotebook1.PageIndex := 1
  else
    TabbedNotebook1.PageIndex := 0;

end;

{------------------------------------------------------------------------------}
{ InitControls }

procedure TdvDesignDataDialog.InitControls;
begin
  edtSearch1.Text := '';
  edtSearch2.Text := '';
  edtSearch3.Text := '';

  cbxSort1.ItemIndex := 0;
  cbxSort2.ItemIndex := 0;
  cbxSort3.ItemIndex := 0;

  FSearchControls.Add(edtSearch1);
  FSearchControls.Add(edtSearch2);
  FSearchControls.Add(edtSearch3);

  FSearchLabels.Add(lblSearch1);
  FSearchLabels.Add(lblSearch2);
  FSearchLabels.Add(lblSearch3);

  FSortButtons.Add(spbSort1);
  FSortButtons.Add(spbSort2);
  FSortButtons.Add(spbSort3);

  FSortControls.Add(cbxSort1);
  FSortControls.Add(cbxSort2);
  FSortControls.Add(cbxSort3);

end;


{------------------------------------------------------------------------------}
{ DataViewToControls }

procedure TdvDesignDataDialog.DataViewToControls;
var
  liFields: Integer;
  liIndex: Integer;
  liSortIndex: Integer;
  lField: TppField;
  liSearchables: Integer;
  liSortOrder: Integer;
  liSortables: Integer;
begin

  liSearchables := 0;

  if (FDataPipeline = nil) then Exit;

  liFields := FDataPipeline.FieldCount;

  for liIndex := 0 to liFields - 1 do
    begin
      {get the field}
      lField := FDataPipeline.Fields[liIndex];

      {load the first three searchables}
      if lField.Searchable and (liSearchables < 3) then
        begin
          {set labels}
          TLabel(FSearchLabels[liSearchables]).Caption := lField.FieldAlias;

          {set control to saved value}
          TEdit(FSearchControls[liSearchables]).Text := lField.SearchExpression;

          Inc(liSearchables);
        end;

      {load all sortables into combo boxes}
      if lField.Sortable then
        begin
          TComboBox(FSortControls[0]).Items.Add(lField.FieldAlias);
          TComboBox(FSortControls[1]).Items.Add(lField.FieldAlias);
          TComboBox(FSortControls[2]).Items.Add(lField.FieldAlias);
        end;

    end; {for, each field map}

  TComboBox(FSortControls[0]).Items.Insert(0,'');
  TComboBox(FSortControls[1]).Items.Insert(0,'');
  TComboBox(FSortControls[2]).Items.Insert(0,'');

  liSortables := 0;

  {restore the sort settings}
  for liIndex := 0 to liFields - 1 do
    begin
      {get the field map}
      lField := FDataPipeline.Fields[liIndex];

      if lField.Sortable and lField.Sort then
        begin
          liSortOrder := lField.SortOrder;

          liSortIndex := TComboBox(FSortControls[liSortOrder]).Items.IndexOf(lField.FieldAlias);
          TComboBox(FSortControls[liSortOrder]).ItemIndex := liSortIndex;

          if (lField.SortType = soAscending) then
            begin
              TSpeedButton(FSortButtons[liSortOrder]).Glyph := spbSortAsc.Glyph;
              TSpeedButton(FSortButtons[liSortOrder]).Tag := Ord(soAscending);
            end
          else
            begin
              TSpeedButton(FSortButtons[liSortOrder]).Glyph := spbSortDesc.Glyph;
              TSpeedButton(FSortButtons[liSortOrder]).Tag := Ord(soDescending);
            end;

          Inc(liSortables);

        end;

    end; {for, each field map}

    {disable appropriate sort controls}
    if ((liSortables + 2) < 4) then
      ClearSorts(liSortables + 2);

end;

{------------------------------------------------------------------------------}
{ ControlsToDataView }

procedure TdvDesignDataDialog.ControlsToDataView;
var
  liIndex: Integer;
  lsSortItem: String;
  lSearchLabel: TLabel;
  lEdit: TEdit;
  lComboBox: TComboBox;
  lSortButton: TSpeedButton;
  lField: TppField; 

begin
  if FDataPipeline = nil then Exit;

  {re-initialize all pipeline fields: set search and sort to false}
  for liIndex := 0 to FDataPipeline.FieldCount - 1 do
    begin
      {get the field}
      lField := FDataPipeline.Fields[liIndex];
      lField.Search := False;
      lField.SearchExpression := '';
      lField.Sort := False;
      lField.SortExpression := '';
    end;



{  FDataView.ClearFieldValues;}

  for liIndex := 0 to 2 do
    begin
      {retrieve search and sort controls}
      lSearchLabel := TLabel(FSearchLabels[liIndex]);
      lEdit := TEdit(FSearchControls[liIndex]);
      lComboBox := TComboBox(FSortControls[liIndex]);
      lSortButton := TSpeedButton(FSortButtons[liIndex]);

      {assign search value to field map}
      if (lEdit.Text <> '') then
        begin
          lField := FDataPipeline.GetFieldForAlias(lSearchLabel.Caption);
          lField.SearchExpression := lEdit.Text;
          lField.Search := True;
        end;

      {assign sort value to field map}
      lsSortItem := lComboBox.Items[lComboBox.ItemIndex];
      if (lsSortItem <> '') then
        begin
          lField := FDataPipeline.GetFieldForAlias(lsSortItem);
          lField.SortType := TppSortOrderType(lSortButton.Tag);
          lField.Sort := True;
          lField.SortOrder := liIndex;
        end;

    end;

end;

{------------------------------------------------------------------------------}
{ Sort1Change }

procedure TdvDesignDataDialog.cbxSort1Change(Sender: TObject);
begin
  if (cbxSort1.ItemIndex = 0) then
    ClearSorts(2)
  else
    begin
      cbxSort2.Enabled := True;
      spbSort2.Enabled := True;
    end;

end;

{------------------------------------------------------------------------------}
{ Sort2Change }

procedure TdvDesignDataDialog.cbxSort2Change(Sender: TObject);
begin
  if (cbxSort2.ItemIndex = 0) then
    ClearSorts(3)
  else
    begin
      cbxSort3.Enabled := True;
      spbSort3.Enabled := True;
    end;

end;

{------------------------------------------------------------------------------}
{ ClearSorts }

procedure TdvDesignDataDialog.ClearSorts(aSortNo: Integer);
var
  liSort: Integer;
  liSorts: Integer;
begin
  liSorts := FSortControls.Count;

  for liSort := aSortNo - 1 to liSorts - 1 do
    begin
      TComboBox(FSortControls[liSort]).ItemIndex := 0;
      TComboBox(FSortControls[liSort]).Enabled := False;

      TSpeedButton(FSortButtons[liSort]).Glyph := spbSortAsc.Glyph;
      TSpeedButton(FSortButtons[liSort]).Enabled := False;
    end;
end;

{------------------------------------------------------------------------------}
{ spbSort1Click }

procedure TdvDesignDataDialog.spbSort1Click(Sender: TObject);
begin
  SortButtonClick(spbSort1);
end;

{------------------------------------------------------------------------------}
{ spbSort2Click }

procedure TdvDesignDataDialog.spbSort2Click(Sender: TObject);
begin
  SortButtonClick(spbSort2);
end;

{------------------------------------------------------------------------------}
{ spbSort3Click }

procedure TdvDesignDataDialog.spbSort3Click(Sender: TObject);
begin
  SortButtonClick(spbSort3);
end;

{------------------------------------------------------------------------------}
{ SortButtonClick }

procedure TdvDesignDataDialog.SortButtonClick(aSortButton: TSpeedButton);
begin
  if aSortButton.Tag = 1 then
    begin
      aSortButton.Glyph := spbSortAsc.Glyph;
      aSortButton.Tag := 0;
    end
  else
    begin
      aSortButton.Glyph := spbSortDesc.Glyph;
      aSortButton.Tag := 1;
    end;
end;





end.
