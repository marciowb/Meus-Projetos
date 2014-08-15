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
  ppReport, StdCtrls;

type
  TfrmMailingLabels = class(TForm)
    ppReport1: TppReport;
    ppDetailBand1: TppDetailBand;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppShape1: TppShape;
    btnPreview: TButton;
    procedure btnPreviewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMailingLabels: TfrmMailingLabels;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmMailingLabels.btnPreviewClick }

procedure TfrmMailingLabels.btnPreviewClick(Sender: TObject);
begin
  ppReport1.Print;
end;

end.
