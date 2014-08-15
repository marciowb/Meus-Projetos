{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0151;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Buttons,
  dmUtil, ppComm, ppProd, ppArchiv, ppRelatv;

type
  Tfrm0151 = class(TdmCustomForm)
    ppArchiveReader1: TppArchiveReader;
    OpenDialog1: TOpenDialog;
    btnOpenArchive: TButton;
    Label1: TLabel;
    lblFileName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOpenArchiveClick(Sender: TObject);
  private
    FDirPath: String;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;
    
  public
    { Public declarations }
  end;

var
  frm0151: Tfrm0151;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0031.GetReport }

function Tfrm0151.GetReport: TppProducer;
begin
  Result := ppArchiveReader1;
end;

procedure Tfrm0151.Init;
begin

  {initialize inherited properties}
  AssignViewer := True;
  DisplayForm := True;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ Tfrm0151.FormCreate }

procedure Tfrm0151.FormCreate(Sender: TObject);
begin

  {get app directory }
  FDirPath := ExtractFilePath(ParamStr(0)) + 'Archives\';

  OpenDialog1.InitialDir := FDirPath;

end;  {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ Tfrm0151.FormClose }

procedure Tfrm0151.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ Tfrm0151.FormShow }

procedure Tfrm0151.FormShow(Sender: TObject);
begin
  btnOpenArchiveClick(Self);
end; {procedure, FormShow}

{------------------------------------------------------------------------------}
{ Tfrm0151.btnPrintArchiveClick }

procedure Tfrm0151.btnOpenArchiveClick(Sender: TObject);
var
  lsFileName: String;
begin
  if OpenDialog1.Execute then
    begin
      Cursor := crHourGlass;
      Enabled := False;

      lsFileName := OpenDialog1.FileName;
      lblFileName.Caption := Copy(lsFileName, Length(lsFileName) - 9, 11);

      ppArchiveReader1.ArchiveFileName := lsFileName;
      ppArchiveReader1.PrintToDevices;

      Enabled := True;
      Cursor := crDefault;
    end;
end; {procedure, btnPrintArchiveClick}




end.
