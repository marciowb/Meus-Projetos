{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDatDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  TypInfo,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppDsIntf,
  ppDB,
  ppComm,
  ppUtils;

type

  {@TppDataDialog }
  TppDataDialog = class(TppCustomDataDialog)
    btnOK: TButton;
    btnCancel: TButton;
    lblMaster: TLabel;
    lbxMasterData: TListBox;
    lblDetail: TLabel;
    lbxDetailData: TListBox;
    procedure FormDestroy(Sender: TObject);
    procedure lbxMasterDataClick(Sender: TObject);
    procedure lbxMasterDataDblClick(Sender: TObject);
    procedure lbxDetailDataClick(Sender: TObject);
    procedure lbxDetailDataDblClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FNoneString: String;
    FDataNames: TppDataPipelineList;
    FMasterDataName: String;
    FDetailDataName: String;

  protected
    procedure LanguageChanged; override;

  public
    procedure Init; override;

  end; {class, TppDataDialog}


var
  ppDataDialog: TppDataDialog;

implementation


{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppDataDialog.FormDestroy }

procedure TppDataDialog.FormDestroy(Sender: TObject);
begin
  FDataNames.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppDataDialog.Init }

procedure TppDataDialog.Init;
begin

  if Report = nil then Exit;

  FDataNames := TppDataPipelineList.Create(Report);

  {initialize master controls}
  lbxMasterData.Items := FDataNames;
  lbxMasterData.Items.Insert(0, FNoneString);

  if MasterDataPipeline <> nil then
    FMasterDataName := TppCommunicator(MasterDataPipeline).UserName
  else
    FMasterDataName := '';

  lbxMasterData.ItemIndex := lbxMasterData.Items.IndexOf(FMasterDataName);

  if lbxMasterData.ItemIndex < 0 then
    begin
      lbxMasterData.ItemIndex := 0;
      FMasterDataName := FNoneString;
    end;

  {initialize detail controls}
  if (DetailDataPipeline = nil) then
    begin
      FDetailDataName := FNoneString;

      lbxDetailData.Visible := False;
      lblDetail.Visible := False;

      btnOK.Top := lbxMasterData.Top + lbxMasterData.Height + 13;
      btnCancel.Top := btnOK.Top;

      Height := btnOK.Top + btnOK.Height + 33;
    end
  else
    begin
      FDetailDataName := TppCommunicator(DetailDataPipeline).UserName;

      lbxDetailData.Items := FDataNames;
      lbxDetailData.Items.Insert(0, FNoneString);

      lbxDetailData.ItemIndex := lbxDetailData.Items.IndexOf(FDetailDataName);

      if (lbxDetailData.ItemIndex < 0) then
        begin
          lbxDetailData.ItemIndex := 0;
          FDetailDataName := FNoneString;
        end;

    end;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppDataDialog.LanguageChanged }

procedure TppDataDialog.LanguageChanged;
begin

  Caption := ppLoadStr(141); {'Data'}

  FNoneString := ppLoadStr(343); {'<None>'}

  if (DetailDataPipeline = nil) then
    lblMaster.Caption := ppLoadStr(500) {'Data Pipeline'}
  else
    lblMaster.Caption := ppLoadStr(395); {'Master Data Pipeline'}

  lblDetail.Caption := ppLoadStr(396); {'Detail Data Pipeline'}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppDataDialog.btnOKClick }

procedure TppDataDialog.btnOKClick(Sender: TObject);
var
  liIndex: Integer;
begin

  {get the master data pipeline}
  if (FMasterDataName = FNoneString) then
    MasterDataPipeline := nil

  else
    begin
      liIndex := FDataNames.IndexOf(FMasterDataName);

      if (liIndex >= 0) then
        MasterDataPipeline := TppDataPipeline(FDataNames.Objects[liIndex]);
    end;


  {get the detail data pipeline}
  if (FDetailDataName = FNoneString) then
    DetailDataPipeline := nil

  else
    begin
      liIndex := FDataNames.IndexOf(FDetailDataName);

      if (liIndex >= 0) then
        DetailDataPipeline := TppDataPipeline(FDataNames.Objects[liIndex]);
    end;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppDataDialog.lbxMasterDataClick }

procedure TppDataDialog.lbxMasterDataClick(Sender: TObject);
begin
  FMasterDataName := lbxMasterData.Items[lbxMasterData.ItemIndex];
end; {procedure, lbxMasterDataClick}

{------------------------------------------------------------------------------}
{ TppDataDialog.lbxMasterDataDblClick }
procedure TppDataDialog.lbxMasterDataDblClick(Sender: TObject);
begin
  FMasterDataName := lbxMasterData.Items[lbxMasterData.ItemIndex];

  btnOKClick(Self);
end; {procedure, lbxMasterDataDblClick}

{------------------------------------------------------------------------------}
{ TppDataDialog.lbxDetailDataClick }

procedure TppDataDialog.lbxDetailDataClick(Sender: TObject);
begin
  FDetailDataName := lbxDetailData.Items[lbxDetailData.ItemIndex];
end; {procedure, lbxDetailDataClick}

{------------------------------------------------------------------------------}
{ TppDataDialog.lbxDetailDataDblClick }

procedure TppDataDialog.lbxDetailDataDblClick(Sender: TObject);
begin
  FDetailDataName := lbxDetailData.Items[lbxDetailData.ItemIndex];

  btnOKClick(Self);
end; {procedure, lbxDetailDataDblClick}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomDataDialog, TppDataDialog);

finalization

  ppUnRegisterForm(TppCustomDataDialog);

end.
