{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ Interbase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2001 Serge Buzadzhy                     }
{    Contact: buzz@devrace.com                                  }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page      : http://www.fibplus.net/           }
{    FIBPlus support e-mail : fibplus@devrace.com               }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}
unit pFIBDataSetOptions;

interface

uses Classes, Graphics,Controls, Forms, FIBDataSet, pFIBProps, StdCtrls, ComCtrls,
  Db, pFIBDataSet,Dialogs;

type

  TFPDataSetOptionsForm = class(TForm)
    pFIBDataSet1: TpFIBDataSet;
    Pages: TPageControl;
    OptionsPage: TTabSheet;
    PreparePage: TTabSheet;
    OkB: TButton;
    CancelB: TButton;
    ch_poTrimCharFields: TCheckBox;
    ch_poRefreshAfterPost: TCheckBox;
    Ch_poRefreshDeletedRecord: TCheckBox;
    ch_poStartTransaction: TCheckBox;
    ch_poAutoFormatFields: TCheckBox;
    ch_poProtectedEdit: TCheckBox;
    ch_poKeepSorting: TCheckBox;
    ch_poPersistentSorting: TCheckBox;
    ch_pfSetRequiredFields: TCheckBox;
    ch_pfSetReadOnlyFields: TCheckBox;
    ch_pfImportDefaultValues: TCheckBox;
    ch_psUseBooleanField: TCheckBox;
    ch_psSQLINT64ToBCD: TCheckBox;
    ch_psApplyRepositary: TCheckBox;
    ch_psGetOrderInfo: TCheckBox;
    ch_psAskRecordCount: TCheckBox;
    ch_poVisibleRecno: TCheckBox;
    ch_poNoForceIsNull: TCheckBox;
    ch_poFetchAll: TCheckBox;
    ch_poFreeHandlesAfterClose: TCheckBox;
    ch_poCacheCalcFields: TCheckBox;
    ch_psCanEditComputedFields: TCheckBox;
    ch_psSetEmptyStrToNull: TCheckBox;
    ch_psSupportUnicodeBlobs: TCheckBox;
    ch_psUseLargeIntField: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ch_poTrimCharFieldsClick(Sender: TObject);
  private
    { Private declarations }
    FDataSet: TFIBDataSet;
    procedure ShowChanges;
  public
    { Public declarations }
    function GetOptionBox(aIndex: Integer;const PropName:string): TCheckBox;
  end;

function EditOptions(aDataSets: array of TFIBDataSet; aPageIndex: Integer): boolean;

implementation
uses FIBConsts, SysUtils,TypInfo;

{$R *.dfm}

function EditOptions(aDataSets: array of TFIBDataSet; aPageIndex: Integer): boolean;
var aForm: TFPDataSetOptionsForm;
    I: TpFIBDsOption;
    J: TpPrepareOption;
    chBox:TCheckBox;
    K:integer;
begin
  Result := False;
  if aDataSets[0] = nil then exit;
  aForm := TFPDataSetOptionsForm.Create(Application);
  try
    with aForm do
    begin
      FDataSet := aDataSets[0];
      Caption := Format(Caption, [FDataSet.Name]);
      Pages.ActivePage := Pages.Pages[aPageIndex];
      for i:=Low(TpFIBDsOption) to High(TpFIBDsOption) do
      begin
        chBox:=GetOptionBox(Ord(I),'Options');
        if Assigned(chBox) then
         chBox.Checked := I in FDataSet.Options;
      end;

//      for J := pfSetRequiredFields to psAskRecordCount do
      for J := Low(TpPrepareOption) to High(TpPrepareOption) do
      begin
        chBox:=GetOptionBox(Ord(J),'PrepareOptions');
        if Assigned(chBox) then
         chBox.Checked := J in FDataSet.PrepareOptions;
      end;

      Result := ShowModal = mrOk;
      if Result then
      begin
        for i:=Low(TpFIBDsOption) to High(TpFIBDsOption) do
        begin
         chBox:=GetOptionBox(Ord(I),'Options');
         for k:=Low(aDataSets) to High(aDataSets) do
         begin
           if Assigned(chBox) then
            if chBox.Checked then
            begin
              if not (I in aDataSets[k].Options) then
               aDataSets[k].Options := aDataSets[k].Options + [I];
            end
            else
              if (I in aDataSets[k].Options) then
               aDataSets[k].Options := aDataSets[k].Options - [I];
         end;
        end;
        for J := Low(TpPrepareOption) to High(TpPrepareOption) do
        begin
          chBox:=GetOptionBox(Ord(J),'PrepareOptions');
          for k:=Low(aDataSets) to High(aDataSets) do
          begin
            if Assigned(chBox) then
             if chBox.Checked then
             begin
              if not (J in aDataSets[k].PrepareOptions) then
               aDataSets[k].PrepareOptions := aDataSets[k].PrepareOptions + [J];
             end
             else
              if (J in aDataSets[k].PrepareOptions) then
               aDataSets[k].PrepareOptions := aDataSets[k].PrepareOptions - [J];
          end;
        end;
      end;
    end;
  finally
    aForm.Free;
  end;
end;

procedure TFPDataSetOptionsForm.ShowChanges;
var
    I: TpFIBDsOption;
    chBox:TCheckBox;
    J: TpPrepareOption;
begin
//  for I := poTrimCharFields to poPersistentSorting do
  for i:=Low(TpFIBDsOption) to High(TpFIBDsOption) do
  begin
    chBox:=GetOptionBox(Ord(I),'Options');
    if Assigned(chBox) then
    begin
     if (Ord(chBox.Checked)-Ord(I in FDataSet.Options))<>0 then
      chBox.Font.Style:=chBox.Font.Style+[fsBold]
     else
      chBox.Font.Style:=chBox.Font.Style-[fsBold]
    end;
  end;

//  for J := pfSetRequiredFields to psAskRecordCount do
  for J := Low(TpPrepareOption) to High(TpPrepareOption) do
  begin
    chBox:=GetOptionBox(Ord(J),'PrepareOptions');
    if Assigned(chBox) then
    begin
     if (Ord(chBox.Checked)-Ord(J in FDataSet.PrepareOptions))<>0 then
      chBox.Font.Style:=chBox.Font.Style+[fsBold]
     else
      chBox.Font.Style:=chBox.Font.Style-[fsBold]
    end;
  end;

end;

function TFPDataSetOptionsForm.GetOptionBox(aIndex: Integer;const PropName:string): TCheckBox;
var
  EnumType: PTypeInfo;
  EnumName: string;
  PropType:PTypeInfo;
  PropInfo: PPropInfo;
begin
    PropInfo := GetPropInfo(TpFIBDataSet, PropName);
    PropType := PPropInfo(PropInfo)^.PropType^;
    EnumType := GetTypeData(PropType)^.CompType^;
    EnumName := GetEnumName(EnumType,aIndex);
    Result   := TCheckBox(FindComponent('Ch_'+EnumName))
end;


procedure TFPDataSetOptionsForm.FormCreate(Sender: TObject);
begin
  //
  Caption := FPOptionsCaption;
  OptionsPage.Caption := FPOptionsPage;
  PreparePage.Caption := FPOptionsPreparePage;

  ch_poTrimCharFields.Caption := FPOptionsTrimChars;
  ch_poRefreshAfterPost.Caption := FPOptionsRefresh;
  Ch_poRefreshDeletedRecord.Caption := FPOptionsRefreshDelete;
  ch_poStartTransaction.Caption := FPOptionsAutoStart;
  ch_poAutoFormatFields.Caption := FPOptionsApplyFormats;
  ch_poProtectedEdit.Caption := FPOptionsIdleUpdate;
  ch_poKeepSorting.Caption := FPOptionsKeepSort;
  ch_poPersistentSorting.Caption := FPOptionsRestoreSort;
  ch_pfSetRequiredFields.Caption := FPOptionsSetRequired;
  ch_pfSetReadOnlyFields.Caption := FPOptionsSetReadOnly;
  ch_pfImportDefaultValues.Caption := FPOptionsSetDefault;
  ch_psUseBooleanField.Caption := FPOptionsEmulateBoolean;
  ch_psSQLINT64ToBCD.Caption := FPOptionsCreateBCD;
  ch_psApplyRepositary.Caption := FPOptionsApplyRepository;
  ch_psGetOrderInfo.Caption := FPOptionsSortFields;
  ch_psAskRecordCount.Caption := FPOptionsRecordCount;
  ch_poVisibleRecno.Caption := FPVisibleRecno;  
end;

procedure TFPDataSetOptionsForm.ch_poTrimCharFieldsClick(Sender: TObject);
begin
 ShowChanges
end;

end.
