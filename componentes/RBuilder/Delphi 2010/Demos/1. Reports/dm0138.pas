{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0138;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppBands, ppClass, ppProd, ppReport, StdCtrls, ppDB, ppComm, ppCache,
  ppTxPipe, ppCtrls, ppPrnabl, ExtCtrls,
  dmUtil, ppVar, ppRelatv, ppStrtch, ppSubRpt;

type
  Tfrm0138 = class(TdmCustomForm)
    TxtPipeCustomer: TppTextPipeline;
    ppField26: TppField;
    ppField25: TppField;
    ppField24: TppField;
    ppField23: TppField;
    ppField22: TppField;
    ppField21: TppField;
    ppField20: TppField;
    ppField19: TppField;
    ppField18: TppField;
    ppField17: TppField;
    ppField2: TppField;
    ppField1: TppField;
    ppField13: TppField;
    TxtPipeOrder: TppTextPipeline;
    ppField47: TppField;
    ppField46: TppField;
    ppField45: TppField;
    ppField44: TppField;
    ppField43: TppField;
    ppField42: TppField;
    ppField41: TppField;
    ppField40: TppField;
    ppField39: TppField;
    ppField38: TppField;
    ppField37: TppField;
    ppField36: TppField;
    ppField35: TppField;
    Label4: TLabel;
    Label1: TLabel;
    ppReport1: TppReport;
    ppOrderListHeaderBand1: TppHeaderBand;
    ppOrderListLabel1: TppLabel;
    ppOrderListLabel2: TppLabel;
    ppOrderListShape1: TppShape;
    ppOrderListLabel3: TppLabel;
    ppOrderListLabel4: TppLabel;
    ppOrderListDBText1: TppDBText;
    ppOrderListDBText2: TppDBText;
    ppOrderListDetailBand1: TppDetailBand;
    ppOrderListFooterBand1: TppFooterBand;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape3: TShape;
    Label2: TLabel;
    ppOrderListCalc1: TppSystemVariable;
    ppOrderListCalc2: TppSystemVariable;
    ppOrderListCalc3: TppSystemVariable;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppOrderListDBText3: TppDBText;
    ppOrderListDBText4: TppDBText;
    ppOrderListDBText5: TppDBText;
    ppOrderListDBText6: TppDBText;
    ppOrderListDBText7: TppDBText;
    ppOrderListDBText8: TppDBText;
    ppOrderListLine2: TppLine;
    ppOrderListDBText10: TppDBText;
    ppOrderListLine1: TppLine;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppOrderListShape2: TppShape;
    ppOrderListLabel5: TppLabel;
    ppOrderListLabel6: TppLabel;
    ppOrderListShape3: TppShape;
    ppOrderListShape4: TppShape;
    ppOrderListLabel7: TppLabel;
    ppOrderListLabel8: TppLabel;
    ppOrderListLabel9: TppLabel;
    ppOrderListLabel10: TppLabel;
    ppOrderListShape5: TppShape;
    ppOrderListLabel11: TppLabel;
    ppOrderListLabel12: TppLabel;
    ppOrderListLabel13: TppLabel;
    ppOrderListLabel15: TppLabel;
    ppOrderListLine4: TppLine;
    ppOrderListLine3: TppLine;
    ppOrderListDBText9: TppDBText;
    ppOrderListLabel14: TppLabel;
    ppOrderListDBCalc1: TppDBCalc;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDecimalSeparator: Char;
    FThousandSeparator: Char;

  protected
    function GetReport: TppProducer; override;

  public

  end;

var
  frm0138: Tfrm0138;

implementation

{$R *.DFM}

function Tfrm0138.GetReport: TppProducer;
begin
  Result := ppReport1;
end;


procedure Tfrm0138.FormCreate(Sender: TObject);
begin
  {note:  The Orders ascii text file contains data with US formatted numeric data.
          Therefore need to override DecimalSeparator,  ThousandSeparator to enable
          this demo to run for international settings }
  FDecimalSeparator  := DecimalSeparator;
  FThousandSeparator := ThousandSeparator;
  DecimalSeparator   := '.';
  ThousandSeparator  := ',';

  TxtPipeCustomer.FileName := ExtractFilePath(ParamStr(0)) + 'customer.txt';
  TxtPipeOrder.FileName    := ExtractFilePath(ParamStr(0)) + 'order.txt';

end;

procedure Tfrm0138.FormDestroy(Sender: TObject);
begin
  {restore international settings}
  DecimalSeparator := FDecimalSeparator;
  ThousandSeparator := FThousandSeparator;
end;

end.
