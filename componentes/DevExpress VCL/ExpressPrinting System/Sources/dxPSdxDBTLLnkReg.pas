{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSdxDBTLLnkReg;

interface

{$I cxVer.inc}

procedure Register;

implementation

uses
   {$IFDEF DELPHI6} 
    DesignIntf, DesignEditors,
   {$ELSE}
    DsgnIntf, 
   {$ENDIF}  
  Classes, dxPSdxTLLnk, dxPSdxDBTLLnk;

type
  TdxDBTreeListOptionsPropertyEditor = class(TSetProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

function TdxDBTreeListOptionsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TdxDBTreeListOptionsPropertyEditor.Edit;
var
  I: Integer;
begin
  inherited;
  if TdxDBTreeListReportLink(GetComponent(0)).DesignReport then
  begin
    Designer.Modified;
    if PropCount > 1 then
      for I := 1 to PropCount - 1 do
        GetComponent(I).Assign(GetComponent(0));
  end;
end;

procedure Register;
begin
  RegisterNoIcon([TdxDBTreeListReportLink]);
  RegisterPropertyEditor(TypeInfo(TdxTreeListPaintOptions),
    TdxDBTreeListReportLink, 'Options', TdxDBTreeListOptionsPropertyEditor);
end;

end.

