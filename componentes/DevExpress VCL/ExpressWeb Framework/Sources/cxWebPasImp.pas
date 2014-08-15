{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Pascal script importers                                     }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebPasImp;

interface

uses
  Classes, ifps3, ifpscomp, ifps3common, ifps3utl, ifpiclass, ifpiclassruntime,
  cxWebPasImpFactory;

type
  TcxWebComponentImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebControlImporter = class(TcxWebComponentImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebContainerControlImporter = class(TcxWebControlImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebStyleItemImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebStyleControllerImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebStylesImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebStyleImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebBordersImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebBorderImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNumberingImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebShadingImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebFontImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebFontSizeImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomEventsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomEventItemImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxURLImporter = class(TcxPascalScriptImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebCustomControlImporter = class(TcxWebControlImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebLabelImporter = class(TcxWebControlImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebURLLabelImporter = class(TcxWebLabelImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebEditImporter = class(TcxWebControlImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebMemoImporter = class(TcxWebControlImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebListBoxImporter = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebListItemsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebListItemImporter = class(TcxPascalScriptImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebComboBoxImporter = class(TcxWebListBoxImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebButtonImporter  = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebCheckBoxImporter = class(TcxWebControlImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebRadioGroupImporter = class(TcxWebControlImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebImageImporter = class(TcxWebControlImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebPanelImporter = class(TcxWebContainerControlImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebPopupMenuImporter = class(TcxWebComponentImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebMenuItemImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebMainMenuImporter = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebImageListImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebImagesImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebImageItemImporter = class(TcxPascalScriptImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTimerImporter = class(TcxWebComponentImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTreeViewImporter = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTreeItemImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebCalendarImporter = class(TcxWebControlImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCalendarSheetImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNavBarImporter = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNavBarGroupsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNavBarGroupImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNavBarGroupItemsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNavBarGroupItemImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDateEditImporter = class(TcxWebCalendarImporter)
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDataNavigatorImporter = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDataNavigatorButtonsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDataNavigatorButtonImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTableImporter = class(TcxWebControlImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTablePagingImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTableColumnsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTableColumnImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

implementation

uses SysUtils, TypInfo, Types, cxWebIntf,
  cxWebTypes, cxWebUtils, cxWebClasses, cxWebControls, cxWebGraphics, cxWebColors,
  cxWebStdCtrls, cxWebMenus, cxWebImgList, cxWebMainMenu, cxWebExtCtrls, cxWebTV,
  cxWebCalendar, cxWebNavBar, cxWebDateEdit, cxWebDataNavigator, cxWebTable;

procedure cxDeclareSetType(ACompiler: TIFPSPascalCompiler; TI: PTypeInfo);
var
  I: Integer;
  TD: PTypeData;
  Name: string;
begin
  if TI^.Kind <> tkSet then Exit;
  TD := GetTypeData(GetTypeData(TI)^.CompType^);
  if TD <> nil then
  for I := TD.MinValue to TD.MaxValue do
  begin
    Name := GetEnumName(GetTypeData(TI)^.CompType^, I);
    ACompiler.AddConstantN(Name, scxByteType)^.Value.tu8 := 1 shl I;
  end;
  ACompiler.AddTypeS(TI.Name, scxByteType);
end;
  
{ TcxWebComponentImporter }

class procedure TcxWebComponentImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomEvents, AObject);
end;

class function TcxWebComponentImporter.ObjectClass: TClass;
begin
  Result := TcxWebComponent;
end;

{ TcxWebControlImporter }

class procedure TcxWebControlImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('procedure Hide;');
    RegisterMethod('procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);');
    RegisterMethod('procedure Show;');

    RegisterProperty('AbsLeft', scxIntegerType, iptR);
    RegisterProperty('AbsTop', scxIntegerType, iptR);
    RegisterProperty('Attributes', scxStringsType, iptR);
    RegisterProperty('BoundsRect', 'TRect', iptRW);
    RegisterProperty('Color', 'TcxWebColor', iptR);
    RegisterProperty('ControlState', 'TcxWebControlStates', iptRW);
    RegisterProperty('ControlStyle', 'TcxWebControlStyles', iptRW);
    RegisterProperty('Font', 'TcxWebFont', iptR);
    RegisterProperty('Hint', scxStringType, iptRW);
    RegisterProperty('Parent', 'TComponent', iptRW);
    RegisterProperty('ParentBoundsRect', 'TRect', iptR);
    RegisterProperty('PopupMenu', 'TcxWebPopupMenu', iptRW);
    RegisterProperty('PopupShowingType', 'TcxPopupShowingType', iptRW);
    RegisterProperty('StyleAttributes', scxStringsType, iptR);
    RegisterProperty('Styles', 'TcxWebStyles', iptRW);
    RegisterProperty('TabOrder', 'TcxWebTabOrder', iptRW);
    RegisterProperty('TabStop', scxBooleanType, iptRW);
  end;
end;

class procedure TcxWebControlImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  cxDeclareSetType(ACompiler, TypeInfo(TcxWebControlStyles));
  cxDeclareSetType(ACompiler, TypeInfo(TcxWebControlStates));
  with ACompiler do
  begin
    AddTypeS('TcxWebCaption', scxStringType);
    AddTypeS('TcxWebColor', scxIntegerType);
    AddTypeS('TcxWebTabOrder', scxIntegerType);
    AddTypeS('TcxPopupShowingType', '(stClick, stMouseOver)');
  end;
end;

class procedure TcxWebControlImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebStyles, AObject);
  Proc(TcxWebContainerControl, AObject);
  Proc(TcxWebPopupMenu, AObject);
  Proc(TcxWebFont, AObject);
end;

class function TcxWebControlImporter.ObjectClass: TClass;
begin
  Result := TcxWebControl;
end;

procedure TcxWebControlStyles_R(ASelf: TcxWebControl; var AValue: TcxWebStyles);
begin
  AValue := ASelf.Styles;
end;

procedure TcxWebControlStyles_W(ASelf: TcxWebControl; AValue: TcxWebStyles);
begin
  ASelf.Styles := AValue;
end;

procedure TcxWebControlAbsLeft_R(ASelf: TcxWebControl; var AValue: Integer);
begin
  AValue := ASelf.AbsLeft;
end;

procedure TcxWebControlAbsTop_R(ASelf: TcxWebControl; var AValue: Integer);
begin
  AValue := ASelf.AbsTop;
end;

procedure TcxWebControlAttributes_R(ASelf: TcxWebControl; var AValue: TStrings);
begin
  AValue := ASelf.Attributes;
end;

procedure TcxWebControlBoundsRect_R(ASelf: TcxWebControl; var AValue: TRect);
begin
  AValue := ASelf.BoundsRect;
end;

procedure TcxWebControlBoundsRect_W(ASelf: TcxWebControl; AValue: TRect);
begin
  ASelf.BoundsRect := AValue;
end;

procedure TcxWebControlColor_R(ASelf: TcxWebControl; var AValue: TcxWebcolor);
begin
  AValue := ASelf.Color;
end;

procedure TcxWebControlControlState_R(ASelf: TcxWebControl; var AValue: TcxWebControlStates);
begin
  AValue := ASelf.ControlState;
end;

procedure TcxWebControlControlState_W(ASelf: TcxWebControl; AValue: TcxWebControlStates);
begin
  ASelf.ControlState := AValue;
end;

procedure TcxWebControlControlStyle_R(ASelf: TcxWebControl; var AValue: TcxWebControlStyles);
begin
  AValue := ASelf.ControlStyle;
end;

procedure TcxWebControlControlStyle_W(ASelf: TcxWebControl; AValue: TcxWebControlStyles);
begin
  ASelf.ControlStyle := AValue;
end;

procedure TcxWebControlFont_R(ASelf: TcxWebControl; var AValue: TcxWebFont);
begin
  AValue := ASelf.Font;
end;

procedure TcxWebControlHint_R(ASelf: TcxWebControl; var AValue: string);
begin
  AValue := ASelf.Hint;
end;

procedure TcxWebControlHint_W(ASelf: TcxWebControl; AValue: string);
begin
  ASelf.Hint := AValue;
end;

procedure TcxWebControlParent_R(ASelf: TcxWebControl; var AValue: TComponent);
begin
  AValue := GetComponentByInterface(ASelf.Parent);
end;

procedure TcxWebControlParent_W(ASelf: TcxWebControl; AValue: TComponent);
begin
  ASelf.Parent := AValue as IcxWebContainerControl;
end;

procedure TcxWebControlParentBoundsRect_R(ASelf: TcxWebControl; var AValue: TRect);
begin
  AValue := ASelf.ParentBoundsRect;
end;

procedure TcxWebControlPopupMenu_R(ASelf: TcxWebControl; var AValue: TcxWebPopupMenu);
begin
  AValue := ASelf.PopupMenu;
end;

procedure TcxWebControlPopupMenu_W(ASelf: TcxWebControl; AValue: TcxWebPopupMenu);
begin
  ASelf.PopupMenu := AValue;
end;

procedure TcxWebControlPopupShowingType_R(ASelf: TcxWebControl; var AValue: TcxPopupShowingType);
begin
  AValue := ASelf.PopupShowingType;
end;

procedure TcxWebControlPopupShowingType_W(ASelf: TcxWebControl; AValue: TcxPopupShowingType);
begin
  ASelf.PopupShowingType := AValue;
end;

procedure TcxWebControlStyleAttributes_R(ASelf: TcxWebControl; var AValue: TStrings);
begin
  AValue := ASelf.StyleAttributes;
end;

procedure TcxWebControlTabOrder_R(ASelf: TcxWebControl; var AValue: TcxWebTabOrder);
begin
  AValue := ASelf.TabOrder;
end;

procedure TcxWebControlTabOrder_W(ASelf: TcxWebControl; AValue: TcxWebTabOrder);
begin
  ASelf.TabOrder := AValue;
end;

procedure TcxWebControlTabStop_R(ASelf: TcxWebControl; var AValue: Boolean);
begin
  AValue := ASelf.TabStop;
end;

procedure TcxWebControlTabStop_W(ASelf: TcxWebControl; AValue: Boolean);
begin
  ASelf.TabStop := AValue;
end;

class procedure TcxWebControlImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebControl.Hide, UpperCase('Hide'));
    RegisterMethod(@TcxWebControl.SetBounds, UpperCase('SetBounds'));
    RegisterMethod(@TcxWebControl.Show, UpperCase('Show'));

    RegisterPropertyHelper(@TcxWebControlAbsLeft_R, nil, UpperCase('AbsLeft'));
    RegisterPropertyHelper(@TcxWebControlAbsTop_R, nil, UpperCase('AbsTop'));
    RegisterPropertyHelper(@TcxWebControlAttributes_R, nil, UpperCase('Attributes'));
    RegisterPropertyHelper(@TcxWebControlBoundsRect_R, @TcxWebControlBoundsRect_W, UpperCase('BoundsRect'));
    RegisterPropertyHelper(@TcxWebControlColor_R, nil, UpperCase('Color'));
    RegisterPropertyHelper(@TcxWebControlControlState_R, @TcxWebControlControlState_W, UpperCase('ControlState'));
    RegisterPropertyHelper(@TcxWebControlControlStyle_R, @TcxWebControlControlStyle_W, UpperCase('ControlStyle'));
    RegisterPropertyHelper(@TcxWebControlFont_R, nil, UpperCase('Font'));
    RegisterPropertyHelper(@TcxWebControlHint_R, @TcxWebControlHint_W, UpperCase('Hint'));
    RegisterPropertyHelper(@TcxWebControlParent_R, @TcxWebControlParent_W, UpperCase('Parent'));
    RegisterPropertyHelper(@TcxWebControlParentBoundsRect_R, nil, UpperCase('ParentBoundsRect'));
    RegisterPropertyHelper(@TcxWebControlPopupMenu_R, @TcxWebControlPopupMenu_W, UpperCase('PopupMenu'));
    RegisterPropertyHelper(@TcxWebControlPopupShowingType_R, @TcxWebControlPopupShowingType_W, UpperCase('PopupShowingType'));
    RegisterPropertyHelper(@TcxWebControlStyleAttributes_R, nil, UpperCase('StyleAttributes'));
    RegisterPropertyHelper(@TcxWebControlStyles_R, @TcxWebControlStyles_W, UpperCase('Styles'));
    RegisterPropertyHelper(@TcxWebControlTabOrder_R, @TcxWebControlTabOrder_W, UpperCase('TabOrder'));
    RegisterPropertyHelper(@TcxWebControlTabStop_R, @TcxWebControlTabStop_W, UpperCase('TabStop'));
  end;
end;

{ TcxWebContainerControlImporter }

class procedure TcxWebContainerControlImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('WebControlContainerCount', scxIntegerType, iptR);
    RegisterProperty('WebControlContainers', 'TcxWebContainerControl' + ' ' + scxIntegerType, iptR);
    RegisterProperty('WebControlCount', scxIntegerType, iptR);
    RegisterProperty('WebControls', 'TcxWebControl' + ' ' + scxIntegerType, iptR);
  end;
end;

class function TcxWebContainerControlImporter.ObjectClass: TClass;
begin
  Result := TcxWebContainerControl;
end;

procedure TcxWebContainerControlWebControlContainerCount_R(ASelf: TcxWebContainerControl; var AValue: Integer);
begin
  AValue := ASelf.WebControlContainerCount;
end;

procedure TcxWebContainerControlWebControlContainers_R(ASelf: TcxWebContainerControl; var AValue: TcxWebContainerControl; Index: Integer);
begin
  AValue := GetComponentByInterface(ASelf.WebControlContainers[Index]) as TcxWebContainerControl;
end;

procedure TcxWebContainerControlWebControlCount_R(ASelf: TcxWebContainerControl; var AValue: Integer);
begin
  AValue := ASelf.WebControlCount;
end;

procedure TcxWebContainerControlWebControls_R(ASelf: TcxWebContainerControl; var AValue: TcxWebControl; Index: Integer);
begin
  AValue := GetComponentByInterface(ASelf.WebControls[Index]) as TcxWebControl;
end;

class procedure TcxWebContainerControlImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebContainerControlWebControlContainerCount_R, nil, UpperCase('WebControlContainerCount'));
    RegisterPropertyHelper(@TcxWebContainerControlWebControlContainers_R, nil, UpperCase('WebControlContainers'));
    RegisterPropertyHelper(@TcxWebContainerControlWebControlCount_R, nil, UpperCase('WebControlCount'));
    RegisterPropertyHelper(@TcxWebContainerControlWebControls_R, nil, UpperCase('WebControls'));
  end;
end;

{ TcxWebStyleItemImporter }

class procedure TcxWebStyleItemImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Controller', 'TcxWebStyleController', iptRW);
end;

class procedure TcxWebStyleItemImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebStyle, AObject);
  Proc(TcxWebStyleController, AObject);
end;

class function TcxWebStyleItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebStyleItem;
end;

procedure TcxWebStyleItemController_R(ASelf: TcxWebStyleItem; var AValue: TcxWebStyleController);
begin
  AValue := ASelf.Controller;
end;

procedure TcxWebStyleItemController_W(ASelf: TcxWebStyleItem; AValue: TcxWebStyleController);
begin
  ASelf.Controller := AValue;
end;

class procedure TcxWebStyleItemImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebStyleItemController_R, @TcxWebStyleItemController_W, UpperCase('Controller'));
end;

{ TcxWebStyleControllerImporter }

class procedure TcxWebStyleControllerImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function Add: TcxWebStyleItem;');
    RegisterMethod('procedure Clear;');
    RegisterMethod('procedure Delete(AIndex: Integer);');
    RegisterMethod('function IndexOf(AItem: TcxWebStyleItem): Integer;');
    RegisterMethod('function ItemByName(const AName: string): TcxWebStyleItem;');

    RegisterProperty('Count', scxIntegerType, iptR);
    RegisterProperty('Items', 'TcxWebStyleItem' + ' ' + scxIntegerType, iptRW);
  end;
end;

class procedure TcxWebStyleControllerImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebStyleItem, AObject);
end;

class function TcxWebStyleControllerImporter.ObjectClass: TClass;
begin
  Result := TcxWebStyleController;
end;

procedure TcxWebStyleControllerCount_R(ASelf: TcxWebStyleController; var AValue: Integer);
begin
  AValue := ASelf.Count;
end;

procedure TcxWebStyleControllerItems_R(ASelf: TcxWebStyleController; var AValue: TcxWebStyleItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebStyleControllerItems_W(ASelf: TcxWebStyleController; AValue: TcxWebStyleItem; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebStyleControllerImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebStyleController.Add, UpperCase('Add'));
    RegisterMethod(@TcxWebStyleController.Clear, UpperCase('Clear'));
    RegisterMethod(@TcxWebStyleController.Delete, UpperCase('Delete'));
    RegisterMethod(@TcxWebStyleController.IndexOf, UpperCase('IndexOf'));
    RegisterMethod(@TcxWebStyleController.ItemByName, UpperCase('ItemByName'));

    RegisterPropertyHelper(@TcxWebStyleControllerCount_R, nil, UpperCase('Count'));
    RegisterPropertyHelper(@TcxWebStyleControllerItems_R, @TcxWebStyleControllerItems_W, UpperCase('Items'));
  end;
end;

{ TcxWebStylesImporter }

class procedure TcxWebStylesImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebStyleItem, AObject);
end;

class function TcxWebStylesImporter.ObjectClass: TClass;
begin
  Result := TcxWebStyles;
end;

{ TcxWebStyleImporter }

class procedure TcxWebStyleImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebBorders, AObject);
  Proc(TcxWebFont, AObject);
  Proc(TcxWebNumbering, AObject);
  Proc(TcxWebShading, AObject);
end;

class function TcxWebStyleImporter.ObjectClass: TClass;
begin
  Result := TcxWebStyle;
end;

{ TcxWebBordersImporter }

class procedure TcxWebBordersImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebBorder, AObject);
end;

class function TcxWebBordersImporter.ObjectClass: TClass;
begin
  Result := TcxWebBorders;
end;

{ TcxWebBorderImporter }

class procedure TcxWebBorderImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebBorderStyle',
      '(wbsNone, wbsSolid, wbsDotted, wbsDashed, wbsDouble, wbsGroove, wbsRidge,' +
      ' wbsInset, wbsOutset)');
    AddTypeS('TcxWebBorderWidth', 'Word');
    AddTypeS('TcxWebColor', scxIntegerType);
//    AddTypeS('TcxWebBorderAssignedValue', '(wbavColor, wbavStyle, wbavWidth)');
    cxDeclareSetType(ACompiler, TypeInfo(TcxWebBorderAssignedValues));
  end;
end;

class function TcxWebBorderImporter.ObjectClass: TClass;
begin
  Result := TcxWebBorder;
end;

{ TcxWebNamberingImporter }

class procedure TcxWebNumberingImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebNumberingPosition', '(wnpInside, wnpOutside)');
    AddTypeS('TcxWebNumberingStyle',
      '(wnsNone, wnsCircle, wnsDisc, wnsSquare, wnsDecimal, wnsUpperRoman,' +
      ' wnsUpperAlpha, wnsLowerAlpha, wnsLowerRoman, wnsPicture)');
//    AddTypeS('TcxWebNumberingAssignedValue', '(wnavPosition, wnavStyle)');
    cxDeclareSetType(ACompiler, TypeInfo(TcxWebNumberingAssignedValues));
  end;
end;

class function TcxWebNumberingImporter.ObjectClass: TClass;
begin
  Result := TcxWebNumbering;
end;

{ TcxWebShadingImporter }

class procedure TcxWebShadingImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebColor', scxIntegerType);
//    AddTypeS('TcxWebShadingAssignedValue', '(wsavColor)');
    cxDeclareSetType(ACompiler, TypeInfo(TcxWebShadingAssignedValues));
  end;
end;

class function TcxWebShadingImporter.ObjectClass: TClass;
begin
  Result := TcxWebShading;
end;

{ TcxWebFontImporter }

class procedure TcxWebFontImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  cxDeclareSetType(ACompiler, TypeInfo(TcxWebFontDecorations));
  with ACompiler do
  begin
    AddTypeS('TcxWebColor', scxIntegerType);
    AddTypeS('TcxWebFontStyle', '(wfsNotSet, wfsNormal, wfsItalic, wfsOblique)');
    AddTypeS('TcxWebFontTransform', '(wftNotSet, wftCapitalize, wftUppercase, wftLowercase, wftNone)');
    AddTypeS('TcxWebFontVariant', '(wfvNotSet, wfvNormal, wfvSmallCaps)');
    AddTypeS('TcxWebFontWeight',
      '(wfwNotSet, wfwNormal, wfwBold, wfwBolder, wfwLighter, wfw100, wfw200,' +
      ' wfw300, wfw400, wfw500, wfw600, wfw700, wfw800, wfw900)');
  end;
end;

class procedure TcxWebFontImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebFontSize, AObject);
end;

class function TcxWebFontImporter.ObjectClass: TClass;
begin
  Result := TcxWebFont;
end;

{ TcxWebFontSizeImporter }

class procedure TcxWebFontSizeImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebUnit',
    '(wuCentimeters, wuEm, wuEx, wuInches, wuMillimeters, wuPercentage, wuPicas,'+
    ' wuPixels, wuPoints)');
end;

class function TcxWebFontSizeImporter.ObjectClass: TClass;
begin
  Result := TcxWebFontSize;
end;

{ TcxCustomEventsImporter }

class procedure TcxCustomEventsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxCustomEventItem' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxCustomEventsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomEventItem, AObject);
end;

class function TcxCustomEventsImporter.ObjectClass: TClass;
begin
  Result := TcxCustomEvents;
end;

procedure TcxCustomEventsItems_R(ASelf: TcxCustomEvents; var AValue: TcxCustomEventItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxCustomEventsItems_W(ASelf: TcxCustomEvents; AValue: TcxCustomEventItem; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxCustomEventsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxCustomEventsItems_R, @TcxCustomEventsItems_W, UpperCase('Items'));
end;

{ TcxCustomEventItemImporter }

class procedure TcxCustomEventItemImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebComponentEventProcType', '(etSingleLine, etProcedure)');
    AddTypeS('TcxHTMLEvent',
      '(eOnBlur, eOnChange, eOnClick, eOnDblClick, eOnDragStart, eOnDragEnd,' +
      ' eOnFocus, eOnKeyPress, eOnLoad, eOnMouseDown, eOnMouseMove, eOnMouseOver,' +
      ' eOnMouseOut, eOnMouseUp, eOnSelect, eOnSelectStart, eOnUnload)');
  end;
end;

class function TcxCustomEventItemImporter.ObjectClass: TClass;
begin
  Result := TcxCustomEventItem;
end;

{ TcxURLImporter }

class function TcxURLImporter.ObjectClass: TClass;
begin
  Result := TcxURL;
end;

{ TcxWebCustomControlImporter }

class function TcxWebCustomControlImporter.ObjectClass: TClass;
begin
  Result := TcxWebCustomControl;
end;

{ TcxWebLabelImporter }

class procedure TcxWebLabelImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebHorzAlignment', '(whalLeft, whalCenter, whalRight, whalJustify, whalChar)');
end;

class function TcxWebLabelImporter.ObjectClass: TClass;
begin
  Result := TcxWebLabel;
end;

{ TcxWebURLLabelImporter }

class procedure TcxWebURLLabelImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxURL, AObject);
end;

class function TcxWebURLLabelImporter.ObjectClass: TClass;
begin
  Result := TcxWebURLLabel;
end;

{ TcxWebEditImporter }

class function TcxWebEditImporter.ObjectClass: TClass;
begin
  Result := TcxWebEdit;
end;

{ TcxWebMemoImporter }

class function TcxWebMemoImporter.ObjectClass: TClass;
begin
  Result := TcxWebMemo;
end;

{ TcxWebListBoxImporter }

class procedure TcxWebListBoxImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('procedure Clear;');
    RegisterProperty('ItemIndex', scxIntegerType, iptRW);
    RegisterProperty('ItemHeight', scxIntegerType, iptR);
    RegisterProperty('SelCount', scxIntegerType, iptR);
  end;
end;

class procedure TcxWebListBoxImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebListItems, AObject);
end;

class function TcxWebListBoxImporter.ObjectClass: TClass;
begin
  Result := TcxWebListBox;
end;

procedure TcxWebListBoxItemIndex_R(ASelf: TcxWebListBox; var AValue: Integer);
begin
  AValue := ASelf.ItemIndex;
end;

procedure TcxWebListBoxItemIndex_W(ASelf: TcxWebListBox; AValue: Integer);
begin
  ASelf.ItemIndex := AValue;
end;

procedure TcxWebListBoxItemHeight_R(ASelf: TcxWebListBox; var AValue: Integer);
begin
  AValue := ASelf.ItemHeight;
end;

procedure TcxWebListBoxSelCount_R(ASelf: TcxWebListBox; var AValue: Integer);
begin
  AValue := ASelf.SelCount;
end;

class procedure TcxWebListBoxImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebListBox.Clear, UpperCase('Clear'));
    RegisterPropertyHelper(@TcxWebListBoxItemIndex_R, @TcxWebListBoxItemIndex_W, UpperCase('ItemIndex'));
    RegisterPropertyHelper(@TcxWebListBoxItemHeight_R, nil, UpperCase('ItemHeight'));
    RegisterPropertyHelper(@TcxWebListBoxSelCount_R, nil, UpperCase('SelCount'));
  end;
end;

{ TcxWebComboBoxImporter }

class procedure TcxWebComboBoxImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Text', scxStringType, iptRW);
end;

class function TcxWebComboBoxImporter.ObjectClass: TClass;
begin
  Result := TcxWebComboBox;
end;

procedure TcxWebComboBoxText_R(ASelf: TcxWebComboBox; var AValue: string);
begin
  AValue := ASelf.Text;
end;

procedure TcxWebComboBoxText_W(ASelf: TcxWebComboBox; AValue: string);
begin
  ASelf.Text := AValue;
end;

class procedure TcxWebComboBoxImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebComboBoxText_R, @TcxWebComboBoxText_W, UpperCase('Text'));
end;

{ TcxWebListItemsImporter }

class procedure TcxWebListItemsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function IndexOfValue(const AValue: string): Integer;');
    RegisterMethod('function IndexOfText(const AText: string): Integer;');
    RegisterMethod('function TextOfValue(const AValue: string): string;');
    RegisterProperty('Items', 'TcxWebListItem' + ' ' + scxIntegerType, iptRW);
  end;
end;

class procedure TcxWebListItemsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebListItem, AObject);
end;

class function TcxWebListItemsImporter.ObjectClass: TClass;
begin
  Result := TcxWebListItems;
end;

procedure TcxWebListItemsItems_R(ASelf: TcxWebListItems; var AValue: TcxWebListItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebListItemsItems_W(ASelf: TcxWebListItems; AValue: TcxWebListItem; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebListItemsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebListItems.IndexOfValue, UpperCase('IndexOfValue'));
    RegisterMethod(@TcxWebListItems.IndexOfText, UpperCase('IndexOfText'));
    RegisterMethod(@TcxWebListItems.TextOfValue, UpperCase('TextOfValue'));
    RegisterPropertyHelper(@TcxWebListItemsItems_R, @TcxWebListItemsItems_W, UpperCase('Items'));
  end;
end;

{ TcxWebListItemImporter }

class function TcxWebListItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebListItem;
end;

{ TcxWebButtonImporter }

class procedure TcxWebButtonImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebButtonTypes', '(btButton, btSubmit, btReset, btImage)');
    AddTypeS('TcxWebButtonGlyphPosition', '(gpBeforeText, gpAfterText)');
  end;
end;

class procedure TcxWebButtonImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebImageList, AObject);
end;

class function TcxWebButtonImporter.ObjectClass: TClass;
begin
  Result := TcxWebButton;
end;

{ TcxWebCheckBoxImporter }

class function TcxWebCheckBoxImporter.ObjectClass: TClass;
begin
  Result := TcxWebCheckBox;
end;

{ TcxWebRadioGroupImporter }

class procedure TcxWebRadioGroupImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('ItemHeight', scxIntegerType, iptR);
end;

class function TcxWebRadioGroupImporter.ObjectClass: TClass;
begin
  Result := TcxWebRadioGroup;
end;

procedure TcxWebRadioGroupItemHeight_R(ASelf: TcxWebRadioGroup; var AValue: Integer);
begin
  AValue := ASelf.ItemHeight;
end;

class procedure TcxWebRadioGroupImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebRadioGroupItemHeight_R, nil, UpperCase('ItemHeight'));
end;

{ TcxCustomWebImageImporter }

class procedure TcxWebImageImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebDisplayStyle', '(wdsAutoSize, wdsProportional, wdsStretch)');
end;

class function TcxWebImageImporter.ObjectClass: TClass;
begin
  Result := TcxWebImage;
end;

{ TcxWebPanelImporter }

class function TcxWebPanelImporter.ObjectClass: TClass;
begin
  Result := TcxWebPanel;
end;

{ TcxWebPopupMenu }

class procedure TcxWebPopupMenuImporter.EnumDependentClasses(Proc: TClassEnumProc;
  AObject: TObject);
begin
  inherited;
  Proc(TcxWebMenuItem, AObject);
end;

class function TcxWebPopupMenuImporter.ObjectClass: TClass;
begin
  Result := TcxWebPopupMenu;
end;

{ TcxWebMenuItemImporter }

class procedure TcxWebMenuItemImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function Add: TcxWebMenuItem;');
    RegisterMethod('procedure Clear;');
    RegisterMethod('procedure Delete(Index: Integer);');
    RegisterMethod('function ParentMenu: TcxWebComponent;');
    RegisterMethod('function IndexOf(Item: TcxWebMenuItem): Integer;');
    RegisterMethod('procedure Insert(Index: Integer; Item: TcxWebMenuItem);');
    RegisterMethod('function ItemByName(const AName: string): TcxWebMenuItem;');
    RegisterMethod('procedure Remove(Item: TcxWebMenuItem);');

    RegisterProperty('Count', scxIntegerType, iptR);
    RegisterProperty('VisibleItemCount', scxIntegerType, iptR);
    RegisterProperty('Items', 'TcxWebMenuItem' + ' ' + scxIntegerType, iptR);
    RegisterProperty('Index', scxIntegerType, iptRW);
    RegisterProperty('Parent', 'TcxWebMenuItem', iptR);
  end;
end;

class procedure TcxWebMenuItemImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebMenuBreak', '(mbNone, mbBreak)');
    AddTypeS('TcxWebMenuAlign', '(maLeft, maCenter, maRight)');
    AddTypeS('TcxWebMenuPopupType', '(ptToLeft, ptToRight)');
  end;
end;

class procedure TcxWebMenuItemImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxURL, AObject);
end;

class function TcxWebMenuItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebMenuItem;
end;

procedure TcxWebMenuItemCount_R(ASelf: TcxWebMenuItem; var AValue: Integer);
begin
  AValue := ASelf.Count;
end;

procedure TcxWebMenuItemVisibleItemCount_R(ASelf: TcxWebMenuItem; var AValue: Integer);
begin
  AValue := ASelf.VisibleItemCount;
end;

procedure TcxWebMenuItemItems_R(ASelf: TcxWebMenuItem; var AValue: TcxWebMenuItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebMenuItemIndex_R(ASelf: TcxWebMenuItem; var AValue: Integer);
begin
  AValue := ASelf.Index;
end;

procedure TcxWebMenuItemIndex_W(ASelf: TcxWebMenuItem; AValue: Integer);
begin
  ASelf.Index := AValue;
end;

procedure TcxWebMenuItemParent_R(ASelf: TcxWebMenuItem; var AValue: TcxWebMenuItem);
begin
  AValue := ASelf.Parent;
end;

class procedure TcxWebMenuItemImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebMenuItem.Add, UpperCase('Add'));
    RegisterMethod(@TcxWebMenuItem.Clear, UpperCase('Clear'));
    RegisterMethod(@TcxWebMenuItem.Delete, UpperCase('Delete'));
    RegisterMethod(@TcxWebMenuItem.ParentMenu, UpperCase('ParentMenu'));
    RegisterMethod(@TcxWebMenuItem.IndexOf, UpperCase('IndexOf'));
    RegisterMethod(@TcxWebMenuItem.Insert, UpperCase('Insert'));
    RegisterMethod(@TcxWebMenuItem.ItemByName, UpperCase('ItemByName'));
    RegisterMethod(@TcxWebMenuItem.Remove, UpperCase('Remove'));

    RegisterPropertyHelper(@TcxWebMenuItemCount_R, nil, UpperCase('Count'));
    RegisterPropertyHelper(@TcxWebMenuItemVisibleItemCount_R, nil, UpperCase('VisibleItemCount'));
    RegisterPropertyHelper(@TcxWebMenuItemItems_R, nil, UpperCase('Items'));
    RegisterPropertyHelper(@TcxWebMenuItemIndex_R, @TcxWebMenuItemIndex_W, UpperCase('Index'));
    RegisterPropertyHelper(@TcxWebMenuItemParent_R, nil, UpperCase('Parent'));
  end;
end;

{ TcxWebImageListImporter }

class procedure TcxWebImageListImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebImages, AObject);
end;

class function TcxWebImageListImporter.ObjectClass: TClass;
begin
  Result := TcxWebImageList;
end;

{ TcxWebImagesImporter }

class procedure TcxWebImagesImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxWebImageItem' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxWebImagesImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebImageItem, AObject);
end;

class function TcxWebImagesImporter.ObjectClass: TClass;
begin
  Result := TcxWebImages;
end;

procedure TcxWebImagesItems_R(ASelf: TcxWebImages; var AValue: TcxWebImageItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebImagesItems_W(ASelf: TcxWebImages; AValue: TcxWebImageItem; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebImagesImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebImagesItems_R, @TcxWebImagesItems_W, UpperCase('Items'));
end;

{ TcxWebImageItemImporter }

class function TcxWebImageItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebImageItem;
end;

{ TcxWebMainMenuImporter }

class procedure TcxWebMainMenuImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterMethod('function ItemByName(const AName: string): TcxWebMenuItem;');
end;

class procedure TcxWebMainMenuImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebMenuItem, AObject);
  Proc(TcxWebImageList, AObject);
end;

class function TcxWebMainMenuImporter.ObjectClass: TClass;
begin
  Result := TcxWebMainMenu;
end;

class procedure TcxWebMainMenuImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterMethod(@TcxWebMainMenu.ItemByName, UpperCase('ItemByName'));
end;

{ TcxWebTimerImporter }

class function TcxWebTimerImporter.ObjectClass: TClass;
begin
  Result := TcxWebTimer;
end;

{ TcxWebTreeViewImporter }

class procedure TcxWebTreeViewImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function AddItem: TcxWebTreeItem;');
    RegisterMethod('procedure Clear;');
    RegisterMethod('procedure FullCollapse;');
    RegisterMethod('procedure FullExpand;');
    RegisterMethod('function ItemByName(const AName: string): TcxWebTreeItem;');
    RegisterMethod('procedure Sort;');

    RegisterProperty('Items', 'TcxWebTreeItem', iptR);
  end;
end;

class procedure TcxWebTreeViewImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebTreeItem, AObject);
  Proc(TcxWebImageList, AObject);
end;

class function TcxWebTreeViewImporter.ObjectClass: TClass;
begin
  Result := TcxWebTreeView;
end;

procedure TcxWebTreeViewItems_R(ASelf: TcxWebTreeView; var AValue: TcxWebTreeItem);
begin
  AValue := ASelf.Items;
end;

class procedure TcxWebTreeViewImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebTreeView.AddItem, UpperCase('AddItem'));
    RegisterMethod(@TcxWebTreeView.Clear, UpperCase('Clear'));
    RegisterMethod(@TcxWebTreeView.FullCollapse, UpperCase('FullCollapse'));
    RegisterMethod(@TcxWebTreeView.FullExpand, UpperCase('FullExpand'));
    RegisterMethod(@TcxWebTreeView.ItemByName, UpperCase('ItemByName'));
    RegisterMethod(@TcxWebTreeView.Sort, UpperCase('Sort'));

    RegisterPropertyHelper(@TcxWebTreeViewItems_R, nil, UpperCase('Items'));
  end;
end;

{ TcxWebTreeItemImporter }

class procedure TcxWebTreeItemImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function AddChild: TcxWebTreeItem;');
    RegisterMethod('procedure Collapse(ARecurse: Boolean);');
    RegisterMethod('procedure DeleteChildren;');
    RegisterMethod('procedure Expand(ARecurse: Boolean);');
    RegisterMethod('function IndexOf(Value: TcxWebTreeItem): Integer;');
    RegisterMethod('function InsertChild(BeforeItem: TcxWebTreeItem): TcxWebTreeItem;');

    RegisterProperty('Count', scxIntegerType, iptR);
    RegisterProperty('Data', 'Pointer', iptRW);
    RegisterProperty('HasChildren', scxBooleanType, iptR);
    RegisterProperty('Index', scxIntegerType, iptR);
    RegisterProperty('Items', 'TcxWebTreeItem' + ' ' + scxIntegerType, iptR);
    RegisterProperty('Level', scxIntegerType, iptR);
    RegisterProperty('Owner', 'TcxWebTreeView', iptR);
    RegisterProperty('Parent', 'TcxWebTreeItem', iptR);
  end;
end;

class procedure TcxWebTreeItemImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxURL, AObject);
  Proc(TcxWebTreeView, AObject);
end;

class function TcxWebTreeItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebTreeItem;
end;

procedure TcxWebTreeItemCount_R(ASelf: TcxWebTreeItem; var AValue: Integer);
begin
  AValue := ASelf.Count;
end;

procedure TcxWebTreeItemData_R(ASelf: TcxWebTreeItem; var AValue: Pointer);
begin
  AValue := ASelf.Data;
end;

procedure TcxWebTreeItemData_W(ASelf: TcxWebTreeItem; AValue: Pointer);
begin
  ASelf.Data := AValue;
end;

procedure TcxWebTreeItemHasChildren_R(ASelf: TcxWebTreeItem; var AValue: Boolean);
begin
  AValue := ASelf.HasChildren;
end;

procedure TcxWebTreeItemIndex_R(ASelf: TcxWebTreeItem; var AValue: Integer);
begin
  AValue := ASelf.Index;
end;

procedure TcxWebTreeItemItems_R(ASelf: TcxWebTreeItem; var AValue: TcxWebTreeItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebTreeItemLevel_R(ASelf: TcxWebTreeItem; var AValue: Integer);
begin
  AValue := ASelf.Level;
end;

procedure TcxWebTreeItemOwner_R(ASelf: TcxWebTreeItem; var AValue: TcxWebTreeView);
begin
  AValue := ASelf.Owner;
end;

procedure TcxWebTreeItemParent_R(ASelf: TcxWebTreeItem; var AValue: TcxWebTreeItem);
begin
  AValue := ASelf.Parent;
end;

class procedure TcxWebTreeItemImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebTreeItem.AddChild, UpperCase('AddChild'));
    RegisterMethod(@TcxWebTreeItem.Collapse, UpperCase('Collapse'));
    RegisterMethod(@TcxWebTreeItem.DeleteChildren, UpperCase('DeleteChildren'));
    RegisterMethod(@TcxWebTreeItem.Expand, UpperCase('Expand'));
    RegisterMethod(@TcxWebTreeItem.IndexOf, UpperCase('IndexOf'));
    RegisterMethod(@TcxWebTreeItem.InsertChild, UpperCase('InsertChild'));

    RegisterPropertyHelper(@TcxWebTreeItemCount_R, nil, UpperCase('Count'));
    RegisterPropertyHelper(@TcxWebTreeItemData_R, @TcxWebTreeItemData_W, UpperCase('Data')); 
    RegisterPropertyHelper(@TcxWebTreeItemHasChildren_R, nil, UpperCase('HasChildren'));
    RegisterPropertyHelper(@TcxWebTreeItemIndex_R, nil, UpperCase('Index'));
    RegisterPropertyHelper(@TcxWebTreeItemItems_R, nil, UpperCase('Items'));
    RegisterPropertyHelper(@TcxWebTreeItemLevel_R, nil, UpperCase('Level'));
    RegisterPropertyHelper(@TcxWebTreeItemOwner_R, nil, UpperCase('Owner'));
    RegisterPropertyHelper(@TcxWebTreeItemParent_R, nil, UpperCase('Parent'));
  end;
end;

{ TcxWebCalendarImporter }

class procedure TcxWebCalendarImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('CalendarSheet', 'TcxCalendarSheet', iptR);
    RegisterProperty('DaysOfWeekNames', scxStringType + ' ' + scxIntegerType, iptR);
    RegisterProperty('MonthNames', scxStringType + ' ' + scxIntegerType, iptR);
    RegisterProperty('SelectedDate', scxDateTimeType, iptRW);
  end;
end;

class procedure TcxWebCalendarImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebHorzAlignment', '(whalLeft, whalCenter, whalRight, whalJustify, whalChar)');
    AddTypeS('TcxWebDayNameFormat', '(dfFull, dfShort, dfFirstLetter, dfFirstTwoLetters)');
    AddTypeS('TcxFirstDayOfWeek', '(dowSunday, dowMonday, dowTuesday, dowWednesday, dowThursday,' +
             ' dowFriday, dowSaturday, dowLocaleDefault)');
    AddTypeS('TcxWebMonthNameFormat', '(mfFull, mfShort)');
  end;
end;

class procedure TcxWebCalendarImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCalendarSheet, AObject);
  Proc(TcxWebImageList, AObject);
end;

class function TcxWebCalendarImporter.ObjectClass: TClass;
begin
  Result := TcxWebCalendar;
end;

procedure TcxWebCalendarCalendarSheet_R(ASelf: TcxWebCalendar; var AValue: TcxCalendarSheet);
begin
  AValue := ASelf.CalendarSheet;
end;

procedure TcxWebCalendarDaysOfWeekNames_R(ASelf: TcxWebCalendar; var AValue: string; Index: Integer);
begin
  AValue := ASelf.DaysOfWeekNames[Index];
end;

procedure TcxWebCalendarMonthNames_R(ASelf: TcxWebCalendar; var AValue: string; Index: Integer);
begin
  AValue := ASelf.MonthNames[Index];
end;

procedure TcxWebCalendarSelectedDate_R(ASelf: TcxWebCalendar; var AValue: TDateTime);
begin
  AValue := ASelf.SelectedDate;
end;

procedure TcxWebCalendarSelectedDate_W(ASelf: TcxWebCalendar; AValue: TDateTime);
begin
  ASelf.SelectedDate := AValue;
end;

class procedure TcxWebCalendarImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebCalendarCalendarSheet_R, nil, UpperCase('CalendarSheet'));
    RegisterPropertyHelper(@TcxWebCalendarDaysOfWeekNames_R, nil, UpperCase('DaysOfWeekNames'));
    RegisterPropertyHelper(@TcxWebCalendarMonthNames_R, nil, UpperCase('MonthNames'));
    RegisterPropertyHelper(@TcxWebCalendarSelectedDate_R, @TcxWebCalendarSelectedDate_W, UpperCase('SelectedDate'));
  end;
end;

{ TcxCalendarSheetImporter }

class procedure TcxCalendarSheetImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Date', scxDateTimeType, iptRW);
    RegisterProperty('Dates', scxDateTimeType + ' ' + scxIntegerType, iptR);
    RegisterProperty('DayCount', scxIntegerType, iptR);
    RegisterProperty('Days', scxIntegerType + ' ' + scxIntegerType, iptR);
    RegisterProperty('Month', 'Word', iptR);
    RegisterProperty('EndOfWeek', scxIntegerType, iptR);
    RegisterProperty('StartOfWeek', scxIntegerType, iptRW);
    RegisterProperty('Year', 'Word', iptR);
  end;
end;

class function TcxCalendarSheetImporter.ObjectClass: TClass;
begin
  Result := TcxCalendarSheet;
end;

procedure TcxCalendarSheetDate_R(ASelf: TcxCalendarSheet; var AValue: TDateTime);
begin
  AValue := ASelf.Date;
end;

procedure TcxCalendarSheetDate_W(ASelf: TcxCalendarSheet; AValue: TDateTime);
begin
  ASelf.Date := AValue;
end;

procedure TcxCalendarSheetDates_R(ASelf: TcxCalendarSheet; var AValue: TDateTime; Index: Integer);
begin
  AValue := ASelf.Dates[Index];
end;

procedure TcxCalendarSheetDayCount_R(ASelf: TcxCalendarSheet; var AValue: Integer);
begin
  AValue := ASelf.DayCount;
end;

procedure TcxCalendarSheetDays_R(ASelf: TcxCalendarSheet; var AValue: Integer; Index: Integer);
begin
  AValue := ASelf.Days[Index];
end;

procedure TcxCalendarSheetMonth_R(ASelf: TcxCalendarSheet; var AValue: Word);
begin
  AValue := ASelf.Month;
end;

procedure TcxCalendarSheetEndOfWeek_R(ASelf: TcxCalendarSheet; var AValue: Integer);
begin
  AValue := ASelf.EndOfWeek;
end;

procedure TcxCalendarSheetStartOfWeek_R(ASelf: TcxCalendarSheet; var AValue: Integer);
begin
  AValue := ASelf.StartOfWeek;
end;

procedure TcxCalendarSheetStartOfWeek_W(ASelf: TcxCalendarSheet; AValue: Integer);
begin
  ASelf.StartOfWeek := AValue;
end;

procedure TcxCalendarSheetYear_R(ASelf: TcxCalendarSheet; var AValue: Word);
begin
  AValue := ASelf.Year;
end;

class procedure TcxCalendarSheetImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxCalendarSheetDate_R, @TcxCalendarSheetDate_W, UpperCase('Date'));
    RegisterPropertyHelper(@TcxCalendarSheetDates_R, nil, UpperCase('Dates'));
    RegisterPropertyHelper(@TcxCalendarSheetDayCount_R, nil, UpperCase('DayCount'));
    RegisterPropertyHelper(@TcxCalendarSheetDays_R, nil, UpperCase('Days'));
    RegisterPropertyHelper(@TcxCalendarSheetMonth_R, nil, UpperCase('Month'));
    RegisterPropertyHelper(@TcxCalendarSheetEndOfWeek_R, nil, UpperCase('EndOfWeek'));
    RegisterPropertyHelper(@TcxCalendarSheetStartOfWeek_R, @TcxCalendarSheetStartOfWeek_W, UpperCase('StartOfWeek'));
    RegisterPropertyHelper(@TcxCalendarSheetYear_R, nil, UpperCase('Year'));
  end;
end;

{ TcxWebNavBarImporter }

class procedure TcxWebNavBarImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebImageList, AObject);
  Proc(TcxWebNavBarGroups, AObject);  
end;

class function TcxWebNavBarImporter.ObjectClass: TClass;
begin
  Result := TcxWebNavBar;
end;

{ TcxWebNavBarGroups }

class procedure TcxWebNavBarGroupsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('WebNavBar', 'TcxWebNavBar', iptR);
    RegisterProperty('Items', 'TcxWebNavBarGroup' + ' ' + scxIntegerType, iptRW);
  end;
end;

class procedure TcxWebNavBarGroupsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebNavBarGroup, AObject);
  Proc(TcxWebNavBar, AObject);
end;

class function TcxWebNavBarGroupsImporter.ObjectClass: TClass;
begin
  Result := TcxWebNavBarGroups;
end;

procedure TcxWebNavBarGroupsWebNavBar_R(ASelf: TcxWebNavBarGroups; var AValue: TcxWebNavBar);
begin
  AValue := ASelf.WebNavBar;
end;

procedure TcxWebNavBarGroupsItems_R(ASelf: TcxWebNavBarGroups; var AValue: TcxWebNavBarGroup; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebNavBarGroupsItems_W(ASelf: TcxWebNavBarGroups; AValue: TcxWebNavBarGroup; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebNavBarGroupsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebNavBarGroupsWebNavBar_R, nil, UpperCase('WebNavBar'));
    RegisterPropertyHelper(@TcxWebNavBarGroupsItems_R, @TcxWebNavBarGroupsItems_W, UpperCase('Items'));
  end;
end;

{ TcxWebNavBarGroupImporter }

class procedure TcxWebNavBarGroupImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebNavBarGroupItems, AObject);
end;

class function TcxWebNavBarGroupImporter.ObjectClass: TClass;
begin
  Result := TcxWebNavBarGroup;
end;

{ TcxWebNavBarGroupItemsImporter }

class procedure TcxWebNavBarGroupItemsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('WebNavBarGroup', 'TcxWebNavBarGroup', iptR);
    RegisterProperty('Items', 'TcxWebNavBarGroupItem' + ' ' + scxIntegerType, iptRW);
  end;
end;

class procedure TcxWebNavBarGroupItemsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebNavBarGroup, AObject);
  Proc(TcxWebNavBarGroupItem, AObject);
end;

class function TcxWebNavBarGroupItemsImporter.ObjectClass: TClass;
begin
  Result := TcxWebNavBarGroupItems;
end;


procedure TcxWebNavBarGroupItemsWebNavBarGroup_R(ASelf: TcxWebNavBarGroupItems; var AValue: TcxWebNavBarGroup);
begin
  AValue := ASelf.WebNavBarGroup;
end;

procedure TcxWebNavBarGroupItemsItems_R(ASelf: TcxWebNavBarGroupItems; var AValue: TcxWebNavBarGroupItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebNavBarGroupItemsItems_W(ASelf: TcxWebNavBarGroupItems; AValue: TcxWebNavBarGroupItem; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebNavBarGroupItemsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebNavBarGroupItemsWebNavBarGroup_R, nil, UpperCase('WebNavBarGroup'));
    RegisterPropertyHelper(@TcxWebNavBarGroupItemsItems_R, @TcxWebNavBarGroupItemsItems_W, UpperCase('Items'));
  end;
end;

{ TcxWebNavBarGroupItemImporter }

class procedure TcxWebNavBarGroupItemImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxURL, AObject);
end;

class function TcxWebNavBarGroupItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebNavBarGroupItem;
end;

{ TcxWebDateEditImporter }

class function TcxWebDateEditImporter.ObjectClass: TClass;
begin
  Result := TcxWebDateEdit;
end;

{ TcxCustomWebDataNavigatorImporter }

class procedure TcxCustomWebDataNavigatorImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataNavigatorButtons, AObject);
  Proc(TcxWebImageList, AObject);
end;

class function TcxCustomWebDataNavigatorImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataNavigator;
end;

{ TcxWebDataNavigatorButtonsImporter }

class procedure TcxWebDataNavigatorButtonsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Navigator', 'TcxCustomWebDataNavigator', iptR);
    RegisterProperty('Items', 'TcxWebDataNavigatorButton' + ' ' + scxIntegerType, iptRW);
  end;
end;

class procedure TcxWebDataNavigatorButtonsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataNavigator, AObject);
  Proc(TcxWebDataNavigatorButton, AObject);
end;

class function TcxWebDataNavigatorButtonsImporter.ObjectClass: TClass;
begin
  Result := TcxWebDataNavigatorButtons;
end;

procedure TcxWebDataNavigatorButtonsNavigator_R(ASelf: TcxWebDataNavigatorButtons; var AValue: TcxCustomWebDataNavigator);
begin
  AValue := ASelf.Navigator;
end;

procedure TcxWebDataNavigatorButtonsItems_R(ASelf: TcxWebDataNavigatorButtons; var AValue: TcxWebDataNavigatorButton; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebDataNavigatorButtonsItems_W(ASelf: TcxWebDataNavigatorButtons; AValue: TcxWebDataNavigatorButton; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebDataNavigatorButtonsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebDataNavigatorButtonsNavigator_R, nil, UpperCase('Navigator'));
    RegisterPropertyHelper(@TcxWebDataNavigatorButtonsItems_R, @TcxWebDataNavigatorButtonsItems_W, UpperCase('Items'));
  end;
end;

{ TcxWebDataNavigatorButtonImporter }

class procedure TcxWebDataNavigatorButtonImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebNavigatorButtonType', '(nbFirst, nbPrevPage, nbPrev,' +
                     ' nbPageSize, nbApplyPageSize, nbNext, nbNextPage, nbLast,' +
                     ' nbInsert, nbEdit, nbDelete, nbPost, nbCancel, nbRefresh, nbCustom)');
end;

class procedure TcxWebDataNavigatorButtonImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataNavigatorButtons, AObject);
end;

class function TcxWebDataNavigatorButtonImporter.ObjectClass: TClass;
begin
  Result := TcxWebDataNavigatorButton;
end;

{ TcxWebTableImporter }

class procedure TcxWebTableImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Columns', 'TcxWebTableColumns', iptR);
    RegisterProperty('Paging', 'TcxWebTablePaging', iptRW);
  end;
end;

class procedure TcxWebTableImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebTableColumns, AObject);
  Proc(TcxWebTablePaging, AObject);
end;

class function TcxWebTableImporter.ObjectClass: TClass;
begin
  Result := TcxWebTable;
end;

procedure TcxWebTableColumns_R(ASelf: TcxWebTable; var AValue: TcxWebTableColumns);
begin
  AValue := ASelf.Columns;
end;

procedure TcxWebTablePaging_R(ASelf: TcxWebTable; var AValue: TcxWebTablePaging);
begin
  AValue := ASelf.Paging;
end;

procedure TcxWebTablePaging_W(ASelf: TcxWebTable; AValue: TcxWebTablePaging);
begin
  ASelf.Paging := AValue;
end;

class procedure TcxWebTableImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebTableColumns_R, nil, UpperCase('Columns'));
    RegisterPropertyHelper(@TcxWebTablePaging_R, @TcxWebTablePaging_W, UpperCase('Paging'));
  end;
end;

{ TcxWebTablePagingImporter }

class procedure TcxWebTablePagingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function StartPageIndex: Integer;');
    RegisterMethod('function EndPageIndex: Integer;');
    RegisterMethod('function MaxPageIndex: Integer;');
  end;
end;

class procedure TcxWebTablePagingImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebHorzAlignment', '(whalLeft, whalCenter, whalRight, whalJustify, whalChar)');
    AddTypeS('TcxWebTablePagingType', '(tptNone, tptBottom, tptTop, tptBoth)');
  end;
end;

class function TcxWebTablePagingImporter.ObjectClass: TClass;
begin
  Result := TcxWebTablePaging;
end;

class procedure TcxWebTablePagingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebTablePaging.StartPageIndex, UpperCase('StartPageIndex'));
    RegisterMethod(@TcxWebTablePaging.EndPageIndex, UpperCase('EndPageIndex'));
    RegisterMethod(@TcxWebTablePaging.MaxPageIndex, UpperCase('MaxPageIndex'));
  end;
end;

{ TcxWebTableColumnsImporter }

class procedure TcxWebTableColumnsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxWebTableColumn' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxWebTableColumnsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebTableColumn, AObject);
end;

class function TcxWebTableColumnsImporter.ObjectClass: TClass;
begin
  Result := TcxWebTableColumns;
end;

procedure TcxWebTableColumnsItems_R(ASelf: TcxWebTableColumns; var AVAlue: TcxWebTableColumn; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebTableColumnsItems_W(ASelf: TcxWebTableColumns; AVAlue: TcxWebTableColumn; Index: Integer);
begin
  ASelf.Items[Index] := AVAlue;
end;

class procedure TcxWebTableColumnsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebTableColumnsItems_R, @TcxWebTableColumnsItems_W, UpperCase('Items'));
end;

{ TcxWebTableColumnImporter }

class procedure TcxWebTableColumnImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  with ACompiler do
  begin
    AddTypeS('TcxWebTableColumnViewType', '(tvtText, tvtHyperText, tvtImage)');
    AddTypeS('TcxWebTableColumnSortMode', '(tsmNone, tsmAscending, tsmDescending)');
  end;
end;

class procedure TcxWebTableColumnImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebTableColumns, AObject);
end;

class function TcxWebTableColumnImporter.ObjectClass: TClass;
begin
  Result := TcxWebTableColumn;
end;

initialization
  cxPasScriptImpFactory.RegisterImporter(TcxWebComponentImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebControlImporter, 'WebControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebContainerControlImporter, 'WebControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebStyleItemImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebStyleControllerImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebStylesImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebStyleImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebBordersImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebBorderImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNumberingImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebShadingImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebFontImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebFontSizeImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomEventsImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomEventItemImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxURLImporter, 'WebClasses');
  cxPasScriptImpFactory.RegisterImporter(TcxWebCustomControlImporter, 'WebControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebLabelImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebURLLabelImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebEditImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebMemoImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebListBoxImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebComboBoxImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebListItemsImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebListItemImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebButtonImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebCheckBoxImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebRadioGroupImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebImageImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebPanelImporter, 'WebStdControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebPopupMenuImporter, 'WebMenus');
  cxPasScriptImpFactory.RegisterImporter(TcxWebMenuItemImporter, 'WebMenus');
  cxPasScriptImpFactory.RegisterImporter(TcxWebMainMenuImporter, 'WebMenus');
  cxPasScriptImpFactory.RegisterImporter(TcxWebImageListImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebImagesImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebImageItemImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTimerImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTreeViewImporter, 'WebTreeView');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTreeItemImporter, 'WebTreeView');
  cxPasScriptImpFactory.RegisterImporter(TcxWebCalendarImporter, 'WebCalendar');
  cxPasScriptImpFactory.RegisterImporter(TcxCalendarSheetImporter, 'WebCalendar');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNavBarImporter, 'WebNavBar');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNavBarGroupsImporter, 'WebNavBar');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNavBarGroupImporter, 'WebNavBar');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNavBarGroupItemsImporter, 'WebNavBar');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNavBarGroupItemImporter, 'WebNavBar');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDateEditImporter, 'WebAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDataNavigatorImporter, 'WebDataNavigator');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDataNavigatorButtonsImporter, 'WebDataNavigator');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDataNavigatorButtonImporter, 'WebDataNavigator');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTableImporter, 'WebTable');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTableColumnImporter, 'WebTable');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTableColumnsImporter, 'WebTable');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTablePagingImporter, 'WebTable');

end.
