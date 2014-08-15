{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit cxPivotGridOLAPConnectionDesigner;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxClasses, cxLookAndFeelPainters, cxGraphics, cxDropDownEdit,
  cxCalendar, cxTextEdit, cxMaskEdit, cxButtonEdit, StdCtrls, cxRadioGroup,
  cxLabel, cxControls, cxContainer, cxEdit, cxGroupBox, cxButtons, cxLookAndFeels,
  cxPivotGridStrs, DB, ADODB;

type
  TcxPivotGridOLAPConnectionDesignerClass = class of TfrmConnectionDesigner;

  TfrmConnectionDesigner = class(TForm)
    btnOk: TcxButton;
    btnCancel: TcxButton;
    gbSite: TcxGroupBox;
    lbConnectType: TcxLabel;
    rbAnalysisServer: TcxRadioButton;
    rbCubeFile: TcxRadioButton;
    edtServer: TcxButtonEdit;
    edtDatabase: TcxComboBox;
    lbServer: TcxLabel;
    lbDatabase: TcxLabel;
    lbCube: TcxLabel;
    edtCube: TcxComboBox;
    dlgOpen: TOpenDialog;
    procedure rbCubeFileClick(Sender: TObject);
    procedure rbAnalysisServerClick(Sender: TObject);
    procedure edtServerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtDatabaseChanged(Sender: TObject);
    procedure edtServerChanged(Sender: TObject);
  private
    function IsDataValid: Boolean;
    procedure SelectConnectionType(AUseServer: Boolean);
  protected
    function CreateServerConnection: TADOConnection;
    procedure DoShow; override;
    procedure FillComboByDataSet(AComboBox: TcxComboBox; ADataSet: TDataSet; AField: TField);
    function GetConnectionString: WideString; virtual;
    procedure Initialize; virtual;
    procedure InitializeCatalogList; virtual;
    procedure InitializeCubeList; virtual;
    procedure Validate;
  public
    property ConnectionString: WideString read GetConnectionString;
  end;

  function cxPivotGridOLAPCreateConnectionString(var ACube: WideString; 
    ALookAndFeel: TcxLookAndFeel = nil): WideString;

const
   ConnectionDesignerClass: TcxPivotGridOLAPConnectionDesignerClass = TfrmConnectionDesigner;

implementation

{$R *.dfm}

function cxPivotGridOLAPCreateConnectionString(var ACube: WideString;
  ALookAndFeel: TcxLookAndFeel = nil): WideString;
var
  AForm: TfrmConnectionDesigner;
begin
  Result := '';
  AForm := ConnectionDesignerClass.Create(nil);
  with AForm do
  try
    ACube := '';
    if ALookAndFeel <> nil then
      SetControlLookAndFeel(AForm, ALookAndFeel);
    if ShowModal = mrOk then
    begin
      Result := ConnectionString;
      ACube := VarToStr(edtCube.EditValue);
    end;
  finally
    Free;
  end;
end;

{ TfrmConnectionDesigner }

function TfrmConnectionDesigner.CreateServerConnection: TADOConnection;
begin
  Result := TADOConnection.Create(Self);
  Result.ConnectionString := Self.GetConnectionString;
  Result.LoginPrompt := False;
  Result.Connected := True;
  if not Result.Connected then
  begin
    edtDatabase.Properties.Items.Clear;
    edtCube.Properties.Items.Clear;
  end; 
end;

procedure TfrmConnectionDesigner.DoShow;
begin
  inherited DoShow;
  SelectConnectionType(rbAnalysisServer.Checked);
  Validate;
  Initialize;
end;

procedure TfrmConnectionDesigner.FillComboByDataSet(
  AComboBox: TcxComboBox; ADataSet: TDataSet; AField: TField);
begin
  with AComboBox.Properties do
  try
    BeginUpdate; 
    Items.Clear;
    ADataSet.First;
    while not ADataSet.Eof do
    begin
      Items.Add(AField.Value);
      ADataSet.Next;
    end;
  finally
    EndUpdate();
  end;
  if AComboBox.Properties.Items.Count > 0 then
    AComboBox.ItemIndex := 0
  else
    AComboBox.Text := '';
end;

function TfrmConnectionDesigner.GetConnectionString: WideString;
var
  ASecutity: string;
begin
  ASecutity := ';Integrated Security=SSPI';
  Result := 'Provider=MSOLAP%s;Persist Security Info=False;Data Source=' + edtServer.EditValue;
  if rbAnalysisServer.Checked then
  begin
    if edtDatabase.Text <> '' then
      Result := Result + ';Initial Catalog=' + edtDatabase.EditValue;
    ASecutity := '';
  end;
  Result := Format(Result, [ASecutity]);
end;

procedure TfrmConnectionDesigner.Initialize;
begin
  lbConnectType.Caption := cxGetResourceString(@scxConnectUsing);
  rbAnalysisServer.Caption := cxGetResourceString(@scxAnalysisServer);
  rbCubeFile.Caption := cxGetResourceString(@scxCubeFile);
  lbServer.Caption := cxGetResourceString(@scxServer);
  lbDataBase.Caption := cxGetResourceString(@scxDatabase);
  lbCube.Caption := cxGetResourceString(@scxCube);
  btnOk.Caption := cxGetResourceString(@scxPivotGridOk);
  btnCancel.Caption := cxGetResourceString(@scxPivotGridCancel);
end;

procedure TfrmConnectionDesigner.InitializeCatalogList;
var
  ADataSet: TADODataSet;
begin
  with CreateServerConnection do
  try
    if not Connected then Exit;
    ADataSet := TADODataSet.Create(nil);
    try
      OpenSchema(siCatalogs, EmptyParam, EmptyParam, ADataSet);
      FillComboByDataSet(edtDatabase, ADataSet, ADataSet.FieldByName('CATALOG_NAME'));
    finally
      ADataSet.Free;
    end;
  finally
    Free;
  end;
end;

procedure TfrmConnectionDesigner.InitializeCubeList;
var
  ADataSet: TADODataSet;
begin
  with CreateServerConnection do
  try
    if not Connected then Exit;
    ADataSet := TADODataSet.Create(nil);
    try
      OpenSchema(siCubes, EmptyParam, EmptyParam, ADataSet);
      FillComboByDataSet(edtCube, ADataSet, ADataSet.FieldByName('CUBE_NAME'));
    finally
      ADataSet.Free;
    end;
  finally
    Free;
  end;
end;

procedure TfrmConnectionDesigner.Validate;
begin
  btnOk.Enabled := IsDataValid;
end;

function TfrmConnectionDesigner.IsDataValid: Boolean;
begin
  Result := (edtServer.Text <> '') and (rbCubeFile.Checked or
    ((edtDatabase.Text <> '') and (edtCube.Text <> '')));
end;

procedure TfrmConnectionDesigner.SelectConnectionType(
  AUseServer: Boolean);
begin
  edtServer.Properties.Buttons.Items[0].Visible := not AUseServer;
  if AUseServer then
    lbServer.Caption := cxGetResourceString(@scxServer)
  else
    lbServer.Caption := cxGetResourceString(@scxCubeFile);
  edtDatabase.Enabled := AUseServer;
  lbDataBase.Enabled := AUseServer;
  lbCube.Enabled := AUseServer;
  edtCube.Enabled := AUseServer;
  if not edtCube.Enabled then
    edtCube.Properties.Items.Clear;
  if not edtDatabase.Enabled then
    edtDatabase.Properties.Items.Clear;
end;

procedure TfrmConnectionDesigner.rbCubeFileClick(Sender: TObject);
begin
  edtServer.Text := '';
  SelectConnectionType(False);
end;

procedure TfrmConnectionDesigner.rbAnalysisServerClick(Sender: TObject);
begin
  edtServer.Text := '';
  SelectConnectionType(True);
end;

procedure TfrmConnectionDesigner.edtServerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if dlgOpen.Execute then
    edtServer.EditValue := dlgOpen.FileName;
end;

procedure TfrmConnectionDesigner.edtDatabaseChanged(Sender: TObject);
begin
  try 
    if edtDatabase.Enabled then
      InitializeCubeList;
  finally
    Validate;
  end;
end;

procedure TfrmConnectionDesigner.edtServerChanged(Sender: TObject);
begin
  try
    if rbAnalysisServer.Checked and (edtServer.Text <> '') then
      InitializeCatalogList;
  finally
    Validate;
  end;
end;

end.
