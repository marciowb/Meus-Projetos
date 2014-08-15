{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressQuantumGrid                                          }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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
unit cxGridImportDialog;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  DesignIntf, Variants,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxConverterFactory, cxGridConverter, cxGrid, TypInfo,
  cxGridStructureNavigator, cxGridLevel, cxGridCustomView, ComCtrls, cxStyles;

type
  TImportDialog = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    lbCurrentLevelName: TLabel;
    cbDeleteAllSublevels: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    cbImportStyles: TCheckBox;
    ComboBox1: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbImportStylesClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
  private
    { Private declarations }
    FcxGrid: TcxCustomGrid;
    FCurrentLevel: TcxGridLevel;
    FDesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF};
    FGridStructureControl: TcxGridStructureControl;
    FGridStructureHelper: TcxGridStructureHelper;
    FIntermediaryList: TStringList;
    FStyleOptionsFirstShow: Boolean;
    function GetConverterClass(ASource: TObject): TcxCustomConverterWithStylesClass;
    function GetConverterIndex(ASource: TObject): Integer;
    procedure LoadComponent(const S: string);
    procedure LoadIntermediary(const S: string);
    procedure LoadStyleRepositories(const S: string);
    procedure DoImport;
    procedure DisableStylesOptions;
    procedure EnableStylesOptions;
    function GetIntermediaryComponent: TComponent;
    function IsParent(ASource: TObject; const AParentClassName: string): Boolean;
    procedure UpdateComboBox;
    procedure UpdateDesigner(Sender: TObject);
  public
    { Public declarations }
    procedure SelectionChanged(Sender: TObject);
    property cxGrid: TcxCustomGrid read FcxGrid write FcxGrid;
    property Designer_: {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF} read FDesigner write FDesigner;
  end;

  procedure ShowGridImportDialog(ADesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF}; AGrid: TcxCustomGrid);

var
  ImportDialog: TImportDialog;

implementation

uses
  cxControls;

{$R *.dfm}

const
  scxStyleRepositoryClassName = 'TcxStyleRepository';

procedure ShowGridImportDialog(ADesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF}; AGrid: TcxCustomGrid);
var
  ADialog: TImportDialog;
begin
  ADialog := TImportDialog.Create(Application);
  try
    ADialog.cxGrid := AGrid;
    ADialog.Designer_ := ADesigner;
    ADialog.ShowModal;
  finally
    ADialog.Free;
    ADesigner.Modified;
  end;
end;

procedure TImportDialog.SelectionChanged(Sender: TObject);
var
  AObject: TObject;
  AList: TList;
begin
  AList := TList.Create;
  try
    FGridStructureControl.GetSelection(AList);
    if AList.Count > 0 then
    begin
      AObject := TObject(AList[0]);
      if AObject is TcxGridLevel then
      begin
        FCurrentLevel := AObject as TcxGridLevel;
        lbCurrentLevelName.Caption := (AObject as TcxGridLevel).Name;
      end
      else if AObject is TcxCustomGrid then
      begin
        FCurrentLevel := nil;
        lbCurrentLevelName.Caption := (AObject as TcxCustomGrid).Name;
      end
      else if AObject is TcxCustomGridView then
      with TcxCustomGridView(AObject) do
      begin
        FCurrentLevel := Level as TcxGridLevel;
        lbCurrentLevelName.Caption := (Level as TcxGridLevel).Name;
      end;
    end;
  finally
    AList.Free;
  end;
end;

procedure TImportDialog.Button2Click(Sender: TObject);
begin
  Close;
end;

function TImportDialog.GetConverterIndex(ASource: TObject): Integer;
var
  I: Integer;
  ASourceClassName: string;
begin
  Result := -1;
  if ASource = nil then
    Exit;
  ASourceClassName := ASource.ClassName;
  with ConverterFactory(cxGridGroupConverterName) do
  begin
    for I := 0 to Count - 1 do
      if (Items[I].Class_.GetSourceClassName = ASourceClassName) or
        IsParent(ASource, Items[I].Class_.GetSourceClassName) then
      begin
        Result := I;
        Break;
      end;
  end;
end;

procedure TImportDialog.FormShow(Sender: TObject);
begin
  Edit1.Text := FDesigner.UniqueName(scxStyleRepositoryClassName);
  FDesigner.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), LoadComponent);
end;

procedure TImportDialog.Button1Click(Sender: TObject);
begin
  DoImport;
end;

function TImportDialog.GetConverterClass(ASource: TObject): TcxCustomConverterWithStylesClass;
var
  AIndex: Integer;
begin
  AIndex := GetConverterIndex(ASource);
  if AIndex <> -1 then
    Result := ConverterFactory(cxGridGroupConverterName).Items[AIndex].Class_
  else
    Result := TcxCustomGridConverter;
end;

procedure TImportDialog.LoadComponent(const S: string);
var
  AComponent: TComponent;
begin
  AComponent := FDesigner.GetComponent(S);
  if AComponent <> nil then
    if GetConverterIndex(AComponent) <> -1 then
       ListBox1.Items.AddObject(S, AComponent);
end;

procedure TImportDialog.LoadIntermediary(const S: string);
var
  AComponent: TComponent;
  AConverterClass: TcxCustomConverterWithStylesClass;
begin
  AComponent := FDesigner.GetComponent(S);
  if AComponent <> nil then
  begin
    AConverterClass := GetConverterClass(ListBox1.Items.Objects[ListBox1.ItemIndex]);
    if AConverterClass.InheritsFrom(TcxCustomGridConverter) then
    begin
      if AComponent.ClassName = TcxCustomGridConverterClass(AConverterClass).GetIntermediaryClassName then
        FIntermediaryList.AddObject(AComponent.ClassName, AComponent);
    end;
  end;
end;

procedure TImportDialog.LoadStyleRepositories(const S: string);
var
  AComponent: TComponent;
begin
  AComponent := FDesigner.GetComponent(S);
  if AComponent <> nil then
    if AComponent.ClassName = scxStyleRepositoryClassName then
      ComboBox1.Items.AddObject(S, AComponent);
end;

procedure TImportDialog.DoImport;
var
  AConverter: TcxCustomConverterWithStyles;
begin
  if (ListBox1.ItemIndex <> -1) and (FcxGrid <> nil) then
  begin
    AConverter := GetConverterClass(ListBox1.Items.Objects[ListBox1.ItemIndex]).Create(FcxGrid);
    try
      if AConverter is TcxCustomGridConverter then
      with TcxCustomGridConverter(AConverter) do
      begin
        Intermediary := GetIntermediaryComponent;
        TcxCustomGridConverter(AConverter).Designer_ := Self.Designer_;
        DestinationLevel := FCurrentLevel;
        DeleteAllSublevels := cbDeleteAllSublevels.Checked;
        ConvertWithStyles := cbImportStyles.Checked;
        if cbImportStyles.Checked then
        begin
          if RadioButton1.Checked then
            NameOfNewStyleRepository := Edit1.Text
          else
            StyleRepository := ComboBox1.Items.Objects[ComboBox1.ItemIndex] as TcxStyleRepository;
        end;
        Button1.Enabled := False;
        ImportFrom(ListBox1.Items.Objects[ListBox1.ItemIndex] as TComponent);
      end;
    finally
      Button1.Enabled := True;
      if FGridStructureControl <> nil then
        FGridStructureControl.Changed;
      AConverter.Free;
      if RadioButton1.Checked then
        UpdateComboBox;
      if cbImportStyles.Checked then
        EnableStylesOptions;
    end;
  end;
end;

procedure TImportDialog.DisableStylesOptions;
begin
  RadioButton1.Enabled := False;
  RadioButton2.Enabled := False;
  Edit1.Enabled := False;
  Edit1.Color := clBtnFace;
  ComboBox1.Enabled := False;
  ComboBox1.Color := clBtnFace;
end;

procedure TImportDialog.EnableStylesOptions;
begin
  RadioButton1.Enabled := True;
  if ComboBox1.Items.Count > 0 then
  begin
    RadioButton2.Enabled := True;
    if RadioButton1.Checked then
    begin
      Edit1.Enabled := True;
      Edit1.Color := clWindow;
      ComboBox1.Enabled := False;
      ComboBox1.Color := clBtnFace;
    end
    else
    begin
      Edit1.Enabled := False;
      Edit1.Color := clBtnFace;
      ComboBox1.Enabled := True;
      ComboBox1.Color := clWindow;
    end;
  end
  else
  begin
    RadioButton2.Enabled := False;
    RadioButton1.Checked := True;
    Edit1.Enabled := True;
    Edit1.Color := clWindow;
    ComboBox1.Enabled := False;
    ComboBox1.Color := clBtnFace;
  end;
end;

function TImportDialog.GetIntermediaryComponent: TComponent;
begin
  Result := nil;
  FIntermediaryList := TStringList.Create;
  try
    FDesigner.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), LoadIntermediary);
    if FIntermediaryList.Count > 0 then
      Result := FIntermediaryList.Objects[0] as TComponent;
  finally
    FIntermediaryList.Free;
  end;
end;

function TImportDialog.IsParent(ASource: TObject; const AParentClassName: string): Boolean;
var
  AParentClass: TClass;
begin
  Result := False;
  AParentClass := ASource.ClassParent;
  while AParentClass <> nil do
  begin
    if AParentClass.ClassName = AParentClassName then
    begin
      Result := True;
      Exit;
    end;
    AParentClass := AParentClass.ClassParent;
  end;
end;

procedure TImportDialog.UpdateComboBox;
var
  AIndex: Integer;
begin
  AIndex := 0;
  if ComboBox1.Items.Count > 0 then
    AIndex := ComboBox1.ItemIndex;
  ComboBox1.Clear;
  FDesigner.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), LoadStyleRepositories);
  if ComboBox1.Items.Count > 0 then
    ComboBox1.ItemIndex := AIndex;
  Edit1.Text := FDesigner.UniqueName(scxStyleRepositoryClassName);    
end;

procedure TImportDialog.UpdateDesigner(Sender: TObject);
begin
  if FCurrentLevel <> nil then
  begin
    if FCurrentLevel.Name <> lbCurrentLevelName.Caption then
    begin
      FCurrentLevel := nil;
      lbCurrentLevelName.Caption := FcxGrid.Name;
    end;
  end
  else
    lbCurrentLevelName.Caption := FcxGrid.Name;
  Designer_.Modified;    
end;

procedure TImportDialog.FormCreate(Sender: TObject);
begin
  FcxGrid := nil;
  FGridStructureControl := nil;
  FGridStructureHelper := nil;
  FCurrentLevel := nil;
  FStyleOptionsFirstShow := True;  
end;

procedure TImportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if TranslateKey(Key) = VK_ESCAPE then
    Close;
end;

procedure TImportDialog.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
    Button1.Enabled := True;
end;

procedure TImportDialog.ListBox1DblClick(Sender: TObject);
begin
  DoImport;
end;

procedure TImportDialog.Button3Click(Sender: TObject);
var
  AList: TList;
begin
  FGridStructureControl := TcxGridStructureControl.Create(Panel3);
  with FGridStructureControl do
  begin
    Align := alClient;
    Grid := cxGrid;
    MayFocused := True;
    MultiSelect := True;
    SelectOneItem := True;
    OnSelectionChanged := SelectionChanged;
    Parent := Panel3;
    AList := TList.Create;
    try
      AList.Add(cxGrid);
      SyncSelection(AList);
    finally
      AList.Free;
    end;
  end;
  FGridStructureHelper := TcxGridStructureHelper.Create(FGridStructureControl);
  FGridStructureHelper.OnUpdateDesigner := UpdateDesigner;
  if FCurrentLevel <> nil then
    lbCurrentLevelName.Caption := FCurrentLevel.Name
  else
    lbCurrentLevelName.Caption := cxGrid.Name;
  Width := 800;
  Button3.Enabled := False;
end;

procedure TImportDialog.FormDestroy(Sender: TObject);
begin
  FGridStructureHelper.Free;
  FGridStructureControl.Free;
end;

procedure TImportDialog.cbImportStylesClick(Sender: TObject);
begin
  if cbImportStyles.Checked then
    EnableStylesOptions
  else
    DisableStylesOptions;
end;

procedure TImportDialog.RadioButton1Click(Sender: TObject);
begin
  EnableStylesOptions;
end;

procedure TImportDialog.RadioButton2Click(Sender: TObject);
begin
  EnableStylesOptions;
end;

procedure TImportDialog.TabSheet2Show(Sender: TObject);
begin
  if not FStyleOptionsFirstShow then
    Exit;
  UpdateComboBox;
  EnableStylesOptions;
  FStyleOptionsFirstShow := False;
end;

end.
