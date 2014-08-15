{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit myChkboxDesign;

interface

{$I ppIFDef.pas}

uses
  Windows,
  Classes,
  Graphics, {contains declaration of TCanvas, used in PaintDesignControl}
  Controls, {contains declaration of mrOK, used for the CheckBox Settings dialog}
  Forms, {contains global screen object}

  ppTypes,  {contains declaration of ReportBuilder enumerated types}
  ppPopupMenus, {contains declaration of component popup menu ancestor}
  ppDesignControls, {contains DesignControlFactory used to register the checkbox design control}
  ppDesignControlsEx, {contains declaration of component design control ancestor}
  ppInspector, {object inspector categories}
  myChkBox;

type

  {Popup menu classes used to display the checkbox
   design control's context menu in the report designer}

  {@TmyCustomCheckBoxPopupMenu}
  TmyCustomCheckBoxPopupMenu = class(TppComponentPopupMenu)
    protected
      procedure CreateMenuItems; override;
  end;


  {@TmyCheckBoxPopupMenu}
  TmyCheckBoxPopupMenu = class(TmyCustomCheckBoxPopupMenu)
  end;


  {@TmyDBCheckBoxPopupMenu}
  TmyDBCheckBoxPopupMenu = class(TmyCustomCheckBoxPopupMenu)
    private
      procedure SettingsMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;


  
  {Design control classes used to display the check box
    in the report designer}

  {@TmyCustomCheckBoxControl}
  TmyCustomCheckBoxControl = class(TppCustomComponentControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@TmyCheckBoxControl}
  TmyCheckBoxControl = class(TmyCustomCheckBoxControl)
  end;


  {@TmyDBCheckBoxControl}
  TmyDBCheckBoxControl = class(TmyCustomCheckBoxControl)
  end;




implementation

uses
  myChkDlg; {allows creation of CheckStyle dialog in DBCheckBox.StyleMenuClick}


{******************************************************************************
 *
 ** C U S T O M  C H E C K B O X  P O P U P  M E N U
 *
{******************************************************************************}

procedure TmyCustomCheckBoxPopupMenu.CreateMenuItems;
begin
  inherited;

  AddItem(30, 'Checked', 'Checked', 0);
  AddItem(30, 'ReprintOnOverFlow', '',  238);
  AddItem(30, 'Transparent', '',  246);

end;


{******************************************************************************
 *
 ** D B  C H E C K B O X  P O P U P  M E N U
 *
{******************************************************************************}

procedure TmyDBCheckBoxPopupMenu.CreateMenuItems;
begin
  inherited;

  ItemByName('Checked').Free;

  {add Settings option}
  AddItem(30, 'Settings', 'Settings...',  0);

end;

procedure TmyDBCheckBoxPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {assign the OnClick event-handler for the Settings menu item}
  ItemByName('Settings').OnClick := SettingsMenuClick;

end;

{------------------------------------------------------------------------------}
{ TmyDBCheckBoxPopupMenu.SettingsMenuClick }

procedure TmyDBCheckBoxPopupMenu.SettingsMenuClick(Sender: TObject);
var
  lDialog: TfrmChkDlg;
  lStyle: TmyCheckStyleType;
  lsBooleanTrue: String;
  lsBooleanFalse: String;
begin

  GetPropValue('Style', lStyle);
  GetPropValue('BooleanTrue', lsBooleanTrue);
  GetPropValue('BooleanFalse', lsBooleanFalse);

  {create and display dialog in response to user clicking Settings... speedmenu item}
  lDialog := TfrmChkDlg.Create(nil);

  try    
{$IFDEF Delphi9}
    lDialog.PopupParent := Screen.ActiveForm;
{$ENDIF}
    lDialog.CheckStyle := lStyle;
    lDialog.BooleanTrue := lsBooleanTrue;
    lDialog.BooleanFalse := lsBooleanFalse;

    if (lDialog.ShowModal = mrOK) then
      begin
        lStyle := lDialog.CheckStyle;
        lsBooleanTrue := lDialog.BooleanTrue;
        lsBooleanFalse := lDialog.BooleanFalse;

        SetPropValue('Style', lStyle);
        SetPropValue('BooleanTrue', lsBooleanTrue);
        SetPropValue('BooleanFalse', lsBooleanFalse);
      end;

  finally
    lDialog.Free;
  end;

end;


{******************************************************************************
 *
 ** C H E C K B O X  D E S I G N  C R O N T R O L
 *
{******************************************************************************}

procedure TmyCustomCheckBoxControl.PaintDesignControl(aCanvas: TCanvas);
var
  lcChar: Char;
  lClientRect: TRect;
  lbTransparent: Boolean;
  lFont: TFont;
begin

  {this call to inherited would paint a single line border around the design control
   which we don't want for the check box component}
  {inherited PaintDesignControl(aCanvas);}

  if not (pppcDesigning in Component.DesignState) or (Component.Printing) then Exit;

  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Font', lFont);

  lClientRect := ClientRect;

  {draw background}
  if not lbTransparent then
    begin
      aCanvas.Brush.Color := GetColor;
      aCanvas.Brush.Style := bsSolid;
      aCanvas.FillRect(lClientRect);
    end;

  aCanvas.Brush.Style := bsClear;
  aCanvas.Font.CharSet := SYMBOL_CHARSET;
  aCanvas.Font.Name := 'Wingdings';
  aCanvas.Font.Color := lFont.Color;


  if (Component is TmyCustomCheckBox) then
    lcChar := TmyCustomCheckBox(Component).GetCheckCharacter
  else
    lcChar := #32;

  if (lcChar = #32) then Exit;

  aCanvas.Font.Height := Height;

  aCanvas.TextOut(0, 0, lcChar);

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  {Register Popup Menus}
  TppPopupMenuManager.RegisterMenuClass(TmyCheckBox, TmyCheckBoxPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TmyDBCheckBox, TmyDBCheckBoxPopupMenu);

  {Register Design Controls}
  TppDesignControlFactory.RegisterDesignControlClass(TmyCheckBox, TmyCheckBoxControl);
  TppDesignControlFactory.RegisterDesignControlClass(TmyDBCheckBox, TmyDBCheckBoxControl);

 // add RB object inspector category
  TppPropertyCategoryManager.PropertyCategories.Add('CheckBox');

  TppPropertyCategoryManager.PropertyCategories.ItemByName['CheckBox'].PropertyNames.Add('Checked');
  TppPropertyCategoryManager.PropertyCategories.ItemByName['CheckBox'].PropertyNames.Add('CheckboxColor');
  // note: there is already a style property in the Appearance category, so this is ignored  
//  TppPropertyCategoryManager.PropertyCategories.ItemByName['CheckBox'].PropertyNames.Add('Style');


finalization

  TppDesignControlFactory.UnRegisterDesignControlClass(TmyDBCheckBox);
  TppDesignControlFactory.UnRegisterDesignControlClass(TmyCheckBox);

  TppPopupMenuManager.UnRegisterMenuClass(TmyDBCheckBoxPopupMenu);
  TppPopupMenuManager.UnRegisterMenuClass(TmyCheckBoxPopupMenu); 

end.
