{*******************************************************************}
{                                                                   }
{       ExpressScript Engine  by Developer Express                  }
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
unit cxScriptDispImpl;

interface

{$I cxVer.inc}

uses {$IFDEF VCL}ActiveX, Windows, {$ENDIF}Classes, SysUtils, Variants, TypInfo;

type

  TcxScriptDispEnumImp = class;

  IcxScriptDispImplGetComponent = interface
    ['{F06EC3EC-AF90-4189-92E6-12CE65839BF7}']
    function GetDispOwner: TComponent;
  end;

  TcxScriptDispImpl = class(TInterfacedPersistent, IDispatch, IcxScriptDispImplGetComponent)
  private
    FOwner: TObject;
    FComponent: TComponent;
    FIsOwnerComponent: Boolean;

    function GetComponent: TComponent;
    function GetMethodAddress(APropInfo: PPropInfo; AFlags: Word): Pointer;
    procedure DestroyDelphiParams(AList: TList);
    function GetDelphiParamCount(AList: TList; AIncludeIndexed: Boolean = False;
          ADestList: TList = nil): Integer;
    function CreateDelphiParamList(APropInfo: PPropInfo; AFlags: Integer): TList;
    function GetDelphiParamList(APropInfo: PPropInfo; Params: TDispParams; AFlags: Integer): TList;
    function GetMethodDataAddress(APropInfo: PPropInfo): Pointer;
    procedure SetInternalDirectParam(APointerValue: PPointer; AParams: TList);
    function InternalDirectParamInvoke(AMethodAddress, ADataAddress: Pointer;
          ADelphiParams: TList; AFlags: Integer; VarResult: Pointer): HResult;
    function InternalRegisterParamInvoke(AMethodAddress, ADataAddress: Pointer;
          ADelphiParams: TList; AFlags: Integer;
          VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    procedure PrepareFuncCall(ADelphiParams: TList; var AEDX, AECX: Integer;
          AStack: PPointerArray; var ARegCount, AStackCount: Integer);
    function IsNeedReturnDispatch(PropInfo: PPropInfo; ADelphiParams: TList): Boolean;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;

    function GetDispOwner: TComponent;

    function GetEnumerator: TcxScriptDispEnumImp; virtual;
    function IsSupportEnum: Boolean;
    function GetDefaultPropInfo: PPropInfo; virtual;
    function GetPropertyInfo(AObject: TObject; APropName: string): PPropInfo;
    function IsSupportDefaultProperty: Boolean;
    function GetCollectionValue(Index: Integer): OleVariant; virtual;
    function GetCollectionCount: Integer; virtual;

  public
    constructor Create(AOwner: TObject); virtual;
    class function GetObjectClass: TClass; virtual;

    property Owner: TObject read FOwner;
    property Component: TComponent read GetComponent;
  end;

  TcxScriptDispImplClass = class of TcxScriptDispImpl;


  TcxScriptDispEnumImp_Next = function(celt: LongWord; var rgvar : OleVariant;
      out pceltFetched: LongWord): HResult of object; stdcall;
  TcxScriptDispEnumImp_Skip = function(celt: LongWord): HResult of object; stdcall;
  TcxScriptDispEnumImp_Reset = function: HResult of object; stdcall;
  TcxScriptDispEnumImp_Clone = function(out Enum: IEnumVariant): HResult of object; stdcall;

  { TcxScriptDispEnumImp }
  TcxScriptDispEnumImp = class(TcxScriptDispImpl, IEnumVariant)
  private
    FIndex: Integer;
    FDispatch_Next: TcxScriptDispEnumImp_Next;
    FDispatch_Skip: TcxScriptDispEnumImp_Skip;
    FDispatch_Reset: TcxScriptDispEnumImp_Reset;
    FDispatch_Clone: TcxScriptDispEnumImp_Clone;

  protected
    // Implementation of IEnumVariant
    function IEnumVariant.Next = Dispatch_Next;
    function IEnumVariant.Skip = Dispatch_Skip;
    function IEnumVariant.Reset = Dispatch_Reset;
    function IEnumVariant.Clone = Dispatch_Clone;

    function Dispatch_Next(celt: LongWord; var rgvar : OleVariant;
      out pceltFetched: LongWord): HResult; stdcall;
    function Dispatch_Skip(celt: LongWord): HResult; stdcall;
    function Dispatch_Reset: HResult; stdcall;
    function Dispatch_Clone(out Enum: IEnumVariant): HResult; stdcall;

    function GetCollection: TcxScriptDispImpl;

    property Collection: TcxScriptDispImpl read GetCollection;

  public
    constructor Create(ACollection: TcxScriptDispImpl); reintroduce;
    constructor CreateClone(ACollection: TcxScriptDispImpl; AIndex: Integer);

  published
    property Next: TcxScriptDispEnumImp_Next read FDispatch_Next;
    property Skip: TcxScriptDispEnumImp_Skip read FDispatch_Skip;
    property Reset: TcxScriptDispEnumImp_Reset read FDispatch_Reset;
    property Clone: TcxScriptDispEnumImp_Clone read FDispatch_Clone;
  end;

  TcxScriptDispStringsImpl_Append = procedure(const Value: string) of object;
  TcxScriptDispStringsImpl_Add = function(const Value: string): Integer of object;
  TcxScriptDispStringsImpl_AddObject = function(const Value: string; Obj: TObject): Integer of object;
  TcxScriptDispStringsImpl_Delete = procedure(Index: Integer) of object;
  TcxScriptDispStringsImpl_IndexOf = function(const Value: string): Integer of object;
  TcxScriptDispStringsImpl_Clear = procedure of object;
  TcxScriptDispStringsImpl_Values = function(const Value: string): string of object;

  TcxScriptDispStringsImpl = class(TcxScriptDispImpl)
  private
    FDispatch_Append: TcxScriptDispStringsImpl_Append;
    FDispatch_Add: TcxScriptDispStringsImpl_Add;
    FDispatch_AddObject: TcxScriptDispStringsImpl_AddObject;
    FDispatch_Delete: TcxScriptDispStringsImpl_Delete;
    FDispatch_IndexOf: TcxScriptDispStringsImpl_IndexOf;
    FDispatch_Clear: TcxScriptDispStringsImpl_Clear;
    FDispatch_Values: TcxScriptDispStringsImpl_Values;

    procedure Dispatch_Append(const Value: String);
    function Dispatch_Add(const Value: string): Integer;
    function Dispatch_AddObject(const Value: string; Obj: TObject): Integer;
    procedure Dispatch_Delete(Index: Integer);
    function Dispatch_IndexOf(const Value: string): Integer;
    procedure Dispatch_Clear;
    function Dispatch_Values(const Value: string): string;

    function GetCount: Integer;
  protected
    function GetStrings: TStrings;
    function GetEnumerator: TcxScriptDispEnumImp; override;
    function GetCollectionValue(Index: Integer): OleVariant; override;
    function GetCollectionCount: Integer; override;
    function GetDefaultPropInfo: PPropInfo; override;

    property Strings: TStrings read GetStrings;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;

  published
    property Count: Integer read GetCount;

    property Append: TcxScriptDispStringsImpl_Append read FDispatch_Append;
    property Add: TcxScriptDispStringsImpl_Add read FDispatch_Add;
    property AddObject: TcxScriptDispStringsImpl_AddObject read FDispatch_AddObject;
    property Delete: TcxScriptDispStringsImpl_Delete read FDispatch_Delete;
    property IndexOf: TcxScriptDispStringsImpl_IndexOf read FDispatch_IndexOf;
    property Clear: TcxScriptDispStringsImpl_Clear read FDispatch_Clear;
    property Values: TcxScriptDispStringsImpl_Values read FDispatch_Values;
  end;


  TcxScriptDispPersistentImpl_GetNamePath = function: string of object;
  TcxScriptDispPersistentImpl_Assign = procedure(Source: TPersistent) of object;

  { TcxScriptDispPersistentImpl }

  TcxScriptDispPersistentImpl = class(TcxScriptDispImpl)
  private
    FDispatch_GetNamePath: TcxScriptDispPersistentImpl_GetNamePath;
    FDispatch_Assign: TcxScriptDispPersistentImpl_Assign;

    function Dispatch_GetNamePath: string;
    procedure Dispatch_Assign(Source: TPersistent);
  protected
    function Persistent: TPersistent;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property NamePath: TcxScriptDispPersistentImpl_GetNamePath read FDispatch_GetNamePath;
    property Assign_: TcxScriptDispPersistentImpl_Assign read FDispatch_Assign;
  end;

  TcxScriptDispCollectionItemImpl = class(TcxScriptDispPersistentImpl)
  private
    function GetCollection: TCollection;
    function GetDisplayName: string;
    function GetID: Integer;
    function GetIndex: Integer;
    function GetNamePath__: string;
    procedure SetCollection(const Value: TCollection);
    procedure SetDisplayName(const Value: string);
    procedure SetIndex(const Value: Integer);
  protected
    function CollectionItem: TCollectionItem;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property GetNamePath_: string read GetNamePath__;
    property Collection: TCollection read GetCollection write SetCollection;
    property ID: Integer read GetID;
    property Index: Integer read GetIndex write SetIndex;
    property DisplayName: string read GetDisplayName write SetDisplayName;
  end;

  TcxScriptDispCollectionImpl_Add = function: TCollectionItem of object;
  TcxScriptDispCollectionImpl_Clear = procedure of object;
  TcxScriptDispCollectionImpl_Delete = procedure(Index: Integer) of object;
  TcxScriptDispCollectionImpl_Insert = function(Index: Integer): TCollectionItem of object;
  TcxScriptDispCollectionImpl_Items = function(Index: Integer): TCollectionItem of object;

  TcxScriptDispCollectionImpl = class(TcxScriptDispPersistentImpl)
  private
    FDispatch_Add: TcxScriptDispCollectionImpl_Add;
    FDispatch_Clear: TcxScriptDispCollectionImpl_Clear;
    FDispatch_Delete: TcxScriptDispCollectionImpl_Delete;
    FDispatch_Insert: TcxScriptDispCollectionImpl_Insert;
    FDispatch_Items: TcxScriptDispCollectionImpl_Items;
    FDispatch_FindItemId: TcxScriptDispCollectionImpl_Items;

    function Dispatch_Add: TCollectionItem;
    procedure Dispatch_Clear;
    procedure Dispatch_Delete(Index: Integer);
    function Dispatch_Insert(Index: Integer): TCollectionItem;
    function Dispatch_Items(Index: Integer): TCollectionItem;
    function Dispatch_FindItemID(Index: Integer): TCollectionItem;
    function GetCount: Integer;
    function GetOwner_: TPersistent;
  protected
    function Collection: TCollection;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Count: Integer read GetCount;
    property Owner_: TPersistent read GetOwner_;
    property Add: TcxScriptDispCollectionImpl_Add read FDispatch_Add;
    property Clear: TcxScriptDispCollectionImpl_Clear read FDispatch_Clear;
    property Delete: TcxScriptDispCollectionImpl_Delete read FDispatch_Delete;
    property Insert: TcxScriptDispCollectionImpl_Insert read FDispatch_Insert;
    property Items: TcxScriptDispCollectionImpl_Items read FDispatch_Items;
    property FindItemID: TcxScriptDispCollectionImpl_Items read FDispatch_FindItemID;
  end;

  TcxScriptDispComponentImpl_BeforeDestruction = procedure of object;
  TcxScriptDispComponentImpl_DestroyComponents = procedure of object;
  TcxScriptDispComponentImpl_Destroying = procedure of object;
  TcxScriptDispComponentImpl_ExecuteAction = function(Action: TBasicAction): Boolean of object;
  TcxScriptDispComponentImpl_FindComponent = function(const AName: string): TComponent of object;
  TcxScriptDispComponentImpl_FreeNotification = procedure(AComponent: TComponent) of object;
  TcxScriptDispComponentImpl_RemoveFreeNotification = procedure(AComponent: TComponent) of object;
  TcxScriptDispComponentImpl_FreeOnRelease = procedure of object;
  TcxScriptDispComponentImpl_GetParentComponent = function: TComponent of object;
  TcxScriptDispComponentImpl_HasParent = function: Boolean of object;
  TcxScriptDispComponentImpl_InsertComponent = procedure(AComponent: TComponent) of object;
  TcxScriptDispComponentImpl_RemoveComponent = procedure(AComponent: TComponent) of object;
  TcxScriptDispComponentImpl_SetSubComponent = procedure(IsSubComponent: Boolean) of object;
  TcxScriptDispComponentImpl_SafeCallException = function(ExceptObject: TObject; ExceptAddr: Pointer): HResult of object;
  TcxScriptDispComponentImpl_UpdateAction = function(Action: TBasicAction): Boolean of object;
  TcxScriptDispComponentImpl_IsImplementorOf = function(const I: IInterface): Boolean of object;
  TcxScriptDispComponentImpl_ReferenceInterface = function(const I: IInterface; Operation: TOperation): Boolean of object;
  TcxScriptDispComponentImpl_GetComponents = function(Index: Integer): TComponent of object;

  { TcxScriptDispComponentImpl }
  TcxScriptDispComponentImpl = class(TcxScriptDispPersistentImpl)
  private
    FDispatch_BeforeDestruction: TcxScriptDispComponentImpl_BeforeDestruction;
    FDispatch_DestroyComponents: TcxScriptDispComponentImpl_DestroyComponents;
    FDispatch_Destroying: TcxScriptDispComponentImpl_Destroying;
    FDispatch_ExecuteAction: TcxScriptDispComponentImpl_ExecuteAction;
    FDispatch_FindComponent: TcxScriptDispComponentImpl_FindComponent;
    FDispatch_FreeNotification: TcxScriptDispComponentImpl_FreeNotification;
    FDispatch_RemoveFreeNotification: TcxScriptDispComponentImpl_RemoveFreeNotification;
    FDispatch_FreeOnRelease: TcxScriptDispComponentImpl_FreeOnRelease;
    FDispatch_GetParentComponent: TcxScriptDispComponentImpl_GetParentComponent;
    FDispatch_HasParent: TcxScriptDispComponentImpl_HasParent;
    FDispatch_InsertComponent: TcxScriptDispComponentImpl_InsertComponent;
    FDispatch_RemoveComponent: TcxScriptDispComponentImpl_RemoveComponent;
    FDispatch_SetSubComponent: TcxScriptDispComponentImpl_SetSubComponent;
    FDispatch_SafeCallException: TcxScriptDispComponentImpl_SafeCallException;
    FDispatch_UpdateAction: TcxScriptDispComponentImpl_UpdateAction;
    FDispatch_IsImplementorOf: TcxScriptDispComponentImpl_IsImplementorOf;
    FDispatch_ReferenceInterface: TcxScriptDispComponentImpl_ReferenceInterface;
    FDispatch_GetComponents: TcxScriptDispComponentImpl_GetComponents;

    procedure Dispatch_BeforeDestruction;
    procedure Dispatch_DestroyComponents;
    procedure Dispatch_Destroying;
    function Dispatch_ExecuteAction(Action: TBasicAction): Boolean;
    function Dispatch_FindComponent(const AName: string): TComponent;
    procedure Dispatch_FreeNotification(AComponent: TComponent);
    procedure Dispatch_RemoveFreeNotification(AComponent: TComponent);
    procedure Dispatch_FreeOnRelease;
    function Dispatch_GetParentComponent: TComponent;
    function Dispatch_HasParent: Boolean;
    procedure Dispatch_InsertComponent(AComponent: TComponent);
    procedure Dispatch_RemoveComponent(AComponent: TComponent);
    procedure Dispatch_SetSubComponent(IsSubComponent: Boolean);
    function Dispatch_SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult;
    function Dispatch_UpdateAction(Action: TBasicAction): Boolean;
    function Dispatch_IsImplementorOf(const I: IInterface): Boolean;
    function Dispatch_ReferenceInterface(const I: IInterface; Operation: TOperation): Boolean;
    function Dispatch_GetComponents(Index: Integer): TComponent;
    function GetComponentCount: Integer;
    function GetComponentIndex: Integer;
    procedure SetComponentIndex(aComponentIndex: Integer);
    function GetComponentState: TComponentState;
    function GetComponentStyle: TComponentStyle;
    function GetOwner: TComponent; reintroduce;
    function Dispatch_GetNamePath: string;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property BeforeDestruction_: TcxScriptDispComponentImpl_BeforeDestruction read FDispatch_BeforeDestruction;
    property DestroyComponents: TcxScriptDispComponentImpl_DestroyComponents read FDispatch_DestroyComponents;
    property Destroying: TcxScriptDispComponentImpl_Destroying read FDispatch_Destroying;
    property ExecuteAction: TcxScriptDispComponentImpl_ExecuteAction read FDispatch_ExecuteAction;
    property FindComponent: TcxScriptDispComponentImpl_FindComponent read FDispatch_FindComponent;
    property FreeNotification: TcxScriptDispComponentImpl_FreeNotification read FDispatch_FreeNotification;
    property RemoveFreeNotification: TcxScriptDispComponentImpl_RemoveFreeNotification read FDispatch_RemoveFreeNotification;
    property FreeOnRelease: TcxScriptDispComponentImpl_FreeOnRelease read FDispatch_FreeOnRelease;
    property GetParentComponent: TcxScriptDispComponentImpl_GetParentComponent read FDispatch_GetParentComponent;
    property HasParent: TcxScriptDispComponentImpl_HasParent read FDispatch_HasParent;
    property InsertComponent: TcxScriptDispComponentImpl_InsertComponent read FDispatch_InsertComponent;
    property RemoveComponent: TcxScriptDispComponentImpl_RemoveComponent read FDispatch_RemoveComponent;
    property SetSubComponent: TcxScriptDispComponentImpl_SetSubComponent read FDispatch_SetSubComponent;
    property SafeCallException_: TcxScriptDispComponentImpl_SafeCallException read FDispatch_SafeCallException;
    property UpdateAction: TcxScriptDispComponentImpl_UpdateAction read FDispatch_UpdateAction;
    property IsImplementorOf: TcxScriptDispComponentImpl_IsImplementorOf read FDispatch_IsImplementorOf;
    property ReferenceInterface: TcxScriptDispComponentImpl_ReferenceInterface read FDispatch_ReferenceInterface;
    property ComponentCount: Integer read GetComponentCount;
    property ComponentIndex: Integer read GetComponentIndex write SetComponentIndex;
    property Components: TcxScriptDispComponentImpl_GetComponents read FDispatch_GetComponents;
    property ComponentState: TComponentState read GetComponentState;
    property ComponentStyle: TComponentStyle read GetComponentStyle;
    property Owner: TComponent read GetOwner;
  end;

implementation

uses cxScriptDispFactory, ComObj;

{ TcxScriptDispStringsImpl }
constructor TcxScriptDispStringsImpl.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FDispatch_Append := Dispatch_Append;
  FDispatch_Add := Dispatch_Add;
  FDispatch_AddObject := Dispatch_AddObject;
  FDispatch_Delete := Dispatch_Delete;
  FDispatch_IndexOf := Dispatch_IndexOf;
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_Values := Dispatch_Values;
end;

class function TcxScriptDispStringsImpl.GetObjectClass: TClass;
begin
  Result := TStrings;
end;

function TcxScriptDispStringsImpl.GetStrings: TStrings;
begin
  if Owner is TStrings then
    Result := TStrings(Owner)
  else Result := nil;  
end;

function TcxScriptDispStringsImpl.GetCount: Integer;
begin
  Result := Strings.Count;
end;

procedure TcxScriptDispStringsImpl.Dispatch_Append(const Value: String);
begin
  Strings.Append(Value);
end;

function TcxScriptDispStringsImpl.Dispatch_Add(const Value: string): Integer;
begin
  Result := Strings.Add(Value);
end;

function TcxScriptDispStringsImpl.Dispatch_AddObject(const Value: string; Obj: TObject): Integer;
begin
  Result := Strings.AddObject(Value, Obj);
end;

procedure TcxScriptDispStringsImpl.Dispatch_Delete(Index: Integer);
begin
  Strings.Delete(Index);
end;

function TcxScriptDispStringsImpl.Dispatch_IndexOf(const Value: string): Integer;
begin
  Result := Strings.IndexOf(Value);
end;

procedure TcxScriptDispStringsImpl.Dispatch_Clear;
begin
  Strings.Clear;
end;

function TcxScriptDispStringsImpl.Dispatch_Values(const Value: string): string;
begin
  Result := Strings.Values[Value];
end;


{ TcxDispatchHelper }
const
  INVOKE_PROPERTYSET = INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF;

type
 PPointer2 = ^Pointer2;
 Pointer2 = array [0..1] of Pointer;

 PPointer3 = ^Pointer3;
 Pointer3 = array [0..2] of Pointer;

 PShortString = ^ShortString;
 PWideString = ^WideString;

PParamRec = ^TParamRec;
TParamRec = record
  Value: Pointer3;
  TypeKind: TTypeKind;
  OrdType: TOrdType;
  FloatType: TFloatType;
  TypeInfo: PTypeInfo;
  IsReturn: Boolean;
  IsIndexed: Boolean;
  StringValue: String;
  ShortStringValue: ShortString;
  WideStringValue: WideString;
end;

function IsStackParam(AParamRec: PParamRec): Boolean;
begin
  Result := AParamRec^.TypeKind in [tkFloat, {tkVariant, }tkArray, tkRecord, tkDynArray]
end;

function GetByteCount(AParamRec: PParamRec): Integer;
begin
  if  IsStackParam(AParamRec) then
  begin
    Result := 2;
    if AParamRec^.FloatType = ftExtended then
      Result := 3;
    if AParamRec^.FloatType = ftSingle then
      Result := 1;
  end
  else if AParamRec^.TypeKind = tkInt64 then
    Result := 2
  else
    Result := 1;
end;

procedure GetTypeKindByName(AName: String; var ATypeKind: TTypeKind;
        var AOrdType: TOrdType; var AFloatType: TFloatType;
        var ATypeInfo: PTypeInfo);
begin
  if GetClass(AName) <> nil then
  begin
    ATypeKind := tkClass;
    AOrdType := otSLong;
    exit;
  end;
  AName := UpperCase(AName);
  ATypeInfo := nil; //TODO
  ATypeKind := tkInteger;
  AOrdType := otSLong;
  AFloatType := ftDouble;
  if (AName = 'DOUBLE') then
    ATypeKind := tkFloat;
  if (AName = 'STRING') then
    ATypeKind := tkLString;
  if (AName = 'VARIANT') then
    ATypeKind := tkVariant;
  //TODO
end;

function GetVarTypeByTypeKind(AParam: PParamRec): Integer;
begin
  Result := varEmpty;
  case AParam^.TypeKind of
    {tkUnknown:}
    tkInteger:
    begin
{      case AParam^.OrdType of
        otUByte:
          Result := varByte;
        otSByte:
          Result := varShortInt;
        otSWord:
          Result := varSmallInt;
        otUWord:
          Result := varWord;
        otULong:
          Result := varLongWord;
        else}
          Result := varInteger;
//      end;
    end;
    tkSet, tkClass:
      Result := varInteger;
    tkEnumeration:
      if AParam^.TypeInfo = System.TypeInfo(Boolean) then
        Result := varBoolean
      else Result := varInteger;
    tkChar,
    tkWChar,
    tkWString,
    tkString,
    tkLString:
      Result := varOleStr;
    tkFloat:
    begin
      case AParam^.FloatType of
        ftSingle: Result := varSingle;
        ftDouble, ftExtended, ftComp: Result := varDouble;
        ftCurr: Result := varCurrency;
      end;
    end;
    tkMethod: Result := varInteger;
    tkVariant: Result := varVariant;
    tkInterface: Result := varDispatch;
    tkInt64: Result := varInt64;
    {tkArray, tkRecord, tkDynArray}
  end;
end;

procedure GetPointerByVariant(AParam: PParamRec; PValue: PPointer; const Value: Variant);
var
 PP3: ^Pointer3;

 procedure SetValueToPointer(ACount: Integer);
 var
   I: Integer;
   PTempValue: PPointer;
 begin
   PTempValue := PValue;
   for I := 0 to ACount - 1 do
   begin
     PTempValue^ := PP3^[I];
     Inc(PTempValue);
   end;
 end;

var
  AExtendedValue: Extended;
  ASingleValue: Single;
  ACurrencyValue: Currency;
  ACompValue: Comp;
  ADoubleValue: Double;
  AByteValue: Byte;
  AShortIntValue: ShortInt;
  AWordValue: Word;
  ASmallIntValue: SmallInt;
  ALongWordValue: LongWord;
  ALongIntValue: Longint;
  AInt64Value: Int64;
  AGetComponent: IcxScriptDispImplGetComponent;
  ADispatch: IDispatch;
begin
  if VarIsNull(Value) or (TVarData(Value).VType = varEmpty) then exit;
  case AParam^.TypeKind of
     tkVariant:
     PValue^ := @Value;
    {tkUnknown:}
     tkInteger:
     begin
       case AParam^.OrdType of
         otSByte:
         begin
           AShortIntValue := Value;
           PValue^ := Pointer(AShortIntValue);
         end;
         otUByte:
         begin
           AByteValue := Value;
           PValue^ := Pointer(AByteValue);
         end;
         otSWord:
         begin
           ASmallIntValue := Value;
           PValue^ := Pointer(ASmallIntValue);
         end;
         otUWord:
         begin
           AWordValue := Value;
           PValue^ := Pointer(AWordValue);
         end;
         otULong:
         begin
           ALongWordValue := Value;
           PValue^ := Pointer(ALongWordValue);
         end;
         otSLong:
         begin
           ALongIntValue := Value;
           PValue^ := Pointer(ALongIntValue);
         end;
         else
           PValue^ := Pointer(TVarData(Value).vInteger);
       end;
     end;
     tkEnumeration, tkSet:
       PValue^ := Pointer(TVarData(Value).vInteger);
     tkLString:
     begin
       case TVarData(Value).VType of
         varInteger:
           AParam^.StringValue := IntToStr(TVarData(Value).VInteger);
         varDouble:
           AParam^.StringValue := FloatToStr(TVarData(Value).VDouble);
         varDate:
           AParam^.StringValue := DateTimeToStr(TVarData(Value).VDouble);
         varBoolean:
           AParam^.StringValue := BoolToStr(TVarData(Value).VBoolean);
         else
           AParam^.StringValue := String(WideString(TVarData(Value).VOleStr));
       end;
       PValue^ := Pointer(AParam^.StringValue);
     end;
     tkWString:
     begin
       AParam^.WideStringValue := String(WideString(TVarData(Value).VOleStr));
       PValue^ := Pointer(PWideString(AParam^.WideStringValue));
     end;
     tkString:
     begin
       AParam^.ShortStringValue := String(WideString(TVarData(Value).VOleStr));
       PValue^ := Pointer(PShortString(@AParam^.ShortStringValue));
     end;
     tkChar:
     begin
       AParam^.StringValue := String(WideString(TVarData(Value).VOleStr));
       PValue^ := Pointer(Ord(AParam^.StringValue[1]));
     end;
     tkWChar:
     begin
       AParam^.StringValue := String(WideString(TVarData(Value).VOleStr));
       PValue^ := Pointer(Ord(AParam^.StringValue[1]));
     end;
     tkFloat:
       begin
         //ftSingle, ftDouble, ftExtended, ftComp, ftCurr
         case AParam^.FloatType of
           ftSingle:
             begin
               ASingleValue := Value;
               Single(PValue^) := ASingleValue;
               {case TVarData(Value).VType of
                 varInteger:
                   begin
                     ASingleValue := TVarData(Value).VInteger;
                     Single(PValue^) := ASingleValue;
                   end;
                 varDouble:
                   begin
                     ASingleValue := TVarData(Value).VDouble;
                     Single(PValue^) := ASingleValue;
                   end;
               else
                 Single(PValue^) := TVarData(Value).VSingle;
               end;}
             end;
           ftExtended:
             begin
               AExtendedValue := Value;
               PP3 := @AExtendedValue;
               SetValueToPointer(3);
             end;
           ftDouble:
             begin
               ADoubleValue := Value;
               PP3 := @ADoubleValue;
//               PP3 := @TVarData(Value).VDouble;
               SetValueToPointer(2);
             end;
           ftComp:
             begin
               ACompValue := Value;
               PP3 := @ACompValue;
               SetValueToPointer(2);
             end;
           ftCurr:
             begin
{               case TVarData(Value).VType of
                 varInteger: ACurrencyValue := TVarData(Value).VInteger;
                 varDouble: ACurrencyValue := TVarData(Value).VDouble;
                 else ACurrencyValue := TVarData(Value).VCurrency;
               end;}
               ACurrencyValue := Value;
               PP3 := @ACurrencyValue;
               SetValueToPointer(2);
             end;
         end;
       end;
{     tkMethod:

     tkVariant:
     tkInterface:}
     tkInt64:
     begin
       AInt64Value := Value;
       PP3 := @AInt64Value;
       SetValueToPointer(2);
     end;
     tkClass:
     begin
       if TVarData(Value).VType = varDispatch then
       begin
         PValue^ := nil;
         if (TVarData(Value).VDispatch <> nil) then
         begin
           ADispatch := IInterface(TVarData(Value).VDispatch) as IDispatch;
           if Supports(ADispatch, IcxScriptDispImplGetComponent, AGetComponent) then
             PValue^ := Pointer(AGetComponent.GetDispOwner)
         end;
       end
       else PValue^ := Pointer(TVarData(Value).vInteger);
     end;
     {tkArray, tkRecord, tkDynArray}
  end;
end;

procedure GetVariantByPointer(AParam: PParamRec; PValue: PPointer; Value: PVariant);
var
  AExtendedValue: Extended;
  ACompValue: Comp;
  AByteValue: Byte;
  AShortIntValue: ShortInt;
  AWordValue: Word;
  ASmallIntValue: SmallInt;
  ALongWordValue: LongWord;
  AInt64Value: Int64;
begin
  TVarData(Value^).VType := GetVarTypeByTypeKind(AParam);
  case AParam^.TypeKind of
    {tkUnknown:}
    tkInteger:
    begin
      case AParam^.OrdType of
        otUByte:
        begin
          Move(PValue^, AByteValue, 1);
          Value^ := AByteValue;
        end;
        otSByte:
        begin
          Move(PValue^, AShortIntValue, 1);
          Value^ := AShortIntValue;
        end;
        otUWord:
        begin
          Move(PValue^, AWordValue, 2);
          Value^ := AWordValue;
        end;
        otSWord:
        begin
          Move(PValue^, ASmallIntValue, 2);
          Value^ := ASmallIntValue;
        end;
        otULong:
        begin
          ALongWordValue := LongWord(PValue^);
          Value^ := ALongWordValue;
        end;
        else
          TVarData(Value^).VInteger := Integer(PValue^);
      end;
    end;
    tkEnumeration, tkSet, tkClass:
      TVarData(Value^).VInteger := Integer(PValue^);
    tkChar:
      TVarData(Value^).VOleStr := StringToOleStr(string(PChar(PValue)^));
    tkWChar:
      TVarData(Value^).VOleStr := PWideChar(PWChar(PValue)^);
    tkLString:
       begin
         TVarData(Value^).VType := varOleStr;
         TVarData(Value^).VOleStr := StringToOleStr(String(PValue^));
       end;
    tkString:
    begin
      TVarData(Value^).VType := varOleStr;
      TVarData(Value^).VOleStr := StringToOleStr(String(PShortString(PValue)^));
    end;
    tkWString:
    begin
      TVarData(Value^).VType := varOleStr;
      TVarData(Value^).VOleStr := PWideChar(PWideString(PValue)^);
    end;
    tkFloat:
      begin
         //ftSingle, ftDouble, ftExtended, ftComp, ftCurr
         case AParam^.FloatType of
           ftSingle:
             TVarData(Value^).VSingle := Single(PValue^);
           ftExtended:
             begin
               Move(PValue^, AExtendedValue, 10);
               TVarData(Value^).VDouble := AExtendedValue;
             end;
           ftComp:
           begin
             ACompValue := Comp(PPointer2(PValue)^);
             Value^ := ACompValue;
           end;
           ftDouble:
             TVarData(Value^).VDouble := Double(PPointer2(PValue)^);
           ftCurr:
             TVarData(Value^).VCurrency := Currency(PPointer2(PValue)^);
         end;
       end;
     tkVariant:
     begin
       if TVarData(PVariant(PValue)^).VType = varString then
       begin
         TVarData(Value^).VType := varOleStr;
         TVarData(Value^).VOleStr := StringToOleStr(String(PVariant(PValue)^))
       end else Value^ := PVariant(PValue)^;
     end;
{     tkMethod:
     tkInterface:}
     tkInt64:
     begin
       AInt64Value := Int64(PPointer2(PValue)^);
       Value^ := AInt64Value;
     end;
     {tkArray, tkRecord, tkDynArray}
  end;
end;

// 0 - no return value, 1 - return via EAX, 2 - return via ST register (float types),
// 3 - Pascal String, 4 - Variant
function GetReturnTypes(ADelphiParams: TList): Byte;
var
  ARetType: TTypeKind;
begin
  if (ADelphiParams.Count > 0) and  PParamRec(ADelphiParams.Last)^.IsReturn then
  begin
    ARetType := PParamRec(ADelphiParams.Last)^.TypeKind;
    if IsStackParam(PParamRec(ADelphiParams.Last)) then
      Result := 2
    else if ARetType in [tkString, tkLString, tkWString] then
      Result := 3
    else if ARetType = tkVariant then
      Result := 4
    else if ARetType = tkInt64 then
      Result := 5
    else
      Result := 1;
  end
  else
    Result := 0;
end;

procedure GetReturnValue(AParam: PParamRec; dwEAX: Integer; dwEDX: Integer; 
        ARetPointer: PPointer; Value: PVariant);
var
  Byte8: Pointer2;
  AVar: Variant;
  AString: string;
begin
  TVarData(Value^).VType := GetVarTypeByTypeKind(AParam);

  if AParam^.TypeKind in [tkInteger, tkEnumeration, tkSet, tkClass] then
  begin
    TVarData(Value^).VPointer := ptr(dwEAX);
    AVar := Value^;
  end
  else if AParam^.TypeKind = tkInt64 then
  begin
    Byte8[0] := Pointer(dwEAX);
    Byte8[1] := Pointer(dwEDX);
    TVarData(Value^).VInt64 := Int64(PPointer2(@Byte8)^);
  end
  else if AParam^.TypeKind in [tkChar, tkWChar] then
  begin
    AString := Chr(Byte(dwEAX));
    TVarData(Value^).VOleStr := StringToOleStr(AString);
  end
  else if AParam^.TypeKind in [tkString] then
    TVarData(Value^).VOleStr := StringToOleStr(string(PShortString(ARetPointer)^))
  else if AParam^.TypeKind in [tkWString] then
    TVarData(Value^).VOleStr := StringToOleStr(string(PWideString(ARetPointer)^))
  else
    GetVariantByPointer(AParam, ARetPointer, Value);
end;

constructor TcxScriptDispImpl.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  FIsOwnerComponent := (FOwner <> nil) and (FOwner is TComponent);
end;

class function TcxScriptDispImpl.GetObjectClass: TClass;
begin
  Result := TObject;
end;

function TcxScriptDispImpl.GetComponent: TComponent;
begin
  if FComponent <> nil then
    Result := FComponent
  else
    if FIsOwnerComponent then
      Result := TComponent(FOwner)
    else Result := nil;
end;

function TcxScriptDispImpl.GetMethodAddress(APropInfo: PPropInfo; AFlags: Word): Pointer;
var
  AMethod: TMethod;
begin
  if APropInfo.PropType^.Kind = tkMethod then
  begin
    AMethod := GetMethodProp(TObject(GetMethodDataAddress(APropInfo)), APropInfo);
    Result := AMethod.Code;
  end else
    if AFlags and INVOKE_PROPERTYSET = INVOKE_PROPERTYSET then
      Result := APropInfo.SetProc
    else Result := APropInfo.GetProc;
  if (Integer(Result) and $FF000000) = $FE000000 then // Virtual method
    Result := Pointer(PInteger(PInteger(GetMethodDataAddress(APropInfo))^ + SmallInt(Result))^)
end;


procedure TcxScriptDispImpl.DestroyDelphiParams(AList: TList);
var
  i: Integer;
begin
  for i := 0 to AList.Count - 1 do
    Dispose(PParamRec(AList[I]));
  AList.Free;
end;

function TcxScriptDispImpl.GetDelphiParamCount(
        AList: TList; AIncludeIndexed: Boolean; ADestList: TList): Integer;
var
  I: Integer;      
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
    if not PParamRec(AList[I])^.IsReturn and
      (AIncludeIndexed or not PParamRec(AList[I])^.IsIndexed) then
      begin
        Inc(Result);
        if ADestList <> nil then
          ADestList.Add(AList[I]);
      end;
end;

function TcxScriptDispImpl.CreateDelphiParamList(APropInfo: PPropInfo; AFlags: Integer): TList;
var
  APos: Integer;
  ATypeData: PTypeData;

  function ReadString: shortString;
  var
    ALen: Byte;
    i: Integer;
  begin
    ALen := Byte(ATypeData.ParamList[APos]);
    Inc(APos);
    SetLength(Result, ALen);
    for i := 0 to ALen - 1 do
      Result[i + 1] := ATypeData.ParamList[APos + i];
    Inc(APos, ALen);
  end;

  procedure AddParameter(AName: string; AIsReturn: Boolean);
  var
    AParamRect: PParamRec;
  begin
    new(AParamRect);
    Result.Add(AParamRect);
    AParamRect^.Value[0] := nil;
    AParamRect^.Value[1] := nil;
    AParamRect^.IsReturn := AIsReturn;
    AParamRect^.IsIndexed := False;
    with AParamRect^ do
      if AName <> '' then
        GetTypeKindByName(AName, TypeKind, OrdType, FloatType, TypeInfo)
      else begin
        TypeKind := APropInfo.PropType^.Kind;
        OrdType := ATypeData.OrdType;
        FloatType := ATypeData.FloatType;
        TypeInfo := APropInfo.PropType^;
      end;
  end;

var
  I: Integer;
begin
  Result := TList.Create;
  ATypeData := GetTypeData(APropInfo.PropType^);
  if (APropInfo.PropType^.Kind = tkMethod) then
  begin
    APos := 0;
    for i := 0 to ATypeData.ParamCount - 1 do
    begin
      Inc(APos);
      ReadString;
      AddParameter(ReadString, False);
    end;
    if ATypeData.MethodKind in [mkFunction, mkClassFunction] then
      AddParameter(ReadString, True);
  end
  else
  begin
    if (APropInfo.Index <> Integer($80000000)) then //has index
    begin
      AddParameter('Integer', False);
      PParamRec(Result.Last)^.Value[0] := Pointer(APropInfo.Index);
      PParamRec(Result.Last)^.IsIndexed := True;
    end;
    if AFlags and INVOKE_PROPERTYGET = INVOKE_PROPERTYGET then
      AddParameter('', True)
    else AddParameter('', False);
  end;
end;

function TcxScriptDispImpl.GetDelphiParamList(APropInfo: PPropInfo; Params: TDispParams; AFlags: Integer): TList;
var
  AParamCount: Integer;
  AValues: PVariantArgList;
  I: Integer;
  ASetParams: TList;
begin
  Result := CreateDelphiParamList(APropInfo, AFlags);
  AValues := Params.rgvarg;
  AParamCount := GetDelphiParamCount(Result);
  if AParamCount = Params.cArgs then
  begin
    ASetParams := TList.Create;
    GetDelphiParamCount(Result, False, ASetParams);
    for I := 0 to ASetParams.Count - 1 do
      with PParamRec(ASetParams[I])^ do
        GetPointerByVariant(PParamRec(ASetParams[I]), @Value[0], Variant(AValues[ASetParams.Count - 1 - I]));
    ASetParams.Free;
  end
  else
  begin
    DestroyDelphiParams(Result);
    Result := nil;
  end;
end;

function TcxScriptDispImpl.GetMethodDataAddress(APropInfo: PPropInfo): Pointer;
begin
   if (FOwner <> nil) and (GetPropInfo(FOwner, APropInfo.Name) = APropInfo) then
    Result := FOwner
  else Result := self;
end;

function TcxScriptDispImpl.InternalDirectParamInvoke(
      AMethodAddress, ADataAddress: Pointer; ADelphiParams: TList;
      AFlags: Integer; VarResult: Pointer): HResult;
var
  APointerValue: PPointer;
begin
  APointerValue := Pointer(Integer(ADataAddress) + (Integer(AMethodAddress) and $00FFFFFF));
  if AFlags and INVOKE_PROPERTYGET = INVOKE_PROPERTYGET then
  begin
    if VarResult <> nil then
      GetVariantByPointer(PParamRec(ADelphiParams.Last), APointerValue, PVariant(VarResult));
  end else
  begin
    SetInternalDirectParam(APointerValue, ADelphiParams);
  end;
  Result := S_OK;
end;

function TcxScriptDispImpl.InternalRegisterParamInvoke(
        AMethodAddress, ADataAddress: Pointer; ADelphiParams: TList;
      AFlags: Integer; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  AEAX, AEDX, AECX: Integer;
  ARegCount, AStackCount: Integer;
  AStack: Array[0..256] of Pointer;
  AStackValue: Pointer;
  ARetType: Byte;
  ARetByteCount: Integer;
  ARetIsCurrency: Byte;
  ARetIsByte: Byte;
  ARetIsWord: Byte;
  ARetIsShortString: Byte;
  ARetIsWideString: Byte;
  ARetExtended: Extended;
  ARetSt: String;
  ARetShortSt: ShortString;
  ARetWideSt: WideString;
  ARetVariant: Variant;
  I: Integer;
begin
  ARetType := GetReturnTypes(ADelphiParams);
  ARetIsCurrency := 0;
  ARetIsByte := 0;
  ARetIsWord := 0;
  ARetIsShortString := 0;
  ARetIsWideString := 0;
  ARetByteCount := 0;
  if (ARetType = 2) or (ARetType = 5) then
  begin
    ARetByteCount := GetByteCount(PParamRec(ADelphiParams.Last));
    if PParamRec(ADelphiParams.Last)^.FloatType in [ftCurr, ftComp] then
      ARetIsCurrency := 1;
  end
  else
    if ARetType = 3 then
    begin
      if PParamRec(ADelphiParams.Last)^.TypeKind = tkString then
        ARetIsShortString := 1
      else if PParamRec(ADelphiParams.Last)^.TypeKind = tkWString then
        ARetIsWideString := 1;
    end
    else
      if (ARetType = 1)  and (PParamRec(ADelphiParams.Last)^.TypeKind <> tkClass) then
      begin
        if PParamRec(ADelphiParams.Last)^.OrdType in [otUByte, otSByte] then
          ARetIsByte := 1
        else if PParamRec(ADelphiParams.Last)^.OrdType in [otUWord, otSWord] then
          ARetIsWord := 1;
      end;
  AEAX := Integer(ADataAddress);
  AEDX := 0;
  AECX := 0;
  PrepareFuncCall(ADelphiParams, AEDX, AECX, @AStack, ARegCount, AStackCount);
  for I := 0 to AStackCount - 1 do
  begin
    AStackValue := AStack[I];
    asm
      push dword ptr[AStackValue]
    end;
  end;
  asm
  @@finishsetupreg:
    cmp ARetType, 5 // is return value int64?
    je @@preparecallmethod
    cmp ARetType, 3  //is return value string?
    jb @@preparecallmethod
    jne @@assignvariant
    cmp ARetIsShortString, 1
    je @@AssignShortString
    cmp ARetIsWideString, 1
    je @@AssignWideString
    lea EAX, dword ptr [ARetSt] //Asssign String
    jmp @@AssignRetValToRightRegister
  @@AssignShortString:
    lea EAX, dword ptr [ARetShortSt] // Assign ShortString
    jmp @@AssignRetValToRightRegister
  @@AssignWideString:
    lea EAX, dword ptr [ARetWideSt] // Assign WideString
    jmp @@AssignRetValToRightRegister
  @@assignvariant:
    lea EAX, dword ptr [ARetVariant] //Assign Variant

                     //assign to the right register
  @@AssignRetValToRightRegister:
    cmp ARegCount, 1 //assign to EDX?
    ja @@assignRetValuetoEAX // ? > 1 (2)
    jb @@assignRetValuetoEDX  // ? < 1 (0)
    mov ECX, EAX // 1
    jmp @@preparecallmethod
  @@assignRetValuetoEDX:
    mov EDX, EAX
    jmp @@preparecallmethod
  @@assignRetValuetoEAX:
    push EAX

  @@preparecallmethod:
    mov EAX, AEAX      //pointer to the Owner or self
    cmp ARegCount, 0
    je @@callmethod
    mov EDX, AEDX     //first ord parameter
    cmp ARegCount, 1
    je @@callmethod
    mov ECX, AECX     //second ord parameter
  @@callmethod:
    call AMethodAddress //make the call

    cmp ARetType, 1    //get the return value: ord or complex, except string (ARetType in [1, 2, 3])
    je @@ret_eax
    cmp ARetType, 2
    je @@ret_stpf
    cmp AretType, 5
    je @@ret_eax_edx
    jmp @@exit
  @@ret_eax:
    cmp ARetIsByte, 1
    je @@ret_al
    cmp ARetIsWord, 1
    je @@ret_ax
    mov AEAX, EAX
    jmp @@exit
  @@ret_al:
    mov AEAX, 0
    mov byte ptr [AEAX], al
    jmp @@exit
  @@ret_ax:
    mov AEAX, 0
    mov word ptr [AEAX], ax
    jmp @@exit
  @@ret_eax_edx:
    mov AEAX, EAX
    mov AEDX, EDX
    jmp @@exit
  @@ret_stpf:
    cmp ARetByteCount, 2
    je @@ret_stpf_qword
    ja @@ret_stpf_tbyte
    fstp dword ptr [ARetExtended]
    jmp @@exit
  @@ret_stpf_qword:
    cmp ARetIsCurrency, 1
    je @@ret_currency
    fstp qword ptr [ARetExtended]
    jmp @@exit
  @@ret_currency:
    fistp qword ptr [ARetExtended]
    jmp @@exit
  @@ret_stpf_tbyte:
    fstp tbyte ptr [ARetExtended]
  @@exit:
  end;
  if (ARetType <> 0) and (VarResult <> nil) then
  begin
    case ARetType of
     1, 2:
       GetReturnValue(PParamRec(ADelphiParams.Last), AEAX, AEDX, @ARetExtended, PVariant(VarResult));
     3:
     begin
       if ARetIsShortString = 1 then
         GetReturnValue(PParamRec(ADelphiParams.Last), AEAX, AEDX, @ARetShortSt, PVariant(VarResult))
       else if ARetIsWideString = 1 then
         GetReturnValue(PParamRec(ADelphiParams.Last), AEAX, AEDX, @ARetWideSt, PVariant(VarResult))
       else
         GetReturnValue(PParamRec(ADelphiParams.Last), AEAX, AEDX, @ARetSt, PVariant(VarResult));
     end;
     4:
       GetReturnValue(PParamRec(ADelphiParams.Last), AEAX, AEDX, @ARetVariant, PVariant(VarResult));
     5:
       GetReturnValue(PParamRec(ADelphiParams.Last), AEAX, AEDX, @ARetExtended, PVariant(VarResult));
    end;
  end;
  Result := S_OK;
end;

procedure TcxScriptDispImpl.PrepareFuncCall(ADelphiParams: TList; var AEDX, AECX: Integer;
        AStack: PPointerArray; var ARegCount, AStackCount: Integer);
var
  I, J: Integer;
  AByteCount: Integer;
begin
  ARegCount := 0;
  AStackCount := 0;
  for I := 0 to GetDelphiParamCount(ADelphiParams, True) - 1 do
    with PParamRec(ADelphiParams[I])^ do
    begin
      if IsStackParam(ADelphiParams[I]) or (ARegCount = 2) or
          (TypeKind = tkInt64) then
      begin
        AByteCount := GetByteCount(PParamRec(ADelphiParams[I]));
        for J := AByteCount - 1 downto 0 do
        begin
          AStack^[AStackCount] := Value[J];
          Inc(AStackCount);
        end;
      end
 {     else if TypeKind = tkChar then
      begin
//        AEDX := (Value[0]);
      end}
      else
      begin
        case ARegCount of
          0: AEDX := Integer(Value[0]);
          1: AECX := Integer(Value[0]);
        end;
        Inc(ARegCount);
      end;
   end;
end;

function TcxScriptDispImpl.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
var
  i: Integer;
  APropInfo: PPropInfo;
begin
  Result := S_OK;
  for i := 0 to NameCount - 1 do
  begin
    if (FOwner <> nil) then
      APropInfo := GetPropInfo(FOwner, POleStrList(Names)^[I])
    else
      APropInfo := nil;

    if (APropInfo <> nil) and (APropInfo.PropType^.Kind = tkMethod) then
      APropInfo := nil;

    if APropInfo = nil then
      APropInfo := GetPropInfo(self, POleStrList(Names)^[I]);

    if (APropInfo = nil) and (FOwner <> nil) then   // Published class field
    begin
      APropInfo := FOwner.FieldAddress(string(POleStrList(Names)^[I]));
      if APropInfo <> nil then
        APropInfo := Pointer(Int64(APropInfo) or $FF000000);
    end;

    if APropInfo <> nil then
      PDispIDList(DispIDs)^[I] := Integer(APropInfo)
    else
    begin
      Result := DISP_E_UNKNOWNNAME;
      break;
    end;
  end;
end;

function TcxScriptDispImpl.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxScriptDispImpl.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TcxScriptDispImpl.IsNeedReturnDispatch(PropInfo: PPropInfo;
        ADelphiParams: TList): Boolean;
begin
  if PropInfo.PropType^.Kind = tkClass then
  begin
    if (ADelphiParams.Count > 0) then
      with PParamRec(ADelphiParams.Last)^ do
        Result := IsReturn
    else Result := True;
  end
  else
  begin
    if(PropInfo.PropType^.Kind = tkMethod) and
      (ADelphiParams.Count > 0) then
        with PParamRec(ADelphiParams.Last)^ do
          Result := IsReturn and (TypeKind = tkClass)
    else Result := False;
  end;
end;

function TcxScriptDispImpl.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
const
  DISPID_CLASSFIELD = -10;
var
  AMethodAddress: Pointer;
  ADelphiParams: TList;
  AIDispatchObject: TcxScriptDispImpl;
  PropInfo: PPropInfo;
begin
  PropInfo :=  nil;
  Result := S_OK;

  if Flags and INVOKE_PROPERTYSET <> 0 then
    Flags := INVOKE_PROPERTYSET;

  ADelphiParams := nil;
  if (DispID <> DISPID_NEWENUM) and (DispID and $FF000000 = $FF000000) then //Published class field
  begin
    TVarData(PVariant(VarResult)^).VType := varInteger;
    TVarData(PVariant(VarResult)^).VInteger := Integer(Pointer(Int64(DispID) xor $FF000000)^);
    DispID := DISPID_CLASSFIELD;
  end
  else
    if DispId = DISPID_NEWENUM then  //Enumerator
    begin
      if not IsSupportEnum then
      begin
        Result := DISP_E_UNKNOWNINTERFACE;
        Exit;
      end;
      TVarData(PVariant(VarResult)^).VType := varInteger;
      TVarData(PVariant(VarResult)^).VInteger := Integer(Pointer(GetEnumerator));
    end
    else
      if DispId = DISPID_VALUE then  //Default value
      begin
        if not IsSupportDefaultProperty then
        begin
          Result := DISP_E_MEMBERNOTFOUND;
          Exit;
        end;
        PropInfo := GetDefaultPropInfo;
      end
      else
        PropInfo := PPropInfo(DispId);

  if PropInfo <> nil then
  begin
    AMethodAddress := GetMethodAddress(PropInfo, Flags);
    if AMethodAddress = nil then
    begin
      Result := DISP_E_UNKNOWNINTERFACE;
      exit;
    end;

    ADelphiParams := GetDelphiParamList(PropInfo, TDispParams(Params), Flags);
    if ADelphiParams = nil then
    begin
      Result := DISP_E_BADPARAMCOUNT;
      exit;
    end;

    if (Integer(AMethodAddress) and $FF000000 = $FF000000) then
      Result := InternalDirectParamInvoke(AMethodAddress, GetMethodDataAddress(PropInfo),
          ADelphiParams, Flags, VarResult)
    else
      Result := InternalRegisterParamInvoke(AMethodAddress, GetMethodDataAddress(PropInfo),
          ADelphiParams, Flags, VarResult, ExcepInfo, ArgErr);
  end;

  if (DispId = DISPID_NEWENUM) or (DispId = DISPID_CLASSFIELD) or
    IsNeedReturnDispatch(PropInfo, ADelphiParams) then
  begin
    TVarData(VarResult^).VType := varDispatch;
    AIDispatchObject := ScriptDispFactory.GetDispatch(TObject(TVarData(VarResult^).VPointer));
    if AIDispatchObject <> nil then
    begin
{ TODO
      if (DispId = -4) or (ADelphiParams <> nil) and (ADelphiParams.Count = 1) then
      begin
        Result := IDispatch(AIDispatchObject).Invoke(0, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
        if Result <> S_OK then
          TVarData(VarResult^).VDispatch := nil;
      end
      else
}
     begin
        if (TObject(TVarData(VarResult^).VPointer) is TComponent)
          and (TComponent(TVarData(VarResult^).VPointer).GetParentComponent = Component) then
          AIDispatchObject.FComponent := Component;
        TVarData(VarResult^).VDispatch := Pointer(AIDispatchObject as IDispatch);
      end;
    end
    else
      TVarData(VarResult^).VDispatch := nil;
  end;

  if ADelphiParams <> nil then
    DestroyDelphiParams(ADelphiParams);
end;

function TcxScriptDispImpl.GetDispOwner: TComponent;
begin
  if FIsOwnerComponent then
    Result := TComponent(FOwner)
  else Result := FComponent;
end;


procedure TcxScriptDispImpl.SetInternalDirectParam(APointerValue: PPointer;
    AParams: TList);
var
  ATempPointerValue: PPointer;
begin
  ATempPointerValue := APointerValue;
  case PParamRec(AParams[0])^.TypeKind of
    tkInteger, tkEnumeration:
    begin
      case PParamRec(AParams[0])^.OrdType of
        otSByte, otUByte:
          Move(PParamRec(AParams[0])^.Value[0], ATempPointerValue^, 1);
        otSWord, otUWord:
          Move(PParamRec(AParams[0])^.Value[0], ATempPointerValue^, 2);
        else
          ATempPointerValue^ := PParamRec(AParams[0])^.Value[0];
      end;
    end;
    tkFloat:
    begin
      ATempPointerValue^ := PParamRec(AParams[0])^.Value[0];
      case PParamRec(AParams[0])^.FloatType of
        ftDouble, ftComp, ftCurr, ftExtended:
        begin
          Inc(ATempPointerValue);
          ATempPointerValue^ := PParamRec(AParams[0])^.Value[1];
          case PParamRec(AParams[0])^.FloatType of
            ftExtended:
            begin
              Inc(ATempPointerValue);
              Move(PParamRec(AParams[0])^.Value[2], ATempPointerValue^, 2)
            end;
          end;
        end;
      end;
    end;
    tkInt64:
    begin
      ATempPointerValue^ := PParamRec(AParams[0])^.Value[0];
      Inc(ATempPointerValue);
      ATempPointerValue^ := PParamRec(AParams[0])^.Value[1];
    end;
    tkChar:
      PChar(ATempPointerValue)^ := PParamRec(AParams[0])^.StringValue[1];
    tkWChar:
      PWChar(ATempPointerValue)^ := WideChar(PParamRec(AParams[0])^.StringValue[1]);
    tkString:
      PShortString(ATempPointerValue)^ := PShortString(PParamRec(AParams[0])^.Value[0])^;
    tkWString:
      PWideString(ATempPointerValue)^ := PParamRec(AParams[0])^.WideStringValue;
    else
      ATempPointerValue^ := PParamRec(AParams[0])^.Value[0];
  end;
end;

function TcxScriptDispStringsImpl.GetEnumerator: TcxScriptDispEnumImp;
begin
  Result := TcxScriptDispEnumImp.Create(Self);
end;

function TcxScriptDispStringsImpl.GetCollectionCount: Integer;
begin
  Result := Strings.Count;
end;

function TcxScriptDispStringsImpl.GetCollectionValue(
  Index: Integer): OleVariant;
begin
  Result := Strings.Strings[Index];
end;


function TcxScriptDispStringsImpl.GetDefaultPropInfo: PPropInfo;
begin
  Result := GetPropertyInfo(Self, 'Add');
end;

{ TcxScriptDispPersistentImpl }

constructor TcxScriptDispPersistentImpl.Create(AOwner: TObject);
begin
  inherited Create(AOwner);

  FDispatch_GetNamePath := Dispatch_GetNamePath;
  FDispatch_Assign := Dispatch_Assign;
end;

procedure TcxScriptDispPersistentImpl.Dispatch_Assign(Source: TPersistent);
begin
  Persistent.Assign(Source);
end;


function TcxScriptDispPersistentImpl.Dispatch_GetNamePath: string;
begin
  Result := Persistent.GetNamePath;
end;


class function TcxScriptDispPersistentImpl.GetObjectClass: TClass;
begin
  Result := TPersistent;
end;

function TcxScriptDispPersistentImpl.Persistent: TPersistent;
begin
  if Owner is TPersistent then
    Result := TPersistent(Owner)
  else Result := nil;
end;

{ TcxScriptDispCollectionItemImpl }

constructor TcxScriptDispCollectionItemImpl.Create(AOwner: TObject);
begin
  inherited;
end;

function TcxScriptDispCollectionItemImpl.GetCollection: TCollection;
begin
  Result := CollectionItem.Collection;
end;

function TcxScriptDispCollectionItemImpl.GetDisplayName: string;
begin
  Result := CollectionItem.DisplayName;
end;

function TcxScriptDispCollectionItemImpl.GetID: Integer;
begin
  Result := CollectionItem.ID;
end;

function TcxScriptDispCollectionItemImpl.GetIndex: Integer;
begin
  Result := CollectionItem.Index;
end;

function TcxScriptDispCollectionItemImpl.GetNamePath__: string;
begin
  Result := CollectionItem.GetNamePath;
end;

class function TcxScriptDispCollectionItemImpl.GetObjectClass: TClass;
begin
  Result := TCollectionItem;
end;

procedure TcxScriptDispCollectionItemImpl.SetCollection(const Value: TCollection);
begin
  CollectionItem.Collection := Value;
end;

procedure TcxScriptDispCollectionItemImpl.SetDisplayName(const Value: string);
begin
  CollectionItem.DisplayName := Value;
end;

procedure TcxScriptDispCollectionItemImpl.SetIndex(const Value: Integer);
begin
  CollectionItem.Index := Value;
end;

function TcxScriptDispCollectionItemImpl.CollectionItem: TCollectionItem;
begin
  if Owner is TCollectionItem then
    Result := TCollectionItem(Owner)
  else Result := nil;
end;

{ TcxScriptDispCollectionImpl }

constructor TcxScriptDispCollectionImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_Add := Dispatch_Add;
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_Delete := Dispatch_Delete;
  FDispatch_Insert := Dispatch_Insert;
  FDispatch_Items := Dispatch_Items;
  FDispatch_FindItemID := Dispatch_FindItemID;
end;

function TcxScriptDispCollectionImpl.Dispatch_Add: TCollectionItem;
begin
  Result := Collection.Add;
end;

procedure TcxScriptDispCollectionImpl.Dispatch_Clear;
begin
  Collection.Clear;
end;

procedure TcxScriptDispCollectionImpl.Dispatch_Delete(Index: Integer);
begin
  Collection.Delete(Index);
end;

function TcxScriptDispCollectionImpl.Dispatch_Insert(Index: Integer): TCollectionItem;
begin
  Result := Collection.Insert(Index);
end;

function TcxScriptDispCollectionImpl.Dispatch_Items(Index: Integer): TCollectionItem;
begin
  Result := Collection.Items[Index];
end;

function TcxScriptDispCollectionImpl.Dispatch_FindItemID(Index: Integer): TCollectionItem;
begin
  Result := Collection.FindItemID(Index);
end;


function TcxScriptDispCollectionImpl.GetCount: Integer;
begin
  Result := Collection.Count;
end;

function TcxScriptDispCollectionImpl.GetOwner_: TPersistent;
begin
  Result := Collection.Owner;
end;

class function TcxScriptDispCollectionImpl.GetObjectClass: TClass;
begin
  Result := TCollection;
end;

function TcxScriptDispCollectionImpl.Collection: TCollection;
begin
  if Owner is TCollection then
    Result := Owner as TCollection
  else Result := nil;
end;

{ TcxScriptDispComponentImpl }

constructor TcxScriptDispComponentImpl.Create(AOwner: TObject);
begin
  inherited Create(AOwner);

  FDispatch_BeforeDestruction := Dispatch_BeforeDestruction;
  FDispatch_DestroyComponents := Dispatch_DestroyComponents;
  FDispatch_Destroying := Dispatch_Destroying;
  FDispatch_ExecuteAction := Dispatch_ExecuteAction;
  FDispatch_FindComponent := Dispatch_FindComponent;
  FDispatch_FreeNotification := Dispatch_FreeNotification;
  FDispatch_RemoveFreeNotification := Dispatch_RemoveFreeNotification;
  FDispatch_FreeOnRelease := Dispatch_FreeOnRelease;
  FDispatch_GetParentComponent := Dispatch_GetParentComponent;
  FDispatch_GetNamePath := Dispatch_GetNamePath;
  FDispatch_HasParent := Dispatch_HasParent;
  FDispatch_InsertComponent := Dispatch_InsertComponent;
  FDispatch_RemoveComponent := Dispatch_RemoveComponent;
  FDispatch_SetSubComponent := Dispatch_SetSubComponent;
  FDispatch_SafeCallException := Dispatch_SafeCallException;
  FDispatch_UpdateAction := Dispatch_UpdateAction;
  FDispatch_IsImplementorOf := Dispatch_IsImplementorOf;
  FDispatch_ReferenceInterface := Dispatch_ReferenceInterface;
  FDispatch_GetComponents := Dispatch_GetComponents; 
end;

procedure TcxScriptDispComponentImpl.Dispatch_BeforeDestruction;
begin
  Component.BeforeDestruction;
end;

procedure TcxScriptDispComponentImpl.Dispatch_DestroyComponents;
begin
  Component.DestroyComponents;
end;

procedure TcxScriptDispComponentImpl.Dispatch_Destroying;
begin
  Component.Destroying;
end;

function TcxScriptDispComponentImpl.Dispatch_ExecuteAction(
  Action: TBasicAction): Boolean;
begin
  Result := Component.ExecuteAction(Action);
end;

function TcxScriptDispComponentImpl.Dispatch_FindComponent(
  const AName: string): TComponent;
begin
  Result := Component.FindComponent(AName);
end;

procedure TcxScriptDispComponentImpl.Dispatch_FreeNotification(
  AComponent: TComponent);
begin
  Component.FreeNotification(AComponent);
end;

procedure TcxScriptDispComponentImpl.Dispatch_FreeOnRelease;
begin
  Component.FreeOnRelease;
end;

function TcxScriptDispComponentImpl.Dispatch_GetComponents(
  Index: Integer): TComponent;
begin
  Result := Component.Components[Index];
end;

function TcxScriptDispComponentImpl.Dispatch_GetNamePath: string;
begin
  Result := Component.GetNamePath;
end;

function TcxScriptDispComponentImpl.Dispatch_GetParentComponent: TComponent;
begin
  Result := Component.GetParentComponent;
end;

function TcxScriptDispComponentImpl.Dispatch_HasParent: Boolean;
begin
  Result := Component.HasParent; 
end;

procedure TcxScriptDispComponentImpl.Dispatch_InsertComponent(
  AComponent: TComponent);
begin
  Component.InsertComponent(AComponent);
end;

function TcxScriptDispComponentImpl.Dispatch_IsImplementorOf(
  const I: IInterface): Boolean;
begin
  Result := Component.IsImplementorOf(I);
end;

function TcxScriptDispComponentImpl.Dispatch_ReferenceInterface(
  const I: IInterface; Operation: TOperation): Boolean;
begin
  Result := Component.ReferenceInterface(I, Operation);
end;

procedure TcxScriptDispComponentImpl.Dispatch_RemoveComponent(
  AComponent: TComponent);
begin
  Component.RemoveComponent(AComponent);
end;

procedure TcxScriptDispComponentImpl.Dispatch_RemoveFreeNotification(
  AComponent: TComponent);
begin
  Component.RemoveFreeNotification(AComponent);
end;

function TcxScriptDispComponentImpl.Dispatch_SafeCallException(
  ExceptObject: TObject; ExceptAddr: Pointer): HResult;
begin
  Result := Component.SafeCallException(ExceptObject, ExceptAddr);
end;

procedure TcxScriptDispComponentImpl.Dispatch_SetSubComponent(
  IsSubComponent: Boolean);
begin
  Component.SetSubComponent(IsSubComponent);
end;

function TcxScriptDispComponentImpl.Dispatch_UpdateAction(
  Action: TBasicAction): Boolean;
begin
  Result := Component.UpdateAction(Action);
end;

{
function TcxScriptDispComponentImpl.GetComponent: TComponent;
begin
  if Owner is TComponent then
    Result := TComponent(Owner)
  else
    Result := nil;
end;
}

function TcxScriptDispComponentImpl.GetComponentCount: Integer;
begin
  Result := Component.ComponentCount;
end;

function TcxScriptDispComponentImpl.GetComponentIndex: Integer;
begin
  Result := Component.ComponentIndex;
end;

function TcxScriptDispComponentImpl.GetComponentState: TComponentState;
begin
  Result := Component.ComponentState;
end;

function TcxScriptDispComponentImpl.GetComponentStyle: TComponentStyle;
begin
  Result := Component.ComponentStyle;
end;

class function TcxScriptDispComponentImpl.GetObjectClass: TClass;
begin
  Result := TComponent;
end;

function TcxScriptDispComponentImpl.GetOwner: TComponent;
begin
  Result := Component.Owner;
end;

procedure TcxScriptDispComponentImpl.SetComponentIndex(
  aComponentIndex: Integer);
begin
  Component.ComponentIndex := aComponentIndex;
end;

{ TcxScriptDispCustomEnumImp }

function TcxScriptDispEnumImp.Dispatch_Clone(out Enum: IEnumVariant): HResult;
var
  NewEnumerator: TcxScriptDispEnumImp;
begin
  try
    NewEnumerator := TcxScriptDispEnumImp.CreateClone(Collection, FIndex);
  except
    Result := E_OUTOFMEMORY;
    Exit;
  end;
  Enum := NewEnumerator as IEnumVariant;
  Result := S_OK;
end;

constructor TcxScriptDispEnumImp.Create(ACollection: TcxScriptDispImpl);
begin
  inherited Create(ACollection);

  FIndex := 0;
  FDispatch_Next := Dispatch_Next;
  FDispatch_Skip := Dispatch_Skip;
  FDispatch_Reset := Dispatch_Reset;
  FDispatch_Clone := Dispatch_Clone;
end;

{function TcxScriptDispEnumImp.Dispatch_Next(celt: LongWord;
  var rgvar: OleVariant; out pceltFetched: LongWord): HResult;
var
  I: Integer;
  LocalCeltFetched: LongWord;
  VarArrayBounds: array of Integer;
  NewIndexValue: Integer;
begin
  SetLength(VarArrayBounds, 2);
  VarArrayBounds[0] := 0;
  VarArrayBounds[1] := Integer(celt - 1);
  VariantInit(rgvar);
  rgvar := VarArrayCreate(VarArrayBounds, varVariant);

  Result := S_OK;
  if Collection.GetCollectionCount <= 0 then
  begin
    NewIndexValue := 0;
    LocalCeltFetched := 0;
  end
  else
  begin
    NewIndexValue := FIndex + celt;
    LocalCeltFetched := celt;

    for I := 0 to celt - 1 do
    begin
      if FIndex + I < Collection.GetCollectionCount then
        rgvar[I] := Collection.GetCollectionValue(FIndex + I)
      else
      begin
        NewIndexValue := Collection.GetCollectionCount - 1;
        LocalCeltFetched := I;
        VariantClear(rgvar);
        Result := S_FALSE;
        Break;
      end;
    end;
  end;

  FIndex := NewIndexValue;
  if @pceltFetched <> nil then
    pceltFetched := LocalCeltFetched;
  VarArrayBounds := nil;
end;}

function TcxScriptDispEnumImp.Dispatch_Next(celt: LongWord;
  var rgvar: OleVariant; out pceltFetched: LongWord): HResult;
var
  LocalCeltFetched: LongWord;
begin
  if celt > 1 then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;

  Result := S_OK;
  if Collection.GetCollectionCount <= 0 then
    LocalCeltFetched := 0
  else
  begin
    VariantInit(rgvar);

    if FIndex < Collection.GetCollectionCount then
    begin
      rgvar := Collection.GetCollectionValue(FIndex);
      Inc(FIndex);
      LocalCeltFetched := 1;
    end
    else
    begin
      VariantClear(rgvar);
      LocalCeltFetched := 0;
      Result := S_FALSE;
    end;
  end;

  if @pceltFetched <> nil then
    pceltFetched := LocalCeltFetched;
end;

function TcxScriptDispEnumImp.Dispatch_Reset: HResult;
begin
  FIndex := 0;
  Result := S_OK;
end;

function TcxScriptDispEnumImp.Dispatch_Skip(celt: LongWord): HResult;
begin
  FIndex := FIndex + Integer(celt);
  if FIndex >= Collection.GetCollectionCount then
  begin
    FIndex := Collection.GetCollectionCount - 1;
    Result := S_FALSE;
  end
  else
    Result := S_OK;
end;

{ TcxScriptDispStringsEnumImp }

function TcxScriptDispImpl.GetEnumerator: TcxScriptDispEnumImp;
begin
  Result := nil;
end;

function TcxScriptDispImpl.IsSupportEnum: Boolean;
var
  Enum: TcxScriptDispEnumImp;
begin
  Enum := GetEnumerator;
  if Enum <> nil then
  begin
    Result := True;
    Enum.Free;
  end
  else
    Result := False;
end;

function TcxScriptDispEnumImp.GetCollection: TcxScriptDispImpl;
begin
  if FOwner is TcxScriptDispImpl then
    Result := TcxScriptDispImpl(FOwner)
  else
    Result := nil;
end;

constructor TcxScriptDispEnumImp.CreateClone(
  ACollection: TcxScriptDispImpl; AIndex: Integer);
begin
  inherited Create(ACollection);

  FIndex := AIndex;
  FDispatch_Next := Dispatch_Next;
  FDispatch_Skip := Dispatch_Skip;
  FDispatch_Reset := Dispatch_Reset;
  FDispatch_Clone := Dispatch_Clone;
end;

function TcxScriptDispImpl.GetDefaultPropInfo: PPropInfo;
begin
  Result := nil;
end;

function TcxScriptDispImpl.IsSupportDefaultProperty: Boolean;
begin
  if GetDefaultPropInfo = nil then
    Result := False
  else
    Result := True;
end;

function TcxScriptDispImpl.GetPropertyInfo(AObject: TObject; APropName: string): PPropInfo;
begin
  Result := GetPropInfo(AObject.ClassInfo, APropName);
end;

function TcxScriptDispImpl.GetCollectionCount: Integer;
begin
  Result := 0;
end;

function TcxScriptDispImpl.GetCollectionValue(Index: Integer): OleVariant;
begin
  Result := OleVariant(0);
end;

initialization
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispStringsImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispPersistentImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispCollectionItemImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispCollectionImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispComponentImpl);

end.
