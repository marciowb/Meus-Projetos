unit Lst_Anexos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, Buttons, Comandos, MinhasClasses,
  VCLUnZip, VCLZip, kpZipObj, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmAnexo = class(TfrmPadrao)
    Panel1: TPanel;
    cxGrid1: TcxGrid;
    TvAnexo: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    DataAnexo: TDataSource;
    vAnexoColumn1: TcxGridDBColumn;
    vAnexoColumn2: TcxGridDBColumn;
    vAnexoColumn3: TcxGridDBColumn;
    btnAdd: TSpeedButton;
    btnMenos: TSpeedButton;
    Open: TOpenDialog;
    Zip: TVCLZip;
    btnExportar: TSpeedButton;
    Save: TSaveDialog;
    procedure btnAddClick(Sender: TObject);
    procedure ZipTotalPercentDone(Sender: TObject; Percent: Integer);
    procedure btnMenosClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    FIdEntidade: Integer;
    FEntidade: String;
    procedure SetIdEntidade(const Value: Integer);
    procedure SetEntidade(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property Entidade : String read FEntidade write SetEntidade;
    property IdEntidade : Integer read FIdEntidade write SetIdEntidade;
  end;

var
  frmAnexo: TfrmAnexo;

implementation

uses  uSQL;

{$R *.dfm}

{ TfrmPadrao1 }

procedure TfrmAnexo.btnAddClick(Sender: TObject);
var
  Mem, MemOut : TMemoryStream;
begin
  inherited;
  if Open.Execute(Self.Handle) then
  Begin
    Try
      Mem := TMemoryStream.Create;
      MemOut := TMemoryStream.Create;
      Mem.LoadFromFile(Open.FileName);
      if DataAnexo.DataSet.FieldByName('IDANEXO').IsNull then
      Begin
        DataAnexo.DataSet.Append;
        DataAnexo.DataSet.FieldByName('FLAGEDICAO').AsString  := 'I';
      End  else
      Begin
        DataAnexo.DataSet.Edit;
        DataAnexo.DataSet.FieldByName('FLAGEDICAO').AsString  := 'E';
      End;

      DataAnexo.DataSet.FieldByName('NOMEARQUIVO').AsString := ExtractFileName(Open.FileName);
      Zip.ArchiveStream := MemOut;
      Zip.ZipFromStream(Mem, DataAnexo.DataSet.FieldByName('NOMEARQUIVO').AsString );
      
      TBlobField(DataAnexo.DataSet.FieldByName('ARQUIVO')).LoadFromStream(MemOut);
      DataAnexo.DataSet.FieldByName('TAMANHO').AsFloat := MemOut.Size/1024;
      DataAnexo.DataSet.FieldByName('IDUSUARIO').AsInteger := UsuarioLogado.Id;
      DataAnexo.DataSet.FieldByName('DATA').AsString := GetDataServidor;
      DataAnexo.DataSet.FieldByName('ENTIDADE').AsString := Entidade;
      DataAnexo.DataSet.FieldByName('IDENTIDADE').AsInteger := IdEntidade;
      if Pergunta('Deseja tornar esse arquivo particular?') then
        DataAnexo.DataSet.FieldByName('FLAGPARTICULAR').AsString := 'Y'
      else
        DataAnexo.DataSet.FieldByName('FLAGPARTICULAR').AsString := 'N';
      DataAnexo.DataSet.Post;
     
    Finally
      FreeAndNil(Mem);
      FreeAndNil(MemOut);
    End;
    
  End;
end;

procedure TfrmAnexo.btnExportarClick(Sender: TObject);
var
  Mem, MemOut : TMemoryStream;
begin
  inherited;
  Save.FileName := DataAnexo.DataSet.FieldByName('NOMEARQUIVO').AsString;
  if Save.Execute(Self.Handle) then
  Begin
    Try
      Mem := TMemoryStream.Create;
      MemOut := TMemoryStream.Create;
      TBlobField(DataAnexo.DataSet.FieldByName('ARQUIVO')).SaveToStream(Mem);
      Zip.DoAll := True;
      Zip.ArchiveStream := Mem;
      Zip.UnZipToStream(MemOut, Save.FileName);
      MemOut.SaveToFile(Save.FileName);
    Finally
      FreeAndNil(Mem);
      FreeAndNil(MemOut);
    End;
  End;

end;

procedure TfrmAnexo.btnMenosClick(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    DataAnexo.DataSet.Edit;
    DataAnexo.DataSet.FieldByName('FLAGEDICAO').AsString  := 'D';
    DataAnexo.DataSet.Post;
  End;
end;

procedure TfrmAnexo.SetEntidade(const Value: String);
begin
  FEntidade := Value;
end;

procedure TfrmAnexo.SetIdEntidade(const Value: Integer);
begin
  FIdEntidade := Value;
end;

procedure TfrmAnexo.ZipTotalPercentDone(Sender: TObject; Percent: Integer);
begin
  inherited;
  Application.ProcessMessages;
end;

end.
