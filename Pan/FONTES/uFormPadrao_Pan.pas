unit uFormPadrao_Pan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvEnterTab , DBCtrls, StdCtrls, Mask, IniFiles,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, cxDBEdit;

type
  TfrmPadrao = class(TForm)
    JvEnterAsTab1: TJvEnterAsTab;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FMaxmiza: boolean;
    FIdForm: Int64;
    { Private declarations }
  public
    { Public declarations }
    property Maxmiza : boolean read FMaxmiza write FMaxmiza;
    property  IdForm : Int64 read FIdForm write FIdForm;
  end;

var
  frmPadrao: TfrmPadrao;
  
implementation

uses  Classes_Pan, Comandos_Pan;

{$R *.dfm}

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  FMaxmiza := False;
  DoubleBuffered := True;
  IdForm := idFrmPadrao;
end;

procedure TfrmPadrao.FormShow(Sender: TObject);
var
  I : Integer;
  Ini : TIniFile;
begin
   AcertaPadroesData;
  if FMaxmiza  then
  Begin
    Self.Align := alClient;
    Self.WindowState := wsMaximized;
  End;

  Try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    for I := 0 to ComponentCount - 1 do
    Begin
      if Components[i] is TcxDBMemo then
      Begin
        (Components[i] as TcxDBMemo).Properties.AssignedValues.MaxLength := True;
        (Components[i] as TcxDBMemo).Properties.MaxLength := ini.ReadInteger('Geral', 'TamanhoTexto', 100);
      End;


    End;
  Finally
    FreeAndNil(ini);
  End;

end;

end.
