{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daVisualLinkHint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls;

type

  { TdaVisualLinkHint }

  TdaVisualLinkHint = class(TForm)
    lblLinkDetail: TLabel;
    lblDetailDataView: TLabel;
    lblDetailField: TLabel;
    lblToMaster: TLabel;
    lblMasterDataView: TLabel;
    lblMasterField: TLabel;
    procedure FormCreate(Sender: TObject);
    private
      FLanguageIndex: Integer;

      procedure SetLanguageIndex(aLanguageIndex: Integer);

    public
      procedure UpdateDescription(aDetailDataViewName, aDetailFieldName, aMasterDataViewName, aMasterFieldName: String; aLinkColor: TColor);

      property LanguageIndex: Integer read FLanguageIndex write SetLanguageIndex;

  end; {class, TdaVisualLinkHint}

implementation

uses
  ppUtils;
  
{$R *.DFM}

procedure TdaVisualLinkHint.FormCreate(Sender: TObject);
begin

  // do this in code, so that labels can use ParentFont = True
  // and then modify the style/color here
  lblDetailDataView.Font.Style := [fsBold];
  lblDetailDataView.Font.Color := clNavy;
  lblDetailField.Font :=  lblDetailDataView.Font;

  lblMasterDataView.Font.Style := [fsBold];
  lblMasterDataView.Font.Color := clMaroon;
  lblMasterField.Font :=  lblDetailDataView.Font;

end;

{------------------------------------------------------------------------------}
{ TdaVisualLinkHint.UpdateDescription }

procedure TdaVisualLinkHint.UpdateDescription(aDetailDataViewName, aDetailFieldName, aMasterDataViewName, aMasterFieldName: String; aLinkColor: TColor);
var
  lLastLabel: TLabel;
begin
  lblDetailDataView.Font.Color := aLinkColor;
  lblDetailField.Font.Color := aLinkColor;

  lblMasterDataView.Font.Color := aLinkColor;
  lblMasterField.Font.Color := aLinkColor;

  lblDetailDataView.Left := lblLinkDetail.Left + lblLinkDetail.Width + 7;
  lblDetailDataView.Caption := aDetailDataViewName + '.';

  lblDetailField.Left := lblDetailDataView.Left + lblDetailDataView.Width;
  lblDetailField.Caption := aDetailFieldName;

  lblToMaster.Left := lblDetailField.Left + lblDetailField.Width + 7;

  lLastLabel := lblToMaster;

  if (aMasterDataViewName <> '') then
    begin
      lblMasterDataView.Left := lblToMaster.Left + lblToMaster.Width + 7;
      lblMasterDataView.Caption := aMasterDataViewName;
      lblMasterDataView.Visible := True;

      lLastLabel := lblMasterDataView;

      if (aMasterFieldName <> '') then
        begin
          lblMasterDataView.Caption := lblMasterDataView.Caption + '.';

          lblMasterField.Left := lblMasterDataView.Left + lblMasterDataView.Width;
          lblMasterField.Caption := aMasterFieldName;
          lblMasterField.Visible := True;

          lLastLabel := lblMasterField;
        end
      else
        lblMasterField.Visible := False;
    end

  else
    begin
      lblMasterDataView.Visible := False;
      lblMasterField.Visible := False;
    end;

  Width := lLastLabel.Left + lLastLabel.Width + 4;

end; {procedure, SetDescription}

{------------------------------------------------------------------------------}
{ TdaVisualLinkHint.SetLanguageIndex }

procedure TdaVisualLinkHint.SetLanguageIndex(aLanguageIndex: Integer);
begin

  FLanguageIndex := aLanguageIndex;

  lblLinkDetail.Caption := ppLoadStr(852); {'Link Detail'}
  lblToMaster.Caption := ppLoadStr(854); {'to master'}

end; {procedure, SetLanguageIndex}


end.
