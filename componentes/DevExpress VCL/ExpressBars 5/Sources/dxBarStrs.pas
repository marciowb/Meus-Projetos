
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars string table constants                          }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxBarStrs;

interface

resourcestring
  dxSBAR_LOOKUPDIALOGCAPTION = 'Select value';
  dxSBAR_LOOKUPDIALOGOK = 'OK';
  dxSBAR_LOOKUPDIALOGCANCEL = 'Cancel';

  dxSBAR_DIALOGOK = 'OK';
  dxSBAR_DIALOGCANCEL = 'Cancel';
  dxSBAR_COLOR_STR_0 = 'Black';
  dxSBAR_COLOR_STR_1 = 'Maroon';
  dxSBAR_COLOR_STR_2 = 'Green';
  dxSBAR_COLOR_STR_3 = 'Olive';
  dxSBAR_COLOR_STR_4 = 'Navy';
  dxSBAR_COLOR_STR_5 = 'Purple';
  dxSBAR_COLOR_STR_6 = 'Teal';
  dxSBAR_COLOR_STR_7 = 'Gray';
  dxSBAR_COLOR_STR_8 = 'Silver';
  dxSBAR_COLOR_STR_9 = 'Red';
  dxSBAR_COLOR_STR_10 = 'Lime';
  dxSBAR_COLOR_STR_11 = 'Yellow';
  dxSBAR_COLOR_STR_12 = 'Blue';
  dxSBAR_COLOR_STR_13 = 'Fuchsia';
  dxSBAR_COLOR_STR_14 = 'Aqua';
  dxSBAR_COLOR_STR_15 = 'White';
  dxSBAR_COLORAUTOTEXT = '(automatic)';
  dxSBAR_COLORCUSTOMTEXT = '(custom)';
  dxSBAR_DATETODAY = 'Today';
  dxSBAR_DATECLEAR = 'Clear';
  dxSBAR_DATEDIALOGCAPTION = 'Select the date';
  dxSBAR_TREEVIEWDIALOGCAPTION = 'Select item';
  dxSBAR_IMAGEDIALOGCAPTION = 'Select item';
  dxSBAR_IMAGEINDEX = 'Image Index';
  dxSBAR_IMAGETEXT = 'Text';
  dxSBAR_PLACEFORCONTROL = 'The place for the ';
  dxSBAR_CANTASSIGNCONTROL = 'You cannot assign the same control to more than one TdxBarControlContainerItem.';

  dxSBAR_WANTTORESETTOOLBAR = 'Are you sure you want to reset the changes made to the ''%s'' toolbar?';
  dxSBAR_WANTTORESETUSAGEDATA = 'This will delete the record of the commands you''ve used in this application and restore the default set of visible commands to the menus and toolbars. It will not undo any explicit customizations.   Are you sure you want to proceed?';
  dxSBAR_BARMANAGERMORETHENONE  = 'A Form should contain only a single TdxBarManager';
  dxSBAR_BARMANAGERBADOWNER = 'TdxBarManager should have as its Owner - TForm (TCustomForm)';
  dxSBAR_NOBARMANAGERS = 'There are no TdxBarManagers available';
  dxSBAR_WANTTODELETETOOLBAR = 'Are you sure you want to delete the ''%s'' toolbar?';
  dxSBAR_WANTTODELETECATEGORY = 'Are you sure you want to delete the ''%s'' category?';
  dxSBAR_WANTTOCLEARCOMMANDS = 'Are you sure you want to delete all commands in the ''%s'' category?';
  dxSBAR_RECURSIVESUBITEMS = 'You cannot create recursive subitems';
  dxSBAR_COMMANDNAMECANNOTBEBLANK = 'A command name cannot be blank. Please enter a name.';
  dxSBAR_TOOLBAREXISTS = 'A toolbar named ''%s'' already exists. Type another name.';
  dxSBAR_RECURSIVEGROUPS = 'You cannot create recursive groups';

  dxSBAR_DEFAULTCATEGORYNAME = 'Default';

  dxSBAR_CP_ADDSUBITEM = 'Add &SubItem';
  dxSBAR_CP_ADDBUTTON = 'Add &Button';
  dxSBAR_CP_ADDITEM = 'Add &Item';
  dxSBAR_CP_DELETEBAR = 'Delete Bar';

  dxSBAR_CP_RESET = '&Reset';
  dxSBAR_CP_DELETE = '&Delete';
  dxSBAR_CP_NAME = '&Name:';
  dxSBAR_CP_CAPTION = '&Caption:'; // is the same as dxSBAR_CP_NAME (at design-time)
  dxSBAR_CP_DEFAULTSTYLE = 'Defa&ult style';
  dxSBAR_CP_TEXTONLYALWAYS = '&Text Only (Always)';
  dxSBAR_CP_TEXTONLYINMENUS = 'Text &Only (in Menus)';
  dxSBAR_CP_IMAGEANDTEXT = 'Image &and Text';
  dxSBAR_CP_BEGINAGROUP = 'Begin a &Group';
  dxSBAR_CP_VISIBLE = '&Visible';
  dxSBAR_CP_MOSTRECENTLYUSED = '&Most recently used';

  dxSBAR_ADDEX = 'Add...';
  dxSBAR_RENAMEEX = 'Rename...';
  dxSBAR_DELETE = 'Delete';
  dxSBAR_CLEAR = 'Clear';
  dxSBAR_VISIBLE = 'Visible';
  dxSBAR_OK = 'OK';
  dxSBAR_CANCEL = 'Cancel';
  dxSBAR_SUBMENUEDITOR = 'SubMenu Editor...';
  dxSBAR_SUBMENUEDITORCAPTION = 'ExpressBars SubMenu Editor';
  dxSBAR_INSERTEX = 'Insert...';

  dxSBAR_MOVEUP = 'Move Up';
  dxSBAR_MOVEDOWN = 'Move Down';
  dxSBAR_POPUPMENUEDITOR = 'PopupMenu Editor...';
  dxSBAR_TABSHEET1 = ' Toolbars ';
  dxSBAR_TABSHEET2 = ' Commands ';
  dxSBAR_TABSHEET3 = ' Options ';
  dxSBAR_TOOLBARS = 'Toolb&ars:';
  dxSBAR_TNEW = '&New...';
  dxSBAR_TRENAME = 'R&ename...';
  dxSBAR_TDELETE = '&Delete';
  dxSBAR_TRESET = '&Reset...';
  dxSBAR_CLOSE = 'Close';
  dxSBAR_CAPTION = 'Customize';
  dxSBAR_CATEGORIES = 'Cate&gories:';
  dxSBAR_COMMANDS = 'Comman&ds:';
  dxSBAR_DESCRIPTION = 'Description  ';

  dxSBAR_CUSTOMIZE = '&Customize...';
  dxSBAR_ADDREMOVEBUTTONS = '&Add or Remove Buttons';
  dxSBAR_MOREBUTTONS = 'More Buttons';
  dxSBAR_RESETTOOLBAR = '&Reset Toolbar';
  dxSBAR_EXPAND = 'Expand (Ctrl-Down)';
  dxSBAR_DRAGTOMAKEMENUFLOAT = 'Drag to make this menu float';

  dxSBAR_TOOLBARNEWNAME  = 'Custom ';
  dxSBAR_CATEGORYADD  = 'Add Category';
  dxSBAR_CATEGORYINSERT  = 'Insert Category';
  dxSBAR_CATEGORYRENAME  = 'Rename Category';
  dxSBAR_TOOLBARADD  = 'Add Toolbar';
  dxSBAR_TOOLBARRENAME  = 'Rename Toolbar';
  dxSBAR_CATEGORYNAME  = '&Category name:';
  dxSBAR_TOOLBARNAME  = '&Toolbar name:';
  dxSBAR_CUSTOMIZINGFORM = 'Customization Form...';

  dxSBAR_MODIFY = '... modify';
  dxSBAR_PERSMENUSANDTOOLBARS = 'Personalized Menus and Toolbars  ';
  dxSBAR_MENUSSHOWRECENTITEMS = 'Me&nus show recently used commands first';
  dxSBAR_SHOWFULLMENUSAFTERDELAY = 'Show f&ull menus after a short delay';
  dxSBAR_RESETUSAGEDATA = '&Reset my usage data';

  dxSBAR_OTHEROPTIONS = 'Other  ';
  dxSBAR_LARGEICONS = '&Large icons';
  dxSBAR_HINTOPT1 = 'Show Tool&Tips on toolbars';
  dxSBAR_HINTOPT2 = 'Show s&hortcut keys in ToolTips';
  dxSBAR_MENUANIMATIONS = '&Menu animations:';
  dxSBAR_MENUANIM1 = '(None)';
  dxSBAR_MENUANIM2 = 'Random';
  dxSBAR_MENUANIM3 = 'Unfold';
  dxSBAR_MENUANIM4 = 'Slide';
  dxSBAR_MENUANIM5 = 'Fade';

implementation

end.
