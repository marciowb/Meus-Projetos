{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       HTML Rendering Modules                                      }
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
unit cxWebHTMLProd;

interface

{$I cxVer.inc}

uses SysUtils, Classes, Contnrs,
  cxWebCompProd, cxWebIntf, cxWebRender;

const
  scxEWF = 'ewf'; // Do not localize
  scxId = 'id'; // Do not localize
  scxForm = 'form'; // Do not localize
  scxRender = 'render'; // Do not localize
  scxRenderChildren = 'renderchildren'; // Do not localize
  scxLayout = 'layout'; // Do not localize
  scxTableRender = 'TableRender'; // Do not localize

type
  TcxWebHTMLProd = class;
  TcxRenderChildren = (noRender, beginRender, beginTableRender, endRender, endTableRender);

  TcxComponentHTMLItem = class;
  TcxCustomHTMLItem = class
  private
    FHTMLProd: TcxWebHTMLProd;
    FItems: TList;
    FParent: TcxComponentHTMLItem;

    function GetCount: Integer;
    function GetItem(Index: Integer): TcxCustomHTMLItem;
  public
    constructor Create(AHTMLProd: TcxWebHTMLProd); overload;
    destructor Destroy; override;

    procedure Clear; virtual;
    procedure Insert(Item: TcxCustomHTMLItem); virtual;
    function IndexOf(Item: TcxCustomHTMLItem): Integer;
    procedure Move(Item: TcxCustomHTMLItem; NewIndex: Integer);
    procedure Remove(Item: TcxCustomHTMLItem);
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;

    function Browser: TcxWebBrowserClass;
    property HTMLProd: TcxWebHTMLProd read FHTMLProd;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomHTMLItem read GetItem;
    property Parent: TcxComponentHTMLItem read FParent;
  end;

  TcxTextHTMLItem = class(TcxCustomHTMLItem)
  private
    FText: string;
  public
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;
    property Text: string read FText write FText;
  end;

  TcxComponentHTMLItem = class(TcxCustomHTMLItem)
  private
    FComponent: TComponent;
    FComponentClass: TComponentClass;
    FComponentClassName: string;
    FComponentName: string;
    FEWFTagFormat: string;
    FEWFEndTagFormat: string;
    FExcludeList: TList;
    FRender: Boolean;
    FRenderChildren: TcxRenderChildren;
  public
    constructor Create(AHTMLProd: TcxWebHTMLProd; AComponent: TComponent); overload;
    destructor Destroy; override;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;

    property Component: TComponent read FComponent write FComponent;
    property ComponentClass: TComponentClass read FComponentClass;
    property ComponentName: string read FComponentName;
    property ComponentClassName: string read FComponentClassName;
    property EWFTagFormat: string read FEWFTagFormat write FEWFTagFormat;
    property EWFEndTagFormat: string read FEWFEndTagFormat write FEWFEndTagFormat;
    property ExcludeList: TList read FExcludeList;
    property Render: Boolean read FRender write FRender;
    property RenderChildren: TcxRenderChildren read FRenderChildren write FRenderChildren;
  end;
  TcxComponentHTMLItemClass = class of TcxComponentHTMLItem;

  TcxWebControlHTMLItem = class(TcxComponentHTMLItem)
  public
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;
    function WebControl: IcxWebControl;
  end;

  TcxWebContainerControlHTMLItem = class(TcxWebControlHTMLItem)
  protected
    procedure UpdateExcludeList;

    procedure WriteControl(AHTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteControlTable(AHTMLTextBuilder: TcxHTMLTextBuilder);
  public
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;
    function WebContainerControl: IcxWebContainerControl;
  end;

  TcxWebModuleHTMLItem = class(TcxWebContainerControlHTMLItem)
  public
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  EcxWebHTMLParserException = class(Exception)
  private
    FErrorStr: string;
    FParserError: Boolean;
  public
    constructor Create(const AMsg, AErrorStr: string; AParserError: Boolean);
    property ErrorStr: string read FErrorStr;
    property ParserError: Boolean read FParserError;
  end;

  TcxWebHTMLProd = class
  private
    FRendererClasses: TClassList;
    FComponentProducer: TcxWebComponentProducer;
    FComponents: TList;
    FComponentItems: TList;
    FContainerItems: TList;
    FModuleItem: TcxWebContainerControlHTMLItem;
    FItems: TcxComponentHTMLItem;
    FParentItem: TcxComponentHTMLItem;
    FModule: TComponent;
    FGlobalExcludeList: TList;

    function GetComponent(Index: Integer): TComponent;
    function GetComponentCount: Integer;
    function GetRendererClassCount: Integer;
    function GetRendererClass(Index: Integer): TcxWebRendererClass;

    procedure FinalizeScriptFactory;
    procedure InitializeScriptFactory;
    procedure PrepareComponentLists;

    procedure AddComponent(AComponent: TComponent);
    procedure AddProviders(AComponent: TComponent);
    procedure AddContainer(AContainer: IcxWebContainerControl; ARenderChildren: Boolean);

    function GetComponentItem(Index: Integer): TcxComponentHTMLItem;
    function GetComponentItemCount: Integer;
    function GetContainerItem(Index: Integer): TcxWebContainerControlHTMLItem;
    function GetContainerItemCount: Integer;
  protected
    function CanAssignCustomAttrs: Boolean; virtual;
    { HTML Items}
    function AddTextHTMLItem(AHTMLString: string): TcxTextHTMLItem;
    function AddComponentHTMLItem(AComponent: TComponent;
        AParentItem: TcxComponentHTMLItem; ARender: Boolean; 
        AEWFTag: string; AComponentClass: TComponentClass;
        AEWFTagRecord: PcxWebHTMLComponent; ARenderChildren: TcxRenderChildren): TcxComponentHTMLItem;
    procedure MoveItem(AItem: TcxCustomHTMLItem; ANewIndex: Integer);

    function GetComponentHTMLItemClass(AComponentClass: TComponentClass): TcxComponentHTMLItemClass; virtual;
    function GetSetComponentProperties: Boolean; virtual;
    { Component rendering }
    function GetRenderClass(AComponent: TComponent): TcxWebRendererClass; virtual;
    procedure WriteHiddenFormElementsCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteScriptCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteExternalStyles(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteStylesCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteScripts(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteIncludedScripts(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteOutOfFormHTMLCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteClassOutOfFormHTMLCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteClassHTMLCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    { Script factory render }
    procedure WriteFactoryHiddenFormElementsCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteFactoryScriptCode(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;

    function GetError(const AMsg, AErrorStr: string;
        AParserError: Boolean): EcxWebHTMLParserException;

    procedure DoAfterHTMLRender; dynamic;
    procedure DoBeforeHTMLRender; dynamic;

    function Browser: TcxWebBrowserClass;
    function ClientData: IcxWebClientData;
    function IsFirstRequest: Boolean; virtual;

    property ComponentProducer: TcxWebComponentProducer read FComponentProducer;
    property GlobalExcludeList: TList read FGlobalExcludeList;
    property Module: TComponent read FModule;
    property Items: TcxComponentHTMLItem read FItems;
    property ParentItem: TcxComponentHTMLItem read FParentItem write FParentItem;
    property RendererClasses[Index: Integer]: TcxWebRendererClass read GetRendererClass;
    property RendererClassCount: Integer read GetRendererClassCount;
    property Components[Index: Integer]: TComponent read GetComponent;
    property ComponentCount: Integer read GetComponentCount;

    property ComponentItems[Index: Integer]: TcxComponentHTMLItem read GetComponentItem;
    property ComponentItemCount: Integer read GetComponentItemCount;
    property ContainerItems[Index: Integer]: TcxWebContainerControlHTMLItem read GetContainerItem;
    property ContainerItemCount: Integer read GetContainerItemCount;
    property ModuleItem: TcxWebContainerControlHTMLItem read FModuleItem;
  public
    constructor Create(AModule: TComponent);
    destructor Destroy; override;

    procedure ParseHTML(const ASource: string);
    function RenderHTML: string;
  end;
  TcxWebHTMLProdClass = class of TcxWebHTMLProd;

implementation
                    
uses
  StrUtils, TypInfo,
  cxWebUtils, cxWebTableBld, cxWebClasses, cxWebConsts, cxWebStrs,
  cxWebScriptFactory;

{ TcxCustomHTMLItem1 }

constructor TcxCustomHTMLItem.Create(AHTMLProd: TcxWebHTMLProd);
begin
  FHTMLProd := AHTMLProd;
  FItems := TList.Create;
end;

destructor TcxCustomHTMLItem.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

procedure TcxCustomHTMLItem.Insert(Item: TcxCustomHTMLItem);
begin
  Item.FParent := TcxComponentHTMLItem(Self);
  FItems.Add(Item);
end;

function TcxCustomHTMLItem.IndexOf(Item: TcxCustomHTMLItem): Integer;
begin
  Result := FItems.IndexOf(Item);
end;

procedure TcxCustomHTMLItem.Move(Item: TcxCustomHTMLItem; NewIndex: Integer);
var
  AOldIndex: Integer;
begin
  AOldIndex := FItems.IndexOf(Item);
  if (AOldIndex > -1) and (AOldIndex <> NewIndex) then
    FItems.Move(AOldIndex, NewIndex);
end;

procedure TcxCustomHTMLItem.Remove(Item: TcxCustomHTMLItem);
begin
  if FItems.IndexOf(Item) > -1 then
  begin
    FItems.Remove(Item);
    Item.FParent := nil;
  end;
end;

function TcxCustomHTMLItem.Browser: TcxWebBrowserClass;
begin
  Result := HTMLProd.Browser;
end;

procedure TcxCustomHTMLItem.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Clear;
end;

procedure TcxCustomHTMLItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

function TcxCustomHTMLItem.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxCustomHTMLItem.GetItem(Index: Integer): TcxCustomHTMLItem;
begin
  Result := TcxCustomHTMLItem(FItems[Index]);
end;

{ TcxTextHTMLItem }

procedure TcxTextHTMLItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteText(Text, False, False);
end;

{ TcxComponentHTMLItem1 }

constructor TcxComponentHTMLItem.Create(AHTMLProd: TcxWebHTMLProd; AComponent: TComponent);
begin
  inherited Create(AHTMLProd);
  FExcludeList := TList.Create;
  FComponent := AComponent;
end;

destructor TcxComponentHTMLItem.Destroy;
begin
  FExcludeList.Free;
  inherited;
end;

procedure TcxComponentHTMLItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

{ TcxWebControlHTMLItem }

procedure TcxWebControlHTMLItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  CodeIntf: IcxCodeProvider;
begin
  if (WebControl <> nil) and not WebControl.Visible then exit;
  if Render and Supports(Component, IcxCodeProvider, CodeIntf) then
    CodeIntf.WriteHTML(HTMLTextBuilder);
end;

function TcxWebControlHTMLItem.WebControl: IcxWebControl;
begin
  Supports(Component, IcxWebControl, Result);
end;

{ TcxWebContainerControlHTMLItem }

procedure TcxWebContainerControlHTMLItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  ContainerCodeIntf: IcxContainerCodeProvider;
begin
  UpdateExcludeList;
  if (WebControl <> nil) and not WebControl.Visible then exit;
  if Render and Supports(Component, IcxContainerCodeProvider, ContainerCodeIntf) then
  begin
    ContainerCodeIntf.WriteBeginHTML(HTMLTextBuilder);
    if RenderChildren = beginTableRender then
      WriteControlTable(HTMLTextBuilder)
    else if RenderChildren = beginRender then
      WriteControl(HTMLTextBuilder);
    for I := 0 to Count - 1 do
      Items[I].WriteHTML(HTMLTextBuilder);
    if RenderChildren = endTableRender then
      WriteControlTable(HTMLTextBuilder)
    else if RenderChildren = endRender then
      WriteControl(HTMLTextBuilder);
    ContainerCodeIntf.WriteEndHTML(HTMLTextBuilder);
  end;
end;

function TcxWebContainerControlHTMLItem.WebContainerControl: IcxWebContainerControl;
begin
  Supports(Component, IcxWebContainerControl, Result);
end;

procedure TcxWebContainerControlHTMLItem.UpdateExcludeList;
var
  I: Integer;
  AComponent: TComponent;
begin
  for I := 0 to HTMLProd.GlobalExcludeList.Count - 1 do
  begin
    AComponent := TComponent(HTMLProd.GlobalExcludeList.Items[I]);
    if AComponent <> Component then
      FExcludeList.Add(AComponent);
  end;
end;

procedure TcxWebContainerControlHTMLItem.WriteControl(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  PageInfoIntf: IcxWebPageModule;
  OldPositioningType: TcxWebPositioningType;
begin
  if Supports(HTMLProd.Module, IcxWebPageModule, PageInfoIntf) then
  begin
    OldPositioningType := PageInfoIntf.GetPositioningType;
    if OldPositioningType = cxptGrid then
      PageInfoIntf.SetPositioningType(cxptAbsolute);
    TcxWebTableBuilder.WriteHTML(AHTMLTextBuilder, WebContainerControl, False, ExcludeList);
    PageInfoIntf.SetPositioningType(OldPositioningType);
  end;
end;

procedure TcxWebContainerControlHTMLItem.WriteControlTable(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  PageInfoIntf: IcxWebPageModule;
begin
  if Supports(HTMLProd.Module, IcxWebPageModule, PageInfoIntf) then
  begin
    TcxWebTableBuilder.WriteHTML(AHTMLTextBuilder, WebContainerControl,
        (WebContainerControl.ControlLayout = wclGrid), ExcludeList);
  end;
end;

{ TcxWebModuleHTMLItem }

procedure TcxWebModuleHTMLItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  ContainerCodeIntf: IcxContainerCodeProvider;
begin
  UpdateExcludeList;
  if (WebControl <> nil) and not WebControl.Visible then exit;
  if Render and Supports(Component, IcxContainerCodeProvider, ContainerCodeIntf) then
  begin
    HTMLProd.WriteOutOfFormHTMLCode(HTMLTextBuilder);
    HTMLProd.WriteClassOutOfFormHTMLCode(HTMLTextBuilder);
    ContainerCodeIntf.WriteBeginHTML(HTMLTextBuilder);
    HTMLProd.WriteClassHTMLCode(HTMLTextBuilder);
    HTMLProd.WriteHiddenFormElements(HTMLTextBuilder);
    HTMLProd.WriteIncludedScripts(HTMLTextBuilder);
    HTMLProd.WriteStyles(HTMLTextBuilder);
    HTMLProd.WriteScripts(HTMLTextBuilder);
    if RenderChildren = beginTableRender then
      WriteControlTable(HTMLTextBuilder)
    else if RenderChildren = beginRender then
      WriteControl(HTMLTextBuilder);
    for I := 0 to Count - 1 do
      Items[I].WriteHTML(HTMLTextBuilder);
    if RenderChildren = endTableRender then
      WriteControlTable(HTMLTextBuilder)
    else if RenderChildren = endRender then
      WriteControl(HTMLTextBuilder);
    ContainerCodeIntf.WriteEndHTML(HTMLTextBuilder);
  end;
end;

{ EcxWebHTMLParserException }

constructor EcxWebHTMLParserException.Create(const AMsg, AErrorStr: string; AParserError: Boolean);
begin
  inherited Create(AMsg);
  FErrorStr := AErrorStr;
  FParserError := AParserError;
end;

{ TcxWebHTMLProd }

constructor TcxWebHTMLProd.Create(AModule: TComponent);
begin
  FModule := AModule;
  FComponentProducer := TcxWebComponentProducer.Create(AModule);
  FItems := TcxComponentHTMLItem.Create(Self);
  FParentItem := FItems;
  FComponents := TList.Create;
  FComponentItems := TList.Create;
  FContainerItems := TList.Create;
  FRendererClasses := TClassList.Create;
  FGlobalExcludeList := TList.Create;
end;

destructor TcxWebHTMLProd.Destroy;
begin
  FGlobalExcludeList.Free;
  FRendererClasses.Free;
  FComponentItems.Free;
  FContainerItems.Free;
  FComponents.Free;
  FItems.Free;
  FComponentProducer.Free;
  inherited;
end;

procedure TcxWebHTMLProd.ParseHTML(const ASource: string);
var
  S, AClassName: string;
  Parser: TcxParser;
  ComponentItem: TcxWebHTMLComponent;
  Render: Boolean;
  RenderChildren: TcxRenderChildren;
  ALayout: TcxWebControlLayout;

  procedure ClearComponentState;
  begin
    Render := True;
    RenderChildren := beginTableRender;

    ComponentItem.Name := '';
    ComponentItem.ClassName := '';
    ComponentItem.ParentName := '';
    ComponentItem.Values.Clear;
  end;

  function ExtractParameter: Boolean;
  var
    Quote: Char;
    PropName, PropValue: string;
    PropValuePos: Integer;
  begin
    with Parser do
      if NextToken = toSymbol then
      begin
        PropName := TokenString;
        while NextToken <> '=' do
        begin
          if Token = '.' then
            PropName := PropName + '.'
          else if Token = toSymbol then
            PropName := PropName + TokenString
          else raise GetError(scxInvalidPropertyName, Parser.OutString, True); ////
        end;

        if (Token = '=') then
        begin
          if (NextToken = '"') or (Token = '''') then
            Quote := Token
          else
          begin
            if (Token = toSymbol) or (Token = toInteger) then
            begin
              Quote := #0;
              PrevToken;
            end
            else raise GetError(scxExpectedPropertyValue, Parser.OutString, True); ////
          end;

          if Quote <> #0 then
          begin
            PropValuePos := OutStringLength;
            while NextToken <> Quote do
            begin
              if IsEOF then
                raise GetError(Format(scxExpectedSymbol, [Quote]), Parser.OutString, True); ////
            end;
            PrevToken;
            PropValue := RightStr(OutString, OutStringLength - PropValuePos);
          end
          else
          begin
            if (NextToken = toSymbol) or (Token = toInteger) then
              PropValue := TokenString
            else PropValue := '';
          end;

          if SameText(PropName, scxId) then
            ComponentItem.Name := PropValue
          else if SameText(PropName, scxRender) then
            Render := StrToBool(PropValue)
          else if SameText(PropName, scxRenderChildren) then
            RenderChildren := TcxRenderChildren(GetEnumValue(TypeInfo(TcxRenderChildren), PropValue))
          else if SameText(PropName, scxLayout) then
            ALayout := TcxWebControlLayout(GetEnumValue(TypeInfo(TcxWebControlLayout), PropValue))
          else if (ComponentItem.Values.IndexOfName(PropName) = -1) then
            ComponentItem.Values.Add(PropName + '=' + PropValue);

          if Quote <> #0 then
          begin
            if NextToken <> Quote then
              raise GetError(Format(scxExpectedSymbol, [Quote]), Parser.OutString, True); ////
          end;
          Result := true;
        end
        else raise GetError(Format(scxExpectedSymbol, ['=']), Parser.OutString, True); ////
      end
      else if Token = '>' then
        Result := false
      else raise GetError(Format(scxExpectedSymbol, ['>']), Parser.OutString, True); ////
  end;

var
  SavedPos: Integer;
  AComponent: TComponent;
  AComponentClass: TComponentClass;
  AWebContainerControl: IcxWebContainerControl;
  SourceStream: TMemoryStream;
  AEWFTag: string;
begin
  SourceStream := TMemoryStream.Create;
  try
    SourceStream.WriteBuffer(ASource[1], Length(ASource));

    ComponentItem.Values := TStringList.Create;
    Parser := TcxParser.Create(SourceStream);
    try
      with Parser do
      begin
        while true do
        begin
          while not ((Token = '<') or IsEOF) do NextToken;
          if IsEOF then
           break;

          if Token = '<' then
          begin
            SavedPos := OutStringLength;
            if NextToken = toSymbol then
            begin
              if SameText(TokenString, scxEWF) then
              begin
                if not Supports(FModule, IcxWebPageModule) then
                  raise GetError(scxUnexpectedEWFTag, Parser.OutString, True); ////

                if NextToken = ':' then
                begin
                  ClearComponentState;

                  if NextToken = toSymbol then
                    ComponentItem.ClassName := TokenString
                  else raise GetError(scxExpectedClassName, Parser.OutString, True); ////

                  ALayout := wclInheritable;
                  while True do
                  begin
                    if ExtractParameter then continue;
                    if Token = '>' then break;
                    if IsEOF then
                      raise GetError(Format(scxExpectedSymbol, ['>']), Parser.OutString, True); ////
                  end;
                  AEWFTag := Copy(OutString, SavedPos, OutStringLength);

                  if (ParentItem <> nil) then
                    ComponentItem.ParentName := ParentItem.ComponentName
                  else ComponentItem.ParentName := '';

                  try
                    AComponent := ComponentProducer.ProduceWebComponent(ComponentItem, IsFirstRequest,
                        GetSetComponentProperties, CanAssignCustomAttrs, AComponentClass);
                    if Supports(AComponent, IcxWebContainerControl, AWebContainerControl) then
                      AWebContainerControl.ControlLayout := ALayout;
                  except
                    on E: EcxComponentProducerException do
                      raise GetError(E.Message, AEWFTag, False) ////
                    else raise;
                  end;

                  AddTextHTMLItem(LeftStr(OutString, SavedPos - 1));
                  if (ParentItem <> nil) and (ParentItem.ExcludeList <> nil) then
                      ParentItem.ExcludeList.Add(AComponent)
                  else FGlobalExcludeList.Add(AComponent);

                  AddComponentHTMLItem(AComponent, ParentItem, Render, AEWFTag,
                        AComponentClass, @ComponentItem, RenderChildren);
                  ResetOutput;
                end
                else raise GetError(Format(scxExpectedSymbol, [':']), Parser.OutString, True); ////
              end;
            end
            else
            begin
              if Token = '/' then
                if (NextToken = toSymbol) and SameText(TokenString, scxEWF) then
                begin
                  if not Supports(FModule, IcxWebPageModule) then
                    raise GetError(scxUnexpectedEWFTag, Parser.OutString, True); ////

                  if NextToken = ':' then
                  begin
                    if NextToken = toSymbol then
                      S := LowerCase(TokenString)
                    else raise GetError(scxExpectedClassname, Parser.OutString, True); ////

                    if ParentItem <> nil then
                    begin
                      AClassName := LowerCase(ParentItem.ComponentClass.ClassName);
                      if (Pos(S, AClassName) <> 0) or SameText(S, scxForm) and SameText(AClassName, Module.ClassName) then
                      begin
                        while True do
                        begin
                          if NextToken = '>' then break;
                          if IsEOF or (Token = '<') then
                            raise GetError(Format(scxExpectedSymbol, ['>']), Parser.OutString, True); ////
                        end;
                        AEWFTag := Copy(OutString, SavedPos, OutStringLength);
                        ParentItem.EWFEndTagFormat := AEWFTag;

                        AddTextHTMLItem(LeftStr(OutString, SavedPos - 1));
                        ParentItem := ParentItem.Parent;
                        ResetOutput;
                      end
                      else raise GetError(Format(scxExpectedClosingTag, [ParentItem.ComponentName]), Parser.OutString, True) ////
                    end
                    else raise GetError(Format(scxUnexpectedClosingTag, [S]), Parser.OutString, True);
                  end
                  else raise GetError(Format(scxExpectedSymbol, [':']), Parser.OutString, True); ////
                end;
            end;
          end;
        end;
        AddTextHTMLItem(OutString);
        if ParentItem <> Items then
          raise GetError(Format(scxExpectedClosingTag, [ParentItem.ClassName]), Parser.OutString, True);
      end;
    finally
      ComponentItem.Values.Free;
      Parser.Free;
    end;
  finally
    SourceStream.Free;
  end;
end;

function TcxWebHTMLProd.RenderHTML: string;
var
  I: Integer;
  HTMLTextBuilder: TcxHTMLTextBuilder;
begin
  HTMLTextBuilder := TcxHTMLTextBuilder.Create(Browser);

  DoBeforeHTMLRender;

  PrepareComponentLists;
  InitializeScriptFactory;
  for I := 0 to Items.Count - 1 do
    Items.Items[I].WriteHTML(HTMLTextBuilder);
  FinalizeScriptFactory;

  DoAfterHTMLRender;

  Result := HTMLTextBuilder.Text;
  HTMLTextBuilder.Free;
end;

procedure TcxWebHTMLProd.MoveItem(AItem: TcxCustomHTMLItem; ANewIndex: Integer);
begin
  if AItem.Parent <> nil then
    AItem.Parent.Move(AItem, ANewIndex);
end;

function TcxWebHTMLProd.AddTextHTMLItem(AHTMLString: string): TcxTextHTMLItem;
begin
  Result := TcxTextHTMLItem.Create(Self);
  ParentItem.Insert(Result);
  Result.Text := AHTMLString;
end;

function TcxWebHTMLProd.AddComponentHTMLItem(AComponent: TComponent; AParentItem: TcxComponentHTMLItem;
    ARender: Boolean; AEWFTag: string; AComponentClass: TComponentClass;
    AEWFTagRecord: PcxWebHTMLComponent; ARenderChildren: TcxRenderChildren): TcxComponentHTMLItem;
var
  AClass: TcxComponentHTMLItemClass;
begin
  AClass := GetComponentHTMLItemClass(AComponentClass);
  Result := AClass.Create(Self, AComponent);
  AParentItem.Insert(Result);
  Result.FComponentClass := AComponentClass;
  Result.EWFTagFormat := AEWFTag;
  if AEWFTagRecord <> nil then
  begin
    Result.FComponentName := AEWFTagRecord^.Name;
    Result.FComponentClassName := AEWFTagRecord^.ClassName;
  end;
  if AClass.InheritsFrom(TcxComponentHTMLItem) then
  begin
    TcxWebControlHTMLItem(Result).Render := ARender;
    FComponentItems.Add(Result);
  end;
  if AClass.InheritsFrom(TcxWebContainerControlHTMLItem) then
  begin
    TcxWebContainerControlHTMLItem(Result).RenderChildren := ARenderChildren;
    FParentItem := Result;
    FContainerItems.Add(Result);
    if Supports(AComponent, IcxWebPageModule) then
    begin
      if FModuleItem <> nil then
        raise GetError(scxTooManyForms, Result.EWFTagFormat, False);
      FModuleItem := TcxWebModuleHTMLItem(Result);
    end;
  end;
end;

function TcxWebHTMLProd.GetComponentHTMLItemClass(AComponentClass: TComponentClass): TcxComponentHTMLItemClass;
begin
  if Supports(AComponentClass, IcxWebPageModule) then
    Result := TcxWebModuleHTMLItem
  else if Supports(AComponentClass, IcxWebContainerControl) then
    Result := TcxWebContainerControlHTMLItem
  else if Supports(AComponentClass, IcxWebControl) then
    Result := TcxWebControlHTMLItem
  else Result := TcxComponentHTMLItem;
end;

function TcxWebHTMLProd.GetSetComponentProperties: Boolean;
begin
  Result := True;
end;

function TcxWebHTMLProd.Browser: TcxWebBrowserClass;
begin
  if ClientData <> nil then
    Result := ClientData.GetBrowser
  else Result := TcxWebBrowserIE;
end;

function TcxWebHTMLProd.ClientData: IcxWebClientData;
begin
  Supports(Module, IcxWebClientData, Result);
end;

function TcxWebHTMLProd.IsFirstRequest: Boolean;
begin
  if ClientData <> nil then
    Result := ClientData.GetIsFirstRequest
  else Result := True;
end;

function TcxWebHTMLProd.CanAssignCustomAttrs: Boolean;
begin
  Result := True;
end;

function TcxWebHTMLProd.GetComponent(Index: Integer): TComponent;
begin
  Result := TComponent(FComponents.Items[Index]);
end;

function TcxWebHTMLProd.GetComponentCount: Integer;
begin
  Result := FComponents.Count;
end;

function TcxWebHTMLProd.GetRendererClass(Index: Integer): TcxWebRendererClass;
begin
  Result := TcxWebRendererClass(FRendererClasses.Items[Index]);
end;

function TcxWebHTMLProd.GetRendererClassCount: Integer;
begin
  Result := FRendererClasses.Count;
end;

procedure TcxWebHTMLProd.FinalizeScriptFactory;
begin
  WebScriptFactory.Unbscribe;
end;

procedure TcxWebHTMLProd.InitializeScriptFactory;
var
  I: Integer;
  ScriptIntf: IcxWebScripts;
begin
  WebScriptFactory.Unbscribe;
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IcxWebScripts, ScriptIntf) then
      ScriptIntf.ScriptsSubscription;
  end;
end;

procedure TcxWebHTMLProd.AddComponent(AComponent: TComponent);
begin
  if (AComponent <> nil) and not (csDestroying in AComponent.ComponentState) and
    (FComponents.IndexOf(AComponent) = -1) then
  begin
    FComponents.Add(AComponent);
    AddProviders(AComponent);
  end;
end;

procedure TcxWebHTMLProd.AddProviders(AComponent: TComponent);
var
  I: Integer;
  ProviderList: TList;
  ProviderIntf: IcxWebProvidersSupport;
begin
  if Supports(AComponent, IcxWebProvidersSupport, ProviderIntf) then
  begin
    ProviderList := TList.Create;
    try
      ProviderIntf.GetProviders(ProviderList);
      for I := 0 to ProviderList.Count - 1 do
        AddComponent(TComponent(ProviderList.Items[I]));
    finally
      ProviderList.Free;
    end;
  end;
end;

procedure TcxWebHTMLProd.AddContainer(AContainer: IcxWebContainerControl; ARenderChildren: Boolean);
var
  I: Integer;
  Component: TComponent;
  ContainerControl: IcxWebContainerControl;
begin
  if ARenderChildren then
    for I := 0 to AContainer.ControlCount - 1 do
    begin
      if Supports(AContainer.Controls[I], IcxWebContainerControl, ContainerControl) then
        AddContainer(ContainerControl, true)
      else AddComponent(GetComponentByInterface(AContainer.Controls[I]));
    end;

  Component := GetComponentByInterface(AContainer);
  for I := 0 to Component.ComponentCount - 1 do
    AddComponent(Component.Components[I]);
end;

function TcxWebHTMLProd.GetRenderClass(AComponent: TComponent): TcxWebRendererClass;
var
  ACodeIntf: IcxCodeProvider;
begin
  if Supports(AComponent, IcxCodeProvider, ACodeIntf) then
    Result := ACodeIntf.GetRendererClass(Browser)
  else Result := nil;
end;

procedure TcxWebHTMLProd.PrepareComponentLists;
  procedure GetComponents(Item: TcxCustomHTMLItem);
  var
    I: Integer;
    ComponentItem: TcxComponentHTMLItem;
  begin
    if Item is TcxComponentHTMLItem then
    begin
      ComponentItem := (Item as TcxComponentHTMLItem);
      if Item is TcxWebContainerControlHTMLItem then
      begin
        if ComponentItem.Render then AddComponent(ComponentItem.Component);
        AddContainer((Item as TcxWebContainerControlHTMLItem).WebContainerControl,
            ComponentItem.RenderChildren <> noRender);
      end
      else if ComponentItem.Render then AddComponent(ComponentItem.Component);
    end;
    for I := 0 to Item.Count - 1 do
      GetComponents(Item.Items[I]);
  end;

var
  I: Integer;
  RendererClass: TcxWebRendererClass;
begin
  GetComponents(Items);

  for I := 0 to ComponentCount - 1 do
  begin
    RendererClass := GetRenderClass(Components[I]);
    if (RendererClass <> nil) and
      (FRendererClasses.IndexOf(RendererClass) = -1) then
      FRendererClasses.Add(RendererClass);
  end;
end;

procedure TcxWebHTMLProd.WriteHiddenFormElementsCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  CodeIntf: IcxCodeProvider;
  ControlInf: IcxWebControl;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IcxWebControl, ControlInf) and
      not ControlInf.Visible then continue;
    if Supports(Components[I], IcxCodeProvider, CodeIntf) then
      CodeIntf.WriteHiddenFormElements(HTMLTextBuilder);
  end;
end;

procedure TcxWebHTMLProd.WriteScriptCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  CodeIntf: IcxCodeProvider;
  ControlInf: IcxWebControl;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IcxWebControl, ControlInf) and
      not ControlInf.Visible then continue;
    if Supports(Components[I], IcxCodeProvider, CodeIntf) then
      CodeIntf.WriteScripts(HTMLTextBuilder);
  end;
  for I := 0 to RendererClassCount - 1 do
    RendererClasses[I].WriteClassScripts(HTMLTextBuilder);
end;

procedure TcxWebHTMLProd.WriteExternalStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I, J: Integer;
  List, ItemList: TStringList;
  AStylesIntf: IcxStylesProvider;
begin
  List := TStringList.Create;
  ItemList := TStringList.Create;
  try
    for I := 0 to ComponentCount - 1 do
    begin
      if Supports(Components[I], IcxStylesProvider, AStylesIntf) then
        AStylesIntf.GetCSSFiles(HTMLTextBuilder, ItemList);
      for J := 0 to ItemList.Count - 1 do
        if List.IndexOf(ItemList.Strings[J]) = -1 then
          List.Add(ItemList.Strings[J]);
      ItemList.Clear;
    end;
    for I := 0 to List.Count - 1 do
    begin
      HTMLTextBuilder.WriteSingleTag(TcxHTMLTagLink);
      HTMLTextBuilder.WriteAttribute(aRel, 'stylesheet');
      HTMLTextBuilder.WriteAttribute(aHref, List.Strings[I]);
      HTMLTextBuilder.WriteAttribute(aType, 'text/css');
    end;
  finally
    ItemList.Free;
    List.Free;
  end;
end;

procedure TcxWebHTMLProd.WriteStylesCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  AStylesIntf: IcxStylesProvider;
  ControlInf: IcxWebControl;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IcxWebControl, ControlInf) and
      not ControlInf.Visible then continue;
    if Supports(Components[I], IcxStylesProvider, AStylesIntf) then
      AStylesIntf.WriteStyles(HTMLTextBuilder);
  end;
  for I := 0 to RendererClassCount - 1 do
    RendererClasses[I].WriteStyles(HTMLTextBuilder);
end;

procedure TcxWebHTMLProd.WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  WriteExternalStyles(HTMLTextBuilder);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagStyle);
  HTMLTextBuilder.WriteAttribute(aType, 'text/css');
  HTMLTextBuilder.WriteText('<!--');
  WriteStylesCode(HTMLTextBuilder);
  HTMLTextBuilder.WriteText('//-->');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagStyle);
end;

procedure TcxWebHTMLProd.WriteIncludedScripts(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I, J: Integer;
  List, ItemList: TStringList;
begin
  List := TStringList.Create;
  List.Add(scxCommonScriptName);
  List.Add(scxModuleScriptName);
  ItemList := TStringList.Create;
  try
    for I := 0 to RendererClassCount - 1 do
    begin
      RendererClasses[I].GetScriptFiles(ItemList);
      for J := 0 to ItemList.Count - 1 do
        if List.IndexOf(ItemList.Strings[J]) = -1 then
          List.Add(ItemList.Strings[J]);
      ItemList.Clear;
    end;
    for I := 0 to List.Count - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagScript, True, False);
      HTMLTextBuilder.WriteAttribute(aLanguage, 'JavaScript1.2');
      HTMLTextBuilder.WriteAttribute(aSrc, QualifyJSFileName(List.Strings[I]));
      HTMLTextBuilder.WriteAttribute(aType, 'text/javascript');
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagScript, False, True);
    end;
  finally
    ItemList.Free;
    List.Free;
  end;
end;

procedure TcxWebHTMLProd.WriteScripts(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagScript);
  HTMLTextBuilder.WriteAttribute(aLanguage, 'JavaScript1.2');
  HTMLTextBuilder.WriteAttribute(aType, 'text/javascript');
  HTMLTextBuilder.WriteText('<!--');
  WriteScriptCode(HTMLTextBuilder);
  WriteFactoryScriptCode(HTMLTextBuilder);
  HTMLTextBuilder.WriteText('//-->');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagScript);
end;

procedure TcxWebHTMLProd.WriteOutOfFormHTMLCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  CodeIntf: IcxCodeProvider;
  ControlInf: IcxWebControl;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IcxWebControl, ControlInf) and
      not ControlInf.Visible then continue;
    if Supports(Components[I], IcxCodeProvider, CodeIntf) then
      CodeIntf.WriteOutOfFormHTML(HTMLTextBuilder);
  end;
end;

procedure TcxWebHTMLProd.WriteClassOutOfFormHTMLCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
begin
  for I := 0 to RendererClassCount - 1 do
    RendererClasses[I].WriteClassOutOfFormHTML(HTMLTextBuilder);
end;

procedure TcxWebHTMLProd.WriteClassHTMLCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
begin
  for I := 0 to RendererClassCount - 1 do
    RendererClasses[I].WriteClassHTML(HTMLTextBuilder);
end;

procedure TcxWebHTMLProd.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  WriteHiddenFormElementsCode(HTMLTextBuilder);
  WriteFactoryHiddenFormElementsCode(HTMLTextBuilder);
end;

procedure TcxWebHTMLProd.WriteFactoryHiddenFormElementsCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Argument: TcxWebScriptRenderArgument;
begin
  if Supports(Module, IcxWebPageModule, Argument.Module) then
    WebScriptFactory.WriteHiddenFormElements(HTMLTextBuilder, Argument);
end;

procedure TcxWebHTMLProd.WriteFactoryScriptCode(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Argument: TcxWebScriptRenderArgument;
begin
  if Supports(Module, IcxWebPageModule, Argument.Module) then
    WebScriptFactory.WriteScript(HTMLTextBuilder, Argument);
end;

function TcxWebHTMLProd.GetError(const AMsg, AErrorStr: string;
    AParserError: Boolean): EcxWebHTMLParserException;
begin
  Result := EcxWebHTMLParserException.Create(AMsg, AErrorStr, AParserError);
end;

procedure TcxWebHTMLProd.DoAfterHTMLRender;
begin
end;

procedure TcxWebHTMLProd.DoBeforeHTMLRender;
begin
end;

function TcxWebHTMLProd.GetComponentItem(Index: Integer): TcxComponentHTMLItem;
begin
  Result := TcxComponentHTMLItem(FComponentItems.Items[Index]);
end;

function TcxWebHTMLProd.GetComponentItemCount: Integer;
begin
  Result := FComponentItems.Count;
end;

function TcxWebHTMLProd.GetContainerItem(Index: Integer): TcxWebContainerControlHTMLItem;
begin
  Result := TcxWebContainerControlHTMLItem(FContainerItems.Items[Index]);
end;

function TcxWebHTMLProd.GetContainerItemCount: Integer;
begin
  Result := FContainerItems.Count;
end;

end.
