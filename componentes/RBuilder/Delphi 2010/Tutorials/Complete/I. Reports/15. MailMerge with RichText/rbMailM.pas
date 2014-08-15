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
  ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, StdCtrls;

type
  TfrmMailMerge = class(TForm)
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
  public
    { Public declarations }
  end;

var
  frmMailMerge: TfrmMailMerge;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmMailMerge.btnPreviewClick }

procedure TfrmMailMerge.btnPreviewClick(Sender: TObject);
begin
  rbMailMerge.Print;
end;

end.
