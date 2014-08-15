{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressSpellChecker                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPELLCHECKER AND ALL           }
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

unit dxSpellCheckerReg;

{$I cxVer.inc}

interface

uses
  ColnEdit, VCLEditors, Types, Classes, SysUtils, DesignIntf, DesignEditors,
  cxClasses, cxPropEditors, dxSpellChecker, dxISpellDecompressor, 
  dxCoreReg, cxLibraryReg, dxSpellCheckerUtils;

type
  { TdxSpellCheckerDictionaryEventsProperty }

  TdxSpellCheckerDictionaryEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TdxSpellCheckerDictionaryTypeProperty }

  TdxSpellCheckerDictionaryTypeProperty = class(TClassProperty)
  protected
    function HasSubProperties: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TdxSpellCheckerLanguageProperty }

  TdxSpellCheckerLanguageProperty = class(TIntegerProperty)
  private
    FLanguages: TdxSpellCheckerLanguages;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    destructor Destroy; override;

    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TdxSpellCheckerCodePageProperty }

  TdxSpellCheckerCodePageProperty = class(TIntegerProperty)
  private
    FCodePages: TdxSpellCheckerCodePages;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    destructor Destroy; override;

    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TdxSpellCheckerComponentEditor }

  TdxSpellCheckerComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

procedure Register;

implementation

const
  dxSpellCheckerMajorVersion = '1';

{ TdxSpellCheckerDictionaryEventsProperty }

function TdxSpellCheckerDictionaryEventsProperty.GetInstance: TPersistent;
begin
  if GetComponent(0) is TdxSpellCheckerDictionaryItem then
    Result := TdxSpellCheckerDictionaryItem(GetComponent(0)).DictionaryType
  else
    Result := nil;
end;

{ TdxSpellCheckerDictionaryTypeProperty }

function TdxSpellCheckerDictionaryTypeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, paSubProperties);
  Result := Result - [paReadOnly] + [paValueList, paSortList, paRevertable, paVolatileSubProperties];
end;

function TdxSpellCheckerDictionaryTypeProperty.GetValue: string;
begin
  if HasSubProperties then
    Result := GetRegisteredDictionaryTypes.GetDescriptionByClass(
      TdxCustomSpellCheckerDictionary(GetOrdValue).ClassType)
  else
    Result := '';
end;

procedure TdxSpellCheckerDictionaryTypeProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GetRegisteredDictionaryTypes.Count - 1 do
    Proc(GetRegisteredDictionaryTypes.Descriptions[I]);
end;

function TdxSpellCheckerDictionaryTypeProperty.HasSubProperties: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to PropCount - 1 do
  begin
    if not (GetComponent(I) is TdxSpellCheckerDictionaryItem) then Exit;
    if TdxSpellCheckerDictionaryItem(GetComponent(I)).DictionaryType = nil then Exit;
  end;
  Result := True;
end;

procedure TdxSpellCheckerDictionaryTypeProperty.SetValue(const Value: string);
var
  ADictionaryTypeClass: TdxCustomSpellCheckerDictionaryClass;
  I: Integer;
begin
  ADictionaryTypeClass := TdxCustomSpellCheckerDictionaryClass(
    GetRegisteredDictionaryTypes.FindByClassName(Value));
  if ADictionaryTypeClass = nil then
    ADictionaryTypeClass := TdxCustomSpellCheckerDictionaryClass(
      GetRegisteredDictionaryTypes.FindByDescription(Value));
  for I := 0 to PropCount - 1 do
    if GetComponent(I) is TdxSpellCheckerDictionaryItem then
      TdxSpellCheckerDictionaryItem(GetComponent(I)).DictionaryTypeClass := ADictionaryTypeClass;
  Modified;
end;

{ TdxSpellCheckerLanguageProperty }

constructor TdxSpellCheckerLanguageProperty.Create(
  const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited Create(ADesigner, APropCount);
  FLanguages := TdxSpellCheckerLanguages.Create;
end;

destructor TdxSpellCheckerLanguageProperty.Destroy;
begin
  FreeAndNil(FLanguages);
  inherited Destroy;
end;

function TdxSpellCheckerLanguageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSortList, paValueList];
end;

function TdxSpellCheckerLanguageProperty.GetValue: string;
begin
  Result := FLanguages.NameFromLocaleID[GetOrdValue];
end;

procedure TdxSpellCheckerLanguageProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to FLanguages.Count - 1 do
    Proc(FLanguages.Name[I]);
end;

procedure TdxSpellCheckerLanguageProperty.SetValue(const Value: string);
begin
  SetOrdValue(FLanguages.GetLCID(Value));
end;

{ TdxSpellCheckerCodePageProperty }

constructor TdxSpellCheckerCodePageProperty.Create(
  const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited Create(ADesigner, APropCount);
  FCodePages := TdxSpellCheckerCodePages.Create(True);
end;

destructor TdxSpellCheckerCodePageProperty.Destroy;
begin
  FreeAndNil(FCodePages);
  inherited;
end;

function TdxSpellCheckerCodePageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSortList, paValueList];
end;

function TdxSpellCheckerCodePageProperty.GetValue: string;
begin
  Result := FCodePages.NameByCode[GetOrdValue];
end;

procedure TdxSpellCheckerCodePageProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to FCodePages.Count - 1 do
    Proc(FCodePages.Name[I]);
end;

procedure TdxSpellCheckerCodePageProperty.SetValue(const Value: string);
begin
  SetOrdValue(FCodePages.CodeByName[Value]);
end;

{ TdxSpellCheckerComponentEditor }

function TdxSpellCheckerComponentEditor.GetProductMajorVersion: string;
begin
  Result := dxSpellCheckerMajorVersion;
end;

function TdxSpellCheckerComponentEditor.GetProductName: string;
begin
  Result := 'ExpressSpellChecker';
end;

procedure TdxSpellCheckerComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  if AIndex = 0 then
    ShowCollectionEditor(Designer, Component, (Component as TdxSpellChecker).DictionaryItems, 'DictionaryItems');
end;

function TdxSpellCheckerComponentEditor.InternalGetVerb(
  AIndex: Integer): string;
begin
  if AIndex = 0 then
    Result := 'Dictionaries Editor...'
  else
    Result := '';
end;

function TdxSpellCheckerComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin
  RegisterComponents(dxCoreLibraryProductPage, [TdxSpellChecker]);
  RegisterClasses([TdxCustomSpellCheckerDictionary]);
  RegisterComponentEditor(TdxCustomSpellChecker, TdxSpellCheckerComponentEditor);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TdxSpellCheckerDictionaryItem, 'DictionaryEvents',
    TdxSpellCheckerDictionaryEventsProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxSpellCheckerDictionaryItem,
    'DictionaryTypeClassName', nil);
  RegisterPropertyEditor(TypeInfo(TdxCustomSpellCheckerDictionary), TdxSpellCheckerDictionaryItem,
    'DictionaryType', TdxSpellCheckerDictionaryTypeProperty);
  RegisterPropertyEditor(TypeInfo(TFileName), TdxAffixCompressionDictionary, 'DictionaryPath', TcxFileNameProperty);
  RegisterPropertyEditor(TypeInfo(TFileName), TdxAffixCompressionDictionary, 'GrammarPath', TcxFileNameProperty);
  RegisterPropertyEditor(TypeInfo(TFileName), TdxUserSpellCheckerDictionary, 'DictionaryPath', TcxFileNameProperty);
  RegisterPropertyEditor(TypeInfo(DWORD), TdxCustomSpellCheckerDictionary, 'Language', TdxSpellCheckerLanguageProperty);
  RegisterPropertyEditor(TypeInfo(Cardinal), TdxCustomSpellCheckerDictionary, 'CodePage', TdxSpellCheckerCodePageProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TdxSpellCheckerCheckAsYouTypeOptions, 'PopupMenu', TcxControlPopupMenuProperty);

end;

end.
