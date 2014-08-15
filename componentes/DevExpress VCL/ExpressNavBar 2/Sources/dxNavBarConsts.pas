{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarConsts;

{$I cxVer.inc}

interface

uses
  Classes, cxLibraryConsts;

const
  dxNavBarDefaultLargeImageHeight = 32;
  dxNavBarDefaultLargeImageWidth = 32;
  dxNavBarDefaultSmallImageHeight = 16;
  dxNavBarDefaultSmallImageWidth = 16;

  dxNavBarActivateGroupInterval = 300;
  dxNavBarScrollInterval = 300;

  dxNavBarCursors: array[0..2] of TIdentMapEntry = (
    (Value: dxNavBarDragCursor; Name: 'dxcrDrag'),
    (Value: dxNavBarDragCopyCursor; Name: 'dxcrDragCopy'),
    (Value: dxNavBarLinksCursor; Name: 'dxcrLinks'));

//Views
  dxNavBarBaseView = 0;
  dxNavBarFlatView = 1;
  dxNavBarOffice1View = 2;
  dxNavBarOffice2View = 3;
  dxNavBarOffice3View = 4;
  dxNavBarVSToolBoxView = 5;
  dxNavBarXP1View = 6;
  dxNavBarXP2View = 7;
  dxNavBarExplorerBarView = 8;
  dxNavBarUltraFlatExplorerView = 9;
  dxNavBarAdvExplorerBarView = 10;
  dxNavBarXPExplorerBarView = 11;
  dxNavBarOffice11TaskPaneView = 12;
  dxNavBarOffice11NavigatorPaneView = 13;
  dxNavBarOffice11ExplorerBarView = 16;
  dxNavBarOffice12NavigatorPaneView = 17;
  dxNavBarOffice12ExplorerBarView = 18;
  dxNavBarVistaExplorerBarView = 19;
  dxNavBarSkinExplorerBarView = 14;
  dxNavBarSkinNavigatorPaneView = 15;

  dxNavBarDefaultView = {$IFDEF USENATIVELOOKANDFEELASDEFAULT}dxNavBarOffice12NavigatorPaneView{$ELSE}dxNavBarBaseView{$ENDIF};

resourcestring
  sdxNavigationPaneOverflowPanelCustomizeHint = 'Configure buttons';
  sdxNavigationPaneMinimizeNavPaneSignHint = 'Minimize Navigation Pane';
  sdxNavigationPaneExpandNavPaneSignHint = 'Expand Navigation Pane';
  sdxNavigationPaneCollapseBarHint = 'Click to expand Navigation Pane';
  sdxNavigationPaneCollapseBar = 'Navigation Pane';

//Exception messages

  sdxInvalideGroupControl = 'Invalid the TdxNavBarGroupControl parent or group.';
  sdxInvalidLink = 'You cannot create a link to the ''%s'' item within the ''%s'' group because they belong to different NavBar controls';
  sdxCannotFindView = 'Cannot find view with ID = %d.';
  sdxViewAlreadyExists = 'ID of view = %d is already exists.';

//Office11Views popup menu captions

  sdxNavBarOffice11ShowMoreButtons = 'Show &More Buttons';
  sdxNavBarOffice11ShowFewerButtons = 'Show &Fewer Buttons';
  sdxNavBarOffice11AddRemoveButtons = '&Add or Remove Buttons';

implementation

uses
  dxCore;

procedure AddNavBarResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAdress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAdress);
  end;

begin
  InternalAdd('sdxNavigationPaneOverflowPanelCustomizeHint', @sdxNavigationPaneOverflowPanelCustomizeHint);
  InternalAdd('sdxNavigationPaneMinimizeNavPaneSignHint', @sdxNavigationPaneMinimizeNavPaneSignHint);
  InternalAdd('sdxNavigationPaneExpandNavPaneSignHint', @sdxNavigationPaneExpandNavPaneSignHint);
  InternalAdd('sdxNavigationPaneCollapseBarHint', @sdxNavigationPaneCollapseBarHint);
  InternalAdd('sdxNavigationPaneCollapseBar', @sdxNavigationPaneCollapseBar);
  InternalAdd('sdxInvalideGroupControl', @sdxInvalideGroupControl);
  InternalAdd('sdxInvalidLink', @sdxInvalidLink);
  InternalAdd('sdxCannotFindView', @sdxCannotFindView);
  InternalAdd('sdxViewAlreadyExists', @sdxViewAlreadyExists);
  InternalAdd('sdxNavBarOffice11ShowMoreButtons', @sdxNavBarOffice11ShowMoreButtons);
  InternalAdd('sdxNavBarOffice11ShowFewerButtons', @sdxNavBarOffice11ShowFewerButtons);
  InternalAdd('sdxNavBarOffice11AddRemoveButtons', @sdxNavBarOffice11AddRemoveButtons);
end;

initialization
  dxResourceStringsRepository.RegisterProduct('ExpressNavBar', @AddNavBarResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExpressNavBar');

end.
