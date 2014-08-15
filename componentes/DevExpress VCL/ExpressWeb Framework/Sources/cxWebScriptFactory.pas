{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Client Java Script Factory                                  }
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
unit cxWebScriptFactory;

{$I cxVer.inc}

interface

uses
  Classes, Contnrs,
  cxWebIntf, cxWebRender;

const
  wssAlt = 1;
  wssCtrl = 2;
  wssShift = 4;

type
  PcxWebScriptRenderArgument = ^TcxWebScriptRenderArgument;
  TcxWebScriptRenderArgument = record
    Module: IcxWebPageModule;
  end;

  TcxWebScriptClass = class of TcxWebScript;
  TcxWebScript = class(TPersistent)
  protected
    class function IsDesigning(const Argument: TcxWebScriptRenderArgument): Boolean;
    class function Root(const Argument: TcxWebScriptRenderArgument): TComponent;
    class procedure WriteHiddenField(HTMLTextBuilder: TcxHTMLTextBuilder; FieldName, FieldValue: string); virtual;
  public
    class procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); virtual;
    class procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); virtual;
  end;

  TcxWebPostBackScript = class(TcxWebScript)
  public
    class procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
    class procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
  end;

  TcxWebChangeStyleScript = class(TcxWebScript)
  public
    class procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
  end;

  TcxWebAdvancedPostBackScript = class(TcxWebScript)
  public
    class procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
    class procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
  end;

  TcxWebFocusedScript = class(TcxWebScript)
  private
    class procedure TabArrayRender(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument);
  public
    class procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
  end;

  TcxWebInitScript = class(TcxWebScript)
  public
    class procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
    class procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
  end;


  TcxWebScriptFactory = class
  private
    FScripts: TClassList;

    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebScriptFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebScriptFactory;
    class procedure ReleaseInstance;

    procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument);
    procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument);

    procedure Subscribe(const AScriptClass: TcxWebScriptClass);
    procedure Unbscribe;
  end;

function WebScriptFactory: TcxWebScriptFactory;

implementation

uses SysUtils, HTTPProd,
  {$IFDEF VCL}
  Windows,
  {$ELSE}
  LibC,
  {$ENDIF}
  cxWebUtils, cxWebClientConsts;

function WebScriptFactory: TcxWebScriptFactory;
begin
  Result := TcxWebScriptFactory.Instance;
end;

{ TcxWebScript }
class function TcxWebScript.IsDesigning(const Argument: TcxWebScriptRenderArgument): Boolean;
begin
  Result := csDesigning in Root(Argument).ComponentState;
end;

class function TcxWebScript.Root(const Argument: TcxWebScriptRenderArgument): TComponent;
begin
  Result := GetComponentByInterface(Argument.Module);
end;

class procedure TcxWebScript.WriteHiddenField(HTMLTextBuilder: TcxHTMLTextBuilder;
    FieldName, FieldValue: string);
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aType, 'hidden');
  HTMLTextBuilder.WriteAttribute(aName, FieldName);
  HTMLTextBuilder.WriteAttribute(aId, FieldName);  
  HTMLTextBuilder.WriteAttribute(aValue, FieldValue);
end;

class procedure TcxWebScript.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
end;

class procedure TcxWebScript.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
end;

{ TcxWebPostBackScript }

class procedure TcxWebPostBackScript.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
  WriteHiddenField(HTMLTextBuilder, CLIENT__TARGETNAME, '');
  WriteHiddenField(HTMLTextBuilder, CLIENT__ACTIONNAME, '');
end;

class procedure TcxWebPostBackScript.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
  HTMLTextBuilder.WriteText('var AllowPostBack = true;');
  HTMLTextBuilder.WriteText(
      'function __doPostBack(eventTarget, eventArgument)' + #13#10 +
      '{' + #13#10 +
      '    if(!AllowPostBack) return;' + #13#10 +
      '    var theform = document.' + Root(Argument).Name + #13#10 +
      '    theform.' + CLIENT__TARGETNAME + '.value = eventTarget;' + #13#10 +
      '    theform.' + CLIENT__ACTIONNAME + '.value = eventArgument;' + #13#10 +
      '    theform.' + CLIENT__LEFTPOSNAME + '.value = dxModule.Pos.GetWindowScroll().x;' + #13#10 +
      '    theform.' + CLIENT__TOPPOSNAME + '.value = dxModule.Pos.GetWindowScroll().y;' + #13#10 +
      '    theform.submit();' + #13#10 +
      '    AllowPostBack = false;' + #13#10 +
      '}'
      );
end;


{ TcxWebChangeStyleScript }

class procedure TcxWebChangeStyleScript.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
  HTMLTextBuilder.WriteText(
      'var savedStyle;' + #13#10 +
      'function __ChangeStyle(e, srcElement, StyleName)' + #13#10 +
      '{' + #13#10 +
      '    if(srcElement) {' + #13#10 +
      '        if(StyleName) {' + #13#10 +
      '            savedStyle = srcElement.className;' + #13#10 +
      '            srcElement.className = StyleName;' + #13#10 +
      '        } else {' + #13#10 +
      '            srcElement.className = savedStyle;' + #13#10 +
      '        }' + #13#10 +
      '    }' + #13#10 +
      '}'
      );
end;



{ TcxWebAdvancedPostBackScript }

class procedure TcxWebAdvancedPostBackScript.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
  WriteHiddenField(HTMLTextBuilder, CLIENT__SHIFTSTATENAME, '0');
end;

class procedure TcxWebAdvancedPostBackScript.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
var
  RootName: string;
begin
  RootName := Root(Argument).Name;
  HTMLTextBuilder.WriteText(
      'function __updateModifiers(e) {' + #13#10 +
      '    if (dxModule.Inf.GetAltState(e))' + #13#10 +
      '        document.'+ RootName + '.' + CLIENT__SHIFTSTATENAME + '.value += ' + IntToStr(wssAlt) + ';' + #13#10 +
      '    if (dxModule.Inf.GetCtrlState(e))' + #13#10 +
      '        document.'+ RootName + '.' + CLIENT__SHIFTSTATENAME + '.value += ' + IntToStr(wssCtrl) + ';' + #13#10 +
      '    if (dxModule.Inf.GetShiftState(e))' + #13#10 +
      '        document.'+ RootName + '.' + CLIENT__SHIFTSTATENAME + '.value += ' + IntToStr(wssShift) + ';' + #13#10 +
      '}' + #13#10 +
      'function __doAdvancedPostBack(e, eventTarget, eventArgument) {' + #13#10 +
      '    __updateModifiers(e);' + #13#10 +
      '    __doPostBack(eventTarget, eventArgument);' + #13#10 +
      '}'
      );
end;

{ TcxWebFocusedScript }

class procedure TcxWebFocusedScript.TabArrayRender(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
var
  I: Integer;
  TabControl: IcxWebControl;
  AModule: IcxWebContainerControl;
  AFounded: Boolean;
begin
  if Supports(Root(Argument), IcxWebContainerControl, AModule) then
    with Root(Argument) do
      for I := 0 to ComponentCount - 1 do
      begin
        if Supports(Components[I], IcxWebTabOrderable) and Supports(Components[I], IcxWebControl, TabControl) then
            HTMLTextBuilder.WriteText(Format('dxModule.Page.AddTabbingElement("%s", %d, %s);',
              [Components[I].Name, AModule.GetLineTabOrder(TabControl, AFounded) + 1, cxWebUtils.BoolToStr(TabControl.TabStop)]));
    end;
end;

class procedure TcxWebFocusedScript.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
var
  RootName: string;
begin
  RootName := Root(Argument).Name;
  TabArrayRender(HTMLTextBuilder, Argument);
  HTMLTextBuilder.WriteText(
      'function __onElementFocus(e)' + #13#10 +
      '{' + #13#10 +
      '    dxModule.Page.OnFocus(e);' + #13#10 +
      '    document.' + RootName + '.' + CLIENT__ACTIVECONTROLNAME + '.value = dxModule.Page.FocusedElementName;' + #13#10 +
      '}' + #13#10 +
      'function __onElementBlur(e)' + #13#10 +
      '{' + #13#10 +
      '}'
      );
end;


{ TcxWebInitScript }

class procedure TcxWebInitScript.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
  WriteHiddenField(HTMLTextBuilder, CLIENT__ACTIVECONTROLNAME, '');
  WriteHiddenField(HTMLTextBuilder, CLIENT__LEFTPOSNAME, '');
  WriteHiddenField(HTMLTextBuilder, CLIENT__TOPPOSNAME, '');
end;

class procedure TcxWebInitScript.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
var
  ActiveControl: TComponent;
  RootName, ActiveControlName: string;
  LeftPos, TopPos: Integer;
  AClientData: IcxWebClientData;
begin
  with Argument.Module do
  begin
    RootName := Root(Argument).Name;
    if Supports(Argument.Module, IcxWebClientData, AClientData) then
    begin
      LeftPos := AClientData.GetScrollLeft;
      TopPos := AClientData.GetScrollTop;
      ActiveControl := GetComponentByInterface(AClientData.GetActiveControl);
      if ActiveControl <> nil then
         ActiveControlName := ActiveControl.Name
      else ActiveControlName := '';
    end else
    begin
      LeftPos := 0;
      TopPos := 0;
      ActiveControlName := '';
    end;
  end;
  HTMLTextBuilder.WriteText(
      'dxModule.Page.Name = "' + RootName + '";' + #13#10 +
      'dxModule.Page.ScrollLeft = ' + IntToStr(LeftPos) + ';' + #13#10 +
      'dxModule.Page.ScrollTop = ' + IntToStr(TopPos) + ';' + #13#10 +
      'dxModule.Page.ActiveControlName = "' + ActiveControlName + '";');
end;

{ TcxWebScriptFactory }

constructor TcxWebScriptFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxWebScriptFactory.Destroy;
begin
  FScripts.Free;
  FScripts := nil;
  inherited Destroy;
end;

constructor TcxWebScriptFactory.CreateInstance(ADummy: Boolean = True);
begin
  FScripts := TClassList.Create;
end;

type
  PcxMultiThreadListItem = ^TcxMultiThreadListItem;
  TcxMultiThreadListItem = record
    ThreadID: Cardinal;
    Obj: TcxWebScriptFactory;
  end;

  TcxMultiThreadList = class
  private
    FList: TThreadList;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function GetScriptFactory: TcxWebScriptFactory;
    procedure DeleteScriptFactory;
  end;

{ TcxMultiThreadList }

constructor TcxMultiThreadList.Create;
begin
  inherited Create;
  FList := TThreadList.Create;
end;

destructor TcxMultiThreadList.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

function TcxMultiThreadList.GetScriptFactory: TcxWebScriptFactory;
var
  AListItem: PcxMultiThreadListItem;
  I: Integer;
begin
  Result := nil;
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      AListItem := PcxMultiThreadListItem(List[I]);
      if (AListItem^.ThreadID = GetCurrentThreadId) then
      begin
        Result := AListItem.Obj;
          break;
      end;
    end;
    if Result = nil then
    begin
       Result := TcxWebScriptFactory.CreateInstance;
       New(AListItem);
       AListItem^.ThreadID := GetCurrentThreadId;
       AListItem^.Obj := Result;
       FList.Add(AListItem);
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TcxMultiThreadList.DeleteScriptFactory;
var
  AListItem: PcxMultiThreadListItem;
  I: Integer;
begin
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      AListItem := PcxMultiThreadListItem(List[I]);
      if (AListItem^.ThreadID = GetCurrentThreadId) then
      begin
        AListItem.Obj.Free;
        FList.Remove(AListItem);
        Dispose(AListItem);
        break;
      end;
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TcxMultiThreadList.Clear;
var
  I: Integer;
begin
  try
    with FList.LockList do
    begin
      for I := 0 to Count - 1 do
      begin
        PcxMultiThreadListItem(List[I]).Obj.Free;
        Dispose(List[I])
      end;
      Clear;
    end;  
  finally
    FList.UnlockList;
  end;
end;

var
  FMultiThreadListInstance: TcxMultiThreadList;

class function TcxWebScriptFactory.AccessInstance(Request: Integer): TcxWebScriptFactory;
begin
  case Request of
    0 : ;
    1 : ;
    2 : ;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FMultiThreadListInstance.GetScriptFactory;
end;

class function TcxWebScriptFactory.Instance: TcxWebScriptFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebScriptFactory.ReleaseInstance;
begin
  FMultiThreadListInstance.DeleteScriptFactory;
end;

procedure TcxWebScriptFactory.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
var
  I: Integer;
begin
  for I := 0 to FScripts.Count - 1 do
    TcxWebScriptClass(FScripts[I]).WriteHiddenFormElements(HTMLTextBuilder, Argument);
end;

procedure TcxWebScriptFactory.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
var
  I: Integer;
begin
  for I := 0 to FScripts.Count - 1 do
    TcxWebScriptClass(FScripts[I]).WriteScript(HTMLTextBuilder, Argument);
end;

procedure TcxWebScriptFactory.Subscribe(const AScriptClass: TcxWebScriptClass);
begin
  if FScripts.IndexOf(AScriptClass) = -1 then
    FScripts.Add(AScriptClass);
end;

procedure TcxWebScriptFactory.Unbscribe;
begin
  FScripts.Clear;
end;

initialization
  RegisterClasses([TcxWebPostBackScript, TcxWebChangeStyleScript, TcxWebAdvancedPostBackScript,
      TcxWebFocusedScript, TcxWebInitScript]);
  FMultiThreadListInstance := TcxMultiThreadList.Create;

finalization
   FMultiThreadListInstance.Free;

end.
