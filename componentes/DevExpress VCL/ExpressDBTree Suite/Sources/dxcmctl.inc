
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express custom draw servce declaration                      }
{                                                                   }
{       Copyright (c) 1998, 99 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
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

{Types and constants for custom draw service}

const
 {Custom draw constants}
 NM_CUSTOMDRAW   = NM_FIRST-12;
 CDDS_PREPAINT   = $00000001;
 CDDS_POSTPAINT  = $00000002;
 CDDS_PREERASE   = $00000003;
 CDDS_POSTERASE  = $00000004;
 CDDS_ITEM       = $00010000;

 CDDS_ITEMPREPAINT  = CDDS_ITEM Or CDDS_PREPAINT;
 CDDS_ITEMPOSTPAINT = CDDS_ITEM Or CDDS_POSTPAINT;
 CDDS_ITEMPREERASE  = CDDS_ITEM Or CDDS_PREERASE;
 CDDS_ITEMPOSTERASE = CDDS_ITEM Or CDDS_POSTERASE;

 CDRF_DODEFAULT       = $00000000;
 CDRF_NEWFONT         = $00000002;
 CDRF_SKIPDEFAULT     = $00000004;
 CDRF_NOTIFYPOSTPAINT = $00000010;
 CDRF_NOTIFYITEMDRAW  = $00000020;
 CDRF_NOTIFYPOSTERASE = $00000040;
 CDRF_NOTIFYITEMERASE = $00000080;


type
 {Custom draw types}
  TNMCustomDraw = record
    hdr : TNMHDR;
    dwDrawStage : DWORD; // State of the Drawing
    hdc : HDC;
    rc : TRECT;
    dwItemSpec : DWORD;
    uItemState : UINT;
    LItemlParam : LPARAM;
  end;

  PNMCustomDraw = ^TNMCustomDraw;

  TNMLVCustomDraw = record
    nmcd : TNMCustomDraw;
    clrText : COLORREF;
    clrTextBk : COLORREF;
  end;

  PNMLVCustomDraw = ^TNMLVCustomDraw;

