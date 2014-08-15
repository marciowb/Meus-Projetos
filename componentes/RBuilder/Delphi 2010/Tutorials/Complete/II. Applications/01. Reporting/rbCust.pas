{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbCust;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppVar, ppCtrls, ppPrnabl, ppClass, ppBands, ppCache, ppDB, ppProd,
  ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, StdCtrls, rbClass;

type

  {Note: This form is setup to run as part of the main tutorial project.
         It descends from TrbReportForm which is defined in rbClass.pas.

         You will need to add rbClass.pas to any project that uses this form.
         The rbClass.pas unit is part of the main tutorial project. }


  TfrmCustomerList = class(TrbReportForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    rbCustomerList: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    btnPreview: TButton;
    procedure btnPreviewClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppReport; override;
  public
    { Public declarations }
  end;

var
  frmCustomerList: TfrmCustomerList;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmCustomerList.GetReport }

function TfrmCustomerList.GetReport: TppReport;
begin
  Result := rbCustomerList;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TfrmCustomerList.btnPreviewClick }

procedure TfrmCustomerList.btnPreviewClick(Sender: TObject);
begin
  rbCustomerList.Print;
end;

end.
