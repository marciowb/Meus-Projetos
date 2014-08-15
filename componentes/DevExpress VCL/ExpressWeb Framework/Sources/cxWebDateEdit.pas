{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       WebDateEdit Control                                         }
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

unit cxWebDateEdit;

{$I cxVer.inc}

interface

uses
  Classes, Types, TypInfo,
  cxWebTypes, cxWebIntf, cxWebRender, cxWebClasses, cxWebCalendar;

type
  TcxWebDateEditEvent = (ceOnSelectDay, ceOnShiftMonth, ceOnValidateEditText);

  TcxWebDateEditEventsHelper = class(TcxWebCalendarEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxCustomWebDateEdit = class(TcxCustomWebCalendar, IcxWebTabOrderable)
  private
    FButtonImageIndex: Integer;
    FButtonWidth: Integer;
    FButtonStyles: TcxWebStyles;
    FEditorStyles: TcxWebStyles;
    FTextHeight: Integer;

    function GetButtonStyles: TcxWebStyles;
    function GetEditorStyles: TcxWebStyles;
    procedure SetButtonStyles(AValue: TcxWebStyles);
    procedure SetEditorStyles(AValue: TcxWebStyles);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure CalcTextHeight;
    function GetDefaultHorzBordersSize: Integer; override;
    function GetDefaultVertBordersSize: Integer; override;
    function GetMaxHeight: Integer; override;
    function GetMinHeight: Integer; override;
    { IcxWebProvidersSupport}
    procedure ImplGetProviders(AList: TList); override;
    { events }
    function GetWebEventsHelper: TcxWebDateEditEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebDateEditEventsHelper read GetWebEventsHelper;
    { renderers}
    procedure RegisterRenderers; override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    { styles }
    procedure StyleChanged(Style: TcxWebStyleItem); override;
    { date conversion }
    function DecodeDate(ADate: string): TcxWebDate;
    function EncodeDate(ADate: TcxWebDate): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ButtonImageIndex: Integer read FButtonImageIndex write FButtonImageIndex;
    property ButtonWidth: Integer read FButtonWidth write FButtonWidth;
    property ButtonStyles: TcxWebStyles read GetButtonStyles write SetButtonStyles;
    property EditorStyles: TcxWebStyles read GetEditorStyles write SetEditorStyles;
    property TabOrder;
    property TabStop;
  end;

  TcxCustomWebDateEditRenderer = class(TcxCustomWebCalendarRenderer)
  private
    function GetWebDateEdit: TcxCustomWebDateEdit;

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
    procedure WriteButton; virtual;
    procedure WriteCalendarAttributes; override;
    procedure WriteTextEdit; virtual;

    function CreationProc: string; override;
    function ShiftMonthScriptProc: string; override;
    function SelectDayScriptProc: string; override;
    function TodayLinkScriptProc: string; override;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHTML; override;

    property WebDateEdit: TcxCustomWebDateEdit read GetWebDateEdit;
  end;

  TcxCustomWebDateEditNS4Renderer = class(TcxCustomWebCalendarNS4Renderer)
  private
    function GetWebDateEdit: TcxCustomWebDateEdit;

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
    procedure WriteButton; virtual;
    procedure WriteCalendarAttributes; override;
    procedure WriteTextEdit; virtual;

    function CreationProc: string; override;
    function ShiftMonthScriptProc: string; override;
    function SelectDayScriptProc: string; override;
    function TodayLinkScriptProc: string; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHTML; override;
    procedure WriteOutOfFormHTML; override;

    property WebDateEdit: TcxCustomWebDateEdit read GetWebDateEdit;
  end;

  TcxCustomWebDateEditOperaRenderer = class(TcxCustomWebDateEditRenderer)
  protected
    function ForcePostBack: Boolean; override;
    procedure WriteTextEdit; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebDateEdit = class(TcxCustomWebDateEdit)
  published
    property SelectedDate;
  end;

implementation

uses SysUtils, DateUtils,
  {$IFDEF VCL}
  Windows,
  {$ENDIF}
  cxWebConsts, cxWebColors, cxWebUtils, cxWebGraphics, cxWebControls;

{ TcxWebDateEditEventsHelper }

function TcxWebDateEditEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebDateEditEvent] of string = ('OnSelectDay', 'OnShiftMonth',
      'OnValidateEditText');
begin
  Result := cxHTMLEvent[TcxWebDateEditEvent(AEvent)];
end;

function TcxWebDateEditEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebDateEditEvent] of string = ('(Sender, ADate)',
    '(Sender, Offset)', '(Sender, AText)');
begin
  Result := cxHTMLEventProcParams[TcxWebDateEditEvent(AEvent)];
end;

function TcxWebDateEditEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebDateEditEvent);
end;

{ TcxCustomWebDateEdit }

constructor TcxCustomWebDateEdit.Create(AOwner: TComponent);
begin
  inherited;
  CalcTextHeight;
  if FTextHeight <> 0 then
    FButtonWidth := FTextHeight
  else
    FButtonWidth := Height - GetVertBordersSize;
end;

destructor TcxCustomWebDateEdit.Destroy;
begin
  FButtonStyles.Free;
  FEditorStyles.Free;
  inherited;
end;

procedure TcxCustomWebDateEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not IsDestroying and (AComponent is TcxWebStyleItem) then
  begin
    if ButtonStyles <> nil then
      ButtonStyles.Notification(AComponent, Operation);
    if EditorStyles <> nil then
      EditorStyles.Notification(AComponent, Operation);
  end;
end;

procedure TcxCustomWebDateEdit.CalcTextHeight;
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

function TcxCustomWebDateEdit.GetDefaultHorzBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebDateEdit.GetDefaultVertBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebDateEdit.GetMaxHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else Result := 0;
end;

function TcxCustomWebDateEdit.GetMinHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else Result := 0;
end;

procedure TcxCustomWebDateEdit.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  AddStylesToProviderList(AList, [ButtonStyles, EditorStyles]);
end;

procedure TcxCustomWebDateEdit.DoSetValues;
begin
  inherited;
  try
    SelectedDate := StrToDate(WebValuesHelper.Values.Values[Name + 'Editor']);
  except
    on EConvertError do ;
    else raise;
  end
end;

function TcxCustomWebDateEdit.GetWebEventsHelper: TcxWebDateEditEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebDateEditEventsHelper;
end;

class function TcxCustomWebDateEdit.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebDateEditEventsHelper;
end;

procedure TcxCustomWebDateEdit.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebDateEditRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDateEditNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDateEditOperaRenderer);
end;

procedure TcxCustomWebDateEdit.RegisterValues;
begin
  inherited;
  WebValuesHelper.RegisterValue(Name + 'Editor', DateToStr(SelectedDate));
end;

procedure TcxCustomWebDateEdit.StyleChanged(Style: TcxWebStyleItem);
begin
  CalcTextHeight;
  inherited;
end;

function TcxCustomWebDateEdit.DecodeDate(ADate: string): TcxWebDate;
begin
  Result := StrToDate(ADate);
end;

function TcxCustomWebDateEdit.EncodeDate(ADate: TcxWebDate): string;
begin
  Result := DateToStr(ADate);
end;

function TcxCustomWebDateEdit.GetButtonStyles: TcxWebStyles;
begin
  if FButtonStyles = nil then
    FButtonStyles := TcxWebStyles.Create(Self);
  Result := FButtonStyles;
end;

function TcxCustomWebDateEdit.GetEditorStyles: TcxWebStyles;
begin
  if FEditorStyles = nil then
    FEditorStyles := TcxWebStyles.Create(Self);
  Result := FEditorStyles;
end;

procedure TcxCustomWebDateEdit.SetButtonStyles(AValue: TcxWebStyles);
begin
  FButtonStyles.Assign(AValue);
end;

procedure TcxCustomWebDateEdit.SetEditorStyles(AValue: TcxWebStyles);
begin
  FEditorStyles.Assign(AValue);
end;

{ TcxCustomWebDateEditRenderer }

class procedure TcxCustomWebDateEditRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxCalendarScriptName);
  AList.Add(scxDateEditScriptName);
end;

procedure TcxCustomWebDateEditRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  WriteHint;
  WritePopupMenu;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDateEdit.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDateEdit.Width);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteTextEdit;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteButton;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);


  if not WebDateEdit.IsDesigning then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aColspan, 2);
    HTMLTextBuilder.WriteAttribute(aHeight, 1);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, WebDateEdit.Name + 'Calendar');
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, WebDateEdit.ZIndex + 10000);    
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
    WriteCalendar;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebDateEditRenderer.WriteButton;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDateEdit.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDateEdit.ButtonWidth);
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
  HTMLTextBuilder.WriteAttribute(aHeight, WebDateEdit.Height - ButtonBottomWidth - ButtonTopWidth);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonColor));
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteAttribute(aId, WebDateEdit.Name + 'Button');
  HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:DateEditButtonClick(''%s'');',
    [WebDateEdit.Name]));

  if (WebDateEdit.Images <> nil) and (WebDateEdit.Images.ValidIndex(WebDateEdit.ButtonImageIndex)) then
    WebDateEdit.Images.Images[WebDateEdit.ButtonImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scxdeDownImageName));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    if WebDateEdit.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, WebDateEdit.Hint);
  end;
  HTMLTextBuilder.WriteAttribute(aName, WebDateEdit.Name + 'ButtonImage');
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

procedure TcxCustomWebDateEditRenderer.WriteCalendarAttributes;
begin
end;

procedure TcxCustomWebDateEditRenderer.WriteTextEdit;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aType, 'text');
  HTMLTextBuilder.WriteAttribute(aValue, WebDateEdit.EncodeDate(WebDateEdit.SelectedDate));
  HTMLTextBuilder.WriteAttribute(aName, WebDateEdit.Name + 'Editor');
  HTMLTextBuilder.WriteAttribute(aId, WebDateEdit.Name + 'Editor');
  if WebDateEdit.EditorStyles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, WebDateEdit.EditorStyles.Default.FullName);
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebDateEdit.Width - WebDateEdit.ButtonWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebDateEdit.Height, 'px');
  if not WebDateEdit.IsDesigning then
    HTMLTextBuilder.WriteEventAttribute(eOnKeyPress, Format('DataEditKeyPress(''%s'', window.event);', [WebDateEdit.Name]));
end;

function TcxCustomWebDateEditRenderer.CreationProc: string;
begin
  Result := 'CreateDateEdit';
end;

function TcxCustomWebDateEditRenderer.ShiftMonthScriptProc: string;
begin
  Result := 'DateEditShiftMonth';
end;

function TcxCustomWebDateEditRenderer.SelectDayScriptProc: string;
begin
  Result := 'DateEditSelectDay';
end;

function TcxCustomWebDateEditRenderer.TodayLinkScriptProc: string;
begin
  Result := 'DateEditSelectToday';
end;

function TcxCustomWebDateEditRenderer.GetWebDateEdit: TcxCustomWebDateEdit;
begin
  Result := Component as TcxCustomWebDateEdit;
end;

function TcxCustomWebDateEditRenderer.ButtonColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wsavColor in WebDateEdit.ButtonStyles.Default.Style.Shading.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Shading.Color
  else Result := $00C8D0D4;
end;

function TcxCustomWebDateEditRenderer.ButtonBottomWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.Width
  else Result := 1;
end;

function TcxCustomWebDateEditRenderer.ButtonBottomColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.Color
  else Result := clWebBlack;
end;

function TcxCustomWebDateEditRenderer.ButtonLeftWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Left.Width
  else Result := 1;
end;

function TcxCustomWebDateEditRenderer.ButtonLeftColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Left.Color
  else Result := clWebWhite;
end;

function TcxCustomWebDateEditRenderer.ButtonRightWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Right.Width
  else Result := 1;
end;

function TcxCustomWebDateEditRenderer.ButtonRightColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Right.Color
  else Result := clWebBlack;
end;

function TcxCustomWebDateEditRenderer.ButtonTopWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Top.Width
  else Result := 1;
end;

function TcxCustomWebDateEditRenderer.ButtonTopColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Top.Color
  else Result := clWebWhite;
end;


{ TcxCustomWebDateEditNS4Renderer }
class function TcxCustomWebDateEditNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

class procedure TcxCustomWebDateEditNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxCalendarScriptName);
  AList.Add(scxDateEditScriptName);
end;

function TcxCustomWebDateEditNS4Renderer.GetWebDateEdit: TcxCustomWebDateEdit;
begin
  Result := Component as TcxCustomWebDateEdit;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wsavColor in WebDateEdit.ButtonStyles.Default.Style.Shading.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Shading.Color
  else Result := $00C8D0D4;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonBottomWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.Width
  else Result := 1;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonBottomColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Bottom.Color
  else Result := clWebBlack;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonLeftWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Left.Width
  else Result := 1;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonLeftColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Left.Color
  else Result := clWebWhite;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonRightWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Right.Width
  else Result := 1;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonRightColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Right.Color
  else Result := clWebBlack;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonTopWidth: Integer;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavWidth in WebDateEdit.ButtonStyles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Top.Width
  else Result := 1;
end;

function TcxCustomWebDateEditNS4Renderer.ButtonTopColor: TcxWebColor;
begin
  if (WebDateEdit.ButtonStyles.Default <> nil) and
    (wbavColor in WebDateEdit.ButtonStyles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebDateEdit.ButtonStyles.Default.Style.Borders.Top.Color
  else Result := clWebWhite;
end;

procedure TcxCustomWebDateEditNS4Renderer.WriteButton;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDateEdit.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDateEdit.ButtonWidth);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonTopColor));
  WriteInvisibleImage(ButtonLeftWidth, ButtonTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonTopColor));
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonTopColor));
  WriteInvisibleImage(ButtonRightWidth, ButtonTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonLeftColor));
  WriteInvisibleImage(ButtonLeftWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDateEdit.Height - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonColor));
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteAttribute(aId, WebDateEdit.Name + 'Button');
  HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:DateEditButtonClick(''%s'');',
    [WebDateEdit.Name]));

  if (WebDateEdit.Images <> nil) and (WebDateEdit.Images.ValidIndex(WebDateEdit.ButtonImageIndex)) then
    WebDateEdit.Images.Images[WebDateEdit.ButtonImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scxdeDownImageName));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    if WebDateEdit.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, WebDateEdit.Hint);
  end;
  HTMLTextBuilder.WriteAttribute(aName, WebDateEdit.Name + 'ButtonImage');
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonRightColor));
  WriteInvisibleImage(ButtonRightWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonBottomColor));
  WriteInvisibleImage(ButtonLeftWidth, ButtonBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonBottomColor));
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ButtonBottomColor));
  WriteInvisibleImage(ButtonRightWidth, ButtonBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebDateEditNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  WriteHint;
  WritePopupMenu;
  WriteAttributes;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDateEdit.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDateEdit.Width);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteTextEdit;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  WriteButton;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 2);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteAttribute(aName, WebDateEdit.Name + 'PosImage');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebDateEditNS4Renderer.WriteOutOfFormHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagLayer);
  HTMLTextBuilder.WriteAttribute(aId, WebDateEdit.Name + 'Calendar');
  HTMLTextBuilder.WriteAttribute(aVisibility, 'hidden');
  WriteCalendar;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagLayer);
end;

procedure TcxCustomWebDateEditNS4Renderer.WriteCalendarAttributes;
begin
end;

function TcxCustomWebDateEditNS4Renderer.CreationProc: string;
begin
  Result := 'CreateDateEdit';
end;

function TcxCustomWebDateEditNS4Renderer.ShiftMonthScriptProc: string;
begin
  Result := 'DateEditShiftMonth';
end;

function TcxCustomWebDateEditNS4Renderer.SelectDayScriptProc: string;
begin
  Result := 'DateEditSelectDay';
end;

function TcxCustomWebDateEditNS4Renderer.TodayLinkScriptProc: string;
begin
  Result := 'DateEditSelectToday';
end;

procedure TcxCustomWebDateEditNS4Renderer.WriteTextEdit;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aType, 'text');
  HTMLTextBuilder.WriteAttribute(aValue, WebDateEdit.EncodeDate(WebDateEdit.SelectedDate));
  HTMLTextBuilder.WriteAttribute(aName, WebDateEdit.Name + 'Editor');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  if not WebDateEdit.IsDesigning then
  begin
    HTMLTextBuilder.WriteEventAttribute(eOnKeyPress, Format('DataEditKeyPress(''%s'', window.event);', [WebDateEdit.Name]));
  end;
end;

{ TcxCustomWebDateEditOperaRenderer }

function TcxCustomWebDateEditOperaRenderer.ForcePostBack: Boolean;
begin
  Result := True;
end;

class function TcxCustomWebDateEditOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

procedure TcxCustomWebDateEditOperaRenderer.WriteTextEdit;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aType, 'text');
  HTMLTextBuilder.WriteAttribute(aValue, WebDateEdit.EncodeDate(WebDateEdit.SelectedDate));
  HTMLTextBuilder.WriteAttribute(aName, WebDateEdit.Name + 'Editor');
  HTMLTextBuilder.WriteAttribute(aId, WebDateEdit.Name + 'Editor');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebDateEdit.Width - WebDateEdit.ButtonWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebDateEdit.Height, 'px');
  if not WebDateEdit.IsDesigning then
    HTMLTextBuilder.WriteEventAttribute(eOnKeyPress, Format('DataEditKeyPress(''%s'', window.event);', [WebDateEdit.Name]));
end;

initialization
  RegisterClasses([TcxWebDateEdit]);

end.
