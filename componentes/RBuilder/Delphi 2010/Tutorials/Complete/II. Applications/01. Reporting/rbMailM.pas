{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbMailM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppPrnabl, ppClass, ppStrtch, ppRichTx, ppCache, ppBands, ppDB, ppProd,
  ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, StdCtrls, rbClass;

type

  {Note: This form is setup to run as part of the main tutorial project.
         It descends from TrbReportForm which is defined in rbClass.pas.

         You will need to add rbClass.pas to any project that uses this form.
         The rbClass.pas unit is part of the main tutorial project. }


  TfrmMailMerge = class(TrbReportForm)
    tblClient: TTable;
    dsClient: TDataSource;
    plClient: TppDBPipeline;
    rbMailMerge: TppReport;
    ppDetailBand1: TppDetailBand;
    ppRichText1: TppRichText;
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
  frmMailMerge: TfrmMailMerge;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TfrmMailMerge.GetReport }

function TfrmMailMerge.GetReport: TppReport;
begin
  Result := rbMailMerge;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TfrmMailMerge.btnPreviewClick }

procedure TfrmMailMerge.btnPreviewClick(Sender: TObject);
begin
  rbMailMerge.Print;
end;

end.
