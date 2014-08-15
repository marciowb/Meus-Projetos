{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       HTML rendering Modules                                      }
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
unit cxWebCompProd;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils,
  cxWebIntf;

const
  scxStyle = 'style'; // Do not localize

type
  PcxWebHTMLComponent = ^TcxWebHTMLComponent;
  TcxWebHTMLComponent = record
    ClassName: String;
    Name: String;
    ParentName: String;
    Values: TStrings;
  end;

  EcxComponentProducerException = class(Exception);

  TcxWebComponentProducer = class
  private
    FNewComponents: TList;
    FOwner: TComponent;
  protected
    procedure Add(AComponent: TComponent);
    procedure Clear;

    function SetAttributes(AComponent: TComponent; AName, AValue: String): Boolean;
    procedure SetComponentProperty(AComponent: TComponent; AName, AValue: String;
        ASetComponentProperties: Boolean);
    procedure SetComponentProperties(AComponent: TComponent; AValues: TStrings;
        ASetComponentProperties: Boolean);
    function CreateComponent(AComponentClass: TComponentClass;
         AItem: TcxWebHTMLComponent): TComponent;

    property Owner: TComponent read FOwner;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    function ProduceWebComponent(AItem: TcxWebHTMLComponent;
        AIsFirstRequest, ASetComponentProperties, ACanAssignCustomAttrs: Boolean;
        var AComponentClass: TComponentClass): TComponent;
  end;

function cxWebGetClass(ARoot: TComponent; AClassName: String): TComponentClass;

implementation

uses StrUtils, TypInfo,
  cxWebColors, cxWebStrs, cxWebGraphics;

function cxWebGetClass(ARoot: TComponent; AClassName: String): TComponentClass;

  function GetComponentClass(AClassName: string): TClass;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to ARoot.ComponentCount - 1 do
      if CompareText(AClassName, ARoot.Components[I].ClassName) = 0 then
      begin
        Result := ARoot.Components[I].ClassType;
        break;
      end;
  end;

const
  ClassAddonString: Array[0..3] of String = ('TcxWeb', 'Tcx', 'T', '');
var
  APersistentClass: TClass;
  I: Integer;
  ASt: string;
begin
  Result := nil;
  for I := Low(ClassAddonString) to High(ClassAddonString) do
  begin
    ASt := ClassAddonString[I] + AClassName;
    APersistentClass := Classes.GetClass(ASt);
    if APersistentClass = nil then
      APersistentClass := GetComponentClass(ASt);
    if (APersistentClass <> nil) and (APersistentClass.InheritsFrom(TComponent)) then
    begin
      Result := TComponentClass(APersistentClass);
      break;
    end;
  end;
end;

type
 TSetComponentPropertyFunc = procedure (AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: string);

procedure SetComponentIntegerProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
var
  Value: Integer;
begin
  if (APPropInfo^.PropType <> nil) and (APPropInfo^.PropType^.Name = 'TcxWebColor') then
    Value := cxStringToWebColor(AValue)
  else Value := StrToInt(AValue);
  SetOrdProp(AInstance, APPropInfo.Name, Value);
end;

procedure SetComponentCharProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
var
  Value: Integer;
begin
  if (Length(AValue) > 0) then
    Value := Integer(AValue[1])
  else Value := 0;
  SetOrdProp(AInstance, APPropInfo.Name, Value);
end;

procedure SetComponentEnumerationProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
begin
  SetEnumProp(AInstance, APPropInfo.Name, AValue);
end;

procedure SetComponentFloatProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
var
  Value: Extended;
begin
  Value := StrToFloat(AValue);
  SetFloatProp(AInstance, APPropInfo.Name, Value);
end;

procedure SetComponentStringProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
begin
  SetStrProp(AInstance, APPropInfo.Name, AValue);
end;

procedure SetComponentSetProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
begin
  SetSetProp(AInstance, APPropInfo.Name, AValue);
end;

procedure SetComponentObjectProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
var
  Value: TObject;
begin
  if (AValue = '') or (UpperCase(AValue) = 'NIL') or (UpperCase(AValue) = 'NULL') then
    SetObjectProp(AInstance, APPropInfo.Name, nil)
  else
  begin
    Value := AOwner.FindComponent(AValue);
    if Value <> nil then
      SetObjectProp(AInstance, APPropInfo.Name, Value)
    else
      raise EcxComponentProducerException.CreateFmt(scxInvalidPropertyValue, [AValue, APPropInfo.Name]);
  end;
end;

procedure SetComponentMethodProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
var
  Value: TMethod;
begin
  if csDesigning in AOwner.ComponentState then Exit;

  if (AValue = '') or (UpperCase(AValue) = 'NIL') or (UpperCase(AValue) = 'NULL') then
    SetObjectProp(AInstance, APPropInfo.Name, nil)
  else
  begin
    Value.Code := AOwner.MethodAddress(AValue);
    Value.Data := AOwner;
    if Value.Code <> nil then
      SetMethodProp(AInstance, APPropInfo.Name, Value)
    else
      raise EcxComponentProducerException.CreateFmt(scxInvalidPropertyValue, [AValue, APPropInfo.Name]);
  end;
end;

procedure SetComponentWideStringProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
begin
  SetWideStrProp(AInstance, APPropInfo.Name, WideString(AValue));
end;

procedure SetComponentVariantProperty(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
begin
  SetVariantProp(AInstance, APPropInfo.Name, AValue);
end;

procedure SetComponentInt64Property(AOwner: TComponent; AInstance: TObject;
        APPropInfo: PPropInfo; AValue: String);
var
  Value: Int64;
begin
  Value := StrToInt64(AValue);
  SetInt64Prop(AInstance, APPropInfo.Name, Value);
end;

function GetSetComponentPropertyFunc(ATypeKind: TTypeKind): TSetComponentPropertyFunc;
const
  AFunc: Array[TTypeKind] of TSetComponentPropertyFunc =
   (nil, // tkUnknown
    SetComponentIntegerProperty, // tkInteger
    SetComponentCharProperty, // tkChar
    SetComponentEnumerationProperty, // tkEnumeration
    SetComponentFloatProperty, // tkFloat
    SetComponentStringProperty, // tkString
    SetComponentSetProperty, // tkSet
    SetComponentObjectProperty, // tkClass
    SetComponentMethodProperty, // tkMethod
    nil, // tkWChar
    SetComponentStringProperty, // tkLString
    SetComponentWideStringProperty, // tkWString
    SetComponentVariantProperty, // tkVariant
    nil, // tkArray
    nil, // tkRecord
    nil, // tkInterface
    SetComponentInt64Property, // tkInt64
    nil);// tkDynArray
begin
  Result := AFunc[ATypeKind];
end;


procedure GetPropertyInfo(AComponent: TComponent; APropertyName: String;
        out AInstance: TObject; out APPropInfo: PPropInfo);
var
  ASt: String;
begin
  AInstance := AComponent;
  APPropInfo := nil;
  while Pos('.', APropertyName) > 0 do
  begin
    ASt := Copy(APropertyName, 1, Pos('.', APropertyName) - 1);
    APropertyName := Copy(APropertyName, Pos('.', APropertyName) + 1, Length(APropertyName));
    APPropInfo := GetPropInfo(AInstance, ASt);
    if (APPropInfo <> nil) then
      AInstance := GetObjectProp(AInstance, APPropInfo)
    else AInstance := nil;
    if AInstance = nil then break;
  end;
  if AInstance <> nil then
    APPropInfo := GetPropInfo(AInstance, APropertyName);
end;

constructor TcxWebComponentProducer.Create(AOwner: TComponent);
begin
  FNewComponents := TList.Create;
  FOwner := AOwner;
end;

destructor TcxWebComponentProducer.Destroy;
begin
  Clear;
  FNewComponents.Free;
  inherited;
end;

function TcxWebComponentProducer.ProduceWebComponent(AItem: TcxWebHTMLComponent;
        AIsFirstRequest, ASetComponentProperties, ACanAssignCustomAttrs: Boolean;
        var AComponentClass: TComponentClass): TComponent;
begin
  if CompareText(Owner.Name, AItem.Name) = 0 then
  begin
    Result := Owner;
    AComponentClass := TComponentClass(Owner.ClassType);
  end else
  begin
    if CompareText(AItem.ClassName, 'form') = 0 then
      AComponentClass := TComponentClass(Owner.ClassType)
    else AComponentClass := cxWebGetClass(Owner, AItem.ClassName);
    if AComponentClass = nil then
      raise EcxComponentProducerException.CreateFmt(scxInvalidComponentClassName, [AItem.ClassName]);
    Result  := Owner.FindComponent(AItem.Name);
    if (Result = nil) and Supports(AComponentClass, IcxWebPage) then
      Result := Owner;
    if AIsFirstRequest then
    begin
      if Result = nil then
        Result := CreateComponent(AComponentClass, AItem)
      else
        if (Result.ClassType <> TClass(AComponentClass)) then
          raise EcxComponentProducerException.CreateFmt(scxIncorrectComponentClassName, [AItem.Name, AItem.ClassName]);
    end;
  end;
  if (Result <> nil) and AIsFirstRequest and ASetComponentProperties then
    SetComponentProperties(Result, AItem.Values, ASetComponentProperties);
end;

procedure TcxWebComponentProducer.Add(AComponent: TComponent);
begin
  if csDesigning in Owner.ComponentState then
    FNewComponents.Add(AComponent);
end;

procedure TcxWebComponentProducer.Clear;
begin
  if csDesigning in Owner.ComponentState then
    while FNewComponents.Count > 0 do
    begin
      TComponent(FNewComponents.Items[0]).Free;
      FNewComponents.Delete(0);
    end;
end;

function TcxWebComponentProducer.SetAttributes(AComponent: TComponent; AName, AValue: String): Boolean;
var
  AttrIntf: IcxWebControlAttributes;

  procedure GetStyleAttributes(StyleString: string);
  var
    S, Name, Value: string;
    APos: Integer;
  begin
    S := StyleString;
    while true do
    begin
      APos := Pos(':', S);
      if APos = 0 then break;
      Name := LeftStr(S, APos - 1);
      S := RightStr(S, Length(S) - APos);
      APos := Pos(';', S);
      if APos = 0 then
      begin
        AttrIntf.SetStyleAttribute(Name, S);
        break;
      end;
      Value := LeftStr(S, APos - 1);
      S := RightStr(S, Length(S) - APos);
      AttrIntf.SetStyleAttribute(Name, Value);
    end;
  end;

begin
  if Supports(AComponent, IcxWebControlAttributes, AttrIntf) then
  begin
    if SameText(AName, scxStyle) then
      GetStyleAttributes(AValue)
    else AttrIntf.SetAttribute(AName, AValue);
    Result := True;
  end
  else Result := False;
end;

procedure TcxWebComponentProducer.SetComponentProperty(AComponent: TComponent; AName, AValue: String;
    ASetComponentProperties: Boolean);
var
  APPropInfo: PPropInfo;
  AFunc: TSetComponentPropertyFunc;
  AInstance: TObject;
begin
  GetPropertyInfo(AComponent, AName, AInstance, APPropInfo);
  if APPropInfo <> nil then
  begin
    AFunc := GetSetComponentPropertyFunc(APPropInfo.PropType^.Kind);
    if Assigned(AFunc) then
    begin
      if (APPropInfo.PropType^.Kind <> tkMethod) or
        (Owner.MethodAddress(AValue) <> nil) then
      begin
        try
          AFunc(AComponent.Owner, AInstance, APPropInfo, AValue);
        except
          if ASetComponentProperties and not SetAttributes(AComponent, AName, AValue) then
            raise EcxComponentProducerException.CreateFmt(scxCannotAssignProperty, [AName, AComponent.Name]);
        end;
      end else
      begin
        if ASetComponentProperties and not SetAttributes(AComponent, AName, AValue) then
          raise EcxComponentProducerException.CreateFmt(scxCannotAssignProperty, [AName, AComponent.Name]);
      end;
    end;
  end
  else
  begin
    if ASetComponentProperties and not SetAttributes(AComponent, AName, AValue) then
      raise EcxComponentProducerException.CreateFmt(scxCannotAssignProperty, [AName, AComponent.Name]);
  end;
end;

procedure TcxWebComponentProducer.SetComponentProperties(AComponent: TComponent; AValues: TStrings;
    ASetComponentProperties: Boolean);
var
  I: Integer;
begin
  for I := 0 to AValues.Count - 1 do
    SetComponentProperty(AComponent, AValues.Names[I], AValues.Values[AValues.Names[I]], ASetComponentProperties);
end;

function TcxWebComponentProducer.CreateComponent(AComponentClass: TComponentClass;
         AItem: TcxWebHTMLComponent): TComponent;
var
  AParent: TComponent;
  AWebContainerControl: IcxWebContainerControl;
  AWebControl: IcxWebControl;
begin
  Result := AComponentClass.Create(Owner);
  Add(Result);
  Result.Name := AItem.Name;
  if SameText(Owner.Name, AItem.ParentName) then
    AParent := Owner
  else AParent := Owner.FindComponent(AItem.ParentName);
  if (AParent <> nil) and
    Supports(AParent, IcxWebContainerControl, AWebContainerControl) and
    Supports(Result, IcxWebControl, AWebControl) then
    AWebControl.Parent := AWebContainerControl;
end;

end.
