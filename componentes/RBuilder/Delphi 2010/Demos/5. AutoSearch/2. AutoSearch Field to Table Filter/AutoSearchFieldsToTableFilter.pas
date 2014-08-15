{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit AutoSearchFieldsToTableFilter;

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
  ppCtrls, ppVar, ppPrnabl, ppBands, Grids, DBGrids;

type
  TForm1 = class(TForm)
    ppReport1: TppReport;
    ppDBPipeline1: TppDBPipeline;
    DataSource1: TDataSource;
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
    Table1: TTable;
    Table2: TTable;
    DataSource2: TDataSource;
    ppDBPipeline2: TppDBPipeline;
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
      lAutoSearchField := ppReport1.CreateAutoSearchField('', 'Company', 'Company Name', dtString, soLike, 'S', True);

      {set properties needed to generate Company as an SQLString}
      lAutoSearchField.WildCard := '*';
      lAutoSearchField.Delimiter := '''';


      {create SaleDate search field}
      lAutoSearchField := ppReport1.CreateAutoSearchField('', 'SaleDate', 'Sale Date', dtDate, soBetween, lsDateExpression, True);

      {set properties needed to generate SaleDate as an SQLString}

      {note: Set DisplayFormat to specify a valid format for a particular
             database product.
             For Paradox tables used here, we can use ShortDateFormat
             because Paradox honors international settings

             for Y2K need to augment the ShortDateFormat to use the century}
      lAutoSearchField.DisplayFormat := StringReplace(ShortDateFormat, 'yy', 'yyyyy', [rfIgnoreCase]);
      lAutoSearchField.Delimiter := '''';

      {create AmountPaid search field}
      lAutoSearchField := ppReport1.CreateAutoSearchField('', 'AmountPaid', 'Amount Paid', dtCurrency, soGreaterThan, '0', True);

      {add DisplayFormat: this format will work for international settings}
      lAutoSearchField.DisplayFormat := '0.##';

    end;

end;

procedure TForm1.ppReport1GetAutoSearchValues(Sender: TObject);
var
  lAutoSearchField: TppAutoSearchField;
begin

  Table1.Close;
  Table2.Close;

  {set parameter values}
  lAutoSearchField := ppReport1.AutoSearchFieldByName('Company');
  Table1.Filter := lAutoSearchField.FilterString;

  lAutoSearchField := ppReport1.AutoSearchFieldByName('SaleDate');
  Table2.Filter := lAutoSearchField.FilterString;

  lAutoSearchField := ppReport1.AutoSearchFieldByName('AmountPaid');
  Table2.Filter := Table2.Filter + ' AND ' + lAutoSearchField.FilterString;

  Table1.Filtered := True;
  Table2.Filtered := True;

end;

end.
