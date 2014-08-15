
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressPageControl                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSPAGECONTROL AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxPCReg;

{$I cxVer.inc}

interface

procedure Register;

implementation

uses
  DesignEditors, DesignIntf, DesignMenus,
  Classes, Forms, SysUtils, dxCore, cxPC, cxPCConsts, cxPCPaintersFactory,
  dxCoreReg, cxLibraryReg;

const
  cxPCMajorVersion = '2';
  cxPCProductName = 'ExpressPageControl Suite';
  cxPageControlComponentEditorVerbA: array[0 .. 3] of string = (
    'New Page',
    'Next Page',
    'Previous Page',
    'Delete Page'
  );

type
  { TcxPCStyleProperty }

  TcxPCStyleProperty = class(TOrdinalProperty)
  private
    class procedure OutError(SourceMethodName, Msg: string);
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxTabControlComponentEditor }

  TcxTabControlComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
  end;

  { TcxPageControlActivePageProperty }

  TcxPageControlActivePageProperty = class(TComponentProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TcxPageControlComponentEditor }

  TcxPageControlComponentEditor = class(TcxTabControlComponentEditor)
  private
    function GetPageControl: TcxPageControl;
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;

    procedure AddPage;
    procedure NextPage(GoForward: Boolean);
    property PageControl: TcxPageControl read GetPageControl;
  public
    procedure Edit; override;
    procedure PrepareItem(Index: Integer; const AItem: TDesignMenuItem); override;
  end;

  { TcxTabControlSelectionEditor }

  TcxTabControlSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

{ TcxPCStyleProperty }

function TcxPCStyleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paSortList, paValueList];
end;

function TcxPCStyleProperty.GetValue: string;
begin
  Result := GetPCStyleName(GetOrdValue);
end;

procedure TcxPCStyleProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc(cxPCDefaultStyleName);
  for I := 0 to PaintersFactory.PainterClassCount - 1 do
    Proc(PaintersFactory.PainterClasses[I].GetStyleName);
end;

class procedure TcxPCStyleProperty.OutError(SourceMethodName, Msg: string);
begin
  raise EdxException.Create('TcxPCStyleProperty.' + SourceMethodName + ': ' + Msg);
end;

procedure TcxPCStyleProperty.SetValue(const Value: string);
var
  PainterClass: TcxPCPainterClass;
begin
  if Value = cxPCDefaultStyleName then
    SetOrdValue(cxPCDefaultStyle)
  else
  begin
    PainterClass := PaintersFactory.GetPainterClass(Value);
    if PainterClass = nil then
      OutError('SetValue', Format(scxPCStyleNameError, [Value]))
    else
      SetOrdValue(PainterClass.GetStyleID);
  end;
end;

{ TcxTabControlComponentEditor }

function TcxTabControlComponentEditor.GetProductMajorVersion: string;
begin
  Result := cxPCMajorVersion;
end;

function TcxTabControlComponentEditor.GetProductName: string;
begin
  Result := cxPCProductName; 
end;

{ TcxPageControlActivePageProperty }

function TcxPageControlActivePageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TcxPageControlActivePageProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Component: TComponent;
begin
  for I := 0 to Designer.GetRoot.ComponentCount - 1 do
  begin
    Component := Designer.GetRoot.Components[I];
    if (Component.Name <> '') and (Component is TcxTabSheet) and
       (TcxTabSheet(Component).PageControl = GetComponent(0)) then
      Proc(Component.Name);
  end;
end;

{ TcxPageControlComponentEditor }

procedure TcxPageControlComponentEditor.Edit;
begin
end;

procedure TcxPageControlComponentEditor.PrepareItem(Index: Integer;
  const AItem: TDesignMenuItem);
begin
  inherited PrepareItem(Index, AItem);
  if (Index > 0) and (Index < GetVerbCount - 3) then
    if Index < 3 then
      AItem.Enabled := PageControl.PageCount > 1
    else
      AItem.Enabled := Component is TcxTabSheet;
end;

function TcxPageControlComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := cxPageControlComponentEditorVerbA[AIndex];
end;

function TcxPageControlComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := Length(cxPageControlComponentEditorVerbA);
end;

procedure TcxPageControlComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  case AIndex of
    0: AddPage;
    1: NextPage(True);
    2: NextPage(False);
    3: if (PageControl.ActivePage <> nil) then
       begin
         Designer.SelectComponent(PageControl);
         PageControl.ActivePage.Free;
       end;
  end;
end;

procedure TcxPageControlComponentEditor.AddPage;
var
  Page: TcxTabSheet;
begin
  Page := TcxTabSheet.Create(Designer.GetRoot);
  Page.Name := Designer.UniqueName(TcxTabSheet.ClassName);
  Page.PageControl := PageControl;
  Page.ImageIndex := Page.TabIndex;
  PageControl.ActivePage := Page;
  Designer.SelectComponent(Page);
end;

procedure TcxPageControlComponentEditor.NextPage(GoForward: Boolean);
var
  APrevActivePage: TcxTabSheet;
begin
  APrevActivePage := PageControl.ActivePage;
  PageControl.SelectNextPage(GoForward, False);
  if PageControl.ActivePage <> APrevActivePage then
    Designer.SelectComponent(PageControl.ActivePage);
end;

function TcxPageControlComponentEditor.GetPageControl: TcxPageControl;
begin
  if Component is TcxPageControl then
    Result := TcxPageControl(Component)
  else
    Result := TcxTabSheet(Component).PageControl;
end;

{ TcxTabControlSelectionEditor }

procedure TcxTabControlSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  dxSkinsRequiresAdditionalUnits(TcxCustomTabControl, Proc);
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  

  RegisterComponents(dxCoreLibraryProductPage, [TcxTabControl, TcxPageControl]);

  RegisterComponentEditor(TcxTabControl, TcxTabControlComponentEditor);
  RegisterComponentEditor(TcxPageControl, TcxPageControlComponentEditor);
  RegisterComponentEditor(TcxTabSheet, TcxPageControlComponentEditor);

  RegisterSelectionEditor(TcxCustomTabControl, TcxTabControlSelectionEditor);

  RegisterPropertyEditor(TypeInfo(TcxPCStyleID), nil, '', TcxPCStyleProperty);
  RegisterPropertyEditor(TypeInfo(TcxTabSheet), TcxPageControl, 'ActivePage', TcxPageControlActivePageProperty);

  RegisterClass(TcxTabSheet);
end;

end.
