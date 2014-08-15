{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit mdichild;

interface

uses
  Windows, Messages, SysUtils, Classes, ExtCtrls, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables,
  ppBands, ppClass, ppCache, ppCtrls, ppComm, ppReport, ppPrnabl, ppDB,
  ppDBBDE, ppEndUsr, ppProd, ppDBPipe, ppVar, ppRelatv;

type
  TfrmInvisible = class(TForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    tblOrder: TTable;
    dsOrder: TDataSource;
    plOrder: TppBDEPipeline;
    Shape3: TShape;
    Label4: TLabel;
    Label5: TLabel;
    tblEmployee: TTable;
    dsEmployee: TDataSource;
    Label6: TLabel;
    plEmployee: TppBDEPipeline;
    Shape2: TShape;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Shape1: TppShape;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1DBText3: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1DBText5: TppDBText;
    ppReport1DBText6: TppDBText;
    ppReport1DBText7: TppDBText;
    ppReport1DBText8: TppDBText;
    ppReport1Line1: TppLine;
    ppReport1Line2: TppLine;
    ppReport1DBText10: TppDBText;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1Group1: TppGroup;
    ppReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppReport1Shape2: TppShape;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Shape3: TppShape;
    ppReport1Shape4: TppShape;
    ppReport1Label7: TppLabel;
    ppReport1Label8: TppLabel;
    ppReport1Label9: TppLabel;
    ppReport1Label10: TppLabel;
    ppReport1Shape5: TppShape;
    ppReport1Label11: TppLabel;
    ppReport1Label12: TppLabel;
    ppReport1Label13: TppLabel;
    ppReport1Label15: TppLabel;
    ppReport1GroupFooterBand1: TppGroupFooterBand;
    ppReport1Line4: TppLine;
    ppReport1Line3: TppLine;
    ppReport1DBText9: TppDBText;
    ppReport1Label14: TppLabel;
    ppReport1DBCalc1: TppDBCalc;
    ppDesigner1: TppDesigner;
    Label7: TLabel;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc2: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
    procedure ppDesigner1Show(Sender: TObject);
    
  private
    { Private declarations }
    
  protected

  public
    { Public declarations }

    property Designer: TppDesigner read ppDesigner1;
    property Report: TppReport read ppReport1;

  end;

var
  frmInvisible: TfrmInvisible;

implementation

{$R *.DFM}

procedure TfrmInvisible.ppDesigner1Show(Sender: TObject);
begin
  {make sure tabs are invisible }
  Designer.TabsVisible := False;

end;

end.
