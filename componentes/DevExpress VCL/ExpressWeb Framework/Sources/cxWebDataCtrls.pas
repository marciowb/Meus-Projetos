{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual data aware Web Controls                              }
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
unit cxWebDataCtrls;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, DB,
  cxWebRender, cxWebClasses, cxWebControls, cxWebStdCtrls, cxWebData,
  cxWebCalendar, cxWebDateEdit, cxWebGrids, cxWebDataNavigator;

type
  TcxWebDataBinding = class(TcxCustomWebDataBinding)
  private
    FFieldName: string;

    function GetField: TcxCustomWebDataField;
    function GetFieldName: string;
    procedure SetFieldName(Value: string);
  protected
    function GetFieldIndex: Integer; override;
    { IcxWebViewDataSupport }
    function GetFirstVisibleRow: Integer; override;
    function GetPageSize: Integer; override;
    { IcxWebDataSourceSupport }
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); override;
    procedure UpdateData(Sender: TcxCustomWebDataSource); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Field: TcxCustomWebDataField read GetField;
    property FieldIndex: Integer read GetFieldIndex;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

  TcxWebDBLabel = class(TcxCustomWebLabel, IcxWebDataSourceSupport, IcxWebViewDataSupport)
  private
    FDataBinding: TcxWebDataBinding;
    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
    { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
  end;

  TcxWebDBLabelRenderer = class(TcxCustomWebLabelRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBLabelNS4Renderer = class(TcxCustomWebLabelNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBEdit = class(TcxCustomWebEdit, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebDataBinding;
    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
    { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
    property MaxLength;
    property Password;
    property ReadOnly;
    property Size;
  end;

  TcxWebDBEditRenderer = class(TcxCustomWebEditRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBEditNS4Renderer = class(TcxCustomWebEditNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBEditOperaRenderer = class(TcxCustomWebEditOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBMemo = class(TcxCustomWebMemo, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebDataBinding;
    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
    { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Cols;
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
    property ReadOnly;
    property Rows;
    property WordWrap;
  end;

  TcxWebDBMemoRenderer = class(TcxCustomWebMemoRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBMemoNS4Renderer = class(TcxCustomWebMemoNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBMemoOperaRenderer = class(TcxCustomWebMemoOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxListStore = (sText, sValue);

  TcxWebListsDataBinding = class(TcxWebDataBinding)
  private
    FStore: TcxListStore;
    procedure SetStore(Value: TcxListStore);
  published
    property Store: TcxListStore read FStore write SetStore;
  end;

  TcxWebDBListBox = class(TcxCustomWebListBox, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebListsDataBinding;
    procedure SetDataBinding(Value: TcxWebListsDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
   { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebListsDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
    property Items;
    property Size stored False;
    property OnChange;
  end;

  TcxWebDBListBoxRenderer = class(TcxCustomWebListBoxRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBListBoxNS4Renderer = class(TcxCustomWebListBoxNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBListBoxOperaRenderer = class(TcxCustomWebListBoxOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBComboBox = class(TcxCustomWebComboBox, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebListsDataBinding;
    procedure SetDataBinding(Value: TcxWebListsDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
   { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { Scripts }
    procedure ScriptsSubscription; override;
    { renderers }
    procedure RegisterRenderers; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebListsDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
    property Items;
    property OnChange;
  end;

  TcxWebDBComboBoxRenderer = class(TcxWebComboBoxRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBComboBoxNS4Renderer = class(TcxWebComboBoxNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBComboBoxOperaRenderer = class(TcxWebComboBoxOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebCheckBoxUndefinedValueState = (uvsChecked, uvsUnchecked);

  TcxWebDBCheckBox = class(TcxCustomWebCheckBox, IcxWebDataSourceSupport,
     IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FCheckedValue: string;
    FDataBinding: TcxWebDataBinding;
    FUncheckedValue: string;
    FUndefinedValuesState: TcxWebCheckBoxUndefinedValueState;

    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
   { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CheckedValue: string read FCheckedValue write FCheckedValue;
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
    property UncheckedValue: string read FUncheckedValue write FUncheckedValue;
    property UndefinedValuesState: TcxWebCheckBoxUndefinedValueState read FUndefinedValuesState
        write FUndefinedValuesState;
  end;

  TcxWebDBCheckBoxRenderer = class(TcxCustomWebCheckBoxRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBCheckBoxNS4Renderer = class(TcxCustomWebCheckBoxNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBRadioGroup = class(TcxCustomWebRadioGroup, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebDataBinding;
    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
   { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
  end;

  TcxWebDBRadioGroupRenderer = class(TcxCustomWebRadioGroupRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBRadioGroupNS4Renderer = class(TcxCustomWebRadioGroupNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBImage = class(TcxCustomWebImage, IcxWebDataSourceSupport, IcxWebViewDataSupport)
  private
    FDataBinding: TcxWebDataBinding;
    FOnLoadImage: TcxLoadImageEvent;

    function GetDataSource: TcxCustomWebDataSource;
    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
    { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DataSource: TcxCustomWebDataSource read GetDataSource;
  published
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
    property OnLoadImage: TcxLoadImageEvent read FOnLoadImage write FOnLoadImage;
  end;

  TcxWebDBImageRenderer = class(TcxCustomWebImageRenderer)
  private
    function GetWebDBImage: TcxWebDBImage;
  protected
    function IsLoadAllRecords: Boolean; virtual;
  public
    procedure WriteHTML; override;
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
    property WebDBImage: TcxWebDBImage read GetWebDBImage;
  end;

  TcxWebDBImageNS4Renderer = class(TcxWebDBImageRenderer)
  protected
    function IsLoadAllRecords: Boolean; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebDBImageOperaRenderer = class(TcxWebDBImageNS4Renderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebDBCalendar = class(TcxCustomWebCalendar, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebDataBinding;

    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
   { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
  end;

  TcxWebDBCalendarRenderer = class(TcxCustomWebCalendarRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBCalendarNS4Renderer = class(TcxCustomWebCalendarNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBCalendarOperaRenderer = class(TcxCustomWebCalendarOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBDateEdit = class(TcxCustomWebDateEdit, IcxWebDataSourceSupport,
      IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebDataBinding;

    procedure SetDataBinding(Value: TcxWebDataBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
   { IcxWebViewDataSupport }
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebUpdeteDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
    { renderers }
    procedure RegisterRenderers; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
  end;

  TcxWebDBDateEditRenderer = class(TcxCustomWebDateEditRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBDateEditNS4Renderer = class(TcxCustomWebDateEditRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDataNavigatorBinding = class(TcxCustomWebDataBinding)
  private
    function GetDataNavigator: TcxCustomWebDataNavigator;
  protected
    function GetPageSize: Integer; override;
    property DataNavigator: TcxCustomWebDataNavigator read GetDataNavigator;
  end;

  TcxWebDBDataNavigator = class(TcxCustomWebDataNavigator, IcxWebDataSourceSupport)
  private
    FDataBinding: TcxWebDataNavigatorBinding;
    procedure SetDataBinding(Value: TcxWebDataNavigatorBinding);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { renderers }
    procedure RegisterRenderers; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebDataNavigatorBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport;
  end;

  TcxWebDBDataNavigatorRenderer = class(TcxCustomWebDataNavigatorRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBDataNavigatorNS4Renderer = class(TcxCustomWebDataNavigatorNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBDataNavigatorNS6Renderer = class(TcxCustomWebDataNavigatorNS6Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

implementation

uses Variants, DBConsts,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebIntf, cxWebScriptFactory, cxWebDataUtils, cxWebFileCacheManager,
  cxWebConsts;

{ TcxWebDataBinding }

function TcxWebDataBinding.GetField: TcxCustomWebDataField;
begin
  if DataSource <> nil then
    Result := DataSource.FieldByName(FFieldName)
  else Result := nil;
end;

function TcxWebDataBinding.GetFieldName: string;
begin
  Result := FFieldName;
end;

procedure TcxWebDataBinding.SetFieldName(Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    ChangedDataLayout(DataSource);
  end;
end;

function TcxWebDataBinding.GetFieldIndex: Integer;
begin
  if Field <> nil then
    Result := Field.Index
  else Result := -1;
end;

function TcxWebDataBinding.GetFirstVisibleRow: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.FocusedRowIndex
  else Result := -1;
end;

function TcxWebDataBinding.GetPageSize: Integer;
begin
  Result := 1;
end;

procedure TcxWebDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
var
  FocusedRow: Integer;
  Value: Variant;
  DisplayText: string;
  AWebControl: IcxWebControl;
  DataIntf: IcxWebViewDataSupport;
begin
  if Supports(Component, IcxWebViewDataSupport, DataIntf) then
  begin
    if (DataSource <> nil) and (Field <> nil) then
    begin
      FocusedRow := DataSource.FocusedRowIndex;
      if (FocusedRow >= 0) and (FocusedRow < DataSource.RowCount)then
      begin
        Value := DataSource.Values[DataSource.GetRowRecord(FocusedRow), Field.Index];
        DisplayText := DataSource.DisplayTexts[DataSource.GetRowRecord(FocusedRow), Field.Index];
        DataIntf.SetData(Value, DisplayText);
      end
      else DataIntf.SetData(Null, '');
    end
    else DataIntf.SetData(Null, '');
    if Supports(Component, IcxWebControl, AWebControl) and
      (AWebControl.DesignerControl <> nil) and not (csDestroying in Component.ComponentState) then
       AWebControl.DesignerControl.UpdateContext;
  end;
end;

procedure TcxWebDataBinding.UpdateData(Sender: TcxCustomWebDataSource);
var
  DataIntf: IcxWebUpdateDataSupport;
begin
  if (DataSource <> nil) and (Field <> nil) then
  begin
    if DataSource.CheckRowIndex(DataSource.FocusedRowIndex) then
    begin
      if Supports(Component, IcxWebUpdateDataSupport, DataIntf) and DataIntf.CanGetData then
        DataSource.SetEditValue(Field.Index, DataIntf.GetData, DataIntf.GetDataTypes);
    end;
  end;
end;

procedure TcxWebDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxWebDataBinding then
  begin
    DataSource := TcxWebDataBinding(Source).DataSource;
    FieldName := TcxWebDataBinding(Source).FieldName;
  end
  else inherited;
end;

{ TcxWebDBLabel }

constructor TcxWebDBLabel.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBLabel.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBLabel.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBLabel.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

{ IcxWebProvidersSupport }
procedure TcxWebDBLabel.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBLabel.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
    Caption := DisplayText
  else
  begin
    if IsDesigning then
      Caption := Name
    else Caption := '';
  end;
end;

procedure TcxWebDBLabel.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBLabelRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBLabelNS4Renderer);
end;

procedure TcxWebDBLabel.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBLabelRenderer }

procedure TcxWebDBLabelRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBLabel(WebLabel).DataBinding.DataSource <> nil then
    TcxWebDBLabel(WebLabel).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBLabel');
end;

class procedure TcxWebDBLabelRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBLabelNS4Renderer }

procedure TcxWebDBLabelNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBLabel(WebLabel).DataBinding.DataSource <> nil then
    TcxWebDBLabel(WebLabel).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBLabel');
end;

class procedure TcxWebDBLabelNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBEdit }

constructor TcxWebDBEdit.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBEdit.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBEdit.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBEdit.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBEdit.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBEdit.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
    Text := DisplayText
  else
  begin
    if IsDesigning then
      Text := Name
    else Text := '';
  end;
end;

function TcxWebDBEdit.CanGetData: Boolean;
begin
  Result := not ReadOnly;
end;

function TcxWebDBEdit.GetData: Variant;
begin
  Result := Text;
end;

function TcxWebDBEdit.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBEdit.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBEditRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBEditNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBEditOperaRenderer);
end;

procedure TcxWebDBEdit.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBEditRenderer }

procedure TcxWebDBEditRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBEdit(WebEdit).DataBinding.DataSource <> nil then
    TcxWebDBEdit(WebEdit).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBEdit');
end;

class procedure TcxWebDBEditRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBEditNS4Renderer }

procedure TcxWebDBEditNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBEdit(WebEdit).DataBinding.DataSource <> nil then
    TcxWebDBEdit(WebEdit).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBEdit');
end;

class procedure TcxWebDBEditNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBEditOperaRenderer }

procedure TcxWebDBEditOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBEdit(WebEdit).DataBinding.DataSource <> nil then
    TcxWebDBEdit(WebEdit).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBEdit');
end;

class procedure TcxWebDBEditOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBMemo }

constructor TcxWebDBMemo.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBMemo.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBMemo.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBMemo.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBMemo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBMemo.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBMemo.SetData(Value: Variant; DisplayText: string);
begin
  Text := HTMLValue(Value);
  if (Text = '') and IsDesigning then
    Text := Name;
end;

function TcxWebDBMemo.CanGetData: Boolean;
begin
  Result := not ReadOnly;
end;

function TcxWebDBMemo.GetData: Variant;
begin
  Result := Text;
end;

function TcxWebDBMemo.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText, dtValue];
end;

procedure TcxWebDBMemo.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBMemoRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBMemoNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBMemoOperaRenderer);
end;

procedure TcxWebDBMemo.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBMemoRenderer }

procedure TcxWebDBMemoRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBMemo(WebMemo).DataBinding.DataSource <> nil then
    TcxWebDBMemo(WebMemo).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBMemo');
end;

class procedure TcxWebDBMemoRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBMemoNS4Renderer }

procedure TcxWebDBMemoNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBMemo(WebMemo).DataBinding.DataSource <> nil then
    TcxWebDBMemo(WebMemo).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBMemo');
end;

class procedure TcxWebDBMemoNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBMemoOperaRenderer }

procedure TcxWebDBMemoOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBMemo(WebMemo).DataBinding.DataSource <> nil then
    TcxWebDBMemo(WebMemo).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBMemo');
end;

class procedure TcxWebDBMemoOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebListsDataBinding }

procedure TcxWebListsDataBinding.SetStore(Value: TcxListStore);
begin
  if FStore <> Value then
  begin
    FStore := Value;
    ChangedDataLayout(DataSource);
  end;
end;

{ TcxWebDBListBox }

constructor TcxWebDBListBox.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebListsDataBinding.Create(Self);
end;

destructor TcxWebDBListBox.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBListBox.SetDataBinding(Value: TcxWebListsDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBListBox.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBListBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBListBox.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBListBox.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
  begin
    if DataBinding.Store = sText then
      ItemIndex := Items.IndexOfText(DisplayText)
    else ItemIndex := Items.IndexOfValue(DisplayText)
  end
  else ItemIndex := -1;
end;

function TcxWebDBListBox.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBListBox.GetData: Variant;
begin
  if ItemIndex > -1 then
  begin
    if DataBinding.Store = sText then
      Result := Items[ItemIndex].Text
    else Result := Items[ItemIndex].Value
  end
  else Result := Null;
end;

function TcxWebDBListBox.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBListBox.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBListBoxRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBListBoxNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBListBoxOperaRenderer);
end;

procedure TcxWebDBListBox.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBListBoxRenderer }

procedure TcxWebDBListBoxRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBListBox(WebListBox).DataBinding.DataSource <> nil then
  begin
    TcxWebDBListBox(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBListBox');
    if TcxWebDBListBox(WebListBox).DataBinding.Store = sValue then
      HTMLTextBuilder.WriteText('  _DataControl.StoreByValues = true;');
  end;
end;

class procedure TcxWebDBListBoxRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBListBoxNS4Renderer }

procedure TcxWebDBListBoxNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBListBox(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBListBox(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBListBox');
end;

class procedure TcxWebDBListBoxNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBListBoxOperaRenderer }

procedure TcxWebDBListBoxOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBListBox(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBListBox(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBListBox');
end;

class procedure TcxWebDBListBoxOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBComboBox }

constructor TcxWebDBComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebListsDataBinding.Create(Self);
end;

destructor TcxWebDBComboBox.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBComboBox.SetDataBinding(Value: TcxWebListsDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBComboBox.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBComboBox.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBComboBox.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
  begin
    if DataBinding.Store = sText then
      ItemIndex := Items.IndexOfText(DisplayText)
    else ItemIndex := Items.IndexOfValue(DisplayText)
  end
  else ItemIndex := -1;
end;

function TcxWebDBComboBox.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBComboBox.GetData: Variant;
begin
  if ItemIndex > -1 then
  begin
    if DataBinding.Store = sText then
      Result := Items[ItemIndex].Text
    else Result := Items[ItemIndex].Value
  end
  else Result := Null;
end;

function TcxWebDBComboBox.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBComboBox.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBComboBoxRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBComboBoxNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBComboBoxOperaRenderer);  
end;

procedure TcxWebDBComboBox.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBComboBoxRenderer }

procedure TcxWebDBComboBoxRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBComboBox(WebListBox).DataBinding.DataSource <> nil then
  begin
    TcxWebDBComboBox(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBComboBox');
    if TcxWebDBComboBox(WebListBox).DataBinding.Store = sValue then
      HTMLTextBuilder.WriteText('  _DataControl.StoreByValues = true;');
  end;
end;

class procedure TcxWebDBComboBoxRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBComboBoxNS4Renderer }

procedure TcxWebDBComboBoxNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBComboBox(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBComboBox(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBComboBox');
end;

class procedure TcxWebDBComboBoxNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBComboBoxOperaRenderer }

procedure TcxWebDBComboBoxOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBComboBox(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBComboBox(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBComboBox');
end;

class procedure TcxWebDBComboBoxOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBCheckBox }

constructor TcxWebDBCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FCheckedValue := DBConsts.STextTrue;
  FDataBinding := TcxWebDataBinding.Create(Self);
  FUncheckedValue := DBConsts.STextFalse;
  FUndefinedValuesState := uvsUnchecked;
end;

destructor TcxWebDBCheckBox.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBCheckBox.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBCheckBox.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBCheckBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBCheckBox.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBCheckBox.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
  begin
    if SameText(DisplayText, CheckedValue) then
       Checked := True
    else if SameText(DisplayText, UncheckedValue) then
       Checked := False
    else if UndefinedValuesState = uvsChecked then
       Checked := True
    else Checked := False;
  end
  else Checked := False;
end;

function TcxWebDBCheckBox.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBCheckBox.GetData: Variant;
begin
  if Checked then
    Result := CheckedValue
  else Result := UncheckedValue;
end;

function TcxWebDBCheckBox.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBCheckBox.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBCheckBoxRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBCheckBoxNS4Renderer);
end;

procedure TcxWebDBCheckBox.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBCheckBoxRenderer }

procedure TcxWebDBCheckBoxRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBCheckBox(WebCheckBox).DataBinding.DataSource <> nil then
  begin
    TcxWebDBCheckBox(WebCheckBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBCheckBox');
    HTMLTextBuilder.WriteText(Format('  _DataControl.CheckedValue = "%s";',
      [TcxWebDBCheckBox(WebCheckBox).CheckedValue]));
    HTMLTextBuilder.WriteText(Format('  _DataControl.UncheckedValue = "%s";',
      [TcxWebDBCheckBox(WebCheckBox).UncheckedValue]));
    if TcxWebDBCheckBox(WebCheckBox).UndefinedValuesState = uvsChecked then
      HTMLTextBuilder.WriteText('  _DataControl.UncheckedIsDefault = false;');
  end;
end;

class procedure TcxWebDBCheckBoxRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBCheckBoxNS4Renderer }

procedure TcxWebDBCheckBoxNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBCheckBox(WebCheckBox).DataBinding.DataSource <> nil then
    TcxWebDBCheckBox(WebCheckBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBCheckBox');
end;

class procedure TcxWebDBCheckBoxNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBRadioGroup }

constructor TcxWebDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBRadioGroup.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBRadioGroup.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBRadioGroup.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBRadioGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBRadioGroup.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBRadioGroup.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
    ItemIndex := Items.IndexOf(DisplayText)
  else ItemIndex := -1;
end;

function TcxWebDBRadioGroup.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBRadioGroup.GetData: Variant;
begin
  if ItemIndex > -1 then
    Result := Items[ItemIndex]
  else Result := Null;
end;

function TcxWebDBRadioGroup.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBRadioGroup.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBRadioGroupRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBRadioGroupNS4Renderer);
end;

procedure TcxWebDBRadioGroup.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBRadioGroupRenderer }

procedure TcxWebDBRadioGroupRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBRadioGroup(WebRadioGroup).DataBinding.DataSource <> nil then
    TcxWebDBRadioGroup(WebRadioGroup).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBRadioGroup');
end;

class procedure TcxWebDBRadioGroupRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBRadioGroupNS4Renderer }

procedure TcxWebDBRadioGroupNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBRadioGroup(WebRadioGroup).DataBinding.DataSource <> nil then
    TcxWebDBRadioGroup(WebRadioGroup).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBRadioGroup');
end;

class procedure TcxWebDBRadioGroupNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBImage }

constructor TcxWebDBImage.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBImage.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

function TcxWebDBImage.GetDataSource: TcxCustomWebDataSource;
begin
  if DataBinding <> nil then
    Result := DataBinding.DataSource
  else Result := nil;
end;

procedure TcxWebDBImage.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBImage.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBImage.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBImage.SetData(Value: Variant; DisplayText: string);
var
  AURL: string;
  AHeight, AWidth: Integer;
  {$IFDEF VCL}
  AGraphicClass: TGraphicClass;
  {$ENDIF}
begin
  if (DataSource <> nil) and (Value <> Null) then
  begin
    try
      {$IFDEF VCL}
      AGraphicClass := nil;
      {$ENDIF}
      if Assigned(OnLoadImage) then OnLoadImage(Self{$IFDEF VCL}, AGraphicClass{$ENDIF});
      if csDesigning in ComponentState then
      begin
        if Assigned(DesignPicture) then
          DesignPicture.SetImage(Value);
      end
      else
      begin
        LoadImage(Value{$IFDEF VCL}, AGraphicClass{$ENDIF}, AURL, AHeight, AWidth);
        PictureURL := AURL;
        AltText := '';
      end;
    except
      PictureURL := '';
      AltText := '[Image]';
      if Assigned(DesignPicture) then
        DesignPicture.SetPath('');
    end;
  end
  else
  begin
    if Assigned(DesignPicture) then
      DesignPicture.SetPath('');
    PictureURL := '';
    AltText := Name;
  end;
end;

procedure TcxWebDBImage.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBImageRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBImageNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBImageOperaRenderer);  
end;

procedure TcxWebDBImage.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebDBImageRenderer }

function TcxWebDBImageRenderer.GetWebDBImage: TcxWebDBImage;
begin
  Result := Component as TcxWebDBImage;
end;

function TcxWebDBImageRenderer.IsLoadAllRecords: Boolean;
begin
  Result := (WebDBImage.DataSource <> nil) and WebDBImage.DataSource.LoadAllRecords;
end;

procedure TcxWebDBImageRenderer.WriteHTML;
var
  I, AHeight, AWidth: Integer;
  Value: Variant;
  AOldName, AOldURL, AURL: string;
  {$IFDEF VCL}
  AGraphicClass: TGraphicClass;
  {$ENDIF}
begin
  if IsLoadAllRecords then
  begin
    AOldName := WebDBImage.Name;
    AOldURL := WebDBImage.PictureURL;
    for I := 0 to WebDBImage.DataSource.RecordCount - 1 do
    begin
      WebDBImage.Name := Format('%s_%d', [AOldName, I]);
      Value := WebDBImage.DataSource.Values[I, WebDBImage.DataBinding.FieldIndex];

      {$IFDEF VCL}
      AGraphicClass := nil;
      {$ENDIF}
      if Assigned(WebDBImage.OnLoadImage) then
        WebDBImage.OnLoadImage(WebDBImage{$IFDEF VCL}, AGraphicClass{$ENDIF});
      try
        LoadImage(Value{$IFDEF VCL}, AGraphicClass{$ENDIF}, AURL, AHeight, AWidth);
      except
        AURL := '';
      end;
      WebDBImage.PictureURL := AURL;
      inherited WriteHTML;
      HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
      HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    end;
    WebDBImage.Name := AOldName;
    WebDBImage.PictureURL := AOldURL;
  end
  else inherited WriteHTML;
end;

procedure TcxWebDBImageRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if WebDBImage.DataBinding.DataSource <> nil then
    WebDBImage.DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBImage');
end;

class procedure TcxWebDBImageRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBImageNS4Renderer }

class function TcxWebDBImageNS4Renderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

function TcxWebDBImageNS4Renderer.IsLoadAllRecords: Boolean;
begin
  Result := False;
end;

{ TcxWebDBImageOperaRenderer }

class function TcxWebDBImageOperaRenderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

{ TcxWebDBCalendar }

constructor TcxWebDBCalendar.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBCalendar.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

function TcxWebDBCalendar.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBCalendar.GetData: Variant;
begin
  Result := SelectedDate;
end;

function TcxWebDBCalendar.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBCalendar.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBCalendar.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBCalendar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBCalendar.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBCalendarRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBCalendarNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBCalendarOperaRenderer);
end;

procedure TcxWebDBCalendar.SetData(Value: Variant; DisplayText: string);
begin
  if VarIsType(Value, varDate) then
    SelectedDate := VarToDateTime(Value);
end;

procedure TcxWebDBCalendar.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

{ TcxWebDBCalendarRenderer }

class procedure TcxWebDBCalendarRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBCalendarRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBCalendar(WebCalendar).DataBinding.DataSource <> nil then
    TcxWebDBCalendar(WebCalendar).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBCalendar');
end;

{ TcxWebDBCalendarNS4Renderer }

class procedure TcxWebDBCalendarNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBCalendarNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBCalendar(WebCalendar).DataBinding.DataSource <> nil then
    TcxWebDBCalendar(WebCalendar).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBCalendar');
end;

{ TcxWebDBCalendarOperaRenderer }

class procedure TcxWebDBCalendarOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBCalendarOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBCalendar(WebCalendar).DataBinding.DataSource <> nil then
    TcxWebDBCalendar(WebCalendar).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBCalendar');
end;

{ TcxWebDBDateEdit }

constructor TcxWebDBDateEdit.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataBinding.Create(Self);
end;

destructor TcxWebDBDateEdit.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

function TcxWebDBDateEdit.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBDateEdit.GetData: Variant;
begin
  Result := SelectedDate;
end;

function TcxWebDBDateEdit.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBDateEdit.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBDateEdit.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBDateEdit.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBDateEditRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBDateEditNS4Renderer);
end;

procedure TcxWebDBDateEdit.SetData(Value: Variant; DisplayText: string);
begin
  if VarIsType(Value, varDate) then
    SelectedDate := VarToDateTime(Value);
end;

procedure TcxWebDBDateEdit.SetDataBinding(Value: TcxWebDataBinding);
begin
  DataBinding.Assign(Value);
end;

{ TcxWebDBDateEditRenderer }

class procedure TcxWebDBDateEditRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBDateEditRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBDateEdit(WebDateEdit).DataBinding.DataSource <> nil then
    TcxWebDBDateEdit(WebDateEdit).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBDateEdit');
end;

{ TcxWebDBDateEditNS4Renderer }

class procedure TcxWebDBDateEditNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBDateEditNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBDateEdit(WebDateEdit).DataBinding.DataSource <> nil then
    TcxWebDBDateEdit(WebDateEdit).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBDateEdit');
end;

{ TcxWebDataNavigatorBinding }

function TcxWebDataNavigatorBinding.GetDataNavigator: TcxCustomWebDataNavigator;
begin
  Result := Component as TcxCustomWebDataNavigator;
end;

function TcxWebDataNavigatorBinding.GetPageSize: Integer;
begin
  Result := DataNavigator.PageSize;
end;

{ TcxWebDBDataNavigator }

constructor TcxWebDBDataNavigator.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebDataNavigatorBinding.Create(Self);
end;

destructor TcxWebDBDataNavigator.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBDataNavigator.SetDataBinding(Value: TcxWebDataNavigatorBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBDataNavigator.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBDataNavigator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBDataNavigator.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBDataNavigatorRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBDataNavigatorNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBDataNavigatorNS6Renderer);
end;

{ TcxWebDBDataNavigatorRenderer }

procedure TcxWebDBDataNavigatorRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBDataNavigator(WebDataNavigator).DataBinding.DataSource <> nil then
    TcxWebDBDataNavigator(WebDataNavigator).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBDataNavigator');
end;

class procedure TcxWebDBDataNavigatorRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBDataNavigatorNS4Renderer }

procedure TcxWebDBDataNavigatorNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBDataNavigator(WebDataNavigator).DataBinding.DataSource <> nil then
    TcxWebDBDataNavigator(WebDataNavigator).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBDataNavigator');
end;

class procedure TcxWebDBDataNavigatorNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBDataNavigatorNS6Renderer }

procedure TcxWebDBDataNavigatorNS6Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBDataNavigator(WebDataNavigator).DataBinding.DataSource <> nil then
    TcxWebDBDataNavigator(WebDataNavigator).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBDataNavigator');
end;

class procedure TcxWebDBDataNavigatorNS6Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

initialization
  RegisterClasses([TcxWebDataBinding, TcxWebDataNavigatorBinding,
      TcxWebDBLabel, TcxWebDBEdit, TcxWebDBMemo, TcxWebDBListBox,
      TcxWebDBComboBox, TcxWebDBCheckBox, TcxWebDBRadioGroup,
      TcxWebDBImage, TcxWebDBCalendar, TcxWebDBDateEdit,
      TcxWebDBDataNavigator]);

end.


