
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxTLIntf;

{$I cxVer.inc}

interface

uses
  Classes;

type

  { IcxTreeListDesignTimeOperations }

  IcxTreeListDesignTimeOperations = interface
    ['{9EC47E18-A921-4E5C-94F0-9995E8C5D8CB}']
    function SupportsBandColumnEditor: Boolean;
    function SupportsItemsEditor: Boolean;
    function SupportsCreateAllItems: Boolean;
    //
    function GetVersion: string;
    procedure CreateAllItems;
    procedure DeleteAllColumns;
  end;

  { IcxTreeListOperations }

  IcxTreeListOperations = interface
  ['{DFEC8B61-5B7A-4A91-8C27-E6AA6DC47301}']
    function SupportCustomizingBox: Boolean;
    procedure HideCustomizingBox;
    procedure ShowCustomizingBox;
  end;

  { IcxTreeListDesigner }

  IcxTreeListDesigner = interface
  ['{E051005C-9F9C-42B5-AD08-B406655872CC}']
    procedure ComponentRemoved(Sender: TObject);
    procedure Modified;
  end;

  { IcxTreeListIndexedItem }

  IcxTreeListIndexedItem = interface
  ['{2FE52E12-14A4-443F-8B26-3ADB55C078AB}']
    function GetItemIndex: Integer;
    function GetVisibleIndex: Integer;
    procedure SetItemIndex(Value: Integer);
    procedure SetVisibleIndex(Value: Integer);
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property VisibleIndex: Integer read GetVisibleIndex write SetVisibleIndex;
  end;

//  { IcxTreeListDataController }
//
//  IcxTreeListDataController = interface
//  ['{22BAF765-FEE2-4A50-85BA-DF74A4F52E58}']
//    function GetKeyValue(ARecordIndex: Integer): Variant;
//    function GetParentKeyValue(ARecordIndex: Integer): Variant;
//  end;

//    function GetKeyValue(ARecordIndex: Integer): Variant;
//    function GetParentKeyValue(ARecordIndex: Integer): Variant;

  { IcxTreeListSubClass }

  IcxTreeListSubClass = interface
  ['{FC2BC45F-C395-4029-AB35-907F495CDC5B}']
    function GetControl: TObject;
  end;

implementation

end.
