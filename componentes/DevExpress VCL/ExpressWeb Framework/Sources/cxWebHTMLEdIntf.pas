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
unit cxWebHTMLEdIntf;

interface

uses Classes, Windows, ActiveX, MSHTML_TLB;

type
  TcxHTMLContainerLayout = (hclGrid, hclFlow);

  TcxHTMLRegionSelectEvent = procedure(const AEventObject: IHTMLEventObj;
    const ARect: TRect) of object;

  IcxHTMLBehaviorViewLink = interface
  ['{5BA42CAA-2A0B-4A12-9F48-29DECC215202}']
    function GetViewLinkDoc: IHTMLDocument2;
    procedure UpdateContent;
    property ViewLinkDoc: IHTMLDocument2 read GetViewLinkDoc;
  end;

  IcxHTMLSelectionBehavior = interface
  ['{4B55854C-7987-4B7E-9C25-9650034DEBB1}']
    procedure SetOnRegionSelected(AHandler: TcxHTMLRegionSelectEvent);
    property OnRegionSelected: TcxHTMLRegionSelectEvent write SetOnRegionSelected;
  end;

  IcxHTMLEditorInfo = interface
  ['{BE20DAAD-A33E-4D30-8479-A579960F3E5F}']
    function ShowBorders: Boolean;
    function ShowDetails: Boolean;
    function ShowGrid: Boolean;
    function SnapToGrid: Boolean;
    function GridXSize: Integer;
    function GridYSize: Integer;
    function IsToolSelected: Boolean;
    procedure CompleteUndoBlock;
  end;

  IcxHTMLElementInfo = interface
  ['{4EF72043-08F7-480E-8551-6112C5A284ED}']
    procedure GetViewLinkContent(const AElement: IHTMLElement; var AContent, ACSSContent, AInlineStyle: string);
    function IsElementContainer(const AElement: IHTMLElement): Boolean;
    function CanHaveBehavior(const AElement: IHTMLElement): Boolean;
    function ContainerLayout(const AElement: IHTMLElement): TcxHTMLContainerLayout;
    function CanElementSelect(const AElement: IHTMLElement): Boolean;
  end;

  IcxHTMLBehavior = interface;

  IcxHTMLNamespace = interface
    ['{22637A0B-EB07-422F-9647-828EB30F671E}']
    procedure AddTags(ATags: array of string);
    function GetBehaviors: IInterfaceList;
    function GetEditorInfo: IcxHTMLEditorInfo;
    function GetElementBehavior(AElement: IHTMLElement): IcxHTMLBehavior;
    function GetElementInfo: IcxHTMLElementInfo;
    function GetName: string;
    property Name: string read GetName;
    property Behaviors: IInterfaceList read GetBehaviors;
  end;

  IcxHTMLBehavior = interface
  ['{113DA5BA-DB32-46C1-8C38-17EBC68DC880}']
    function GetPaintSite: IHTMLPaintSite;
    function GetElement: IHTMLElement;
    function GetNamespace: IcxHTMLNamespace;
    property PaintSite: IHTMLPaintSite read GetPaintSite;
    property Element: IHTMLElement read GetElement;
    property Namespace: IcxHTMLNamespace read GetNamespace;
  end;

  IcxEventSink = interface
  ['{DA6C14F6-C766-43DE-BA3D-B49AA4F54943}']
    procedure Connect(const ASource: IUnknown);
    procedure Disconnect;
    function GetSource: IUnknown;
    property Source: IUnknown read GetSource;
  end;

const
  IID_IcxOleUndoManager: TGUID = '{D001F200-EF97-11CE-9BC9-00AA00608E01}';
  IID_IcxOleUndoUnit: TGUID = '{B3E7C340-EF97-11CE-9BC9-00AA00608E01}';
  IID_IcxOleParentUndoUnit: TGUID = '{A1FAF330-EF97-11CE-9BC9-00AA00608E01}';
  IID_IcxEnumOleUndoUnits: TGUID = '{894AD3B0-EF97-11CE-9BC9-00AA00608E01}';

// Constants for enum tagUASFLAGS
type
  tagUASFLAGS = TOleEnum;
const
  UAS_NORMAL = $00000000;
  UAS_BLOCKED = $00000001;
  UAS_NOPARENTENABLE = $00000002;
  UAS_MASK = $00000003;

type

  IcxOleUndoManager = interface;
  IcxOleUndoUnit  = interface;
  IcxOleParentUndoUnit  = interface;
  IcxEnumOleUndoUnits  = interface;

  IcxOleUndoManager = interface(IUnknown)
  ['{D001F200-EF97-11CE-9BC9-00AA00608E01}']
    function Open(const pPUU: IcxOleParentUndoUnit): HResult; stdcall;
    function Close(const pPUU: IcxOleParentUndoUnit; fCommit: WordBool): HResult; stdcall;
    function Add(const pUU: IcxOleUndoUnit): HResult; stdcall;
    function GetOpenParentState(out pdwState: LongWord): HResult; stdcall;
    function DiscardFrom(const pUU: IcxOleUndoUnit): HResult; stdcall;
    function UndoTo(const pUU: IcxOleUndoUnit): HResult; stdcall;
    function RedoTo(const pUU: IcxOleUndoUnit): HResult; stdcall;
    function EnumUndoable(out ppEnum: IcxEnumOleUndoUnits): HResult; stdcall;
    function EnumRedoable(out ppEnum: IcxEnumOleUndoUnits): HResult; stdcall;
    function GetLastUndoDescription(out pbstr: WideString): HResult; stdcall;
    function GetLastRedoDescription(out pbstr: WideString): HResult; stdcall;
    function Enable(fEnable: WordBool): HResult; stdcall;
  end;

  IcxEnumOleUndoUnits = interface(IUnknown)
  ['{B3E7C340-EF97-11CE-9BC9-00AA00608E01}']
    function Next(cElt: Longint; out rgElt: IcxOleUndoUnit;
      pcEltFetched: PLongint): HResult; stdcall;
    function Skip(cElt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppEnum: IcxEnumOleUndoUnits): HResult; stdcall;
  end;

  IcxOleUndoUnit = interface(IUnknown)
  ['{894AD3B0-EF97-11CE-9BC9-00AA00608E01}']
    function Do_(const pUndoManager: IcxOleUndoManager): HResult; stdcall;
    function GetDescription(out pbstr: WideString): HResult; stdcall;
    function GetUnitType(out pClsid: TGUID; out plID: Longint): HResult; stdcall;
    function OnNextAdd: HResult; stdcall;
  end;

  IcxOleParentUndoUnit = interface(IcxOleUndoUnit)
  ['{A1FAF330-EF97-11CE-9BC9-00AA00608E01}']
    function Open(const pPUU: IcxOleParentUndoUnit): HResult; stdcall;
    function Close(const pPUU: IcxOleUndoUnit; fCommit: WordBool): HResult; stdcall;
    function Add(const pUU: IcxOleParentUndoUnit): HResult; stdcall;
    function FindUnit(const pUU: IcxOleUndoUnit): HResult; stdcall;
    function GetParentState(out pdwState: LongWord): HResult; stdcall;
  end;

  IcxOleCommandTarget = interface(IUnknown)
    ['{b722bccb-4e68-101b-a2bc-00aa00404770}']
    function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
      prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
    function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
      vaIn, vaOut: PVariantArg): HResult; stdcall;
  end;

  IcxHTMLEditorBar = interface(IUnknown)
  ['{8CDF38A3-AB00-4FFD-A51F-BB806B4AC056}']
    procedure SetCommandTarget(const ACommandTarget: IcxOleCommandTarget);
    procedure DisableUI(const ADisabled: Boolean);
    procedure UpdateActionControls;
  end;

implementation

end.
