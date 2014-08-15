{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Basic interfaces                                            }
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
unit cxWebIntf;

interface

{$I cxVer.inc}

uses Classes, HTTPApp, HttpProd,
  {$IFDEF VCL}
   Windows,
  {$ELSE}
  Types,
  {$ENDIF}
   cxWebRender;

type

  IcxStylesProvider = interface
  ['{81C2E73B-DFFF-4939-B27B-DEE1E5E6AB57}']
    procedure GetCSSFiles(HTMLTextBuilder: TcxHTMLTextBuilder; AList: TStrings);
    procedure WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
  end;

  TcxWebComponentState = (wcsLoading);
  TcxWebComponentStates = set of TcxWebComponentState;

  IcxWebComponentState = interface
  ['{F2726C94-D255-4F3B-A3BE-81E28E8875D9}']
    function GetState: TcxWebComponentStates;
    procedure SetState(Value: TcxWebComponentStates);

    property State: TcxWebComponentStates read GetState write SetState;
  end;

  IcxCodeProvider = interface
  ['{9994948E-6728-443A-80D0-768A0EEB2434}']
    function GetRendererClass(Browser: TcxWebBrowserClass): TcxWebRendererClass;
    procedure GetScriptFiles(HTMLTextBuilder: TcxHTMLTextBuilder; AList: TStrings);
    procedure WriteClassScripts(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteClassHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteClassOutOfFormHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteOutOfFormHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteScripts(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteXML(HTMLTextBuilder: TcxHTMLTextBuilder);
  end;

  IcxContainerCodeProvider = interface
  ['{DDCA6301-AF1F-4E69-8769-349E5A277C18}']
    procedure WriteBeginHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    procedure WriteEndHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
  end;

  IcxDesignCodeProvider = interface
  ['{B46E57AA-5460-4BDE-A97E-9C75BEE3114E}']
    function GetRendererClass: TcxWebRendererClass;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
  end;

  IcxWebProvidersSupport = interface
  ['{070CCC90-3A13-4538-8D6A-41B7C64FA88F}']
    procedure GetProviders(AList: TList);
  end;

  TcxActionParameters = record
    ParamString: string;
    ShiftState: Integer;
  end;

  TcxWebComponentActionProc = procedure(const AParameters: TcxActionParameters) of object;
  TcxWebComponentEventProc = procedure(var AScript: string) of object;
  TcxWebComponentEventProcType = (etSingleLine, etProcedure);
  TcxWebRenderProc = function: string of object;


  IcxWebActions = interface
  ['{2C4A7F69-B222-434C-BD4F-D1847096DDDE}']
    procedure ClearActions;
    procedure RegisterActions;
    procedure DoAfterPerformActions;
    procedure DoPerformAction(const ActionName: string; const ActionParameters: TcxActionParameters);
  end;

  IcxWebEvents = interface
  ['{47806D90-E079-471A-870D-680CA44B1183}']
    procedure ClearEvents;
    procedure RegisterEvents;
  end;

  IcxWebScripts = interface
  ['{4C7839A9-212A-4C5A-8F10-6250CDDCADC9}']
    procedure ScriptsSubscription;
  end;

  IcxWebValues = interface
  ['{E570A4C5-D96B-41BC-A96B-F3224B174D95}']
    function GetValues: TStrings;
    procedure DoAfterSetValues;
    procedure DoSetValues;
    function CanSetValues: Boolean;
    procedure RegisterValues;

    property Values: TStrings read GetValues;
  end;

  TcxWebTabOrder = -1..32766;

//  TcxWebAnchor = (akLeft, akRight);
//  TcxWebAnchors = set of TcxWebAnchor;

  TcxWebCaption = type string;

  IcxWebContainerControl = interface;

  IcxWebTabOrderable = interface
    ['{1F5208E6-C0AB-4828-8CF2-33E87D174817}']
  end;

  IcxWebDesignerControlNotify = interface
  ['{80B18E02-6869-4E38-AB74-61AD348D2DF9}']
    procedure BoundsChanged;
    procedure ParentChanged;
    procedure UpdateContext;
  end;

  IcxWebControl = interface
    ['{88CEB4AC-24C8-42A5-881C-519325CBC9F9}']
    procedure InternalSetParent(const Value: IcxWebContainerControl);
    function GetBoundsRect: TRect;
    function GetParent: IcxWebContainerControl;
    function GetVisible: Boolean;
    function GetTabOrder: TcxWebTabOrder;
    function GetInternalTabOrder: TcxWebTabOrder;
    function GetTabStop: Boolean;
    function GetZIndex: Integer;
    function GetDesignerControl: IcxWebDesignerControlNotify;
    procedure SetBoundsRect(const Value: TRect);
    procedure SetParent(const Value: IcxWebContainerControl);
    procedure SetVisible(const Value: Boolean);
    procedure SetDesignerControl(const Value: IcxWebDesignerControlNotify);

    procedure UpdateControlPosition;

    property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;
    property Parent: IcxWebContainerControl read GetParent write SetParent;
    property TabOrder: TcxWebTabOrder read GetTabOrder;
    property TabStop: Boolean read GetTabStop;
    property Visible: Boolean read GetVisible write SetVisible;
    property ZIndex: Integer read GetZIndex;
    property DesignerControl: IcxWebDesignerControlNotify read GetDesignerControl write SetDesignerControl;
  end;

  IcxWebControlAttributes = interface
  ['{3013AB3E-419B-4A31-8B41-623607B8398C}']
    procedure SetAttribute(Name, Value: string);
    procedure SetStyleAttribute(Name, Value: string);
  end;

  TcxWebControlLayout = (wclGrid, wclAbsolute, wclFlow, wclInheritable);

  IcxWebContainerControl = interface
    ['{B4037AB3-C7E2-4045-BC5E-0D96982B1311}']
    function GetControl(Index: Integer): IcxWebControl;
    function GetControlContainer(Index: Integer): IcxWebContainerControl;
    function GetControlContainerCount: Integer;
    function GetControlCount: Integer;
    function GetParent: IcxWebContainerControl;

    function GetClientLeft: Integer;
    function GetClientTop: Integer;

    function CanAcceptsControls: Boolean;
    function ContainsControl(const AControl: IcxWebControl): Boolean;
    function IndexOf(const AControl: IcxWebControl): Integer;
    procedure InsertControl(const AControl: IInterface);
    procedure RemoveControl(const AControl: IInterface);

    function GetLineTabOrder(const AControl: IcxWebControl; var AFounded: Boolean): Integer;    
    procedure GetTabOrderList(const AList: TList);
    procedure SetTabOrderList(const AList: TList);
    function TabOrderOf(const AControl: IcxWebControl): Integer;
    procedure UpdateTabOrder(ACurIndex, ANewIndex: TcxWebTabOrder);
    procedure UpdateControlsPosition;

    function GetControlLayout: TcxWebControlLayout;
    procedure SetControlLayout(Value: TcxWebControlLayout);

    property ControlContainerCount: Integer read GetControlContainerCount;
    property ControlContainers[Index: Integer]: IcxWebContainerControl read GetControlContainer;
    property ControlCount: Integer read GetControlCount;
    property ControlLayout: TcxWebControlLayout read GetControlLayout write SetControlLayout;
    property Controls[Index: Integer]: IcxWebControl read GetControl;
    property Parent: IcxWebContainerControl read GetParent;
  end;

  IcxWebSessionsService = interface
  ['{9971D2FC-5D6A-4176-86FB-4750A2765E4C}']
    function CheckStatus: Boolean;
    function GetUseCookie: Boolean;
    function GetDefaultTimeout: Integer;
    procedure NotifyStatusChange;
    property UseCookie: Boolean read GetUseCookie;
    property DefaultTimeout: Integer read GetDefaultTimeout;
  end;

  IcxWebTranslatePathInfo = interface
  ['{6E39CB2C-D67E-47D4-8829-BBC45982CB91}']
    function EmbedURLModificator(ARequest: TWebRequest; ASession: TAbstractWebSession): string;
    function ExtractURLModificator(ARequest: TWebRequest): string;
    function ExcludeURLModificator(ARequest: TWebRequest): string;
  end;
  IcxWebSessionsNotify = interface
  ['{6DC9496C-F35F-4065-B88C-564CF688C5D7}']
    procedure SessionStarted(ASessionID: string);
    procedure SessionTerminated(ASessionID: string);
  end;

  IcxWebModule = interface
  ['{3B2D660C-C89C-4A0F-B2E6-5B82B1C34693}']
    procedure Activate;
    procedure Deactivate;
  end;

  TcxScriptEngine = 0..255;

  IcxWebPage = interface
  ['{0B5A6B16-AC16-4AE6-BE0C-E86F428E6212}']
    function DispatchPage(const APageName: string; AWebResponse: TWebResponse): Boolean;
    function IncludePage(const APageName: string; var AOwned: Boolean): TStream;
    function RedirectToPage(const APageName: string; const AParams: string; AWebResponse: TWebResponse): Boolean;
    function GetServerScript: TcxScriptengine;
  end;

  IcxWebClientData = interface
  ['{8B16527D-C3F1-484B-A1AB-CD610CD11E4D}']
    function GetActiveControl: IcxWebControl;
    function GetBrowser: TcxWebBrowserClass;
    function GetIsFirstRequest: Boolean;
    function GetLeftPos: Integer;
    function GetReferer: string;
    function GetShiftState: Integer;
    function GetScrollLeft: Integer;
    function GetScrollTop: Integer;
    function GetTopPos: Integer;
    function GetValues: TStrings;
    procedure SetActiveControl(const AValue: IcxWebControl);
    procedure SetLeftPos(const Value: Integer);
    procedure SetShiftState(const Value: Integer);
    procedure SetTopPos(const Value: Integer);
  end;

  IcxWebScripter = interface
  ['{FC7A3464-C383-497C-B0E8-8D1755CAD068}']
    procedure AddGlobalObjects(AProducer: TAbstractScriptProducer);
    procedure AddComponents(AProducer: TAbstractScriptProducer);
    procedure ClearAll;
    procedure Run(const AText, AScriptEngine: string);
  end;

  IcxWebPageModule = interface
  ['{22A1C3A3-7C9A-4753-AD40-33286E917C9B}']
    function GetAsString: string;
    function GetEncoding: string;
    function GetPositioningType: TcxWebPositioningType;
    procedure SetAsString(const Value: string);
    procedure SetPositioningType(const Value: TcxWebPositioningType);
    function PerformScript(const Value: string): string;
    procedure ProcessClientChanges;
  end;

  IcxWebDesignerModule = interface
  ['{D435B556-5D15-4058-B3A1-B22389FAFFDF}']
    function GetDesignerID: Integer;
    procedure SetDesignerID(Value: Integer);
    procedure SetIsDesignerPreviewModule(Value: Boolean);
  end;


  IcxWebModuleComponentPersistent = interface
  ['{E4F37693-19DD-4072-8C28-52BD23A4ABDF}']
    function IsComponentPersistent(AComponent: TComponent): Boolean;
  end;

  IcxWebDebugDesignerFileManager = interface
  ['{BCD7E8D7-FB98-4B26-95D5-0DD833B13FB2}']
  end;


  IcxWebModuleDesignerNotify = interface
  ['{A3C83E0C-717B-318F-7F56-3B0753793C78}']
    procedure DesignerIDChanged;
    procedure DesignerPositioningTypeChanged;
    function GetDesignerCount: Integer;
    function GetDesignerName(Index: Integer): String;
    function IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean;
    function GetControlPositioningType: TcxWebPositioningType;
  end;

implementation

end.
