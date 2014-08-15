{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit AutoSearchFieldsToSQLWhereClause;

{$I ppIfDef.pas}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables,

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  ppCache, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport, ppTypes,
  ppCtrls, ppVar, ppPrnabl, ppBands;

type
  TForm1 = class(TForm)
    ppReport1: TppReport;
    ppDBPipeline1: TppDBPipeline;
    DataSource1: TDataSource;
    Query1: TQuery;
    btnPreview: TButton;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppTitleBand1: TppTitleBand;
    ppGroup1: TppGroup;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel3: TppLabel;
    ppDBText4: TppDBText;
    ppLabel4: TppLabel;
    ppDBText5: TppDBText;
    ppLabel5: TppLabel;
    ppDBText6: TppDBText;
    ppLabel6: TppLabel;
    ppDBText7: TppDBText;
    ppLabel7: TppLabel;
    ppDBText8: TppDBText;
    ppLabel8: TppLabel;
    ppLine4: TppLine;
    ppShape1: TppShape;
    ppLabel9: TppLabel;
    procedure btnPreviewClick(Sender: TObject);
    procedure ppReport1AutoSearchDialogCreate(Sender: TObject);
    procedure ppReport1GetAutoSearchValues(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  ppASField;

procedure TForm1.btnPreviewClick(Sender: TObject);
begin
  ppReport1.Print;
end;

procedure TForm1.ppReport1AutoSearchDialogCreate(Sender: TObject);
var
  lAutoSearchField: TppAutoSearchField;
  ldBeginDate: TDateTime;
  ldEndDate: TDateTime;
  lsDateExpression: String;

begin

  {use EncodeDate to avoid international date formatting issues}
  ldBeginDate := EncodeDate(1990, 1, 1);
  ldEndDate   := EncodeDate(1995, 12, 31);

  lsDateExpression := DateToStr(ldBeginDate) + ',' + DateToStr(ldEndDate);

  if (ppReport1.AutoSearchFieldCount = 0) then
    begin
      {create Company search field}
      lAutoSearchField := ppReport1.CreateAutoSearchField('Customer', 'Company', 'Company Name', dtString, soLike, '', False);

      {set properties needed to generate Company as an SQLString}
      lAutoSearchField.WildCard := '%';
      lAutoSearchField.Delimiter := '''';


      {create ZipCode search field}
      lAutoSearchField := ppReport1.CreateAutoSearchField('Customer', 'Zip', 'Zip Code', dtString, soInList, '00820,99776', False);

      {set properties needed to generate ZipCode as an SQLString}
      lAutoSearchField.Delimiter := '''';


      {create SaleDate search field}
      lAutoSearchField := ppReport1.CreateAutoSearchField('Orders', 'SaleDate', 'Sale Date', dtDate, soBetween, lsDateExpression, False);

      {set properties needed to generate SaleDate as an SQLString}
      {note: Set DisplayFormat to specify a valid format for a particular
             database product.
             For Paradox tables used here, we can use the ShortDateFormat
             because Paradox honors international settings }
      lAutoSearchField.DisplayFormat := ShortDateFormat;
      lAutoSearchField.Delimiter := '''';

      

      {create AmountPaid search field}
      ppReport1.CreateAutoSearchField('Orders', 'AmountPaid', 'Amount Paid', dtCurrency, soGreaterThan, '0', False);
    end;

end;

procedure TForm1.ppReport1GetAutoSearchValues(Sender: TObject);
var
  liIndex: Integer;
  lAutoSearchField: TppAutoSearchField;
  lsLine: String;
  lbWhereInserted: Boolean;
  liCurrentLine: Integer;
begin

  {if user clicked 'Cancel' on dialog, exit}
  if not(ppReport1.AutoSearchDialog.ModalResult = mrOK) then Exit;

  {delete previous WHERE clause}
  if (Pos('WHERE', Query1.SQL[4]) <> 0) then
    begin
      Query1.SQL.Delete(4);

      while (Pos('ORDER BY', Query1.SQL[4]) = 0) do
        Query1.SQL.Delete(4);
    end;

  {add new WHERE clause based on autosearch field values}
  lbWhereInserted := False;
  liCurrentLine := 4;

  for liIndex := 0 to ppReport1.AutoSearchFieldCount - 1 do
    begin
      {get autosearch field}
      lAutoSearchField := ppReport1.AutoSearchFields[liIndex];

      {if valid entry, get search expression in SQL format}
      if not(lAutoSearchField.ShowAllValues) and (lAutoSearchField.Valid) then
        begin
          lsLine := lAutoSearchField.SQLString;

          {if auto search field already added, use AND operator}
          if lbWhereInserted then
            lsLine := 'AND ' + lsLine;

          if not(lbWhereInserted) then
            begin
              lsLine := 'WHERE ' + lsLine;

              lbWhereInserted := True;
            end;

          Query1.SQL.Insert(liCurrentLine, lsLine);

          Inc(liCurrentLine);
        end;

    end;
    
end;

end.
