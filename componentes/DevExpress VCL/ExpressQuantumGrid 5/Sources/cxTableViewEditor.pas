{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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

unit cxTableViewEditor;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants, 
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, ExtCtrls,
  cxViewEditor, cxCustomTableViewEditor, cxGridCustomView, cxGridTableView;

type
  TcxTableViewEditor = class(TcxCustomTableViewEditor)
  protected
    function GetItemName: string; override;
  end;

  TcxGridTableViewStorage = class(TcxCustomGridTableViewStorage)
  private
    function GetFiltering: TcxGridTableFiltering;
    function GetOptionsBehavior: TcxGridTableOptionsBehavior;
    function GetOptionsCustomize: TcxGridTableOptionsCustomize;
    function GetOptionsData: TcxGridTableOptionsData;
    function GetOptionsSelection: TcxGridTableOptionsSelection;
    function GetOptionsView: TcxGridTableOptionsView;
    function GetPreview: TcxGridPreview;
  protected
    function TableView: TcxGridTableView;
  public
    class function GetViewClass: TcxCustomGridViewClass; override;
  published
    property Filtering: TcxGridTableFiltering read GetFiltering;
    property OptionsBehavior: TcxGridTableOptionsBehavior read GetOptionsBehavior;
    property OptionsCustomize: TcxGridTableOptionsCustomize read GetOptionsCustomize;
    property OptionsData: TcxGridTableOptionsData read GetOptionsData;
    property OptionsSelection: TcxGridTableOptionsSelection read GetOptionsSelection;
    property OptionsView: TcxGridTableOptionsView read GetOptionsView;
    property Preview: TcxGridPreview read GetPreview;
  end;

implementation

{$R *.dfm}

{ TcxTableViewEditor }

function TcxTableViewEditor.GetItemName: string;
begin
  Result := 'Column';
end;

{ TcxGridTableViewStorage }

function TcxGridTableViewStorage.GetFiltering: TcxGridTableFiltering;
begin
  Result := TableView.Filtering;
end;

function TcxGridTableViewStorage.GetOptionsBehavior: TcxGridTableOptionsBehavior;
begin
  Result := TableView.OptionsBehavior;
end;

function TcxGridTableViewStorage.GetOptionsCustomize: TcxGridTableOptionsCustomize;
begin
  Result := TableView.OptionsCustomize;
end;

function TcxGridTableViewStorage.GetOptionsData: TcxGridTableOptionsData;
begin
  Result := TableView.OptionsData;
end;

function TcxGridTableViewStorage.GetOptionsSelection: TcxGridTableOptionsSelection;
begin
  Result := TableView.OptionsSelection;
end;

function TcxGridTableViewStorage.GetOptionsView: TcxGridTableOptionsView;
begin
  Result := TableView.OptionsView;
end;

function TcxGridTableViewStorage.GetPreview: TcxGridPreview;
begin
  Result := TableView.Preview;
end;

function TcxGridTableViewStorage.TableView: TcxGridTableView;
begin
  Result := inherited View as TcxGridTableView;
end;

class function TcxGridTableViewStorage.GetViewClass: TcxCustomGridViewClass;
begin
  Result := TcxGridTableView;
end;

initialization
  RegisterViewEditorClass(TcxGridTableView, TcxTableViewEditor);
  RegisterDefaultViewStorage(TcxGridTableViewStorage);

finalization
  UnregisterDefaultViewStorage(TcxGridTableViewStorage);
  UnregisterViewEditorClass(TcxGridTableView, TcxTableViewEditor);

end.
 
