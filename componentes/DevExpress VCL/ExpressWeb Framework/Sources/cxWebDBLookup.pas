{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
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
unit cxWebDBLookup;

{$I cxVer.inc}

interface

uses
  Classes, DB, DBConsts, TypInfo,
  cxWebIntf, cxWebClasses, cxWebControls, cxWebStdCtrls, cxWebData,
  cxWebDataCtrls, cxWebTypes, cxWebRender, cxWebImgList;

type
  TcxCustomWebDBLookupDataBinding = class(TcxWebDataBinding)
  private
    FKeyFieldName: string;
    FListSource: TcxCustomWebDataSource;

    procedure SetKeyFieldName(Value: string);
    procedure SetListSource(Value: TcxCustomWebDataSource);
  protected
    procedure SetDataSource(Value: TcxCustomWebDataSource); override;
  public
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function KeyField: TcxCustomWebDataField;
    function KeyFieldIndex: Integer;
  published
    property KeyFieldName: string read FKeyFieldName write SetKeyFieldName;
    property ListSource: TcxCustomWebDataSource read FListSource write SetListSource;
  end;

  TcxCustomWebDBLookup = class(TcxCustomWebComboBox)
  published
    property OnChange;
  end;

  TcxWebDBLookup = class;

  TcxWebLookupDataBinding = class(TcxCustomWebDBLookupDataBinding)
  private
    FListFieldName: string;

    function GetWebDBLookup: TcxWebDBLookup;
    procedure SetListFieldName(Value: string);
  protected
    { IcxWebDataSourceSupport }
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); override;
  public
    function ListField: TcxCustomWebDataField;
    function ListFieldIndex: Integer;

    property WebDBLookup: TcxWebDBLookup read GetWebDBLookup;
  published
    property ListFieldName: string read FListFieldName write SetListFieldName;
  end;


  TcxWebDBLookup = class(TcxCustomWebDBLookup, IcxWebDataSourceSupport,
    IcxWebViewDataSupport, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebLookupDataBinding;
    procedure SetDataBinding(Value: TcxWebLookupDataBinding);
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
    { scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataBinding: TcxWebLookupDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
  end;

  TcxWebDBLookupRenderer = class(TcxWebComboBoxRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBLookupNS4Renderer = class(TcxWebComboBoxNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBLookupOperaRenderer = class(TcxWebComboBoxOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebExtDBLookup = class;
  TcxWebExtLookupDataBinding = class(TcxCustomWebDBLookupDataBinding)
  private
    FListFieldIndex: Integer;
    FListFieldNames: string;
    FListFieldsList: TStrings;

    function GetListFieldCount: Integer;
    function GetListField(Index: Integer): TcxCustomWebDataField;
    function GetWebExtDBLookup: TcxWebExtDBLookup;
    procedure SetListFieldIndex(Value: Integer);
    procedure SetListFieldNames(Value: string);
  protected
    procedure UpdateFieldsList; virtual;
    { IcxWebDataSourceSupport }
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); override;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
    function ListField: TcxCustomWebDataField;

    property ListFieldCount: Integer read GetListFieldCount;
    property ListFields[Index: Integer]: TcxCustomWebDataField read GetListField;
    property WebExtDBLookup: TcxWebExtDBLookup read GetWebExtDBLookup;
  published
    property ListFieldIndex: Integer read FListFieldIndex write SetListFieldIndex;
    property ListFieldNames: string read FListFieldNames write SetListFieldNames;
  end;

  TcxWebExtDBLookupEvent = (eleOnChange);

  TcxWebExtDBLookupEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxWebExtDBLookup = class(TcxWebDBLookup, IcxWebDataSourceSupport)
  private
    FButtonImageIndex: Integer;
    FButtonWidth: Integer;
    FButtonStyles: TcxWebStyles;
    FDataBinding: TcxWebExtLookupDataBinding;
    FEditorStyles: TcxWebStyles;
    FImages: TcxWebImageList;
    FLookupHeight: Integer;
    FLookupWidth: Integer;
    FTextHeight: Integer;

    function GetButtonStyles: TcxWebStyles;
    function GetEditorStyles: TcxWebStyles;
    procedure SetButtonStyles(AValue: TcxWebStyles);
    procedure SetButtonWidth(AValue: Integer);
    procedure SetEditorStyles(AValue: TcxWebStyles);
    procedure SetDataBinding(Value: TcxWebExtLookupDataBinding);
    procedure SetImages(Value: TcxWebImageList);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure CalcTextHeight;
    function GetDefaultHorzBordersSize: Integer; override;
    function GetDefaultVertBordersSize: Integer; override;
    function GetMaxHeight: Integer; override;
    function GetMinHeight: Integer; override;
    { events }
    function GetWebEventsHelper: TcxWebExtDBLookupEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebExtDBLookupEventsHelper read GetWebEventsHelper;
    { renderers }
    procedure RegisterRenderers; override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ButtonImageIndex: Integer read FButtonImageIndex write FButtonImageIndex;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth;
    property ButtonStyles: TcxWebStyles read GetButtonStyles write SetButtonStyles;
    property DataBinding: TcxWebExtLookupDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport;
    property EditorStyles: TcxWebStyles read GetEditorStyles write SetEditorStyles;
    property Images: TcxWebImageList read FImages write SetImages;
    property LookupHeight: Integer read FLookupHeight write FLookupHeight;
    property LookupWidth: Integer read FLookupWidth write FLookupWidth;
  end;

  TcxWebExtDBLookupRenderer = class(TcxWebControlRenderer)
  private
    function GetWebExtDBLookup: TcxWebExtDBLookup;
    function GetListSource: TcxCustomWebDataSource;

    function ButtonColor: TcxWebColor;
    function ButtonBottomWidth: Integer;
    function ButtonBottomColor: TcxWebColor;
    function ButtonLeftWidth: Integer;
    function ButtonLeftColor: TcxWebColor;
    function ButtonRightWidth: Integer;
    function ButtonRightColor: TcxWebColor;
    function ButtonTopWidth: Integer;
    function ButtonTopColor: TcxWebColor;
  protected
    procedure WriteEditorButton; virtual;
    procedure WriteLookup; virtual;
    procedure WriteLookupTable; virtual;
    procedure WriteLookupCell(ARecordIndex, AItemIndex: Integer); virtual;
    procedure WriteLookupCellContent(ARecordIndex, AItemIndex: Integer); virtual;
    procedure WriteLookupHeader; virtual;
    procedure WriteTextEdit; virtual;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteHTML; override;
    procedure WriteScripts; override;

    property ListSource: TcxCustomWebDataSource read GetListSource;
    property WebExtDBLookup: TcxWebExtDBLookup read GetWebExtDBLookup;
  end;

  TcxWebExtDBLookupNS4Renderer = class(TcxWebExtDBLookupRenderer)
  protected
    procedure WriteLookup; override;
    procedure WriteLookupCell(ARecordIndex, AItemIndex: Integer); override;
    procedure WriteLookupHeader; override;
    procedure WriteLookupTable; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
    procedure WriteOutOfFormHTML; override;
  end;

  TcxWebExtDBLookupOperaRenderer = class(TcxWebExtDBLookupRenderer)
  protected
    procedure WriteLookup; override;
    procedure WriteLookupCell(ARecordIndex, AItemIndex: Integer); override;
    procedure WriteLookupTable; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

implementation

uses SysUtils, Variants,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebColors, cxWebGraphics, cxWebUtils, cxWebDataUtils,
  cxWebScriptFactory, cxWebConsts;

{ TcxCustomWebDBLookupDataBinding }

destructor TcxCustomWebDBLookupDataBinding.Destroy;
begin
  ListSource := nil;
  inherited;
end;

procedure TcxCustomWebDBLookupDataBinding.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = ListSource) then
    ListSource := nil;
end;

function TcxCustomWebDBLookupDataBinding.KeyField: TcxCustomWebDataField;
begin
  if ListSource <> nil then
    Result := ListSource.FieldByName(KeyFieldName)
  else Result := nil;
end;

function TcxCustomWebDBLookupDataBinding.KeyFieldIndex: Integer;
begin
  if KeyField <> nil then
    Result := KeyField.Index
  else Result := -1;
end;

procedure TcxCustomWebDBLookupDataBinding.SetDataSource(Value: TcxCustomWebDataSource);
begin
  if (ListSource <> nil) and (ListSource = Value) then
    DatabaseError(SCircularDataLink);
  inherited SetDataSource(Value);
end;

procedure TcxCustomWebDBLookupDataBinding.SetKeyFieldName(Value: string);
begin
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    ChangedDataLayout(ListSource);
  end;
end;

procedure TcxCustomWebDBLookupDataBinding.SetListSource(Value: TcxCustomWebDataSource);
begin
  if FListSource <> Value then
  begin
    if (DataSource <> nil) and (DataSource = Value) then
      DatabaseError(SCircularDataLink);
    if (FListSource <> nil) and not (csDestroying in FListSource.ComponentState) then
    begin
      FListSource.UnRegisterClient(Component);
      FListSource.RemoveFreeNotification(Component);
    end;
    FListSource := Value;
    if FListSource <> nil then
    begin
      FListSource.FreeNotification(Component);
      FListSource.RegisterClient(Component);
    end;
    ChangedDataLayout(FListSource);
  end;
end;

{ TcxWebLookupDataBinding }

function TcxWebLookupDataBinding.ListField: TcxCustomWebDataField;
begin
  if ListSource <> nil then
    Result := ListSource.FieldByName(ListFieldName)
  else Result := nil;
end;

function TcxWebLookupDataBinding.ListFieldIndex: Integer;
begin
  if ListField <> nil then
    Result := ListField.Index
  else Result := -1;
end;

function TcxWebLookupDataBinding.GetWebDBLookup: TcxWebDBLookup;
begin
  Result := Component as TcxWebDBLookup;
end;

procedure TcxWebLookupDataBinding.SetListFieldName(Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    ChangedDataLayout(ListSource);
  end;
end;

procedure TcxWebLookupDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
var
  I: Integer;
begin
  if Sender = ListSource then
  begin
    WebDBLookup.Items.Clear;
    if (ListField <> nil) and (KeyField <> nil) then
      for I := 0 to ListSource.RecordCount - 1 do
        with WebDBLookup.Items.Add do
        begin
          Text := ListSource.DisplayTexts[I, ListFieldIndex];
          Value := ListSource.DisplayTexts[I, KeyFieldIndex];
        end;
  end;
  inherited;
end;

{ TcxWebDBLookup }

constructor TcxWebDBLookup.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebLookupDataBinding.Create(Self);
end;

destructor TcxWebDBLookup.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

procedure TcxWebDBLookup.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if DataBinding <> nil then
  begin
    if DataBinding.DataSource <> nil then AList.Add(DataBinding.DataSource);
    if DataBinding.ListSource <> nil then AList.Add(DataBinding.ListSource);
  end;
end;

procedure TcxWebDBLookup.Loaded;
begin
  inherited;
  DataBinding.Loaded;
end;

procedure TcxWebDBLookup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBLookup.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBLookupRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBLookupNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBLookupOperaRenderer);
end;

procedure TcxWebDBLookup.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

procedure TcxWebDBLookup.SetData(Value: Variant; DisplayText: string);
begin
  if Value <> Null then
    ItemIndex := Items.IndexOfValue(DisplayText)
  else ItemIndex := -1;
end;

function TcxWebDBLookup.CanGetData: Boolean;
begin
  Result := True;
end;

function TcxWebDBLookup.GetData: Variant;
begin
  if ItemIndex > -1 then
    Result := Items[ItemIndex].Value
  else Result := Null;
end;

function TcxWebDBLookup.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

procedure TcxWebDBLookup.SetDataBinding(Value: TcxWebLookupDataBinding);
begin
  DataBinding.Assign(Value);
end;

{ TcxWebDBLookupRenderer }

class procedure TcxWebDBLookupRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBLookupRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBLookup(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBLookup(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBLookup');
end;

{ TcxWebDBLookupNS4Renderer }

class procedure TcxWebDBLookupNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBLookupNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBLookup(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBLookup(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBLookup');
end;

{ TcxWebDBLookupOperaRenderer }

class procedure TcxWebDBLookupOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxWebDBLookupOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBLookup(WebListBox).DataBinding.DataSource <> nil then
    TcxWebDBLookup(WebListBox).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBLookup');
end;

{ TcxWebExtLookupDataBinding }

constructor TcxWebExtLookupDataBinding.Create(AComponent: TComponent);
begin
  inherited;
  FListFieldsList := TStringList.Create;
end;

destructor TcxWebExtLookupDataBinding.Destroy;
begin
  FListFieldsList.Free;
  inherited;
end;

function TcxWebExtLookupDataBinding.ListField: TcxCustomWebDataField;
begin
  if (0 <= ListFieldIndex) and (ListFieldIndex < ListFieldCount) then
    Result := ListFields[ListFieldIndex]
  else Result := nil;
end;

procedure TcxWebExtLookupDataBinding.UpdateFieldsList;
begin
  FListFieldsList.Text := StringReplace(ListFieldNames, ';', #13#10, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TcxWebExtLookupDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
var
  I: Integer;
begin
  if Sender = ListSource then
  begin
    WebExtDBLookup.Items.Clear;
    if (ListField <> nil) and (KeyField <> nil) then
      for I := 0 to ListSource.RecordCount - 1 do
        with WebExtDBLookup.Items.Add do
        begin
          Text := ListSource.DisplayTexts[I, ListField.Index];
          Value := ListSource.DisplayTexts[I, KeyFieldIndex];
        end;
  end;
  inherited;
end;

function TcxWebExtLookupDataBinding.GetListFieldCount: Integer;
begin
  if ListSource <> nil then
    Result := FListFieldsList.Count
  else Result := 0;
end;

function TcxWebExtLookupDataBinding.GetListField(Index: Integer): TcxCustomWebDataField;
begin
  if (ListSource <> nil) and (Index > -1) and (Index < FListFieldsList.Count) then
    Result := ListSource.FieldByName(FListFieldsList.Strings[Index])
  else Result := nil;
end;

function TcxWebExtLookupDataBinding.GetWebExtDBLookup: TcxWebExtDBLookup;
begin
  Result := Component as TcxWebExtDBLookup;
end;

procedure TcxWebExtLookupDataBinding.SetListFieldIndex(Value: Integer);
begin
  if FListFieldIndex <> Value then
  begin
    FListFieldIndex := Value;
    ChangedDataLayout(ListSource);
  end;
end;

procedure  TcxWebExtLookupDataBinding.SetListFieldNames(Value: string);
begin
  if FListFieldNames <> Value then
  begin
    FListFieldNames := Value;
    UpdateFieldsList;
    ChangedDataLayout(ListSource);    
  end;
end;

{ TcxWebExtDBLookupEventsHelper }

function TcxWebExtDBLookupEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebExtDBLookupEvent] of string = ('OnChange');
begin
  Result := cxHTMLEvent[TcxWebExtDBLookupEvent(AEvent)];
end;

function TcxWebExtDBLookupEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebExtDBLookupEvent] of string =
    ('(Sender)');
begin
  Result := cxHTMLEventProcParams[TcxWebExtDBLookupEvent(AEvent)];
end;

function TcxWebExtDBLookupEventsHelper.ScriptObject: string;
begin
  Result := '_Lookup';
end;

function TcxWebExtDBLookupEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebExtDBLookupEvent);
end;

{ TcxWebExtDBLookup }

constructor TcxWebExtDBLookup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CalcTextHeight;
  if FTextHeight <> 0 then
    FButtonWidth := FTextHeight
  else
    FButtonWidth := Height - GetVertBordersSize;
  FLookupHeight := 200;
  FLookupWidth := 400;
  Width := 100;

  FDataBinding := TcxWebExtLookupDataBinding.Create(Self);
end;

destructor TcxWebExtDBLookup.Destroy;
begin
  FreeAndNil(FDataBinding);
  FEditorStyles.Free;
  FButtonStyles.Free;
  inherited;
end;

function TcxWebExtDBLookup.GetButtonStyles: TcxWebStyles;
begin
  if FButtonStyles = nil then
    FButtonStyles := TcxWebStyles.Create(Self);
  Result := FButtonStyles;
end;

function TcxWebExtDBLookup.GetEditorStyles: TcxWebStyles;
begin
  if FEditorStyles = nil then
    FEditorStyles := TcxWebStyles.Create(Self);
  Result := FEditorStyles;
end;

procedure TcxWebExtDBLookup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then
    Images := nil;
end;

procedure TcxWebExtDBLookup.CalcTextHeight;
var
  AFont: TcxWebFont;
begin
  if Assigned(cxWebMetricsUtils) then
  begin
    if EditorStyles.Default <> nil then
      AFont := EditorStyles.Default.Style.Font
    else
      AFont := Font;
    FTextHeight := cxWebMetricsUtils.CalcEditHeight(AFont);
  end
  else
    FTextHeight := 0;
end;

function TcxWebExtDBLookup.GetDefaultHorzBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxWebExtDBLookup.GetDefaultVertBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxWebExtDBLookup.GetMaxHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else Result := 0;
end;

function TcxWebExtDBLookup.GetMinHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else Result := 0;
end;

function TcxWebExtDBLookup.GetWebEventsHelper: TcxWebExtDBLookupEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebExtDBLookupEventsHelper;
end;

class function TcxWebExtDBLookup.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebExtDBLookupEventsHelper;
end;

procedure TcxWebExtDBLookup.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebExtDBLookupRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebExtDBLookupNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebExtDBLookupOperaRenderer);
end;

procedure TcxWebExtDBLookup.DoSetValues;
begin
  ItemIndex := Items.IndexOfValue(WebValuesHelper.Values.Values[Name + 'KeyValue']);
end;

procedure TcxWebExtDBLookup.RegisterValues;
begin
  WebValuesHelper.RegisterValue(Name + 'KeyValue', '');
end;


procedure TcxWebExtDBLookup.SetButtonStyles(AValue: TcxWebStyles);
begin
  FButtonStyles.Assign(AValue);
end;

procedure TcxWebExtDBLookup.SetButtonWidth(AValue: Integer);
begin
  if FButtonWidth <> AValue then
  begin
    if AValue < 0 then AValue := 0;
    FButtonWidth := AValue;
  end;
end;

procedure TcxWebExtDBLookup.SetEditorStyles(AValue: TcxWebStyles);
begin
  FEditorStyles.Assign(AValue);
end;

procedure TcxWebExtDBLookup.SetDataBinding(Value: TcxWebExtLookupDataBinding);
begin
  FDataBinding.Assign(Value);
end;

procedure TcxWebExtDBLookup.SetImages(Value: TcxWebImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnregisterClient(Self);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterClient(Self);
      FImages.FreeNotification(Self);
    end;
  end;
end;

{ TcxWebExtDBLookupRenderer }

function TcxWebExtDBLookupRenderer.ButtonColor: TcxWebColor;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wsavColor in WebExtDBLookup.ButtonStyles.Default.Style.Shading.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Shading.Color
  else Result := $00C8D0D4;
end;

function TcxWebExtDBLookupRenderer.ButtonBottomWidth: Integer;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavWidth in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Bottom.Width
  else Result := 1;
end;

function TcxWebExtDBLookupRenderer.ButtonBottomColor: TcxWebColor;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavColor in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Bottom.Color
  else Result := clWebBlack;
end;

function TcxWebExtDBLookupRenderer.ButtonLeftWidth: Integer;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavWidth in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Left.Width
  else Result := 1;
end;

function TcxWebExtDBLookupRenderer.ButtonLeftColor: TcxWebColor;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavColor in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Left.Color
  else Result := clWebWhite;
end;

function TcxWebExtDBLookupRenderer.ButtonRightWidth: Integer;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavWidth in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Right.Width
  else Result := 1;
end;

function TcxWebExtDBLookupRenderer.ButtonRightColor: TcxWebColor;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavColor in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Right.Color
  else Result := clWebBlack;
end;

function TcxWebExtDBLookupRenderer.ButtonTopWidth: Integer;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavWidth in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Top.Width
  else Result := 1;
end;

function TcxWebExtDBLookupRenderer.ButtonTopColor: TcxWebColor;
begin
  if (WebExtDBLookup.ButtonStyles.Default <> nil) and
    (wbavColor in WebExtDBLookup.ButtonStyles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebExtDBLookup.ButtonStyles.Default.Style.Borders.Top.Color
  else Result := clWebWhite;
end;

class procedure TcxWebExtDBLookupRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxLookupScriptName);
  AList.Add(scxDataControlsScriptName);
end;

function TcxWebExtDBLookupRenderer.GetWebExtDBLookup: TcxWebExtDBLookup;
begin
  Result := Component as TcxWebExtDBLookup;
end;

function TcxWebExtDBLookupRenderer.GetListSource: TcxCustomWebDataSource;
begin
  Result := WebExtDBLookup.DataBinding.ListSource;
end;

procedure TcxWebExtDBLookupRenderer.WriteEditorButton;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, WebExtDBLookup.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebExtDBLookup.ButtonWidth);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonTopColor));
  WriteInvisibleImage(ButtonLeftWidth, ButtonTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonTopColor));
  WriteInvisibleImage(1, ButtonTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonTopColor));
  WriteInvisibleImage(ButtonRightWidth, ButtonTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonLeftColor));
  WriteInvisibleImage(ButtonLeftWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, WebExtDBLookup.Height - ButtonBottomWidth - ButtonTopWidth);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonColor));
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'Button');
  HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:LookupButtonClick(''%s'');',
    [WebExtDBLookup.Name]));

  if (WebExtDBLookup.Images <> nil) and (WebExtDBLookup.Images.ValidIndex(WebExtDBLookup.ButtonImageIndex)) then
    WebExtDBLookup.Images.Images[WebExtDBLookup.ButtonImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scxdeDownImageName));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    if WebExtDBLookup.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, WebExtDBLookup.Hint);
  end;
  HTMLTextBuilder.WriteAttribute(aName, WebExtDBLookup.Name + 'ButtonImage');
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonRightColor));
  WriteInvisibleImage(ButtonRightWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonBottomColor));
  WriteInvisibleImage(ButtonLeftWidth, ButtonBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonBottomColor));
  WriteInvisibleImage(1, ButtonBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonBottomColor));
  WriteInvisibleImage(ButtonRightWidth, ButtonBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebExtDBLookupRenderer.WriteLookup;
begin
  if not WebExtDBLookup.IsDesigning then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'Lookup');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, WebExtDBLookup.LookupWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, 'window');
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, WebExtDBLookup.ZIndex + 10000);
    HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');

    WriteLookupHeader;
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'LookupTable');
    HTMLTextBuilder.WriteStyleAttribute(saHeight, WebExtDBLookup.LookupHeight, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, WebExtDBLookup.LookupWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'auto');
    WriteLookupTable;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  end;
end;

procedure TcxWebExtDBLookupRenderer.WriteLookupTable;
var
  I, J: Integer;
  KeyValue: string;
begin
  if ListSource <> nil then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 2);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    for I := 0 to WebExtDBLookup.Items.Count - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
      HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name +
        ListSource.DisplayTexts[I, WebExtDBLookup.DataBinding.KeyFieldIndex]);
      HTMLTextBuilder.WriteStyleAttribute(saCursor, 'default');
      KeyValue := HTMLString(ListSource.DisplayTexts[I, WebExtDBLookup.DataBinding.KeyFieldIndex]);
      HTMLTextBuilder.WriteEventAttribute(eOnClick, Format('SelectLookupItem(''%s'', ''%s'');',
          [WebExtDBLookup.Name, KeyValue]));
      for J := 0 to WebExtDBLookup.DataBinding.ListFieldCount - 1 do
        WriteLookupCell(I, J);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    end;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  end;
end;

procedure TcxWebExtDBLookupRenderer.WriteLookupCell(ARecordIndex, AItemIndex: Integer);
var
  AField: TcxCustomWebDataField;
begin
  AField := WebExtDBLookup.DataBinding.ListFields[AItemIndex];
  if AField = nil then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  if AItemIndex = WebExtDBLookup.DataBinding.ListFieldIndex then
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name +
        ListSource.DisplayTexts[ARecordIndex, WebExtDBLookup.DataBinding.KeyFieldIndex] + 'ListCell');
  WriteLookupCellContent(ARecordIndex, AItemIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
end;

procedure TcxWebExtDBLookupRenderer.WriteLookupCellContent(ARecordIndex, AItemIndex: Integer);
var
  Value: Variant;
  AField: TcxCustomWebDataField;
  APictureURL: string;
  ImgHeight, ImgWidth: Integer;
begin
  AField := WebExtDBLookup.DataBinding.ListFields[AItemIndex];
  if AField.FieldHelper is TcxImageFieldHelper then
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    Value := ListSource.Values[ARecordIndex, AField.Index];
    try
      LoadImage(Value{$IFDEF VCL}, nil{$ENDIF}, APictureURL, ImgHeight, ImgWidth);
      HTMLTextBuilder.WriteAttribute(aSrc, APictureURL);
    except
      HTMLTextBuilder.WriteAttribute(aAlt, '[IMAGE]');
    end;
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
    HTMLTextBuilder.WriteAttribute(aHspace, 0);
    HTMLTextBuilder.WriteAttribute(aVspace, 0);
  end
  else HTMLTextBuilder.WriteText(ListSource.DisplayTexts[ARecordIndex, AField.Index], False, False)
end;

procedure TcxWebExtDBLookupRenderer.WriteLookupHeader;
var
  J: Integer;
  AField: TcxCustomWebDataField;
begin
  if WebExtDBLookup.DataBinding.ListSource <> nil then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 2);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    for J := 0 to WebExtDBLookup.DataBinding.ListFieldCount - 1 do
    begin
      AField := WebExtDBLookup.DataBinding.ListFields[J];
      if AField = nil then continue;
            
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aAlign, 'center');
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagStrong);
      HTMLTextBuilder.WriteText(AField.DisplayLabel);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagStrong);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    end;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  end;
end;

procedure TcxWebExtDBLookupRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  WriteAttributes;
  WritePosition;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aHeight, WebExtDBLookup.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebExtDBLookup.Width);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteTextEdit;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteEditorButton;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aColspan, 2);
  WriteLookup;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebExtDBLookupRenderer.WriteTextEdit;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aType, 'text');
  HTMLTextBuilder.WriteAttribute(aValue, WebExtDBLookup.Text);
  HTMLTextBuilder.WriteAttribute(aReadOnly);
  HTMLTextBuilder.WriteAttribute(aName, WebExtDBLookup.Name + 'Editor');
  HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'Editor');
  if WebExtDBLookup.EditorStyles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, WebExtDBLookup.EditorStyles.Default.FullName);
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebExtDBLookup.Width - WebExtDBLookup.ButtonWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebExtDBLookup.Height, 'px');
end;

procedure TcxWebExtDBLookupRenderer.WriteHiddenFormElements;
var
  Value: string;
begin
  if WebExtDBLookup.ItemIndex > -1 then
    Value := WebExtDBLookup.Items[WebExtDBLookup.ItemIndex].Value
  else Value := '';
  WriteHiddenField(WebExtDBLookup.Name + 'KeyValue', Value);
end;

procedure TcxWebExtDBLookupRenderer.WriteScripts;
begin
  inherited WriteScripts;
  HTMLTextBuilder.WriteText('var _Lookup = CreateLookup();');
  HTMLTextBuilder.WriteText(Format('  _Lookup.Name = "%s";', [WebExtDBLookup.Name]));
  if not Assigned(WebExtDBLookup.OnChange) then
    HTMLTextBuilder.WriteText('  _Lookup.AssignOnChange = false;');
  WriteEvents;
  if WebExtDBLookup.DataBinding.DataSource <> nil then
    WebExtDBLookup.DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBExtLookup');
end;

{ TcxWebExtDBLookupNS4Renderer }
class function TcxWebExtDBLookupNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxWebExtDBLookupNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  WriteAttributes;
  WritePosition;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aHeight, WebExtDBLookup.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebExtDBLookup.Width);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteTextEdit;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteEditorButton;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 2);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteAttribute(aName, WebExtDBLookup.Name + 'PosImage');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebExtDBLookupNS4Renderer.WriteLookup;
var
  J: Integer;
  AField: TcxCustomWebDataField;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagLayer);
  HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'Lookup');
  HTMLTextBuilder.WriteAttribute(aHeight, WebExtDBLookup.LookupHeight);
  HTMLTextBuilder.WriteAttribute(aWidth, WebExtDBLookup.LookupWidth);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  HTMLTextBuilder.WriteAttribute(aVisibility, 'hidden');

  if WebExtDBLookup.DataBinding.ListSource <> nil then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aHeight, '100%');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    for J := 0 to WebExtDBLookup.DataBinding.ListFieldCount - 1 do
    begin
      AField := WebExtDBLookup.DataBinding.ListFields[J];
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aAlign, 'center');
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagStrong);
      HTMLTextBuilder.WriteText(AField.DisplayLabel);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagStrong);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    end;
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aValign, 'top');
    HTMLTextBuilder.WriteAttribute(aBgcolor, 'lightgrey');
    HTMLTextBuilder.WriteAttribute(aWidth, 1);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:LookupScrollUp(''%s'');', [WebExtDBLookup.Name]));
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scxScrlUpImageName));
    HTMLTextBuilder.WriteAttribute(aAlt, 'Prev page');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aAlign, 'left');
    HTMLTextBuilder.WriteAttribute(aValign, 'top');
    HTMLTextBuilder.WriteAttribute(aHeight, '100%');
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aColspan, WebExtDBLookup.DataBinding.ListFieldCount);
    WriteInvisibleImage(1, 1);
    HTMLTextBuilder.WriteAttribute(aName, WebExtDBLookup.Name + 'TableLTImage');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aBgcolor, 'lightgrey');
    HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
    HTMLTextBuilder.WriteAttribute(aWidth, 1);
    HTMLTextBuilder.WriteAttribute(aHeight, '100%');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:LookupScrollDown(''%s'');', [WebExtDBLookup.Name]));
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scxscrlDownImageName));
    HTMLTextBuilder.WriteAttribute(aAlt, 'Next page');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteAttribute(aAlign, 'right');
    HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
    HTMLTextBuilder.WriteAttribute(aHeight, 1);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aColspan, WebExtDBLookup.DataBinding.ListFieldCount);
    WriteInvisibleImage(1, 1);
    HTMLTextBuilder.WriteAttribute(aName, WebExtDBLookup.Name + 'TableRBImage');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteAttribute(aBgcolor, 'lightgrey');
    HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
    HTMLTextBuilder.WriteAttribute(aWidth, 1);
    HTMLTextBuilder.WriteAttribute(aHeight, 1);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagLayer);
end;

procedure TcxWebExtDBLookupNS4Renderer.WriteLookupCell(ARecordIndex, AItemIndex: Integer);
var
  AField: TcxCustomWebDataField;
  KeyValue, ListValue: string;
begin
  AField := WebExtDBLookup.DataBinding.ListFields[AItemIndex];
  if AField = nil then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  if AItemIndex = WebExtDBLookup.DataBinding.ListFieldIndex then
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name +
        ListSource.DisplayTexts[ARecordIndex, WebExtDBLookup.DataBinding.KeyFieldIndex] + 'ListCell');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  KeyValue := HTMLString(ListSource.DisplayTexts[ARecordIndex, WebExtDBLookup.DataBinding.KeyFieldIndex]);
  ListValue := HTMLString(ListSource.DisplayTexts[ARecordIndex, WebExtDBLookup.DataBinding.ListField.Index]);
  HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:SelectLookupItem(''%s'', ''%s'', ''%s'');',
      [WebExtDBLookup.Name, KeyValue, ListValue]));
  WriteLookupCellContent(ARecordIndex, AItemIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
end;

procedure TcxWebExtDBLookupNS4Renderer.WriteLookupHeader;
begin
end;

procedure TcxWebExtDBLookupNS4Renderer.WriteLookupTable;
var
  I, J: Integer;
begin
  if WebExtDBLookup.DataBinding.ListSource <> nil then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagLayer);
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'LookupTable');
    HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
    HTMLTextBuilder.WriteAttribute(aHeight, WebExtDBLookup.LookupHeight);
    HTMLTextBuilder.WriteAttribute(aWidth, WebExtDBLookup.LookupWidth);
    HTMLTextBuilder.WriteAttribute(aVisibility, 'hidden');

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 2);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    for I := 0 to WebExtDBLookup.Items.Count - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
      for J := 0 to WebExtDBLookup.DataBinding.ListFieldCount - 1 do
        WriteLookupCell(I, J);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    end;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagLayer);
  end;
end;

procedure TcxWebExtDBLookupNS4Renderer.WriteOutOfFormHTML;
begin
  WriteLookup;
  WriteLookupTable;
end;

{ TcxWebExtDBLookupOperaRenderer }

class function TcxWebExtDBLookupOperaRenderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

procedure TcxWebExtDBLookupOperaRenderer.WriteLookup;
begin
  if not WebExtDBLookup.IsDesigning then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'Lookup');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, WebExtDBLookup.LookupWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, 'window');
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, WebExtDBLookup.ZIndex + 10000);
    HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');

    WriteLookupHeader;
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name + 'LookupTable');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, WebExtDBLookup.LookupWidth, 'px');
    WriteLookupTable;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  end;
end;

procedure TcxWebExtDBLookupOperaRenderer.WriteLookupCell(ARecordIndex,
  AItemIndex: Integer);
var
  AField: TcxCustomWebDataField;
  KeyValue, ListValue: string;
begin
  AField := WebExtDBLookup.DataBinding.ListFields[AItemIndex];
  if AField = nil then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  KeyValue := HTMLString(ListSource.DisplayTexts[ARecordIndex, WebExtDBLookup.DataBinding.KeyFieldIndex]);
  ListValue := HTMLString(ListSource.DisplayTexts[ARecordIndex, WebExtDBLookup.DataBinding.ListField.Index]);
  HTMLTextBuilder.WriteEventAttribute(eOnClick, Format('SelectLookupItem(''%s'', ''%s'', ''%s'');',
      [WebExtDBLookup.Name, KeyValue, ListValue]));
  WriteLookupCellContent(ARecordIndex, AItemIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
end;

procedure TcxWebExtDBLookupOperaRenderer.WriteLookupTable;
var
  I, J: Integer;
begin
  if ListSource <> nil then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 2);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    for I := 0 to WebExtDBLookup.Items.Count - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
      HTMLTextBuilder.WriteAttribute(aId, WebExtDBLookup.Name +
        ListSource.DisplayTexts[I, WebExtDBLookup.DataBinding.KeyFieldIndex]);
      HTMLTextBuilder.WriteStyleAttribute(saCursor, 'default');
      for J := 0 to WebExtDBLookup.DataBinding.ListFieldCount - 1 do
        WriteLookupCell(I, J);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    end;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  end;
end;

initialization
  RegisterClasses([TcxWebDBLookup, TcxWebExtDBLookup]);

end.

