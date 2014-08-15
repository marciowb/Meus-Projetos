{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
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
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxTabbedMDIReg;

{$I cxVer.inc}

interface

procedure Register;

implementation

uses
  Classes, TypInfo, DesignIntf, DesignEditors, dxCore, dxCoreReg, dxBarReg,
  dxTabbedMDI, cxPC, cxClasses, cxPCGoDialog, cxLibraryReg;

type
  { TdxTabbedMDIManagerComponentEditor }

  TdxTabbedMDIManagerComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
  end;

  { TdxTabbedMDIManagerSelectionEditor }

  TdxTabbedMDIManagerSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

{ TdxTabbedMDIManagerComponentEditor }

function TdxTabbedMDIManagerComponentEditor.GetProductMajorVersion: string;
begin
  Result := dxBarMajorVersion;
end;

function TdxTabbedMDIManagerComponentEditor.GetProductName: string;
begin
  Result := dxBarProductName; 
end;

{ TdxTabbedMDIManagerSelectionEditor }

procedure TdxTabbedMDIManagerSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('cxPC');
  dxSkinsRequiresAdditionalUnits(TcxPageControl, Proc);
  if cxPCInternalPopupMenuClass <> TcxPCInternalPopupMenu then
    Proc(cxGetUnitName(cxPCInternalPopupMenuClass));
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}
  RegisterComponents('ExpressBars', [TdxTabbedMDIManager]);
  RegisterComponentEditor(TdxTabbedMDIManager, TdxTabbedMDIManagerComponentEditor);
  RegisterSelectionEditor(TdxTabbedMDIManager, TdxTabbedMDIManagerSelectionEditor);
end;

end.
