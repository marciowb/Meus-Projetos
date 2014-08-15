{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbMailL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppPrnabl, ppClass, ppCtrls, ppBands, ppCache, ppComm, ppRelatv, ppProd,
  ppReport, StdCtrls, rbClass;

type

  {Note: This form is setup to run as part of the main tutorial project.
         It descends from TrbReportForm which is defined in rbClass.pas.

         You will need to add rbClass.pas to any project that uses this form.
         The rbClass.pas unit is part of the main tutorial project. }


  TfrmMailingLabels = class(TrbReportForm)
    ppReport1: TppReport;
    ppDetailBand1: TppDetailBand;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppShape1: TppShape;
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
  frmMailingLabels: TfrmMailingLabels;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmMailingLabels.GetReport }

function TfrmMailingLabels.GetReport: TppReport;
begin
  Result := ppReport1;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TfrmMailingLabels.btnPreviewClick }

procedure TfrmMailingLabels.btnPreviewClick(Sender: TObject);
begin
  ppReport1.Print;
end;

end.
