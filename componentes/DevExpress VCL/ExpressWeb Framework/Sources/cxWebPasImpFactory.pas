{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Pascal script importers factory                             }
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
unit cxWebPasImpFactory;

interface

uses
  Classes, SysUtils, Contnrs, 
  ifps3, ifpscomp, ifpiclass, ifpiclassruntime;

type
  TClassEnumProc = procedure(AClass: TClass; AObject: TObject);

  TcxPascalScriptImporter = class
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); virtual;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); virtual;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); virtual;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); virtual;
  public
    class procedure CompileTimeRegistration(AImporter: TIFPSCompileTimeClassesImporter);
    class procedure RunTimeRegistration(AImporter: TIFPSRuntimeClassImporter);
    class function ObjectClass: TClass; virtual;
  end;

  TcxPascalScriptImporterClass = class of TcxPascalScriptImporter;

  TcxPascalScriptImporterFactory = class
  private
    FClassList: TStringList;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxPascalScriptImporterFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxPascalScriptImporterFactory;
    class procedure ReleaseInstance;

    function GetImporterClass(AObjectClass: TClass): TcxPascalScriptImporterClass; overload;
    function GetImporterClass(AObject: TObject): TcxPascalScriptImporterClass; overload;
    procedure GetImporterClassList(const AUnitName: string; AClassList: TClassList);
    procedure RegisterImporter(AImporterClass: TcxPascalScriptImporterClass; const AVirtualUnit: string);
    procedure UnregisterImporter(AImporterClass: TcxPascalScriptImporterClass);
  end;

function cxPasScriptImpFactory: TcxPascalScriptImporterFactory;
function cxCTRegisterClass(AImporter: TIFPSCompileTimeClassesImporter;
  AClass: TClass): TIFPSCompileTimeClass;
function cxRTRegisterClass(AImporter: TIFPSRuntimeClassImporter;
  AClass: TClass): TIFPSRuntimeClass;

const
  scxStringType = 'string'; //do not localize
  scxStringsType = 'TStrings'; //do not localize
  scxIntegerType = 'Integer'; //do not localize
  scxByteType = 'Byte'; //do not localize
  scxBooleanType = 'Boolean'; //do not localize
  scxDateTimeType = 'TDateTime'; //do not localize
  scxVariantType = 'Variant'; //do not localize
  scxComponentType = 'TComponent'; //do not localize

implementation

uses
  cxWebScript;

function cxCTRegisterClass(AImporter: TIFPSCompileTimeClassesImporter;
  AClass: TClass): TIFPSCompileTimeClass;
var
  ParentClass: TClass;
  ParentCTClass: TIFPSCompileTimeClass;
begin
  Result := nil;
  if AImporter.FindClass(AClass.ClassName) <> nil then Exit;
  ParentClass := AClass.ClassParent;
  ParentCTClass := nil;
  while (ParentCTClass = nil) and (ParentClass <> nil) do
  begin
    ParentCTClass := AImporter.FindClass(ParentClass.ClassName);
    ParentClass := ParentClass.ClassParent;
  end;
  Result := AImporter.Add(ParentCTClass, AClass);
end;

function cxRTRegisterClass(AImporter: TIFPSRuntimeClassImporter;
  AClass: TClass): TIFPSRuntimeClass;
begin
  if AImporter.FindClass(UpperCase(AClass.ClassName)) = nil then
    Result := AImporter.Add(AClass)
  else
    Result := nil;
end;

{ TcxPascalScriptImporter }

procedure DeclareAndRegisterDependentClass(AClass: TClass; AObject: TObject);
var
  ScriptImp: TcxPascalScriptImporterClass;
begin
  ScriptImp := cxPasScriptImpFactory.GetImporterClass(AClass);
  if ScriptImp <> nil then
  begin
    if AObject is TIFPSCompileTimeClassesImporter then
      ScriptImp.CompileTimeRegistration(AObject as TIFPSCompileTimeClassesImporter);
    if AObject is TIFPSRuntimeClassImporter then
      ScriptImp.RunTimeRegistration(AObject as TIFPSRuntimeClassImporter);
  end;
end;

class procedure TcxPascalScriptImporter.CompileTimeRegistration(
  AImporter: TIFPSCompileTimeClassesImporter);
var
  CTClass: TIFPSCompileTimeClass;
begin
  if ClassParent.InheritsFrom(TcxPascalScriptImporter) then
    TcxPascalScriptImporterClass(ClassParent).CompileTimeRegistration(AImporter);
  CTClass := cxCTRegisterClass(AImporter, ObjectClass);
  if CTClass <> nil then
  begin
    DeclareTypes(AImporter.SE);
    EnumDependentClasses(DeclareAndRegisterDependentClass, AImporter);
    CTClass.RegisterPublishedProperties;
    DeclareClassMembers(CTClass);
  end;
end;

class procedure TcxPascalScriptImporter.RunTimeRegistration(
  AImporter: TIFPSRuntimeClassImporter);
var
  RTClass: TIFPSRuntimeClass;
begin
  RTClass := cxRTRegisterClass(AImporter, ObjectClass);
  if RTClass <> nil then
  begin
    EnumDependentClasses(DeclareAndRegisterDependentClass, AImporter);
    RegisterClassMembers(RTClass);
  end;  
end;

class function TcxPascalScriptImporter.ObjectClass: TClass;
begin
  Result := TObject;
end;

class procedure TcxPascalScriptImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
end;

class procedure TcxPascalScriptImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
end;

class procedure TcxPascalScriptImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
end;

class procedure TcxPascalScriptImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
end;

{ TcxScriptDispClassFactory }

var
  FPasScriptImpFactoryInstance: TcxPascalScriptImporterFactory = nil;

function cxPasScriptImpFactory: TcxPascalScriptImporterFactory;
begin
  Result := TcxPascalScriptImporterFactory.Instance;
end;

constructor TcxPascalScriptImporterFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxPascalScriptImporterFactory.Destroy;
begin
  FClassList.Free;
  inherited Destroy;
end;

constructor TcxPascalScriptImporterFactory.CreateInstance(ADummy: Boolean = True);
begin
  FClassList := TStringList.Create;
end;

class function TcxPascalScriptImporterFactory.AccessInstance(Request: Integer): TcxPascalScriptImporterFactory;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FPasScriptImpFactoryInstance) then FPasScriptImpFactoryInstance := CreateInstance;
    2 : FreeAndNil(FPasScriptImpFactoryInstance);
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FPasScriptImpFactoryInstance;
end;

class function TcxPascalScriptImporterFactory.Instance: TcxPascalScriptImporterFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxPascalScriptImporterFactory.ReleaseInstance;
begin
  AccessInstance(2);
end;

procedure TcxPascalScriptImporterFactory.RegisterImporter(
  AImporterClass: TcxPascalScriptImporterClass; const AVirtualUnit: string);
begin
  if FClassList.IndexOfObject(TObject(AImporterClass)) < 0 then
    FClassList.AddObject(AVirtualUnit, TObject(AImporterClass));
end;

procedure TcxPascalScriptImporterFactory.UnregisterImporter(
  AImporterClass: TcxPascalScriptImporterClass);
var
  Index: Integer;
begin
  Index := FClassList.IndexOfObject(TObject(AImporterClass));
  if Index <> -1 then
    FClassList.Delete(Index);
end;

function TcxPascalScriptImporterFactory.GetImporterClass(
  AObjectClass: TClass): TcxPascalScriptImporterClass;
var
  I: Integer;
  ACurrent: TcxPascalScriptImporterClass;
begin
  Result := nil;
  if AObjectClass = nil then exit;

  for I := 0 to FClassList.Count - 1 do
  begin
    ACurrent := TcxPascalScriptImporterClass(FClassList.Objects[I]);
    if AObjectClass.InheritsFrom(ACurrent.ObjectClass) then
      if (Result = nil) or
        not Result.ObjectClass.InheritsFrom(ACurrent.ObjectClass) then
        Result := ACurrent;

    if (Result <> nil) and (Result.ObjectClass = AObjectClass) then
      break;
  end;
end;

function TcxPascalScriptImporterFactory.GetImporterClass(
  AObject: TObject): TcxPascalScriptImporterClass;
begin
  if AObject <> nil then
    Result := GetImporterClass(AObject.ClassType)
  else
    Result := nil;
end;

procedure TcxPascalScriptImporterFactory.GetImporterClassList(
  const AUnitName: string; AClassList: TClassList);
var
  I: Integer;
begin
  if AUnitName = '' then Exit;
  for I := 0 to FClassList.Count - 1 do
    if SameText(FClassList[I], AUnitName) then
      AClassList.Add(TClass(FClassList.Objects[I]));
end;

initialization

finalization
  TcxPascalScriptImporterFactory.ReleaseInstance;

end.
