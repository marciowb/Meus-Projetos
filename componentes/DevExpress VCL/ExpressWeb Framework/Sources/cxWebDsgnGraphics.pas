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
unit cxWebDsgnGraphics;

{$I cxVer.inc}

interface

uses
  {$IFDEF VCL}
  Windows, Graphics, Forms,
  {$ELSE}
  Qt, QGraphics, QForms,
  {$ENDIF}
  cxWebTypes, cxWebGraphics;

function ColorToWebColor(const Value: TColor): TcxWebColor;
function WebColorToColor(const Value: TcxWebColor): TColor;

procedure WebFontToFont(const AWebFont: TcxWebFont; const AFont: TFont);

implementation

uses
  SysUtils,
  cxWebUtils, cxWebDsgnUtils, cxWebMetrics;

{ TcxWebColor }

function ColorToWebColor(const Value: TColor): TcxWebColor;
begin
  Result := TcxWebColor(ColorToRGB(Value));
end;

function WebColorToColor(const Value: TcxWebColor): TColor;
begin
  Result := TColor(Value);
end;

{ TcxWebFont }

type
  TcxWebMetricsUtilsAcess = class(TcxWebMetricsUtils);

procedure WebFontToFont(const AWebFont: TcxWebFont; const AFont: TFont);
var
  TmpFont: TFont;
{$IFDEF VCL}
  FontHandle: HFONT;
{$ELSE}
  FontHandle: QFontH;
{$ENDIF}
begin
  if Assigned(cxWebMetricsUtils) and (cxWebMetricsUtils is TcxWebMetricsUtils) then
  begin
    FontHandle := TcxWebMetricsUtilsAcess(cxWebMetricsUtils).WebFontToFont(AWebFont);
    TmpFont := TFont.Create{$IFNDEF VCL}(FontHandle){$ENDIF};
    try
      {$IFDEF VCL}
      TmpFont.Handle := FontHandle;
      {$ELSE}
      TmpFont.OwnHandle;
      {$ENDIF}
      AFont.Assign(TmpFont);
    finally
      TmpFont.Free;
    end;
  end;  
  AFont.Color := WebColorToColor(AWebFont.Color);
end;

end.
