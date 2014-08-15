{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid Utils                                     }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridUICustomTableHelper;

{$I cxGridUtils.inc}

interface

uses
  Classes, SysUtils, cxGrid, cxGridCustomView, cxGridUIHelper,
  cxGridCustomTableView;

type
  TcxGridCustomTableViewOperationHelper = class(TcxCustomGridViewOperationHelper)
  protected
    procedure RegisterOperations; override;
    procedure DoCopyToClipboard(const AParameter: TcxCustomGridOperationHelperParameters);
    procedure DoShowEditButtons(const AParameter: TcxCustomGridOperationHelperParameters);
  public
    class function GetViewClass: TcxCustomGridViewClass; override;
  end;

implementation

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  cxGridTableView, DB, cxGridDBDataDefinitions;

{ TcxGridCustomTableViewOperationHelper }
procedure TcxGridCustomTableViewOperationHelper.RegisterOperations;
begin
  inherited RegisterOperations;
  RegisterOperation(GROP_SHOWEDITBUTTONS, DoShowEditButtons);
  RegisterOperation(GROP_COPYTOCLIPBOARD, DoCopyToClipboard);
end;

type
TcxCustomGridTableViewAccess = class(TcxCustomGridTableView);

procedure TcxGridCustomTableViewOperationHelper.DoCopyToClipboard(
  const AParameter: TcxCustomGridOperationHelperParameters);
begin
  TcxCustomGridTableView(AParameter.View).CopyToClipboard(False);
end;

procedure TcxGridCustomTableViewOperationHelper.DoShowEditButtons(
  const AParameter: TcxCustomGridOperationHelperParameters);
const
  ShowEditButtonsToBool: Array[TcxGridShowEditButtons] of Boolean = (False, False, True);
  BoolToShowEditButtons: Array[Boolean] of TcxGridShowEditButtons = (gsebNever, gsebAlways);
begin
  if AParameter.IsPerform then
    TcxCustomGridTableViewAccess(AParameter.View).OptionsView.ShowEditButtons :=
      BoolToShowEditButtons[GetShowProperty(AParameter)]
  else SetShowProperty(AParameter, ShowEditButtonsToBool[TcxCustomGridTableViewAccess(AParameter.View).OptionsView.ShowEditButtons]);
end;

class function TcxGridCustomTableViewOperationHelper.GetViewClass: TcxCustomGridViewClass;
begin
  Result := TcxCustomGridTableView;
end;

initialization
  RegisterGridViewOperationHelper(TcxGridCustomTableViewOperationHelper);

end.
