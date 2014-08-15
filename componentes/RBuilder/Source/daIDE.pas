{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daIDE;

interface

implementation

{$R rbDADE.res}
{$R daIDEBmp.res}

uses
  ppClass, ppUtils, ppForms, ppDsIntf, ppDsgnDB,
  daDataWizard, daDataManager, daDataSettingDlg, daQueryDesigner, daQueryWizard,
  daLinkDataViewDlg;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  TppResourceManager.RegisterFileName('rbDADE');

  ppRegisterDesignModule(TdaDataManager, 'TppDesignerWindow');
  ppRegisterForm(TppCustomDataSettingsDialog, TdaDataSettingsDialog);

  daRegisterWizard(TdaQueryWizard);
  daRegisterWizard(TdaQueryDesigner);

finalization

  TppResourceManager.UnregisterFileName('rbDADE');

  ppUnRegisterDesignModule(TdaDataManager, 'TppDesignerWindow');
  ppUnRegisterForm(TppCustomDataSettingsDialog);

  daUnRegisterWizard(TdaQueryWizard);
  daUnRegisterWizard(TdaQueryDesigner);

end.
