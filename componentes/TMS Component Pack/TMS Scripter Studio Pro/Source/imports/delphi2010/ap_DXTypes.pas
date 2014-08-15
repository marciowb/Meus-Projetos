{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_DXTypes;

interface

uses
  Windows,
  DXTypes,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDXTypesLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _D3DVECTORWrapper = class(TatRecordWrapper)
  private
    Fx: Single;
    Fy: Single;
    Fz: Single;
  public
    constructor Create(ARecord: _D3DVECTOR);
    function ObjToRec: _D3DVECTOR;
  published
    property x: Single read Fx write Fx;
    property y: Single read Fy write Fy;
    property z: Single read Fz write Fz;
  end;
  

implementation

constructor _D3DVECTORWrapper.Create(ARecord: _D3DVECTOR);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fz := ARecord.z;
end;

function _D3DVECTORWrapper.ObjToRec: _D3DVECTOR;
begin
  result.x := Fx;
  result.y := Fy;
  result.z := Fz;
end;



procedure TatDXTypesLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('_DXSDK_PRODUCT_MAJOR',_DXSDK_PRODUCT_MAJOR);
    AddConstant('_DXSDK_PRODUCT_MINOR',_DXSDK_PRODUCT_MINOR);
    AddConstant('_DXSDK_BUILD_MAJOR',_DXSDK_BUILD_MAJOR);
    AddConstant('_DXSDK_BUILD_MINOR',_DXSDK_BUILD_MINOR);
  end;
end;

class function TatDXTypesLibrary.LibraryName: string;
begin
  result := 'DXTypes';
end;

initialization
  RegisterScripterLibrary(TatDXTypesLibrary, True);

{$WARNINGS ON}

end.

