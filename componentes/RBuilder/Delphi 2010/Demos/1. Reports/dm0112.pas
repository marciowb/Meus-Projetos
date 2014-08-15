{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0112;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, Db, DBTables, ppDB, dmUtil, ppReport, ppComm, ppCache,
  ppBands, ppPrnabl, ppCtrls, ppDBBDE, Grids, DBGrids, ppProd, ppDBPipe,
  ppRelatv;

type
  Tfrm0112 = class(TdmCustomForm)
    ppReport1: TppReport;
    ppReport1Shape2: TppShape;
    ppReport1Shape3: TppShape;
    ppReport1Shape4: TppShape;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppBDEPipeline1: TppBDEPipeline;
    Table1: TTable;
    DataSource1: TDataSource;
    ppReport1DBText1: TppDBText;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Label1: TLabel;
    ppDBImage1: TppDBImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
    procedure Init; override;
  public
    { Public declarations }
  end;

var
  frm0112: Tfrm0112;

implementation

{$R *.DFM}

procedure Tfrm0112.Init;
begin
  {initialize inherited properties}
  DisplayForm := True;
  AssignViewer := True;
end;

function Tfrm0112.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0112.Button1Click(Sender: TObject);
var
  liIndex: Integer;
begin

  ppBDEPipeline1.ClearBookmarkList;

  for liIndex := 0 to DBGrid1.SelectedRows.Count - 1 do
    ppBDEPipeline1.AddBookmark(Longint(DBGrid1.SelectedRows[liIndex]));

  Table1.DisableControls;

  ppReport1.Print;

  Table1.EnableControls;

end;


end.
