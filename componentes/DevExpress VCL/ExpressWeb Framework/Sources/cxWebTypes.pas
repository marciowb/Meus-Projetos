{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Basic Web types                                             }
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

unit cxWebTypes;

{$I cxVer.inc}

interface

type
  PcxWebColor = ^TcxWebColor;
  TcxWebColor = -$7FFFFFFF-1..$7FFFFFFF;
  
{$IFDEF DELPHI4}
  {$NODEFINE TcxWebColor}

  (*$HPPEMIT 'namespace cxWebTypes'*)
  (*$HPPEMIT '{'*)
  (*$HPPEMIT '  enum TcxWebColor {clMin=-0x7fffffff-1, clMax=0x7fffffff};'*)
  (*$HPPEMIT '}'*)
{$ENDIF}
    
  PcxWebColorTriple = ^TcxWebColorTriple;
  TcxWebColorTriple = packed record
    case Integer of
      0: (Red, Green, Blue: Byte);
      1: (Value: Longint);
  end;

implementation

end.
