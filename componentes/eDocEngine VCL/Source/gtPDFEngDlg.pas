{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtPDFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls, gtPDFCrypt,
  gtPlnDlg, gtDocDlg, gtDocResStrs, gtCstDocEng, gtCstPDFEng, gtDocConsts
  {$IFDEF gtPro}
    , gtExPDFEng
  {$ENDIF}
  ;

type
  TgtPDFEngineDlg = class(TgtPlainSheetDlg)
    tsPDFAdvanced: TTabSheet;
    gbPDFOptions: TGroupBox;
    lblFontEncoding: TLabel;
    gbEncryption: TGroupBox;
    lblOwnerPassword: TLabel;
    lblConfirmOwnerPassword: TLabel;
    lblUserPassword: TLabel;
    lblConfirmUserPassword: TLabel;
    edOwnerPassword: TEdit;
    edConfirmOwnerPassword: TEdit;
    gbUserPermissions: TGroupBox;
    chkPrint: TCheckBox;
    chkModify: TCheckBox;
    chkCopy: TCheckBox;
    edUserPassword: TEdit;
    edConfirmUserPassword: TEdit;
    gbUseCompression: TGroupBox;
    lblCompressionLevel: TLabel;
    cbCompressionLevel: TComboBox;
    chkCompressDocument: TCheckBox;
    cbEncoding: TComboBox;
    chkEnableEncryption: TCheckBox;
    tsViewerPreferences: TTabSheet;
    gbViewerPreferences: TGroupBox;
    lblPageLayout: TLabel;
    lblPageMode: TLabel;
    cbPageLayout: TComboBox;
    cbPageMode: TComboBox;
    gbHideUIElements: TGroupBox;
    chkMenuBar: TCheckBox;
    chkToolBar: TCheckBox;
    chkNavigationControls: TCheckBox;
    gbPresentationMode: TGroupBox;
    lblPageTransitionEffect: TLabel;
    lblPageTransitionDuration: TLabel;
    lblSecs: TLabel;
    edPageTransitionDuration: TEdit;
    cbPageTransitionEffect: TComboBox;
    lblEncryptionLevel: TLabel;
    cbEncryptionLevel: TComboBox;
    chkAnnotation: TCheckBox;
    chkFormFill: TCheckBox;
    chkAccessibility: TCheckBox;
    chkDocumentAssembly: TCheckBox;
    chkHighResolutionPrint: TCheckBox;
    rgpEmbedTrueTypeFonts: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edConfirmPasswordExit(Sender: TObject);
    procedure chkEnableEncryptionClick(Sender: TObject);
    procedure cbPageTransitionEffectChange(Sender: TObject);
    procedure cbEncryptionLevelChange(Sender: TObject);
    procedure chkCompressDocumentClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  protected
		procedure Localize; override;

  public
    { Public declarations }
  end;

const
  TTFontEmbedding: array[TgtTTFontEmbedding] of String = (
    STTFENone, STTFEFull, STTFESubset
  );

	CompressionMethods: array[TgtCompressionLevel] of String = (
		SCompressionMethodFastest, SCompressionMethodNormal,
		SCompressionMethodMaximum);
	PDFPageLayout: array[TgtPageLayout] of String = (SPageLayoutSinglePage,
    SPageLayoutOneColoumn, SPageLayoutTwoColoumnLeft,
    SPageLayoutTwoColoumnRight);

	PDFPageMode: array[TgtPageMode] of String = (SPageModeUseNone,
    SPageModeUseOutlines, SPageModeUseThumbs, SPageModeFullScreen);

	PDFTransitionEffects: array[TgtTransitionEffect] of String = (SNone,
    SSplitHorizontalInward, SSplitHorizontalOutward, SSplitVerticalInward,
    SSplitVerticalOutward, SBlindsHorizontal, SBlindsVertical,
    SBoxInward, SBoxOutward, SWipeLeftToRight, SWipeBottomToTop,
    SWipeRightToLeft, SWipeTopToBottom, SDissolve, SGlitterLeftToRight,
    SGlitterTopToBottom, SGlitterTopLeftToBottomRight);

  PDFEncryptionLevel: array[TgtPDFEncryptionLevel] of String = (Sel40Bit,
    Sel128Bit);

implementation

uses gtUtils;

{$R *.dfm}

{ TgtPDFEngineDlg }

procedure TgtPDFEngineDlg.Localize;
var
  LI: TgtTTFontEmbedding;
begin
  inherited;
  Caption := SPDFDlgCaption;

  rgpEmbedTrueTypeFonts.Caption := SrgpEmbedTrueTypeFonts;
  rgpEmbedTrueTypeFonts.Items.Clear;
  for LI := Low(TgtTTFontEmbedding) to High(TgtTTFontEmbedding) do
    rgpEmbedTrueTypeFonts.Items.AddObject(TTFontEmbedding[LI], TObject(LI));
  
  tsPDFAdvanced.Caption := StsPDFAdvanced;
  chkCompressDocument.Caption := SchkCompressDocument;
  lblCompressionLevel.Caption := SlblCompressionLevel;
  chkEnableEncryption.Caption := SchkEnableEncryption;
  lblOwnerPassword.Caption := SlblOwnerPassword;
  lblConfirmOwnerPassword.Caption := SlblConfirmOwnerPassword;
  lblUserPassword.Caption := SlblUserPassword;
  lblConfirmUserPassword.Caption := SlblConfirmUserPassword;
  lblEncryptionLevel.Caption := SlblEncryptionLevel;
  gbUserPermissions.Caption := SgbUserPermissions;
  chkCopy.Caption := SchkCopy;
  chkModify.Caption := SchkModify;
  chkPrint.Caption := SchkPrint;
  chkFormFill.Caption := SchkFormFill;
  chkAnnotation.Caption := SchkAnnotation;
  chkAccessibility.Caption := SchkAccessibility;
  chkDocumentAssembly.Caption := SchkDocumentAssembly;
  chkHighResolutionPrint.Caption := SchkHighResolutionPrint;
  lblFontEncoding.Caption := SlblFontEncoding;
  tsViewerPreferences.Caption := StsViewerPreferences;
  lblPageLayout.Caption := SlblPageLayout;
  lblPageMode.Caption := SlblPageMode;
  gbHideUIElements.Caption := SgbHideUIElements;
  chkMenuBar.Caption := SchkMenuBar;
  chkToolBar.Caption := SchkToolBar;
  chkNavigationControls.Caption := SchkNavigationControls;
  gbPresentationMode.Caption := SgbPresentationMode;
  lblPageTransitionEffect.Caption := SlblPageTransitionEffect;
  lblPageTransitionDuration.Caption := SlblPageTransitionDuration;
end;

procedure TgtPDFEngineDlg.FormCreate(Sender: TObject);
var
	I: TgtCompressionLevel;
	J: TgtPDFFontEncoding;
  K: TgtPageLayout;
  L: TgtPageMode;
  M: TgtTransitionEffect;
  N: TgtPDFEncryptionLevel;
begin
	inherited FormCreate(Sender);
  {$IFNDEF GIFSupport}
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifGIF))));
  {$ENDIF}
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifPNG))));
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifMetafile))));

	for I := Low(TgtCompressionLevel) to High(TgtCompressionLevel) do
		cbCompressionLevel.Items.AddObject(CompressionMethods[I], TObject(I));

	for J := Low(TgtPDFFontEncoding) to High(TgtPDFFontEncoding) do
		cbEncoding.Items.AddObject(PDFFontEncodeStrings[J], TObject(J));

	for K := Low(TgtPageLayout) to High(TgtPageLayOut) do
		cbPageLayout.Items.AddObject(PDFPageLayout[K], TObject(K));

	for L := Low(TgtPageMode) to High(TgtPageMode) do
		cbPageMode.Items.AddObject(PDFPageMode[L], TObject(L));

	for M := Low(TgtTransitionEffect) to High(TgtTransitionEffect) do
		cbPageTransitionEffect.Items.AddObject(PDFTransitionEffects[M], TObject(M));

	for N := Low(TgtPDFEncryptionLevel) to High(TgtPDFEncryptionLevel) do
		cbEncryptionLevel.Items.AddObject(PDFEncryptionLevel[N], TObject(N));
  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1 ,SlblAdvanced);
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, SlblViewerPreferences);
  {$ELSE}
  lbDocumentDlg.Items.Append(SlblAdvanced);
  lbDocumentDlg.Items.Append(SlblViewerPreferences);
  {$ENDIF}
end;

procedure TgtPDFEngineDlg.FormShow(Sender: TObject);
begin
  {$IFDEF gtPro}
  with TgtExPDFEngine(Engine) do
  {$ELSE}
  with TgtCustomPDFEngine(Engine) do
  {$ENDIF}
  begin
    with ImageSettings do
    begin
      cbOutputImageFormat.ItemIndex := cbOutputImageFormat.Items.IndexOf(
        ImageFormats[TgtOutputImageFormat(OutputImageFormat)]);
      edJPEGQuality.Text := IntToStr(JPEGQuality);
      if OutputImageFormat = ifJPEG then
        edJPEGQuality.Enabled := True
      else
        edJPEGQuality.Enabled := False;
      cbOutputImageFormatChange(Sender);
    end;
    imgBackgroundImage.Picture.Assign(BackgroundImage);
    cbBackgroundDisplayType.ItemIndex :=
      cbBackgroundDisplayType.Items.IndexOfObject(
      TObject(Ord(BackgroundImageDisplayType)));
    shpBackgroundColor.Brush.Color := BackgroundColor;
    if (imgBackgroundImage.Picture.Graphic = nil) or
      imgBackgroundImage.Picture.Graphic.Empty then
      btnClearClick(Sender);
    rgpEmbedTrueTypeFonts.ItemIndex := Integer(
      TgtTTFontEmbedding(Preferences.EmbedTrueTypeFonts));
		chkCompressDocument.Checked := Compression.Enabled;
		cbCompressionLevel.ItemIndex := cbCompressionLevel.Items.IndexOfObject(
			TObject(Ord(Compression.Level)));
		cbEncoding.ItemIndex := cbEncoding.Items.IndexOfObject(
			TObject(Ord(FontEncoding)));
    chkEnableEncryption.Checked := Encryption.Enabled;
    edOwnerPassword.Text := String(Encryption.OwnerPassword);
    edConfirmOwnerPassword.Text := String(Encryption.OwnerPassword);
    edUserPassword.Text := String(Encryption.UserPassword);
    edConfirmUserPassword.Text := String(Encryption.UserPassword);
    cbEncryptionLevel.ItemIndex := cbEncryptionLevel.Items.IndexOfObject(
      TObject(Ord(Encryption.Level)));
    chkPrint.Checked := AllowPrint in Encryption.UserPermissions;
    chkModify.Checked := AllowModify in Encryption.UserPermissions;
    chkCopy.Checked := AllowCopy in Encryption.UserPermissions;
    chkFormFill.Checked := AllowFormFill in Encryption.UserPermissions;
    chkAnnotation.Checked := AllowAnnotation in Encryption.UserPermissions;
    chkAccessibility.Checked := AllowAccessibility in Encryption.UserPermissions;
    chkDocumentAssembly.Checked := AllowDocAssembly in Encryption.UserPermissions;
    chkHighResolutionPrint.Checked := AllowHighResPrint in Encryption.UserPermissions;

		cbPageLayout.ItemIndex := cbPageLayout.Items.IndexOfObject(
			TObject(Ord(ViewerPreferences.PageLayout)));
		cbPageMode.ItemIndex := cbPageMode.Items.IndexOfObject(
			TObject(Ord(ViewerPreferences.PageMode)));

    chkMenuBar.Checked := ViewerPreferences.HideMenuBar;
    chkToolBar.Checked := ViewerPreferences.HideToolBar;
    chkNavigationControls.Checked := ViewerPreferences.HideWindowUI;

		cbPageTransitionEffect.ItemIndex := cbPageTransitionEffect.Items.
        IndexOfObject(TObject(Ord(ViewerPreferences.
      PresentationMode.TransitionEffect)));
    edPageTransitionDuration.Text := IntToStr(ViewerPreferences.
      PresentationMode.Duration);

    cbEncryptionLevelChange(Sender);
    chkEnableEncryptionClick(Sender);
    cbPageTransitionEffectChange(Sender);
  end;
  inherited FormShow(Sender);
end;

procedure TgtPDFEngineDlg.edConfirmPasswordExit(Sender: TObject);
var
  Str: String;
begin
  if (chkEnableEncryption.Checked) then
  begin
    if (TEdit(Sender) = edConfirmOwnerPassword) then
    begin
      if (AnsiCompareStr(edOwnerPassword.Text,
        edConfirmOwnerPassword.Text) <> 0) then
      begin
        Str := Format(SPasswordMissMatch ,['Owner']);
        MessageDlg(Str, mtError, [mbOK], 0);
        edOwnerPassword.SetFocus;
        Exit;
      end;
    end;
    if (TEdit(Sender) = edConfirmUserPassword) then
    begin
      if (AnsiCompareStr(edUserPassword.Text,
        edConfirmUserPassword.Text) <> 0) then
      begin
        Str := Format(SPasswordMissMatch ,['User']);
        MessageDlg(Str, mtError, [mbOK], 0);
        edUserPassword.SetFocus;
        Exit;
      end;
    end;
  end;
  inherited;
end;

procedure TgtPDFEngineDlg.chkEnableEncryptionClick(Sender: TObject);
begin
	SetControlsEnabled(gbEncryption, chkEnableEncryption.Checked);
  if chkEnableEncryption.Checked then
    cbEncryptionLevelChange(Sender);
end;

procedure TgtPDFEngineDlg.cbPageTransitionEffectChange(Sender: TObject);
begin
	lblPageTransitionDuration.Enabled := not (cbPageTransitionEffect.Text =
    PDFTransitionEffects[teNone]);
	edPageTransitionDuration.Enabled := lblPageTransitionDuration.Enabled;
	edPageTransitionDuration.Color := EditColor[edPageTransitionDuration.Enabled];
	lblSecs.Enabled := not (cbPageTransitionEffect.Text =
    PDFTransitionEffects[teNone]);
end;

procedure TgtPDFEngineDlg.cbEncryptionLevelChange(Sender: TObject);
begin
  if TgtPDFEncryptionLevel(cbEncryptionLevel.ItemIndex) = el40Bit then
  begin
    chkAnnotation.Enabled := False;
    chkAccessibility.Enabled := False;
    chkDocumentAssembly.Enabled := False;
    chkHighResolutionPrint.Enabled := False;
  end
  else
  begin
    chkAnnotation.Enabled := True;
    chkAccessibility.Enabled := True;
    chkDocumentAssembly.Enabled := True;
    chkHighResolutionPrint.Enabled := True;
  end;
end;

procedure TgtPDFEngineDlg.chkCompressDocumentClick(Sender: TObject);
begin
	SetControlsEnabled(gbUseCompression, chkCompressDocument.Checked);
end;

procedure TgtPDFEngineDlg.btnOKClick(Sender: TObject);
begin
  {$IFDEF gtPro}
  with TgtExPDFEngine(Engine) do
  {$ELSE}
  with TgtCustomPDFEngine(Engine) do
  {$ENDIF}
  begin
    Preferences.EmbedTrueTypeFonts :=
      TgtTTFontEmbedding(rgpEmbedTrueTypeFonts.Items.Objects[
      rgpEmbedTrueTypeFonts.ItemIndex]);
    BackgroundColor := shpBackgroundColor.Brush.Color;
    BackgroundImage.Assign(imgBackgroundImage.Picture);
		BackgroundImageDisplayType := TgtBackgroundDisplayType(
			cbBackgroundDisplayType.Items.Objects[
			cbBackgroundDisplayType.ItemIndex]);
    with Compression do
    begin
      Enabled := chkCompressDocument.Checked;
      Level :=
        TgtCompressionLevel(cbCompressionLevel.Items.Objects[
        cbCompressionlevel.ItemIndex]);
    end;
		FontEncoding := TgtPDFFontEncoding(cbEncoding.Items.Objects[
      cbEncoding.ItemIndex]);
    Encryption.Enabled := chkEnableEncryption.Checked;
    with Encryption do
    begin
      OwnerPassword := AnsiString(edOwnerPassword.Text);
      UserPassword := AnsiString(edUserPassword.Text);
      Level :=
        TgtPDFEncryptionLevel(cbEncryptionLevel.Items.Objects[
        cbEncryptionLevel.ItemIndex]);
      if chkCopy.Checked then
        UserPermissions := UserPermissions + [AllowCopy]
      else
        UserPermissions := UserPermissions - [AllowCopy];
      if chkModify.Checked then
        UserPermissions := UserPermissions + [AllowModify]
      else
        UserPermissions := UserPermissions - [AllowModify];
      if chkPrint.Checked then
        UserPermissions := UserPermissions + [AllowPrint]
      else
        UserPermissions := UserPermissions - [AllowPrint];
      if chkFormFill.Checked then
        UserPermissions := UserPermissions + [AllowFormFill]
      else
        UserPermissions := UserPermissions - [AllowFormFill];
      if Level = el128Bit then
      begin
        if chkAnnotation.Checked then
          UserPermissions := UserPermissions + [AllowAnnotation]
        else
          UserPermissions := UserPermissions - [AllowAnnotation];
        if chkAccessibility.Checked then
          UserPermissions := UserPermissions + [AllowAccessibility]
        else
          UserPermissions := UserPermissions - [AllowAccessibility];
        if chkDocumentAssembly.Checked then
          UserPermissions := UserPermissions + [AllowDocAssembly]
        else
          UserPermissions := UserPermissions - [AllowDocAssembly];
        if chkHighResolutionPrint.Checked then
          UserPermissions := UserPermissions + [AllowHighResPrint]
        else
          UserPermissions := UserPermissions - [AllowHighResPrint];
      end;
    end;

    with ViewerPreferences do
    begin
      PageLayout := TgtPageLayout(cbPageLayout.Items.Objects[
        cbPageLayout.ItemIndex]);
      PageMode := TgtPageMode(cbPageMode.Items.Objects[cbPageMode.ItemIndex]);
      HideMenuBar := chkMenuBar.Checked;
      HideToolBar := chkToolBar.Checked;
      HideWindowUI := chkNavigationControls.Checked;
      with PresentationMode do
      begin
        TransitionEffect :=
          TgtTransitionEffect(cbPageTransitionEffect.Items.Objects[
          cbPageTransitionEffect.ItemIndex]);
        Duration := StrToInt(edPageTransitionDuration.Text);
      end;
    end;
  end;
	inherited btnOKClick(Sender);
end;

end.
