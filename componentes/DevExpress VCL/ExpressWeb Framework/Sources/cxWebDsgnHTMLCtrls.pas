{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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

unit cxWebDsgnHTMLCtrls;

interface

uses Classes, SysUtils, Windows, MSHTML_TLB;

type
  TcxBaseHTMLElement = class;

  IcxBaseHTMLElementCreatorNotify = interface
    procedure HTMLElementCreated(ABaseHTMLElement: TcxBaseHTMLElement);
    function GetHTMLElementFileName: string;
  end;

  TcxBaseHTMLElement = class(TComponent)
  protected
    class function GetStyle(const AAbsolutePosition: Boolean; const ARect: TRect): string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; virtual; abstract;
    class function GetInnerHTML: string; virtual;
    class procedure AfterElementCreated(AElement: IHTMLElement); virtual;
  end;

  TcxBaseHTMLElementClass = class of TcxBaseHTMLElement;

  TcxHTMLLabelElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
    class function GetInnerHTML: string; override;
  end;

  TcxHTMLButtonElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLResetButtonElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLSubmitButtonElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLTextFieldElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLTextAreaElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLFileFieldElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLPasswordFieldElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLCheckBoxElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLRadioButtonElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLHiddenElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLTableElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
    class procedure AfterElementCreated(AElement: IHTMLElement); override;
  end;

  TcxHTMLImageElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLListBoxElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLDropDownElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

  TcxHTMLHorizontalRuleElement = class(TcxBaseHTMLElement)
  public
    class function GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string; override;
  end;

procedure AddBaseHTMLElementCreatorNotify(ANotify: IcxBaseHTMLElementCreatorNotify);
procedure RemoveBaseHTMLElementCreatorNotify(ANotify: IcxBaseHTMLElementCreatorNotify);

procedure Register;

implementation

uses
  ToolsAPI;

{$R *.dcr}

var
  FElementCreateNotifyList: IInterfaceList = nil;

procedure AddBaseHTMLElementCreatorNotify(ANotify: IcxBaseHTMLElementCreatorNotify);
begin
  if (FElementCreateNotifyList = nil) then
    FElementCreateNotifyList := TInterfaceList.Create;
  FElementCreateNotifyList.Add(ANotify);
end;

procedure RemoveBaseHTMLElementCreatorNotify(ANotify: IcxBaseHTMLElementCreatorNotify);
begin
  if (FElementCreateNotifyList = nil) then exit;
  FElementCreateNotifyList.Remove(ANotify);
  if FElementCreateNotifyList.Count = 0 then
    FElementCreateNotifyList := nil;
end;

function BaseHTMLElementCreatorNotify(ABaseHTMLElement: TcxBaseHTMLElement): Boolean;
var
  I: Integer;
  AFileName: string;
begin
  Result := False;
  if FElementCreateNotifyList = nil then exit;
  AFileName := (BorlandIDEServices as IOTAModuleServices).CurrentModule.FileName;
  for I := 0 to FElementCreateNotifyList.Count - 1 do
    if CompareText(AFileName, IcxBaseHTMLElementCreatorNotify(FElementCreateNotifyList[I]).GetHTMLElementFileName) = 0 then
    begin
      Result := True;
      IcxBaseHTMLElementCreatorNotify(FElementCreateNotifyList[I]).HTMLElementCreated(ABaseHTMLElement);
      exit;
    end;
end;

{ TcxBaseHTMLElement }
constructor TcxBaseHTMLElement.Create(AOwner: TComponent);
begin
  if not BaseHTMLElementCreatorNotify(self) then
  //TODO move to resources
    raise Exception.CreateFmt('You can not create an instance of [%s] component class', [ClassName]);
end;

class function TcxBaseHTMLElement.GetStyle(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  if AAbsolutePosition then
  begin
    with ARect do
      if (Right - Left > 0) and (Bottom - Top > 0) then
        Result := Format('Style="POSITION:absolute; LEFT:%dpx; TOP:%dpx; WIDTH:%dpx; HEIGHT:%dpx"',
                  [Left, Top, Right - Left, Bottom - Top])
      else Result := Format('Style="POSITION:absolute; LEFT:%dpx; TOP:%dpx"', [Left, Top])
  end else Result := '';
end;

class function TcxBaseHTMLElement.GetInnerHTML: string;
begin
  Result := '';
end;

class procedure TcxBaseHTMLElement.AfterElementCreated(AElement: IHTMLElement);
begin
end;


class function TcxHTMLLabelElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  if AAbsolutePosition then
    Result := Format('<DIV %s></DIV>', [GetStyle(AAbsolutePosition, ARect)])
  else Result := Format('<DIV STYLE="WIDTH:%dpx; HEIGHT:%dpx"></DIV>',
                [ARect.Right - ARect.Left, ARect.Bottom - ARect.Top])
end;

class function TcxHTMLLabelElement.GetInnerHTML: string;
begin
  Result := ' Label ';
end;


class function TcxHTMLButtonElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="button" value="Button" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLResetButtonElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="reset" value="Reset" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLSubmitButtonElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="submit" value="Submit" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLTextFieldElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="text" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLTextAreaElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<TEXTAREA rows="2" cols="20" %s> </TEXTAREA>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLFileFieldElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="file" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLPasswordFieldElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="password" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLCheckBoxElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="checkbox" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLRadioButtonElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="radio" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLHiddenElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<INPUT type="hidden" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLTableElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  with ARect do
    Result := Format('<table cellspacing=1 cellpadding=1 width=%d height=%d border=1 %s></table>',
                [Right - Left, Bottom - Top, GetStyle(AAbsolutePosition, ARect)]);
end;


class procedure TcxHTMLTableElement.AfterElementCreated(AElement: IHTMLElement);
var
  ATable: IHTMLTable;

  procedure InsertRow(AIndex: Integer);
  var
    ARow: IHTMLTableRow;
    ADispatch: IDispatch;
  begin
    ADispatch := ATable.insertRow(AIndex);
    if ADispatch.QueryInterface(IHTMLTableRow, ARow) = S_OK then
    begin
      ARow.insertCell(0);
      ARow.insertCell(1);
      ARow.insertCell(2);
    end;
  end;

begin
  if not Supports(AElement, IHTMLTable, ATable) then exit;
  InsertRow(0);
  InsertRow(1);
  InsertRow(2);
end;


class function TcxHTMLImageElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<IMG alt="" src="" %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLListBoxElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<SELECT size=2 %s> <OPTION></OPTION> </SELECT>', [GetStyle(AAbsolutePosition, ARect)]);
end;

class function TcxHTMLDropDownElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<SELECT %s> <OPTION></OPTION> </SELECT>', [GetStyle(AAbsolutePosition, ARect)]);
end;


class function TcxHTMLHorizontalRuleElement.GetHTML(const AAbsolutePosition: Boolean; const ARect: TRect): string;
begin
  Result := Format('<HR width=100%% size=1 %s>', [GetStyle(AAbsolutePosition, ARect)]);
end;

procedure Register;
begin
  RegisterComponents('EWF HTML Elements', [TcxHTMLLabelElement, TcxHTMLButtonElement,
    TcxHTMLResetButtonElement, TcxHTMLSubmitButtonElement, TcxHTMLTextFieldElement,
    TcxHTMLTextAreaElement, TcxHTMLFileFieldElement, TcxHTMLPasswordFieldElement,
    TcxHTMLCheckBoxElement, TcxHTMLRadioButtonElement, TcxHTMLHiddenElement,
    TcxHTMLTableElement, TcxHTMLImageElement, TcxHTMLListBoxElement, TcxHTMLDropDownElement,
    TcxHTMLHorizontalRuleElement]);
end;

end.
