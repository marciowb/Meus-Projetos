{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Snap Support                                            }
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
unit cxWebSnapReg;

interface

procedure Register;

implementation

uses Classes, SysUtils, DesignIntf, DesignEditors, WebComp, MidItems, TypInfo,
  cxWebSnapModule, cxWebDsgnModule, cxWebSnapAdapter, cxWebSnapModuleWizard,
  cxWebDsgnUtils, cxWebDsgnBaseModules;

type

TWebSnapControlProperty = class(TComponentProperty)
private
  FGetValuesStrProc: TGetStrProc;
protected
  procedure ReceiveComponentNames(const S: string);
public
  procedure GetValues(Proc: TGetStrProc); override;
end;

{ TWebSnapControlProperty }
procedure TWebSnapControlProperty.ReceiveComponentNames(const S: string);
var
  Temp: TComponent;
begin
  Temp := Designer.GetComponent(S);
  if Assigned(FGetValuesStrProc) and Assigned(Temp)
  and TcxWebSnapControlAdapter.IsWebSnapControlSupported(Temp) then
    FGetValuesStrProc(S);
end;

procedure TWebSnapControlProperty.GetValues(Proc: TGetStrProc);
begin
  FGetValuesStrProc := Proc;
  try
    Designer.GetComponentNames(GetTypeData(TypeInfo(TComponent)), ReceiveComponentNames);
  finally
    FGetValuesStrProc := nil;
  end;
end;

procedure Register;
begin
  RegisterCustomModule(TcxWebSnapPageModule, TcxCustomWebPageModuleDesigner);
  cxWebRegisterBasePageModule(TcxWebSnapPageModule);

  cxRegisterWebComponents('EWF Controls', [TcxWebSnapControlAdapter], True);
  RegisterPropertyEditor(TypeInfo(TComponent), TcxWebSnapControlAdapter, 'WebSnapControl', TWebSnapControlProperty);
end;

end.
