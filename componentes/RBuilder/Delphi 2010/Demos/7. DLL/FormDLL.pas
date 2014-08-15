{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit FormDLL;

interface

{$I ppIfDef.pas}

uses
{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  {$IFDEF Pro}ppEndUsr, {$ENDIF}
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DBTables, DB, ppCtrls, ppClass, ppBands,
  ExtCtrls, Menus, ppStrtch, ppMemo, ppPrnabl, ppCache, ppComm, ppReport,
  ppDB, ppDBBDE, ppTypes, ppRichTx, ppProd, ppVar, ppDBPipe, ppRelatv;

type
  TfrmDLL = class(TForm)
    Shape4: TShape;
    Shape3: TShape;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape9: TShape;
    btnBioLifePrint: TButton;
    btnBioLifePrintPreview: TButton;
    dsBioLife: TDataSource;
    tblBioLife: TTable;
    memFormDLL: TMemo;
    ppBioLife: TppReport;
    ppBioLifeHeader: TppHeaderBand;
    ppBioLifeShape1: TppShape;
    ppBioLifeLabel1: TppLabel;
    ppBioLifeLabel2: TppLabel;
    ppBioLifeLabel3: TppLabel;
    ppBioLifeLabel4: TppLabel;
    ppBioLifeLabel5: TppLabel;
    ppBioLifeLabel6: TppLabel;
    ppBioLifeDetail: TppDetailBand;
    ppBioLifeShape4: TppShape;
    ppBioLifeShape5: TppShape;
    ppBioLifeShape6: TppShape;
    ppBioLifeShape3: TppShape;
    ppBioLifeShape2: TppShape;
    ppBioLifeDBText1: TppDBText;
    ppBioLifeDBImage1: TppDBImage;
    ppBioLifeDBText2: TppDBText;
    ppBioLifeDBText3: TppDBText;
    ppBioLifeFooter: TppFooterBand;
    ppBioLifeGroup1: TppGroup;
    ppBioLifeGroupHeader1: TppGroupHeaderBand;
    ppBioLifeGroupFooter1: TppGroupFooterBand;
    ppBioLifeShape7: TppShape;
    ppBioLifeLabel7: TppLabel;
    ppBioLifeDBCalc1: TppDBCalc;
    ppBioLifeLine1: TppLine;
    c: TImage;
    ppBDEPipeline1: TppBDEPipeline;
    ppBioLifeDBMemo1: TppDBMemo;
    ppBioLifeCalc1: TppSystemVariable;
    ppBioLifeCalc2: TppSystemVariable;
    btnDesign: TButton;
    procedure btnDesignClick(Sender: TObject);
    procedure btnBioLifePrintClick(Sender: TObject);
    procedure btnBioLifePrintPreviewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    { Public declarations }
  end;


  {Declare an export function - enables form to be used in a DLL }

  function ShowForm(aAppHandle: THandle): Bool; StdCall;



implementation

{$R *.DFM}


{------------------------------------------------------------------------}
{ShowForm - exported function for DLL example


  1. When calling a DLL from Delphi, pass the Application.Handle

  example:
     ShowForm(Application.Handle);

  2. When calling from a non VCL environment, pass 0 and a new application
  handle will be created

  example:
    Showform(0);

}

function ShowForm(aAppHandle: THandle): Bool;
var
  Form1: TfrmDLL;
begin

  // use specified app handle or create a new one, as needed}
  if (aAppHandle <> 0) then
    Application.Handle := aAppHandle
  else
    Application.CreateHandle;

  {create the form}
  Form1 := TfrmDLL.Create(nil);

  {must be modal for DLL calls (never modeless) }
  try
    Result := (Form1.ShowModal = mrOK);
  finally
    Form1.Free;
  end;
  
end;     


{------------------------------------------------------------------------}
{FormCreate }

procedure TfrmDLL.FormCreate(Sender: TObject);
begin
  {move memo field up}
  memFormDLL.Height := 81;
  memFormDLL.Left := 8;
  memFormDLL.Top := 32;
  Height := 150;

  tblBiolife.Active := False;

    {scale, if large fonts}
  if Screen.PixelsPerInch = 120 then
    begin
      Height := Trunc(Height * 1.25);
      Width  := Trunc(Width  * 1.25);
      memFormDLL.Left :=  Trunc(memFormDLL.Left  * 1.25);
      memFormDLL.Top  :=  Trunc(memFormDLL.Top   * 1.25);

    end;

{$IFNDEF Pro}
  btnDesign.Visible := False;
{$ENDIF}

end;


{------------------------------------------------------------------------}
{FormCloseQuery }

procedure TfrmDLL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  {check whether report currently printing }
  if ppBioLife.Printing then

    begin
      {display message to user }
      MessageDlg('Unable to close form - ReportBuilder is currently printing.' ,mtInformation, [mbOK] ,0);

      {do not allow form to close }
      CanClose := False;

    end; {if, currently printing}

end;

{------------------------------------------------------------------------}
{btnBioLifePrintClick }

procedure TfrmDLL.btnBioLifePrintClick(Sender: TObject);
begin
  ppBioLife.Device := dvPrinter;
  ppBioLife.PrintReport;
end;

{------------------------------------------------------------------------}
{btnBioLifePrintPreviewClick }

procedure TfrmDLL.btnBioLifePrintPreviewClick(Sender: TObject);
begin
  ppBioLife.Device := dvScreen;
  ppBioLife.PrintReport;
end;


procedure TfrmDLL.btnDesignClick(Sender: TObject);
{$IFDEF Pro}
var
  lDesigner: TppDesigner;
begin
  lDesigner := TppDesigner.Create(nil);
  lDesigner.Report := ppBioLife;
  lDesigner.ShowModal;
  lDesigner.Free;
{$ELSE}
begin
  ShowMessage('RB Standard Edition does not include the run-time designer');
end;
{$ENDIF}
end;


{------------------------------------------------------------------------}
{FormActivate - required for DLL example }

procedure TfrmDLL.FormActivate(Sender: TObject);
begin
  {initialize the BDE session }

  Session.Active     := True;

  tblBiolife.Active  := True;

end;

{------------------------------------------------------------------------}
{FormClose - required for DLL example }

procedure TfrmDLL.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   {shut down the BDE session }
   tblBiolife.Active  := False;

    Session.Active     := False;
    Session.DropConnections;

end;

end.
