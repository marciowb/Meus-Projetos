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
unit cxWebDsgnIntf;

{$I cxVer.inc}

interface

uses Classes, DesignIntf,
  {$IFDEF VCL}
  Windows, Menus, Controls, Forms,
  {$ELSE}
  Qt, Types, QMenus, QControls, QForms,
  {$ENDIF}
  cxWebClasses, cxWebControls, cxWebIntf, cxWebDsgnTypes, cxWebRender;

type
  TUpdateConstrolPositionEvent = procedure (var AUpdate: Boolean) of object;

  IcxWebDesignerControlUpdatePosition = interface
  ['{A0C20358-FBEE-49B5-AF01-D829E00698A4}']
    procedure SetOnUpdateConstrolPosition(Value: TUpdateConstrolPositionEvent);
  end;

  IcxWebDesignerControl = interface(IcxWebDesignerControlNotify)
  ['{78B1F14A-F44A-4DE3-B0D5-E9A16F9B54AC}']
    function GetDesignerSurface: TWinControl;
    function GetImplementor: TWinControl;
    function GetSelected: Boolean;
    function GetWebControl: IcxWebControl;
    procedure SetDesignerSurface(Value: TWinControl);
    procedure SetSelected(Value: Boolean);
    procedure SetWebControl(Value: IcxWebControl);

    property DesignerSurface: TWinControl read GetDesignerSurface write SetDesignerSurface;
    property Implementor: TWinControl read GetImplementor;
    property Selected: Boolean read GetSelected write SetSelected;
    property WebControl: IcxWebControl read GetWebControl write SetWebControl;
  end;

  IcxWebDesignerControlRepaint = interface
    ['{1FF15C5E-EB28-405F-8FB7-90FB6BF45267}']
    procedure RepaintControl;
  end;

  IcxDesignNotification = interface
    ['{542CEB8B-3718-49E6-B09E-CDB9EA2963AE}']
    procedure ItemDeleted(const AnItem: TPersistent);
    procedure ItemInserted(const AnItem: TPersistent);
    procedure ItemsModified;//(const ADesigner: IcxWebDesigner);
    procedure SelectionChanged(const AList: TList);
  end;

  type
    TcxWebDesignerShowingType = (stDesigner, stPreview);

  IcxDesignerWindow = interface
  ['{BA629928-B7EA-425B-B608-6DBC61C4EB4F}']
    function GetShowingType: TcxWebDesignerShowingType;
    procedure ShowDesigner;
  end;


  TcxAbstractWebDesigner = class(TInterfacedObject)
  protected
    function GetForm: TCustomForm; virtual; abstract;
    function GetRoot: TComponent; virtual; abstract;

    procedure AddNotifier(const ADesignNotification: IcxDesignNotification); virtual; abstract;
    procedure RemoveNotifier(const ADesignNotification: IcxDesignNotification); virtual; abstract;

    function BuildLocalMenu(const ABaseMenu: TPopupMenu; const AFilter: TcxLocalMenuFilters): TPopupMenu; virtual; abstract;
    procedure InvokeLocalMenuAt(const ABaseMenu: TPopupMenu; const AFilter: TcxLocalMenuFilters; const Pt: TPoint); virtual; abstract;
    procedure InvokeLocalMenuAtCursor(const ABaseMenu: TPopupMenu; const AFilter: TcxLocalMenuFilters); virtual; abstract;

    function GetDesignerControl: TWinControl; virtual; abstract;

    function CanAlign: Boolean; virtual; abstract;
    function CanAlignToGrid: Boolean; virtual; abstract;
    function CanSelect(const AControl: TComponent): Boolean; virtual; abstract;
    procedure Edit(AComponent: TComponent); virtual; abstract;
    procedure GetSelections(const AList: TList); virtual; abstract;
    procedure SelectComponent(const AnItem: TPersistent); virtual; abstract;
    procedure SetSelections(const AList: TList); virtual; abstract;
  public
    constructor Create(AForm: TCustomForm; ADelphiDesigner: IDesigner); virtual; abstract;
    class function GetID: Integer; virtual; abstract;
    class function GetName: String; virtual; abstract;

    procedure CreateDesignerControl(AParentControl: TWinControl); virtual; abstract;
    procedure DestroyDesignerControl; virtual; abstract;
    procedure UpdateDesignerControl; virtual; abstract;
    procedure DesignerActivated; virtual; abstract;
    procedure DesignerDeactivated; virtual; abstract;
    procedure PreviewShowing; virtual; abstract;
    procedure DesignerIdChanging; virtual; abstract;
    procedure DesignerPositioningTypeChanged; virtual; abstract;
    function IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean; virtual; abstract;
    function GetControlPositioningType: TcxWebPositioningType; virtual; abstract;


    procedure ComponentCreated(AComponent: TComponent); virtual; abstract;
    procedure ComponentDestroyed(AComponent: TComponent); virtual; abstract;
    procedure ComponentChangedName(AComponent: TComponent; const AOldName, ANewName: string); virtual; abstract;
    
    function CanCopy: Boolean; virtual; abstract;
    function CanCut: Boolean; virtual; abstract;
    function CanDelete: Boolean; virtual; abstract;
    function CanPaste: Boolean; virtual; abstract;
    function CanTabOrder: Boolean; virtual; abstract;
    function CanUndo: Boolean; virtual; abstract;
    function CanSelectAll: Boolean; virtual; abstract;

    procedure AlignToGrid; virtual; abstract;
    procedure CopySelection; virtual; abstract;
    procedure CutSelection; virtual; abstract;
    procedure DeleteSelection; virtual; abstract;
    procedure PasteSelection; virtual; abstract;
    procedure SelectAll; virtual; abstract;
    procedure Undo; virtual; abstract;

    procedure Modified; virtual; abstract;
    procedure RefreshDesignControls; virtual; abstract;
    procedure SelectionChanged(const AList: TList); virtual; abstract;

    property DesignerControl: TWinControl read GetDesignerControl;
    property Form: TCustomForm read GetForm;
    property Root: TComponent read GetRoot;
  end;

  TcxAbstractWebDesignerClass = class of TcxAbstractWebDesigner;

implementation

end.

