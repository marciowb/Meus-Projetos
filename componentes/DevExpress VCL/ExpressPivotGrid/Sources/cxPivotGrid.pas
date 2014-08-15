{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxPivotGrid;

{$I cxVer.inc}

interface

uses
  Classes, cxClasses, cxControls, cxCustomData, cxCustomPivotGrid;

type
  { TcxPivotGrid }

  TcxPivotGrid = class(TcxCustomPivotGrid)
  public
    property DataController;
  published
    property Align;
    property Anchors;
  {$IFDEF DELPHI6}
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
  {$ENDIF}
    property BorderStyle;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FieldHeaderImages;
    property Font;
    property GroupHeaderImages;
    property Groups;
    property LookAndFeel;
    property OptionsBehavior;
    property OptionsCustomize;
    property OptionsData;
    property OptionsDataField;
    property OptionsSelection;
    property OptionsView;
    property ParentFont;
    property PopupMenu;
    property PopupMenus;
    property ShowHint;
    property Styles;
    property TabOrder;
    property TabStop;
    property Visible;
    //events
    // pivotgrid
    property OnCompare;
    property OnCustomDrawFieldHeader;
    property OnCustomDrawColumnHeader;
    property OnCustomDrawRowHeader;
    property OnCustomDrawCell;
    property OnCustomDrawPart;
    property OnCustomization;
    property OnFieldPosChanged;
    property OnLayoutChanged; 
    property OnSelectionChanged;
    // standard
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

end.
