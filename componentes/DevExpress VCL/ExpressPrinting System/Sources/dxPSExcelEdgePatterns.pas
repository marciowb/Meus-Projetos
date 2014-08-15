{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSExcelEdgePatterns;
         
interface

{$I cxVer.inc}

uses
  {$IFDEF DELPHI6} Types,{$ENDIF} Windows, dxPSCore, dxPSEdgePatterns;

type  
  TdxPSMediumSolidEdgePattern = class(TdxPSSolidEdgePattern)
  public
    class function Name: string; override;
    class function Thickness: Integer; override;
  end;

  TdxPSThickSolidEdgePattern = class(TdxPSSolidEdgePattern)
  public
    class function Name: string; override;
    class function Thickness: Integer; override;
  end;

  TdxPSDottedEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSDashedEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSDashDotDotEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSDashDotEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSSlantedDashDotEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSMediumDashDotDotEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSHairEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSMediumDashDotEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSMediumDashedEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;

  TdxPSDoubleLineSolidEdgePattern = class(TdxPSEdgePattern)
  public
    class function Bits(Index: Integer): DWORD; override;
    class function Name: string; override;
    class function SignificantBitCount: Integer; override;
    class function Thickness: Integer; override;
  end;
  
implementation

uses
  cxClasses, dxPSRes;
  
{ TdxPSMediumSolidEdgePattern }

class function TdxPSMediumSolidEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxMediumSolidEdgePattern);
end;

class function TdxPSMediumSolidEdgePattern.Thickness: Integer;
begin
  Result := 2;
end;

{ TdxPSThickSolidEdgePattern }

class function TdxPSThickSolidEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxThickSolidEdgePattern);
end;

class function TdxPSThickSolidEdgePattern.Thickness: Integer;
begin
  Result := 3;
end;

{ TdxPSDottedEdgePattern }

class function TdxPSDottedEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $EEEEEEEE;
end;

class function TdxPSDottedEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxSlantedDashDotEdgePattern);
end;

class function TdxPSDottedEdgePattern.SignificantBitCount: Integer;
begin
  Result := 8;
end;

class function TdxPSDottedEdgePattern.Thickness: Integer;
begin
  Result := 1;
end;

{ TdxPSDashedEdgePattern }

class function TdxPSDashedEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $33333333;
end;

class function TdxPSDashedEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxDashedEdgePattern);
end;

class function TdxPSDashedEdgePattern.SignificantBitCount: Integer;
begin
  Result := 8;
end;

class function TdxPSDashedEdgePattern.Thickness: Integer;
begin
  Result := 1;
end;

{ TdxPSDashDotDotEdgePattern }

class function TdxPSDashDotDotEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $FF1C7FC7;
end;

class function TdxPSDashDotDotEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxDashDotDotEdgePattern);
end;

class function TdxPSDashDotDotEdgePattern.SignificantBitCount: Integer;
begin
  Result := 24;
end;

class function TdxPSDashDotDotEdgePattern.Thickness: Integer;
begin
  Result := 1;
end;

{ TdxPSDashDotEdgePattern }

class function TdxPSDashDotEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $FFFC7FC7;
end;

class function TdxPSDashDotEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxDashDotEdgePattern);
end;

class function TdxPSDashDotEdgePattern.SignificantBitCount: Integer;
begin
  Result := 18;
end;

class function TdxPSDashDotEdgePattern.Thickness: Integer;
begin
  Result := 1;
end;

{ TdxPSSlantedDashDotEdgePattern }

class function TdxPSSlantedDashDotEdgePattern.Bits(Index: Integer): DWORD;
begin
  if Index = 0 then
    Result := $FFFFEFFE 
  else
    Result := $FFFCF3FF;
end;

class function TdxPSSlantedDashDotEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxHairEdgePattern);
end;

class function TdxPSSlantedDashDotEdgePattern.SignificantBitCount: Integer;
begin
  Result := 18;
end;

class function TdxPSSlantedDashDotEdgePattern.Thickness: Integer;
begin
  Result := 2;
end;

{ TdxPSMediumDashDotDotEdgePattern }

class function TdxPSMediumDashDotDotEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $FF1C7FC7;
end;

class function TdxPSMediumDashDotDotEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxMediumDashDotDotEdgePattern);
end;

class function TdxPSMediumDashDotDotEdgePattern.SignificantBitCount: Integer;
begin
  Result := 24;
end;

class function TdxPSMediumDashDotDotEdgePattern.Thickness: Integer;
begin
  Result := 2;
end;

{ TdxPSHairEdgePattern }

class function TdxPSHairEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $55555555;
end;

class function TdxPSHairEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxDottedEdgePattern);
end;

class function TdxPSHairEdgePattern.SignificantBitCount: Integer;
begin
  Result := 8;
end;

class function TdxPSHairEdgePattern.Thickness: Integer;
begin
  Result := 1;
end;

{ TdxPSMediumDashDotEdgePattern }

class function TdxPSMediumDashDotEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $FFFC71FF;
end;

class function TdxPSMediumDashDotEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxMediumDashDotEdgePattern);
end;

class function TdxPSMediumDashDotEdgePattern.SignificantBitCount: Integer;
begin
  Result := 18;
end;

class function TdxPSMediumDashDotEdgePattern.Thickness: Integer;
begin
  Result := 2;
end;

{ TdxPSMediumDashedEdgePattern }

class function TdxPSMediumDashedEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $FFFFF1FF;
end;

class function TdxPSMediumDashedEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxMediumDashedEdgePattern);
end;

class function TdxPSMediumDashedEdgePattern.SignificantBitCount: Integer;
begin
  Result := 12;
end;

class function TdxPSMediumDashedEdgePattern.Thickness: Integer;
begin
  Result := 2;
end;

{ TdxPSDoubleLineSolidEdgePattern }

class function TdxPSDoubleLineSolidEdgePattern.Bits(Index: Integer): DWORD;
begin
  Result := $FFFFFFFF * DWORD(Ord(not Odd(Index)));
end;

class function TdxPSDoubleLineSolidEdgePattern.Name: string;
begin
  Result := cxGetResourceString(@sdxDoubleLineEdgePattern);
end;

class function TdxPSDoubleLineSolidEdgePattern.SignificantBitCount: Integer;
begin
  Result := 8;
end;

class function TdxPSDoubleLineSolidEdgePattern.Thickness: Integer;
begin
  Result := 3;
end;

procedure RegisterPatterns;
begin
  TdxPSMediumSolidEdgePattern.Register;
  TdxPSThickSolidEdgePattern.Register;
  TdxPSDottedEdgePattern.Register;
  TdxPSDashedEdgePattern.Register;
  TdxPSDashDotDotEdgePattern.Register;
  TdxPSDashDotEdgePattern.Register;
  TdxPSSlantedDashDotEdgePattern.Register;
  TdxPSMediumDashDotDotEdgePattern.Register;
  TdxPSHairEdgePattern.Register;
  TdxPSMediumDashDotEdgePattern.Register;
  TdxPSMediumDashedEdgePattern.Register;
  TdxPSDoubleLineSolidEdgePattern.Register;
end;

procedure UnregisterPatterns;
begin
  TdxPSDoubleLineSolidEdgePattern.Unregister;
  TdxPSMediumDashedEdgePattern.Unregister;
  TdxPSMediumDashDotEdgePattern.Unregister;
  TdxPSHairEdgePattern.Unregister;
  TdxPSMediumDashDotDotEdgePattern.Unregister;
  TdxPSSlantedDashDotEdgePattern.Unregister;
  TdxPSDashDotEdgePattern.Unregister;
  TdxPSDashDotDotEdgePattern.Unregister;
  TdxPSDashedEdgePattern.Unregister;
  TdxPSDottedEdgePattern.Unregister;
  TdxPSThickSolidEdgePattern.Unregister;
  TdxPSMediumSolidEdgePattern.Unregister;
end;

initialization
  RegisterPatterns;

finalization
  UnregisterPatterns;

end.
