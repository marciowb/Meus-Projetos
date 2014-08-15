{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express RTTI Inspector Registration	                    }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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

unit dxOIReg;

{$I dxInsVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 {$IFDEF DELPHI6}DesignIntf, DesignEditors, VCLEditors{$ELSE} DsgnIntf{$ENDIF};
procedure Register;

implementation

uses dxOI, TypInfo, EditIntf{$IFDEF DELPHI6}, ComponentDesigner{$ENDIF};

type
  TdxOIPropertyEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TdxOIPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TdxOIPropertyEditor.GetValues(Proc: TGetStrProc);

  procedure FillList(AComponent: TComponent);
  var
    I: Integer;
  begin
     if (AComponent.Name <> '') and (AComponent <> GetComponent(0)) then
       Proc(AComponent.Name);
     for i := 0 to AComponent.ComponentCount - 1 do
       FillList(AComponent.Components[I]);
  end;

begin
   FillList(Designer.GetRoot);
end;

function TdxOIPropertyEditor.GetValue: string;
var
  OI: TCustomdxRTTIInspector;
begin
  Result := '';
  OI := TCustomdxRTTIInspector(GetComponent(0));
  if OI.InspectedObject <> nil then
  begin
    if OI.InspectedObject is TComponent then
      Result := OI.InspectedObject.GetNamePath;
  end;
end;


procedure TdxOIPropertyEditor.SetValue(const Value: string);

   function GetValueComponent: TComponent;
   begin
     if CompareText(Value, Designer.GetRoot.Name) = 0 then
       Result := Designer.GetRoot
     else Result := Designer.GetRoot.FindComponent(Value);
     if Result = nil then
       Result := Application.FindComponent(Value);
     if Result = GetComponent(0) then
       Result := nil;
   end;
var
  OI: TCustomdxRTTIInspector;
begin
  OI := TCustomdxRTTIInspector(GetComponent(0));
  if Value = '' then
    OI.InspectedObject := nil
  else
  begin
    if GetValueComponent <> nil then
      OI.InspectedObject := GetValueComponent;
  end;
  Modified;
end;

procedure Register;
begin
  RegisterComponents('Dev Express', [TdxRTTIInspector]);
  RegisterPropertyEditor(TypeInfo(TPersistent), TCustomdxRTTIInspector, 'InspectedObject',
    TdxOIPropertyEditor);
end;

end.
