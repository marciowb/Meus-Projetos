{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myASDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ppForms, ppASCtrl, ppDB, ppTypes, ppUtils, ppASDlg,
  Db, DBTables, ComCtrls, ppASField;

type

  { TmyAutoSearchDialog }
  TmyAutoSearchDialog = class(TppAutoSearchDialog)
    protected
      procedure GetPanelClassForField(aField: TppAutoSearchField; var aPanelClass: TppAutoSearchPanelClass); override;

  end; {class, TmyAutoSearchDialog}

  { TmySaleDateSearchPanel }
  TmySaleDateSearchPanel = class(TppBetweenSearchPanel)
    private
      FDateTimePicker1: TDateTimePicker;
      FDateTimePicker2: TDateTimePicker;

    protected
      procedure ShowAllValuesClickEvent(Sender: TObject); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Init; override;
      function  Valid: Boolean; override;

  end; {class, TmySaleDateSearchPanel}

implementation

{******************************************************************************
 *
 ** A U T O   S E A R C H    D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyAutoSearchDialog.GetPanelClassForField}

procedure TmyAutoSearchDialog.GetPanelClassForField(aField: TppAutoSearchField; var aPanelClass: TppAutoSearchPanelClass);
begin

  {we'll be handling the Sale Date with our own custom panel, so return this class}
  if (aField.FieldName = 'SaleDate') and (aField.SearchOperator = soBetween) then
    aPanelClass := TmySaleDateSearchPanel;

end; {function, GetPanelClassForField}

{******************************************************************************
 *
 ** S A L E    D A T E   S E A R C H    P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmySaleDateSearchPanel.Create}

constructor TmySaleDateSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDateTimePicker1 := nil;
  FDateTimePicker2 := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TmySaleDateSearchPanel.Destroy}

destructor TmySaleDateSearchPanel.Destroy;
begin

  FDateTimePicker1.Free;
  FDateTimePicker2.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TmySaleDateSearchPanel.Init}

procedure TmySaleDateSearchPanel.Init;
var
  lQuery: TQuery;
  lMaxDate: TDateTime;
  lMinDate: TDateTime;
begin

  inherited Init;

  {hide the edit boxes}
  EditControl.Visible := False;
  EditControl2.Visible := False;

  {get the min and max dates}
  lQuery := TQuery.Create(Self);
  lQuery.DatabaseName := 'DBDemos';
  lQuery.SQL.Add('SELECT MAX( Orders.SaleDate ) MaxSaleDate, MIN( Orders.SaleDate ) MinSaleDate');
  lQuery.SQL.Add('FROM "customer.DB" Customer');
  lQuery.SQL.Add('INNER JOIN "orders.db" Orders');
  lQuery.SQL.Add('ON  (Customer.CustNo = Orders.CustNo)');
  lQuery.SQL.Add('WHERE  Orders.SaleDate IS NOT NULL');
  lQuery.Open;

  lMaxDate := lQuery.FieldByName('MaxSaleDate').AsDateTime;
  lMinDate := lQuery.FieldByName('MinSaleDate').AsDateTime;

  lQuery.Free;

  {create date picker number one}
  FDateTimePicker1 := TDateTimePicker.Create(Self);
  FDateTimePicker1.Parent := Self;
  FDateTimePicker1.Date := lMinDate;
//  FDateTimePicker1.MaxDate := lMaxDate;
//  FDateTimePicker1.MinDate := lMinDate;
  FDateTimePicker1.Left := EditControl.Left;
  FDateTimePicker1.Top := EditControl.Top;
  FDateTimePicker1.Width := 150;

  AndLabel.Left := FDateTimePicker1.Left + FDateTimePicker1.Width + 5;

  {create date picker number two}
  FDateTimePicker2 := TDateTimePicker.Create(Self);
  FDateTimePicker2.Parent := Self;
  FDateTimePicker2.Date := lMaxDate;
//  FDateTimePicker2.MaxDate := lMaxDate;
//  FDateTimePicker2.MinDate := lMinDate;
  FDateTimePicker2.Left := AndLabel.Left + AndLabel.Width + 5;
  FDateTimePicker2.Top := EditControl.Top;
  FDateTimePicker2.Width := 150;

  {get values}
  if Field.ValueCount > 0 then
    FDateTimePicker1.Date := Field.Values[0];

  if Field.ValueCount > 1 then
    FDateTimePicker2.Date := Field.Values[1];

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TmySaleDateSearchPanel.ShowAllValuesClickEvent}

procedure TmySaleDateSearchPanel.ShowAllValuesClickEvent(Sender: TObject);
begin

  inherited ShowAllValuesClickEvent(Sender);

  FDateTimePicker1.Enabled := not(ShowAllValues.Checked);
  FDateTimePicker2.Enabled := not(ShowAllValues.Checked);

  if (FDateTimePicker1.Enabled) and (FDateTimePicker1.Visible) then
    FDateTimePicker1.SetFocus;

end; {procedure, ShowAllValuesClickEvent}

{------------------------------------------------------------------------------}
{ TmySaleDateSearchPanel.Valid}

function TmySaleDateSearchPanel.Valid: Boolean;
begin

  Result := True;

  Field.ShowAllValues := ShowAllValues.Checked;
  Field.SearchExpression := DateTimeToStr(FDateTimePicker1.Date) + ', ' + DateTimeToStr(FDateTimePicker2.Date);

end; {procedure, Valid}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomAutoSearchDialog, TmyAutoSearchDialog);

finalization

  ppUnRegisterForm(TppCustomAutoSearchDialog);

end.
