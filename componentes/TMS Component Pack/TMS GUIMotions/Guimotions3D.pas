unit GUIMotions3D;

interface

(*$HPPEMIT '#include "d3d9.h"' *)
(*$HPPEMIT '#include "d3d9types.h"' *)
(*$HPPEMIT '#include "d3d9caps.h"' *)
(*$HPPEMIT '#include "d3dx9.h"' *)
(*$HPPEMIT 'namespace D3dx9' *)
(*$HPPEMIT '{' *)
(*$HPPEMIT '#include "dxsdkver.h"' *)


uses Windows, SysUtils, activex;
const
  //////////// DLL export definitions ///////////////////////////////////////
  d3dx9MicrosoftDLL = 'd3dx9_33.dll';
  d3dx9BorlandDLL = d3dx9MicrosoftDLL; // Compatibility with previous header releases
  d3dx9dll = d3dx9MicrosoftDLL;

const
  _DXSDK_PRODUCT_MAJOR  = 9;
  {$EXTERNALSYM _DXSDK_PRODUCT_MAJOR}
  _DXSDK_PRODUCT_MINOR  = 18;
  {$EXTERNALSYM _DXSDK_PRODUCT_MINOR}
  _DXSDK_BUILD_MAJOR    = 944;
  {$EXTERNALSYM _DXSDK_BUILD_MAJOR}
  _DXSDK_BUILD_MINOR    = 0000;
  {$EXTERNALSYM _DXSDK_BUILD_MINOR}

type
  // TD3DValue is the fundamental Direct3D fractional data type
  D3DVALUE = Single;
  {$EXTERNALSYM D3DVALUE}
  TD3DValue = D3DVALUE;
  {$NODEFINE TD3DValue}
  PD3DValue = ^TD3DValue;
  {$NODEFINE PD3DValue}

  D3DCOLOR = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM D3DCOLOR}
  TD3DColor = D3DCOLOR;
  {$NODEFINE TD3DColor}
  PD3DColor = ^TD3DColor;
  {$NODEFINE PD3DColor}

  _D3DVECTOR = packed record
    x: Single;
    y: Single;
    z: Single;
  end {_D3DVECTOR};
  {$EXTERNALSYM _D3DVECTOR}
  D3DVECTOR = _D3DVECTOR;
  {$EXTERNALSYM D3DVECTOR}
  TD3DVector = _D3DVECTOR;
  {$NODEFINE TD3DVector}
  PD3DVector = ^TD3DVector;
  {$NODEFINE PD3DVector}

const
  iTrue  = DWORD(True);
  iFalse = DWORD(False);


(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       d3d9types.h
 *  Content:    Direct3D capabilities include file
 *
 ***************************************************************************)

// maps unsigned 8 bits/channel to D3DCOLOR
// #define D3DCOLOR_ARGB(a,r,g,b) \
//     ((D3DCOLOR)((((a)&0xff)<<24)|(((r)&0xff)<<16)|(((g)&0xff)<<8)|((b)&0xff)))
function D3DCOLOR_ARGB(a,r,g,b: DWord): TD3DColor;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DCOLOR_ARGB}
// #define D3DCOLOR_RGBA(r,g,b,a) D3DCOLOR_ARGB(a,r,g,b)
function D3DCOLOR_RGBA(r,g,b,a: DWord): TD3DColor;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DCOLOR_RGBA}
// #define D3DCOLOR_XRGB(r,g,b)   D3DCOLOR_ARGB(0xff,r,g,b)
function D3DCOLOR_XRGB(r,g,b: DWord): TD3DColor;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DCOLOR_XRGB}

// #define D3DCOLOR_XYUV(y,u,v)   D3DCOLOR_ARGB(0xff,y,u,v)
function D3DCOLOR_XYUV(y,u,v: DWord): TD3DColor;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DCOLOR_XYUV}
// #define D3DCOLOR_AYUV(a,y,u,v) D3DCOLOR_ARGB(a,y,u,v)
function D3DCOLOR_AYUV(a,y,u,v: DWord): TD3DColor;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DCOLOR_AYUV}

// maps floating point channels (0.f to 1.f range) to D3DCOLOR
// #define D3DCOLOR_COLORVALUE(r,g,b,a) \
//     D3DCOLOR_RGBA((DWORD)((r)*255.f),(DWORD)((g)*255.f),(DWORD)((b)*255.f),(DWORD)((a)*255.f))
function D3DCOLOR_COLORVALUE(r,g,b,a: Single): TD3DColor;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DCOLOR_COLORVALUE}

type
  PD3DColorValue = ^TD3DColorValue;
  _D3DCOLORVALUE = packed record
    r: Single;
    g: Single;
    b: Single;
    a: Single;
  end {_D3DCOLORVALUE};
  {$EXTERNALSYM _D3DCOLORVALUE}
  D3DCOLORVALUE = _D3DCOLORVALUE;
  {$EXTERNALSYM D3DCOLORVALUE}
  TD3DColorValue = _D3DCOLORVALUE;

  PD3DRect = ^TD3DRect;
  _D3DRECT = packed record
    x1: LongInt;
    y1: LongInt;
    x2: LongInt;
    y2: LongInt;
  end {_D3DRECT};
  {$EXTERNALSYM _D3DRECT}
  D3DRECT = _D3DRECT;
  {$EXTERNALSYM D3DRECT}
  TD3DRect = _D3DRECT;

  PD3DMatrix = ^TD3DMatrix;
  _D3DMATRIX = packed record
    case integer of
      0 : (_11, _12, _13, _14: Single;
           _21, _22, _23, _24: Single;
           _31, _32, _33, _34: Single;
           _41, _42, _43, _44: Single);
      1 : (m : array [0..3, 0..3] of Single);
  end {_D3DMATRIX};
  {$EXTERNALSYM _D3DMATRIX}
  D3DMATRIX = _D3DMATRIX;
  {$EXTERNALSYM D3DMATRIX}
  TD3DMatrix = _D3DMATRIX;

  PD3DViewport9 = ^TD3DViewport9;
  _D3DVIEWPORT9 = packed record
    X: DWord;
    Y: DWord;         { Viewport Top left }
    Width: DWord;
    Height: DWord;    { Viewport Dimensions }
    MinZ: Single;       { Min/max of clip Volume }
    MaxZ: Single;
  end {_D3DVIEWPORT9};
  {$EXTERNALSYM _D3DVIEWPORT9}
  D3DVIEWPORT9 = _D3DVIEWPORT9;
  {$EXTERNALSYM D3DVIEWPORT9}
  TD3DViewport9 = _D3DVIEWPORT9;

(*
 * Values for clip fields.
 *)

const
  // Max number of user clipping planes, supported in D3D.
  D3DMAXUSERCLIPPLANES = 32;
  {$EXTERNALSYM D3DMAXUSERCLIPPLANES}

  // These bits could be ORed together to use with D3DRS_CLIPPLANEENABLE
  //
  D3DCLIPPLANE0 = (1 shl 0);
  {$EXTERNALSYM D3DCLIPPLANE0}
  D3DCLIPPLANE1 = (1 shl 1);
  {$EXTERNALSYM D3DCLIPPLANE1}
  D3DCLIPPLANE2 = (1 shl 2);
  {$EXTERNALSYM D3DCLIPPLANE2}
  D3DCLIPPLANE3 = (1 shl 3);
  {$EXTERNALSYM D3DCLIPPLANE3}
  D3DCLIPPLANE4 = (1 shl 4);
  {$EXTERNALSYM D3DCLIPPLANE4}
  D3DCLIPPLANE5 = (1 shl 5);
  {$EXTERNALSYM D3DCLIPPLANE5}

  // The following bits are used in the ClipUnion and ClipIntersection
  // members of the D3DCLIPSTATUS9
  //
  D3DCS_LEFT    = $00000001;
  {$EXTERNALSYM D3DCS_LEFT}
  D3DCS_RIGHT   = $00000002;
  {$EXTERNALSYM D3DCS_RIGHT}
  D3DCS_TOP     = $00000004;
  {$EXTERNALSYM D3DCS_TOP}
  D3DCS_BOTTOM  = $00000008;
  {$EXTERNALSYM D3DCS_BOTTOM}
  D3DCS_FRONT   = $00000010;
  {$EXTERNALSYM D3DCS_FRONT}
  D3DCS_BACK    = $00000020;
  {$EXTERNALSYM D3DCS_BACK}
  D3DCS_PLANE0  = $00000040;
  {$EXTERNALSYM D3DCS_PLANE0}
  D3DCS_PLANE1  = $00000080;
  {$EXTERNALSYM D3DCS_PLANE1}
  D3DCS_PLANE2  = $00000100;
  {$EXTERNALSYM D3DCS_PLANE2}
  D3DCS_PLANE3  = $00000200;
  {$EXTERNALSYM D3DCS_PLANE3}
  D3DCS_PLANE4  = $00000400;
  {$EXTERNALSYM D3DCS_PLANE4}
  D3DCS_PLANE5  = $00000800;
  {$EXTERNALSYM D3DCS_PLANE5}

  D3DCS_ALL     = D3DCS_LEFT   or
                  D3DCS_RIGHT  or
                  D3DCS_TOP    or
                  D3DCS_BOTTOM or
                  D3DCS_FRONT  or
                  D3DCS_BACK   or
                  D3DCS_PLANE0 or
                  D3DCS_PLANE1 or
                  D3DCS_PLANE2 or
                  D3DCS_PLANE3 or
                  D3DCS_PLANE4 or
                  D3DCS_PLANE5;
  {$EXTERNALSYM D3DCS_ALL}

type
  PD3DClipStatus9 = ^TD3DClipStatus9;
  _D3DCLIPSTATUS9 = packed record
    ClipUnion: DWord;
    ClipIntersection: DWord;
  end {_D3DCLIPSTATUS9};
  {$EXTERNALSYM _D3DCLIPSTATUS9}
  D3DCLIPSTATUS9 = _D3DCLIPSTATUS9;
  {$EXTERNALSYM D3DCLIPSTATUS9}
  TD3DClipStatus9 = _D3DCLIPSTATUS9;

  PD3DMaterial9 = ^TD3DMaterial9;
  _D3DMATERIAL9 = packed record
    Diffuse: TD3DColorValue;   { Diffuse color RGBA }
    Ambient: TD3DColorValue;   { Ambient color RGB }
    Specular: TD3DColorValue;  { Specular 'shininess' }
    Emissive: TD3DColorValue;  { Emissive color RGB }
    Power: Single;             { Sharpness if specular highlight }
  end {_D3DMATERIAL9};
  {$EXTERNALSYM _D3DMATERIAL9}
  D3DMATERIAL9 = _D3DMATERIAL9;
  {$EXTERNALSYM D3DMATERIAL9}
  TD3DMaterial9 = _D3DMATERIAL9;

  _D3DLIGHTTYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DLIGHT_INVALID_0, {= 0}
    D3DLIGHT_POINT,     {= 1}
    D3DLIGHT_SPOT,      {= 2}
    D3DLIGHT_DIRECTIONAL{= 3}
  {$ELSE}
    D3DLIGHT_POINT       = 1,
    D3DLIGHT_SPOT        = 2,
    D3DLIGHT_DIRECTIONAL = 3
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DLIGHTTYPE}
  D3DLIGHTTYPE = _D3DLIGHTTYPE;
  {$EXTERNALSYM D3DLIGHTTYPE}
  TD3DLightType = _D3DLIGHTTYPE;

  PD3DLight9 = ^TD3DLight9;
  _D3DLIGHT9 = packed record
    _Type: TD3DLightType;       { Type of light source }
    Diffuse: TD3DColorValue;    { Diffuse color of light }
    Specular: TD3DColorValue;   { Specular color of light }
    Ambient: TD3DColorValue;    { Ambient color of light }
    Position: TD3DVector;       { Position in world space }
    Direction: TD3DVector;      { Direction in world space }
    Range: Single;              { Cutoff range }
    Falloff: Single;            { Falloff }
    Attenuation0: Single;       { Constant attenuation }
    Attenuation1: Single;       { Linear attenuation }
    Attenuation2: Single;       { Quadratic attenuation }
    Theta: Single;              { Inner angle of spotlight cone }
    Phi: Single;                { Outer angle of spotlight cone }
  end {_D3DLIGHT9};
  {$EXTERNALSYM _D3DLIGHT9}
  D3DLIGHT9 = _D3DLIGHT9;
  {$EXTERNALSYM D3DLIGHT9}
  TD3DLight9 = _D3DLIGHT9;

(*
 * Options for clearing
 *)
const
  D3DCLEAR_TARGET       = $00000001; { Clear target surface }
  {$EXTERNALSYM D3DCLEAR_TARGET}
  D3DCLEAR_ZBUFFER      = $00000002; { Clear target z buffer }
  {$EXTERNALSYM D3DCLEAR_ZBUFFER}
  D3DCLEAR_STENCIL      = $00000004; { Clear stencil planes }
  {$EXTERNALSYM D3DCLEAR_STENCIL}

(*
 * The following defines the rendering states
 *)
type
  _D3DSHADEMODE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DSHADEMODE}
  D3DSHADEMODE = _D3DSHADEMODE;
  {$EXTERNALSYM D3DSHADEMODE}
  TD3DShadeMode = _D3DSHADEMODE;

const
  D3DSHADE_FLAT      = 1;
  {$EXTERNALSYM D3DSHADE_FLAT}
  D3DSHADE_GOURAUD   = 2;
  {$EXTERNALSYM D3DSHADE_GOURAUD}
  D3DSHADE_PHONG     = 3;
  {$EXTERNALSYM D3DSHADE_PHONG}

type
  _D3DFILLMODE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DFILLMODE}
  D3DFILLMODE = _D3DFILLMODE;
  {$EXTERNALSYM D3DFILLMODE}
  TD3DFillMode = _D3DFILLMODE;

const
  D3DFILL_POINT      = 1;
  {$EXTERNALSYM D3DFILL_POINT}
  D3DFILL_WIREFRAME  = 2;
  {$EXTERNALSYM D3DFILL_WIREFRAME}
  D3DFILL_SOLID      = 3;
  {$EXTERNALSYM D3DFILL_SOLID}

type
  _D3DBLEND = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DBLEND}
  D3DBLEND = _D3DBLEND;
  {$EXTERNALSYM D3DBLEND}
  TD3DBlend = _D3DBLEND;

const
  D3DBLEND_ZERO              = 1;
  {$EXTERNALSYM D3DBLEND_ZERO}
  D3DBLEND_ONE               = 2;
  {$EXTERNALSYM D3DBLEND_ONE}
  D3DBLEND_SRCCOLOR          = 3;
  {$EXTERNALSYM D3DBLEND_SRCCOLOR}
  D3DBLEND_INVSRCCOLOR       = 4;
  {$EXTERNALSYM D3DBLEND_INVSRCCOLOR}
  D3DBLEND_SRCALPHA          = 5;
  {$EXTERNALSYM D3DBLEND_SRCALPHA}
  D3DBLEND_INVSRCALPHA       = 6;
  {$EXTERNALSYM D3DBLEND_INVSRCALPHA}
  D3DBLEND_DESTALPHA         = 7;
  {$EXTERNALSYM D3DBLEND_DESTALPHA}
  D3DBLEND_INVDESTALPHA      = 8;
  {$EXTERNALSYM D3DBLEND_INVDESTALPHA}
  D3DBLEND_DESTCOLOR         = 9;
  {$EXTERNALSYM D3DBLEND_DESTCOLOR}
  D3DBLEND_INVDESTCOLOR      = 10;
  {$EXTERNALSYM D3DBLEND_INVDESTCOLOR}
  D3DBLEND_SRCALPHASAT       = 11;
  {$EXTERNALSYM D3DBLEND_SRCALPHASAT}
  D3DBLEND_BOTHSRCALPHA      = 12;
  {$EXTERNALSYM D3DBLEND_BOTHSRCALPHA}
  D3DBLEND_BOTHINVSRCALPHA   = 13;
  {$EXTERNALSYM D3DBLEND_BOTHINVSRCALPHA}
  D3DBLEND_BLENDFACTOR       = 14; (* Only supported if D3DPBLENDCAPS_BLENDFACTOR is on *)
  {$EXTERNALSYM D3DBLEND_BLENDFACTOR}
  D3DBLEND_INVBLENDFACTOR    = 15; (* Only supported if D3DPBLENDCAPS_BLENDFACTOR is on *)
  {$EXTERNALSYM D3DBLEND_INVBLENDFACTOR}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DBLEND_SRCCOLOR2         = 16;
  {$EXTERNALSYM D3DBLEND_SRCCOLOR2}
  D3DBLEND_INVSRCCOLOR2      = 17;
  {$EXTERNALSYM D3DBLEND_INVSRCCOLOR2}
{$ENDIF}

type
  _D3DBLENDOP = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DBLENDOP}
  D3DBLENDOP = _D3DBLENDOP;
  {$EXTERNALSYM D3DBLENDOP}
  TD3DBlendOp = _D3DBLENDOP;

const
  D3DBLENDOP_ADD             = 1;
  {$EXTERNALSYM D3DBLENDOP_ADD}
  D3DBLENDOP_SUBTRACT        = 2;
  {$EXTERNALSYM D3DBLENDOP_SUBTRACT}
  D3DBLENDOP_REVSUBTRACT     = 3;
  {$EXTERNALSYM D3DBLENDOP_REVSUBTRACT}
  D3DBLENDOP_MIN             = 4;
  {$EXTERNALSYM D3DBLENDOP_MIN}
  D3DBLENDOP_MAX             = 5;
  {$EXTERNALSYM D3DBLENDOP_MAX}

type
  _D3DTEXTUREADDRESS = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DTEXTUREADDRESS}
  D3DTEXTUREADDRESS = _D3DTEXTUREADDRESS;
  {$EXTERNALSYM D3DTEXTUREADDRESS}
  TD3DTextureAddress = _D3DTEXTUREADDRESS;

const
  D3DTADDRESS_WRAP           = 1;
  {$EXTERNALSYM D3DTADDRESS_WRAP}
  D3DTADDRESS_MIRROR         = 2;
  {$EXTERNALSYM D3DTADDRESS_MIRROR}
  D3DTADDRESS_CLAMP          = 3;
  {$EXTERNALSYM D3DTADDRESS_CLAMP}
  D3DTADDRESS_BORDER         = 4;
  {$EXTERNALSYM D3DTADDRESS_BORDER}
  D3DTADDRESS_MIRRORONCE     = 5;
  {$EXTERNALSYM D3DTADDRESS_MIRRORONCE}

type
  _D3DCULL = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DCULL}
  D3DCULL = _D3DCULL;
  {$EXTERNALSYM D3DCULL}
  TD3DCull = _D3DCULL;

const
  D3DCULL_NONE       = 1;
  {$EXTERNALSYM D3DCULL_NONE}
  D3DCULL_CW         = 2;
  {$EXTERNALSYM D3DCULL_CW}
  D3DCULL_CCW        = 3;
  {$EXTERNALSYM D3DCULL_CCW}

type
  _D3DCMPFUNC = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DCMPFUNC}
  D3DCMPFUNC = _D3DCMPFUNC;
  {$EXTERNALSYM D3DCMPFUNC}
  TD3DCmpFunc = _D3DCMPFUNC;

const
  D3DCMP_NEVER          = 1;
  {$EXTERNALSYM D3DCMP_NEVER}
  D3DCMP_LESS           = 2;
  {$EXTERNALSYM D3DCMP_LESS}
  D3DCMP_EQUAL          = 3;
  {$EXTERNALSYM D3DCMP_EQUAL}
  D3DCMP_LESSEQUAL      = 4;
  {$EXTERNALSYM D3DCMP_LESSEQUAL}
  D3DCMP_GREATER        = 5;
  {$EXTERNALSYM D3DCMP_GREATER}
  D3DCMP_NOTEQUAL       = 6;
  {$EXTERNALSYM D3DCMP_NOTEQUAL}
  D3DCMP_GREATEREQUAL   = 7;
  {$EXTERNALSYM D3DCMP_GREATEREQUAL}
  D3DCMP_ALWAYS         = 8;
  {$EXTERNALSYM D3DCMP_ALWAYS}

type
  _D3DSTENCILOP = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DSTENCILOP}
  D3DSTENCILOP = _D3DSTENCILOP;
  {$EXTERNALSYM D3DSTENCILOP}
  TD3DStencilOp = _D3DSTENCILOP;

const
  D3DSTENCILOP_KEEP     = 1;
  {$EXTERNALSYM D3DSTENCILOP_KEEP}
  D3DSTENCILOP_ZERO     = 2;
  {$EXTERNALSYM D3DSTENCILOP_ZERO}
  D3DSTENCILOP_REPLACE  = 3;
  {$EXTERNALSYM D3DSTENCILOP_REPLACE}
  D3DSTENCILOP_INCRSAT  = 4;
  {$EXTERNALSYM D3DSTENCILOP_INCRSAT}
  D3DSTENCILOP_DECRSAT  = 5;
  {$EXTERNALSYM D3DSTENCILOP_DECRSAT}
  D3DSTENCILOP_INVERT   = 6;
  {$EXTERNALSYM D3DSTENCILOP_INVERT}
  D3DSTENCILOP_INCR     = 7;
  {$EXTERNALSYM D3DSTENCILOP_INCR}
  D3DSTENCILOP_DECR     = 8;
  {$EXTERNALSYM D3DSTENCILOP_DECR}

type
  _D3DFOGMODE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DFOGMODE}
  D3DFOGMODE = _D3DFOGMODE;
  {$EXTERNALSYM D3DFOGMODE}
  TD3DFogMode = _D3DFOGMODE;

const
  D3DFOG_NONE   = 0;
  {$EXTERNALSYM D3DFOG_NONE}
  D3DFOG_EXP    = 1;
  {$EXTERNALSYM D3DFOG_EXP}
  D3DFOG_EXP2   = 2;
  {$EXTERNALSYM D3DFOG_EXP2}
  D3DFOG_LINEAR = 3;
  {$EXTERNALSYM D3DFOG_LINEAR}

type
  _D3DZBUFFERTYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DZBUFFERTYPE}
  D3DZBUFFERTYPE = _D3DZBUFFERTYPE;
  {$EXTERNALSYM D3DZBUFFERTYPE}
  TD3DZBufferType = _D3DZBUFFERTYPE;

const
  D3DZB_FALSE   = 0;
  {$EXTERNALSYM D3DZB_FALSE}
  D3DZB_TRUE    = 1;
  {$EXTERNALSYM D3DZB_TRUE}
  D3DZB_USEW    = 2;
  {$EXTERNALSYM D3DZB_USEW}

type
  // Primitives supported by draw-primitive API
  _D3DPRIMITIVETYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DPT_INVALID_0    {= 0},
    D3DPT_POINTLIST    {= 1},
    D3DPT_LINELIST     {= 2},
    D3DPT_LINESTRIP    {= 3},
    D3DPT_TRIANGLELIST {= 4},
    D3DPT_TRIANGLESTRIP{= 5},
    D3DPT_TRIANGLEFAN  {= 6}
  {$ELSE}
    D3DPT_POINTLIST     = 1,
    D3DPT_LINELIST      = 2,
    D3DPT_LINESTRIP     = 3,
    D3DPT_TRIANGLELIST  = 4,
    D3DPT_TRIANGLESTRIP = 5,
    D3DPT_TRIANGLEFAN   = 6
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DPRIMITIVETYPE}
  D3DPRIMITIVETYPE = _D3DPRIMITIVETYPE;
  {$EXTERNALSYM D3DPRIMITIVETYPE}
  TD3DPrimitiveType = _D3DPRIMITIVETYPE;

{$IFNDEF SUPPORTS_EXPL_ENUMS}
const
  D3DTS_VIEW          = 2;
  {$EXTERNALSYM D3DTS_VIEW}
  D3DTS_PROJECTION    = 3;
  {$EXTERNALSYM D3DTS_PROJECTION}
  D3DTS_TEXTURE0      = 16;
  {$EXTERNALSYM D3DTS_TEXTURE0}
  D3DTS_TEXTURE1      = 17;
  {$EXTERNALSYM D3DTS_TEXTURE1}
  D3DTS_TEXTURE2      = 18;
  {$EXTERNALSYM D3DTS_TEXTURE2}
  D3DTS_TEXTURE3      = 19;
  {$EXTERNALSYM D3DTS_TEXTURE3}
  D3DTS_TEXTURE4      = 20;
  {$EXTERNALSYM D3DTS_TEXTURE4}
  D3DTS_TEXTURE5      = 21;
  {$EXTERNALSYM D3DTS_TEXTURE5}
  D3DTS_TEXTURE6      = 22;
  {$EXTERNALSYM D3DTS_TEXTURE6}
  D3DTS_TEXTURE7      = 23;
  {$EXTERNALSYM D3DTS_TEXTURE7}
  D3DTS_FORCE_DWORD   = $7fffffff; (* force 32-bit size enum *)
  {$EXTERNALSYM D3DTS_FORCE_DWORD}

type
  _D3DTRANSFORMSTATETYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
{$ELSE}
type
  _D3DTRANSFORMSTATETYPE = (
    D3DTS_VIEW          = 2,
    D3DTS_PROJECTION    = 3,
    D3DTS_TEXTURE0      = 16,
    D3DTS_TEXTURE1      = 17,
    D3DTS_TEXTURE2      = 18,
    D3DTS_TEXTURE3      = 19,
    D3DTS_TEXTURE4      = 20,
    D3DTS_TEXTURE5      = 21,
    D3DTS_TEXTURE6      = 22,
    D3DTS_TEXTURE7      = 23
  );
{$ENDIF}
  {$EXTERNALSYM _D3DTRANSFORMSTATETYPE}
  D3DTRANSFORMSTATETYPE = _D3DTRANSFORMSTATETYPE;
  {$EXTERNALSYM D3DTRANSFORMSTATETYPE}
  TD3DTransformStateType = _D3DTRANSFORMSTATETYPE;

// #define D3DTS_WORLDMATRIX(index) (D3DTRANSFORMSTATETYPE)(index + 256)
function D3DTS_WORLDMATRIX(index: Byte): TD3DTransformStateType;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DTS_WORLDMATRIX}

const
  D3DTS_WORLD   =  TD3DTransformStateType(0 + 256); // #define D3DTS_WORLD  D3DTS_WORLDMATRIX(0)
  {$EXTERNALSYM D3DTS_WORLD}
  D3DTS_WORLD1  =  TD3DTransformStateType(1 + 256); // #define D3DTS_WORLD1 D3DTS_WORLDMATRIX(1)
  {$EXTERNALSYM D3DTS_WORLD1}
  D3DTS_WORLD2  =  TD3DTransformStateType(2 + 256); // #define D3DTS_WORLD2 D3DTS_WORLDMATRIX(2)
  {$EXTERNALSYM D3DTS_WORLD2}
  D3DTS_WORLD3  =  TD3DTransformStateType(3 + 256); // #define D3DTS_WORLD3 D3DTS_WORLDMATRIX(3)
  {$EXTERNALSYM D3DTS_WORLD3}

{$IFNDEF SUPPORTS_EXPL_ENUMS}
type
  _D3DRENDERSTATETYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DRENDERSTATETYPE}
  D3DRENDERSTATETYPE = _D3DRENDERSTATETYPE;
  {$EXTERNALSYM D3DRENDERSTATETYPE}
  TD3DRenderStateType = _D3DRENDERSTATETYPE;

const
  D3DRS_ZENABLE                   = TD3DRenderStateType(7);    { D3DZBUFFERTYPE (or TRUE/FALSE for legacy) }
  {$EXTERNALSYM D3DRS_ZENABLE}
  D3DRS_FILLMODE                  = TD3DRenderStateType(8);    { D3DFILLMODE }
  {$EXTERNALSYM D3DRS_FILLMODE}
  D3DRS_SHADEMODE                 = TD3DRenderStateType(9);    { D3DSHADEMODE }
  {$EXTERNALSYM D3DRS_SHADEMODE}
  D3DRS_ZWRITEENABLE              = TD3DRenderStateType(14);   { TRUE to enable z writes }
  {$EXTERNALSYM D3DRS_ZWRITEENABLE}
  D3DRS_ALPHATESTENABLE           = TD3DRenderStateType(15);   { TRUE to enable alpha tests }
  {$EXTERNALSYM D3DRS_ALPHATESTENABLE}
  D3DRS_LASTPIXEL                 = TD3DRenderStateType(16);   { TRUE for last-pixel on lines }
  {$EXTERNALSYM D3DRS_LASTPIXEL}
  D3DRS_SRCBLEND                  = TD3DRenderStateType(19);   { D3DBLEND }
  {$EXTERNALSYM D3DRS_SRCBLEND}
  D3DRS_DESTBLEND                 = TD3DRenderStateType(20);   { D3DBLEND }
  {$EXTERNALSYM D3DRS_DESTBLEND}
  D3DRS_CULLMODE                  = TD3DRenderStateType(22);   { D3DCULL }
  {$EXTERNALSYM D3DRS_CULLMODE}
  D3DRS_ZFUNC                     = TD3DRenderStateType(23);   { D3DCMPFUNC }
  {$EXTERNALSYM D3DRS_ZFUNC}
  D3DRS_ALPHAREF                  = TD3DRenderStateType(24);   { D3DFIXED }
  {$EXTERNALSYM D3DRS_ALPHAREF}
  D3DRS_ALPHAFUNC                 = TD3DRenderStateType(25);   { D3DCMPFUNC }
  {$EXTERNALSYM D3DRS_ALPHAFUNC}
  D3DRS_DITHERENABLE              = TD3DRenderStateType(26);   { TRUE to enable dithering }
  {$EXTERNALSYM D3DRS_DITHERENABLE}
  D3DRS_ALPHABLENDENABLE          = TD3DRenderStateType(27);   { TRUE to enable alpha blending }
  {$EXTERNALSYM D3DRS_ALPHABLENDENABLE}
  D3DRS_FOGENABLE                 = TD3DRenderStateType(28);   { TRUE to enable fog blending }
  {$EXTERNALSYM D3DRS_FOGENABLE}
  D3DRS_SPECULARENABLE            = TD3DRenderStateType(29);   { TRUE to enable specular }
  {$EXTERNALSYM D3DRS_SPECULARENABLE}
  D3DRS_FOGCOLOR                  = TD3DRenderStateType(34);   { D3DCOLOR }
  {$EXTERNALSYM D3DRS_FOGCOLOR}
  D3DRS_FOGTABLEMODE              = TD3DRenderStateType(35);   { D3DFOGMODE }
  {$EXTERNALSYM D3DRS_FOGTABLEMODE}
  D3DRS_FOGSTART                  = TD3DRenderStateType(36);   { Fog start (for both vertex and pixel fog) }
  {$EXTERNALSYM D3DRS_FOGSTART}
  D3DRS_FOGEND                    = TD3DRenderStateType(37);   { Fog end      }
  {$EXTERNALSYM D3DRS_FOGEND}
  D3DRS_FOGDENSITY                = TD3DRenderStateType(38);   { Fog density  }
  {$EXTERNALSYM D3DRS_FOGDENSITY}
  D3DRS_RANGEFOGENABLE            = TD3DRenderStateType(48);   { Enables range-based fog }
  {$EXTERNALSYM D3DRS_RANGEFOGENABLE}
  D3DRS_STENCILENABLE             = TD3DRenderStateType(52);   { BOOL enable/disable stenciling }
  {$EXTERNALSYM D3DRS_STENCILENABLE}
  D3DRS_STENCILFAIL               = TD3DRenderStateType(53);   { D3DSTENCILOP to do if stencil test fails }
  {$EXTERNALSYM D3DRS_STENCILFAIL}
  D3DRS_STENCILZFAIL              = TD3DRenderStateType(54);   { D3DSTENCILOP to do if stencil test passes and Z test fails }
  {$EXTERNALSYM D3DRS_STENCILZFAIL}
  D3DRS_STENCILPASS               = TD3DRenderStateType(55);   { D3DSTENCILOP to do if both stencil and Z tests pass }
  {$EXTERNALSYM D3DRS_STENCILPASS}
  D3DRS_STENCILFUNC               = TD3DRenderStateType(56);   { D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true }
  {$EXTERNALSYM D3DRS_STENCILFUNC}
  D3DRS_STENCILREF                = TD3DRenderStateType(57);   { Reference value used in stencil test }
  {$EXTERNALSYM D3DRS_STENCILREF}
  D3DRS_STENCILMASK               = TD3DRenderStateType(58);   { Mask value used in stencil test }
  {$EXTERNALSYM D3DRS_STENCILMASK}
  D3DRS_STENCILWRITEMASK          = TD3DRenderStateType(59);   { Write mask applied to values written to stencil buffer }
  {$EXTERNALSYM D3DRS_STENCILWRITEMASK}
  D3DRS_TEXTUREFACTOR             = TD3DRenderStateType(60);   { D3DCOLOR used for multi-texture blend }
  {$EXTERNALSYM D3DRS_TEXTUREFACTOR}
  D3DRS_WRAP0                     = TD3DRenderStateType(128);  { wrap for 1st texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP0}
  D3DRS_WRAP1                     = TD3DRenderStateType(129);  { wrap for 2nd texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP1}
  D3DRS_WRAP2                     = TD3DRenderStateType(130);  { wrap for 3rd texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP2}
  D3DRS_WRAP3                     = TD3DRenderStateType(131);  { wrap for 4th texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP3}
  D3DRS_WRAP4                     = TD3DRenderStateType(132);  { wrap for 5th texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP4}
  D3DRS_WRAP5                     = TD3DRenderStateType(133);  { wrap for 6th texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP5}
  D3DRS_WRAP6                     = TD3DRenderStateType(134);  { wrap for 7th texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP6}
  D3DRS_WRAP7                     = TD3DRenderStateType(135);  { wrap for 8th texture coord. set }
  {$EXTERNALSYM D3DRS_WRAP7}
  D3DRS_CLIPPING                  = TD3DRenderStateType(136);
  {$EXTERNALSYM D3DRS_CLIPPING}
  D3DRS_LIGHTING                  = TD3DRenderStateType(137);
  {$EXTERNALSYM D3DRS_LIGHTING}
  D3DRS_AMBIENT                   = TD3DRenderStateType(139);
  {$EXTERNALSYM D3DRS_AMBIENT}
  D3DRS_FOGVERTEXMODE             = TD3DRenderStateType(140);
  {$EXTERNALSYM D3DRS_FOGVERTEXMODE}
  D3DRS_COLORVERTEX               = TD3DRenderStateType(141);
  {$EXTERNALSYM D3DRS_COLORVERTEX}
  D3DRS_LOCALVIEWER               = TD3DRenderStateType(142);
  {$EXTERNALSYM D3DRS_LOCALVIEWER}
  D3DRS_NORMALIZENORMALS          = TD3DRenderStateType(143);
  {$EXTERNALSYM D3DRS_NORMALIZENORMALS}
  D3DRS_DIFFUSEMATERIALSOURCE     = TD3DRenderStateType(145);
  {$EXTERNALSYM D3DRS_DIFFUSEMATERIALSOURCE}
  D3DRS_SPECULARMATERIALSOURCE    = TD3DRenderStateType(146);
  {$EXTERNALSYM D3DRS_SPECULARMATERIALSOURCE}
  D3DRS_AMBIENTMATERIALSOURCE     = TD3DRenderStateType(147);
  {$EXTERNALSYM D3DRS_AMBIENTMATERIALSOURCE}
  D3DRS_EMISSIVEMATERIALSOURCE    = TD3DRenderStateType(148);
  {$EXTERNALSYM D3DRS_EMISSIVEMATERIALSOURCE}
  D3DRS_VERTEXBLEND               = TD3DRenderStateType(151);
  {$EXTERNALSYM D3DRS_VERTEXBLEND}
  D3DRS_CLIPPLANEENABLE           = TD3DRenderStateType(152);
  {$EXTERNALSYM D3DRS_CLIPPLANEENABLE}
  D3DRS_POINTSIZE                 = TD3DRenderStateType(154);   { float point size }
  {$EXTERNALSYM D3DRS_POINTSIZE}
  D3DRS_POINTSIZE_MIN             = TD3DRenderStateType(155);   { float point size min threshold }
  {$EXTERNALSYM D3DRS_POINTSIZE_MIN}
  D3DRS_POINTSPRITEENABLE         = TD3DRenderStateType(156);   { BOOL point texture coord control }
  {$EXTERNALSYM D3DRS_POINTSPRITEENABLE}
  D3DRS_POINTSCALEENABLE          = TD3DRenderStateType(157);   { BOOL point size scale enable }
  {$EXTERNALSYM D3DRS_POINTSCALEENABLE}
  D3DRS_POINTSCALE_A              = TD3DRenderStateType(158);   { float point attenuation A value }
  {$EXTERNALSYM D3DRS_POINTSCALE_A}
  D3DRS_POINTSCALE_B              = TD3DRenderStateType(159);   { float point attenuation B value }
  {$EXTERNALSYM D3DRS_POINTSCALE_B}
  D3DRS_POINTSCALE_C              = TD3DRenderStateType(160);   { float point attenuation C value }
  {$EXTERNALSYM D3DRS_POINTSCALE_C}
  D3DRS_MULTISAMPLEANTIALIAS      = TD3DRenderStateType(161);  // BOOL - set to do FSAA with multisample buffer
  {$EXTERNALSYM D3DRS_MULTISAMPLEANTIALIAS}
  D3DRS_MULTISAMPLEMASK           = TD3DRenderStateType(162);  // DWORD - per-sample enable/disable
  {$EXTERNALSYM D3DRS_MULTISAMPLEMASK}
  D3DRS_PATCHEDGESTYLE            = TD3DRenderStateType(163);  // Sets whether patch edges will use float style tessellation
  {$EXTERNALSYM D3DRS_PATCHEDGESTYLE}
  D3DRS_DEBUGMONITORTOKEN         = TD3DRenderStateType(165);  // DEBUG ONLY - token to debug monitor
  {$EXTERNALSYM D3DRS_DEBUGMONITORTOKEN}
  D3DRS_POINTSIZE_MAX             = TD3DRenderStateType(166);   { float point size max threshold }
  {$EXTERNALSYM D3DRS_POINTSIZE_MAX}
  D3DRS_INDEXEDVERTEXBLENDENABLE  = TD3DRenderStateType(167);
  {$EXTERNALSYM D3DRS_INDEXEDVERTEXBLENDENABLE}
  D3DRS_COLORWRITEENABLE          = TD3DRenderStateType(168);  // per-channel write enable
  {$EXTERNALSYM D3DRS_COLORWRITEENABLE}
  D3DRS_TWEENFACTOR               = TD3DRenderStateType(170);   // float tween factor
  {$EXTERNALSYM D3DRS_TWEENFACTOR}
  D3DRS_BLENDOP                   = TD3DRenderStateType(171);   // D3DBLENDOP setting
  {$EXTERNALSYM D3DRS_BLENDOP}
  D3DRS_POSITIONDEGREE            = TD3DRenderStateType(172);   // NPatch position interpolation degree. D3DDEGREE_LINEAR or D3DDEGREE_CUBIC (default)
  {$EXTERNALSYM D3DRS_POSITIONDEGREE}
  D3DRS_NORMALDEGREE              = TD3DRenderStateType(173);   // NPatch normal interpolation degree. D3DDEGREE_LINEAR (default) or D3DDEGREE_QUADRATIC
  {$EXTERNALSYM D3DRS_NORMALDEGREE}
  D3DRS_SCISSORTESTENABLE         = TD3DRenderStateType(174);
  {$EXTERNALSYM D3DRS_SCISSORTESTENABLE}
  D3DRS_SLOPESCALEDEPTHBIAS       = TD3DRenderStateType(175);
  {$EXTERNALSYM D3DRS_SLOPESCALEDEPTHBIAS}
  D3DRS_ANTIALIASEDLINEENABLE     = TD3DRenderStateType(176);
  {$EXTERNALSYM D3DRS_ANTIALIASEDLINEENABLE}
  D3DRS_MINTESSELLATIONLEVEL      = TD3DRenderStateType(178);
  {$EXTERNALSYM D3DRS_MINTESSELLATIONLEVEL}
  D3DRS_MAXTESSELLATIONLEVEL      = TD3DRenderStateType(179);
  {$EXTERNALSYM D3DRS_MAXTESSELLATIONLEVEL}
  D3DRS_ADAPTIVETESS_X            = TD3DRenderStateType(180);
  {$EXTERNALSYM D3DRS_ADAPTIVETESS_X}
  D3DRS_ADAPTIVETESS_Y            = TD3DRenderStateType(181);
  {$EXTERNALSYM D3DRS_ADAPTIVETESS_Y}
  D3DRS_ADAPTIVETESS_Z            = TD3DRenderStateType(182);
  {$EXTERNALSYM D3DRS_ADAPTIVETESS_Z}
  D3DRS_ADAPTIVETESS_W            = TD3DRenderStateType(183);
  {$EXTERNALSYM D3DRS_ADAPTIVETESS_W}
  D3DRS_ENABLEADAPTIVETESSELLATION = TD3DRenderStateType(184);
  {$EXTERNALSYM D3DRS_ENABLEADAPTIVETESSELLATION}
  D3DRS_TWOSIDEDSTENCILMODE       = TD3DRenderStateType(185);   (* BOOL enable/disable 2 sided stenciling *)
  {$EXTERNALSYM D3DRS_TWOSIDEDSTENCILMODE}
  D3DRS_CCW_STENCILFAIL           = TD3DRenderStateType(186);   (* D3DSTENCILOP to do if ccw stencil test fails *)
  {$EXTERNALSYM D3DRS_CCW_STENCILFAIL}
  D3DRS_CCW_STENCILZFAIL          = TD3DRenderStateType(187);   (* D3DSTENCILOP to do if ccw stencil test passes and Z test fails *)
  {$EXTERNALSYM D3DRS_CCW_STENCILZFAIL}
  D3DRS_CCW_STENCILPASS           = TD3DRenderStateType(188);   (* D3DSTENCILOP to do if both ccw stencil and Z tests pass *)
  {$EXTERNALSYM D3DRS_CCW_STENCILPASS}
  D3DRS_CCW_STENCILFUNC           = TD3DRenderStateType(189);   (* D3DCMPFUNC fn.  ccw Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
  {$EXTERNALSYM D3DRS_CCW_STENCILFUNC}
  D3DRS_COLORWRITEENABLE1         = TD3DRenderStateType(190);   (* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS *)
  {$EXTERNALSYM D3DRS_COLORWRITEENABLE1}
  D3DRS_COLORWRITEENABLE2         = TD3DRenderStateType(191);   (* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS *)
  {$EXTERNALSYM D3DRS_COLORWRITEENABLE2}
  D3DRS_COLORWRITEENABLE3         = TD3DRenderStateType(192);   (* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS *)
  {$EXTERNALSYM D3DRS_COLORWRITEENABLE3}
  D3DRS_BLENDFACTOR               = TD3DRenderStateType(193);   (* D3DCOLOR used for a constant blend factor during alpha blending for devices that support D3DPBLENDCAPS_BLENDFACTOR *)
  {$EXTERNALSYM D3DRS_BLENDFACTOR}
  D3DRS_SRGBWRITEENABLE           = TD3DRenderStateType(194);   (* Enable rendertarget writes to be DE-linearized to SRGB (for formats that expose D3DUSAGE_QUERY_SRGBWRITE) *)
  {$EXTERNALSYM D3DRS_SRGBWRITEENABLE}
  D3DRS_DEPTHBIAS                 = TD3DRenderStateType(195);
  {$EXTERNALSYM D3DRS_DEPTHBIAS}
  D3DRS_WRAP8                     = TD3DRenderStateType(198);   (* Additional wrap states for vs_3_0+ attributes with D3DDECLUSAGE_TEXCOORD *)
  {$EXTERNALSYM D3DRS_WRAP8}
  D3DRS_WRAP9                     = TD3DRenderStateType(199);
  {$EXTERNALSYM D3DRS_WRAP9}
  D3DRS_WRAP10                    = TD3DRenderStateType(200);
  {$EXTERNALSYM D3DRS_WRAP10}
  D3DRS_WRAP11                    = TD3DRenderStateType(201);
  {$EXTERNALSYM D3DRS_WRAP11}
  D3DRS_WRAP12                    = TD3DRenderStateType(202);
  {$EXTERNALSYM D3DRS_WRAP12}
  D3DRS_WRAP13                    = TD3DRenderStateType(203);
  {$EXTERNALSYM D3DRS_WRAP13}
  D3DRS_WRAP14                    = TD3DRenderStateType(204);
  {$EXTERNALSYM D3DRS_WRAP14}
  D3DRS_WRAP15                    = TD3DRenderStateType(205);
  {$EXTERNALSYM D3DRS_WRAP15}
  D3DRS_SEPARATEALPHABLENDENABLE  = TD3DRenderStateType(206);  (* TRUE to enable a separate blending function for the alpha channel *)
  {$EXTERNALSYM D3DRS_SEPARATEALPHABLENDENABLE}
  D3DRS_SRCBLENDALPHA             = TD3DRenderStateType(207);  (* SRC blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE *)
  {$EXTERNALSYM D3DRS_SRCBLENDALPHA}
  D3DRS_DESTBLENDALPHA            = TD3DRenderStateType(208);  (* DST blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE *)
  {$EXTERNALSYM D3DRS_DESTBLENDALPHA}
  D3DRS_BLENDOPALPHA              = TD3DRenderStateType(209);  (* Blending operation for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE *)
  {$EXTERNALSYM D3DRS_BLENDOPALPHA}


  D3DRS_FORCE_DWORD               = TD3DRenderStateType($7fffffff); { force 32-bit size enum }
  {$EXTERNALSYM D3DRS_FORCE_DWORD}
{$ELSE}
type
  _D3DRENDERSTATETYPE = (
    D3DRS_ZENABLE                   = 7,    (* D3DZBUFFERTYPE (or TRUE/FALSE for legacy) *)
    D3DRS_FILLMODE                  = 8,    (* D3DFILLMODE *)
    D3DRS_SHADEMODE                 = 9,    (* D3DSHADEMODE *)
    D3DRS_ZWRITEENABLE              = 14,   (* TRUE to enable z writes *)
    D3DRS_ALPHATESTENABLE           = 15,   (* TRUE to enable alpha tests *)
    D3DRS_LASTPIXEL                 = 16,   (* TRUE for last-pixel on lines *)
    D3DRS_SRCBLEND                  = 19,   (* D3DBLEND *)
    D3DRS_DESTBLEND                 = 20,   (* D3DBLEND *)
    D3DRS_CULLMODE                  = 22,   (* D3DCULL *)
    D3DRS_ZFUNC                     = 23,   (* D3DCMPFUNC *)
    D3DRS_ALPHAREF                  = 24,   (* D3DFIXED *)
    D3DRS_ALPHAFUNC                 = 25,   (* D3DCMPFUNC *)
    D3DRS_DITHERENABLE              = 26,   (* TRUE to enable dithering *)
    D3DRS_ALPHABLENDENABLE          = 27,   (* TRUE to enable alpha blending *)
    D3DRS_FOGENABLE                 = 28,   (* TRUE to enable fog blending *)
    D3DRS_SPECULARENABLE            = 29,   (* TRUE to enable specular *)
    D3DRS_FOGCOLOR                  = 34,   (* D3DCOLOR *)
    D3DRS_FOGTABLEMODE              = 35,   (* D3DFOGMODE *)
    D3DRS_FOGSTART                  = 36,   (* Fog start (for both vertex and pixel fog) *)
    D3DRS_FOGEND                    = 37,   (* Fog end      *)
    D3DRS_FOGDENSITY                = 38,   (* Fog density  *)
    D3DRS_RANGEFOGENABLE            = 48,   (* Enables range-based fog *)
    D3DRS_STENCILENABLE             = 52,   (* BOOL enable/disable stenciling *)
    D3DRS_STENCILFAIL               = 53,   (* D3DSTENCILOP to do if stencil test fails *)
    D3DRS_STENCILZFAIL              = 54,   (* D3DSTENCILOP to do if stencil test passes and Z test fails *)
    D3DRS_STENCILPASS               = 55,   (* D3DSTENCILOP to do if both stencil and Z tests pass *)
    D3DRS_STENCILFUNC               = 56,   (* D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
    D3DRS_STENCILREF                = 57,   (* Reference value used in stencil test *)
    D3DRS_STENCILMASK               = 58,   (* Mask value used in stencil test *)
    D3DRS_STENCILWRITEMASK          = 59,   (* Write mask applied to values written to stencil buffer *)
    D3DRS_TEXTUREFACTOR             = 60,   (* D3DCOLOR used for multi-texture blend *)
    D3DRS_WRAP0                     = 128,  (* wrap for 1st texture coord. set *)
    D3DRS_WRAP1                     = 129,  (* wrap for 2nd texture coord. set *)
    D3DRS_WRAP2                     = 130,  (* wrap for 3rd texture coord. set *)
    D3DRS_WRAP3                     = 131,  (* wrap for 4th texture coord. set *)
    D3DRS_WRAP4                     = 132,  (* wrap for 5th texture coord. set *)
    D3DRS_WRAP5                     = 133,  (* wrap for 6th texture coord. set *)
    D3DRS_WRAP6                     = 134,  (* wrap for 7th texture coord. set *)
    D3DRS_WRAP7                     = 135,  (* wrap for 8th texture coord. set *)
    D3DRS_CLIPPING                  = 136,
    D3DRS_LIGHTING                  = 137,
    D3DRS_AMBIENT                   = 139,
    D3DRS_FOGVERTEXMODE             = 140,
    D3DRS_COLORVERTEX               = 141,
    D3DRS_LOCALVIEWER               = 142,
    D3DRS_NORMALIZENORMALS          = 143,
    D3DRS_DIFFUSEMATERIALSOURCE     = 145,
    D3DRS_SPECULARMATERIALSOURCE    = 146,
    D3DRS_AMBIENTMATERIALSOURCE     = 147,
    D3DRS_EMISSIVEMATERIALSOURCE    = 148,
    D3DRS_VERTEXBLEND               = 151,
    D3DRS_CLIPPLANEENABLE           = 152,
    D3DRS_POINTSIZE                 = 154,   (* float point size *)
    D3DRS_POINTSIZE_MIN             = 155,   (* float point size min threshold *)
    D3DRS_POINTSPRITEENABLE         = 156,   (* BOOL point texture coord control *)
    D3DRS_POINTSCALEENABLE          = 157,   (* BOOL point size scale enable *)
    D3DRS_POINTSCALE_A              = 158,   (* float point attenuation A value *)
    D3DRS_POINTSCALE_B              = 159,   (* float point attenuation B value *)
    D3DRS_POINTSCALE_C              = 160,   (* float point attenuation C value *)
    D3DRS_MULTISAMPLEANTIALIAS      = 161,  // BOOL - set to do FSAA with multisample buffer
    D3DRS_MULTISAMPLEMASK           = 162,  // DWORD - per-sample enable/disable
    D3DRS_PATCHEDGESTYLE            = 163,  // Sets whether patch edges will use float style tessellation
    D3DRS_DEBUGMONITORTOKEN         = 165,  // DEBUG ONLY - token to debug monitor
    D3DRS_POINTSIZE_MAX             = 166,   (* float point size max threshold *)
    D3DRS_INDEXEDVERTEXBLENDENABLE  = 167,
    D3DRS_COLORWRITEENABLE          = 168,  // per-channel write enable
    D3DRS_TWEENFACTOR               = 170,   // float tween factor
    D3DRS_BLENDOP                   = 171,   // D3DBLENDOP setting
    D3DRS_POSITIONDEGREE            = 172,   // NPatch position interpolation degree. D3DDEGREE_LINEAR or D3DDEGREE_CUBIC (default)
    D3DRS_NORMALDEGREE              = 173,   // NPatch normal interpolation degree. D3DDEGREE_LINEAR (default) or D3DDEGREE_QUADRATIC
    D3DRS_SCISSORTESTENABLE         = 174,
    D3DRS_SLOPESCALEDEPTHBIAS       = 175,
    D3DRS_ANTIALIASEDLINEENABLE     = 176,

    D3DRS_MINTESSELLATIONLEVEL      = 178,
    D3DRS_MAXTESSELLATIONLEVEL      = 179,
    D3DRS_ADAPTIVETESS_X            = 180,
    D3DRS_ADAPTIVETESS_Y            = 181,
    D3DRS_ADAPTIVETESS_Z            = 182,
    D3DRS_ADAPTIVETESS_W            = 183,
    D3DRS_ENABLEADAPTIVETESSELLATION = 184,
    D3DRS_TWOSIDEDSTENCILMODE       = 185,   (* BOOL enable/disable 2 sided stenciling *)
    D3DRS_CCW_STENCILFAIL           = 186,   (* D3DSTENCILOP to do if ccw stencil test fails *)
    D3DRS_CCW_STENCILZFAIL          = 187,   (* D3DSTENCILOP to do if ccw stencil test passes and Z test fails *)
    D3DRS_CCW_STENCILPASS           = 188,   (* D3DSTENCILOP to do if both ccw stencil and Z tests pass *)
    D3DRS_CCW_STENCILFUNC           = 189,   (* D3DCMPFUNC fn.  ccw Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
    D3DRS_COLORWRITEENABLE1         = 190,   (* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS *)
    D3DRS_COLORWRITEENABLE2         = 191,   (* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS *)
    D3DRS_COLORWRITEENABLE3         = 192,   (* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS *)
    D3DRS_BLENDFACTOR               = 193,   (* D3DCOLOR used for a constant blend factor during alpha blending for devices that support D3DPBLENDCAPS_BLENDFACTOR *)
    D3DRS_SRGBWRITEENABLE           = 194,   (* Enable rendertarget writes to be DE-linearized to SRGB (for formats that expose D3DUSAGE_QUERY_SRGBWRITE) *)
    D3DRS_DEPTHBIAS                 = 195,
    D3DRS_WRAP8                     = 198,   (* Additional wrap states for vs_3_0+ attributes with D3DDECLUSAGE_TEXCOORD *)
    D3DRS_WRAP9                     = 199,
    D3DRS_WRAP10                    = 200,
    D3DRS_WRAP11                    = 201,
    D3DRS_WRAP12                    = 202,
    D3DRS_WRAP13                    = 203,
    D3DRS_WRAP14                    = 204,
    D3DRS_WRAP15                    = 205,
    D3DRS_SEPARATEALPHABLENDENABLE  = 206,  (* TRUE to enable a separate blending function for the alpha channel *)
    D3DRS_SRCBLENDALPHA             = 207,  (* SRC blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE *)
    D3DRS_DESTBLENDALPHA            = 208,  (* DST blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE *)
    D3DRS_BLENDOPALPHA              = 209   (* Blending operation for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE *)
  );
  {$EXTERNALSYM _D3DRENDERSTATETYPE}
  D3DRENDERSTATETYPE = _D3DRENDERSTATETYPE;
  {$EXTERNALSYM D3DRENDERSTATETYPE}
  TD3DRenderStateType = _D3DRENDERSTATETYPE;
{$ENDIF}

const
  // Maximum number of simultaneous render targets D3D supports
  D3D_MAX_SIMULTANEOUS_RENDERTARGETS = 4;
  {$EXTERNALSYM D3D_MAX_SIMULTANEOUS_RENDERTARGETS}

type
  // Values for material source
  _D3DMATERIALCOLORSOURCE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DMATERIALCOLORSOURCE}
  D3DMATERIALCOLORSOURCE = _D3DMATERIALCOLORSOURCE;
  {$EXTERNALSYM D3DMATERIALCOLORSOURCE}
  TD3DMaterialSource = _D3DMATERIALCOLORSOURCE;

const
  D3DMCS_MATERIAL       = TD3DMaterialSource(0);         // Color from material is used
  {$EXTERNALSYM D3DMCS_MATERIAL}
  D3DMCS_COLOR1         = TD3DMaterialSource(1);         // Diffuse vertex color is used
  {$EXTERNALSYM D3DMCS_COLOR1}
  D3DMCS_COLOR2         = TD3DMaterialSource(2);         // Specular vertex color is used
  {$EXTERNALSYM D3DMCS_COLOR2}
  D3DMCS_FORCE_DWORD    = TD3DMaterialSource($7fffffff); // force 32-bit size enum
  {$EXTERNALSYM D3DMCS_FORCE_DWORD}

  // Bias to apply to the texture coordinate set to apply a wrap to.
  D3DRENDERSTATE_WRAPBIAS                = DWORD(128);
  {$EXTERNALSYM D3DRENDERSTATE_WRAPBIAS}

  { Flags to construct the WRAP render states }
  D3DWRAP_U             = $00000001;
  {$EXTERNALSYM D3DWRAP_U}
  D3DWRAP_V             = $00000002;
  {$EXTERNALSYM D3DWRAP_V}
  D3DWRAP_W             = $00000004;
  {$EXTERNALSYM D3DWRAP_W}

  { Flags to construct the WRAP render states for 1D thru 4D texture coordinates }
  D3DWRAPCOORD_0        = $00000001;    // same as D3DWRAP_U
  {$EXTERNALSYM D3DWRAPCOORD_0}
  D3DWRAPCOORD_1        = $00000002;    // same as D3DWRAP_V
  {$EXTERNALSYM D3DWRAPCOORD_1}
  D3DWRAPCOORD_2        = $00000004;    // same as D3DWRAP_W
  {$EXTERNALSYM D3DWRAPCOORD_2}
  D3DWRAPCOORD_3        = $00000008;
  {$EXTERNALSYM D3DWRAPCOORD_3}

  { Flags to construct D3DRS_COLORWRITEENABLE }
  D3DCOLORWRITEENABLE_RED       = (1 shl 0);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_RED}
  D3DCOLORWRITEENABLE_GREEN     = (1 shl 1);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_GREEN}
  D3DCOLORWRITEENABLE_BLUE      = (1 shl 2);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_BLUE}
  D3DCOLORWRITEENABLE_ALPHA     = (1 shl 3);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_ALPHA}

(*
 * State enumerants for per-stage processing of fixed function pixel processing
 * Two of these affect fixed function vertex processing as well: TEXTURETRANSFORMFLAGS and TEXCOORDINDEX.
 *)
{$IFNDEF SUPPORTS_EXPL_ENUMS}
type
  _D3DTEXTURESTAGESTATETYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DTEXTURESTAGESTATETYPE}
  D3DTEXTURESTAGESTATETYPE = _D3DTEXTURESTAGESTATETYPE;
  {$EXTERNALSYM D3DTEXTURESTAGESTATETYPE}
  TD3DTextureStageStateType = _D3DTEXTURESTAGESTATETYPE;

const
  D3DTSS_COLOROP        = TD3DTextureStageStateType( 1); { D3DTEXTUREOP - per-stage blending controls for color channels }
  {$EXTERNALSYM D3DTSS_COLOROP}
  D3DTSS_COLORARG1      = TD3DTextureStageStateType( 2); { D3DTA_* (texture arg) }
  {$EXTERNALSYM D3DTSS_COLORARG1}
  D3DTSS_COLORARG2      = TD3DTextureStageStateType( 3); { D3DTA_* (texture arg) }
  {$EXTERNALSYM D3DTSS_COLORARG2}
  D3DTSS_ALPHAOP        = TD3DTextureStageStateType( 4); { D3DTEXTUREOP - per-stage blending controls for alpha channel }
  {$EXTERNALSYM D3DTSS_ALPHAOP}
  D3DTSS_ALPHAARG1      = TD3DTextureStageStateType( 5); { D3DTA_* (texture arg) }
  {$EXTERNALSYM D3DTSS_ALPHAARG1}
  D3DTSS_ALPHAARG2      = TD3DTextureStageStateType( 6); { D3DTA_* (texture arg) }
  {$EXTERNALSYM D3DTSS_ALPHAARG2}
  D3DTSS_BUMPENVMAT00   = TD3DTextureStageStateType( 7); { float (bump mapping matrix) }
  {$EXTERNALSYM D3DTSS_BUMPENVMAT00}
  D3DTSS_BUMPENVMAT01   = TD3DTextureStageStateType( 8); { float (bump mapping matrix) }
  {$EXTERNALSYM D3DTSS_BUMPENVMAT01}
  D3DTSS_BUMPENVMAT10   = TD3DTextureStageStateType( 9); { float (bump mapping matrix) }
  {$EXTERNALSYM D3DTSS_BUMPENVMAT10}
  D3DTSS_BUMPENVMAT11   = TD3DTextureStageStateType(10); { float (bump mapping matrix) }
  {$EXTERNALSYM D3DTSS_BUMPENVMAT11}
  D3DTSS_TEXCOORDINDEX  = TD3DTextureStageStateType(11); { identifies which set of texture coordinates index this texture }
  {$EXTERNALSYM D3DTSS_TEXCOORDINDEX}
  D3DTSS_BUMPENVLSCALE  = TD3DTextureStageStateType(22); { float scale for bump map luminance }
  {$EXTERNALSYM D3DTSS_BUMPENVLSCALE}
  D3DTSS_BUMPENVLOFFSET = TD3DTextureStageStateType(23); { float offset for bump map luminance }
  {$EXTERNALSYM D3DTSS_BUMPENVLOFFSET}
  D3DTSS_TEXTURETRANSFORMFLAGS = TD3DTextureStageStateType(24); { D3DTEXTURETRANSFORMFLAGS controls texture transform }
  {$EXTERNALSYM D3DTSS_TEXTURETRANSFORMFLAGS}
  D3DTSS_COLORARG0      = TD3DTextureStageStateType(26); { D3DTA_* third arg for triadic ops }
  {$EXTERNALSYM D3DTSS_COLORARG0}
  D3DTSS_ALPHAARG0      = TD3DTextureStageStateType(27); { D3DTA_* third arg for triadic ops }
  {$EXTERNALSYM D3DTSS_ALPHAARG0}
  D3DTSS_RESULTARG      = TD3DTextureStageStateType(28); { D3DTA_* arg for result (CURRENT or TEMP) }
  {$EXTERNALSYM D3DTSS_RESULTARG}
  D3DTSS_CONSTANT       = TD3DTextureStageStateType(32); { Per-stage constant D3DTA_CONSTANT }
  {$EXTERNALSYM D3DTSS_CONSTANT}

  D3DTSS_FORCE_DWORD    = TD3DTextureStageStateType($7fffffff); { force 32-bit size enum }
  {$EXTERNALSYM D3DTSS_FORCE_DWORD}
{$ELSE}
type
  _D3DTEXTURESTAGESTATETYPE = (
    D3DTSS_COLOROP        =  1, { D3DTEXTUREOP - per-stage blending controls for color channels }
    D3DTSS_COLORARG1      =  2, { D3DTA_* (texture arg) }
    D3DTSS_COLORARG2      =  3, { D3DTA_* (texture arg) }
    D3DTSS_ALPHAOP        =  4, { D3DTEXTUREOP - per-stage blending controls for alpha channel }
    D3DTSS_ALPHAARG1      =  5, { D3DTA_* (texture arg) }
    D3DTSS_ALPHAARG2      =  6, { D3DTA_* (texture arg) }
    D3DTSS_BUMPENVMAT00   =  7, { float (bump mapping matrix) }
    D3DTSS_BUMPENVMAT01   =  8, { float (bump mapping matrix) }
    D3DTSS_BUMPENVMAT10   =  9, { float (bump mapping matrix) }
    D3DTSS_BUMPENVMAT11   = 10, { float (bump mapping matrix) }
    D3DTSS_TEXCOORDINDEX  = 11, { identifies which set of texture coordinates index this texture }
    D3DTSS_BUMPENVLSCALE  = 22, { float scale for bump map luminance }
    D3DTSS_BUMPENVLOFFSET = 23, { float offset for bump map luminance }
    D3DTSS_TEXTURETRANSFORMFLAGS = 24, { D3DTEXTURETRANSFORMFLAGS controls texture transform }
    D3DTSS_COLORARG0      = 26, { D3DTA_* third arg for triadic ops }
    D3DTSS_ALPHAARG0      = 27, { D3DTA_* third arg for triadic ops }
    D3DTSS_RESULTARG      = 28, { D3DTA_* arg for result (CURRENT or TEMP) }
    D3DTSS_CONSTANT       = 32  { Per-stage constant D3DTA_CONSTANT }
  );
  {$EXTERNALSYM _D3DTEXTURESTAGESTATETYPE}
  D3DTEXTURESTAGESTATETYPE = _D3DTEXTURESTAGESTATETYPE;
  {$EXTERNALSYM D3DTEXTURESTAGESTATETYPE}
  TD3DTextureStageStateType = _D3DTEXTURESTAGESTATETYPE;
{$ENDIF}

type
(*
 * State enumerants for per-sampler texture processing.
 *)
  _D3DSAMPLERSTATETYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DSAMP_invalid_0     {= 0},
    D3DSAMP_ADDRESSU      {= 1},  { D3DTEXTUREADDRESS for U coordinate }
    D3DSAMP_ADDRESSV      {= 2},  { D3DTEXTUREADDRESS for V coordinate }
    D3DSAMP_ADDRESSW      {= 3},  { D3DTEXTUREADDRESS for W coordinate }
    D3DSAMP_BORDERCOLOR   {= 4},  { D3DCOLOR }
    D3DSAMP_MAGFILTER     {= 5},  { D3DTEXTUREFILTER filter to use for magnification }
    D3DSAMP_MINFILTER     {= 6},  { D3DTEXTUREFILTER filter to use for minification }
    D3DSAMP_MIPFILTER     {= 7},  { D3DTEXTUREFILTER filter to use between mipmaps during minification }
    D3DSAMP_MIPMAPLODBIAS {= 8},  { float Mipmap LOD bias }
    D3DSAMP_MAXMIPLEVEL   {= 9},  { DWORD 0..(n-1) LOD index of largest map to use (0 == largest) }
    D3DSAMP_MAXANISOTROPY {= 10}, { DWORD maximum anisotropy }
    D3DSAMP_SRGBTEXTURE   {= 11}, { Default = 0 (which means Gamma 1.0,
                                   no correction required.) else correct for
                                   Gamma = 2.2 }
    D3DSAMP_ELEMENTINDEX  {= 12}, { When multi-element texture is assigned to sampler, this
                                    indicates which element index to use.  Default = 0.  }
    D3DSAMP_DMAPOFFSET    {= 13}  { Offset in vertices in the pre-sampled displacement map.
                                    Only valid for D3DDMAPSAMPLER sampler  }
  {$ELSE}
    D3DSAMP_ADDRESSU       = 1,  { D3DTEXTUREADDRESS for U coordinate }
    D3DSAMP_ADDRESSV       = 2,  { D3DTEXTUREADDRESS for V coordinate }
    D3DSAMP_ADDRESSW       = 3,  { D3DTEXTUREADDRESS for W coordinate }
    D3DSAMP_BORDERCOLOR    = 4,  { D3DCOLOR }
    D3DSAMP_MAGFILTER      = 5,  { D3DTEXTUREFILTER filter to use for magnification }
    D3DSAMP_MINFILTER      = 6,  { D3DTEXTUREFILTER filter to use for minification }
    D3DSAMP_MIPFILTER      = 7,  { D3DTEXTUREFILTER filter to use between mipmaps during minification }
    D3DSAMP_MIPMAPLODBIAS  = 8,  { float Mipmap LOD bias }
    D3DSAMP_MAXMIPLEVEL    = 9,  { DWORD 0..(n-1) LOD index of largest map to use (0 == largest) }
    D3DSAMP_MAXANISOTROPY  = 10, { DWORD maximum anisotropy }
    D3DSAMP_SRGBTEXTURE    = 11, { Default = 0 (which means Gamma 1.0,
                                  no correction required.) else correct for
                                  Gamma = 2.2 }
    D3DSAMP_ELEMENTINDEX   = 12, { When multi-element texture is assigned to sampler, this
                                   indicates which element index to use.  Default = 0.  }
    D3DSAMP_DMAPOFFSET     = 13  { Offset in vertices in the pre-sampled displacement map.
                                   Only valid for D3DDMAPSAMPLER sampler  }
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DSAMPLERSTATETYPE}
  D3DSAMPLERSTATETYPE = _D3DSAMPLERSTATETYPE;
  {$EXTERNALSYM D3DSAMPLERSTATETYPE}
  TD3DSamplerStateType = _D3DSAMPLERSTATETYPE;

const
  { Special sampler which is used in the tesselator }
  D3DDMAPSAMPLER = 256;
  {$EXTERNALSYM D3DDMAPSAMPLER}

  // Samplers used in vertex shaders
  D3DVERTEXTEXTURESAMPLER0 = (D3DDMAPSAMPLER+1);
  {$EXTERNALSYM D3DVERTEXTEXTURESAMPLER0}
  D3DVERTEXTEXTURESAMPLER1 = (D3DDMAPSAMPLER+2);
  {$EXTERNALSYM D3DVERTEXTEXTURESAMPLER1}
  D3DVERTEXTEXTURESAMPLER2 = (D3DDMAPSAMPLER+3);
  {$EXTERNALSYM D3DVERTEXTEXTURESAMPLER2}
  D3DVERTEXTEXTURESAMPLER3 = (D3DDMAPSAMPLER+4);
  {$EXTERNALSYM D3DVERTEXTEXTURESAMPLER3}

  // Values, used with D3DTSS_TEXCOORDINDEX, to specify that the vertex data(position
  // and normal in the camera space) should be taken as texture coordinates
  // Low 16 bits are used to specify texture coordinate index, to take the WRAP mode from
  //
  D3DTSS_TCI_PASSTHRU                           = $00000000;
  {$EXTERNALSYM D3DTSS_TCI_PASSTHRU}
  D3DTSS_TCI_CAMERASPACENORMAL                  = $00010000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACENORMAL}
  D3DTSS_TCI_CAMERASPACEPOSITION                = $00020000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACEPOSITION}
  D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR        = $00030000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR}
  D3DTSS_TCI_SPHEREMAP                          = $00040000;
  {$EXTERNALSYM D3DTSS_TCI_SPHEREMAP}

(*
 * Enumerations for COLOROP and ALPHAOP texture blending operations set in
 * texture processing stage controls in D3DTSS.
 *)
type
  _D3DTEXTUREOP = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DTEXTUREOP}
  D3DTEXTUREOP = _D3DTEXTUREOP;
  {$EXTERNALSYM D3DTEXTUREOP}
  TD3DTextureOp = _D3DTEXTUREOP;

const
  // Control
  D3DTOP_DISABLE              = 1;      // disables stage
  {$EXTERNALSYM D3DTOP_DISABLE}
  D3DTOP_SELECTARG1           = 2;      // the default
  {$EXTERNALSYM D3DTOP_SELECTARG1}
  D3DTOP_SELECTARG2           = 3;
  {$EXTERNALSYM D3DTOP_SELECTARG2}

  // Modulate
  D3DTOP_MODULATE             = 4;      // multiply args together
  {$EXTERNALSYM D3DTOP_MODULATE}
  D3DTOP_MODULATE2X           = 5;      // multiply and  1 bit
  {$EXTERNALSYM D3DTOP_MODULATE2X}
  D3DTOP_MODULATE4X           = 6;      // multiply and  2 bits
  {$EXTERNALSYM D3DTOP_MODULATE4X}

  // Add
  D3DTOP_ADD                  =  7;   // add arguments together
  {$EXTERNALSYM D3DTOP_ADD}
  D3DTOP_ADDSIGNED            =  8;   // add with -0.5 bias
  {$EXTERNALSYM D3DTOP_ADDSIGNED}
  D3DTOP_ADDSIGNED2X          =  9;   // as above but left  1 bit
  {$EXTERNALSYM D3DTOP_ADDSIGNED2X}
  D3DTOP_SUBTRACT             = 10;   // Arg1 - Arg2, with no saturation
  {$EXTERNALSYM D3DTOP_SUBTRACT}
  D3DTOP_ADDSMOOTH            = 11;   // add 2 args, subtract product
                                      // Arg1 + Arg2 - Arg1*Arg2
                                      // = Arg1 + (1-Arg1)*Arg2
  {$EXTERNALSYM D3DTOP_ADDSMOOTH}

  // Linear alpha blend: Arg1*(Alpha) + Arg2*(1-Alpha)
  D3DTOP_BLENDDIFFUSEALPHA    = 12; // iterated alpha
  {$EXTERNALSYM D3DTOP_BLENDDIFFUSEALPHA}
  D3DTOP_BLENDTEXTUREALPHA    = 13; // texture alpha
  {$EXTERNALSYM D3DTOP_BLENDTEXTUREALPHA}
  D3DTOP_BLENDFACTORALPHA     = 14; // alpha from D3DRS_TEXTUREFACTOR
  {$EXTERNALSYM D3DTOP_BLENDFACTORALPHA}

  // Linear alpha blend with pre-multiplied arg1 input: Arg1 + Arg2*(1-Alpha)
  D3DTOP_BLENDTEXTUREALPHAPM  = 15; // texture alpha
  {$EXTERNALSYM D3DTOP_BLENDTEXTUREALPHAPM}
  D3DTOP_BLENDCURRENTALPHA    = 16; // by alpha of current color
  {$EXTERNALSYM D3DTOP_BLENDCURRENTALPHA}

  // Specular mapping
  D3DTOP_PREMODULATE            = 17;     // modulate with next texture before use
  {$EXTERNALSYM D3DTOP_PREMODULATE}
  D3DTOP_MODULATEALPHA_ADDCOLOR = 18;     // Arg1.RGB + Arg1.A*Arg2.RGB
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATEALPHA_ADDCOLOR}
  D3DTOP_MODULATECOLOR_ADDALPHA = 19;     // Arg1.RGB*Arg2.RGB + Arg1.A
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATECOLOR_ADDALPHA}
  D3DTOP_MODULATEINVALPHA_ADDCOLOR = 20;  // (1-Arg1.A)*Arg2.RGB + Arg1.RGB
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATEINVALPHA_ADDCOLOR}
  D3DTOP_MODULATEINVCOLOR_ADDALPHA = 21;  // (1-Arg1.RGB)*Arg2.RGB + Arg1.A
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATEINVCOLOR_ADDALPHA}

  // Bump mapping
  D3DTOP_BUMPENVMAP           = 22; // per pixel env map perturbation
  {$EXTERNALSYM D3DTOP_BUMPENVMAP}
  D3DTOP_BUMPENVMAPLUMINANCE  = 23; // with luminance channel
  {$EXTERNALSYM D3DTOP_BUMPENVMAPLUMINANCE}

  // This can do either diffuse or specular bump mapping with correct input.
  // Performs the function (Arg1.R*Arg2.R + Arg1.G*Arg2.G + Arg1.B*Arg2.B)
  // where each component has been scaled and offset to make it signed.
  // The result is replicated into all four (including alpha) channels.
  // This is a valid COLOROP only.
  D3DTOP_DOTPRODUCT3          = 24;
  {$EXTERNALSYM D3DTOP_DOTPRODUCT3}

  // Triadic ops
  D3DTOP_MULTIPLYADD          = 25; // Arg0 + Arg1*Arg2
  {$EXTERNALSYM D3DTOP_MULTIPLYADD}
  D3DTOP_LERP                 = 26; // (Arg0)*Arg1 + (1-Arg0)*Arg2
  {$EXTERNALSYM D3DTOP_LERP}

(*
 * Values for COLORARG0,1,2, ALPHAARG0,1,2, and RESULTARG texture blending
 * operations set in texture processing stage controls in D3DRENDERSTATE.
 *)
const
  D3DTA_SELECTMASK        = $0000000f;  // mask for arg selector
  {$EXTERNALSYM D3DTA_SELECTMASK}
  D3DTA_DIFFUSE           = $00000000;  // select diffuse color (read only)
  {$EXTERNALSYM D3DTA_DIFFUSE}
  D3DTA_CURRENT           = $00000001;  // select stage destination register (read/write)
  {$EXTERNALSYM D3DTA_CURRENT}
  D3DTA_TEXTURE           = $00000002;  // select texture color (read only)
  {$EXTERNALSYM D3DTA_TEXTURE}
  D3DTA_TFACTOR           = $00000003;  // select D3DRS_TEXTUREFACTOR (read only)
  {$EXTERNALSYM D3DTA_TFACTOR}
  D3DTA_SPECULAR          = $00000004;  // select specular color (read only)
  {$EXTERNALSYM D3DTA_SPECULAR}
  D3DTA_TEMP              = $00000005;  // select temporary register color (read/write)
  {$EXTERNALSYM D3DTA_TEMP}
  D3DTA_CONSTANT          = $00000006;  // select texture stage constant
  {$EXTERNALSYM D3DTA_CONSTANT}
  D3DTA_COMPLEMENT        = $00000010;  // take 1.0 - x (read modifier)
  {$EXTERNALSYM D3DTA_COMPLEMENT}
  D3DTA_ALPHAREPLICATE    = $00000020;  // replicate alpha to color components (read modifier)
  {$EXTERNALSYM D3DTA_ALPHAREPLICATE}

type
  //
  // Values for D3DSAMP_***FILTER texture stage states
  //
  _D3DTEXTUREFILTERTYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DTEXTUREFILTERTYPE}
  D3DTEXTUREFILTERTYPE = _D3DTEXTUREFILTERTYPE;
  {$EXTERNALSYM D3DTEXTUREFILTERTYPE}
  TD3DTextureFilterType = _D3DTEXTUREFILTERTYPE;

const
  D3DTEXF_NONE            = 0;    // filtering disabled (valid for mip filter only)
  {$EXTERNALSYM D3DTEXF_NONE}
  D3DTEXF_POINT           = 1;    // nearest
  {$EXTERNALSYM D3DTEXF_POINT}
  D3DTEXF_LINEAR          = 2;    // linear interpolation
  {$EXTERNALSYM D3DTEXF_LINEAR}
  D3DTEXF_ANISOTROPIC     = 3;    // anisotropic
  {$EXTERNALSYM D3DTEXF_ANISOTROPIC}
  D3DTEXF_PYRAMIDALQUAD   = 6;    // 4-sample tent
  {$EXTERNALSYM D3DTEXF_PYRAMIDALQUAD}
  D3DTEXF_GAUSSIANQUAD    = 7;    // 4-sample gaussian
  {$EXTERNALSYM D3DTEXF_GAUSSIANQUAD}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DTEXF_CONVOLUTIONMONO = 8;    // Convolution filter for monochrome textures
  {$EXTERNALSYM D3DTEXF_CONVOLUTIONMONO}
{$ENDIF}

const
  { Bits for Flags in ProcessVertices call }
  D3DPV_DONOTCOPYDATA        = (1 shl 0);
  {$EXTERNALSYM D3DPV_DONOTCOPYDATA}

//-------------------------------------------------------------------

  // Flexible vertex format bits
  //
  D3DFVF_RESERVED0        = $001;
  {$EXTERNALSYM D3DFVF_RESERVED0}
  D3DFVF_POSITION_MASK    = $400E;
  {$EXTERNALSYM D3DFVF_POSITION_MASK}
  D3DFVF_XYZ              = $002;
  {$EXTERNALSYM D3DFVF_XYZ}
  D3DFVF_XYZRHW           = $004;
  {$EXTERNALSYM D3DFVF_XYZRHW}
  D3DFVF_XYZB1            = $006;
  {$EXTERNALSYM D3DFVF_XYZB1}
  D3DFVF_XYZB2            = $008;
  {$EXTERNALSYM D3DFVF_XYZB2}
  D3DFVF_XYZB3            = $00a;
  {$EXTERNALSYM D3DFVF_XYZB3}
  D3DFVF_XYZB4            = $00c;
  {$EXTERNALSYM D3DFVF_XYZB4}
  D3DFVF_XYZB5            = $00e;
  {$EXTERNALSYM D3DFVF_XYZB5}
  D3DFVF_XYZW             = $4002;
  {$EXTERNALSYM D3DFVF_XYZW}

  D3DFVF_NORMAL           = $010;
  {$EXTERNALSYM D3DFVF_NORMAL}
  D3DFVF_PSIZE            = $020;
  {$EXTERNALSYM D3DFVF_PSIZE}
  D3DFVF_DIFFUSE          = $040;
  {$EXTERNALSYM D3DFVF_DIFFUSE}
  D3DFVF_SPECULAR         = $080;
  {$EXTERNALSYM D3DFVF_SPECULAR}

  D3DFVF_TEXCOUNT_MASK    = $f00;
  {$EXTERNALSYM D3DFVF_TEXCOUNT_MASK}
  D3DFVF_TEXCOUNT_SHIFT   = 8;
  {$EXTERNALSYM D3DFVF_TEXCOUNT_SHIFT}
  D3DFVF_TEX0             = $000;
  {$EXTERNALSYM D3DFVF_TEX0}
  D3DFVF_TEX1             = $100;
  {$EXTERNALSYM D3DFVF_TEX1}
  D3DFVF_TEX2             = $200;
  {$EXTERNALSYM D3DFVF_TEX2}
  D3DFVF_TEX3             = $300;
  {$EXTERNALSYM D3DFVF_TEX3}
  D3DFVF_TEX4             = $400;
  {$EXTERNALSYM D3DFVF_TEX4}
  D3DFVF_TEX5             = $500;
  {$EXTERNALSYM D3DFVF_TEX5}
  D3DFVF_TEX6             = $600;
  {$EXTERNALSYM D3DFVF_TEX6}
  D3DFVF_TEX7             = $700;
  {$EXTERNALSYM D3DFVF_TEX7}
  D3DFVF_TEX8             = $800;
  {$EXTERNALSYM D3DFVF_TEX8}

  D3DFVF_LASTBETA_UBYTE4   = $1000;
  {$EXTERNALSYM D3DFVF_LASTBETA_UBYTE4}
  D3DFVF_LASTBETA_D3DCOLOR = $8000;
  {$EXTERNALSYM D3DFVF_LASTBETA_D3DCOLOR}

  D3DFVF_RESERVED2         = $6000;  // 2 reserved bits
  {$EXTERNALSYM D3DFVF_RESERVED2}

//---------------------------------------------------------------------
// Vertex Shaders
//

// Vertex shader declaration

// Forces TD3DDeclUsage, TD3DDeclMethod, TD3DDeclType be 1 byte enums
{$MINENUMSIZE 1}

type
  // Vertex element semantics
  //
  _D3DDECLUSAGE = (
    D3DDECLUSAGE_POSITION,      // = 0
    D3DDECLUSAGE_BLENDWEIGHT,   // 1
    D3DDECLUSAGE_BLENDINDICES,  // 2
    D3DDECLUSAGE_NORMAL,        // 3
    D3DDECLUSAGE_PSIZE,         // 4
    D3DDECLUSAGE_TEXCOORD,      // 5
    D3DDECLUSAGE_TANGENT,       // 6
    D3DDECLUSAGE_BINORMAL,      // 7
    D3DDECLUSAGE_TESSFACTOR,    // 8
    D3DDECLUSAGE_POSITIONT,     // 9
    D3DDECLUSAGE_COLOR,         // 10
    D3DDECLUSAGE_FOG,           // 11
    D3DDECLUSAGE_DEPTH,         // 12
    D3DDECLUSAGE_SAMPLE         // 13
  );
  {$EXTERNALSYM _D3DDECLUSAGE}
  D3DDECLUSAGE = _D3DDECLUSAGE;
  {$EXTERNALSYM D3DDECLUSAGE}
  TD3DDeclUsage = _D3DDECLUSAGE;

const
  MAXD3DDECLUSAGE         = DWORD(D3DDECLUSAGE_SAMPLE);
  {$EXTERNALSYM MAXD3DDECLUSAGE}
  MAXD3DDECLUSAGEINDEX    = 15;
  {$EXTERNALSYM MAXD3DDECLUSAGEINDEX}
  MAXD3DDECLLENGTH        = 64; // does not include "end" marker vertex element
  {$EXTERNALSYM MAXD3DDECLLENGTH}

type
  _D3DDECLMETHOD = (
    D3DDECLMETHOD_DEFAULT,    // = 0,
    D3DDECLMETHOD_PARTIALU,
    D3DDECLMETHOD_PARTIALV,
    D3DDECLMETHOD_CROSSUV,    // Normal
    D3DDECLMETHOD_UV,
    D3DDECLMETHOD_LOOKUP,               // Lookup a displacement map
    D3DDECLMETHOD_LOOKUPPRESAMPLED      // Lookup a pre-sampled displacement map
  );
  {$EXTERNALSYM _D3DDECLMETHOD}
  D3DDECLMETHOD = _D3DDECLMETHOD;
  {$EXTERNALSYM D3DDECLMETHOD}
  TD3DDeclMethod = _D3DDECLMETHOD;

const
  MAXD3DDECLMETHOD = DWORD(D3DDECLMETHOD_LOOKUPPRESAMPLED);
  {$EXTERNALSYM MAXD3DDECLMETHOD}

type
  // Declarations for _Type fields
  //
  _D3DDECLTYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DDECLTYPE_FLOAT1   {=  0}, // 1D float expanded to (value, 0., 0., 1.)
    D3DDECLTYPE_FLOAT2   {=  1}, // 2D float expanded to (value, value, 0., 1.)
    D3DDECLTYPE_FLOAT3   {=  2}, // 3D float expanded to (value, value, value, 1.)
    D3DDECLTYPE_FLOAT4   {=  3}, // 4D float
    D3DDECLTYPE_D3DCOLOR {=  4}, // 4D packed unsigned bytes mapped to 0. to 1. range
                                 // Input is in D3DCOLOR format (ARGB) expanded to (R, G, B, A)
    D3DDECLTYPE_UBYTE4   {=  5}, // 4D unsigned byte
    D3DDECLTYPE_SHORT2   {=  6}, // 2D signed short expanded to (value, value, 0., 1.)
    D3DDECLTYPE_SHORT4   {=  7}, // 4D signed short

  // The following types are valid only with vertex shaders >= 2.0


    D3DDECLTYPE_UBYTE4N  {=  8}, // Each of 4 bytes is normalized by dividing to 255.0
    D3DDECLTYPE_SHORT2N  {=  9}, // 2D signed short normalized (v[0]/32767.0,v[1]/32767.0,0,1)
    D3DDECLTYPE_SHORT4N  {= 10}, // 4D signed short normalized (v[0]/32767.0,v[1]/32767.0,v[2]/32767.0,v[3]/32767.0)
    D3DDECLTYPE_USHORT2N {= 11}, // 2D unsigned short normalized (v[0]/65535.0,v[1]/65535.0,0,1)
    D3DDECLTYPE_USHORT4N {= 12}, // 4D unsigned short normalized (v[0]/65535.0,v[1]/65535.0,v[2]/65535.0,v[3]/65535.0)
    D3DDECLTYPE_UDEC3    {= 13}, // 3D unsigned 10 10 10 format expanded to (value, value, value, 1)
    D3DDECLTYPE_DEC3N    {= 14}, // 3D signed 10 10 10 format normalized and expanded to (v[0]/511.0, v[1]/511.0, v[2]/511.0, 1)
    D3DDECLTYPE_FLOAT16_2{= 15}, // Two 16-bit floating point values, expanded to (value, value, 0, 1)
    D3DDECLTYPE_FLOAT16_4{= 16}, // Four 16-bit floating point values
    D3DDECLTYPE_UNUSED   {= 17}  // When the type field in a decl is unused.
  {$ELSE}
    D3DDECLTYPE_FLOAT1    =  0,  // 1D float expanded to (value, 0., 0., 1.)
    D3DDECLTYPE_FLOAT2    =  1,  // 2D float expanded to (value, value, 0., 1.)
    D3DDECLTYPE_FLOAT3    =  2,  // 3D float expanded to (value, value, value, 1.)
    D3DDECLTYPE_FLOAT4    =  3,  // 4D float
    D3DDECLTYPE_D3DCOLOR  =  4,  // 4D packed unsigned bytes mapped to 0. to 1. range
                                 // Input is in D3DCOLOR format (ARGB) expanded to (R, G, B, A)
    D3DDECLTYPE_UBYTE4    =  5,  // 4D unsigned byte
    D3DDECLTYPE_SHORT2    =  6,  // 2D signed short expanded to (value, value, 0., 1.)
    D3DDECLTYPE_SHORT4    =  7,  // 4D signed short

  // The following types are valid only with vertex shaders >= 2.0


    D3DDECLTYPE_UBYTE4N   =  8,  // Each of 4 bytes is normalized by dividing to 255.0
    D3DDECLTYPE_SHORT2N   =  9,  // 2D signed short normalized (v[0]/32767.0,v[1]/32767.0,0,1)
    D3DDECLTYPE_SHORT4N   = 10,  // 4D signed short normalized (v[0]/32767.0,v[1]/32767.0,v[2]/32767.0,v[3]/32767.0)
    D3DDECLTYPE_USHORT2N  = 11,  // 2D unsigned short normalized (v[0]/65535.0,v[1]/65535.0,0,1)
    D3DDECLTYPE_USHORT4N  = 12,  // 4D unsigned short normalized (v[0]/65535.0,v[1]/65535.0,v[2]/65535.0,v[3]/65535.0)
    D3DDECLTYPE_UDEC3     = 13,  // 3D unsigned 10 10 10 format expanded to (value, value, value, 1)
    D3DDECLTYPE_DEC3N     = 14,  // 3D signed 10 10 10 format normalized and expanded to (v[0]/511.0, v[1]/511.0, v[2]/511.0, 1)
    D3DDECLTYPE_FLOAT16_2 = 15,  // Two 16-bit floating point values, expanded to (value, value, 0, 1)
    D3DDECLTYPE_FLOAT16_4 = 16,  // Four 16-bit floating point values
    D3DDECLTYPE_UNUSED    = 17   // When the type field in a decl is unused.
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DDECLTYPE}
  D3DDECLTYPE = _D3DDECLTYPE;
  {$EXTERNALSYM D3DDECLTYPE}
  TD3DDeclType = _D3DDECLTYPE;

// Restores enums to be 4 byte in size
{$MINENUMSIZE 4}

const
  MAXD3DDECLTYPE      = DWORD(D3DDECLTYPE_UNUSED);
  {$EXTERNALSYM MAXD3DDECLTYPE}

type
  PD3DVertexElement9 = ^TD3DVertexElement9;
  _D3DVERTEXELEMENT9 = packed record
    Stream:     Word;                 // Stream index
    Offset:     Word;                 // Offset in the stream in bytes
    _Type:      TD3DDeclType{Byte};   // Data type
    Method:     TD3DDeclMethod{Byte}; // Processing method
    Usage:      TD3DDeclUsage{Byte};  // Semantics
    UsageIndex: Byte;                 // Semantic index
  end;
  {$EXTERNALSYM _D3DVERTEXELEMENT9}
  D3DVERTEXELEMENT9 = _D3DVERTEXELEMENT9;
  {$EXTERNALSYM D3DVERTEXELEMENT9}
  TD3DVertexElement9 = _D3DVERTEXELEMENT9;

// This is used to initialize the last vertex element in a vertex declaration
// array
//
const
  D3DDECL_END: TD3DVertexElement9 = (Stream     : $FF;
                                     Offset     : 0;
                                     _Type      : D3DDECLTYPE_UNUSED;
                                     Method     : TD3DDeclMethod(0);
                                     Usage      : TD3DDeclUsage(0);
                                     UsageIndex : 0);
  {$EXTERNALSYM D3DDECL_END}

// Maximum supported number of texture coordinate sets
const
  D3DDP_MAXTEXCOORD   = 8;
  {$EXTERNALSYM D3DDP_MAXTEXCOORD}

//---------------------------------------------------------------------
// Values for IDirect3DDevice9::SetStreamSourceFreq's Setting parameter
//---------------------------------------------------------------------
  D3DSTREAMSOURCE_INDEXEDDATA  = LongWord(1 shl 30);
  {$EXTERNALSYM D3DSTREAMSOURCE_INDEXEDDATA}
  D3DSTREAMSOURCE_INSTANCEDATA = LongWord(2 shl 30);
  {$EXTERNALSYM D3DSTREAMSOURCE_INSTANCEDATA}


//---------------------------------------------------------------------
//
// The internal format of Pixel Shader (PS) & Vertex Shader (VS)
// Instruction Tokens is defined in the Direct3D Device Driver Kit
//
//---------------------------------------------------------------------

  //
  // Instruction Token Bit Definitions
  //
  D3DSI_OPCODE_MASK       = $0000FFFF;
  {$EXTERNALSYM D3DSI_OPCODE_MASK}

  D3DSI_INSTLENGTH_MASK   = $0F000000;
  {$EXTERNALSYM D3DSI_INSTLENGTH_MASK}
  D3DSI_INSTLENGTH_SHIFT  = 24;
  {$EXTERNALSYM D3DSI_INSTLENGTH_SHIFT}

type 
  _D3DSHADER_INSTRUCTION_OPCODE_TYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DSHADER_INSTRUCTION_OPCODE_TYPE}
  D3DSHADER_INSTRUCTION_OPCODE_TYPE = _D3DSHADER_INSTRUCTION_OPCODE_TYPE;
  {$EXTERNALSYM D3DSHADER_INSTRUCTION_OPCODE_TYPE}
  TD3DShaderInstructionOpcodeType = _D3DSHADER_INSTRUCTION_OPCODE_TYPE;

const
  D3DSIO_NOP          = 0;
  {$EXTERNALSYM D3DSIO_NOP}
  D3DSIO_MOV          = 1;
  {$EXTERNALSYM D3DSIO_MOV}
  D3DSIO_ADD          = 2;
  {$EXTERNALSYM D3DSIO_ADD}
  D3DSIO_SUB          = 3;
  {$EXTERNALSYM D3DSIO_SUB}
  D3DSIO_MAD          = 4;
  {$EXTERNALSYM D3DSIO_MAD}
  D3DSIO_MUL          = 5;
  {$EXTERNALSYM D3DSIO_MUL}
  D3DSIO_RCP          = 6;
  {$EXTERNALSYM D3DSIO_RCP}
  D3DSIO_RSQ          = 7;
  {$EXTERNALSYM D3DSIO_RSQ}
  D3DSIO_DP3          = 8;
  {$EXTERNALSYM D3DSIO_DP3}
  D3DSIO_DP4          = 9;
  {$EXTERNALSYM D3DSIO_DP4}
  D3DSIO_MIN          = 10;
  {$EXTERNALSYM D3DSIO_MIN}
  D3DSIO_MAX          = 11;
  {$EXTERNALSYM D3DSIO_MAX}
  D3DSIO_SLT          = 12;
  {$EXTERNALSYM D3DSIO_SLT}
  D3DSIO_SGE          = 13;
  {$EXTERNALSYM D3DSIO_SGE}
  D3DSIO_EXP          = 14;
  {$EXTERNALSYM D3DSIO_EXP}
  D3DSIO_LOG          = 15;
  {$EXTERNALSYM D3DSIO_LOG}
  D3DSIO_LIT          = 16;
  {$EXTERNALSYM D3DSIO_LIT}
  D3DSIO_DST          = 17;
  {$EXTERNALSYM D3DSIO_DST}
  D3DSIO_LRP          = 18;
  {$EXTERNALSYM D3DSIO_LRP}
  D3DSIO_FRC          = 19;
  {$EXTERNALSYM D3DSIO_FRC}
  D3DSIO_M4x4         = 20;
  {$EXTERNALSYM D3DSIO_M4x4}
  D3DSIO_M4x3         = 21;
  {$EXTERNALSYM D3DSIO_M4x3}
  D3DSIO_M3x4         = 22;
  {$EXTERNALSYM D3DSIO_M3x4}
  D3DSIO_M3x3         = 23;
  {$EXTERNALSYM D3DSIO_M3x3}
  D3DSIO_M3x2         = 24;
  {$EXTERNALSYM D3DSIO_M3x2}
  D3DSIO_CALL         = 25;
  {$EXTERNALSYM D3DSIO_CALL}
  D3DSIO_CALLNZ       = 26;
  {$EXTERNALSYM D3DSIO_CALLNZ}
  D3DSIO_LOOP         = 27;
  {$EXTERNALSYM D3DSIO_LOOP}
  D3DSIO_RET          = 28;
  {$EXTERNALSYM D3DSIO_RET}
  D3DSIO_ENDLOOP      = 29;
  {$EXTERNALSYM D3DSIO_ENDLOOP}
  D3DSIO_LABEL        = 30;
  {$EXTERNALSYM D3DSIO_LABEL}
  D3DSIO_DCL          = 31;
  {$EXTERNALSYM D3DSIO_DCL}
  D3DSIO_POW          = 32;
  {$EXTERNALSYM D3DSIO_POW}
  D3DSIO_CRS          = 33;
  {$EXTERNALSYM D3DSIO_CRS}
  D3DSIO_SGN          = 34;
  {$EXTERNALSYM D3DSIO_SGN}
  D3DSIO_ABS          = 35;
  {$EXTERNALSYM D3DSIO_ABS}
  D3DSIO_NRM          = 36;
  {$EXTERNALSYM D3DSIO_NRM}
  D3DSIO_SINCOS       = 37;
  {$EXTERNALSYM D3DSIO_SINCOS}
  D3DSIO_REP          = 38;
  {$EXTERNALSYM D3DSIO_REP}
  D3DSIO_ENDREP       = 39;
  {$EXTERNALSYM D3DSIO_ENDREP}
  D3DSIO_IF           = 40;
  {$EXTERNALSYM D3DSIO_IF}
  D3DSIO_IFC          = 41;
  {$EXTERNALSYM D3DSIO_IFC}
  D3DSIO_ELSE         = 42;
  {$EXTERNALSYM D3DSIO_ELSE}
  D3DSIO_ENDIF        = 43;
  {$EXTERNALSYM D3DSIO_ENDIF}
  D3DSIO_BREAK        = 44;
  {$EXTERNALSYM D3DSIO_BREAK}
  D3DSIO_BREAKC       = 45;
  {$EXTERNALSYM D3DSIO_BREAKC}
  D3DSIO_MOVA         = 46;
  {$EXTERNALSYM D3DSIO_MOVA}
  D3DSIO_DEFB         = 47;
  {$EXTERNALSYM D3DSIO_DEFB}
  D3DSIO_DEFI         = 48;
  {$EXTERNALSYM D3DSIO_DEFI}

  D3DSIO_TEXCOORD     = 64;
  {$EXTERNALSYM D3DSIO_TEXCOORD}
  D3DSIO_TEXKILL      = 65;
  {$EXTERNALSYM D3DSIO_TEXKILL}
  D3DSIO_TEX          = 66;
  {$EXTERNALSYM D3DSIO_TEX}
  D3DSIO_TEXBEM       = 67;
  {$EXTERNALSYM D3DSIO_TEXBEM}
  D3DSIO_TEXBEML      = 68;
  {$EXTERNALSYM D3DSIO_TEXBEML}
  D3DSIO_TEXREG2AR    = 69;
  {$EXTERNALSYM D3DSIO_TEXREG2AR}
  D3DSIO_TEXREG2GB    = 70;
  {$EXTERNALSYM D3DSIO_TEXREG2GB}
  D3DSIO_TEXM3x2PAD   = 71;
  {$EXTERNALSYM D3DSIO_TEXM3x2PAD}
  D3DSIO_TEXM3x2TEX   = 72;
  {$EXTERNALSYM D3DSIO_TEXM3x2TEX}
  D3DSIO_TEXM3x3PAD   = 73;
  {$EXTERNALSYM D3DSIO_TEXM3x3PAD}
  D3DSIO_TEXM3x3TEX   = 74;
  {$EXTERNALSYM D3DSIO_TEXM3x3TEX}
  D3DSIO_RESERVED0    = 75;
  {$EXTERNALSYM D3DSIO_RESERVED0}
  D3DSIO_TEXM3x3SPEC  = 76;
  {$EXTERNALSYM D3DSIO_TEXM3x3SPEC}
  D3DSIO_TEXM3x3VSPEC = 77;
  {$EXTERNALSYM D3DSIO_TEXM3x3VSPEC}
  D3DSIO_EXPP         = 78;
  {$EXTERNALSYM D3DSIO_EXPP}
  D3DSIO_LOGP         = 79;
  {$EXTERNALSYM D3DSIO_LOGP}
  D3DSIO_CND          = 80;
  {$EXTERNALSYM D3DSIO_CND}
  D3DSIO_DEF          = 81;
  {$EXTERNALSYM D3DSIO_DEF}
  D3DSIO_TEXREG2RGB   = 82;
  {$EXTERNALSYM D3DSIO_TEXREG2RGB}
  D3DSIO_TEXDP3TEX    = 83;
  {$EXTERNALSYM D3DSIO_TEXDP3TEX}
  D3DSIO_TEXM3x2DEPTH = 84;
  {$EXTERNALSYM D3DSIO_TEXM3x2DEPTH}
  D3DSIO_TEXDP3       = 85;
  {$EXTERNALSYM D3DSIO_TEXDP3}
  D3DSIO_TEXM3x3      = 86;
  {$EXTERNALSYM D3DSIO_TEXM3x3}
  D3DSIO_TEXDEPTH     = 87;
  {$EXTERNALSYM D3DSIO_TEXDEPTH}
  D3DSIO_CMP          = 88;
  {$EXTERNALSYM D3DSIO_CMP}
  D3DSIO_BEM          = 89;
  {$EXTERNALSYM D3DSIO_BEM}

  D3DSIO_DP2ADD       = 90;
  {$EXTERNALSYM D3DSIO_DP2ADD}
  D3DSIO_DSX          = 91;
  {$EXTERNALSYM D3DSIO_DSX}
  D3DSIO_DSY          = 92;
  {$EXTERNALSYM D3DSIO_DSY}
  D3DSIO_TEXLDD       = 93;
  {$EXTERNALSYM D3DSIO_TEXLDD}
  D3DSIO_SETP         = 94;
  {$EXTERNALSYM D3DSIO_SETP}
  D3DSIO_TEXLDL       = 95;
  {$EXTERNALSYM D3DSIO_TEXLDL}
  D3DSIO_BREAKP       = 96;
  {$EXTERNALSYM D3DSIO_BREAKP}


  D3DSIO_PHASE        = $FFFD;
  {$EXTERNALSYM D3DSIO_PHASE}
  D3DSIO_COMMENT      = $FFFE;
  {$EXTERNALSYM D3DSIO_COMMENT}
  D3DSIO_END          = $FFFF;
  {$EXTERNALSYM D3DSIO_END}

  //---------------------------------------------------------------------
  // Use these constants with D3DSIO_SINCOS macro as SRC2, SRC3
  //
  //#define D3DSINCOSCONST1 -1.5500992e-006f, -2.1701389e-005f,  0.0026041667f, 0.00026041668f
  //#define D3DSINCOSCONST2 -0.020833334f, -0.12500000f, 1.0f, 0.50000000f

  //---------------------------------------------------------------------
  // Co-Issue Instruction Modifier - if set then this instruction is to be
  // issued in parallel with the previous instruction(s) for which this bit
  // is not set.
  //
  D3DSI_COISSUE           = $40000000;
  {$EXTERNALSYM D3DSI_COISSUE}

  //---------------------------------------------------------------------
  // Opcode specific controls

  D3DSP_OPCODESPECIFICCONTROL_MASK  = $00ff0000;
  {$EXTERNALSYM D3DSP_OPCODESPECIFICCONTROL_MASK}
  D3DSP_OPCODESPECIFICCONTROL_SHIFT = 16;
  {$EXTERNALSYM D3DSP_OPCODESPECIFICCONTROL_SHIFT}

  // ps_2_0 texld controls
  D3DSI_TEXLD_PROJECT = ($01 shl D3DSP_OPCODESPECIFICCONTROL_SHIFT);
  {$EXTERNALSYM D3DSI_TEXLD_PROJECT}
  D3DSI_TEXLD_BIAS    = ($02 shl D3DSP_OPCODESPECIFICCONTROL_SHIFT);
  {$EXTERNALSYM D3DSI_TEXLD_BIAS}

type
  // Comparison for dynamic conditional instruction opcodes (i.e. if, breakc)
  {$MINENUMSIZE 1} // Forces TD3DShaderComparison be 1 byte enum
  _D3DSHADER_COMPARISON = (
                         // < = >
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DSPC_RESERVED0{= 0}, // 0 0 0
    D3DSPC_GT       {= 1}, // 0 0 1
    D3DSPC_EQ       {= 2}, // 0 1 0
    D3DSPC_GE       {= 3}, // 0 1 1
    D3DSPC_LT       {= 4}, // 1 0 0
    D3DSPC_NE       {= 5}, // 1 0 1
    D3DSPC_LE       {= 6}, // 1 1 0
    D3DSPC_RESERVED1{= 7}  // 1 1 1
  {$ELSE}
    D3DSPC_RESERVED0= 0, // 0 0 0
    D3DSPC_GT       = 1, // 0 0 1
    D3DSPC_EQ       = 2, // 0 1 0
    D3DSPC_GE       = 3, // 0 1 1
    D3DSPC_LT       = 4, // 1 0 0
    D3DSPC_NE       = 5, // 1 0 1
    D3DSPC_LE       = 6, // 1 1 0
    D3DSPC_RESERVED1= 7  // 1 1 1
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DSHADER_COMPARISON}
  D3DSHADER_COMPARISON = _D3DSHADER_COMPARISON;
  {$EXTERNALSYM D3DSHADER_COMPARISON}
  TD3DShaderComparison = _D3DSHADER_COMPARISON;
  {$MINENUMSIZE 4} // Restores enums to be 4 byte in size

const
  // Comparison is part of instruction opcode token:
  D3DSHADER_COMPARISON_SHIFT = D3DSP_OPCODESPECIFICCONTROL_SHIFT;
  {$EXTERNALSYM D3DSHADER_COMPARISON_SHIFT}
  D3DSHADER_COMPARISON_MASK  = ($7 shl D3DSHADER_COMPARISON_SHIFT);
  {$EXTERNALSYM D3DSHADER_COMPARISON_MASK}

  //---------------------------------------------------------------------
  // Predication flags on instruction token
  D3DSHADER_INSTRUCTION_PREDICATED    = ($1 shl 28);
  {$EXTERNALSYM D3DSHADER_INSTRUCTION_PREDICATED}

  //---------------------------------------------------------------------
  // DCL Info Token Controls

  // For dcl info tokens requiring a semantic (usage + index)
  D3DSP_DCL_USAGE_SHIFT = 0;
  {$EXTERNALSYM D3DSP_DCL_USAGE_SHIFT}
  D3DSP_DCL_USAGE_MASK  = $0000000f;
  {$EXTERNALSYM D3DSP_DCL_USAGE_MASK}

  D3DSP_DCL_USAGEINDEX_SHIFT = 16;
  {$EXTERNALSYM D3DSP_DCL_USAGEINDEX_SHIFT}
  D3DSP_DCL_USAGEINDEX_MASK  = $000f0000;
  {$EXTERNALSYM D3DSP_DCL_USAGEINDEX_MASK}

  // DCL pixel shader sampler info token.
  D3DSP_TEXTURETYPE_SHIFT = 27;
  {$EXTERNALSYM D3DSP_TEXTURETYPE_SHIFT}
  D3DSP_TEXTURETYPE_MASK  = $78000000;
  {$EXTERNALSYM D3DSP_TEXTURETYPE_MASK}

{$IFNDEF SUPPORTS_EXPL_ENUMS_except_BCB6}
type
  _D3DSAMPLER_TEXTURE_TYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DSAMPLER_TEXTURE_TYPE}
  D3DSAMPLER_TEXTURE_TYPE = _D3DSAMPLER_TEXTURE_TYPE;
  {$EXTERNALSYM D3DSAMPLER_TEXTURE_TYPE}
  TD3DSamplerTextureType = _D3DSAMPLER_TEXTURE_TYPE;

const
  D3DSTT_UNKNOWN = 0 shl D3DSP_TEXTURETYPE_SHIFT; // uninitialized value
  {$EXTERNALSYM D3DSTT_UNKNOWN}
  D3DSTT_2D      = 2 shl D3DSP_TEXTURETYPE_SHIFT; // dcl_2d s# (for declaring a 2-D texture)
  {$EXTERNALSYM D3DSTT_2D}
  D3DSTT_CUBE    = 3 shl D3DSP_TEXTURETYPE_SHIFT; // dcl_cube s# (for declaring a cube texture)
  {$EXTERNALSYM D3DSTT_CUBE}
  D3DSTT_VOLUME  = 4 shl D3DSP_TEXTURETYPE_SHIFT; // dcl_volume s# (for declaring a volume texture)
  {$EXTERNALSYM D3DSTT_VOLUME}
  D3DSTT_FORCE_DWORD  = $7fffffff;      // force 32-bit size enum
  {$EXTERNALSYM D3DSTT_FORCE_DWORD}
{$ELSE}
type
  _D3DSAMPLER_TEXTURE_TYPE = (
    D3DSTT_UNKNOWN = 0 shl D3DSP_TEXTURETYPE_SHIFT, // uninitialized value
    D3DSTT_2D      = 2 shl D3DSP_TEXTURETYPE_SHIFT, // dcl_2d s# (for declaring a 2-D texture)
    D3DSTT_CUBE    = 3 shl D3DSP_TEXTURETYPE_SHIFT, // dcl_cube s# (for declaring a cube texture)
    D3DSTT_VOLUME  = 4 shl D3DSP_TEXTURETYPE_SHIFT, // dcl_volume s# (for declaring a volume texture)
    D3DSTT_FORCE_DWORD  = $7fffffff      // force 32-bit size enum
  );
  {$EXTERNALSYM _D3DSAMPLER_TEXTURE_TYPE}
  D3DSAMPLER_TEXTURE_TYPE = _D3DSAMPLER_TEXTURE_TYPE;
  {$EXTERNALSYM D3DSAMPLER_TEXTURE_TYPE}
  TD3DSamplerTextureType = _D3DSAMPLER_TEXTURE_TYPE;
{$ENDIF}

const
  //---------------------------------------------------------------------
  // Parameter Token Bit Definitions
  //
  D3DSP_REGNUM_MASK       = $000007FF;
  {$EXTERNALSYM D3DSP_REGNUM_MASK}

  // destination parameter write mask
  D3DSP_WRITEMASK_0       = $00010000;  // Component 0 (X;Red)
  {$EXTERNALSYM D3DSP_WRITEMASK_0}
  D3DSP_WRITEMASK_1       = $00020000;  // Component 1 (Y;Green)
  {$EXTERNALSYM D3DSP_WRITEMASK_1}
  D3DSP_WRITEMASK_2       = $00040000;  // Component 2 (Z;Blue)
  {$EXTERNALSYM D3DSP_WRITEMASK_2}
  D3DSP_WRITEMASK_3       = $00080000;  // Component 3 (W;Alpha)
  {$EXTERNALSYM D3DSP_WRITEMASK_3}
  D3DSP_WRITEMASK_ALL     = $000F0000;  // All Components
  {$EXTERNALSYM D3DSP_WRITEMASK_ALL}

  // destination parameter modifiers
  D3DSP_DSTMOD_SHIFT      = 20;
  {$EXTERNALSYM D3DSP_DSTMOD_SHIFT}
  D3DSP_DSTMOD_MASK       = $00F00000;
  {$EXTERNALSYM D3DSP_DSTMOD_MASK}

  // Bit masks for destination parameter modifiers
    D3DSPDM_NONE                 = (0 shl D3DSP_DSTMOD_SHIFT); // nop
    {$EXTERNALSYM D3DSPDM_NONE}
    D3DSPDM_SATURATE             = (1 shl D3DSP_DSTMOD_SHIFT); // clamp to 0. to 1. range
    {$EXTERNALSYM D3DSPDM_SATURATE}
    D3DSPDM_PARTIALPRECISION     = (2 shl D3DSP_DSTMOD_SHIFT); // Partial precision hint
    {$EXTERNALSYM D3DSPDM_PARTIALPRECISION}
    D3DSPDM_MSAMPCENTROID        = (4 shl D3DSP_DSTMOD_SHIFT); // Relevant to multisampling only:
    {$EXTERNALSYM D3DSPDM_MSAMPCENTROID}
                                                               //      When the pixel center is not covered, sample
                                                               //      attribute or compute gradients/LOD
                                                               //      using multisample "centroid" location.
                                                               //      "Centroid" is some location within the covered
                                                               //      region of the pixel.

  // destination parameter
  D3DSP_DSTSHIFT_SHIFT    = 24;
  {$EXTERNALSYM D3DSP_DSTSHIFT_SHIFT}
  D3DSP_DSTSHIFT_MASK     = $0F000000;
  {$EXTERNALSYM D3DSP_DSTSHIFT_MASK}

  // destination/source parameter register type
  D3DSP_REGTYPE_SHIFT     = 28;
  {$EXTERNALSYM D3DSP_REGTYPE_SHIFT}
  D3DSP_REGTYPE_SHIFT2    = 8;
  {$EXTERNALSYM D3DSP_REGTYPE_SHIFT2}
  D3DSP_REGTYPE_MASK      = $70000000;
  {$EXTERNALSYM D3DSP_REGTYPE_MASK}
  D3DSP_REGTYPE_MASK2     = $00001800;
  {$EXTERNALSYM D3DSP_REGTYPE_MASK2}


{$IFNDEF SUPPORTS_EXPL_ENUMS}
const
  D3DSPR_TEMP          =  0; // Temporary Register File
  {$EXTERNALSYM D3DSPR_TEMP}
  D3DSPR_INPUT         =  1; // Input Register File
  {$EXTERNALSYM D3DSPR_INPUT}
  D3DSPR_CONST         =  2; // Constant Register File
  {$EXTERNALSYM D3DSPR_CONST}
  D3DSPR_ADDR          =  3; // Address Register (VS)
  {$EXTERNALSYM D3DSPR_ADDR}
  D3DSPR_TEXTURE       =  3; // Texture Register File (PS)
  {$EXTERNALSYM D3DSPR_TEXTURE}
  D3DSPR_RASTOUT       =  4; // Rasterizer Register File
  {$EXTERNALSYM D3DSPR_RASTOUT}
  D3DSPR_ATTROUT       =  5; // Attribute Output Register File
  {$EXTERNALSYM D3DSPR_ATTROUT}
  D3DSPR_TEXCRDOUT     =  6; // Texture Coordinate Output Register File
  {$EXTERNALSYM D3DSPR_TEXCRDOUT}
  D3DSPR_OUTPUT        =  6; // Output register file for VS3.0+
  {$EXTERNALSYM D3DSPR_OUTPUT}
  D3DSPR_CONSTINT      =  7; // Constant Integer Vector Register File
  {$EXTERNALSYM D3DSPR_CONSTINT}
  D3DSPR_COLOROUT      =  8; // Color Output Register File
  {$EXTERNALSYM D3DSPR_COLOROUT}
  D3DSPR_DEPTHOUT      =  9; // Depth Output Register File
  {$EXTERNALSYM D3DSPR_DEPTHOUT}
  D3DSPR_SAMPLER       = 10; // Sampler State Register File
  {$EXTERNALSYM D3DSPR_SAMPLER}
  D3DSPR_CONST2        = 11; // Constant Register File  2048 - 4095
  {$EXTERNALSYM D3DSPR_CONST2}
  D3DSPR_CONST3        = 12; // Constant Register File  4096 - 6143
  {$EXTERNALSYM D3DSPR_CONST3}
  D3DSPR_CONST4        = 13; // Constant Register File  6144 - 8191
  {$EXTERNALSYM D3DSPR_CONST4}
  D3DSPR_CONSTBOOL     = 14; // Constant Boolean register file
  {$EXTERNALSYM D3DSPR_CONSTBOOL}
  D3DSPR_LOOP          = 15; // Loop counter register file
  {$EXTERNALSYM D3DSPR_LOOP}
  D3DSPR_TEMPFLOAT16   = 16; // 16-bit float temp register file
  {$EXTERNALSYM D3DSPR_TEMPFLOAT16}
  D3DSPR_MISCTYPE      = 17; // Miscellaneous (single) registers.
  {$EXTERNALSYM D3DSPR_MISCTYPE}
  D3DSPR_LABEL         = 18; // Label
  {$EXTERNALSYM D3DSPR_LABEL}
  D3DSPR_PREDICATE     = 19; // Predicate register
  {$EXTERNALSYM D3DSPR_PREDICATE}

type
  _D3DSHADER_PARAM_REGISTER_TYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
{$ELSE}
type
  _D3DSHADER_PARAM_REGISTER_TYPE = (
    D3DSPR_TEMP           =  0, // Temporary Register File
    D3DSPR_INPUT          =  1, // Input Register File
    D3DSPR_CONST          =  2, // Constant Register File
    D3DSPR_ADDR           =  3, // Address Register (VS)
    D3DSPR_TEXTURE        =  3, // Texture Register File (PS)
    D3DSPR_RASTOUT        =  4, // Rasterizer Register File
    D3DSPR_ATTROUT        =  5, // Attribute Output Register File
    D3DSPR_TEXCRDOUT      =  6, // Texture Coordinate Output Register File
    D3DSPR_OUTPUT         =  6, // Output register file for VS3.0+
    D3DSPR_CONSTINT       =  7, // Constant Integer Vector Register File
    D3DSPR_COLOROUT       =  8, // Color Output Register File
    D3DSPR_DEPTHOUT       =  9, // Depth Output Register File
    D3DSPR_SAMPLER        = 10, // Sampler State Register File
    D3DSPR_CONST2         = 11, // Constant Register File  2048 - 4095
    D3DSPR_CONST3         = 12, // Constant Register File  4096 - 6143
    D3DSPR_CONST4         = 13, // Constant Register File  6144 - 8191
    D3DSPR_CONSTBOOL      = 14, // Constant Boolean register file
    D3DSPR_LOOP           = 15, // Loop counter register file
    D3DSPR_TEMPFLOAT16    = 16, // 16-bit float temp register file
    D3DSPR_MISCTYPE       = 17, // Miscellaneous (single) registers.
    D3DSPR_LABEL          = 18, // Label
    D3DSPR_PREDICATE      = 19  // Predicate register
  );
{$ENDIF}
  {$EXTERNALSYM _D3DSHADER_PARAM_REGISTER_TYPE}
  D3DSHADER_PARAM_REGISTER_TYPE = _D3DSHADER_PARAM_REGISTER_TYPE;
  {$EXTERNALSYM D3DSHADER_PARAM_REGISTER_TYPE}
  TD3DShaderParamRegisterType = _D3DSHADER_PARAM_REGISTER_TYPE;

  // The miscellaneous register file (D3DSPR_MISCTYPES)
  // contains register types for which there is only ever one
  // register (i.e. the register # is not needed).
  // Rather than use up additional register types for such
  // registers, they are defined
  // as particular offsets into the misc. register file:
  {$MINENUMSIZE 1} // Forces TD3DShaderMiscTypeOffsets be 1 byte enum
  _D3DSHADER_MISCTYPE_OFFSETS = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DSMO_POSITION   {= 0}, // Input position x,y,z,rhw (PS)
    D3DSMO_FACE   {= 1}  // Floating point primitive area (PS)
  {$ELSE}
    D3DSMO_POSITION   = 0, // Input position x,y,z,rhw (PS)
    D3DSMO_FACE   = 1  // Floating point primitive area (PS)
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DSHADER_MISCTYPE_OFFSETS}
  D3DSHADER_MISCTYPE_OFFSETS = _D3DSHADER_MISCTYPE_OFFSETS;
  {$EXTERNALSYM D3DSHADER_MISCTYPE_OFFSETS}
  TD3DShaderMiscTypeOffsets = _D3DSHADER_MISCTYPE_OFFSETS;
  {$MINENUMSIZE 4} // Restores enums to be 4 byte in size

  // Register offsets in the Rasterizer Register File
  //
  _D3DVS_RASTOUT_OFFSETS = (
    D3DSRO_POSITION, // = 0,
    D3DSRO_FOG,
    D3DSRO_POINT_SIZE
  );
  {$EXTERNALSYM _D3DVS_RASTOUT_OFFSETS}
  D3DVS_RASTOUT_OFFSETS = _D3DVS_RASTOUT_OFFSETS;
  {$EXTERNALSYM D3DVS_RASTOUT_OFFSETS}
  TD3DVSRastoutOffsets = _D3DVS_RASTOUT_OFFSETS;

// Source operand addressing modes

const
  D3DVS_ADDRESSMODE_SHIFT = 13;
  {$EXTERNALSYM D3DVS_ADDRESSMODE_SHIFT}
  D3DVS_ADDRESSMODE_MASK  = 1 shl D3DVS_ADDRESSMODE_SHIFT;
  {$EXTERNALSYM D3DVS_ADDRESSMODE_MASK}

type
  _D3DVS_ADDRESSMODE_TYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DVS_ADDRESSMODE_TYPE}
  D3DVS_ADDRESSMODE_TYPE = _D3DVS_ADDRESSMODE_TYPE;
  {$EXTERNALSYM D3DVS_ADDRESSMODE_TYPE}
  TD3DVSAddressModeType = _D3DVS_ADDRESSMODE_TYPE;

const
  D3DVS_ADDRMODE_ABSOLUTE    = 0 shl D3DVS_ADDRESSMODE_SHIFT;
  {$EXTERNALSYM D3DVS_ADDRMODE_ABSOLUTE}
  D3DVS_ADDRMODE_RELATIVE    = 1 shl D3DVS_ADDRESSMODE_SHIFT; 
  {$EXTERNALSYM D3DVS_ADDRMODE_RELATIVE}
  D3DVS_ADDRMODE_FORCE_DWORD = $7fffffff;                      // force 32-bit size enum
  {$EXTERNALSYM D3DVS_ADDRMODE_FORCE_DWORD}

const
  D3DSHADER_ADDRESSMODE_SHIFT = 13;
  {$EXTERNALSYM D3DSHADER_ADDRESSMODE_SHIFT}
  D3DSHADER_ADDRESSMODE_MASK  = (1 shl D3DSHADER_ADDRESSMODE_SHIFT);
  {$EXTERNALSYM D3DSHADER_ADDRESSMODE_MASK}

type
  _D3DSHADER_ADDRESSMODE_TYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DSHADER_ADDRESSMODE_TYPE}
  D3DSHADER_ADDRESSMODE_TYPE = _D3DSHADER_ADDRESSMODE_TYPE;
  {$EXTERNALSYM D3DSHADER_ADDRESSMODE_TYPE}
  TD3DShaderAddressModeType = _D3DSHADER_ADDRESSMODE_TYPE;

const
  D3DSHADER_ADDRMODE_ABSOLUTE  = (0 shl D3DSHADER_ADDRESSMODE_SHIFT);
  {$EXTERNALSYM D3DSHADER_ADDRMODE_ABSOLUTE}
  D3DSHADER_ADDRMODE_RELATIVE  = (1 shl D3DSHADER_ADDRESSMODE_SHIFT);
  {$EXTERNALSYM D3DSHADER_ADDRMODE_RELATIVE}
  D3DSHADER_ADDRMODE_FORCE_DWORD = $7fffffff; // force 32-bit size enum
  {$EXTERNALSYM D3DSHADER_ADDRMODE_FORCE_DWORD}

  // Source operand swizzle definitions
  //
  D3DVS_SWIZZLE_SHIFT     = 16;
  {$EXTERNALSYM D3DVS_SWIZZLE_SHIFT}
  D3DVS_SWIZZLE_MASK      = $00FF0000;
  {$EXTERNALSYM D3DVS_SWIZZLE_MASK}

  // The following bits define where to take component X from:

  D3DVS_X_X = 0 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_X}
  D3DVS_X_Y = 1 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_Y}
  D3DVS_X_Z = 2 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_Z}
  D3DVS_X_W = 3 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_W}

  // The following bits define where to take component Y from:

  D3DVS_Y_X = 0 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_X}
  D3DVS_Y_Y = 1 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_Y}
  D3DVS_Y_Z = 2 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_Z}
  D3DVS_Y_W = 3 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_W}

  // The following bits define where to take component Z from:

  D3DVS_Z_X = 0 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_X}
  D3DVS_Z_Y = 1 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_Y}
  D3DVS_Z_Z = 2 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_Z}
  D3DVS_Z_W = 3 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_W}

  // The following bits define where to take component W from:

  D3DVS_W_X = 0 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_X}
  D3DVS_W_Y = 1 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_Y}
  D3DVS_W_Z = 2 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_Z}
  D3DVS_W_W = 3 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_W}

  // Value when there is no swizzle (X is taken from X, Y is taken from Y,
  // Z is taken from Z, W is taken from W
  //
  D3DVS_NOSWIZZLE = D3DVS_X_X or D3DVS_Y_Y or D3DVS_Z_Z or D3DVS_W_W;
  {$EXTERNALSYM D3DVS_NOSWIZZLE}

  // source parameter swizzle
  D3DSP_SWIZZLE_SHIFT = 16;
  {$EXTERNALSYM D3DSP_SWIZZLE_SHIFT}
  D3DSP_SWIZZLE_MASK  = $00FF0000;
  {$EXTERNALSYM D3DSP_SWIZZLE_MASK}

  D3DSP_NOSWIZZLE =
    (0 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_NOSWIZZLE}

  // pixel-shader swizzle ops
  D3DSP_REPLICATERED =
    (0 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (0 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (0 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (0 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATERED}

  D3DSP_REPLICATEGREEN =
    (1 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATEGREEN}

  D3DSP_REPLICATEBLUE =
    (2 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATEBLUE}

  D3DSP_REPLICATEALPHA =
    (3 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATEALPHA}

  // source parameter modifiers
  D3DSP_SRCMOD_SHIFT      = 24;
  {$EXTERNALSYM D3DSP_SRCMOD_SHIFT}
  D3DSP_SRCMOD_MASK       = $0F000000;
  {$EXTERNALSYM D3DSP_SRCMOD_MASK}

type
  _D3DSHADER_PARAM_SRCMOD_TYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DSHADER_PARAM_SRCMOD_TYPE}
  D3DSHADER_PARAM_SRCMOD_TYPE = _D3DSHADER_PARAM_SRCMOD_TYPE;
  {$EXTERNALSYM D3DSHADER_PARAM_SRCMOD_TYPE}
  TD3DShaderParamSRCModType = _D3DSHADER_PARAM_SRCMOD_TYPE;

//---------------------------------------------------------------------

type
  // High order surfaces
  //
  _D3DBASISTYPE = (
    D3DBASIS_BEZIER      {= 0},
    D3DBASIS_BSPLINE     {= 1},
    D3DBASIS_CATMULL_ROM {= 2} { In D3D8 this used to be D3DBASIS_INTERPOLATE }
  );
  {$EXTERNALSYM _D3DBASISTYPE}
  D3DBASISTYPE = _D3DBASISTYPE;
  {$EXTERNALSYM D3DBASISTYPE}
  TD3DBasisType = _D3DBASISTYPE;

  _D3DDEGREETYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DDEGREE_invalid_0  {= 0},
    D3DDEGREE_LINEAR     {= 1},
    D3DDEGREE_QUADRATIC  {= 2},
    D3DDEGREE_CUBIC      {= 3},
    D3DDEGREE_invalid_4  {= 4},
    D3DDEGREE_QUINTIC    {= 5}
  {$ELSE}
    D3DDEGREE_LINEAR      = 1,
    D3DDEGREE_QUADRATIC   = 2,
    D3DDEGREE_CUBIC       = 3,
    D3DDEGREE_QUINTIC     = 5
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DDEGREETYPE}
  D3DDEGREETYPE = _D3DDEGREETYPE;
  {$EXTERNALSYM D3DDEGREETYPE}
  TD3DDegreeType = _D3DDEGREETYPE;

  _D3DPATCHEDGESTYLE = (
    D3DPATCHEDGE_DISCRETE   {= 0},
    D3DPATCHEDGE_CONTINUOUS {= 1}
  );
  {$EXTERNALSYM _D3DPATCHEDGESTYLE}
  D3DPATCHEDGESTYLE = _D3DPATCHEDGESTYLE;
  {$EXTERNALSYM D3DPATCHEDGESTYLE}
  TD3DPatchEdgeStyle = _D3DPATCHEDGESTYLE;

  _D3DSTATEBLOCKTYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DSBT_INVALID_0,
    D3DSBT_ALL          {= 1}, // capture all state
    D3DSBT_PIXELSTATE   {= 2}, // capture pixel state
    D3DSBT_VERTEXSTATE  {= 3}  // capture vertex state
  {$ELSE}
    D3DSBT_ALL          = 1, // capture all state
    D3DSBT_PIXELSTATE   = 2, // capture pixel state
    D3DSBT_VERTEXSTATE  = 3  // capture vertex state
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DSTATEBLOCKTYPE}
  D3DSTATEBLOCKTYPE = _D3DSTATEBLOCKTYPE;
  {$EXTERNALSYM D3DSTATEBLOCKTYPE}
  TD3DStateBlockType = _D3DSTATEBLOCKTYPE;

type
  // The D3DVERTEXBLENDFLAGS type is used with D3DRS_VERTEXBLEND state.
  //
  _D3DVERTEXBLENDFLAGS = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DVERTEXBLENDFLAGS}
  D3DVERTEXBLENDFLAGS = _D3DVERTEXBLENDFLAGS;
  {$EXTERNALSYM D3DVERTEXBLENDFLAGS}
  TD3DVertexBlendFlags = _D3DVERTEXBLENDFLAGS;

const
  D3DVBF_DISABLE  = 0;            // Disable vertex blending
  {$EXTERNALSYM D3DVBF_DISABLE}
  D3DVBF_1WEIGHTS = 1;            // 2 matrix blending
  {$EXTERNALSYM D3DVBF_1WEIGHTS}
  D3DVBF_2WEIGHTS = 2;            // 3 matrix blending
  {$EXTERNALSYM D3DVBF_2WEIGHTS}
  D3DVBF_3WEIGHTS = 3;            // 4 matrix blending
  {$EXTERNALSYM D3DVBF_3WEIGHTS}
  D3DVBF_TWEENING = 255;          // blending using D3DRS_TWEENFACTOR
  {$EXTERNALSYM D3DVBF_TWEENING}
  D3DVBF_0WEIGHTS = 256;          // one matrix is used with weight 1.0
  {$EXTERNALSYM D3DVBF_0WEIGHTS}
  D3DVBF_FORCE_DWORD = $7fffffff; // force 32-bit size enum
  {$EXTERNALSYM D3DVBF_FORCE_DWORD}

type
  _D3DTEXTURETRANSFORMFLAGS = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DTEXTURETRANSFORMFLAGS}
  D3DTEXTURETRANSFORMFLAGS = _D3DTEXTURETRANSFORMFLAGS;
  {$EXTERNALSYM D3DTEXTURETRANSFORMFLAGS}
  TD3DTextureTransformFlags = _D3DTEXTURETRANSFORMFLAGS;

const
  D3DTTFF_DISABLE         = 0;    // texture coordinates are passed directly
  {$EXTERNALSYM D3DTTFF_DISABLE}
  D3DTTFF_COUNT1          = 1;    // rasterizer should expect 1-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT1}
  D3DTTFF_COUNT2          = 2;    // rasterizer should expect 2-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT2}
  D3DTTFF_COUNT3          = 3;    // rasterizer should expect 3-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT3}
  D3DTTFF_COUNT4          = 4;    // rasterizer should expect 4-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT4}
  D3DTTFF_PROJECTED       = 256;  // texcoords to be divided by COUNTth element
  {$EXTERNALSYM D3DTTFF_PROJECTED}
  D3DTTFF_FORCE_DWORD     = $7fffffff;
  {$EXTERNALSYM D3DTTFF_FORCE_DWORD}

const
  // Macros to set texture coordinate format bits in the FVF id

  D3DFVF_TEXTUREFORMAT2 = 0;         // Two floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT2}
  D3DFVF_TEXTUREFORMAT1 = 3;         // One floating point value
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT1}
  D3DFVF_TEXTUREFORMAT3 = 1;         // Three floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT3}
  D3DFVF_TEXTUREFORMAT4 = 2;         // Four floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT4}

//#define D3DFVF_TEXCOORDSIZE3(CoordIndex) (D3DFVF_TEXTUREFORMAT3 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE3(CoordIndex: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE3}
//#define D3DFVF_TEXCOORDSIZE2(CoordIndex) (D3DFVF_TEXTUREFORMAT2)
function D3DFVF_TEXCOORDSIZE2(CoordIndex: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE2}
//#define D3DFVF_TEXCOORDSIZE4(CoordIndex) (D3DFVF_TEXTUREFORMAT4 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE4(CoordIndex: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE4}
//#define D3DFVF_TEXCOORDSIZE1(CoordIndex) (D3DFVF_TEXTUREFORMAT1 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE1(CoordIndex: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE1}


//---------------------------------------------------------------------

type
  { Direct3D9 Device types }
  _D3DDEVTYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DDEVTYPE_INVALID_0,
    D3DDEVTYPE_HAL         {= 1},
    D3DDEVTYPE_REF         {= 2},
    D3DDEVTYPE_SW          {= 3},

    D3DDEVTYPE_NULLREF     {= 4}
  {$ELSE}
    D3DDEVTYPE_HAL         = 1,
    D3DDEVTYPE_REF         = 2,
    D3DDEVTYPE_SW          = 3,

    D3DDEVTYPE_NULLREF     = 4
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DDEVTYPE}
  D3DDEVTYPE = _D3DDEVTYPE;
  {$EXTERNALSYM D3DDEVTYPE}
  TD3DDevType = _D3DDEVTYPE;

  { Multi-Sample buffer types }
  _D3DMULTISAMPLE_TYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DMULTISAMPLE_NONE            {=  0},
    D3DMULTISAMPLE_NONMASKABLE     {=  1},
    D3DMULTISAMPLE_2_SAMPLES       {=  2},
    D3DMULTISAMPLE_3_SAMPLES       {=  3},
    D3DMULTISAMPLE_4_SAMPLES       {=  4},
    D3DMULTISAMPLE_5_SAMPLES       {=  5},
    D3DMULTISAMPLE_6_SAMPLES       {=  6},
    D3DMULTISAMPLE_7_SAMPLES       {=  7},
    D3DMULTISAMPLE_8_SAMPLES       {=  8},
    D3DMULTISAMPLE_9_SAMPLES       {=  9},
    D3DMULTISAMPLE_10_SAMPLES      {= 10},
    D3DMULTISAMPLE_11_SAMPLES      {= 11},
    D3DMULTISAMPLE_12_SAMPLES      {= 12},
    D3DMULTISAMPLE_13_SAMPLES      {= 13},
    D3DMULTISAMPLE_14_SAMPLES      {= 14},
    D3DMULTISAMPLE_15_SAMPLES      {= 15},
    D3DMULTISAMPLE_16_SAMPLES      {= 16}
  {$ELSE}
    D3DMULTISAMPLE_NONE            =  0,
    D3DMULTISAMPLE_NONMASKABLE     =  1,
    D3DMULTISAMPLE_2_SAMPLES       =  2,
    D3DMULTISAMPLE_3_SAMPLES       =  3,
    D3DMULTISAMPLE_4_SAMPLES       =  4,
    D3DMULTISAMPLE_5_SAMPLES       =  5,
    D3DMULTISAMPLE_6_SAMPLES       =  6,
    D3DMULTISAMPLE_7_SAMPLES       =  7,
    D3DMULTISAMPLE_8_SAMPLES       =  8,
    D3DMULTISAMPLE_9_SAMPLES       =  9,
    D3DMULTISAMPLE_10_SAMPLES      = 10,
    D3DMULTISAMPLE_11_SAMPLES      = 11,
    D3DMULTISAMPLE_12_SAMPLES      = 12,
    D3DMULTISAMPLE_13_SAMPLES      = 13,
    D3DMULTISAMPLE_14_SAMPLES      = 14,
    D3DMULTISAMPLE_15_SAMPLES      = 15,
    D3DMULTISAMPLE_16_SAMPLES      = 16
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DMULTISAMPLE_TYPE}
  D3DMULTISAMPLE_TYPE = _D3DMULTISAMPLE_TYPE;
  {$EXTERNALSYM D3DMULTISAMPLE_TYPE}
  TD3DMultiSampleType = _D3DMULTISAMPLE_TYPE;

(* Formats
 * Most of these names have the following convention:
 *      A = Alpha
 *      R = Red
 *      G = Green
 *      B = Blue
 *      X = Unused Bits
 *      P = Palette
 *      L = Luminance
 *      U = dU coordinate for BumpMap
 *      V = dV coordinate for BumpMap
 *      S = Stencil
 *      D = Depth (e.g. Z or W buffer)
 *      C = Computed from other channels (typically on certain read operations)
 *
 *      Further, the order of the pieces are from MSB first; hence
 *      D3DFMT_A8L8 indicates that the high byte of this two byte
 *      format is alpha.
 *
 *      D3DFMT_D16_LOCKABLE indicates:
 *           - An integer 16-bit value.
 *           - An app-lockable surface.
 *
 *      D3DFMT_D32F_LOCKABLE indicates:
 *           - An IEEE 754 floating-point value.
 *           - An app-lockable surface.
 *
 *      All Depth/Stencil formats except D3DFMT_D16_LOCKABLE and D3DFMT_D32F_LOCKABLE indicate:
 *          - no particular bit ordering per pixel, and
 *          - are not app lockable, and
 *          - the driver is allowed to consume more than the indicated
 *            number of bits per Depth channel (but not Stencil channel).
 *)
//    #define MAKEFOURCC(ch0, ch1, ch2, ch3)                              \
//                ((DWORD)(BYTE)(ch0) | ((DWORD)(BYTE)(ch1) << 8) |       \
//                ((DWORD)(BYTE)(ch2) << 16) | ((DWORD)(BYTE)(ch3) << 24 ))
function MAKEFOURCC(ch0, ch1, ch2, ch3: Char): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKEFOURCC}


{$IFNDEF SUPPORTS_EXPL_ENUMS_except_BCB6}
const
  D3DFMT_UNKNOWN              =  0;
  {$EXTERNALSYM D3DFMT_UNKNOWN}

  D3DFMT_R8G8B8               = 20;
  {$EXTERNALSYM D3DFMT_R8G8B8}
  D3DFMT_A8R8G8B8             = 21;
  {$EXTERNALSYM D3DFMT_A8R8G8B8}
  D3DFMT_X8R8G8B8             = 22;
  {$EXTERNALSYM D3DFMT_X8R8G8B8}
  D3DFMT_R5G6B5               = 23;
  {$EXTERNALSYM D3DFMT_R5G6B5}
  D3DFMT_X1R5G5B5             = 24;
  {$EXTERNALSYM D3DFMT_X1R5G5B5}
  D3DFMT_A1R5G5B5             = 25;
  {$EXTERNALSYM D3DFMT_A1R5G5B5}
  D3DFMT_A4R4G4B4             = 26;
  {$EXTERNALSYM D3DFMT_A4R4G4B4}
  D3DFMT_R3G3B2               = 27;
  {$EXTERNALSYM D3DFMT_R3G3B2}
  D3DFMT_A8                   = 28;
  {$EXTERNALSYM D3DFMT_A8}
  D3DFMT_A8R3G3B2             = 29;
  {$EXTERNALSYM D3DFMT_A8R3G3B2}
  D3DFMT_X4R4G4B4             = 30;
  {$EXTERNALSYM D3DFMT_X4R4G4B4}
  D3DFMT_A2B10G10R10          = 31;
  {$EXTERNALSYM D3DFMT_A2B10G10R10}
  D3DFMT_A8B8G8R8             = 32;
  {$EXTERNALSYM D3DFMT_A8B8G8R8}
  D3DFMT_X8B8G8R8             = 33;
  {$EXTERNALSYM D3DFMT_X8B8G8R8}
  D3DFMT_G16R16               = 34;
  {$EXTERNALSYM D3DFMT_G16R16}
  D3DFMT_A2R10G10B10          = 35;
  {$EXTERNALSYM D3DFMT_A2R10G10B10}
  D3DFMT_A16B16G16R16         = 36;
  {$EXTERNALSYM D3DFMT_A16B16G16R16}

  D3DFMT_A8P8                 = 40;
  {$EXTERNALSYM D3DFMT_A8P8}
  D3DFMT_P8                   = 41;
  {$EXTERNALSYM D3DFMT_P8}

  D3DFMT_L8                   = 50;
  {$EXTERNALSYM D3DFMT_L8}
  D3DFMT_A8L8                 = 51;
  {$EXTERNALSYM D3DFMT_A8L8}
  D3DFMT_A4L4                 = 52;
  {$EXTERNALSYM D3DFMT_A4L4}

  D3DFMT_V8U8                 = 60;
  {$EXTERNALSYM D3DFMT_V8U8}
  D3DFMT_L6V5U5               = 61;
  {$EXTERNALSYM D3DFMT_L6V5U5}
  D3DFMT_X8L8V8U8             = 62;
  {$EXTERNALSYM D3DFMT_X8L8V8U8}
  D3DFMT_Q8W8V8U8             = 63;
  {$EXTERNALSYM D3DFMT_Q8W8V8U8}
  D3DFMT_V16U16               = 64;
  {$EXTERNALSYM D3DFMT_V16U16}
  D3DFMT_A2W10V10U10          = 67;
  {$EXTERNALSYM D3DFMT_A2W10V10U10}

  // D3DFMT_UYVY                 = MAKEFOURCC('U', 'Y', 'V', 'Y');
  D3DFMT_UYVY                 = Byte('U') or (Byte('Y') shl 8) or (Byte('V') shl 16) or (Byte('Y') shl 24);
  {$EXTERNALSYM D3DFMT_UYVY}
  // D3DFMT_R8G8_B8G8            = MAKEFOURCC('R', 'G', 'B', 'G'),
  D3DFMT_R8G8_B8G8            = Byte('R') or (Byte('G') shl 8) or (Byte('B') shl 16) or (Byte('G') shl 24);
  {$EXTERNALSYM D3DFMT_R8G8_B8G8}
  // D3DFMT_YUY2                 = MAKEFOURCC('Y', 'U', 'Y', '2'),
  D3DFMT_YUY2                 = Byte('Y') or (Byte('U') shl 8) or (Byte('Y') shl 16) or (Byte('2') shl 24);
  {$EXTERNALSYM D3DFMT_YUY2}
  // D3DFMT_G8R8_G8B8            = MAKEFOURCC('G', 'R', 'G', 'B'),
  D3DFMT_G8R8_G8B8            = Byte('G') or (Byte('R') shl 8) or (Byte('G') shl 16) or (Byte('B') shl 24);
  {$EXTERNALSYM D3DFMT_G8R8_G8B8}
  // D3DFMT_DXT1                 = MAKEFOURCC('D', 'X', 'T', '1'),
  D3DFMT_DXT1                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('1') shl 24);
  {$EXTERNALSYM D3DFMT_DXT1}
  // D3DFMT_DXT2                 = MAKEFOURCC('D', 'X', 'T', '2'),
  D3DFMT_DXT2                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('2') shl 24);
  {$EXTERNALSYM D3DFMT_DXT2}
  // D3DFMT_DXT3                 = MAKEFOURCC('D', 'X', 'T', '3'),
  D3DFMT_DXT3                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('3') shl 24);
  {$EXTERNALSYM D3DFMT_DXT3}
  // D3DFMT_DXT4                 = MAKEFOURCC('D', 'X', 'T', '4'),
  D3DFMT_DXT4                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('4') shl 24);
  {$EXTERNALSYM D3DFMT_DXT4}
  // D3DFMT_DXT5                 = MAKEFOURCC('D', 'X', 'T', '5'),
  D3DFMT_DXT5                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('5') shl 24);
  {$EXTERNALSYM D3DFMT_DXT5}

  D3DFMT_D16_LOCKABLE         = 70;
  {$EXTERNALSYM D3DFMT_D16_LOCKABLE}
  D3DFMT_D32                  = 71;
  {$EXTERNALSYM D3DFMT_D32}
  D3DFMT_D15S1                = 73;
  {$EXTERNALSYM D3DFMT_D15S1}
  D3DFMT_D24S8                = 75;
  {$EXTERNALSYM D3DFMT_D24S8}
  D3DFMT_D24X8                = 77;
  {$EXTERNALSYM D3DFMT_D24X8}
  D3DFMT_D24X4S4              = 79;
  {$EXTERNALSYM D3DFMT_D24X4S4}
  D3DFMT_D16                  = 80;
  {$EXTERNALSYM D3DFMT_D16}


  D3DFMT_D32F_LOCKABLE        = 82;
  {$EXTERNALSYM D3DFMT_D32F_LOCKABLE}
  D3DFMT_D24FS8               = 83;
  {$EXTERNALSYM D3DFMT_D24FS8}

{$IFDEF DIRECT3D_VERSION_9_VISTA}
  (* Z-Stencil formats valid for CPU access *)
  D3DFMT_D32_LOCKABLE         = 84;
  {$EXTERNALSYM D3DFMT_D32_LOCKABLE}
  D3DFMT_S8_LOCKABLE          = 85;
  {$EXTERNALSYM D3DFMT_S8_LOCKABLE}


{$ENDIF}

  D3DFMT_L16                  = 81;
  {$EXTERNALSYM D3DFMT_L16}


  D3DFMT_VERTEXDATA           =100;
  {$EXTERNALSYM D3DFMT_VERTEXDATA}
  D3DFMT_INDEX16              =101;
  {$EXTERNALSYM D3DFMT_INDEX16}
  D3DFMT_INDEX32              =102;
  {$EXTERNALSYM D3DFMT_INDEX32}

  D3DFMT_Q16W16V16U16         =110;
  {$EXTERNALSYM D3DFMT_Q16W16V16U16}

  // D3DFMT_MULTI2_ARGB8         = MAKEFOURCC('M','E','T','1'),
  D3DFMT_MULTI2_ARGB8         = Byte('M') or (Byte('E') shl 8) or (Byte('T') shl 16) or (Byte('1') shl 24);
  {$EXTERNALSYM D3DFMT_MULTI2_ARGB8}

  // Floating point surface formats

  // s10e5 formats (16-bits per channel)
  D3DFMT_R16F                 = 111;
  {$EXTERNALSYM D3DFMT_R16F}
  D3DFMT_G16R16F              = 112;
  {$EXTERNALSYM D3DFMT_G16R16F}
  D3DFMT_A16B16G16R16F        = 113;
  {$EXTERNALSYM D3DFMT_A16B16G16R16F}

  // IEEE s23e8 formats (32-bits per channel)
  D3DFMT_R32F                 = 114;
  {$EXTERNALSYM D3DFMT_R32F}
  D3DFMT_G32R32F              = 115;
  {$EXTERNALSYM D3DFMT_G32R32F}
  D3DFMT_A32B32G32R32F        = 116;
  {$EXTERNALSYM D3DFMT_A32B32G32R32F}

  D3DFMT_CxV8U8               = 117;
  {$EXTERNALSYM D3DFMT_CxV8U8}

{$IFDEF DIRECT3D_VERSION_9_VISTA}
  // Monochrome 1 bit per pixel format
  D3DFMT_A1                   = 118;
  {$EXTERNALSYM D3DFMT_A1}


  // Binary format indicating that the data has no inherent type
  D3DFMT_BINARYBUFFER         = 199;
  {$EXTERNALSYM D3DFMT_BINARYBUFFER}

{$ENDIF}

  // ATI - 3Dc/ATI2N texture format
  // D3DFMT_ATI2                 = MAKEFOURCC('A', 'T', 'I', '2'),
  D3DFMT_ATI2                 = Byte('A') or (Byte('T') shl 8) or (Byte('I') shl 16) or (Byte('2') shl 24);
  //{$EXTERNALSYM D3DFMT_ATI2} //Clootie: - this is not defined in original SDK headers

  D3DFMT_FORCE_DWORD          = $7fffffff;
  {$EXTERNALSYM D3DFMT_FORCE_DWORD}

type
  _D3DFORMAT = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
{$ELSE}
type
  _D3DFORMAT = (
    D3DFMT_UNKNOWN              =  0,

    D3DFMT_R8G8B8               = 20,
    D3DFMT_A8R8G8B8             = 21,
    D3DFMT_X8R8G8B8             = 22,
    D3DFMT_R5G6B5               = 23,
    D3DFMT_X1R5G5B5             = 24,
    D3DFMT_A1R5G5B5             = 25,
    D3DFMT_A4R4G4B4             = 26,
    D3DFMT_R3G3B2               = 27,
    D3DFMT_A8                   = 28,
    D3DFMT_A8R3G3B2             = 29,
    D3DFMT_X4R4G4B4             = 30,
    D3DFMT_A2B10G10R10          = 31,
    D3DFMT_A8B8G8R8             = 32,
    D3DFMT_X8B8G8R8             = 33,
    D3DFMT_G16R16               = 34,
    D3DFMT_A2R10G10B10          = 35,
    D3DFMT_A16B16G16R16         = 36,

    D3DFMT_A8P8                 = 40,
    D3DFMT_P8                   = 41,

    D3DFMT_L8                   = 50,
    D3DFMT_A8L8                 = 51,
    D3DFMT_A4L4                 = 52,

    D3DFMT_V8U8                 = 60,
    D3DFMT_L6V5U5               = 61,
    D3DFMT_X8L8V8U8             = 62,
    D3DFMT_Q8W8V8U8             = 63,
    D3DFMT_V16U16               = 64,
    D3DFMT_A2W10V10U10          = 67,
    D3DFMT_A8X8V8U8             = 68,
    D3DFMT_L8X8V8U8             = 69,

    // D3DFMT_UYVY                 = MAKEFOURCC('U', 'Y', 'V', 'Y'),
    D3DFMT_UYVY                 = Byte('U') or (Byte('Y') shl 8) or (Byte('V') shl 16) or (Byte('Y') shl 24),
    // D3DFMT_RGBG                 = MAKEFOURCC('R', 'G', 'B', 'G'),
    D3DFMT_RGBG                 = Byte('R') or (Byte('G') shl 8) or (Byte('B') shl 16) or (Byte('G') shl 24),
    // D3DFMT_YUY2                 = MAKEFOURCC('Y', 'U', 'Y', '2'),
    D3DFMT_YUY2                 = Byte('Y') or (Byte('U') shl 8) or (Byte('Y') shl 16) or (Byte('2') shl 24),
    // D3DFMT_GRGB                 = MAKEFOURCC('G', 'R', 'G', 'B'),
    D3DFMT_GRGB                 = Byte('G') or (Byte('R') shl 8) or (Byte('G') shl 16) or (Byte('B') shl 24),
    // D3DFMT_DXT1                 = MAKEFOURCC('D', 'X', 'T', '1'),
    D3DFMT_DXT1                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('1') shl 24),
    // D3DFMT_DXT2                 = MAKEFOURCC('D', 'X', 'T', '2'),
    D3DFMT_DXT2                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('2') shl 24),
    // D3DFMT_DXT3                 = MAKEFOURCC('D', 'X', 'T', '3'),
    D3DFMT_DXT3                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('3') shl 24),
    // D3DFMT_DXT4                 = MAKEFOURCC('D', 'X', 'T', '4'),
    D3DFMT_DXT4                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('4') shl 24),
    // D3DFMT_DXT5                 = MAKEFOURCC('D', 'X', 'T', '5'),
    D3DFMT_DXT5                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('5') shl 24),

    D3DFMT_D16_LOCKABLE         = 70,
    D3DFMT_D32                  = 71,
    D3DFMT_D15S1                = 73,
    D3DFMT_D24S8                = 75,
    D3DFMT_D24X8                = 77,
    D3DFMT_D24X4S4              = 79,
    D3DFMT_D16                  = 80,

    D3DFMT_D32F_LOCKABLE        = 82,
    D3DFMT_D24FS8               = 83,

{$IFDEF DIRECT3D_VERSION_9_VISTA}
    (* Z-Stencil formats valid for CPU access *)
    D3DFMT_D32_LOCKABLE         = 84,
    D3DFMT_S8_LOCKABLE          = 85,


{$ENDIF}

    D3DFMT_L16                  = 81,

    D3DFMT_VERTEXDATA           =100,
    D3DFMT_INDEX16              =101,
    D3DFMT_INDEX32              =102,

    D3DFMT_Q16W16V16U16         =110,

    // D3DFMT_MULTI2_ARGB8         = MAKEFOURCC('M','E','T','1'),
    D3DFMT_MULTI2_ARGB8         = Byte('M') or (Byte('E') shl 8) or (Byte('T') shl 16) or (Byte('1') shl 24),

    // Floating point surface formats

    // s10e5 formats (16-bits per channel)
    D3DFMT_R16F                 = 111,
    D3DFMT_G16R16F              = 112,
    D3DFMT_A16B16G16R16F        = 113,

    // IEEE s23e8 formats (32-bits per channel)
    D3DFMT_R32F                 = 114,
    D3DFMT_G32R32F              = 115,
    D3DFMT_A32B32G32R32F        = 116,

    D3DFMT_CxV8U8               = 117,

{$IFDEF DIRECT3D_VERSION_9_VISTA}
    // Monochrome 1 bit per pixel format
    D3DFMT_A1                   = 118,


    // Binary format indicating that the data has no inherent type
    D3DFMT_BINARYBUFFER         = 199,

{$ENDIF}

    D3DFMT_FORCE_DWORD          = $7fffffff
  );
{$ENDIF}
  {$EXTERNALSYM _D3DFORMAT}
  D3DFORMAT = _D3DFORMAT;
  {$EXTERNALSYM D3DFORMAT}
  PD3DFormat = ^TD3DFormat;
  TD3DFormat = _D3DFORMAT;

  { Display Modes }
  PD3DDisplayMode = ^TD3DDisplayMode;
  _D3DDISPLAYMODE = packed record
    Width: LongWord;
    Height: LongWord;
    RefreshRate: LongWord;
    Format: TD3DFormat;
  end {_D3DDISPLAYMODE};
  {$EXTERNALSYM _D3DDISPLAYMODE}
  D3DDISPLAYMODE = _D3DDISPLAYMODE;
  {$EXTERNALSYM D3DDISPLAYMODE}
  TD3DDisplayMode = _D3DDISPLAYMODE;

  { Creation Parameters }
  PD3DDeviceCreationParameters = ^TD3DDeviceCreationParameters;
  _D3DDEVICE_CREATION_PARAMETERS = packed record
    AdapterOrdinal: LongWord;
    DeviceType: TD3DDevType;
    hFocusWindow: HWND;
    BehaviorFlags: LongInt;
  end {_D3DDEVICE_CREATION_PARAMETERS};
  {$EXTERNALSYM _D3DDEVICE_CREATION_PARAMETERS}
  D3DDEVICE_CREATION_PARAMETERS = _D3DDEVICE_CREATION_PARAMETERS;
  {$EXTERNALSYM D3DDEVICE_CREATION_PARAMETERS}
  TD3DDeviceCreationParameters = _D3DDEVICE_CREATION_PARAMETERS;


  { SwapEffects }
  _D3DSWAPEFFECT = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DSWAPEFFECT_INVALID_0     {= 0},
    D3DSWAPEFFECT_DISCARD       {= 1},
    D3DSWAPEFFECT_FLIP          {= 2},
    D3DSWAPEFFECT_COPY          {= 3}
  {$ELSE}
    D3DSWAPEFFECT_DISCARD       = 1,
    D3DSWAPEFFECT_FLIP          = 2,
    D3DSWAPEFFECT_COPY          = 3
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DSWAPEFFECT}
  D3DSWAPEFFECT = _D3DSWAPEFFECT;
  {$EXTERNALSYM D3DSWAPEFFECT}
  TD3DSwapEffect = _D3DSWAPEFFECT;

  { Pool types }
  _D3DPOOL = (
    D3DPOOL_DEFAULT     {= 0},
    D3DPOOL_MANAGED     {= 1},
    D3DPOOL_SYSTEMMEM   {= 2},
    D3DPOOL_SCRATCH     {= 3}
  );
  {$EXTERNALSYM _D3DPOOL}
  D3DPOOL = _D3DPOOL;
  {$EXTERNALSYM D3DPOOL}
  TD3DPool = _D3DPOOL;


const
  { RefreshRate pre-defines }
  D3DPRESENT_RATE_DEFAULT         = $00000000;
  {$EXTERNALSYM D3DPRESENT_RATE_DEFAULT}

type
  { Resize Optional Parameters }
  PD3DPresentParameters = ^TD3DPresentParameters;
  _D3DPRESENT_PARAMETERS_ = packed record
    BackBufferWidth:                    LongWord;
    BackBufferHeight:                   LongWord;
    BackBufferFormat:                   TD3DFormat;
    BackBufferCount:                    LongWord;

    MultiSampleType:                    TD3DMultiSampleType;
    MultiSampleQuality:                 DWORD;

    SwapEffect:                         TD3DSwapEffect;
    hDeviceWindow:                      HWND;
    Windowed:                           Bool;
    EnableAutoDepthStencil:             Bool;
    AutoDepthStencilFormat:             TD3DFormat;
    Flags: LongInt;

    { FullScreen_RefreshRateInHz must be zero for Windowed mode }
    FullScreen_RefreshRateInHz:         LongWord;
    PresentationInterval:               LongWord;
  end {_D3DPRESENT_PARAMETERS_};
  {$EXTERNALSYM _D3DPRESENT_PARAMETERS_}
  D3DPRESENT_PARAMETERS = _D3DPRESENT_PARAMETERS_;
  {$EXTERNALSYM D3DPRESENT_PARAMETERS}
  TD3DPresentParameters = _D3DPRESENT_PARAMETERS_;

  // Values for D3DPRESENT_PARAMETERS.Flags

const
  D3DPRESENTFLAG_LOCKABLE_BACKBUFFER  = $00000001;
  {$EXTERNALSYM D3DPRESENTFLAG_LOCKABLE_BACKBUFFER}
  D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL = $00000002;
  {$EXTERNALSYM D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL}
  D3DPRESENTFLAG_DEVICECLIP           = $00000004;
  {$EXTERNALSYM D3DPRESENTFLAG_DEVICECLIP}
  D3DPRESENTFLAG_VIDEO                = $00000010;
  {$EXTERNALSYM D3DPRESENTFLAG_VIDEO}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DPRESENTFLAG_NOAUTOROTATE         = $00000020;
  {$EXTERNALSYM D3DPRESENTFLAG_NOAUTOROTATE}
  D3DPRESENTFLAG_UNPRUNEDMODE         = $00000040;
  {$EXTERNALSYM D3DPRESENTFLAG_UNPRUNEDMODE}

{$ENDIF}

  { Gamma Ramp: Same as DX7 }

type
  PD3DGammaRamp = ^TD3DGammaRamp;
  _D3DGAMMARAMP = packed record
    red   : array [0..255] of Word;
    green : array [0..255] of Word;
    blue  : array [0..255] of Word;
  end;
  {$EXTERNALSYM _D3DGAMMARAMP}
  D3DGAMMARAMP = _D3DGAMMARAMP;
  {$EXTERNALSYM D3DGAMMARAMP}
  TD3DGammaRamp = _D3DGAMMARAMP;

  { Back buffer types }
  _D3DBACKBUFFER_TYPE = (
    D3DBACKBUFFER_TYPE_MONO         {= 0},
    D3DBACKBUFFER_TYPE_LEFT         {= 1},
    D3DBACKBUFFER_TYPE_RIGHT        {= 2}
  );
  {$EXTERNALSYM _D3DBACKBUFFER_TYPE}
  D3DBACKBUFFER_TYPE = _D3DBACKBUFFER_TYPE;
  {$EXTERNALSYM D3DBACKBUFFER_TYPE}
  TD3DBackbufferType = _D3DBACKBUFFER_TYPE;


  { Types }
  _D3DRESOURCETYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DRTYPE_INVALID_0              {=  0},
    D3DRTYPE_SURFACE                {=  1},
    D3DRTYPE_VOLUME                 {=  2},
    D3DRTYPE_TEXTURE                {=  3},
    D3DRTYPE_VOLUMETEXTURE          {=  4},
    D3DRTYPE_CUBETEXTURE            {=  5},
    D3DRTYPE_VERTEXBUFFER           {=  6},
    D3DRTYPE_INDEXBUFFER            {=  7}  //if this changes, change _D3DDEVINFO_RESOURCEMANAGER definition
  {$ELSE}
    D3DRTYPE_SURFACE                =  1,
    D3DRTYPE_VOLUME                 =  2,
    D3DRTYPE_TEXTURE                =  3,
    D3DRTYPE_VOLUMETEXTURE          =  4,
    D3DRTYPE_CUBETEXTURE            =  5,
    D3DRTYPE_VERTEXBUFFER           =  6,
    D3DRTYPE_INDEXBUFFER            =  7   //if this changes, change _D3DDEVINFO_RESOURCEMANAGER definition
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DRESOURCETYPE}
  D3DRESOURCETYPE = _D3DRESOURCETYPE;
  {$EXTERNALSYM D3DRESOURCETYPE}
  TD3DResourceType = _D3DRESOURCETYPE;

const
  { Usages }
  D3DUSAGE_RENDERTARGET       = $00000001;
  {$EXTERNALSYM D3DUSAGE_RENDERTARGET}
  D3DUSAGE_DEPTHSTENCIL       = $00000002;
  {$EXTERNALSYM D3DUSAGE_DEPTHSTENCIL}
  D3DUSAGE_DYNAMIC            = $00000200;
  {$EXTERNALSYM D3DUSAGE_DYNAMIC}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DUSAGE_NONSECURE          = $00800000;
  {$EXTERNALSYM D3DUSAGE_NONSECURE}
{$ENDIF}

  // When passed to CheckDeviceFormat, D3DUSAGE_AUTOGENMIPMAP may return
  // D3DOK_NOAUTOGEN if the device doesn't support autogeneration for that format.
  // D3DOK_NOAUTOGEN is a success code, not a failure code... the SUCCEEDED and FAILED macros
  // will return true and false respectively for this code.
  D3DUSAGE_AUTOGENMIPMAP      = $00000400;
  {$EXTERNALSYM D3DUSAGE_AUTOGENMIPMAP}
  D3DUSAGE_DMAP               = $00004000;
  {$EXTERNALSYM D3DUSAGE_DMAP}

  // The following usages are valid only for querying CheckDeviceFormat
  D3DUSAGE_QUERY_LEGACYBUMPMAP            = $00008000;
  {$EXTERNALSYM D3DUSAGE_QUERY_LEGACYBUMPMAP}
  D3DUSAGE_QUERY_SRGBREAD                 = $00010000;
  {$EXTERNALSYM D3DUSAGE_QUERY_SRGBREAD}
  D3DUSAGE_QUERY_FILTER                   = $00020000;
  {$EXTERNALSYM D3DUSAGE_QUERY_FILTER}
  D3DUSAGE_QUERY_SRGBWRITE                = $00040000;
  {$EXTERNALSYM D3DUSAGE_QUERY_SRGBWRITE}
  D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING = $00080000;
  {$EXTERNALSYM D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING}
  D3DUSAGE_QUERY_VERTEXTEXTURE            = $00100000;
  {$EXTERNALSYM D3DUSAGE_QUERY_VERTEXTEXTURE}
  D3DUSAGE_QUERY_WRAPANDMIP               = $00200000;
  {$EXTERNALSYM D3DUSAGE_QUERY_WRAPANDMIP}


  { Usages for Vertex/Index buffers }
  D3DUSAGE_WRITEONLY          = $00000008;
  {$EXTERNALSYM D3DUSAGE_WRITEONLY}
  D3DUSAGE_SOFTWAREPROCESSING = $00000010;
  {$EXTERNALSYM D3DUSAGE_SOFTWAREPROCESSING}
  D3DUSAGE_DONOTCLIP          = $00000020;
  {$EXTERNALSYM D3DUSAGE_DONOTCLIP}
  D3DUSAGE_POINTS             = $00000040;
  {$EXTERNALSYM D3DUSAGE_POINTS}
  D3DUSAGE_RTPATCHES          = $00000080;
  {$EXTERNALSYM D3DUSAGE_RTPATCHES}
  D3DUSAGE_NPATCHES           = $00000100;
  {$EXTERNALSYM D3DUSAGE_NPATCHES}








type
  { CubeMap Face identifiers }
  _D3DCUBEMAP_FACES = (
    D3DCUBEMAP_FACE_POSITIVE_X     {= 0},
    D3DCUBEMAP_FACE_NEGATIVE_X     {= 1},
    D3DCUBEMAP_FACE_POSITIVE_Y     {= 2},
    D3DCUBEMAP_FACE_NEGATIVE_Y     {= 3},
    D3DCUBEMAP_FACE_POSITIVE_Z     {= 4},
    D3DCUBEMAP_FACE_NEGATIVE_Z     {= 5}
  );
  {$EXTERNALSYM _D3DCUBEMAP_FACES}
  D3DCUBEMAP_FACES = _D3DCUBEMAP_FACES;
  {$EXTERNALSYM D3DCUBEMAP_FACES}
  TD3DCubemapFaces = _D3DCUBEMAP_FACES;


const
  { Lock flags }
  D3DLOCK_READONLY         = $00000010;
  {$EXTERNALSYM D3DLOCK_READONLY}
  D3DLOCK_DISCARD          = $00002000;
  {$EXTERNALSYM D3DLOCK_DISCARD}
  D3DLOCK_NOOVERWRITE      = $00001000;
  {$EXTERNALSYM D3DLOCK_NOOVERWRITE}
  D3DLOCK_NOSYSLOCK        = $00000800;
  {$EXTERNALSYM D3DLOCK_NOSYSLOCK}
  D3DLOCK_DONOTWAIT        = $00004000;
  {$EXTERNALSYM D3DLOCK_DONOTWAIT}

  D3DLOCK_NO_DIRTY_UPDATE  = $00008000;
  {$EXTERNALSYM D3DLOCK_NO_DIRTY_UPDATE}






type
  { Vertex Buffer Description }
  PD3DVertexBufferDesc = ^TD3DVertexBufferDesc;
  _D3DVERTEXBUFFER_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;
    Size   : LongWord;

    FVF    : DWord;
  end;
  {$EXTERNALSYM _D3DVERTEXBUFFER_DESC}
  D3DVERTEXBUFFER_DESC = _D3DVERTEXBUFFER_DESC;
  {$EXTERNALSYM D3DVERTEXBUFFER_DESC}
  TD3DVertexBufferDesc = _D3DVERTEXBUFFER_DESC;

  { Index Buffer Description }
  PD3DIndexBufferDesc = ^TD3DIndexBufferDesc;
  _D3DINDEXBUFFER_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;
    Size   : LongWord;
  end {_D3DINDEXBUFFER_DESC};
  {$EXTERNALSYM _D3DINDEXBUFFER_DESC}
  D3DINDEXBUFFER_DESC = _D3DINDEXBUFFER_DESC;
  {$EXTERNALSYM D3DINDEXBUFFER_DESC}
  TD3DIndexBufferDesc = _D3DINDEXBUFFER_DESC;


 { Surface Description }
  PD3DSurfaceDesc = ^TD3DSurfaceDesc;
  _D3DSURFACE_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;

    MultiSampleType: TD3DMultiSampleType;
    MultiSampleQuality: DWORD;
    Width  : LongWord;
    Height : LongWord;
  end {_D3DSURFACE_DESC};
  {$EXTERNALSYM _D3DSURFACE_DESC}
  D3DSURFACE_DESC = _D3DSURFACE_DESC;
  {$EXTERNALSYM D3DSURFACE_DESC}
  TD3DSurfaceDesc = _D3DSURFACE_DESC;

  PD3DVolumeDesc = ^TD3DVolumeDesc;
  _D3DVOLUME_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;

    Width  : LongWord;
    Height : LongWord;
    Depth  : LongWord;
  end {_D3DVOLUME_DESC};
  {$EXTERNALSYM _D3DVOLUME_DESC}
  D3DVOLUME_DESC = _D3DVOLUME_DESC;
  {$EXTERNALSYM D3DVOLUME_DESC}
  TD3DVolumeDesc = _D3DVOLUME_DESC;

  { Structure for LockRect }
  PD3DLockedRect = ^TD3DLockedRect;
  _D3DLOCKED_RECT = packed record
    Pitch: Integer;
    pBits: Pointer; // void*
  end {_D3DLOCKED_RECT};
  {$EXTERNALSYM _D3DLOCKED_RECT}
  D3DLOCKED_RECT = _D3DLOCKED_RECT;
  {$EXTERNALSYM D3DLOCKED_RECT}
  TD3DLockedRect = _D3DLOCKED_RECT;

  { Structures for LockBox }
  PD3DBox = ^TD3DBox;
  _D3DBOX = packed record
    Left        : LongWord;
    Top         : LongWord;
    Right       : LongWord;
    Bottom      : LongWord;
    Front       : LongWord;
    Back        : LongWord;
  end {_D3DBOX};
  {$EXTERNALSYM _D3DBOX}
  D3DBOX = _D3DBOX;
  {$EXTERNALSYM D3DBOX}
  TD3DBox = _D3DBOX;

  PD3DLockedBox = ^TD3DLockedBox;
  _D3DLOCKED_BOX = packed record
    RowPitch    : Integer;
    SlicePitch  : Integer;
    pBits       : Pointer; // void*
  end {_D3DLOCKED_BOX};
  {$EXTERNALSYM _D3DLOCKED_BOX}
  D3DLOCKED_BOX = _D3DLOCKED_BOX;
  {$EXTERNALSYM D3DLOCKED_BOX}
  TD3DLockedBox = _D3DLOCKED_BOX;

  { Structures for LockRange }
  PD3DRange = ^TD3DRange;
  _D3DRANGE = packed record
    Offset      : LongWord;
    Size        : LongWord;
  end {_D3DRANGE};
  {$EXTERNALSYM _D3DRANGE}
  D3DRANGE = _D3DRANGE;
  {$EXTERNALSYM D3DRANGE}
  TD3DRange = _D3DRANGE;

  { Structures for high order primitives }
  PD3DRectPatchInfo = ^TD3DRectPatchInfo;
  _D3DRECTPATCH_INFO = packed record
    StartVertexOffsetWidth  : LongWord;
    StartVertexOffsetHeight : LongWord;
    Width                   : LongWord;
    Height                  : LongWord;
    Stride                  : LongWord;
    Basis                   : TD3DBasisType;
    Degree                  : TD3DDegreeType;
  end;
  {$EXTERNALSYM _D3DRECTPATCH_INFO}
  D3DRECTPATCH_INFO = _D3DRECTPATCH_INFO;
  {$EXTERNALSYM D3DRECTPATCH_INFO}
  TD3DRectPatchInfo = _D3DRECTPATCH_INFO;

  PD3DTriPatchInfo = ^TD3DTriPatchInfo;
  _D3DTRIPATCH_INFO = packed record
    StartVertexOffset : LongWord;
    NumVertices       : LongWord;
    Basis             : TD3DBasisType;
    Degree            : TD3DDegreeType;
  end;
  {$EXTERNALSYM _D3DTRIPATCH_INFO}
  D3DTRIPATCH_INFO = _D3DTRIPATCH_INFO;
  {$EXTERNALSYM D3DTRIPATCH_INFO}
  TD3DTriPatchInfo = _D3DTRIPATCH_INFO;

const
  { Adapter Identifier }
  MAX_DEVICE_IDENTIFIER_STRING  = 512;
  {$EXTERNALSYM MAX_DEVICE_IDENTIFIER_STRING}
type
  PD3DAdapterIdentifier9 = ^TD3DAdapterIdentifier9;
  _D3DADAPTER_IDENTIFIER9 = packed record
    Driver      : array [0..MAX_DEVICE_IDENTIFIER_STRING-1] of Char;
    Description : array [0..MAX_DEVICE_IDENTIFIER_STRING-1] of Char;
    DeviceName  : array [0..31] of Char;   { Device name for GDI (ex. \\.\DISPLAY1) }

{$IFDEF WIN32}
    DriverVersion               : Int64;   { Defined for 32 bit components }
{$ELSE}
    DriverVersionLowPart        : DWord;   { Defined for 16 bit driver components }
    DriverVersionHighPart       : DWord;
{$ENDIF}

    VendorId    : DWord;
    DeviceId    : DWord;
    SubSysId    : DWord;
    Revision    : DWord;

    DeviceIdentifier : TGUID;

    WHQLLevel   : DWord;

  end;
  {$EXTERNALSYM _D3DADAPTER_IDENTIFIER9}
  D3DADAPTER_IDENTIFIER9 = _D3DADAPTER_IDENTIFIER9;
  {$EXTERNALSYM D3DADAPTER_IDENTIFIER9}
  TD3DAdapterIdentifier9 = _D3DADAPTER_IDENTIFIER9;


  { Raster Status structure returned by GetRasterStatus }
  PD3DRasterStatus = ^TD3DRasterStatus;
  _D3DRASTER_STATUS = packed record
    InVBlank : Bool;
    ScanLine : LongWord;
  end;
  {$EXTERNALSYM _D3DRASTER_STATUS}
  D3DRASTER_STATUS = _D3DRASTER_STATUS;
  {$EXTERNALSYM D3DRASTER_STATUS}
  TD3DRasterStatus = _D3DRASTER_STATUS;



{ Debug monitor tokens (DEBUG only)

   Note that if D3DRS_DEBUGMONITORTOKEN is set, the call is treated as
   passing a token to the debug monitor.  For example, if, after passing
   D3DDMT_ENABLE/DISABLE to D3DRS_DEBUGMONITORTOKEN other token values
   are passed in, the enabled/disabled state of the debug
   monitor will still persist.

   The debug monitor defaults to enabled.

   Calling GetRenderState on D3DRS_DEBUGMONITORTOKEN is not of any use.
}
  _D3DDEBUGMONITORTOKENS = DWord;
  {$EXTERNALSYM _D3DDEBUGMONITORTOKENS}
  D3DDEBUGMONITORTOKENS = _D3DDEBUGMONITORTOKENS;
  {$EXTERNALSYM D3DDEBUGMONITORTOKENS}
  TD3DDebugMonitorTokens = _D3DDEBUGMONITORTOKENS;

const
  D3DDMT_ENABLE            = 0;    // enable debug monitor
  {$EXTERNALSYM D3DDMT_ENABLE}
  D3DDMT_DISABLE           = 1;    // disable debug monitor
  {$EXTERNALSYM D3DDMT_DISABLE}

{$IFNDEF SUPPORTS_EXPL_ENUMS}
const
  // Async feedback
  D3DQUERYTYPE_VCACHE                 = 4; { D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_VCACHE}
  D3DQUERYTYPE_RESOURCEMANAGER        = 5; { D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_RESOURCEMANAGER}
  D3DQUERYTYPE_VERTEXSTATS            = 6; { D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_VERTEXSTATS}
  D3DQUERYTYPE_EVENT                  = 8; { D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_EVENT}
  D3DQUERYTYPE_OCCLUSION              = 9; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_OCCLUSION}
  D3DQUERYTYPE_TIMESTAMP              = 10; { D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_TIMESTAMP}
  D3DQUERYTYPE_TIMESTAMPDISJOINT      = 11; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_TIMESTAMPDISJOINT}
  D3DQUERYTYPE_TIMESTAMPFREQ          = 12; { D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_TIMESTAMPFREQ}
  D3DQUERYTYPE_PIPELINETIMINGS        = 13; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_PIPELINETIMINGS}
  D3DQUERYTYPE_INTERFACETIMINGS       = 14; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_INTERFACETIMINGS}
  D3DQUERYTYPE_VERTEXTIMINGS          = 15; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_VERTEXTIMINGS}
  D3DQUERYTYPE_PIXELTIMINGS           = 16; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_PIXELTIMINGS}
  D3DQUERYTYPE_BANDWIDTHTIMINGS       = 17; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_BANDWIDTHTIMINGS}
  D3DQUERYTYPE_CACHEUTILIZATION       = 18; { D3DISSUE_BEGIN, D3DISSUE_END }
  {$EXTERNALSYM D3DQUERYTYPE_CACHEUTILIZATION}
type
  _D3DQUERYTYPE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
{$ELSE}
type
  // Async feedback
  {$MINENUMSIZE 1} // Forces TD3DQueryType be 1 byte enum
  _D3DQUERYTYPE = (
    D3DQUERYTYPE_VCACHE                 = 4, { D3DISSUE_END }
    D3DQUERYTYPE_RESOURCEMANAGER        = 5, { D3DISSUE_END }
    D3DQUERYTYPE_VERTEXSTATS            = 6, { D3DISSUE_END }
    D3DQUERYTYPE_EVENT                  = 8, { D3DISSUE_END }
    D3DQUERYTYPE_OCCLUSION              = 9,  { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_TIMESTAMP              = 10, { D3DISSUE_END }
    D3DQUERYTYPE_TIMESTAMPDISJOINT      = 11, { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_TIMESTAMPFREQ          = 12, { D3DISSUE_END }
    D3DQUERYTYPE_PIPELINETIMINGS        = 13, { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_INTERFACETIMINGS       = 14, { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_VERTEXTIMINGS          = 15, { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_PIXELTIMINGS           = 16, { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_BANDWIDTHTIMINGS       = 17, { D3DISSUE_BEGIN, D3DISSUE_END }
    D3DQUERYTYPE_CACHEUTILIZATION       = 18  { D3DISSUE_BEGIN, D3DISSUE_END }
  );
  {$MINENUMSIZE 4} // Restores enums to be 4 byte in size
{$ENDIF}
  {$EXTERNALSYM _D3DQUERYTYPE}
  D3DQUERYTYPE = _D3DQUERYTYPE;
  {$EXTERNALSYM D3DQUERYTYPE}
  TD3DQueryType = _D3DQUERYTYPE;

const
  // Flags field for Issue
  D3DISSUE_END     = (1 shl 0); // Tells the runtime to issue the end of a query, changing it's state to "non-signaled".
  {$EXTERNALSYM D3DISSUE_END}
  D3DISSUE_BEGIN   = (1 shl 1); // Tells the runtime to issue the beginng of a query.
  {$EXTERNALSYM D3DISSUE_BEGIN}


  // Flags field for GetData
  D3DGETDATA_FLUSH = (1 shl 0); // Tells the runtime to flush if the query is outstanding.
  {$EXTERNALSYM D3DGETDATA_FLUSH}

type
  PD3DResourceStats = ^TD3DResourceStats;
  _D3DRESOURCESTATS = packed record
  // Data collected since last Present()
    bThrashing                  : BOOL;  (* indicates if thrashing *)
    ApproxBytesDownloaded       : DWORD; (* Approximate number of bytes downloaded by resource manager *)
    NumEvicts                   : DWORD; (* number of objects evicted *)
    NumVidCreates               : DWORD; (* number of objects created in video memory *)
    LastPri                     : DWORD; (* priority of last object evicted *)
    NumUsed                     : DWORD; (* number of objects set to the device *)
    NumUsedInVidMem             : DWORD; (* number of objects set to the device, which are already in video memory *)
  // Persistent data
    WorkingSet                  : DWORD; (* number of objects in video memory *)
    WorkingSetBytes             : DWORD; (* number of bytes in video memory *)
    TotalManaged                : DWORD; (* total number of managed objects *)
    TotalBytes                  : DWORD; (* total number of bytes of managed objects *)
  end;
  {$EXTERNALSYM _D3DRESOURCESTATS}
  D3DRESOURCESTATS = _D3DRESOURCESTATS;
  {$EXTERNALSYM D3DRESOURCESTATS}
  TD3DResourceStats = _D3DRESOURCESTATS;

const
  D3DRTYPECOUNT = (DWORD(D3DRTYPE_INDEXBUFFER) + 1);
  {$EXTERNALSYM D3DRTYPECOUNT}

type
  PD3DDevInfoResourceManager = ^TD3DDevInfoResourceManager;
  _D3DDEVINFO_RESOURCEMANAGER = packed record
//#ifndef WOW64_ENUM_WORKAROUND
    stats: array [0..D3DRTYPECOUNT-1] of TD3DResourceStats;
//#else
//  stats: array[0..7] of TD3DResourceStats; 
//#endif
  end;
  {$EXTERNALSYM _D3DDEVINFO_RESOURCEMANAGER}
  D3DDEVINFO_RESOURCEMANAGER = _D3DDEVINFO_RESOURCEMANAGER;
  {$EXTERNALSYM D3DDEVINFO_RESOURCEMANAGER}
  TD3DDevInfoResourceManager = _D3DDEVINFO_RESOURCEMANAGER;

  PD3DDevInfoD3DVertexStats = ^TD3DDevInfoD3DVertexStats;
  _D3DDEVINFO_D3DVERTEXSTATS = packed record
    NumRenderedTriangles        : DWORD; (* total number of triangles that are not clipped in this frame *)
    NumExtraClippingTriangles   : DWORD; (* Number of new triangles generated by clipping *)
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3DVERTEXSTATS}
  D3DDEVINFO_D3DVERTEXSTATS = _D3DDEVINFO_D3DVERTEXSTATS;
  {$EXTERNALSYM D3DDEVINFO_D3DVERTEXSTATS}
  TD3DDevInfoD3DVertexStats = _D3DDEVINFO_D3DVERTEXSTATS;

  PD3DDevInfoVCache = ^TD3DDevInfoVCache;
  _D3DDEVINFO_VCACHE = packed record
    Pattern     : DWORD;        (* bit pattern, return value must be FOUR_CC('C', 'A', 'C', 'H') *)
    OptMethod   : DWORD;        (* optimization method 0 means longest strips, 1 means vertex cache based *)
    CacheSize   : DWORD;        (* cache size to optimize for  (only required if type is 1) *)
    MagicNumber : DWORD;        (* used to determine when to restart strips (only required if type is 1)*)
  end;
  {$EXTERNALSYM _D3DDEVINFO_VCACHE}
  D3DDEVINFO_VCACHE = _D3DDEVINFO_VCACHE;
  {$EXTERNALSYM D3DDEVINFO_VCACHE}
  TD3DDevInfoVCache = _D3DDEVINFO_VCACHE;


  PD3DDevInfoD3D9PipelineTimings = ^TD3DDevInfoD3D9PipelineTimings;
  _D3DDEVINFO_D3D9PIPELINETIMINGS = packed record
    VertexProcessingTimePercent: Single;
    PixelProcessingTimePercent: Single;
    OtherGPUProcessingTimePercent: Single;
    GPUIdleTimePercent: Single;
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3D9PIPELINETIMINGS}
  D3DDEVINFO_D3D9PIPELINETIMINGS = _D3DDEVINFO_D3D9PIPELINETIMINGS;
  {$EXTERNALSYM D3DDEVINFO_D3D9PIPELINETIMINGS}
  TD3DDevInfoD3D9PipelineTimings = _D3DDEVINFO_D3D9PIPELINETIMINGS;

  PD3DDevInfoD3D9InterfaceTimings = ^TD3DDevInfoD3D9InterfaceTimings;
  _D3DDEVINFO_D3D9INTERFACETIMINGS = packed record
    WaitingForGPUToUseApplicationResourceTimePercent: Single;
    WaitingForGPUToAcceptMoreCommandsTimePercent: Single;
    WaitingForGPUToStayWithinLatencyTimePercent: Single;
    WaitingForGPUExclusiveResourceTimePercent: Single;
    WaitingForGPUOtherTimePercent: Single;
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3D9INTERFACETIMINGS}
  D3DDEVINFO_D3D9INTERFACETIMINGS = _D3DDEVINFO_D3D9INTERFACETIMINGS;
  {$EXTERNALSYM D3DDEVINFO_D3D9INTERFACETIMINGS}
  TD3DDevInfoD3D9InterfaceTimings = _D3DDEVINFO_D3D9INTERFACETIMINGS;

  PD3DDevInfoD3D9StageTimings = ^TD3DDevInfoD3D9StageTimings;
  _D3DDEVINFO_D3D9STAGETIMINGS = packed record
    MemoryProcessingPercent: Single;
    ComputationProcessingPercent: Single;
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3D9STAGETIMINGS}
  D3DDEVINFO_D3D9STAGETIMINGS = _D3DDEVINFO_D3D9STAGETIMINGS;
  {$EXTERNALSYM D3DDEVINFO_D3D9STAGETIMINGS}
  TD3DDevInfoD3D9StageTimings = _D3DDEVINFO_D3D9STAGETIMINGS;

  PD3DDevInfoD3D9BandwidthTimings = ^TD3DDevInfoD3D9BandwidthTimings;
  _D3DDEVINFO_D3D9BANDWIDTHTIMINGS = packed record
    MaxBandwidthUtilized: Single;
    FrontEndUploadMemoryUtilizedPercent: Single;
    VertexRateUtilizedPercent: Single;
    TriangleSetupRateUtilizedPercent: Single;
    FillRateUtilizedPercent: Single;
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3D9BANDWIDTHTIMINGS}
  D3DDEVINFO_D3D9BANDWIDTHTIMINGS = _D3DDEVINFO_D3D9BANDWIDTHTIMINGS;
  {$EXTERNALSYM D3DDEVINFO_D3D9BANDWIDTHTIMINGS}
  TD3DDevInfoD3D9BandwidthTimings = _D3DDEVINFO_D3D9BANDWIDTHTIMINGS;

  PD3DDevInfoD3D9CacheUtilization = ^TD3DDevInfoD3D9CacheUtilization;
  _D3DDEVINFO_D3D9CACHEUTILIZATION = packed record
    TextureCacheHitRate: Single; // Percentage of cache hits
    PostTransformVertexCacheHitRate: Single;
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3D9CACHEUTILIZATION}
  D3DDEVINFO_D3D9CACHEUTILIZATION = _D3DDEVINFO_D3D9CACHEUTILIZATION;
  {$EXTERNALSYM D3DDEVINFO_D3D9CACHEUTILIZATION}
  TD3DDevInfoD3D9CacheUtilization = _D3DDEVINFO_D3D9CACHEUTILIZATION;

{$IFDEF DIRECT3D_VERSION_9_VISTA}

  PD3DComposeRectsOp = ^TD3DComposeRectsOp;
  _D3DCOMPOSERECTSOP =
  (
    D3DCOMPOSERECTS_INVALID_0,
    D3DCOMPOSERECTS_COPY     {= 1},
    D3DCOMPOSERECTS_OR       {= 2},
    D3DCOMPOSERECTS_AND      {= 3},
    D3DCOMPOSERECTS_NEG      {= 4}
  );
  {$EXTERNALSYM _D3DCOMPOSERECTSOP}
  D3DCOMPOSERECTSOP = _D3DCOMPOSERECTSOP;
  {$EXTERNALSYM D3DCOMPOSERECTSOP}
  TD3DComposeRectsOp = _D3DCOMPOSERECTSOP;

  PD3DComposeRectDesc = ^TD3DComposeRectDesc;
  _D3DCOMPOSERECTDESC = record
    X, Y: Word;           // Top-left coordinates of a rect in the source surface
    Width, Height: Word;  // Dimensions of the rect
  end;
  {$EXTERNALSYM _D3DCOMPOSERECTDESC}
  D3DCOMPOSERECTDESC = _D3DCOMPOSERECTDESC;
  {$EXTERNALSYM D3DCOMPOSERECTDESC}
  TD3DComposeRectDesc = _D3DCOMPOSERECTDESC;

  PD3DComposeRectDestination = ^TD3DComposeRectDestination;
  _D3DCOMPOSERECTDESTINATION = record
    SrcRectIndex: Word;    // Index of D3DCOMPOSERECTDESC
    Reserved: Word;        // For alignment
    X, Y:  Smallint;       // Top-left coordinates of the rect in the destination surface
  end;
  {$EXTERNALSYM _D3DCOMPOSERECTDESTINATION}
  D3DCOMPOSERECTDESTINATION = _D3DCOMPOSERECTDESTINATION;
  {$EXTERNALSYM D3DCOMPOSERECTDESTINATION}
  TD3DComposeRectDestination = _D3DCOMPOSERECTDESTINATION;

const
  D3DCOMPOSERECTS_MAXNUMRECTS = $FFFF;
  {$EXTERNALSYM D3DCOMPOSERECTS_MAXNUMRECTS}
  D3DCONVOLUTIONMONO_MAXWIDTH  = 7;
  {$EXTERNALSYM D3DCONVOLUTIONMONO_MAXWIDTH}
  D3DCONVOLUTIONMONO_MAXHEIGHT = D3DCONVOLUTIONMONO_MAXWIDTH;
  {$EXTERNALSYM D3DCONVOLUTIONMONO_MAXHEIGHT}
  D3DFMT_A1_SURFACE_MAXWIDTH  = 8192;
  {$EXTERNALSYM D3DFMT_A1_SURFACE_MAXWIDTH}
  D3DFMT_A1_SURFACE_MAXHEIGHT = 2048;
  {$EXTERNALSYM D3DFMT_A1_SURFACE_MAXHEIGHT}


type
  PD3DPresentStats = ^TD3DPresentStats;
  _D3DPRESENTSTATS = record
    PresentCount: LongWord;
    PresentRefreshCount: LongWord;
    SyncRefreshCount: LongWord;
    SyncQPCTime: LARGE_INTEGER;
    SyncGPUTime: LARGE_INTEGER;
  end;
  {$EXTERNALSYM _D3DPRESENTSTATS}
  D3DPRESENTSTATS = _D3DPRESENTSTATS;
  {$EXTERNALSYM D3DPRESENTSTATS}
  TD3DPresentStats = _D3DPRESENTSTATS;

  PD3DScanlineOrdering = ^TD3DScanlineOrdering;
  D3DSCANLINEORDERING = (
    D3DSCANLINEORDERING_INVALID_0,
    D3DSCANLINEORDERING_PROGRESSIVE                {= 1},
    D3DSCANLINEORDERING_INTERLACED                 {= 2}
  );
  {$EXTERNALSYM D3DSCANLINEORDERING}
  TD3DScanlineOrdering = D3DSCANLINEORDERING;


  PD3DDisplayModeEx = ^TD3DDisplayModeEx;
  D3DDISPLAYMODEEX = record
    Size: LongWord;
    Width: LongWord;
    Height: LongWord;
    RefreshRate: LongWord;
    Format: TD3DFormat;
    ScanLineOrdering: TD3DScanlineOrdering;
  end;
  {$EXTERNALSYM D3DDISPLAYMODEEX}
  TD3DDisplayModeEx = D3DDISPLAYMODEEX;

  PD3DDisplayModeFilter = ^TD3DDisplayModeFilter;
  D3DDISPLAYMODEFILTER = record
    Size: LongWord;
    Format: TD3DFormat;
    ScanLineOrdering: TD3DScanlineOrdering;
  end;
  {$EXTERNALSYM D3DDISPLAYMODEFILTER}
  TD3DDisplayModeFilter = D3DDISPLAYMODEFILTER;


  PD3DDisplayRotation = ^TD3DDisplayRotation;
  D3DDISPLAYROTATION =
  (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DDISPLAYROTATION_INVALID_0,
    D3DDISPLAYROTATION_IDENTITY {= 1}, // No rotation.
    D3DDISPLAYROTATION_90       {= 2}, // Rotated 90 degrees.
    D3DDISPLAYROTATION_180      {= 3}, // Rotated 180 degrees.
    D3DDISPLAYROTATION_270      {= 4}  // Rotated 270 degrees.
  {$ELSE}
    D3DDISPLAYROTATION_IDENTITY = 1, // No rotation.
    D3DDISPLAYROTATION_90       = 2, // Rotated 90 degrees.
    D3DDISPLAYROTATION_180      = 3, // Rotated 180 degrees.
    D3DDISPLAYROTATION_270      = 4  // Rotated 270 degrees.
  {$ENDIF}
  );
  {$EXTERNALSYM D3DDISPLAYROTATION}
  TD3DDisplayRotation = D3DDISPLAYROTATION;

{$ENDIF}




(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       d3d9caps.h
 *  Content:    Direct3D capabilities include file
 *
 ***************************************************************************)

type
  PD3DVShaderCaps2_0 = ^TD3DVShaderCaps2_0;
  _D3DVSHADERCAPS2_0 = packed record
    Caps:                     DWORD;
    DynamicFlowControlDepth:  Integer;
    NumTemps:                 Integer;
    StaticFlowControlDepth:   Integer;
  end;
  {$EXTERNALSYM _D3DVSHADERCAPS2_0}
  D3DVSHADERCAPS2_0 = _D3DVSHADERCAPS2_0;
  {$EXTERNALSYM D3DVSHADERCAPS2_0}
  TD3DVShaderCaps2_0 = _D3DVSHADERCAPS2_0;

const
  D3DVS20CAPS_PREDICATION              = (1 shl 0);
  {$EXTERNALSYM D3DVS20CAPS_PREDICATION}

  D3DVS20_MAX_DYNAMICFLOWCONTROLDEPTH  = 24;
  {$EXTERNALSYM D3DVS20_MAX_DYNAMICFLOWCONTROLDEPTH}
  D3DVS20_MIN_DYNAMICFLOWCONTROLDEPTH  = 0;
  {$EXTERNALSYM D3DVS20_MIN_DYNAMICFLOWCONTROLDEPTH}
  D3DVS20_MAX_NUMTEMPS                 = 32;
  {$EXTERNALSYM D3DVS20_MAX_NUMTEMPS}
  D3DVS20_MIN_NUMTEMPS                 = 12;
  {$EXTERNALSYM D3DVS20_MIN_NUMTEMPS}
  D3DVS20_MAX_STATICFLOWCONTROLDEPTH   = 4;
  {$EXTERNALSYM D3DVS20_MAX_STATICFLOWCONTROLDEPTH}
  D3DVS20_MIN_STATICFLOWCONTROLDEPTH   = 1;
  {$EXTERNALSYM D3DVS20_MIN_STATICFLOWCONTROLDEPTH}

type
  PD3DPShaderCaps2_0 = ^TD3DPShaderCaps2_0;
  _D3DPSHADERCAPS2_0 = packed record
    Caps:                     DWORD;
    DynamicFlowControlDepth:  Integer;
    NumTemps:                 Integer;
    StaticFlowControlDepth:   Integer;
    NumInstructionSlots:      Integer;
  end;
  {$EXTERNALSYM _D3DPSHADERCAPS2_0}
  D3DPSHADERCAPS2_0 = _D3DPSHADERCAPS2_0;
  {$EXTERNALSYM D3DPSHADERCAPS2_0}
  TD3DPShaderCaps2_0 = _D3DPSHADERCAPS2_0;

const
  D3DPS20CAPS_ARBITRARYSWIZZLE         = (1 shl 0);
  {$EXTERNALSYM D3DPS20CAPS_ARBITRARYSWIZZLE}
  D3DPS20CAPS_GRADIENTINSTRUCTIONS     = (1 shl 1);
  {$EXTERNALSYM D3DPS20CAPS_GRADIENTINSTRUCTIONS}
  D3DPS20CAPS_PREDICATION              = (1 shl 2);
  {$EXTERNALSYM D3DPS20CAPS_PREDICATION}
  D3DPS20CAPS_NODEPENDENTREADLIMIT     = (1 shl 3);
  {$EXTERNALSYM D3DPS20CAPS_NODEPENDENTREADLIMIT}
  D3DPS20CAPS_NOTEXINSTRUCTIONLIMIT    = (1 shl 4);
  {$EXTERNALSYM D3DPS20CAPS_NOTEXINSTRUCTIONLIMIT}

  D3DPS20_MAX_DYNAMICFLOWCONTROLDEPTH  = 24;
  {$EXTERNALSYM D3DPS20_MAX_DYNAMICFLOWCONTROLDEPTH}
  D3DPS20_MIN_DYNAMICFLOWCONTROLDEPTH  = 0;
  {$EXTERNALSYM D3DPS20_MIN_DYNAMICFLOWCONTROLDEPTH}
  D3DPS20_MAX_NUMTEMPS                 = 32;
  {$EXTERNALSYM D3DPS20_MAX_NUMTEMPS}
  D3DPS20_MIN_NUMTEMPS                 = 12;
  {$EXTERNALSYM D3DPS20_MIN_NUMTEMPS}
  D3DPS20_MAX_STATICFLOWCONTROLDEPTH   = 4;
  {$EXTERNALSYM D3DPS20_MAX_STATICFLOWCONTROLDEPTH}
  D3DPS20_MIN_STATICFLOWCONTROLDEPTH   = 0;
  {$EXTERNALSYM D3DPS20_MIN_STATICFLOWCONTROLDEPTH}
  D3DPS20_MAX_NUMINSTRUCTIONSLOTS      = 512;
  {$EXTERNALSYM D3DPS20_MAX_NUMINSTRUCTIONSLOTS}
  D3DPS20_MIN_NUMINSTRUCTIONSLOTS      = 96;
  {$EXTERNALSYM D3DPS20_MIN_NUMINSTRUCTIONSLOTS}

  D3DMIN30SHADERINSTRUCTIONS           = 512;
  {$EXTERNALSYM D3DMIN30SHADERINSTRUCTIONS}
  D3DMAX30SHADERINSTRUCTIONS           = 32768;
  {$EXTERNALSYM D3DMAX30SHADERINSTRUCTIONS}

type
  PD3DCaps9 = ^TD3DCaps9;
  _D3DCAPS9 = record
    (* Device Info *)
    DeviceType: TD3DDevType;
    AdapterOrdinal: DWord;

    (* Caps from DX7 Draw *)
    Caps: DWord;
    Caps2: DWord;
    Caps3: DWord;
    PresentationIntervals: DWord;

    (* Cursor Caps *)
    CursorCaps: DWORD;

    (* 3D Device Caps *)
    DevCaps: DWord;
    PrimitiveMiscCaps: DWord;
    RasterCaps: DWord;
    ZCmpCaps: DWord;
    SrcBlendCaps: DWord;
    DestBlendCaps: DWord;
    AlphaCmpCaps: DWord;
    ShadeCaps: DWord;
    TextureCaps: DWord;
    TextureFilterCaps: DWord;           // D3DPTFILTERCAPS for IDirect3DTexture9's
    CubeTextureFilterCaps: DWord;       // D3DPTFILTERCAPS for IDirect3DCubeTexture9's
    VolumeTextureFilterCaps: DWord;     // D3DPTFILTERCAPS for IDirect3DVolumeTexture9's
    TextureAddressCaps: DWord;          // D3DPTADDRESSCAPS for IDirect3DTexture9's
    VolumeTextureAddressCaps: DWord;    // D3DPTADDRESSCAPS for IDirect3DVolumeTexture9's

    LineCaps: DWord;                    // D3DLINECAPS

    MaxTextureWidth, MaxTextureHeight: DWord;
    MaxVolumeExtent: DWord;

    MaxTextureRepeat: DWord;
    MaxTextureAspectRatio: DWord;
    MaxAnisotropy: DWord;
    MaxVertexW: Single;

    GuardBandLeft: Single;
    GuardBandTop: Single;
    GuardBandRight: Single;
    GuardBandBottom: Single;

    ExtentsAdjust: Single;
    StencilCaps: DWord;

    FVFCaps: DWord;
    TextureOpCaps: DWord;
    MaxTextureBlendStages: DWord;
    MaxSimultaneousTextures: DWord;

    VertexProcessingCaps: DWord;
    MaxActiveLights: DWord;
    MaxUserClipPlanes: DWord;
    MaxVertexBlendMatrices: DWord;
    MaxVertexBlendMatrixIndex: DWord;

    MaxPointSize: Single;

    MaxPrimitiveCount: DWord;           // max number of primitives per DrawPrimitive call
    MaxVertexIndex: DWord;
    MaxStreams: DWord;
    MaxStreamStride: DWord;             // max stride for SetStreamSource

    VertexShaderVersion: DWord;
    MaxVertexShaderConst: DWord;        // number of vertex shader constant registers

    PixelShaderVersion: DWord;
    PixelShader1xMaxValue: Single;      // max value storable in registers of ps.1.x shaders

    // Here are the DX9 specific ones
    DevCaps2: DWORD;

    MaxNpatchTessellationLevel: Single;
    Reserved5: DWORD;

    MasterAdapterOrdinal: LongWord;     // ordinal of master adaptor for adapter group
    AdapterOrdinalInGroup: LongWord;    // ordinal inside the adapter group
    NumberOfAdaptersInGroup: LongWord;  // number of adapters in this adapter group (only if master)
    DeclTypes: DWORD;                   // Data types, supported in vertex declarations
    NumSimultaneousRTs: DWORD;          // Will be at least 1
    StretchRectFilterCaps: DWORD;       // Filter caps supported by StretchRect
    VS20Caps: TD3DVShaderCaps2_0;
    PS20Caps: TD3DPShaderCaps2_0;
    VertexTextureFilterCaps: DWORD;     // D3DPTFILTERCAPS for IDirect3DTexture9's for texture, used in vertex shaders
    MaxVShaderInstructionsExecuted: DWORD; // maximum number of vertex shader instructions that can be executed
    MaxPShaderInstructionsExecuted: DWORD; // maximum number of pixel shader instructions that can be executed
    MaxVertexShader30InstructionSlots: DWORD;
    MaxPixelShader30InstructionSlots: DWORD;
  end {D3DCAPS9};
  {$EXTERNALSYM _D3DCAPS9}
  D3DCAPS9 = _D3DCAPS9;
  {$EXTERNALSYM D3DCAPS9}
  TD3DCaps9 = _D3DCAPS9;

  //
  // BIT DEFINES FOR D3DCAPS9 DWORD MEMBERS
  //

const
  //
  // Caps
  //
  D3DCAPS_READ_SCANLINE         = $00020000;
  {$EXTERNALSYM D3DCAPS_READ_SCANLINE}

  //
  // Caps2
  //
  D3DCAPS2_FULLSCREENGAMMA      = $00020000;
  {$EXTERNALSYM D3DCAPS2_FULLSCREENGAMMA}
  D3DCAPS2_CANCALIBRATEGAMMA    = $00100000;
  {$EXTERNALSYM D3DCAPS2_CANCALIBRATEGAMMA}
  D3DCAPS2_RESERVED             = $02000000;
  {$EXTERNALSYM D3DCAPS2_RESERVED}
  D3DCAPS2_CANMANAGERESOURCE    = $10000000;
  {$EXTERNALSYM D3DCAPS2_CANMANAGERESOURCE}
  D3DCAPS2_DYNAMICTEXTURES      = $20000000;
  {$EXTERNALSYM D3DCAPS2_DYNAMICTEXTURES}
  D3DCAPS2_CANAUTOGENMIPMAP     = $40000000;
  {$EXTERNALSYM D3DCAPS2_CANAUTOGENMIPMAP}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DCAPS2_CANSHARERESOURCE     = $80000000;
  {$EXTERNALSYM D3DCAPS2_CANSHARERESOURCE}
{$ENDIF}

  //
  // Caps3
  //
  D3DCAPS3_RESERVED             = $8000001F;
  {$EXTERNALSYM D3DCAPS3_RESERVED}

  // Indicates that the device can respect the ALPHABLENDENABLE render state
  // when fullscreen while using the FLIP or DISCARD swap effect.
  // COPY and COPYVSYNC swap effects work whether or not this flag is set.
  D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD     = $00000020;
  {$EXTERNALSYM D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD}

  // Indicates that the device can perform a gamma correction from
  // a windowed back buffer containing linear content to the sRGB desktop.
  D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION  = $00000080;
  {$EXTERNALSYM D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION}

  D3DCAPS3_COPY_TO_VIDMEM         = $00000100; { Device can acclerate copies from sysmem to local vidmem }
  {$EXTERNALSYM D3DCAPS3_COPY_TO_VIDMEM}
  D3DCAPS3_COPY_TO_SYSTEMMEM      = $00000200; { Device can acclerate copies from local vidmem to sysmem }
  {$EXTERNALSYM D3DCAPS3_COPY_TO_SYSTEMMEM}


  //
  // PresentationIntervals
  //
  D3DPRESENT_INTERVAL_DEFAULT   = $00000000;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_DEFAULT}
  D3DPRESENT_INTERVAL_ONE       = $00000001;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_ONE}
  D3DPRESENT_INTERVAL_TWO       = $00000002;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_TWO}
  D3DPRESENT_INTERVAL_THREE     = $00000004;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_THREE}
  D3DPRESENT_INTERVAL_FOUR      = $00000008;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_FOUR}
  D3DPRESENT_INTERVAL_IMMEDIATE = $80000000;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_IMMEDIATE}

  //
  // CursorCaps
  //
  // Driver supports HW color cursor in at least hi-res modes(height >=400)
  D3DCURSORCAPS_COLOR           = $00000001;
  {$EXTERNALSYM D3DCURSORCAPS_COLOR}
  // Driver supports HW cursor also in low-res modes(height < 400)
  D3DCURSORCAPS_LOWRES          = $00000002;
  {$EXTERNALSYM D3DCURSORCAPS_LOWRES}

  //
  // DevCaps
  //
  D3DDEVCAPS_EXECUTESYSTEMMEMORY        = $00000010; { Device can use execute buffers from system memory }
  {$EXTERNALSYM D3DDEVCAPS_EXECUTESYSTEMMEMORY}
  D3DDEVCAPS_EXECUTEVIDEOMEMORY         = $00000020; { Device can use execute buffers from video memory }
  {$EXTERNALSYM D3DDEVCAPS_EXECUTEVIDEOMEMORY}
  D3DDEVCAPS_TLVERTEXSYSTEMMEMORY       = $00000040; { Device can use TL buffers from system memory }
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXSYSTEMMEMORY}
  D3DDEVCAPS_TLVERTEXVIDEOMEMORY        = $00000080; { Device can use TL buffers from video memory }
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXVIDEOMEMORY}
  D3DDEVCAPS_TEXTURESYSTEMMEMORY        = $00000100; { Device can texture from system memory }
  {$EXTERNALSYM D3DDEVCAPS_TEXTURESYSTEMMEMORY}
  D3DDEVCAPS_TEXTUREVIDEOMEMORY         = $00000200; { Device can texture from device memory }
  {$EXTERNALSYM D3DDEVCAPS_TEXTUREVIDEOMEMORY}
  D3DDEVCAPS_DRAWPRIMTLVERTEX           = $00000400; { Device can draw TLVERTEX primitives }
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMTLVERTEX}
  D3DDEVCAPS_CANRENDERAFTERFLIP         = $00000800; { Device can render without waiting for flip to complete }
  {$EXTERNALSYM D3DDEVCAPS_CANRENDERAFTERFLIP}
  D3DDEVCAPS_TEXTURENONLOCALVIDMEM      = $00001000; { Device can texture from nonlocal video memory }
  {$EXTERNALSYM D3DDEVCAPS_TEXTURENONLOCALVIDMEM}
  D3DDEVCAPS_DRAWPRIMITIVES2            = $00002000; { Device can support DrawPrimitives2 }
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2}
  D3DDEVCAPS_SEPARATETEXTUREMEMORIES    = $00004000; { Device is texturing from separate memory pools }
  {$EXTERNALSYM D3DDEVCAPS_SEPARATETEXTUREMEMORIES}
  D3DDEVCAPS_DRAWPRIMITIVES2EX          = $00008000; { Device can support Extended DrawPrimitives2 i.e. DX7 compliant driver }
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2EX}
  D3DDEVCAPS_HWTRANSFORMANDLIGHT        = $00010000; { Device can support transformation and lighting in hardware and DRAWPRIMITIVES2EX must be also }
  {$EXTERNALSYM D3DDEVCAPS_HWTRANSFORMANDLIGHT}
  D3DDEVCAPS_CANBLTSYSTONONLOCAL        = $00020000; { Device supports a Tex Blt from system memory to non-local vidmem }
  {$EXTERNALSYM D3DDEVCAPS_CANBLTSYSTONONLOCAL}
  D3DDEVCAPS_HWRASTERIZATION            = $00080000; { Device has HW acceleration for rasterization }
  {$EXTERNALSYM D3DDEVCAPS_HWRASTERIZATION}
  D3DDEVCAPS_PUREDEVICE                 = $00100000; { Device supports D3DCREATE_PUREDEVICE }
  {$EXTERNALSYM D3DDEVCAPS_PUREDEVICE}
  D3DDEVCAPS_QUINTICRTPATCHES           = $00200000; { Device supports quintic Beziers and BSplines }
  {$EXTERNALSYM D3DDEVCAPS_QUINTICRTPATCHES}
  D3DDEVCAPS_RTPATCHES                  = $00400000; { Device supports Rect and Tri patches }
  {$EXTERNALSYM D3DDEVCAPS_RTPATCHES}
  D3DDEVCAPS_RTPATCHHANDLEZERO          = $00800000; { Indicates that RT Patches may be drawn efficiently using handle 0 }
  {$EXTERNALSYM D3DDEVCAPS_RTPATCHHANDLEZERO}
  D3DDEVCAPS_NPATCHES                   = $01000000; { Device supports N-Patches }
  {$EXTERNALSYM D3DDEVCAPS_NPATCHES}

  //
  // PrimitiveMiscCaps
  //
  D3DPMISCCAPS_MASKZ                    = $00000002;
  {$EXTERNALSYM D3DPMISCCAPS_MASKZ}
  D3DPMISCCAPS_CULLNONE                 = $00000010;
  {$EXTERNALSYM D3DPMISCCAPS_CULLNONE}
  D3DPMISCCAPS_CULLCW                   = $00000020;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCW}
  D3DPMISCCAPS_CULLCCW                  = $00000040;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCCW}
  D3DPMISCCAPS_COLORWRITEENABLE         = $00000080;
  {$EXTERNALSYM D3DPMISCCAPS_COLORWRITEENABLE}
  D3DPMISCCAPS_CLIPPLANESCALEDPOINTS    = $00000100; { Device correctly clips scaled points to clip planes }
  {$EXTERNALSYM D3DPMISCCAPS_CLIPPLANESCALEDPOINTS}
  D3DPMISCCAPS_CLIPTLVERTS              = $00000200; { device will clip post-transformed vertex primitives }
  {$EXTERNALSYM D3DPMISCCAPS_CLIPTLVERTS}
  D3DPMISCCAPS_TSSARGTEMP               = $00000400; { device supports D3DTA_TEMP for temporary register }
  {$EXTERNALSYM D3DPMISCCAPS_TSSARGTEMP}
  D3DPMISCCAPS_BLENDOP                  = $00000800; { device supports D3DRS_BLENDOP }
  {$EXTERNALSYM D3DPMISCCAPS_BLENDOP}
  D3DPMISCCAPS_NULLREFERENCE            = $00001000; { Reference Device that doesnt render }
  {$EXTERNALSYM D3DPMISCCAPS_NULLREFERENCE}
  D3DPMISCCAPS_INDEPENDENTWRITEMASKS    = $00004000; { Device supports independent write masks for MET or MRT }
  {$EXTERNALSYM D3DPMISCCAPS_INDEPENDENTWRITEMASKS}
  D3DPMISCCAPS_PERSTAGECONSTANT         = $00008000; { Device supports per-stage constants }
  {$EXTERNALSYM D3DPMISCCAPS_PERSTAGECONSTANT}
  D3DPMISCCAPS_FOGANDSPECULARALPHA      = $00010000; { Device supports separate fog and specular alpha (many devices
                                                       use the specular alpha channel to store fog factor) }
  {$EXTERNALSYM D3DPMISCCAPS_FOGANDSPECULARALPHA}
  D3DPMISCCAPS_SEPARATEALPHABLEND       = $00020000; { Device supports separate blend settings for the alpha channel }
  {$EXTERNALSYM D3DPMISCCAPS_SEPARATEALPHABLEND}
  D3DPMISCCAPS_MRTINDEPENDENTBITDEPTHS    = $00040000; { Device supports different bit depths for MRT }
  {$EXTERNALSYM D3DPMISCCAPS_MRTINDEPENDENTBITDEPTHS}
  D3DPMISCCAPS_MRTPOSTPIXELSHADERBLENDING = $00080000; { Device supports post-pixel shader operations for MRT }
  {$EXTERNALSYM D3DPMISCCAPS_MRTPOSTPIXELSHADERBLENDING}
  D3DPMISCCAPS_FOGVERTEXCLAMPED           = $00100000; { Device clamps fog blend factor per vertex }
  {$EXTERNALSYM D3DPMISCCAPS_FOGVERTEXCLAMPED}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DPMISCCAPS_POSTBLENDSRGBCONVERT       = $00200000; { Indicates device can perform conversion to sRGB after blending. }
  {$EXTERNALSYM D3DPMISCCAPS_POSTBLENDSRGBCONVERT}
{$ENDIF}

  //
  // LineCaps
  //
  D3DLINECAPS_TEXTURE                   = $00000001;
  {$EXTERNALSYM D3DLINECAPS_TEXTURE}
  D3DLINECAPS_ZTEST                     = $00000002;
  {$EXTERNALSYM D3DLINECAPS_ZTEST}
  D3DLINECAPS_BLEND                     = $00000004;
  {$EXTERNALSYM D3DLINECAPS_BLEND}
  D3DLINECAPS_ALPHACMP                  = $00000008;
  {$EXTERNALSYM D3DLINECAPS_ALPHACMP}
  D3DLINECAPS_FOG                       = $00000010;
  {$EXTERNALSYM D3DLINECAPS_FOG}
  D3DLINECAPS_ANTIALIAS                 = $00000020;
  {$EXTERNALSYM D3DLINECAPS_ANTIALIAS}

  //
  // RasterCaps
  //
  D3DPRASTERCAPS_DITHER                 = $00000001;
  {$EXTERNALSYM D3DPRASTERCAPS_DITHER}
  D3DPRASTERCAPS_ZTEST                  = $00000010;
  {$EXTERNALSYM D3DPRASTERCAPS_ZTEST}
  D3DPRASTERCAPS_FOGVERTEX              = $00000080;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGVERTEX}
  D3DPRASTERCAPS_FOGTABLE               = $00000100;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGTABLE}
  D3DPRASTERCAPS_MIPMAPLODBIAS          = $00002000;
  {$EXTERNALSYM D3DPRASTERCAPS_MIPMAPLODBIAS}
  D3DPRASTERCAPS_ZBUFFERLESSHSR         = $00008000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBUFFERLESSHSR}
  D3DPRASTERCAPS_FOGRANGE               = $00010000;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGRANGE}
  D3DPRASTERCAPS_ANISOTROPY             = $00020000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANISOTROPY}
  D3DPRASTERCAPS_WBUFFER                = $00040000;
  {$EXTERNALSYM D3DPRASTERCAPS_WBUFFER}
  D3DPRASTERCAPS_WFOG                   = $00100000;
  {$EXTERNALSYM D3DPRASTERCAPS_WFOG}
  D3DPRASTERCAPS_ZFOG                   = $00200000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZFOG}
  D3DPRASTERCAPS_COLORPERSPECTIVE       = $00400000; { Device iterates colors perspective correct }
  {$EXTERNALSYM D3DPRASTERCAPS_COLORPERSPECTIVE}
  D3DPRASTERCAPS_SCISSORTEST            = $01000000;
  {$EXTERNALSYM D3DPRASTERCAPS_SCISSORTEST}
  D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS    = $02000000;
  {$EXTERNALSYM D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS}
  D3DPRASTERCAPS_DEPTHBIAS              = $04000000;
  {$EXTERNALSYM D3DPRASTERCAPS_DEPTHBIAS}
  D3DPRASTERCAPS_MULTISAMPLE_TOGGLE     = $08000000;
  {$EXTERNALSYM D3DPRASTERCAPS_MULTISAMPLE_TOGGLE}

  //
  // ZCmpCaps, AlphaCmpCaps
  //
  D3DPCMPCAPS_NEVER                     = $00000001;
  {$EXTERNALSYM D3DPCMPCAPS_NEVER}
  D3DPCMPCAPS_LESS                      = $00000002;
  {$EXTERNALSYM D3DPCMPCAPS_LESS}
  D3DPCMPCAPS_EQUAL                     = $00000004;
  {$EXTERNALSYM D3DPCMPCAPS_EQUAL}
  D3DPCMPCAPS_LESSEQUAL                 = $00000008;
  {$EXTERNALSYM D3DPCMPCAPS_LESSEQUAL}
  D3DPCMPCAPS_GREATER                   = $00000010;
  {$EXTERNALSYM D3DPCMPCAPS_GREATER}
  D3DPCMPCAPS_NOTEQUAL                  = $00000020;
  {$EXTERNALSYM D3DPCMPCAPS_NOTEQUAL}
  D3DPCMPCAPS_GREATEREQUAL              = $00000040;
  {$EXTERNALSYM D3DPCMPCAPS_GREATEREQUAL}
  D3DPCMPCAPS_ALWAYS                    = $00000080;
  {$EXTERNALSYM D3DPCMPCAPS_ALWAYS}

  //
  // SourceBlendCaps, DestBlendCaps
  //
  D3DPBLENDCAPS_ZERO                    = $00000001;
  {$EXTERNALSYM D3DPBLENDCAPS_ZERO}
  D3DPBLENDCAPS_ONE                     = $00000002;
  {$EXTERNALSYM D3DPBLENDCAPS_ONE}
  D3DPBLENDCAPS_SRCCOLOR                = $00000004;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCCOLOR}
  D3DPBLENDCAPS_INVSRCCOLOR             = $00000008;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCCOLOR}
  D3DPBLENDCAPS_SRCALPHA                = $00000010;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHA}
  D3DPBLENDCAPS_INVSRCALPHA             = $00000020;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCALPHA}
  D3DPBLENDCAPS_DESTALPHA               = $00000040;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTALPHA}
  D3DPBLENDCAPS_INVDESTALPHA            = $00000080;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTALPHA}
  D3DPBLENDCAPS_DESTCOLOR               = $00000100;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTCOLOR}
  D3DPBLENDCAPS_INVDESTCOLOR            = $00000200;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTCOLOR}
  D3DPBLENDCAPS_SRCALPHASAT             = $00000400;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHASAT}
  D3DPBLENDCAPS_BOTHSRCALPHA            = $00000800;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHSRCALPHA}
  D3DPBLENDCAPS_BOTHINVSRCALPHA         = $00001000;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHINVSRCALPHA}
  D3DPBLENDCAPS_BLENDFACTOR             = $00002000; { Supports both D3DBLEND_BLENDFACTOR and D3DBLEND_INVBLENDFACTOR }
  {$EXTERNALSYM D3DPBLENDCAPS_BLENDFACTOR}

  //
  // ShadeCaps
  //
  D3DPSHADECAPS_COLORGOURAUDRGB         = $00000008;
  {$EXTERNALSYM D3DPSHADECAPS_COLORGOURAUDRGB}
  D3DPSHADECAPS_SPECULARGOURAUDRGB      = $00000200;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARGOURAUDRGB}
  D3DPSHADECAPS_ALPHAGOURAUDBLEND       = $00004000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAGOURAUDBLEND}
  D3DPSHADECAPS_FOGGOURAUD              = $00080000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGGOURAUD}

  //
  // TextureCaps
  //
  D3DPTEXTURECAPS_PERSPECTIVE           = $00000001; { Perspective-correct texturing is supported }
  {$EXTERNALSYM D3DPTEXTURECAPS_PERSPECTIVE}
  D3DPTEXTURECAPS_POW2                  = $00000002; { Power-of-2 texture dimensions are required - applies to non-Cube/Volume textures only. }
  {$EXTERNALSYM D3DPTEXTURECAPS_POW2}
  D3DPTEXTURECAPS_ALPHA                 = $00000004; { Alpha in texture pixels is supported }
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHA}
  D3DPTEXTURECAPS_SQUAREONLY            = $00000020; { Only square textures are supported }
  {$EXTERNALSYM D3DPTEXTURECAPS_SQUAREONLY}
  D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE = $00000040; { Texture indices are not scaled by the texture size prior to interpolation }
  {$EXTERNALSYM D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE}
  D3DPTEXTURECAPS_ALPHAPALETTE          = $00000080; { Device can draw alpha from texture palettes }
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHAPALETTE}
  // Device can use non-POW2 textures if:
  //  1) D3DTEXTURE_ADDRESS is set to CLAMP for this texture's stage
  //  2) D3DRS_WRAP(N) is zero for this texture's coordinates
  //  3) mip mapping is not enabled (use magnification filter only)
  D3DPTEXTURECAPS_NONPOW2CONDITIONAL    = $00000100;
  {$EXTERNALSYM D3DPTEXTURECAPS_NONPOW2CONDITIONAL}
  D3DPTEXTURECAPS_PROJECTED             = $00000400; { Device can do D3DTTFF_PROJECTED }
  {$EXTERNALSYM D3DPTEXTURECAPS_PROJECTED}
  D3DPTEXTURECAPS_CUBEMAP               = $00000800; { Device can do cubemap textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_CUBEMAP}
  D3DPTEXTURECAPS_VOLUMEMAP             = $00002000; { Device can do volume textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_VOLUMEMAP}
  D3DPTEXTURECAPS_MIPMAP                = $00004000; { Device can do mipmapped textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_MIPMAP}
  D3DPTEXTURECAPS_MIPVOLUMEMAP          = $00008000; { Device can do mipmapped volume textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_MIPVOLUMEMAP}
  D3DPTEXTURECAPS_MIPCUBEMAP            = $00010000; { Device can do mipmapped cube maps }
  {$EXTERNALSYM D3DPTEXTURECAPS_MIPCUBEMAP}
  D3DPTEXTURECAPS_CUBEMAP_POW2          = $00020000; { Device requires that cubemaps be power-of-2 dimension }
  {$EXTERNALSYM D3DPTEXTURECAPS_CUBEMAP_POW2}
  D3DPTEXTURECAPS_VOLUMEMAP_POW2        = $00040000; { Device requires that volume maps be power-of-2 dimension }
  {$EXTERNALSYM D3DPTEXTURECAPS_VOLUMEMAP_POW2}
  D3DPTEXTURECAPS_NOPROJECTEDBUMPENV    = $00200000; { Device does not support projected bump env lookup operation
                                                       in programmable and fixed function pixel shaders }
  {$EXTERNALSYM D3DPTEXTURECAPS_NOPROJECTEDBUMPENV}

  //
  // TextureFilterCaps, StretchRectFilterCaps
  //
  D3DPTFILTERCAPS_MINFPOINT             = $00000100; { Min Filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFPOINT}
  D3DPTFILTERCAPS_MINFLINEAR            = $00000200;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFLINEAR}
  D3DPTFILTERCAPS_MINFANISOTROPIC       = $00000400;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFANISOTROPIC}
  D3DPTFILTERCAPS_MINFPYRAMIDALQUAD     = $00000800;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFPYRAMIDALQUAD}
  D3DPTFILTERCAPS_MINFGAUSSIANQUAD      = $00001000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFGAUSSIANQUAD}
  D3DPTFILTERCAPS_MIPFPOINT             = $00010000; { Mip Filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFPOINT}
  D3DPTFILTERCAPS_MIPFLINEAR            = $00020000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFLINEAR}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DPTFILTERCAPS_CONVOLUTIONMONO       = $00040000; { Min and Mag for the convolution mono filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_CONVOLUTIONMONO}
{$ENDIF}
  D3DPTFILTERCAPS_MAGFPOINT             = $01000000; { Mag Filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFPOINT}
  D3DPTFILTERCAPS_MAGFLINEAR            = $02000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFLINEAR}
  D3DPTFILTERCAPS_MAGFANISOTROPIC       = $04000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFANISOTROPIC}
  D3DPTFILTERCAPS_MAGFPYRAMIDALQUAD     = $08000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFPYRAMIDALQUAD}
  D3DPTFILTERCAPS_MAGFGAUSSIANQUAD      = $10000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFGAUSSIANQUAD}

  //
  // TextureAddressCaps
  //
  D3DPTADDRESSCAPS_WRAP                 = $00000001;
  {$EXTERNALSYM D3DPTADDRESSCAPS_WRAP}
  D3DPTADDRESSCAPS_MIRROR               = $00000002;
  {$EXTERNALSYM D3DPTADDRESSCAPS_MIRROR}
  D3DPTADDRESSCAPS_CLAMP                = $00000004;
  {$EXTERNALSYM D3DPTADDRESSCAPS_CLAMP}
  D3DPTADDRESSCAPS_BORDER               = $00000008;
  {$EXTERNALSYM D3DPTADDRESSCAPS_BORDER}
  D3DPTADDRESSCAPS_INDEPENDENTUV        = $00000010;
  {$EXTERNALSYM D3DPTADDRESSCAPS_INDEPENDENTUV}
  D3DPTADDRESSCAPS_MIRRORONCE           = $00000020;
  {$EXTERNALSYM D3DPTADDRESSCAPS_MIRRORONCE}

  //
  // StencilCaps
  //
  D3DSTENCILCAPS_KEEP                   = $00000001;
  {$EXTERNALSYM D3DSTENCILCAPS_KEEP}
  D3DSTENCILCAPS_ZERO                   = $00000002;
  {$EXTERNALSYM D3DSTENCILCAPS_ZERO}
  D3DSTENCILCAPS_REPLACE                = $00000004;
  {$EXTERNALSYM D3DSTENCILCAPS_REPLACE}
  D3DSTENCILCAPS_INCRSAT                = $00000008;
  {$EXTERNALSYM D3DSTENCILCAPS_INCRSAT}
  D3DSTENCILCAPS_DECRSAT                = $00000010;
  {$EXTERNALSYM D3DSTENCILCAPS_DECRSAT}
  D3DSTENCILCAPS_INVERT                 = $00000020;
  {$EXTERNALSYM D3DSTENCILCAPS_INVERT}
  D3DSTENCILCAPS_INCR                   = $00000040;
  {$EXTERNALSYM D3DSTENCILCAPS_INCR}
  D3DSTENCILCAPS_DECR                   = $00000080;
  {$EXTERNALSYM D3DSTENCILCAPS_DECR}
  D3DSTENCILCAPS_TWOSIDED               = $00000100;
  {$EXTERNALSYM D3DSTENCILCAPS_TWOSIDED}

  //
  // TextureOpCaps
  //
  D3DTEXOPCAPS_DISABLE                          = $00000001;
  {$EXTERNALSYM D3DTEXOPCAPS_DISABLE}
  D3DTEXOPCAPS_SELECTARG1                       = $00000002;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG1}
  D3DTEXOPCAPS_SELECTARG2                       = $00000004;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG2}
  D3DTEXOPCAPS_MODULATE                         = $00000008;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE}
  D3DTEXOPCAPS_MODULATE2X                       = $00000010;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE2X}
  D3DTEXOPCAPS_MODULATE4X                       = $00000020;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE4X}
  D3DTEXOPCAPS_ADD                              = $00000040;
  {$EXTERNALSYM D3DTEXOPCAPS_ADD}
  D3DTEXOPCAPS_ADDSIGNED                        = $00000080;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED}
  D3DTEXOPCAPS_ADDSIGNED2X                      = $00000100;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED2X}
  D3DTEXOPCAPS_SUBTRACT                         = $00000200;
  {$EXTERNALSYM D3DTEXOPCAPS_SUBTRACT}
  D3DTEXOPCAPS_ADDSMOOTH                        = $00000400;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSMOOTH}
  D3DTEXOPCAPS_BLENDDIFFUSEALPHA                = $00000800;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDDIFFUSEALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHA                = $00001000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHA}
  D3DTEXOPCAPS_BLENDFACTORALPHA                 = $00002000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDFACTORALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHAPM              = $00004000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHAPM}
  D3DTEXOPCAPS_BLENDCURRENTALPHA                = $00008000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDCURRENTALPHA}
  D3DTEXOPCAPS_PREMODULATE                      = $00010000;
  {$EXTERNALSYM D3DTEXOPCAPS_PREMODULATE}
  D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR           = $00020000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA           = $00040000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA}
  D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR        = $00080000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA        = $00100000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA}
  D3DTEXOPCAPS_BUMPENVMAP                       = $00200000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAP}
  D3DTEXOPCAPS_BUMPENVMAPLUMINANCE              = $00400000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAPLUMINANCE}
  D3DTEXOPCAPS_DOTPRODUCT3                      = $00800000;
  {$EXTERNALSYM D3DTEXOPCAPS_DOTPRODUCT3}
  D3DTEXOPCAPS_MULTIPLYADD                      = $01000000;
  {$EXTERNALSYM D3DTEXOPCAPS_MULTIPLYADD}
  D3DTEXOPCAPS_LERP                             = $02000000;
  {$EXTERNALSYM D3DTEXOPCAPS_LERP}

  //
  // FVFCaps
  //
  D3DFVFCAPS_TEXCOORDCOUNTMASK  = $0000ffff; { mask for texture coordinate count field }
  {$EXTERNALSYM D3DFVFCAPS_TEXCOORDCOUNTMASK}
  D3DFVFCAPS_DONOTSTRIPELEMENTS = $00080000; { Device prefers that vertex elements not be stripped }
  {$EXTERNALSYM D3DFVFCAPS_DONOTSTRIPELEMENTS}
  D3DFVFCAPS_PSIZE              = $00100000; { Device can receive point size }
  {$EXTERNALSYM D3DFVFCAPS_PSIZE}

  //
  // VertexProcessingCaps
  //
  D3DVTXPCAPS_TEXGEN            = $00000001; { device can do texgen }
  {$EXTERNALSYM D3DVTXPCAPS_TEXGEN}
  D3DVTXPCAPS_MATERIALSOURCE7   = $00000002; { device can do DX7-level colormaterialsource ops }
  {$EXTERNALSYM D3DVTXPCAPS_MATERIALSOURCE7}
  D3DVTXPCAPS_DIRECTIONALLIGHTS = $00000008; { device can do directional lights }
  {$EXTERNALSYM D3DVTXPCAPS_DIRECTIONALLIGHTS}
  D3DVTXPCAPS_POSITIONALLIGHTS  = $00000010; { device can do positional lights (includes point and spot) }
  {$EXTERNALSYM D3DVTXPCAPS_POSITIONALLIGHTS}
  D3DVTXPCAPS_LOCALVIEWER       = $00000020; { device can do local viewer }
  {$EXTERNALSYM D3DVTXPCAPS_LOCALVIEWER}
  D3DVTXPCAPS_TWEENING          = $00000040; { device can do vertex tweening }
  {$EXTERNALSYM D3DVTXPCAPS_TWEENING}
  D3DVTXPCAPS_TEXGEN_SPHEREMAP  = $00000100; { device supports D3DTSS_TCI_SPHEREMAP }
  {$EXTERNALSYM D3DVTXPCAPS_TEXGEN_SPHEREMAP}
  D3DVTXPCAPS_NO_TEXGEN_NONLOCALVIEWER = $00000200; { device does not support TexGen in non-local
                                                      viewer mode }
  {$EXTERNALSYM D3DVTXPCAPS_NO_TEXGEN_NONLOCALVIEWER}

  //
  // DevCaps2
  //
  D3DDEVCAPS2_STREAMOFFSET                        = $00000001; { Device supports offsets in streams. Must be set by DX9 drivers }
  {$EXTERNALSYM D3DDEVCAPS2_STREAMOFFSET}
  D3DDEVCAPS2_DMAPNPATCH                          = $00000002; { Device supports displacement maps for N-Patches}
  {$EXTERNALSYM D3DDEVCAPS2_DMAPNPATCH}
  D3DDEVCAPS2_ADAPTIVETESSRTPATCH                 = $00000004; { Device supports adaptive tesselation of RT-patches}
  {$EXTERNALSYM D3DDEVCAPS2_ADAPTIVETESSRTPATCH}
  D3DDEVCAPS2_ADAPTIVETESSNPATCH                  = $00000008; { Device supports adaptive tesselation of N-patches}
  {$EXTERNALSYM D3DDEVCAPS2_ADAPTIVETESSNPATCH}
  D3DDEVCAPS2_CAN_STRETCHRECT_FROM_TEXTURES       = $00000010; { Device supports StretchRect calls with a texture as the source}
  {$EXTERNALSYM D3DDEVCAPS2_CAN_STRETCHRECT_FROM_TEXTURES}
  D3DDEVCAPS2_PRESAMPLEDDMAPNPATCH                = $00000020; { Device supports presampled displacement maps for N-Patches }
  {$EXTERNALSYM D3DDEVCAPS2_PRESAMPLEDDMAPNPATCH}
  D3DDEVCAPS2_VERTEXELEMENTSCANSHARESTREAMOFFSET  = $00000040; { Vertex elements in a vertex declaration can share the same stream offset }
  {$EXTERNALSYM D3DDEVCAPS2_VERTEXELEMENTSCANSHARESTREAMOFFSET}

  //
  // DeclTypes
  //
  D3DDTCAPS_UBYTE4     = $00000001;
  {$EXTERNALSYM D3DDTCAPS_UBYTE4}
  D3DDTCAPS_UBYTE4N    = $00000002;
  {$EXTERNALSYM D3DDTCAPS_UBYTE4N}
  D3DDTCAPS_SHORT2N    = $00000004;
  {$EXTERNALSYM D3DDTCAPS_SHORT2N}
  D3DDTCAPS_SHORT4N    = $00000008;
  {$EXTERNALSYM D3DDTCAPS_SHORT4N}
  D3DDTCAPS_USHORT2N   = $00000010;
  {$EXTERNALSYM D3DDTCAPS_USHORT2N}
  D3DDTCAPS_USHORT4N   = $00000020;
  {$EXTERNALSYM D3DDTCAPS_USHORT4N}
  D3DDTCAPS_UDEC3      = $00000040;
  {$EXTERNALSYM D3DDTCAPS_UDEC3}
  D3DDTCAPS_DEC3N      = $00000080;
  {$EXTERNALSYM D3DDTCAPS_DEC3N}
  D3DDTCAPS_FLOAT16_2  = $00000100;
  {$EXTERNALSYM D3DDTCAPS_FLOAT16_2}
  D3DDTCAPS_FLOAT16_4  = $00000200;
  {$EXTERNALSYM D3DDTCAPS_FLOAT16_4}




(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:   d3d9.h
 *  Content:    Direct3D include file
 *
 ****************************************************************************)

(* This identifier is passed to Direct3DCreate9 in order to ensure that an
 * application was built against the correct header files. This number is
 * incremented whenever a header (or other) change would require applications
 * to be rebuilt. If the version doesn't match, Direct3DCreate9 will fail.
 * (The number itself has no meaning.)*)

const
  D3D_SDK_VERSION   = (32 or $80000000);
  D3D9b_SDK_VERSION = (31 or $80000000);
  {$EXTERNALSYM D3D_SDK_VERSION}
  {$EXTERNALSYM D3D9b_SDK_VERSION}

type
  HMONITOR = THandle;
  {$EXTERNALSYM HMONITOR}

(*
 * Direct3D interfaces
 *)

  // forward interfaces declaration
  IDirect3D9 = interface;
  IDirect3DDevice9 = interface;
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  IDirect3DDevice9Ex = interface;
{$ENDIF}
  IDirect3DStateBlock9 = interface;
  IDirect3DVertexDeclaration9 = interface;
  IDirect3DVertexShader9 = interface;
  IDirect3DPixelShader9 = interface;
  IDirect3DResource9 = interface;
  IDirect3DBaseTexture9 = interface;
  IDirect3DTexture9 = interface;
  IDirect3DVolumeTexture9 = interface;
  IDirect3DCubeTexture9 = interface;
  IDirect3DVertexBuffer9 = interface;
  IDirect3DIndexBuffer9 = interface;
  IDirect3DSurface9 = interface;
  IDirect3DVolume9 = interface;
  IDirect3DSwapChain9 = interface;
  IDirect3DQuery9 = interface;

  
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D9);'}
  {$EXTERNALSYM IDirect3D9}
  IDirect3D9 = interface(IUnknown)
    ['{81BDCBCA-64D4-426d-AE8D-AD0147F4275C}']
    (*** IDirect3D9 methods ***)
    function RegisterSoftwareDevice(pInitializeFunction: Pointer): HResult; stdcall;
    function GetAdapterCount: LongWord; stdcall;
    function GetAdapterIdentifier(Adapter: LongWord; Flags: DWord; out pIdentifier: TD3DAdapterIdentifier9): HResult; stdcall;
    function GetAdapterModeCount(Adapter: LongWord; Format: TD3DFormat): LongWord; stdcall;
    function EnumAdapterModes(Adapter: LongWord; Format: TD3DFormat; Mode: LongWord; out pMode: TD3DDisplayMode): HResult; stdcall;
    function GetAdapterDisplayMode(Adapter: LongWord; out pMode: TD3DDisplayMode): HResult; stdcall;
    function CheckDeviceType(Adapter: LongWord; CheckType: TD3DDevType; AdapterFormat, BackBufferFormat: TD3DFormat; Windowed: BOOL): HResult; stdcall;
    function CheckDeviceFormat(Adapter: LongWord; DeviceType: TD3DDevType; AdapterFormat: TD3DFormat; Usage: DWord; RType: TD3DResourceType; CheckFormat: TD3DFormat): HResult; stdcall;
    function CheckDeviceMultiSampleType(Adapter: LongWord; DeviceType: TD3DDevType; SurfaceFormat: TD3DFormat; Windowed: BOOL; MultiSampleType: TD3DMultiSampleType; pQualityLevels: PDWORD): HResult; stdcall;
    function CheckDepthStencilMatch(Adapter: LongWord; DeviceType: TD3DDevType; AdapterFormat, RenderTargetFormat, DepthStencilFormat: TD3DFormat): HResult; stdcall;
    function CheckDeviceFormatConversion(Adapter: LongWord; DeviceType: TD3DDevType; SourceFormat, TargetFormat: TD3DFormat): HResult; stdcall;
    function GetDeviceCaps(Adapter: LongWord; DeviceType: TD3DDevType; out pCaps: TD3DCaps9): HResult; stdcall;
    function GetAdapterMonitor(Adapter: LongWord): HMONITOR; stdcall;
    function CreateDevice(Adapter: LongWord; DeviceType: TD3DDevType; hFocusWindow: HWND; BehaviorFlags: DWord; pPresentationParameters: PD3DPresentParameters; out ppReturnedDeviceInterface: IDirect3DDevice9): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3D9Helper}
  IDirect3D9Helper = class
    (*** helper information ***)
    szVersionString: PWideChar;
  end;
{$IFDEF DIRECT3D_VERSION_9_VISTA}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D9Ex);'}
  {$EXTERNALSYM IDirect3D9Ex}
  IDirect3D9Ex = interface(IDirect3D9)
    ['{02177241-69FC-400C-8FF1-93A44DF6861D}']
    (*** IDirect3D9Ex methods ***)
    function GetAdapterModeCountEx(Adapter: LongWord; const pFilter: PD3DDisplayModeFilter): LongWord; stdcall;
    function EnumAdapterModesEx(Adapter: LongWord; const pFilter: PD3DDisplayModeFilter; Mode: LongWord; pMode: PD3DDisplayModeEx): HResult; stdcall;
    function GetAdapterDisplayModeEx(Adapter: LongWord; pMode: PD3DDisplayModeEx; pRotation: PD3DDisplayRotation): HResult; stdcall;
    function CreateDeviceEx(Adapter: LongWord; DeviceType: TD3DDevType; hFocusWindow: HWND; BehaviorFlags: DWORD; pPresentationParameters: PD3DPresentParameters; pFullscreenDisplayMode: PD3DDisplayModeEx; out ppReturnedDeviceInterface: IDirect3DDevice9Ex): HResult; stdcall;
    function GetAdapterLUID(Adapter: LongWord; pLUID: PLargeInteger{*LUID}): HResult; stdcall;
  end;
{$ENDIF}



{ SwapChain }





  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice9);'}
  {$EXTERNALSYM IDirect3DDevice9}
  IDirect3DDevice9 = interface(IUnknown)
    ['{D0223B96-BF7A-43fd-92BD-A43B0D82B9EB}']
    (*** IDirect3DDevice9 methods ***)
    function TestCooperativeLevel: HResult; stdcall;
    function GetAvailableTextureMem: LongWord; stdcall;
    function EvictManagedResources: HResult; stdcall;
    function GetDirect3D(out ppD3D9: IDirect3D9): HResult; stdcall;
    function GetDeviceCaps(out pCaps: TD3DCaps9): HResult; stdcall;
    function GetDisplayMode(iSwapChain: LongWord; out pMode: TD3DDisplayMode): HResult; stdcall;
    function GetCreationParameters(out pParameters: TD3DDeviceCreationParameters): HResult; stdcall;
    function SetCursorProperties(XHotSpot, YHotSpot: LongWord; pCursorBitmap: IDirect3DSurface9): HResult; stdcall;
    procedure SetCursorPosition(XScreenSpace, YScreenSpace: LongWord; Flags: DWord); stdcall;
    function ShowCursor(bShow: BOOL): BOOL; stdcall;
    function CreateAdditionalSwapChain(const pPresentationParameters: TD3DPresentParameters; out pSwapChain: IDirect3DSwapChain9): HResult; stdcall;
    function GetSwapChain(iSwapChain: LongWord; out pSwapChain: IDirect3DSwapChain9): HResult; stdcall;
    function GetNumberOfSwapChains: LongWord; stdcall;
    function Reset(const pPresentationParameters: TD3DPresentParameters): HResult; stdcall;
    function Present(pSourceRect, pDestRect: PRect; hDestWindowOverride: HWND; pDirtyRegion: PRgnData): HResult; stdcall;
    function GetBackBuffer(iSwapChain: LongWord; iBackBuffer: LongWord; _Type: TD3DBackBufferType; out ppBackBuffer: IDirect3DSurface9): HResult; stdcall;
    function GetRasterStatus(iSwapChain: LongWord; out pRasterStatus: TD3DRasterStatus): HResult; stdcall;
    function SetDialogBoxMode(bEnableDialogs: BOOL): HResult; stdcall;
    procedure SetGammaRamp(iSwapChain: LongWord; Flags: DWord; const pRamp: TD3DGammaRamp); stdcall;
    procedure GetGammaRamp(iSwapChain: LongWord; out pRamp: TD3DGammaRamp); stdcall;
    function CreateTexture(Width, Height, Levels: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppTexture: IDirect3DTexture9; pSharedHandle: PHandle): HResult; stdcall;
    function CreateVolumeTexture(Width, Height, Depth, Levels: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppVolumeTexture: IDirect3DVolumeTexture9; pSharedHandle: PHandle): HResult; stdcall;
    function CreateCubeTexture(EdgeLength, Levels: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppCubeTexture: IDirect3DCubeTexture9; pSharedHandle: PHandle): HResult; stdcall;
    function CreateVertexBuffer(Length: LongWord; Usage, FVF: DWord; Pool: TD3DPool; out ppVertexBuffer: IDirect3DVertexBuffer9; pSharedHandle: PHandle): HResult; stdcall;
    function CreateIndexBuffer(Length: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppIndexBuffer: IDirect3DIndexBuffer9; pSharedHandle: PHandle): HResult; stdcall;
    function CreateRenderTarget(Width, Height: LongWord; Format: TD3DFormat; MultiSample: TD3DMultiSampleType; MultisampleQuality: DWORD; Lockable: BOOL; out ppSurface: IDirect3DSurface9; pSharedHandle: PHandle): HResult; stdcall;
    function CreateDepthStencilSurface(Width, Height: LongWord; Format: TD3DFormat; MultiSample: TD3DMultiSampleType; MultisampleQuality: DWORD; Discard: BOOL; out ppSurface: IDirect3DSurface9; pSharedHandle: PHandle): HResult; stdcall;
    function UpdateSurface(pSourceSurface: IDirect3DSurface9; pSourceRect: PRect; pDestinationSurface: IDirect3DSurface9; pDestPoint: PPoint): HResult; stdcall;
    function UpdateTexture(pSourceTexture, pDestinationTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function GetRenderTargetData(pRenderTarget, pDestSurface: IDirect3DSurface9): HResult; stdcall;
    function GetFrontBufferData(iSwapChain: LongWord; pDestSurface: IDirect3DSurface9): HResult; stdcall;
    function StretchRect(pSourceSurface: IDirect3DSurface9; pSourceRect: PRect; pDestSurface: IDirect3DSurface9; pDestRect: PRect; Filter: TD3DTextureFilterType): HResult; stdcall;
    function ColorFill(pSurface: IDirect3DSurface9; pRect: PRect; color: TD3DColor): HResult; stdcall;
    function CreateOffscreenPlainSurface(Width, Height: LongWord; Format: TD3DFormat; Pool: TD3DPool; out ppSurface: IDirect3DSurface9; pSharedHandle: PHandle): HResult; stdcall;
    function SetRenderTarget(RenderTargetIndex: DWORD; pRenderTarget: IDirect3DSurface9): HResult; stdcall;
    function GetRenderTarget(RenderTargetIndex: DWORD; out ppRenderTarget: IDirect3DSurface9): HResult; stdcall;
    function SetDepthStencilSurface(pNewZStencil: IDirect3DSurface9): HResult; stdcall;
    function GetDepthStencilSurface(out ppZStencilSurface: IDirect3DSurface9): HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function Clear(Count: DWord; pRects: PD3DRect; Flags: DWord; Color: TD3DColor; Z: Single; Stencil: DWord): HResult; stdcall;
    function SetTransform(State: TD3DTransformStateType; const pMatrix: TD3DMatrix): HResult; stdcall;
    function GetTransform(State: TD3DTransformStateType; out pMatrix: TD3DMatrix): HResult; stdcall;
    function MultiplyTransform(State: TD3DTransformStateType; const pMatrix: TD3DMatrix): HResult; stdcall;
    function SetViewport(const pViewport: TD3DViewport9): HResult; stdcall;
    function GetViewport(out pViewport: TD3DViewport9): HResult; stdcall;
    function SetMaterial(const pMaterial: TD3DMaterial9): HResult; stdcall;
    function GetMaterial(out pMaterial: TD3DMaterial9): HResult; stdcall;
    function SetLight(Index: DWord; const pLight: TD3DLight9): HResult; stdcall;
    function GetLight(Index: DWord; out pLight: TD3DLight9): HResult; stdcall;
    function LightEnable(Index: DWord; Enable: BOOL): HResult; stdcall;
    function GetLightEnable(Index: DWord; out pEnable: BOOL): HResult; stdcall;
    function SetClipPlane(Index: DWord; pPlane: PSingle): HResult; stdcall;
    function GetClipPlane(Index: DWord; pPlane: PSingle): HResult; stdcall;
    function SetRenderState(State: TD3DRenderStateType; Value: DWord): HResult; stdcall;
    function GetRenderState(State: TD3DRenderStateType; out pValue: DWord): HResult; stdcall;
    function CreateStateBlock(_Type: TD3DStateBlockType; out ppSB: IDirect3DStateBlock9): HResult; stdcall;
    function BeginStateBlock: HResult; stdcall;
    function EndStateBlock(out ppSB: IDirect3DStateBlock9): HResult; stdcall;
    function SetClipStatus(const pClipStatus: TD3DClipStatus9): HResult; stdcall;
    function GetClipStatus(out pClipStatus: TD3DClipStatus9): HResult; stdcall;
    function GetTexture(Stage: DWord; out ppTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function SetTexture(Stage: DWord; pTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function GetTextureStageState(Stage: DWord; _Type: TD3DTextureStageStateType; out pValue: DWord): HResult; stdcall;
    function SetTextureStageState(Stage: DWord; _Type: TD3DTextureStageStateType; Value: DWord): HResult; stdcall;
    function GetSamplerState(Sampler: DWORD; _Type: TD3DSamplerStateType; out pValue: DWORD): HResult; stdcall;
    function SetSamplerState(Sampler: DWORD; _Type: TD3DSamplerStateType; Value: DWORD): HResult; stdcall;
    function ValidateDevice(out pNumPasses: DWord): HResult; stdcall;
    function SetPaletteEntries(PaletteNumber: LongWord; pEntries: pPaletteEntry): HResult; stdcall;
    function GetPaletteEntries(PaletteNumber: LongWord; pEntries: pPaletteEntry): HResult; stdcall;
    function SetCurrentTexturePalette(PaletteNumber: LongWord): HResult; stdcall;
    function GetCurrentTexturePalette(out PaletteNumber: LongWord): HResult; stdcall;
    function SetScissorRect(pRect: PRect): HResult; stdcall;
    function GetScissorRect(out pRect: TRect): HResult; stdcall;
    function SetSoftwareVertexProcessing(bSoftware: BOOL): HResult; stdcall;
    function GetSoftwareVertexProcessing: BOOL; stdcall;
    function SetNPatchMode(nSegments: Single): HResult; stdcall;
    function GetNPatchMode: Single; stdcall;
    function DrawPrimitive(PrimitiveType: TD3DPrimitiveType; StartVertex, PrimitiveCount: LongWord): HResult; stdcall;
    function DrawIndexedPrimitive(_Type: TD3DPrimitiveType; BaseVertexIndex: Integer; MinVertexIndex, NumVertices, startIndex, primCount: LongWord): HResult; stdcall;
    function DrawPrimitiveUP(PrimitiveType: TD3DPrimitiveType; PrimitiveCount: LongWord; const pVertexStreamZeroData; VertexStreamZeroStride: LongWord): HResult; stdcall;
    function DrawIndexedPrimitiveUP(PrimitiveType: TD3DPrimitiveType; MinVertexIndex, NumVertice, PrimitiveCount: LongWord; const pIndexData; IndexDataFormat: TD3DFormat; const pVertexStreamZeroData; VertexStreamZeroStride: LongWord): HResult; stdcall;
    function ProcessVertices(SrcStartIndex, DestIndex, VertexCount: LongWord; pDestBuffer: IDirect3DVertexBuffer9; pVertexDecl: IDirect3DVertexDeclaration9; Flags: DWord): HResult; stdcall;
    function CreateVertexDeclaration(pVertexElements: PD3DVertexElement9; out ppDecl: IDirect3DVertexDeclaration9): HResult; stdcall;
    function SetVertexDeclaration(pDecl: IDirect3DVertexDeclaration9): HResult; stdcall;
    function GetVertexDeclaration(out ppDecl: IDirect3DVertexDeclaration9): HResult; stdcall;
    function SetFVF(FVF: DWORD): HResult; stdcall;
    function GetFVF(out FVF: DWORD): HResult; stdcall;
    function CreateVertexShader(pFunction: PDWord; out ppShader: IDirect3DVertexShader9): HResult; stdcall;
    function SetVertexShader(pShader: IDirect3DVertexShader9): HResult; stdcall;
    function GetVertexShader(out ppShader: IDirect3DVertexShader9): HResult; stdcall;
    function SetVertexShaderConstantF(StartRegister: LongWord; pConstantData: PSingle; Vector4fCount: LongWord): HResult; stdcall;
    function GetVertexShaderConstantF(StartRegister: LongWord; pConstantData: PSingle; Vector4fCount: LongWord): HResult; stdcall;
    function SetVertexShaderConstantI(StartRegister: LongWord; pConstantData: PInteger; Vector4iCount: LongWord): HResult; stdcall;
    function GetVertexShaderConstantI(StartRegister: LongWord; pConstantData: PInteger; Vector4iCount: LongWord): HResult; stdcall;
    function SetVertexShaderConstantB(StartRegister: LongWord; pConstantData: PBOOL; BoolCount: LongWord): HResult; stdcall;
    function GetVertexShaderConstantB(StartRegister: LongWord; pConstantData: PBOOL; BoolCount: LongWord): HResult; stdcall;
    function SetStreamSource(StreamNumber: LongWord; pStreamData: IDirect3DVertexBuffer9; OffsetInBytes, Stride: LongWord): HResult; stdcall;
    function GetStreamSource(StreamNumber: LongWord; out ppStreamData: IDirect3DVertexBuffer9; out pOffsetInBytes, pStride: LongWord): HResult; stdcall;
    function SetStreamSourceFreq(StreamNumber: LongWord; Setting: LongWord): HResult; stdcall;
    function GetStreamSourceFreq(StreamNumber: LongWord; out Setting: LongWord): HResult; stdcall;
    function SetIndices(pIndexData: IDirect3DIndexBuffer9): HResult; stdcall;
    function GetIndices(out ppIndexData: IDirect3DIndexBuffer9): HResult; stdcall;
    function CreatePixelShader(pFunction: PDWord; out ppShader: IDirect3DPixelShader9): HResult; stdcall;
    function SetPixelShader(pShader: IDirect3DPixelShader9): HResult; stdcall;
    function GetPixelShader(out ppShader: IDirect3DPixelShader9): HResult; stdcall;
    function SetPixelShaderConstantF(StartRegister: LongWord; pConstantData: PSingle; Vector4fCount: LongWord): HResult; stdcall;
    function GetPixelShaderConstantF(StartRegister: LongWord; pConstantData: PSingle; Vector4fCount: LongWord): HResult; stdcall;
    function SetPixelShaderConstantI(StartRegister: LongWord; pConstantData: PInteger; Vector4iCount: LongWord): HResult; stdcall;
    function GetPixelShaderConstantI(StartRegister: LongWord; pConstantData: PInteger; Vector4iCount: LongWord): HResult; stdcall;
    function SetPixelShaderConstantB(StartRegister: LongWord; pConstantData: PBOOL; BoolCount: LongWord): HResult; stdcall;
    function GetPixelShaderConstantB(StartRegister: LongWord; pConstantData: PBOOL; BoolCount: LongWord): HResult; stdcall;
    function DrawRectPatch(Handle: LongWord; pNumSegs: PSingle; pTriPatchInfo: PD3DRectPatchInfo): HResult; stdcall;
    function DrawTriPatch(Handle: LongWord; pNumSegs: PSingle; pTriPatchInfo: PD3DTriPatchInfo): HResult; stdcall;
    function DeletePatch(Handle: LongWord): HResult; stdcall;
    function CreateQuery(_Type: TD3DQueryType; out ppQuery: IDirect3DQuery9): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DDevice9Helper}
  IDirect3DDevice9Helper = class
    (*** helper information ***)
    CreationParameters: TD3DDeviceCreationParameters;
    PresentParameters: TD3DPresentParameters;
    DisplayMode: TD3DDisplayMode;
    Caps: TD3DCaps9;

    AvailableTextureMem: LongWord;
    SwapChains: LongWord;
    Textures: LongWord;
    VertexBuffers: LongWord;
    IndexBuffers: LongWord;
    VertexShaders: LongWord;
    PixelShaders: LongWord;

    Viewport: TD3DViewport9;
    ProjectionMatrix: TD3DMatrix;
    ViewMatrix: TD3DMatrix;
    WorldMatrix: TD3DMatrix;
    TextureMatrices: array[0..7] of TD3DMatrix;

    FVF: DWORD;
    VertexSize: LongWord;
    VertexShaderVersion: DWORD;
    PixelShaderVersion: DWORD;
    SoftwareVertexProcessing: BOOL;

    Material: TD3DMaterial9;
    Lights: array[0..15] of  TD3DLight9;
    LightsEnabled: array[0..15] of BOOL;

    GammaRamp: TD3DGammaRamp;
    ScissorRect: TRect;
    DialogBoxMode: BOOL;
  end;
{$IFDEF DIRECT3D_VERSION_9_VISTA}


  PIDirect3DResource9 = ^IDirect3DResource9;
  {$EXTERNALSYM PIDirect3DResource9}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice9Ex);'}
  {$EXTERNALSYM IDirect3DDevice9Ex}
  IDirect3DDevice9Ex = interface(IDirect3DDevice9)
    ['{B18B10CE-2649-405a-870F-95F777D4313A}']
    (*** IDirect3DDevice9Ex methods ***)
    function SetConvolutionMonoKernel(Width, Height: LongWord; rows, columns: PSingle): HResult; stdcall;
    function ComposeRects(pSrc, pDst: IDirect3DSurface9; pSrcRectDescs: IDirect3DVertexBuffer9; NumRects: LongWord; pDstRectDescs: IDirect3DVertexBuffer9; Operation: TD3DComposeRectsOp; Xoffset, Yoffset: Integer): HResult; stdcall;
    function PresentEx(const pSourceRect, pDestRect: PRect; hDestWindowOverride: HWND; const pDirtyRegion: PRgnData; dwFlags: DWORD): HResult; stdcall;
    function GetGPUThreadPriority(out pPriority: Integer): HResult; stdcall;
    function SetGPUThreadPriority(Priority: Integer): HResult; stdcall;
    function WaitForVBlank(iSwapChain: LongWord): HResult; stdcall;
    function CheckResourceResidency(pResourceArray: PIDirect3DResource9; NumResources: LongWord): HResult; stdcall;
    function SetMaximumFrameLatency(MaxLatency: LongWord): HResult; stdcall;
    function GetMaximumFrameLatency(out pMaxLatency: LongWord): HResult; stdcall;
    function CheckDeviceState(hDestinationWindow: HWND): HResult; stdcall;
    function CreateRenderTargetEx(Width, Height: LongWord; Format: TD3DFormat; MultiSample: TD3DMultiSampleType; MultisampleQuality: DWORD; Lockable: BOOL; out ppSurface: IDirect3DSurface9; pSharedHandle: PHandle; Usage: DWORD): HResult; stdcall;
    function CreateOffscreenPlainSurfaceEx(Width, Height: LongWord; Format: TD3DFormat; Pool: TD3DPool; out ppSurface: IDirect3DSurface9; pSharedHandle: PHandle; Usage: DWORD): HResult; stdcall;
    function CreateDepthStencilSurfaceEx(Width, Height: LongWord; Format: TD3DFormat; MultiSample: TD3DMultiSampleType; MultisampleQuality: DWORD; Discard: BOOL; out ppSurface: IDirect3DSurface9; pSharedHandle: PHandle; Usage: DWORD): HResult; stdcall;
    function ResetEx(const pPresentationParameters: TD3DPresentParameters; const pFullscreenDisplayMode: TD3DDisplayModeEx): HResult; stdcall;
    function GetDisplayModeEx(iSwapChain: LongWord; pMode: PD3DDisplayModeEx; pRotation: PD3DDisplayRotation): HResult; stdcall;
  end;
{$ENDIF}



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DStateBlock9);'}
  {$EXTERNALSYM IDirect3DStateBlock9}
  IDirect3DStateBlock9 = interface(IUnknown)
    ['{B07C4FE5-310D-4ba8-A23C-4F0F206F218B}']
     (*** IDirect3DStateBlock9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function Capture: HResult; stdcall;
    function Apply: HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DStateBlock9Helper}
  IDirect3DStateBlock9Helper = class
    (*** helper information ***)
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSwapChain9);'}
  {$EXTERNALSYM IDirect3DSwapChain9}
  IDirect3DSwapChain9 = interface(IUnknown)
    ['{794950F2-ADFC-458a-905E-10A10B0B503B}']
    (*** IDirect3DSwapChain9 methods ***)
    function Present(pSourceRect, pDestRect: PRect; hDestWindowOverride: HWND; pDirtyRegion: PRgnData; dwFlags: DWORD): HResult; stdcall;
    function GetFrontBufferData(pDestSurface: IDirect3DSurface9): HResult; stdcall;
    function GetBackBuffer(iBackBuffer: LongWord; _Type: TD3DBackBufferType; out ppBackBuffer: IDirect3DSurface9): HResult; stdcall;
    function GetRasterStatus(out pRasterStatus: TD3DRasterStatus): HResult; stdcall;
    function GetDisplayMode(out pMode: TD3DDisplayMode): HResult; stdcall;
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetPresentParameters(out pPresentationParameters: TD3DPresentParameters): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DSwapChain9Helper}
  IDirect3DSwapChain9Helper = class
    (*** helper information ***)
    PresentParameters: TD3DPresentParameters;
    DisplayMode: TD3DDisplayMode;
    CreationCallStack: PWideChar;
  end;
{$IFDEF DIRECT3D_VERSION_9_VISTA}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSwapChain9Ex);'}
  {$EXTERNALSYM IDirect3DSwapChain9Ex}
  IDirect3DSwapChain9Ex = interface(IDirect3DSwapChain9)
    ['{91886CAF-1C3D-4d2e-A0AB-3E4C7D8D3303}']
    (*** IDirect3DSwapChain9Ex methods ***)
    function GetLastPresentCount(out pLastPresentCount: LongWord): HResult; stdcall;
    function GetPresentStats(out pPresentationStatistics: TD3DPresentStats): HResult; stdcall;
    function GetDisplayModeEx(pMode: PD3DDisplayModeEx; pRotation: PD3DDisplayRotation): HResult; stdcall;
  end;
{$ENDIF}



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DResource9);'}
  {$EXTERNALSYM IDirect3DResource9}
  IDirect3DResource9 = interface(IUnknown)
    ['{05EEC05D-8F7D-4362-B999-D1BAF357C704}']
    (*** IDirect3DResource9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function SetPrivateData(const refguid: TGUID; const pData: Pointer; SizeOfData, Flags: DWord): HResult; stdcall;
    function GetPrivateData(const refguid: TGUID; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function SetPriority(PriorityNew: DWord): DWord; stdcall;
    function GetPriority: DWord; stdcall;
    procedure PreLoad; stdcall;
    function GetType: TD3DResourceType; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexDeclaration9);'}
  {$EXTERNALSYM IDirect3DVertexDeclaration9}
  IDirect3DVertexDeclaration9 = interface(IUnknown)
    ['{DD13C59C-36FA-4098-A8FB-C7ED39DC8546}']
    (*** IDirect3DVertexDeclaration9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetDeclaration(pElement: PD3DVertexElement9; out pNumElements: LongWord): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DVertexDeclaration9Helper}
  IDirect3DVertexDeclaration9Helper = class
    (*** helper information ***)
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexShader9);'}
  {$EXTERNALSYM IDirect3DVertexShader9}
  IDirect3DVertexShader9 = interface(IUnknown)
    ['{EFC5557E-6265-4613-8A94-43857889EB36}']
    (*** IDirect3DVertexShader9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetFunction(pData: Pointer; out pSizeOfData: LongWord): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DVertexShader9Helper}
  IDirect3DVertexShader9Helper = class
    (*** helper information ***)
    Version: DWORD;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DPixelShader9);'}
  {$EXTERNALSYM IDirect3DPixelShader9}
  IDirect3DPixelShader9 = interface(IUnknown)
    ['{6D3BDBDC-5B02-4415-B852-CE5E8BCCB289}']
    (*** IDirect3DPixelShader9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetFunction(pData: Pointer; out pSizeOfData: LongWord): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DPixelShader9Helper}
  IDirect3DPixelShader9Helper = class
    (*** helper information ***)
    Version: DWORD;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DBaseTexture9);'}
  {$EXTERNALSYM IDirect3DBaseTexture9}
  IDirect3DBaseTexture9 = interface(IDirect3DResource9)
    ['{580CA87E-1D3C-4d54-991D-B7D3E3C298CE}']
    (*** IDirect3DBaseTexture9 methods ***)
    function SetLOD(LODNew: DWord): DWord; stdcall;
    function GetLOD: DWord; stdcall;
    function GetLevelCount: DWord; stdcall;
    function SetAutoGenFilterType(FilterType: TD3DTextureFilterType): HResult; stdcall;
    function GetAutoGenFilterType: TD3DTextureFilterType; stdcall;
    procedure GenerateMipSubLevels; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DTexture9);'}
  {$EXTERNALSYM IDirect3DTexture9}
  IDirect3DTexture9 = interface(IDirect3DBaseTexture9)
    ['{85C31227-3DE5-4f00-9B3A-F11AC38C18B5}']
    (*** IDirect3DTexture9 methods ***)
    function GetLevelDesc(Level: LongWord; out pDesc: TD3DSurfaceDesc): HResult; stdcall;
    function GetSurfaceLevel(Level: LongWord; out ppSurfaceLevel: IDirect3DSurface9): HResult; stdcall;
    function LockRect(Level: LongWord; out pLockedRect: TD3DLockedRect; pRect: PRect; Flags: DWord): HResult; stdcall;
    function UnlockRect(Level: LongWord): HResult; stdcall;
    function AddDirtyRect(pDirtyRect: PRect): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DTexture9Helper}
  IDirect3DTexture9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Width: LongWord;
    Height: LongWord;
    Levels: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    Priority: DWORD;
    LOD: DWORD;
    FilterType: TD3DTextureFilterType;
    LockCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVolumeTexture9);'}
  {$EXTERNALSYM IDirect3DVolumeTexture9}
  IDirect3DVolumeTexture9 = interface(IDirect3DBaseTexture9)
    ['{2518526C-E789-4111-A7B9-47EF328D13E6}']
    (*** IDirect3DVolumeTexture9 methods ***)
    function GetLevelDesc(Level: LongWord; out pDesc: TD3DVolumeDesc): HResult; stdcall;
    function GetVolumeLevel(Level: LongWord; out ppVolumeLevel: IDirect3DVolume9): HResult; stdcall;
    function LockBox(Level: LongWord; out pLockedVolume: TD3DLockedBox; pBox: PD3DBox; Flags: DWord): HResult; stdcall;
    function UnlockBox(Level: LongWord): HResult; stdcall;
    function AddDirtyBox(pDirtyBox: PD3DBox): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DVolumeTexture9Helper}
  IDirect3DVolumeTexture9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Width: LongWord;
    Height: LongWord;
    Depth: LongWord;
    Levels: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    Priority: DWORD;
    LOD: DWORD;
    FilterType: TD3DTextureFilterType;
    LockCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DCubeTexture9);'}
  {$EXTERNALSYM IDirect3DCubeTexture9}
  IDirect3DCubeTexture9 = interface(IDirect3DBaseTexture9)
    ['{FFF32F81-D953-473a-9223-93D652ABA93F}']
    (*** IDirect3DCubeTexture9 methods ***)
    function GetLevelDesc(Level: LongWord; out pDesc: TD3DSurfaceDesc): HResult; stdcall;
    function GetCubeMapSurface(FaceType: TD3DCubeMapFaces; Level: LongWord; out ppCubeMapSurface: IDirect3DSurface9): HResult; stdcall;
    function LockRect(FaceType: TD3DCubeMapFaces; Level: LongWord; out pLockedRect: TD3DLockedRect; pRect: PRect; Flags: DWord): HResult; stdcall;
    function UnlockRect(FaceType: TD3DCubeMapFaces; Level: LongWord): HResult; stdcall;
    function AddDirtyRect(FaceType: TD3DCubeMapFaces; pDirtyRect: PRect): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DCubeTexture9Helper}
  IDirect3DCubeTexture9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Width: LongWord;
    Height: LongWord;
    Depth: LongWord;
    Levels: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    Priority: DWORD;
    LOD: DWORD;
    FilterType: TD3DTextureFilterType;
    LockCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexBuffer9);'}
  {$EXTERNALSYM IDirect3DVertexBuffer9}
  IDirect3DVertexBuffer9 = interface(IDirect3DResource9)
    ['{B64BB1B5-FD70-4df6-BF91-19D0A12455E3}']
    (*** IDirect3DVertexBuffer9 methods ***)
    function Lock(OffsetToLock, SizeToLock: LongWord; out ppbData: Pointer; Flags: DWord): HResult; stdcall;
    function Unlock: HResult; stdcall;
    function GetDesc(out pDesc: TD3DVertexBufferDesc): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DVertexBuffer9Helper}
  IDirect3DVertexBuffer9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Length: LongWord;
    Usage: DWORD;
    FVF: DWORD;
    Pool: TD3DPool;
    Priority: DWORD;
    LockCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DIndexBuffer9);'}
  {$EXTERNALSYM IDirect3DIndexBuffer9}
  IDirect3DIndexBuffer9 = interface(IDirect3DResource9)
    ['{7C9DD65E-D3F7-4529-ACEE-785830ACDE35}']
    (*** IDirect3DIndexBuffer9 methods ***)
    function Lock(OffsetToLock, SizeToLock: DWord; out ppbData: Pointer; Flags: DWord): HResult; stdcall;
    function Unlock: HResult; stdcall;
    function GetDesc(out pDesc: TD3DIndexBufferDesc): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DIndexBuffer9Helper}
  IDirect3DIndexBuffer9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Length: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    Priority: DWORD;
    LockCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSurface9);'}
  {$EXTERNALSYM IDirect3DSurface9}
  IDirect3DSurface9 = interface(IDirect3DResource9)
    ['{0CFBAF3A-9FF6-429a-99B3-A2796AF8B89B}']
    (*** IDirect3DSurface9 methods ***)
    function GetContainer(const riid: TGUID; out ppContainer{: Pointer}): HResult; stdcall;
    function GetDesc(out pDesc: TD3DSurfaceDesc): HResult; stdcall;
    function LockRect(out pLockedRect: TD3DLockedRect; pRect: PRect; Flags: DWord): HResult; stdcall;
    function UnlockRect: HResult; stdcall;
    function GetDC(out phdc: HDC): HResult; stdcall;
    function ReleaseDC(hdc: HDC): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DSurface9Helper}
  IDirect3DSurface9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Width: LongWord;
    Height: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    MultiSampleType: TD3DMultiSampleType;
    MultiSampleQuality: DWORD;
    Priority: DWORD;
    LockCount: LongWord;
    DCCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVolume9);'}
  {$EXTERNALSYM IDirect3DVolume9}
  IDirect3DVolume9 = interface (IUnknown)
    ['{24F416E6-1F67-4aa7-B88E-D33F6F3128A1}']
    (*** IDirect3DVolume9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function SetPrivateData(const refguid: TGUID; const pData; SizeOfData, Flags: DWord): HResult; stdcall;
    function GetPrivateData(const refguid: TGUID; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function GetContainer(const riid: TGUID; var ppContainer: Pointer): HResult; stdcall;
    function GetDesc(out pDesc: TD3DVolumeDesc): HResult; stdcall;
    function LockBox(out pLockedVolume: TD3DLockedBox; pBox: PD3DBox; Flags: DWord): HResult; stdcall;
    function UnlockBox: HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DVolume9Helper}
  IDirect3DVolume9Helper = class
    (*** helper information ***)
    Name: PWideChar;
    Width: LongWord;
    Height: LongWord;
    Depth: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    LockCount: LongWord;
    CreationCallStack: PWideChar;
  end;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DQuery9);'}
  {$EXTERNALSYM IDirect3DQuery9}
  IDirect3DQuery9 = interface(IUnknown)
    ['{d9771460-a695-4f26-bbd3-27b840b541cc}']
    (*** IDirect3DQuery9 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetType: TD3DQueryType; stdcall;
    function GetDataSize: DWORD; stdcall;
    function Issue(dwIssueFlags: DWORD): HResult; stdcall;
    function GetData(pData: Pointer; dwSize: DWORD; dwGetDataFlags: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirect3DQuery9Helper}
  IDirect3DQuery9Helper = class
    (*** helper information ***)
    _Type: TD3DQueryType;
    DataSize: DWORD;
    CreationCallStack: PWideChar;
  end;




(*
 * Interface IID's
 *)
type
  IID_IDirect3D9              = IDirect3D9;
  {$EXTERNALSYM IID_IDirect3D9}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  IID_IDirect3D9Ex            = IDirect3D9Ex;
  {$EXTERNALSYM IID_IDirect3D9Ex}
{$ENDIF}
  IID_IDirect3DDevice9        = IDirect3DDevice9;
  {$EXTERNALSYM IID_IDirect3DDevice9}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  IID_IDirect3DDevice9Ex      = IDirect3DDevice9Ex;
  {$EXTERNALSYM IID_IDirect3DDevice9Ex}
{$ENDIF}
  IID_IDirect3DResource9      = IDirect3DResource9;
  {$EXTERNALSYM IID_IDirect3DResource9}
  IID_IDirect3DBaseTexture9   = IDirect3DBaseTexture9;
  {$EXTERNALSYM IID_IDirect3DBaseTexture9}
  IID_IDirect3DTexture9       = IDirect3DTexture9;
  {$EXTERNALSYM IID_IDirect3DTexture9}
  IID_IDirect3DCubeTexture9   = IDirect3DCubeTexture9;
  {$EXTERNALSYM IID_IDirect3DCubeTexture9}
  IID_IDirect3DVolumeTexture9 = IDirect3DVolumeTexture9;
  {$EXTERNALSYM IID_IDirect3DVolumeTexture9}
  IID_IDirect3DVertexBuffer9  = IDirect3DVertexBuffer9;
  {$EXTERNALSYM IID_IDirect3DVertexBuffer9}
  IID_IDirect3DIndexBuffer9   = IDirect3DIndexBuffer9;
  {$EXTERNALSYM IID_IDirect3DIndexBuffer9}
  IID_IDirect3DSurface9       = IDirect3DSurface9;
  {$EXTERNALSYM IID_IDirect3DSurface9}
  IID_IDirect3DVolume9        = IDirect3DVolume9;
  {$EXTERNALSYM IID_IDirect3DVolume9}
  IID_IDirect3DSwapChain9     = IDirect3DSwapChain9;
  {$EXTERNALSYM IID_IDirect3DSwapChain9}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  IID_IDirect3DSwapChain9Ex   = IDirect3DSwapChain9Ex;
  {$EXTERNALSYM IID_IDirect3DSwapChain9Ex}
{$ENDIF}
  IID_IDirect3DVertexDeclaration9 = IDirect3DVertexDeclaration9;
  {$EXTERNALSYM IID_IDirect3DVertexDeclaration9}
  IID_IDirect3DVertexShader9  = IDirect3DVertexShader9;
  {$EXTERNALSYM IID_IDirect3DVertexShader9}
  IID_IDirect3DPixelShader9   = IDirect3DPixelShader9;
  {$EXTERNALSYM IID_IDirect3DPixelShader9}
  IID_IDirect3DStateBlock9    = IDirect3DStateBlock9;
  {$EXTERNALSYM IID_IDirect3DStateBlock9}
  IID_IDirect3DQuery9         = IDirect3DQuery9;
  {$EXTERNALSYM IID_IDirect3DQuery9}
const
  IID_HelperName : TGUID = '{E4A36723-FDFE-4b22-B146-3C04C07F4CC8}';
  {$EXTERNALSYM IID_HelperName}



const
{****************************************************************************
 * Flags for SetPrivateData method on all D3D9 interfaces
 *
 * The passed pointer is an IUnknown ptr. The SizeOfData argument to SetPrivateData
 * must be set to sizeof(IUnknown*). Direct3D will call AddRef through this
 * pointer and Release when the private data is destroyed. The data will be
 * destroyed when another SetPrivateData with the same GUID is set, when
 * FreePrivateData is called, or when the D3D9 object is freed.
 ****************************************************************************}
  D3DSPD_IUNKNOWN                         = $00000001;
  {$EXTERNALSYM D3DSPD_IUNKNOWN}

(****************************************************************************
 *
 * Flags for IDirect3D9::CreateDevice's BehaviorFlags
 *
 ****************************************************************************)

  D3DCREATE_FPU_PRESERVE                  = $00000002;
  {$EXTERNALSYM D3DCREATE_FPU_PRESERVE}
  D3DCREATE_MULTITHREADED                 = $00000004;
  {$EXTERNALSYM D3DCREATE_MULTITHREADED}

  D3DCREATE_PUREDEVICE                    = $00000010;
  {$EXTERNALSYM D3DCREATE_PUREDEVICE}
  D3DCREATE_SOFTWARE_VERTEXPROCESSING     = $00000020;
  {$EXTERNALSYM D3DCREATE_SOFTWARE_VERTEXPROCESSING}
  D3DCREATE_HARDWARE_VERTEXPROCESSING     = $00000040;
  {$EXTERNALSYM D3DCREATE_HARDWARE_VERTEXPROCESSING}
  D3DCREATE_MIXED_VERTEXPROCESSING        = $00000080;
  {$EXTERNALSYM D3DCREATE_MIXED_VERTEXPROCESSING}

  D3DCREATE_DISABLE_DRIVER_MANAGEMENT     = $00000100;
  {$EXTERNALSYM D3DCREATE_DISABLE_DRIVER_MANAGEMENT}
  D3DCREATE_ADAPTERGROUP_DEVICE           = $00000200;
  {$EXTERNALSYM D3DCREATE_ADAPTERGROUP_DEVICE}
  D3DCREATE_DISABLE_DRIVER_MANAGEMENT_EX  = $00000400;
  {$EXTERNALSYM D3DCREATE_DISABLE_DRIVER_MANAGEMENT_EX}

  // This flag causes the D3D runtime not to alter the focus
  // window in any way. Use with caution- the burden of supporting
  // focus management events (alt-tab, etc.) falls on the
  // application, and appropriate responses (switching display
  // mode, etc.) should be coded.
  D3DCREATE_NOWINDOWCHANGES               = $00000800;
  {$EXTERNALSYM D3DCREATE_NOWINDOWCHANGES}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  // Disable multithreading for software vertex processing
  D3DCREATE_DISABLE_PSGP_THREADING        = $00002000;
  {$EXTERNALSYM D3DCREATE_DISABLE_PSGP_THREADING}
  // This flag enables present statistics on device.
  D3DCREATE_ENABLE_PRESENTSTATS           = $00004000;
  {$EXTERNALSYM D3DCREATE_ENABLE_PRESENTSTATS}
  // This flag disables printscreen support in the runtime for this device
  D3DCREATE_DISABLE_PRINTSCREEN           = $00008000;
  {$EXTERNALSYM D3DCREATE_DISABLE_PRINTSCREEN}

  D3DCREATE_SCREENSAVER                   = $10000000;
  {$EXTERNALSYM D3DCREATE_SCREENSAVER}
{$ENDIF}


(****************************************************************************
 *
 * Parameter for IDirect3D9::CreateDevice's Adapter argument
 *
 ****************************************************************************)

  D3DADAPTER_DEFAULT                      = 0;
  {$EXTERNALSYM D3DADAPTER_DEFAULT}

(****************************************************************************
 *
 * Flags for IDirect3D9::EnumAdapters
 *
 ****************************************************************************)

{$IFDEF DIRECT3D_VERSION_9_VISTA}
(*
 * The D3DENUM_WHQL_LEVEL value has been retired for this and future versions.
 * See the DirectX SDK for sample code on discovering driver signatures.
 *)

(* NO_DRIVERVERSION will not fill out the DriverVersion field, nor will the
   DriverVersion be incorporated into the DeviceIdentifier GUID. WINNT only *)
  D3DENUM_NO_DRIVERVERSION                = $00000004;
  {$EXTERNALSYM D3DENUM_NO_DRIVERVERSION}
{$ELSE}
  D3DENUM_WHQL_LEVEL                      = $00000002;
  {$EXTERNALSYM D3DENUM_WHQL_LEVEL}
{$ENDIF}

(****************************************************************************
 *
 * Maximum number of back-buffers supported in DX9
 *
 ****************************************************************************)

  D3DPRESENT_BACK_BUFFERS_MAX             = 3;
  {$EXTERNALSYM D3DPRESENT_BACK_BUFFERS_MAX}

{$IFDEF DIRECT3D_VERSION_9_VISTA}
(****************************************************************************
 *
 * Maximum number of back-buffers supported when apps use CreateDeviceEx
 *
 ****************************************************************************)

  D3DPRESENT_BACK_BUFFERS_MAX_EX          = 30;
  {$EXTERNALSYM D3DPRESENT_BACK_BUFFERS_MAX_EX}

{$ENDIF}
(****************************************************************************
 *
 * Flags for IDirect3DDevice9::SetGammaRamp
 *
 ****************************************************************************)

  D3DSGR_NO_CALIBRATION                  = $00000000;
  {$EXTERNALSYM D3DSGR_NO_CALIBRATION}
  D3DSGR_CALIBRATE                       = $00000001;
  {$EXTERNALSYM D3DSGR_CALIBRATE}

(****************************************************************************
 *
 * Flags for IDirect3DDevice9::SetCursorPosition
 *
 ****************************************************************************)

  D3DCURSOR_IMMEDIATE_UPDATE             = $00000001;
  {$EXTERNALSYM D3DCURSOR_IMMEDIATE_UPDATE}

(****************************************************************************
 *
 * Flags for IDirect3DSwapChain9::Present
 *
 ****************************************************************************)

  D3DPRESENT_DONOTWAIT                   = $00000001;
  {$EXTERNALSYM D3DPRESENT_DONOTWAIT}
  D3DPRESENT_LINEAR_CONTENT              = $00000002;
  {$EXTERNALSYM D3DPRESENT_LINEAR_CONTENT}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  D3DPRESENT_DONOTFLIP                   = $00000004;
  {$EXTERNALSYM D3DPRESENT_DONOTFLIP}
  D3DPRESENT_FLIPRESTART                 = $00000008;
  {$EXTERNALSYM D3DPRESENT_FLIPRESTART}
{$ENDIF}

(****************************************************************************
 *
 * Flags for DrawPrimitive/DrawIndexedPrimitive
 *   Also valid for Begin/BeginIndexed
 *   Also valid for VertexBuffer::CreateVertexBuffer
 ****************************************************************************)


(*
 *  DirectDraw error codes
 *)
  _FACD3D = $876;
  {$EXTERNALSYM _FACD3D}

//#define MAKE_D3DHRESULT( code )  MAKE_HRESULT( 1, _FACD3D, code )
function MAKE_D3DHRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_D3DHRESULT}
//#define MAKE_D3DSTATUS( code )  MAKE_HRESULT( 0, _FACD3D, code )
function MAKE_D3DSTATUS(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_D3DSTATUS}

const
  MAKE_D3DHRESULT_R     = (1 shl 31) or (_FACD3D shl 16);
  MAKE_D3DSTATUS_R      = (0 shl 31) or (_FACD3D shl 16);

(*
 * Direct3D Errors
 *)
  D3D_OK                                  = S_OK;
  {$EXTERNALSYM D3D_OK}

  D3DERR_WRONGTEXTUREFORMAT               = HResult(MAKE_D3DHRESULT_R or 2072);
  {$EXTERNALSYM D3DERR_WRONGTEXTUREFORMAT}
  D3DERR_UNSUPPORTEDCOLOROPERATION        = HResult(MAKE_D3DHRESULT_R or 2073);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDCOLOROPERATION}
  D3DERR_UNSUPPORTEDCOLORARG              = HResult(MAKE_D3DHRESULT_R or 2074);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDCOLORARG}
  D3DERR_UNSUPPORTEDALPHAOPERATION        = HResult(MAKE_D3DHRESULT_R or 2075);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDALPHAOPERATION}
  D3DERR_UNSUPPORTEDALPHAARG              = HResult(MAKE_D3DHRESULT_R or 2076);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDALPHAARG}
  D3DERR_TOOMANYOPERATIONS                = HResult(MAKE_D3DHRESULT_R or 2077);
  {$EXTERNALSYM D3DERR_TOOMANYOPERATIONS}
  D3DERR_CONFLICTINGTEXTUREFILTER         = HResult(MAKE_D3DHRESULT_R or 2078);
  {$EXTERNALSYM D3DERR_CONFLICTINGTEXTUREFILTER}
  D3DERR_UNSUPPORTEDFACTORVALUE           = HResult(MAKE_D3DHRESULT_R or 2079);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDFACTORVALUE}
  D3DERR_CONFLICTINGRENDERSTATE           = HResult(MAKE_D3DHRESULT_R or 2081);
  {$EXTERNALSYM D3DERR_CONFLICTINGRENDERSTATE}
  D3DERR_UNSUPPORTEDTEXTUREFILTER         = HResult(MAKE_D3DHRESULT_R or 2082);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDTEXTUREFILTER}
  D3DERR_CONFLICTINGTEXTUREPALETTE        = HResult(MAKE_D3DHRESULT_R or 2086);
  {$EXTERNALSYM D3DERR_CONFLICTINGTEXTUREPALETTE}
  D3DERR_DRIVERINTERNALERROR              = HResult(MAKE_D3DHRESULT_R or 2087);
  {$EXTERNALSYM D3DERR_DRIVERINTERNALERROR}

  D3DERR_NOTFOUND                         = HResult(MAKE_D3DHRESULT_R or 2150);
  {$EXTERNALSYM D3DERR_NOTFOUND}
  D3DERR_MOREDATA                         = HResult(MAKE_D3DHRESULT_R or 2151);
  {$EXTERNALSYM D3DERR_MOREDATA}
  D3DERR_DEVICELOST                       = HResult(MAKE_D3DHRESULT_R or 2152);
  {$EXTERNALSYM D3DERR_DEVICELOST}
  D3DERR_DEVICENOTRESET                   = HResult(MAKE_D3DHRESULT_R or 2153);
  {$EXTERNALSYM D3DERR_DEVICENOTRESET}
  D3DERR_NOTAVAILABLE                     = HResult(MAKE_D3DHRESULT_R or 2154);
  {$EXTERNALSYM D3DERR_NOTAVAILABLE}
  D3DERR_OUTOFVIDEOMEMORY                 = HResult(MAKE_D3DHRESULT_R or 380);
  {$EXTERNALSYM D3DERR_OUTOFVIDEOMEMORY}
  D3DERR_INVALIDDEVICE                    = HResult(MAKE_D3DHRESULT_R or 2155);
  {$EXTERNALSYM D3DERR_INVALIDDEVICE}
  D3DERR_INVALIDCALL                      = HResult(MAKE_D3DHRESULT_R or 2156);
  {$EXTERNALSYM D3DERR_INVALIDCALL}
  D3DERR_DRIVERINVALIDCALL                = HResult(MAKE_D3DHRESULT_R or 2157);
  {$EXTERNALSYM D3DERR_DRIVERINVALIDCALL}
  D3DERR_WASSTILLDRAWING                  = HResult(MAKE_D3DHRESULT_R or 540);
  {$EXTERNALSYM D3DERR_WASSTILLDRAWING}
{$IFDEF DIRECT3D_VERSION_9_VISTA}


  D3DERR_DEVICEREMOVED                    = HResult(MAKE_D3DHRESULT_R or 2160);
  {$EXTERNALSYM D3DERR_DEVICEREMOVED}
{$ENDIF}
  D3DOK_NOAUTOGEN                         = HResult(MAKE_D3DSTATUS_R or 2159);
  {$EXTERNALSYM D3DOK_NOAUTOGEN}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
  S_NOT_RESIDENT                          = HResult(MAKE_D3DSTATUS_R or 2165);
  {$EXTERNALSYM S_NOT_RESIDENT}
  S_RESIDENT_IN_SHARED_MEMORY             = HResult(MAKE_D3DSTATUS_R or 2166);
  {$EXTERNALSYM S_RESIDENT_IN_SHARED_MEMORY}
  S_PRESENT_MODE_CHANGED                  = HResult(MAKE_D3DSTATUS_R or 2167);
  {$EXTERNALSYM S_PRESENT_MODE_CHANGED}
  S_PRESENT_OCCLUDED                      = HResult(MAKE_D3DSTATUS_R or 2168);
  {$EXTERNALSYM S_PRESENT_OCCLUDED}
  D3DERR_DEVICEHUNG                       = HResult(MAKE_D3DHRESULT_R or 2164);
  {$EXTERNALSYM D3DERR_DEVICEHUNG}
{$ENDIF}



(*
 * DLL Function for creating a Direct3D9 object. This object supports
 * enumeration and allows the creation of Direct3DDevice9 objects.
 * Pass the value of the constant D3D_SDK_VERSION to this function, so
 * that the run-time can validate that your application was compiled
 * against the right headers.
 *)


function Direct3D9Loaded: Boolean;
function LoadDirect3D9: Boolean;
function UnLoadDirect3D9: Boolean;

const
  Direct3D9dll = 'd3d9.dll';

// Due to the way Object Pascal handles functions resulting in 'native' interface
// pointer we should declare result not as interface but as usial pointer

{$IFDEF DIRECT3D9_DYNAMIC_LINK}
type
  TDirect3DCreate9 = function (SDKVersion: LongWord): Pointer; stdcall;
  {$IFDEF DIRECT3D_VERSION_9_VISTA}
  TDirect3DCreate9Ex = function (SDKVersion: LongWord; out d3d9ex: IDirect3D9Ex): HRESULT; stdcall;
  {$ENDIF}

var
  _Direct3DCreate9: TDirect3DCreate9 = nil;
  {$IFDEF DIRECT3D_VERSION_9_VISTA}
  Direct3DCreate9Ex: TDirect3DCreate9Ex = nil;
  {$ENDIF}

{$ELSE}
function _Direct3DCreate9(SDKVersion: LongWord): Pointer; stdcall;
{$ENDIF}

function Direct3DCreate9(SDKVersion: LongWord): IDirect3D9; stdcall;
{$EXTERNALSYM Direct3DCreate9}
{$IFNDEF DIRECT3D9_DYNAMIC_LINK}
{$IFDEF DIRECT3D_VERSION_9_VISTA}
function Direct3DCreate9Ex(SDKVersion: LongWord; out d3d9ex: IDirect3D9Ex): HRESULT; stdcall;
{$EXTERNALSYM Direct3DCreate9Ex}
{$ENDIF}
{$ENDIF}

(*
 * Stubs for graphics profiling.
 *)

function D3DPERF_BeginEvent(col: TD3DColor; wszName: PWideChar): Integer; stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_BeginEvent}
function D3DPERF_EndEvent: Integer; stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_EndEvent}
procedure D3DPERF_SetMarker(col: TD3DColor; wszName: PWideChar); stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_SetMarker}
procedure D3DPERF_SetRegion(col: TD3DColor; wszName: PWideChar); stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_SetRegion}
function D3DPERF_QueryRepeatFrame: BOOL; stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_QueryRepeatFrame}

procedure D3DPERF_SetOptions(dwOptions: DWORD); stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_SetOptions}
function D3DPERF_GetStatus: DWORD; stdcall; external Direct3D9dll;
{$EXTERNALSYM D3DPERF_GetStatus}


//********************************************************************
// Introduced types for compatibility with non-Borland compliant translation
// by Ampaze (Tim Baumgarten) from http://www.crazyentertainment.net
type
  PD3DAdapter_Identifier9               = PD3DAdapterIdentifier9;
  PD3DDevice_Creation_Parameters        = PD3DDeviceCreationParameters;
  PD3DDevInfo_D3DVertexStats            = PD3DDevInfoD3DVertexStats;
  PD3DDevInfo_ResourceManager           = PD3DDevInfoResourceManager;
  PD3DDevInfo_VCache                    = PD3DDevInfoVCache;
  PD3DIndexBuffer_Desc                  = PD3DIndexBufferDesc;
  PD3DLocked_Box                        = PD3DLockedBox;
  PD3DLocked_Rect                       = PD3DLockedRect;
  PD3DPresent_Parameters                = PD3DPresentParameters;
  PD3DRaster_Status                     = PD3DRasterStatus;
  PD3DRectPatch_Info                    = PD3DRectPatchInfo;
  PD3DSurface_Desc                      = PD3DSurfaceDesc;
  PD3DTriPatch_Info                     = PD3DTriPatchInfo;
  PD3DVertexBuffer_Desc                 = PD3DVertexBufferDesc;
  PD3DVolume_Desc                       = PD3DVolumeDesc;

  TD3DAdapter_Identifier9               = TD3DAdapterIdentifier9;
  TD3DBackBuffer_Type                   = TD3DBackBufferType;
  TD3DCubeMap_Faces                     = TD3DCubeMapFaces;
  TD3DDevice_Creation_Parameters        = TD3DDeviceCreationParameters;
  TD3DDevInfo_D3DVertexStats            = TD3DDevInfoD3DVertexStats;
  TD3DDevInfo_ResourceManager           = TD3DDevInfoResourceManager;
  TD3DDevInfo_VCache                    = TD3DDevInfoVCache;
  TD3DIndexBuffer_Desc                  = TD3DIndexBufferDesc;
  TD3DLocked_Box                        = TD3DLockedBox;
  TD3DLocked_Rect                       = TD3DLockedRect;
  TD3DMultiSample_Type                  = TD3DMultiSampleType;
  TD3DPresent_Parameters                = TD3DPresentParameters;
  TD3DRaster_Status                     = TD3DRasterStatus;
  TD3DRectPatch_Info                    = TD3DRectPatchInfo;
  TD3DSampler_Texture_Type              = TD3DSamplerTextureType;
  TD3DShader_AddressMode_Type           = TD3DShaderAddressModeType;
  TD3DShader_Comparison                 = TD3DShaderComparison;
  TD3DShader_Instruction_Opcode_Type    = TD3DShaderInstructionOpcodeType;
  TD3DShader_MiscType_Offsets           = TD3DShaderMiscTypeOffsets;
  TD3DShader_Param_Register_Type        = TD3DShaderParamRegisterType;
  TD3DShader_Param_SRCMod_Type          = TD3DShaderParamSRCModType;
  TD3DSurface_Desc                      = TD3DSurfaceDesc;
  TD3DTriPatch_Info                     = TD3DTriPatchInfo;
  TD3DVertexBuffer_Desc                 = TD3DVertexBufferDesc;
  TD3DVolume_Desc                       = TD3DVolumeDesc;
  TD3DVS_AddressMode_Type               = TD3DVSAddressModeType;
  TD3DVS_RastOut_Offsets                = TD3DVSRastOutOffsets;


{$IFNDEF COMPILER6_UP}
type
  PPointer = ^Pointer;
  PPAnsiChar = ^PAnsiChar;

{$ENDIF}
//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9.h
//  Content:    D3DX utility library
//
//////////////////////////////////////////////////////////////////////////////

const
  // #define D3DX_DEFAULT ULONG_MAX
  // #define D3DX_DEFAULT            ((UINT) -1)
  D3DX_DEFAULT          = Cardinal(-1);
  {$EXTERNALSYM D3DX_DEFAULT}
  // #define D3DX_DEFAULT_NONPOW2    ((UINT) -2)
  D3DX_DEFAULT_NONPOW2  = Cardinal(-2);
  {$EXTERNALSYM D3DX_DEFAULT_NONPOW2}

var
  // #define D3DX_DEFAULT_FLOAT FLT_MAX
  // Forced to define as 'var' cos pascal compiler treats all consts as Double
  D3DX_DEFAULT_FLOAT: Single = 3.402823466e+38;  // max single value
  {$EXTERNALSYM D3DX_DEFAULT_FLOAT}

const
  D3DX_FROM_FILE          = LongWord(-3);
  {$EXTERNALSYM D3DX_FROM_FILE}
  D3DFMT_FROM_FILE        = TD3DFormat(-3);
  {$EXTERNALSYM D3DFMT_FROM_FILE}

type
  _D3DXERR = HResult;
  {$EXTERNALSYM _D3DXERR}

const
  D3DXERR_CANNOTMODIFYINDEXBUFFER       = HResult(MAKE_D3DHRESULT_R or 2900);
  {$EXTERNALSYM D3DXERR_CANNOTMODIFYINDEXBUFFER}
  D3DXERR_INVALIDMESH                   = HResult(MAKE_D3DHRESULT_R or 2901);
  {$EXTERNALSYM D3DXERR_INVALIDMESH}
  D3DXERR_CANNOTATTRSORT                = HResult(MAKE_D3DHRESULT_R or 2902);
  {$EXTERNALSYM D3DXERR_CANNOTATTRSORT}
  D3DXERR_SKINNINGNOTSUPPORTED          = HResult(MAKE_D3DHRESULT_R or 2903);
  {$EXTERNALSYM D3DXERR_SKINNINGNOTSUPPORTED}
  D3DXERR_TOOMANYINFLUENCES             = HResult(MAKE_D3DHRESULT_R or 2904);
  {$EXTERNALSYM D3DXERR_TOOMANYINFLUENCES}
  D3DXERR_INVALIDDATA                   = HResult(MAKE_D3DHRESULT_R or 2905);
  {$EXTERNALSYM D3DXERR_INVALIDDATA}
  D3DXERR_LOADEDMESHASNODATA            = HResult(MAKE_D3DHRESULT_R or 2906);
  {$EXTERNALSYM D3DXERR_LOADEDMESHASNODATA}
  D3DXERR_DUPLICATENAMEDFRAGMENT        = HResult(MAKE_D3DHRESULT_R or 2907);
  {$EXTERNALSYM D3DXERR_DUPLICATENAMEDFRAGMENT}
  D3DXERR_CANNOTREMOVELASTITEM          = HResult(MAKE_D3DHRESULT_R or 2908);
  {$EXTERNALSYM D3DXERR_CANNOTREMOVELASTITEM}




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9math.h
//  Content:    D3DX math types and functions
//
//////////////////////////////////////////////////////////////////////////////

//===========================================================================
//
// General purpose utilities
//
//===========================================================================
const
  D3DX_PI: Single       = 3.141592654;
  {$EXTERNALSYM D3DX_PI}
  D3DX_1BYPI: Single    = 0.318309886;
  {$EXTERNALSYM D3DX_1BYPI}

//#define D3DXToRadian( degree ) ((degree) * (D3DX_PI / 180.0f))
function D3DXToRadian(Degree: Single): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXToRadian}
//#define D3DXToDegree( radian ) ((radian) * (180.0f / D3DX_PI))
function D3DXToDegree(Radian: Single): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXToDegree}



//===========================================================================
//
// 16 bit floating point numbers
//
//===========================================================================

const
  D3DX_16F_DIG          = 3;               // # of decimal digits of precision
  {$EXTERNALSYM D3DX_16F_DIG}
  D3DX_16F_EPSILON      = 4.8875809e-4;    // smallest such that 1.0 + epsilon <> 1.0
  {$EXTERNALSYM D3DX_16F_EPSILON}
  D3DX_16F_MANT_DIG     = 11;              // # of bits in mantissa
  {$EXTERNALSYM D3DX_16F_MANT_DIG}
  D3DX_16F_MAX          = 6.550400e+004;   // max value
  {$EXTERNALSYM D3DX_16F_MAX}
  D3DX_16F_MAX_10_EXP   = 4;               // max decimal exponent
  {$EXTERNALSYM D3DX_16F_MAX_10_EXP}
  D3DX_16F_MAX_EXP      = 15;              // max binary exponent
  {$EXTERNALSYM D3DX_16F_MAX_EXP}
  D3DX_16F_MIN          = 6.1035156e-5;    // min positive value
  {$EXTERNALSYM D3DX_16F_MIN}
  D3DX_16F_MIN_10_EXP   = -4;              // min decimal exponent
  {$EXTERNALSYM D3DX_16F_MIN_10_EXP}
  D3DX_16F_MIN_EXP      = -14;             // min binary exponent
  {$EXTERNALSYM D3DX_16F_MIN_EXP}
  D3DX_16F_RADIX        = 2;               // exponent radix
  {$EXTERNALSYM D3DX_16F_RADIX}
  D3DX_16F_ROUNDS       = 1;               // addition rounding: near
  {$EXTERNALSYM D3DX_16F_ROUNDS}


type
  (*$HPPEMIT 'typedef D3DXFLOAT16       TD3DXFloat16;' *)
  (*$HPPEMIT 'typedef D3DXFLOAT16      *PD3DXFloat16;' *)
  PD3DXFloat16 = ^TD3DXFloat16;
  {$EXTERNALSYM PD3DXFloat16}
  TD3DXFloat16 = packed record
    value: Word;
  end;
  {$NODEFINE TD3DXFloat16}

// Some pascal equalents of C++ class functions & operators
const D3DXFloat16Zero: TD3DXFloat16 = (value:0); // 0
function D3DXFloat16(value: Single): TD3DXFloat16;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXFloat16Equal(const v1, v2: TD3DXFloat16): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXFloat16ToFloat(value: TD3DXFloat16): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//===========================================================================
//
// Vectors
//
//===========================================================================


//--------------------------
// 2D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR2       TD3DXVector2;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR2      *PD3DXVector2;' *)
  PD3DXVector2 = ^TD3DXVector2;
  {$EXTERNALSYM PD3DXVector2}
  TD3DXVector2 = record
    x, y: Single;
  end;
  {$NODEFINE TD3DXVector2}

// Some pascal equalents of C++ class functions & operators
const D3DXVector2Zero: TD3DXVector2 = (x:0; y:0);  // (0,0)
function D3DXVector2(_x, _y: Single): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2Equal(const v1, v2: TD3DXVector2): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 2D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR2_16F       TD3DXVector2_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR2_16F      *PD3DXVector2_16F;' *)
  PD3DXVector2_16F = ^TD3DXVector2_16F;
  {$EXTERNALSYM PD3DXVector2_16F}
  TD3DXVector2_16F = packed record
    x, y: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector2_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector2_16fZero: TD3DXVector2_16F = (x:(value:0); y:(value:0));  // (0,0)
function D3DXVector2_16F(_x, _y: TD3DXFloat16): TD3DXVector2_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2_16fEqual(const v1, v2: TD3DXVector2_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2_16fFromVector2(const v: TD3DXVector2): TD3DXVector2_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2FromVector2_16f(const v: TD3DXVector2_16f): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 3D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR3       TD3DXVector3;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR3      *PD3DXVector3;' *)
  PD3DXVector3 = ^TD3DXVector3;
  {$EXTERNALSYM PD3DXVector3}
  TD3DXVector3 = TD3DVector;
  {$NODEFINE TD3DXVector3}

// Some pascal equalents of C++ class functions & operators
const D3DXVector3Zero: TD3DXVector3 = (x:0; y:0; z:0);  // (0,0,0)
function D3DXVector3(_x, _y, _z: Single): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3Equal(const v1, v2: TD3DXVector3): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 3D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR3_16F       TD3DXVector3_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR3_16F      *PD3DXVector3_16F;' *)
  PD3DXVector3_16F = ^TD3DXVector3_16F;
  {$EXTERNALSYM PD3DXVector3}
  TD3DXVector3_16F = packed record
    x, y, z: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector3_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector3_16fZero: TD3DXVector3_16F = (x:(value:0); y:(value:0); z:(value:0));  // (0,0,0)
function D3DXVector3_16F(_x, _y, _z: TD3DXFloat16): TD3DXVector3_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3_16fEqual(const v1, v2: TD3DXVector3_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3_16fFromVector3(const v: TD3DXVector3): TD3DXVector3_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3FromVector3_16f(const v: TD3DXVector3_16f): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 4D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR4       TD3DXVector4;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR4      *PD3DXVector4;' *)
  PD3DXVector4 = ^TD3DXVector4;
  {$EXTERNALSYM PD3DXVector4}
  TD3DXVector4 = record
    x, y, z, w: Single;
  end;
  {$NODEFINE TD3DXVector4}

// Some pascal equalents of C++ class functions & operators
const D3DXVector4Zero: TD3DXVector4 = (x:0; y:0; z:0; w:0);  // (0,0,0,0)
function D3DXVector4(_x, _y, _z, _w: Single): TD3DXVector4; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4(xyz: TD3DXVector3; _w: Single): TD3DXVector4; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4Equal(const v1, v2: TD3DXVector4): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 4D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR4_16F       TD3DXVector4_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR4_16F      *PD3DXVector4_16F;' *)
  PD3DXVector4_16F = ^TD3DXVector4_16F;
  {$EXTERNALSYM PD3DXVector4_16F}
  TD3DXVector4_16F = packed record
    x, y, z, w: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector4_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector4_16fZero: TD3DXVector4_16F = (x:(value:0); y:(value:0); z:(value:0); w:(value:0));  // (0,0,0,0)
function D3DXVector4_16F(_x, _y, _z, _w: TD3DXFloat16): TD3DXVector4_16F; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16F(xyz: TD3DXVector3_16f; _w: TD3DXFloat16): TD3DXVector4_16F; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16fEqual(const v1, v2: TD3DXVector4_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16fFromVector4(const v: TD3DXVector4): TD3DXVector4_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4FromVector4_16f(const v: TD3DXVector4_16f): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//===========================================================================
//
// Matrices
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXMATRIX        TD3DXMatrix;' *)
  (*$HPPEMIT 'typedef D3DXMATRIX       *PD3DXMatrix;' *)
  (*$HPPEMIT 'typedef D3DXMATRIX      **PPD3DXMatrix;' *)
  PPD3DXMatrix = ^PD3DXMatrix;
  PD3DXMatrix = ^TD3DXMatrix;
  {$EXTERNALSYM PD3DXMatrix}
  TD3DXMatrix = TD3DMatrix;
  {$NODEFINE TD3DXMatrix}

// Some pascal equalents of C++ class functions & operators
function D3DXMatrix(
  _m00, _m01, _m02, _m03,
  _m10, _m11, _m12, _m13,
  _m20, _m21, _m22, _m23,
  _m30, _m31, _m32, _m33: Single): TD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixAdd(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixSubtract(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixMul(out mOut: TD3DXMatrix; const m: TD3DXMatrix; MulBy: Single): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixEqual(const m1, m2: TD3DXMatrix): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}


//---------------------------------------------------------------------------
// Aligned Matrices
//
// This class helps keep matrices 16-byte aligned as preferred by P4 cpus.
// It aligns matrices on the stack and on the heap or in global scope.
// It does this using __declspec(align(16)) which works on VC7 and on VC 6
// with the processor pack. Unfortunately there is no way to detect the
// latter so this is turned on only on VC7. On other compilers this is the
// the same as D3DXMATRIX.
//
// Using this class on a compiler that does not actually do the alignment
// can be dangerous since it will not expose bugs that ignore alignment.
// E.g if an object of this class in inside a struct or class, and some code
// memcopys data in it assuming tight packing. This could break on a compiler
// that eventually start aligning the matrix.
//---------------------------------------------------------------------------

// Translator comments: None of current pascal compilers can even align data
// inside records to 16 byte boundary, so we just leave aligned matrix
// declaration equal to standart matrix
type
  PD3DXMatrixA16 = ^TD3DXMatrixA16;
  TD3DXMatrixA16 = TD3DXMatrix;


//===========================================================================
//
//    Quaternions
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXQUATERNION TD3DXQuaternion;' *)
  PD3DXQuaternion = ^TD3DXQuaternion;
  TD3DXQuaternion = record
    x, y, z, w: Single;
  end;
  {$NODEFINE TD3DXQuaternion}

// Some pascal equalents of C++ class functions & operators
function D3DXQuaternion(_x, _y, _z, _w: Single): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionAdd(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionSubtract(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionEqual(const q1, q2: TD3DXQuaternion): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionScale(out qOut: TD3DXQuaternion; const q: TD3DXQuaternion;
  s: Single): PD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//===========================================================================
//
// Planes
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXPLANE TD3DXPlane;' *)
  PD3DXPlane = ^TD3DXPlane;
  TD3DXPlane = record
    a, b, c, d: Single;
  end;
  {$NODEFINE TD3DXPlane}

// Some pascal equalents of C++ class functions & operators
const D3DXPlaneZero: TD3DXPlane = (a:0; b:0; c:0; d:0);  // (0,0,0,0)
function D3DXPlane(_a, _b, _c, _d: Single): TD3DXPlane;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXPlaneEqual(const p1, p2: TD3DXPlane): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}


//===========================================================================
//
// Colors
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXCOLOR TD3DXColor;' *)
  (*$HPPEMIT 'typedef D3DXCOLOR *PD3DXColor;' *)
  PD3DXColor = PD3DColorValue;
  {$EXTERNALSYM PD3DXColor}
  TD3DXColor = TD3DColorValue;
  {$EXTERNALSYM TD3DXColor}

function D3DXColor(_r, _g, _b, _a: Single): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorToDWord(c: TD3DXColor): DWord;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorFromDWord(c: DWord): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorEqual(const c1, c2: TD3DXColor): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}


//===========================================================================
//
// D3DX math functions:
//
// NOTE:
//  * All these functions can take the same object as in and out parameters.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//===========================================================================

//--------------------------
// Float16
//--------------------------

// non-inline

// Converts an array 32-bit floats to 16-bit floats
function D3DXFloat32To16Array(pOut: PD3DXFloat16; pIn: PSingle; n: LongWord): PD3DXFloat16; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXFloat32To16Array}

// Converts an array 16-bit floats to 32-bit floats
function D3DXFloat16To32Array(pOut: PSingle; pIn: PD3DXFloat16; n: LongWord): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXFloat16To32Array}


//--------------------------
// 2D Vector
//--------------------------

// inline

function D3DXVec2Length(const v: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Length}

function D3DXVec2LengthSq(const v: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2LengthSq}

function D3DXVec2Dot(const v1, v2: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Dot}

// Z component of ((x1,y1,0) cross (x2,y2,0))
function D3DXVec2CCW(const v1, v2: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2CCW}

function D3DXVec2Add(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Add}

function D3DXVec2Subtract(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec2Minimize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec2Maximize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Maximize}

function D3DXVec2Scale(out vOut: TD3DXVector2; const v: TD3DXVector2; s: Single): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec2Lerp(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2; s: Single): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Lerp}

// non-inline
function D3DXVec2Normalize(out vOut: TD3DXVector2; const v: TD3DXVector2): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec2Hermite(out vOut: TD3DXVector2;
   const v1, t1, v2, t2: TD3DXVector2; s: Single): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec2CatmullRom(out vOut: TD3DXVector2;
   const v0, v1, v2, v3: TD3DXVector2; s: Single): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec2BaryCentric(out vOut: TD3DXVector2;
   const v1, v2, v3: TD3DXVector2; f, g: Single): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2BaryCentric}

// Transform (x, y, 0, 1) by matrix.
function D3DXVec2Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2Transform}

// Transform (x, y, 0, 1) by matrix, project result back into w=1.
function D3DXVec2TransformCoord(out vOut: TD3DXVector2;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2TransformCoord}

// Transform (x, y, 0, 0) by matrix.
function D3DXVec2TransformNormal(out vOut: TD3DXVector2;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2TransformNormal}


// Transform Array (x, y, 0, 1) by matrix.
function D3DXVec2TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2TransformArray}

// Transform Array (x, y, 0, 1) by matrix, project result back into w=1.
function D3DXVec2TransformCoordArray(pOut: PD3DXVector2; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2TransformCoordArray}

// Transform Array (x, y, 0, 0) by matrix.
function D3DXVec2TransformNormalArray(pOut: PD3DXVector2; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector2; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec2TransformNormalArray}


//--------------------------
// 3D Vector
//--------------------------

// inline

function D3DXVec3Length(const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Length}

function D3DXVec3LengthSq(const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3LengthSq}

function D3DXVec3Dot(const v1, v2: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Dot}

function D3DXVec3Cross(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Cross}

function D3DXVec3Add(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Add}

function D3DXVec3Subtract(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2), ...
function D3DXVec3Minimize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2), ...
function D3DXVec3Maximize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Maximize}

function D3DXVec3Scale(out vOut: TD3DXVector3; const v: TD3DXVector3; s: Single): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec3Lerp(out vOut: TD3DXVector3;
  const v1, v2: TD3DXVector3; s: Single): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Lerp}

// non-inline

function D3DXVec3Normalize(out vOut: TD3DXVector3;
   const v: TD3DXVector3): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec3Hermite(out vOut: TD3DXVector3;
   const v1, t1, v2, t2: TD3DXVector3; s: Single): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec3CatmullRom(out vOut: TD3DXVector3;
   const v0, v1, v2, v3: TD3DXVector3; s: Single): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec3BaryCentric(out vOut: TD3DXVector3;
   const v1, v2, v3: TD3DXVector3; f, g: Single): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3BaryCentric}

// Transform (x, y, z, 1) by matrix.
function D3DXVec3Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3Transform}

// Transform (x, y, z, 1) by matrix, project result back into w=1.
function D3DXVec3TransformCoord(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3TransformCoord}

// Transform (x, y, z, 0) by matrix.  If you transforming a normal by a
// non-affine matrix, the matrix you pass to this function should be the
// transpose of the inverse of the matrix you would use to transform a coord.
function D3DXVec3TransformNormal(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3TransformNormal}


// Transform Array (x, y, z, 1) by matrix.
function D3DXVec3TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3TransformArray}

// Transform Array (x, y, z, 1) by matrix, project result back into w=1.
function D3DXVec3TransformCoordArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3TransformCoordArray}

// Transform (x, y, z, 0) by matrix.  If you transforming a normal by a
// non-affine matrix, the matrix you pass to this function should be the
// transpose of the inverse of the matrix you would use to transform a coord.
function D3DXVec3TransformNormalArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3TransformNormalArray}

// Project vector from object space into screen space
function D3DXVec3Project(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3Project}

// Project vector from screen space into object space
function D3DXVec3Unproject(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3Unproject}

// Project vector Array from object space into screen space
function D3DXVec3ProjectArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3ProjectArray}

// Project vector Array from screen space into object space
function D3DXVec3UnprojectArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec3UnprojectArray}


//--------------------------
// 4D Vector
//--------------------------

// inline

function D3DXVec4Length(const v: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Length}

function D3DXVec4LengthSq(const v: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4LengthSq}

function D3DXVec4Dot(const v1, v2: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Dot}

function D3DXVec4Add(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Add}

function D3DXVec4Subtract(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2), ...
function D3DXVec4Minimize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2), ...
function D3DXVec4Maximize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Maximize}

function D3DXVec4Scale(out vOut: TD3DXVector4; const v: TD3DXVector4; s: Single): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec4Lerp(out vOut: TD3DXVector4;
  const v1, v2: TD3DXVector4; s: Single): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Lerp}

// non-inline

// Cross-product in 4 dimensions.
function D3DXVec4Cross(out vOut: TD3DXVector4;
  const v1, v2, v3: TD3DXVector4): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4Cross}

function D3DXVec4Normalize(out vOut: TD3DXVector4;
  const v: TD3DXVector4): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec4Hermite(out vOut: TD3DXVector4;
   const v1, t1, v2, t2: TD3DXVector4; s: Single): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec4CatmullRom(out vOut: TD3DXVector4;
   const v0, v1, v2, v3: TD3DXVector4; s: Single): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec4BaryCentric(out vOut: TD3DXVector4;
   const v1, v2, v3: TD3DXVector4; f, g: Single): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4BaryCentric}

// Transform vector by matrix.
function D3DXVec4Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector4; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4Transform}

// Transform vector array by matrix.
function D3DXVec4TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector4; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXVec4TransformArray}


//--------------------------
// 4D Matrix
//--------------------------

// inline

function D3DXMatrixIdentity(out mOut: TD3DXMatrix): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXMatrixIdentity}

function D3DXMatrixIsIdentity(const m: TD3DXMatrix): BOOL;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXMatrixIsIdentity}

// non-inline

function D3DXMatrixDeterminant(const m: TD3DXMatrix): Single; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixDeterminant}

function D3DXMatrixDecompose(pOutScale: PD3DXVector3; pOutRotation: PD3DXQuaternion;
   pOutTranslation: PD3DXVector3; const M: TD3DXMatrix): HRESULT; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixDecompose}

function D3DXMatrixTranspose(out pOut: TD3DXMatrix; const pM: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixTranspose}

// Matrix multiplication.  The result represents the transformation M2
// followed by the transformation M1.  (Out = M1 * M2)
function D3DXMatrixMultiply(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixMultiply}

// Matrix multiplication, followed by a transpose. (Out = T(M1 * M2))
function D3DXMatrixMultiplyTranspose(out pOut: TD3DXMatrix; const pM1, pM2: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixMultiplyTranspose}

// Calculate inverse of matrix.  Inversion my fail, in which case NULL will
// be returned.  The determinant of pM is also returned it pfDeterminant
// is non-NULL.
function D3DXMatrixInverse(out mOut: TD3DXMatrix; pfDeterminant: PSingle;
    const m: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixInverse}

// Build a matrix which scales by (sx, sy, sz)
function D3DXMatrixScaling(out mOut: TD3DXMatrix; sx, sy, sz: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixScaling}

// Build a matrix which translates by (x, y, z)
function D3DXMatrixTranslation(out mOut: TD3DXMatrix; x, y, z: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixTranslation}

// Build a matrix which rotates around the X axis
function D3DXMatrixRotationX(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixRotationX}

// Build a matrix which rotates around the Y axis
function D3DXMatrixRotationY(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixRotationY}

// Build a matrix which rotates around the Z axis
function D3DXMatrixRotationZ(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixRotationZ}

// Build a matrix which rotates around an arbitrary axis
function D3DXMatrixRotationAxis(out mOut: TD3DXMatrix; const v: TD3DXVector3;
  angle: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixRotationAxis}

// Build a matrix from a quaternion
function D3DXMatrixRotationQuaternion(out mOut: TD3DXMatrix; const Q: TD3DXQuaternion): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixRotationQuaternion}

// Yaw around the Y axis, a pitch around the X axis,
// and a roll around the Z axis.
function D3DXMatrixRotationYawPitchRoll(out mOut: TD3DXMatrix; yaw, pitch, roll: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixRotationYawPitchRoll}

// Build transformation matrix.  NULL arguments are treated as identity.
// Mout = Msc-1 * Msr-1 * Ms * Msr * Msc * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixTransformation(out mOut: TD3DXMatrix;
   pScalingCenter: PD3DXVector3;
   pScalingRotation: PD3DXQuaternion; pScaling, pRotationCenter: PD3DXVector3;
   pRotation: PD3DXQuaternion; pTranslation: PD3DXVector3): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixTransformation}

// Build 2D transformation matrix in XY plane.  NULL arguments are treated as identity.
// Mout = Msc-1 * Msr-1 * Ms * Msr * Msc * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixTransformation2D(out pOut: TD3DXMatrix;
   pScalingCenter: PD3DXVector2;
   ScalingRotation: Single; pScaling: PD3DXVector2; pRotationCenter: PD3DXVector2;
   Rotation: Single; pTranslation: PD3DXVector2): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixTransformation2D}

// Build affine transformation matrix.  NULL arguments are treated as identity.
// Mout = Ms * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixAffineTransformation(out mOut: TD3DXMatrix;
   Scaling: Single; pRotationCenter: PD3DXVector3;
   pRotation: PD3DXQuaternion; pTranslation: PD3DXVector3): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixAffineTransformation}

// Build 2D affine transformation matrix in XY plane.  NULL arguments are treated as identity.
// Mout = Ms * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixAffineTransformation2D(out mOut: TD3DXMatrix;
   Scaling: Single; pRotationCenter: PD3DXVector2;
   Rotation: Single; pTranslation: PD3DXVector2): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixAffineTransformation2D}

// Build a lookat matrix. (right-handed)
function D3DXMatrixLookAtRH(out mOut: TD3DXMatrix; const Eye, At, Up: TD3DXVector3): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixLookAtRH}

// Build a lookat matrix. (left-handed)
function D3DXMatrixLookAtLH(out mOut: TD3DXMatrix; const Eye, At, Up: TD3DXVector3): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixLookAtLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveRH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixPerspectiveRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveLH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixPerspectiveLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveFovRH(out mOut: TD3DXMatrix; flovy, aspect, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixPerspectiveFovRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveFovLH(out mOut: TD3DXMatrix; flovy, aspect, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixPerspectiveFovLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveOffCenterRH(out mOut: TD3DXMatrix;
   l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixPerspectiveOffCenterRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveOffCenterLH(out mOut: TD3DXMatrix;
   l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixPerspectiveOffCenterLH}

// Build an ortho projection matrix. (right-handed)
function D3DXMatrixOrthoRH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixOrthoRH}

// Build an ortho projection matrix. (left-handed)
function D3DXMatrixOrthoLH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixOrthoLH}

// Build an ortho projection matrix. (right-handed)
function D3DXMatrixOrthoOffCenterRH(out mOut: TD3DXMatrix;
  l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixOrthoOffCenterRH}

// Build an ortho projection matrix. (left-handed)
function D3DXMatrixOrthoOffCenterLH(out mOut: TD3DXMatrix;
  l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixOrthoOffCenterLH}

// Build a matrix which flattens geometry into a plane, as if casting
// a shadow from a light.
function D3DXMatrixShadow(out mOut: TD3DXMatrix;
  const Light: TD3DXVector4; const Plane: TD3DXPlane): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixShadow}

// Build a matrix which reflects the coordinate system about a plane
function D3DXMatrixReflect(out mOut: TD3DXMatrix;
   const Plane: TD3DXPlane): PD3DXMatrix; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXMatrixReflect}


//--------------------------
// Quaternion
//--------------------------

// inline

function D3DXQuaternionLength(const q: TD3DXQuaternion): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionLength}

// Length squared, or "norm"
function D3DXQuaternionLengthSq(const q: TD3DXQuaternion): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionLengthSq}

function D3DXQuaternionDot(const q1, q2: TD3DXQuaternion): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionDot}

// (0, 0, 0, 1)
function D3DXQuaternionIdentity(out qOut: TD3DXQuaternion): PD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionIdentity}

function D3DXQuaternionIsIdentity (const q: TD3DXQuaternion): BOOL;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionIsIdentity}

// (-x, -y, -z, w)
function D3DXQuaternionConjugate(out qOut: TD3DXQuaternion;
  const q: TD3DXQuaternion): PD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionConjugate}


// non-inline

// Compute a quaternin's axis and angle of rotation. Expects unit quaternions.
procedure D3DXQuaternionToAxisAngle(const q: TD3DXQuaternion;
  out Axis: TD3DXVector3; out Angle: Single); stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionToAxisAngle}

// Build a quaternion from a rotation matrix.
function D3DXQuaternionRotationMatrix(out qOut: TD3DXQuaternion;
  const m: TD3DXMatrix): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionRotationMatrix}

// Rotation about arbitrary axis.
function D3DXQuaternionRotationAxis(out qOut: TD3DXQuaternion;
  const v: TD3DXVector3; Angle: Single): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionRotationAxis}

// Yaw around the Y axis, a pitch around the X axis,
// and a roll around the Z axis.
function D3DXQuaternionRotationYawPitchRoll(out qOut: TD3DXQuaternion;
  yaw, pitch, roll: Single): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionRotationYawPitchRoll}

// Quaternion multiplication.  The result represents the rotation Q2
// followed by the rotation Q1.  (Out = Q2 * Q1)
function D3DXQuaternionMultiply(out qOut: TD3DXQuaternion;
   const q1, q2: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionMultiply}

function D3DXQuaternionNormalize(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionNormalize}

// Conjugate and re-norm
function D3DXQuaternionInverse(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionInverse}

// Expects unit quaternions.
// if q = (cos(theta), sin(theta) * v); ln(q) = (0, theta * v)
function D3DXQuaternionLn(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionLn}

// Expects pure quaternions. (w == 0)  w is ignored in calculation.
// if q = (0, theta * v); exp(q) = (cos(theta), sin(theta) * v)
function D3DXQuaternionExp(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionExp}

// Spherical linear interpolation between Q1 (s == 0) and Q2 (s == 1).
// Expects unit quaternions.
function D3DXQuaternionSlerp(out qOut: TD3DXQuaternion;
   const q1, q2: TD3DXQuaternion; t: Single): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionSlerp}

// Spherical quadrangle interpolation.
// Slerp(Slerp(Q1, C, t), Slerp(A, B, t), 2t(1-t))
function D3DXQuaternionSquad(out qOut: TD3DXQuaternion;
   const pQ1, pA, pB, pC: TD3DXQuaternion; t: Single): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionSquad}

// Setup control points for spherical quadrangle interpolation
// from Q1 to Q2.  The control points are chosen in such a way
// to ensure the continuity of tangents with adjacent segments.
procedure D3DXQuaternionSquadSetup(out pAOut, pBOut, pCOut: TD3DXQuaternion;
   const pQ0, pQ1, pQ2, pQ3: TD3DXQuaternion); stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionSquadSetup}

// Barycentric interpolation.
// Slerp(Slerp(Q1, Q2, f+g), Slerp(Q1, Q3, f+g), g/(f+g))
function D3DXQuaternionBaryCentric(out qOut: TD3DXQuaternion;
   const q1, q2, q3: TD3DXQuaternion; f, g: Single): PD3DXQuaternion; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXQuaternionBaryCentric}


//--------------------------
// Plane
//--------------------------

// inline

// ax + by + cz + dw
function D3DXPlaneDot(const p: TD3DXPlane; const v: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneDot}

// ax + by + cz + d
function D3DXPlaneDotCoord(const p: TD3DXPlane; const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneDotCoord}

// ax + by + cz
function D3DXPlaneDotNormal(const p: TD3DXPlane; const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneDotNormal}

function D3DXPlaneScale(out pOut: TD3DXPlane; const pP: TD3DXPlane; s: Single): PD3DXPlane;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneScale}


// non-inline

// Normalize plane (so that |a,b,c| == 1)
function D3DXPlaneNormalize(out pOut: TD3DXPlane; const p: TD3DXPlane): PD3DXPlane; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXPlaneNormalize}

// Find the intersection between a plane and a line.  If the line is
// parallel to the plane, NULL is returned.
function D3DXPlaneIntersectLine(out pOut: TD3DXVector3;
   const p: TD3DXPlane; const v1, v2: TD3DXVector3): PD3DXVector3; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXPlaneIntersectLine}

// Construct a plane from a point and a normal
function D3DXPlaneFromPointNormal(out pOut: TD3DXPlane;
   const vPoint, vNormal: TD3DXVector3): PD3DXPlane; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXPlaneFromPointNormal}

// Construct a plane from 3 points
function D3DXPlaneFromPoints(out pOut: TD3DXPlane;
   const v1, v2, v3: TD3DXVector3): PD3DXPlane; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXPlaneFromPoints}

// Transform a plane by a matrix.  The vector (a,b,c) must be normal.
// M should be the inverse transpose of the transformation desired.
function D3DXPlaneTransform(out pOut: TD3DXPlane; const p: TD3DXPlane; const m: TD3DXMatrix): PD3DXPlane; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXPlaneTransform}

// Transform an array of planes by a matrix.  The vectors (a,b,c) must be normal.
// M should be the inverse transpose of the transformation desired.
function D3DXPlaneTransformArray(pOut: PD3DXPlane; OutStride: LongWord;
  pP: PD3DXPlane; PStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXPlane; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXPlaneTransformArray}


//--------------------------
// Color
//--------------------------

// inline

// (1-r, 1-g, 1-b, a)
function D3DXColorNegative(out cOut: TD3DXColor; const c: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorNegative}

function D3DXColorAdd(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorAdd}

function D3DXColorSubtract(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorSubtract}

function D3DXColorScale(out cOut: TD3DXColor; const c: TD3DXColor; s: Single): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorScale}

// (r1*r2, g1*g2, b1*b2, a1*a2)
function D3DXColorModulate(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorModulate}

// Linear interpolation of r,g,b, and a. C1 + s(C2-C1)
function D3DXColorLerp(out cOut: TD3DXColor; const c1, c2: TD3DXColor; s: Single): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorLerp}

// non-inline

// Interpolate r,g,b between desaturated color and color.
// DesaturatedColor + s(Color - DesaturatedColor)
function D3DXColorAdjustSaturation(out cOut: TD3DXColor;
   const pC: TD3DXColor; s: Single): PD3DXColor; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXColorAdjustSaturation}

// Interpolate r,g,b between 50% grey and color.  Grey + s(Color - Grey)
function D3DXColorAdjustContrast(out cOut: TD3DXColor;
   const pC: TD3DXColor; c: Single): PD3DXColor; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXColorAdjustContrast}


//--------------------------
// Misc
//--------------------------

// Calculate Fresnel term given the cosine of theta (likely obtained by
// taking the dot of two normals), and the refraction index of the material.
function D3DXFresnelTerm(CosTheta, RefractionIndex: Single): Single; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXFresnelTerm}



//===========================================================================
//
//    Matrix Stack
//
//===========================================================================

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXMatrixStack);'}
  {$EXTERNALSYM ID3DXMatrixStack}
  ID3DXMatrixStack = interface(IUnknown)
    ['{C7885BA7-F990-4fe7-922D-8515E477DD85}']
    //
    // ID3DXMatrixStack methods
    //

    // Pops the top of the stack, returns the current top
    // *after* popping the top.
    function Pop: HResult; stdcall;

    // Pushes the stack by one, duplicating the current matrix.
    function Push: HResult; stdcall;

    // Loads identity in the current matrix.
    function LoadIdentity: HResult; stdcall;

    // Loads the given matrix into the current matrix
    function LoadMatrix(const M: TD3DXMatrix): HResult; stdcall;

    // Right-Multiplies the given matrix to the current matrix.
    // (transformation is about the current world origin)
    function MultMatrix(const M: TD3DXMatrix): HResult; stdcall;

    // Left-Multiplies the given matrix to the current matrix
    // (transformation is about the local origin of the object)
    function MultMatrixLocal(const M: TD3DXMatrix): HResult; stdcall;

    // Right multiply the current matrix with the computed rotation
    // matrix, counterclockwise about the given axis with the given angle.
    // (rotation is about the current world origin)
    function RotateAxis(const V: TD3DXVector3; Angle: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed rotation
    // matrix, counterclockwise about the given axis with the given angle.
    // (rotation is about the local origin of the object)
    function RotateAxisLocal(const V: TD3DXVector3; Angle: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed rotation
    // matrix. All angles are counterclockwise. (rotation is about the
    // current world origin)

    // The rotation is composed of a yaw around the Y axis, a pitch around
    // the X axis, and a roll around the Z axis.
    function RotateYawPitchRoll(yaw, pitch, roll: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed rotation
    // matrix. All angles are counterclockwise. (rotation is about the
    // local origin of the object)

    // The rotation is composed of a yaw around the Y axis, a pitch around
    // the X axis, and a roll around the Z axis.
    function RotateYawPitchRollLocal(yaw, pitch, roll: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed scale
    // matrix. (transformation is about the current world origin)
    function Scale(x, y, z: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed scale
    // matrix. (transformation is about the local origin of the object)
    function ScaleLocal(x, y, z: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed translation
    // matrix. (transformation is about the current world origin)
    function Translate(x, y, z: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed translation
    // matrix. (transformation is about the local origin of the object)
    function TranslateLocal(x, y, z: Single): HResult; stdcall;

    // Obtain the current matrix at the top of the stack
    function GetTop: PD3DXMatrix; stdcall;
  end;

type
  IID_ID3DXMatrixStack = ID3DXMatrixStack;
  {$EXTERNALSYM IID_ID3DXMatrixStack}

function D3DXCreateMatrixStack(Flags: DWord; out Stack: ID3DXMatrixStack): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXCreateMatrixStack}

//===========================================================================
//
//  Spherical Harmonic Runtime Routines
//
// NOTE:
//  * Most of these functions can take the same object as in and out parameters.
//    The exceptions are the rotation functions.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//============================================================================


//============================================================================
//
//  Basic Spherical Harmonic math routines
//
//============================================================================

const
  D3DXSH_MINORDER = 2;
  {$EXTERNALSYM D3DXSH_MINORDER}
  D3DXSH_MAXORDER = 6;
  {$EXTERNALSYM D3DXSH_MAXORDER}

//============================================================================
//
//  D3DXSHEvalDirection:
//  --------------------
//  Evaluates the Spherical Harmonic basis functions
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction to evaluate in - assumed to be normalized
//
//============================================================================

function D3DXSHEvalDirection(pOut: PSingle; Order: LongWord;
    const pDir: TD3DXVector3): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHEvalDirection}

//============================================================================
//
//  D3DXSHRotate:
//  --------------------
//  Rotates SH vector by a rotation matrix
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned (should not alias with pIn.)
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pMatrix
//      Matrix used for rotation - rotation sub matrix should be orthogonal
//      and have a unit determinant.
//   pIn
//      Input SH coeffs (rotated), incorect results if this is also output.
//
//============================================================================

function D3DXSHRotate(pOut: PSingle; Order: LongWord;
    const pMatrix: TD3DXMatrix; pIn: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHRotate}

//============================================================================
//
//  D3DXSHRotateZ:
//  --------------------
//  Rotates the SH vector in the Z axis by an angle
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned (should not alias with pIn.)
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   Angle
//      Angle in radians to rotate around the Z axis.
//   pIn
//      Input SH coeffs (rotated), incorect results if this is also output.
//
//============================================================================

function D3DXSHRotateZ(pOut: PSingle; Order: LongWord;
    Angle: Single; pIn: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHRotateZ}

//============================================================================
//
//  D3DXSHAdd:
//  --------------------
//  Adds two SH vectors, pOut[i] = pA[i] + pB[i];
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pA
//      Input SH coeffs.
//   pB
//      Input SH coeffs (second vector.)
//
//============================================================================

function D3DXSHAdd(pOut: PSingle; Order: LongWord;
    pA, pB: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHAdd}

//============================================================================
//
//  D3DXSHScale:
//  --------------------
//  Adds two SH vectors, pOut[i] = pA[i]*Scale;
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pIn
//      Input SH coeffs.
//   Scale
//      Scale factor.
//
//============================================================================

function D3DXSHScale(pOut: PSingle; Order: LongWord;
    pIn: PSingle; Scale: Single): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHScale}

//============================================================================
//
//  D3DXSHDot:
//  --------------------
//  Computes the dot product of two SH vectors
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pA
//      Input SH coeffs.
//   pB
//      Second set of input SH coeffs.
//
//============================================================================

function D3DXSHDot(Order: LongWord; pA, pB: PSingle): Single; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHDot}

//============================================================================
//
//  D3DXSHMultiply[O]:
//  --------------------
//  Computes the product of two functions represented using SH (f and g), where:
//  pOut[i] = int(y_i(s) * f(s) * g(s)), where y_i(s) is the ith SH basis
//  function, f(s) and g(s) are SH functions (sum_i(y_i(s)*c_i)).  The order O
//  determines the lengths of the arrays, where there should always be O^2
//  coefficients.  In general the product of two SH functions of order O generates
//  and SH function of order 2*O - 1, but we truncate the result.  This means
//  that the product commutes (f*g == g*f) but doesn't associate
//  (f*(g*h) != (f*g)*h.
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   pF
//      Input SH coeffs for first function.
//   pG
//      Second set of input SH coeffs.
//
//============================================================================

function D3DXSHMultiply2(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHMultiply2}
function D3DXSHMultiply3(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHMultiply3}
function D3DXSHMultiply4(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHMultiply4}
function D3DXSHMultiply5(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHMultiply5}
function D3DXSHMultiply6(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHMultiply6}

//============================================================================
//
//  Basic Spherical Harmonic lighting routines
//
//============================================================================

//============================================================================
//
//  D3DXSHEvalDirectionalLight:
//  --------------------
//  Evaluates a directional light and returns spectral SH data.  The output 
//  vector is computed so that if the intensity of R/G/B is unit the resulting
//  exit radiance of a point directly under the light on a diffuse object with
//  an albedo of 1 would be 1.0.  This will compute 3 spectral samples, pROut
//  has to be specified, while pGout and pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction light is coming from (assumed to be normalized.)
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalDirectionalLight(Order: LongWord; const pDir: TD3DXVector3;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHEvalDirectionalLight}

//============================================================================
//
//  D3DXSHEvalSphericalLight:
//  --------------------
//  Evaluates a spherical light and returns spectral SH data.  There is no
//  normalization of the intensity of the light like there is for directional
//  lights, care has to be taken when specifiying the intensities.  This will
//  compute 3 spectral samples, pROut has to be specified, while pGout and
//  pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pPos
//      Position of light - reciever is assumed to be at the origin.
//   Radius
//      Radius of the spherical light source.
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalSphericalLight(Order: LongWord; const pPos: TD3DXVector3; Radius: Single;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHEvalSphericalLight}

//============================================================================
//
//  D3DXSHEvalConeLight:
//  --------------------
//  Evaluates a light that is a cone of constant intensity and returns spectral
//  SH data.  The output vector is computed so that if the intensity of R/G/B is
//  unit the resulting exit radiance of a point directly under the light oriented
//  in the cone direction on a diffuse object with an albedo of 1 would be 1.0.
//  This will compute 3 spectral samples, pROut has to be specified, while pGout
//  and pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction light is coming from (assumed to be normalized.)
//   Radius
//      Radius of cone in radians.
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalConeLight(Order: LongWord; const pDir: TD3DXVector3; Radius: Single;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHEvalConeLight}
      
//============================================================================
//
//  D3DXSHEvalHemisphereLight:
//  --------------------
//  Evaluates a light that is a linear interpolant between two colors over the
//  sphere.  The interpolant is linear along the axis of the two points, not
//  over the surface of the sphere (ie: if the axis was (0,0,1) it is linear in
//  Z, not in the azimuthal angle.)  The resulting spherical lighting function
//  is normalized so that a point on a perfectly diffuse surface with no
//  shadowing and a normal pointed in the direction pDir would result in exit
//  radiance with a value of 1 if the top color was white and the bottom color
//  was black.  This is a very simple model where Top represents the intensity 
//  of the "sky" and Bottom represents the intensity of the "ground".
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Axis of the hemisphere.
//   Top
//      Color of the upper hemisphere.
//   Bottom
//      Color of the lower hemisphere.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green
//   pBOut
//      Output SH vector for Blue        
//
//============================================================================

function D3DXSHEvalHemisphereLight(Order: LongWord; const pDir: TD3DXVector3;
    Top, Bottom: TD3DXColor;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHEvalHemisphereLight}

//============================================================================
//
//  Basic Spherical Harmonic projection routines
//
//============================================================================

//============================================================================
//
//  D3DXSHProjectCubeMap:
//  --------------------
//  Projects a function represented on a cube map into spherical harmonics.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pCubeMap
//      CubeMap that is going to be projected into spherical harmonics
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green
//   pBOut
//      Output SH vector for Blue
//
//============================================================================

function D3DXSHProjectCubeMap(Order: LongWord; pCubeMap: IDirect3DCubeTexture9;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXSHProjectCubeMap}







///////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9core.h
//  Content:    D3DX core types and functions
//
///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
// D3DX_SDK_VERSION:
// -----------------
// This identifier is passed to D3DXCheckVersion in order to ensure that an
// application was built against the correct header files and lib files.
// This number is incremented whenever a header (or other) change would
// require applications to be rebuilt. If the version doesn't match,
// D3DXCheckVersion will return FALSE. (The number itself has no meaning.)
///////////////////////////////////////////////////////////////////////////

const
  D3DX_VERSION          = $0902;
  {$EXTERNALSYM D3DX_VERSION}
  D3DX_SDK_VERSION      = 33;
  {$EXTERNALSYM D3DX_SDK_VERSION}

function D3DXCheckVersion(D3DSdkVersion, D3DXSdkVersion: LongWord): BOOL; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXCheckVersion}



///////////////////////////////////////////////////////////////////////////
// D3DXDebugMute
//    Mutes D3DX and D3D debug spew (TRUE - mute, FALSE - not mute)
//
//  returns previous mute value
//
///////////////////////////////////////////////////////////////////////////

function D3DXDebugMute(Mute: BOOL): BOOL; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXDebugMute}



///////////////////////////////////////////////////////////////////////////
// D3DXGetDriverLevel:
//    Returns driver version information:
//
//    700 - DX7 level driver
//    800 - DX8 level driver
//    900 - DX9 level driver
///////////////////////////////////////////////////////////////////////////

function D3DXGetDriverLevel(pDevice: IDirect3DDevice9): LongWord; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXGetDriverLevel}


///////////////////////////////////////////////////////////////////////////
// ID3DXBuffer:
// ------------
// The buffer object is used by D3DX to return arbitrary size data.
//
// GetBufferPointer -
//    Returns a pointer to the beginning of the buffer.
//
// GetBufferSize -
//    Returns the size of the buffer, in bytes.
///////////////////////////////////////////////////////////////////////////

type
  PID3DXBuffer = ^ID3DXBuffer;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXBuffer);'}
  {$EXTERNALSYM ID3DXBuffer}
  ID3DXBuffer = interface(IUnknown)
    ['{8BA5FB08-5195-40e2-AC58-0D989C3A0102}']
    // ID3DXBuffer
    function GetBufferPointer: Pointer; stdcall;
    function GetBufferSize: DWord; stdcall;
  end;

  IID_ID3DXBuffer = ID3DXBuffer;
  {$EXTERNALSYM IID_ID3DXBuffer}


//////////////////////////////////////////////////////////////////////////////
// D3DXSPRITE flags:
// -----------------
// D3DXSPRITE_DONOTSAVESTATE
//   Specifies device state is not to be saved and restored in Begin/End.
// D3DXSPRITE_DONOTMODIFY_RENDERSTATE
//   Specifies device render state is not to be changed in Begin.  The device
//   is assumed to be in a valid state to draw vertices containing POSITION0,
//   TEXCOORD0, and COLOR0 data.
// D3DXSPRITE_OBJECTSPACE
//   The WORLD, VIEW, and PROJECTION transforms are NOT modified.  The
//   transforms currently set to the device are used to transform the sprites
//   when the batch is drawn (at Flush or End).  If this is not specified,
//   WORLD, VIEW, and PROJECTION transforms are modified so that sprites are
//   drawn in screenspace coordinates.
// D3DXSPRITE_BILLBOARD
//   Rotates each sprite about its center so that it is facing the viewer.
// D3DXSPRITE_ALPHABLEND
//   Enables ALPHABLEND(SRCALPHA, INVSRCALPHA) and ALPHATEST(alpha > 0).
//   ID3DXFont expects this to be set when drawing text.
// D3DXSPRITE_SORT_TEXTURE
//   Sprites are sorted by texture prior to drawing.  This is recommended when
//   drawing non-overlapping sprites of uniform depth.  For example, drawing
//   screen-aligned text with ID3DXFont.
// D3DXSPRITE_SORT_DEPTH_FRONTTOBACK
//   Sprites are sorted by depth front-to-back prior to drawing.  This is
//   recommended when drawing opaque sprites of varying depths.
// D3DXSPRITE_SORT_DEPTH_BACKTOFRONT
//   Sprites are sorted by depth back-to-front prior to drawing.  This is
//   recommended when drawing transparent sprites of varying depths.
// D3DXSPRITE_DO_NOT_ADDREF_TEXTURE
//   Disables calling AddRef() on every draw, and Release() on Flush() for
//   better performance.
//////////////////////////////////////////////////////////////////////////////

const
  D3DXSPRITE_DONOTSAVESTATE               = (1 shl 0);
  {$EXTERNALSYM D3DXSPRITE_DONOTSAVESTATE}
  D3DXSPRITE_DONOTMODIFY_RENDERSTATE      = (1 shl 1);
  {$EXTERNALSYM D3DXSPRITE_DONOTMODIFY_RENDERSTATE}
  D3DXSPRITE_OBJECTSPACE                  = (1 shl 2);
  {$EXTERNALSYM D3DXSPRITE_OBJECTSPACE}
  D3DXSPRITE_BILLBOARD                    = (1 shl 3);
  {$EXTERNALSYM D3DXSPRITE_BILLBOARD}
  D3DXSPRITE_ALPHABLEND                   = (1 shl 4);
  {$EXTERNALSYM D3DXSPRITE_ALPHABLEND}
  D3DXSPRITE_SORT_TEXTURE                 = (1 shl 5);
  {$EXTERNALSYM D3DXSPRITE_SORT_TEXTURE}
  D3DXSPRITE_SORT_DEPTH_FRONTTOBACK       = (1 shl 6);
  {$EXTERNALSYM D3DXSPRITE_SORT_DEPTH_FRONTTOBACK}
  D3DXSPRITE_SORT_DEPTH_BACKTOFRONT       = (1 shl 7);
  {$EXTERNALSYM D3DXSPRITE_SORT_DEPTH_BACKTOFRONT}
  D3DXSPRITE_DO_NOT_ADDREF_TEXTURE        = (1 shl 8);
  {$EXTERNALSYM D3DXSPRITE_DO_NOT_ADDREF_TEXTURE}


//////////////////////////////////////////////////////////////////////////////
// ID3DXSprite:
// ------------
// This object intends to provide an easy way to drawing sprites using D3D.
//
// Begin -
//    Prepares device for drawing sprites.
//
// Draw -
//    Draws a sprite.  Before transformation, the sprite is the size of
//    SrcRect, with its top-left corner specified by Position.  The color
//    and alpha channels are modulated by Color.
//
// Flush -
//    Forces all batched sprites to submitted to the device.
//
// End -
//    Restores device state to how it was when Begin was called.
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
//////////////////////////////////////////////////////////////////////////////

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXSprite);'}
  {$EXTERNALSYM ID3DXSprite}
  ID3DXSprite = interface(IUnknown)
    ['{BA0B762D-7D28-43ec-B9DC-2F84443B0614}']
    // ID3DXSprite
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;

    function GetTransform(out pTransform: TD3DXMatrix): HResult; stdcall;
    function SetTransform(const pTransform: TD3DXMatrix): HResult; stdcall;

    function SetWorldViewRH(pWorld, pView: PD3DXMatrix): HResult; stdcall;
    function SetWorldViewLH(pWorld, pView: PD3DXMatrix): HResult; stdcall;

    function _Begin(Flags: DWORD): HResult; stdcall;
    function Draw(pTexture: IDirect3DTexture9; pSrcRect: PRect; pCenter, pPosition: PD3DXVector3; Color: TD3DColor): HResult; stdcall;
    function Flush: HResult; stdcall;
    function _End: HResult; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXSprite = ID3DXSprite;
  {$EXTERNALSYM IID_ID3DXSprite}

function D3DXCreateSprite(pDevice: IDirect3DDevice9;
  out ppSprite: ID3DXSprite): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXCreateSprite}



//////////////////////////////////////////////////////////////////////////////
// ID3DXFont:
// ----------
// Font objects contain the textures and resources needed to render a specific 
// font on a specific device.
//
// GetGlyphData -
//    Returns glyph cache data, for a given glyph.
//
// PreloadCharacters/PreloadGlyphs/PreloadText -
//    Preloads glyphs into the glyph cache textures.
//
// DrawText -
//    Draws formatted text on a D3D device.  Some parameters are 
//    surprisingly similar to those of GDI's DrawText function.  See GDI 
//    documentation for a detailed description of these parameters.
//    If pSprite is NULL, an internal sprite object will be used.
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
//////////////////////////////////////////////////////////////////////////////

type
  PD3DXFontDescA = ^TD3DXFontDescA;
  PD3DXFontDescW = ^TD3DXFontDescW;
  PD3DXFontDesc = PD3DXFontDescA;
  _D3DXFONT_DESCA = record
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of AnsiChar;
  end;
  {$EXTERNALSYM _D3DXFONT_DESCA}
  _D3DXFONT_DESCW = record
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of WideChar;
  end;
  {$EXTERNALSYM _D3DXFONT_DESCW}
  _D3DXFONT_DESC = _D3DXFONT_DESCA;
  {$EXTERNALSYM _D3DXFONT_DESC}
  D3DXFONT_DESCA = _D3DXFONT_DESCA;
  {$EXTERNALSYM D3DXFONT_DESCA}
  D3DXFONT_DESCW = _D3DXFONT_DESCW;
  {$EXTERNALSYM D3DXFONT_DESCW}
  D3DXFONT_DESC = D3DXFONT_DESCA;
  {$EXTERNALSYM D3DXFONT_DESC}
  TD3DXFontDescA = _D3DXFONT_DESCA;
  TD3DXFontDescW = _D3DXFONT_DESCW;
  TD3DXFontDesc = TD3DXFontDescA;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFont);'}
  {$EXTERNALSYM ID3DXFont}
  ID3DXFont = interface(IUnknown)
    ['{D79DBB70-5F21-4d36-BBC2-FF525C213CDC}']
    // ID3DXFont
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetDescA(out pDesc: TD3DXFontDescA): HResult; stdcall;
    function GetDescW(out pDesc: TD3DXFontDescW): HResult; stdcall;
    function GetTextMetricsA(out pTextMetrics: TTextMetricA): BOOL; stdcall;
    function GetTextMetricsW(out pTextMetrics: TTextMetricW): BOOL; stdcall;

    function GetDC: HDC; stdcall;
    function GetGlyphData(Glyph: LongWord; out ppTexture: IDirect3DTexture9; pBlackBox: PRect; pCellInc: PPoint): HResult; stdcall;

    function PreloadCharacters(First, Last: LongWord): HResult; stdcall;
    function PreloadGlyphs(First, Last: LongWord): HResult; stdcall;
    function PreloadTextA(pString: PAnsiChar; Count: Integer): HResult; stdcall;
    function PreloadTextW(pString: PWideChar; Count: Integer): HResult; stdcall;

    function DrawTextA(pSprite: ID3DXSprite; pString: PAnsiChar; Count: Integer; pRect: PRect; Format: DWORD; Color: TD3DColor): Integer; stdcall;
    function DrawTextW(pSprite: ID3DXSprite; pString: PWideChar; Count: Integer; pRect: PRect; Format: DWORD; Color: TD3DColor): Integer; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXFont = ID3DXFont;
  {$EXTERNALSYM IID_ID3DXFont}


function D3DXCreateFontA(
  pDevice: IDirect3DDevice9;
  Height: Integer;
  Width: Longint;
  Weight: LongWord;
  MipLevels: LongWord;
  Italic: BOOL;
  CharSet: DWORD;
  OutputPrecision: DWORD;
  Quality: DWORD;
  PitchAndFamily: DWORD;
  pFaceName: PAnsiChar;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9DLL name 'D3DXCreateFontA';
{$EXTERNALSYM D3DXCreateFontA}

function D3DXCreateFontW(
  pDevice: IDirect3DDevice9;
  Height: Integer;
  Width: Longint;
  Weight: LongWord;
  MipLevels: LongWord;
  Italic: BOOL;
  CharSet: DWORD;
  OutputPrecision: DWORD;
  Quality: DWORD;
  PitchAndFamily: DWORD;
  pFaceName: PWideChar;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9DLL name 'D3DXCreateFontW';
{$EXTERNALSYM D3DXCreateFontW}

function D3DXCreateFont(
  pDevice: IDirect3DDevice9;
  Height: Integer;
  Width: Longint;
  Weight: LongWord;
  MipLevels: LongWord;
  Italic: BOOL;
  CharSet: DWORD;
  OutputPrecision: DWORD;
  Quality: DWORD;
  PitchAndFamily: DWORD;
  pFaceName: PAnsiChar;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9DLL name 'D3DXCreateFontA';
{$EXTERNALSYM D3DXCreateFont}


function D3DXCreateFontIndirectA(
  pDevice: IDirect3DDevice9;
  const pDesc: TD3DXFontDescA;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9DLL name 'D3DXCreateFontIndirectA';
{$EXTERNALSYM D3DXCreateFontIndirectA}

function D3DXCreateFontIndirectW(
  pDevice: IDirect3DDevice9;
  const pDesc: TD3DXFontDescW;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9DLL name 'D3DXCreateFontIndirectW';
{$EXTERNALSYM D3DXCreateFontIndirectW}

function D3DXCreateFontIndirect(
  pDevice: IDirect3DDevice9;
  const pDesc: TD3DXFontDesc;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9DLL name 'D3DXCreateFontIndirectA';
{$EXTERNALSYM D3DXCreateFontIndirect}

//---------------------------------------------------------------------------
// D3DXTX_VERSION:
// --------------
// Version token used to create a procedural texture filler in effects
// Used by D3DXFill[]TX functions
//---------------------------------------------------------------------------
// #define D3DXTX_VERSION(_Major,_Minor) (('T' << 24) | ('X' << 16) | ((_Major) << 8) | (_Minor))
function D3DXTX_VERSION(_Major, _Minor: Byte): DWORD;
{$EXTERNALSYM D3DXTX_VERSION}

(*
 * DirectX File errors.
 *)

const
  _FACD3DXF = $876;
  {$EXTERNALSYM _FACD3DXF}
  MAKE_D3DXFERR_D     = (1 shl 31) or (_FACD3DXF shl 16);

  D3DXFERR_BADOBJECT              = HResult(MAKE_D3DXFERR_D or 900);
  {$EXTERNALSYM D3DXFERR_BADOBJECT}
  D3DXFERR_BADVALUE               = HResult(MAKE_D3DXFERR_D or 901);
  {$EXTERNALSYM D3DXFERR_BADVALUE}
  D3DXFERR_BADTYPE                = HResult(MAKE_D3DXFERR_D or 902);
  {$EXTERNALSYM D3DXFERR_BADTYPE}
  D3DXFERR_NOTFOUND               = HResult(MAKE_D3DXFERR_D or 903);
  {$EXTERNALSYM D3DXFERR_NOTFOUND}
  D3DXFERR_NOTDONEYET             = HResult(MAKE_D3DXFERR_D or 904);
  {$EXTERNALSYM D3DXFERR_NOTDONEYET}
  D3DXFERR_FILENOTFOUND           = HResult(MAKE_D3DXFERR_D or 905);
  {$EXTERNALSYM D3DXFERR_FILENOTFOUND}
  D3DXFERR_RESOURCENOTFOUND       = HResult(MAKE_D3DXFERR_D or 906);
  {$EXTERNALSYM D3DXFERR_RESOURCENOTFOUND}
  D3DXFERR_BADRESOURCE            = HResult(MAKE_D3DXFERR_D or 907);
  {$EXTERNALSYM D3DXFERR_BADRESOURCE}
  D3DXFERR_BADFILETYPE            = HResult(MAKE_D3DXFERR_D or 908);
  {$EXTERNALSYM D3DXFERR_BADFILETYPE}
  D3DXFERR_BADFILEVERSION         = HResult(MAKE_D3DXFERR_D or 909);
  {$EXTERNALSYM D3DXFERR_BADFILEVERSION}
  D3DXFERR_BADFILEFLOATSIZE       = HResult(MAKE_D3DXFERR_D or 910);
  {$EXTERNALSYM D3DXFERR_BADFILEFLOATSIZE}
  D3DXFERR_BADFILE                = HResult(MAKE_D3DXFERR_D or 911);
  {$EXTERNALSYM D3DXFERR_BADFILE}
  D3DXFERR_PARSEERROR             = HResult(MAKE_D3DXFERR_D or 912);
  {$EXTERNALSYM D3DXFERR_PARSEERROR}
  D3DXFERR_BADARRAYSIZE           = HResult(MAKE_D3DXFERR_D or 913);
  {$EXTERNALSYM D3DXFERR_BADARRAYSIZE}
  D3DXFERR_BADDATAREFERENCE       = HResult(MAKE_D3DXFERR_D or 914);
  {$EXTERNALSYM D3DXFERR_BADDATAREFERENCE}
  D3DXFERR_NOMOREOBJECTS          = HResult(MAKE_D3DXFERR_D or 915);
  {$EXTERNALSYM D3DXFERR_NOMOREOBJECTS}
  D3DXFERR_NOMOREDATA             = HResult(MAKE_D3DXFERR_D or 916);
  {$EXTERNALSYM D3DXFERR_NOMOREDATA}
  D3DXFERR_BADCACHEFILE           = HResult(MAKE_D3DXFERR_D or 917);
  {$EXTERNALSYM D3DXFERR_BADCACHEFILE}




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9mesh.h
//  Content:    D3DX mesh types and functions
//
//////////////////////////////////////////////////////////////////////////////

type
  //patch mesh can be quads or tris
  _D3DXPATCHMESHTYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DXPATCHMESH_invalid_0,
    D3DXPATCHMESH_RECT   {= $001},
    D3DXPATCHMESH_TRI    {= $002},
    D3DXPATCHMESH_NPATCH {= $003}
  {$ELSE}
    D3DXPATCHMESH_RECT   = $001,
    D3DXPATCHMESH_TRI    = $002,
    D3DXPATCHMESH_NPATCH = $003
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DXPATCHMESHTYPE}
  D3DXPATCHMESHTYPE = _D3DXPATCHMESHTYPE;
  {$EXTERNALSYM D3DXPATCHMESHTYPE}
  TD3DXPatchMeshType = _D3DXPATCHMESHTYPE;

type
  _D3DXMESH = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DXMESH}
  TD3DXMesh = _D3DXMESH;

// Mesh options - lower 3 bytes only, upper byte used by _D3DXMESHOPT option flags
const
  D3DXMESH_32BIT                  = $001; // If set, then use 32 bit indices, if not set use 16 bit indices.
  {$EXTERNALSYM D3DXMESH_32BIT}
  D3DXMESH_DONOTCLIP              = $002; // Use D3DUSAGE_DONOTCLIP for VB & IB.
  {$EXTERNALSYM D3DXMESH_DONOTCLIP}
  D3DXMESH_POINTS                 = $004; // Use D3DUSAGE_POINTS for VB & IB.
  {$EXTERNALSYM D3DXMESH_POINTS}
  D3DXMESH_RTPATCHES              = $008; // Use D3DUSAGE_RTPATCHES for VB & IB.
  {$EXTERNALSYM D3DXMESH_RTPATCHES}
  D3DXMESH_NPATCHES      = $4000;// Use D3DUSAGE_NPATCHES for VB & IB.
  {$EXTERNALSYM D3DXMESH_NPATCHES}
  D3DXMESH_VB_SYSTEMMEM      = $010; // Use D3DPOOL_SYSTEMMEM for VB. Overrides D3DXMESH_MANAGEDVERTEXBUFFER
  {$EXTERNALSYM D3DXMESH_VB_SYSTEMMEM}
  D3DXMESH_VB_MANAGED             = $020; // Use D3DPOOL_MANAGED for VB.
  {$EXTERNALSYM D3DXMESH_VB_MANAGED}
  D3DXMESH_VB_WRITEONLY           = $040; // Use D3DUSAGE_WRITEONLY for VB.
  {$EXTERNALSYM D3DXMESH_VB_WRITEONLY}
  D3DXMESH_VB_DYNAMIC             = $080; // Use D3DUSAGE_DYNAMIC for VB.
  {$EXTERNALSYM D3DXMESH_VB_DYNAMIC}
  D3DXMESH_VB_SOFTWAREPROCESSING = $8000; // Use D3DUSAGE_SOFTWAREPROCESSING for VB.
  {$EXTERNALSYM D3DXMESH_VB_SOFTWAREPROCESSING}
  D3DXMESH_IB_SYSTEMMEM      = $100; // Use D3DPOOL_SYSTEMMEM for IB. Overrides D3DXMESH_MANAGEDINDEXBUFFER
  {$EXTERNALSYM D3DXMESH_IB_SYSTEMMEM}
  D3DXMESH_IB_MANAGED             = $200; // Use D3DPOOL_MANAGED for IB.
  {$EXTERNALSYM D3DXMESH_IB_MANAGED}
  D3DXMESH_IB_WRITEONLY           = $400; // Use D3DUSAGE_WRITEONLY for IB.
  {$EXTERNALSYM D3DXMESH_IB_WRITEONLY}
  D3DXMESH_IB_DYNAMIC             = $800; // Use D3DUSAGE_DYNAMIC for IB.
  {$EXTERNALSYM D3DXMESH_IB_DYNAMIC}
  D3DXMESH_IB_SOFTWAREPROCESSING= $10000; // Use D3DUSAGE_SOFTWAREPROCESSING for IB.
  {$EXTERNALSYM D3DXMESH_IB_SOFTWAREPROCESSING}

  D3DXMESH_VB_SHARE               = $1000; // Valid for Clone* calls only, forces cloned mesh/pmesh to share vertex buffer
  {$EXTERNALSYM D3DXMESH_VB_SHARE}

  D3DXMESH_USEHWONLY              = $2000; // Valid for ID3DXSkinInfo.ConvertToBlendedMesh
  {$EXTERNALSYM D3DXMESH_USEHWONLY}

  // Helper options
  D3DXMESH_SYSTEMMEM      = $110; // D3DXMESH_VB_SYSTEMMEM | D3DXMESH_IB_SYSTEMMEM
  {$EXTERNALSYM D3DXMESH_SYSTEMMEM}
  D3DXMESH_MANAGED                = $220; // D3DXMESH_VB_MANAGED | D3DXMESH_IB_MANAGED
  {$EXTERNALSYM D3DXMESH_MANAGED}
  D3DXMESH_WRITEONLY              = $440; // D3DXMESH_VB_WRITEONLY | D3DXMESH_IB_WRITEONLY
  {$EXTERNALSYM D3DXMESH_WRITEONLY}
  D3DXMESH_DYNAMIC                = $880; // D3DXMESH_VB_DYNAMIC | D3DXMESH_IB_DYNAMIC
  {$EXTERNALSYM D3DXMESH_DYNAMIC}
  D3DXMESH_SOFTWAREPROCESSING   = $18000; // D3DXMESH_VB_SOFTWAREPROCESSING | D3DXMESH_IB_SOFTWAREPROCESSING
  {$EXTERNALSYM D3DXMESH_SOFTWAREPROCESSING}

type
  //patch mesh options
  _D3DXPATCHMESH = (
    D3DXPATCHMESH_DEFAULT {= 000,}
  );
  {$EXTERNALSYM _D3DXPATCHMESH}
  D3DXPATCHMESH = _D3DXPATCHMESH;
  {$EXTERNALSYM D3DXPATCHMESH}
  TD3DXPatchMesh = _D3DXPATCHMESH;

  // option field values for specifying min value in D3DXGeneratePMesh and D3DXSimplifyMesh
  _D3DXMESHSIMP = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DXMESHSIMP_invalid_0{= 0x0},
    D3DXMESHSIMP_VERTEX   {= 0x1},
    D3DXMESHSIMP_FACE     {= 0x2}
  {$ELSE}
    D3DXMESHSIMP_VERTEX   = $1,
    D3DXMESHSIMP_FACE     = $2
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DXMESHSIMP}
  TD3DXMeshSimp = _D3DXMESHSIMP;

{$IFNDEF SUPPORTS_EXPL_ENUMS}
const
  D3DXCLEAN_BACKFACING  = $00000001;
  {$EXTERNALSYM D3DXCLEAN_BACKFACING}
  D3DXCLEAN_BOWTIES     = $00000002;
  {$EXTERNALSYM D3DXCLEAN_BOWTIES}

  // Helper options
  D3DXCLEAN_SKINNING         = D3DXCLEAN_BACKFACING;  // Bowtie cleaning modifies geometry and breaks skinning
  {$EXTERNALSYM D3DXCLEAN_SKINNING}
  D3DXCLEAN_OPTIMIZATION     = D3DXCLEAN_BACKFACING;
  {$EXTERNALSYM D3DXCLEAN_OPTIMIZATION}
  D3DXCLEAN_SIMPLIFICATION   = D3DXCLEAN_BACKFACING + D3DXCLEAN_BOWTIES;
  {$EXTERNALSYM D3DXCLEAN_SIMPLIFICATION}

type
  _D3DXCLEANTYPE = DWord;
  {$EXTERNALSYM _D3DXCLEANTYPE}
{$ELSE}
  _D3DXCLEANTYPE = (
    D3DXCLEAN_BACKFACING     = $00000001,
    D3DXCLEAN_BOWTIES        = $00000002,

    // Helper options
    D3DXCLEAN_SKINNING       = D3DXCLEAN_BACKFACING,  // Bowtie cleaning modifies geometry and breaks skinning
    D3DXCLEAN_OPTIMIZATION   = D3DXCLEAN_BACKFACING,
    D3DXCLEAN_SIMPLIFICATION = D3DXCLEAN_BACKFACING + D3DXCLEAN_BOWTIES
  );
  {$EXTERNALSYM _D3DXCLEANTYPE}

{$ENDIF}
  D3DXCLEANTYPE = _D3DXCLEANTYPE;
  {$EXTERNALSYM D3DXCLEANTYPE}
  TD3DXCleanType = _D3DXCLEANTYPE;

  _MAX_FVF_DECL_SIZE = DWord;
  {$EXTERNALSYM _MAX_FVF_DECL_SIZE}
const
  MAX_FVF_DECL_SIZE = MAXD3DDECLLENGTH + 1; // +1 for END
  {$EXTERNALSYM MAX_FVF_DECL_SIZE}

type
  TFVFDeclaration = array [0..MAX_FVF_DECL_SIZE-1] of TD3DVertexElement9;

const
  D3DXTANGENT_WRAP_U =                    $01;
  {$EXTERNALSYM D3DXTANGENT_WRAP_U}
  D3DXTANGENT_WRAP_V =                    $02;
  {$EXTERNALSYM D3DXTANGENT_WRAP_V}
  D3DXTANGENT_WRAP_UV =                   $03;
  {$EXTERNALSYM D3DXTANGENT_WRAP_UV}
  D3DXTANGENT_DONT_NORMALIZE_PARTIALS =   $04;
  {$EXTERNALSYM D3DXTANGENT_DONT_NORMALIZE_PARTIALS}
  D3DXTANGENT_DONT_ORTHOGONALIZE =        $08;
  {$EXTERNALSYM D3DXTANGENT_DONT_ORTHOGONALIZE}
  D3DXTANGENT_ORTHOGONALIZE_FROM_V =      $010;
  {$EXTERNALSYM D3DXTANGENT_ORTHOGONALIZE_FROM_V}
  D3DXTANGENT_ORTHOGONALIZE_FROM_U =      $020;
  {$EXTERNALSYM D3DXTANGENT_ORTHOGONALIZE_FROM_U}
  D3DXTANGENT_WEIGHT_BY_AREA =            $040;
  {$EXTERNALSYM D3DXTANGENT_WEIGHT_BY_AREA}
  D3DXTANGENT_WEIGHT_EQUAL =              $080;
  {$EXTERNALSYM D3DXTANGENT_WEIGHT_EQUAL}
  D3DXTANGENT_WIND_CW =                   $0100;
  {$EXTERNALSYM D3DXTANGENT_WIND_CW}
  D3DXTANGENT_CALCULATE_NORMALS =         $0200;
  {$EXTERNALSYM D3DXTANGENT_CALCULATE_NORMALS}
  D3DXTANGENT_GENERATE_IN_PLACE =         $0400;
  {$EXTERNALSYM D3DXTANGENT_GENERATE_IN_PLACE}

type
  _D3DXTANGENT = DWord;
  {$EXTERNALSYM _D3DXTANGENT}
  D3DXTANGENT = _D3DXTANGENT;
  {$EXTERNALSYM D3DXCLEANTYPE}
  TD3DXTangent = _D3DXTANGENT;

  // D3DXIMT_WRAP_U means the texture wraps in the U direction
  // D3DXIMT_WRAP_V means the texture wraps in the V direction
  // D3DXIMT_WRAP_UV means the texture wraps in both directions
  _D3DXIMT = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DXIMT_WRAP_invalid_0,
    D3DXIMT_WRAP_U                   {= $01},
    D3DXIMT_WRAP_V                   {= $02},
    D3DXIMT_WRAP_UV                  {= $03}
  {$ELSE}
    D3DXIMT_WRAP_U                    = $01,
    D3DXIMT_WRAP_V                    = $02,
    D3DXIMT_WRAP_UV                   = $03
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DXIMT}
  D3DXIMT = _D3DXIMT;
  {$EXTERNALSYM D3DXIMT}
  TD3DXIMT = _D3DXIMT;


  // These options are only valid for UVAtlasCreate and UVAtlasPartition, we may add more for UVAtlasPack if necessary
  // D3DXUVATLAS_DEFAULT - Meshes with more than 25k faces go through fast, meshes with fewer than 25k faces go through quality
  // D3DXUVATLAS_GEODESIC_FAST - Uses approximations to improve charting speed at the cost of added stretch or more charts.
  // D3DXUVATLAS_GEODESIC_QUALITY - Provides better quality charts, but requires more time and memory than fast.
  _D3DXUVATLAS = (
    D3DXUVATLAS_DEFAULT               {= $00},
    D3DXUVATLAS_GEODESIC_FAST         {= $01},
    D3DXUVATLAS_GEODESIC_QUALITY      {= $02}
   );
   {$EXTERNALSYM _D3DXUVATLAS}
   D3DXUVATLAS = _D3DXUVATLAS;
   {$EXTERNALSYM D3DXUVATLAS}
   TD3DXUVAtlas = D3DXUVATLAS;

  PD3DXAttributeRange = ^TD3DXAttributeRange;
  _D3DXATTRIBUTERANGE = record
    AttribId:    DWord;
    FaceStart:   DWord;
    FaceCount:   DWord;
    VertexStart: DWord;
    VertexCount: DWord;
  end;
  {$EXTERNALSYM _D3DXATTRIBUTERANGE}
  D3DXATTRIBUTERANGE = _D3DXATTRIBUTERANGE;
  {$EXTERNALSYM D3DXATTRIBUTERANGE}
  TD3DXAttributeRange = _D3DXATTRIBUTERANGE;

  PD3DXMaterial = ^TD3DXMaterial;
  _D3DXMATERIAL = record
    MatD3D: TD3Dmaterial9;
    pTextureFilename: PAnsiChar;
  end;
  {$EXTERNALSYM _D3DXMATERIAL}
  D3DXMATERIAL = _D3DXMATERIAL;
  {$EXTERNALSYM D3DXMATERIAL}
  TD3DXMaterial = _D3DXMATERIAL;

  _D3DXEFFECTDEFAULTTYPE = (
  {$IFNDEF SUPPORTS_EXPL_ENUMS}
    D3DXEDT_invalid_0,
    D3DXEDT_STRING {= $1},      // pValue points to a null terminated ASCII string
    D3DXEDT_FLOATS {= $2},      // pValue points to an array of floats - number of floats is NumBytes / sizeof(float)
    D3DXEDT_DWORD  {= $3}       // pValue points to a DWORD
  {$ELSE}
    D3DXEDT_STRING = $1,        // pValue points to a null terminated ASCII string
    D3DXEDT_FLOATS = $2,        // pValue points to an array of floats - number of floats is NumBytes / sizeof(float)
    D3DXEDT_DWORD  = $3         // pValue points to a DWORD
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DXEFFECTDEFAULTTYPE}
  D3DXEFFECTDEFAULTTYPE = _D3DXEFFECTDEFAULTTYPE;
  {$EXTERNALSYM D3DXEFFECTDEFAULTTYPE}
  TD3DXEffectDefaultType = _D3DXEFFECTDEFAULTTYPE;

  PD3DXEffectDefault = ^TD3DXEffectDefault;
  _D3DXEFFECTDEFAULT = record
    pParamName: PAnsiChar;
    _Type: TD3DXEffectDefaultType;        // type of the data pointed to by pValue
    NumBytes: DWORD;                      // size in bytes of the data pointed to by pValue
    pValue: Pointer;                      // data for the default of the effect
  end;
  {$EXTERNALSYM _D3DXEFFECTDEFAULT}
  D3DXEFFECTDEFAULT = _D3DXEFFECTDEFAULT;
  {$EXTERNALSYM D3DXEFFECTDEFAULT}
  TD3DXEffectDefault = _D3DXEFFECTDEFAULT;

  PD3DXEffectInstance = ^TD3DXEffectInstance;
  _D3DXEFFECTINSTANCE = record
    pEffectFilename: PAnsiChar;
    NumDefaults: DWORD;
    pDefaults: PD3DXEffectDefault;
  end;
  {$EXTERNALSYM _D3DXEFFECTINSTANCE}
  D3DXEFFECTINSTANCE = _D3DXEFFECTINSTANCE;
  {$EXTERNALSYM D3DXEFFECTINSTANCE}
  TD3DXEffectInstance = _D3DXEFFECTINSTANCE;

  PD3DXAttributeWeights = ^TD3DXAttributeWeights;
  _D3DXATTRIBUTEWEIGHTS = record
    Position: Single;
    Boundary: Single;
    Normal:   Single;
    Diffuse:  Single;
    Specular: Single;
    Texcoord: array[0..7] of Single;
    Tangent: Single;
    Binormal: Single;
  end;
  {$EXTERNALSYM _D3DXATTRIBUTEWEIGHTS}
  D3DXATTRIBUTEWEIGHTS = _D3DXATTRIBUTEWEIGHTS;
  {$EXTERNALSYM D3DXATTRIBUTEWEIGHTS}
  TD3DXAttributeWeights = _D3DXATTRIBUTEWEIGHTS;

  _D3DXWELDEPSILONSFLAGS = {$IFDEF TYPE_IDENTITY}type {$ENDIF}DWord;
  {$EXTERNALSYM _D3DXWELDEPSILONSFLAGS}
  TD3DXWeldEpsilonsFlags = _D3DXWELDEPSILONSFLAGS;

const
  D3DXWELDEPSILONS_WELDALL = $1;              // weld all vertices marked by adjacency as being overlapping
  {$EXTERNALSYM D3DXWELDEPSILONS_WELDALL}

  D3DXWELDEPSILONS_WELDPARTIALMATCHES = $2;   // if a given vertex component is within epsilon, modify partial matched
                                                 // vertices so that both components identical AND if all components "equal"
                                                 // remove one of the vertices
  {$EXTERNALSYM D3DXWELDEPSILONS_WELDPARTIALMATCHES}
  D3DXWELDEPSILONS_DONOTREMOVEVERTICES = $4;  // instructs weld to only allow modifications to vertices and not removal
                                                 // ONLY valid if D3DXWELDEPSILONS_WELDPARTIALMATCHES is set
                                                 // useful to modify vertices to be equal, but not allow vertices to be removed
  {$EXTERNALSYM D3DXWELDEPSILONS_DONOTREMOVEVERTICES}
  D3DXWELDEPSILONS_DONOTSPLIT          = $8;  // instructs weld to specify the D3DXMESHOPT_DONOTSPLIT flag when doing an Optimize(ATTR_SORT)
                                                 // if this flag is not set, all vertices that are in separate attribute groups
                                                 // will remain split and not welded.  Setting this flag can slow down software vertex processing
  {$EXTERNALSYM D3DXWELDEPSILONS_DONOTSPLIT}

type
  PD3DXWeldEpsilons = ^TD3DXWeldEpsilons;
  _D3DXWELDEPSILONS = record
    Position: Single; // NOTE: This does NOT replace the epsilon in GenerateAdjacency
                      // in general, it should be the same value or greater than the one passed to GeneratedAdjacency
    BlendWeights: Single;
    Normal: Single;
    PSize: Single;
    Specular: Single;
    Diffuse: Single;
    Texcoord: array[0..7] of Single;
    Tangent: Single;
    Binormal: Single;
    TessFactor: Single;
  end;
  {$EXTERNALSYM _D3DXWELDEPSILONS}
  D3DXWELDEPSILONS = _D3DXWELDEPSILONS;
  {$EXTERNALSYM D3DXWELDEPSILONS}
  TD3DXWeldEpsilons = _D3DXWELDEPSILONS;

  PID3DXMesh = ^ID3DXMesh;
  ID3DXMesh = interface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXBaseMesh);'}
  {$EXTERNALSYM ID3DXBaseMesh}
  ID3DXBaseMesh = interface(IUnknown)
    ['{7ED943DD-52E8-40b5-A8D8-76685C406330}']
    // ID3DXBaseMesh
    function DrawSubset(AttribId: DWord): HResult; stdcall;
    function GetNumFaces: DWord; stdcall;
    function GetNumVertices: DWord; stdcall;
    function GetFVF: DWord; stdcall;
    function GetDeclaration(out Declaration: TFVFDeclaration): HResult; stdcall;
    function GetNumBytesPerVertex: DWORD; stdcall;
    function GetOptions: DWord; stdcall;
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function CloneMeshFVF(Options, FVF: DWord; pD3DDevice: IDirect3DDevice9;
      out ppCloneMesh: ID3DXMesh): HResult; stdcall;
    function CloneMesh(Options: DWORD; pDeclaration: PD3DVertexElement9;
      pD3DDevice: IDirect3DDevice9; out ppCloneMesh: ID3DXMesh): HResult; stdcall;
    function GetVertexBuffer(out ppVB: IDirect3DVertexBuffer9): HResult; stdcall;
    function GetIndexBuffer(out ppIB: IDirect3DIndexBuffer9): HResult; stdcall;
    function LockVertexBuffer(Flags: DWord; out ppData: Pointer): HResult; stdcall;
    function UnlockVertexBuffer: HResult; stdcall;
    function LockIndexBuffer(Flags: DWord; out ppData: Pointer): HResult; stdcall;
    function UnlockIndexBuffer: HResult; stdcall;
    function GetAttributeTable(pAttribTable: PD3DXAttributeRange;
      pAttribTableSize: PDWord): HResult; stdcall;

    function ConvertPointRepsToAdjacency(pPRep: PDWord; pAdjacency: PDWord): HResult; stdcall;
    function ConvertAdjacencyToPointReps(pAdjacency: PDWord; pPRep: PDWord): HResult; stdcall;
    function GenerateAdjacency(Epsilon: Single; pAdjacency: PDWord): HResult; stdcall;

    function UpdateSemantics(const Declaration: TFVFDeclaration): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXMesh);'}
  {$EXTERNALSYM ID3DXMesh}
  ID3DXMesh = interface(ID3DXBaseMesh)
    ['{4020E5C2-1403-4929-883F-E2E849FAC195}']
    // ID3DXMesh
    function LockAttributeBuffer(Flags: DWord; out ppData: PDWORD): HResult; stdcall;
    function UnlockAttributeBuffer: HResult; stdcall;
    function Optimize(Flags: DWord; pAdjacencyIn, pAdjacencyOut: PDWord;
      pFaceRemap: PDWord; ppVertexRemap: PID3DXBuffer;
      out ppOptMesh: ID3DXMesh): HResult; stdcall;
    function OptimizeInplace(Flags: DWord; pAdjacencyIn, pAdjacencyOut: PDWord;
      pFaceRemap: PDWord; ppVertexRemap: PID3DXBuffer): HResult; stdcall;
    function SetAttributeTable(pAttribTable: PD3DXAttributeRange; cAttribTableSize: DWORD): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXPMesh);'}
  {$EXTERNALSYM ID3DXPMesh}
  ID3DXPMesh = interface(ID3DXBaseMesh)
    ['{8875769A-D579-4088-AAEB-534D1AD84E96}']
    // ID3DXPMesh
    function ClonePMeshFVF(Options, FVF: DWord; pD3DDevice: IDirect3DDevice9;
      out ppCloneMesh: ID3DXPMesh): HResult; stdcall;
    function ClonePMesh(Options: DWORD; pDeclaration: PD3DVertexElement9;
      pD3DDevice: IDirect3DDevice9; out ppCloneMesh: ID3DXPMesh): HResult; stdcall;
    function SetNumFaces(Faces: DWord): HResult; stdcall;
    function SetNumVertices(Vertices: DWord): HResult; stdcall;
    function GetMaxFaces: DWord; stdcall;
    function GetMinFaces: DWord; stdcall;
    function GetMaxVertices: DWord; stdcall;
    function GetMinVertices: DWord; stdcall;
    function Save(pStream: IStream; pMaterials: PD3DXMaterial;
      pEffectInstances: PD3DXEffectInstance; NumMaterials: DWORD): HResult; stdcall;

    function Optimize(Flags: DWord; pAdjacencyOut: PDWord;
      pFaceRemap: PDWord; ppVertexRemap: PID3DXBuffer;
      out ppOptMesh: ID3DXMesh): HResult; stdcall;

    function OptimizeBaseLOD(Flags: DWord; pFaceRemap: PDWord): HResult; stdcall;
    function TrimByFaces(NewFacesMin, NewFacesMax: DWord; rgiFaceRemap, rgiVertRemap: PDWord): HResult; stdcall;
    function TrimByVertices(NewVerticesMin, NewVerticesMax: DWord; rgiFaceRemap, rgiVertRemap: PDWord): HResult; stdcall;

    function GetAdjacency(pAdjacency: PDWord): HResult; stdcall;

    //  Used to generate the immediate "ancestor" for each vertex when it is removed by a vsplit.  Allows generation of geomorphs
    //     Vertex buffer must be equal to or greater than the maximum number of vertices in the pmesh
    function GenerateVertexHistory(pVertexHistory: PDWORD): HResult; stdcall;
  end;

//----------------------------------------------------------------------------
// D3DX_FILTER flags:
// ------------------
//
// A valid filter must contain one of these values:
//
//  D3DX_FILTER_NONE
//      No scaling or filtering will take place.  Pixels outside the bounds
//      of the source image are assumed to be transparent black.
//  D3DX_FILTER_POINT
//      Each destination pixel is computed by sampling the nearest pixel
//      from the source image.
//  D3DX_FILTER_LINEAR
//      Each destination pixel is computed by linearly interpolating between
//      the nearest pixels in the source image.  This filter works best
//      when the scale on each axis is less than 2.
//  D3DX_FILTER_TRIANGLE
//      Every pixel in the source image contributes equally to the
//      destination image.  This is the slowest of all the filters.
//  D3DX_FILTER_BOX
//      Each pixel is computed by averaging a 2x2(x2) box pixels from
//      the source image. Only works when the dimensions of the
//      destination are half those of the source. (as with mip maps)
//
// And can be OR'd with any of these optional flags:
//
//  D3DX_FILTER_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR_W
//      Indicates that pixels off the edge of the texture on the W-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR
//      Same as specifying D3DX_FILTER_MIRROR_U | D3DX_FILTER_MIRROR_V |
//      D3DX_FILTER_MIRROR_V
//  D3DX_FILTER_DITHER
//      Dithers the resulting image using a 4x4 order dither pattern.
//  D3DX_FILTER_SRGB_IN
//      Denotes that the input data is in sRGB (gamma 2.2) colorspace.
//  D3DX_FILTER_SRGB_OUT
//      Denotes that the output data is in sRGB (gamma 2.2) colorspace.
//  D3DX_FILTER_SRGB
//      Same as specifying D3DX_FILTER_SRGB_IN | D3DX_FILTER_SRGB_OUT
//
//----------------------------------------------------------------------------

const
  D3DX_FILTER_NONE      = (1 shl 0);
  {$EXTERNALSYM D3DX_FILTER_NONE}
  D3DX_FILTER_POINT     = (2 shl 0);
  {$EXTERNALSYM D3DX_FILTER_POINT}
  D3DX_FILTER_LINEAR    = (3 shl 0);
  {$EXTERNALSYM D3DX_FILTER_LINEAR}
  D3DX_FILTER_TRIANGLE  = (4 shl 0);
  {$EXTERNALSYM D3DX_FILTER_TRIANGLE}
  D3DX_FILTER_BOX       = (5 shl 0);
  {$EXTERNALSYM D3DX_FILTER_BOX}

  D3DX_FILTER_MIRROR_U  = (1 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR_U}
  D3DX_FILTER_MIRROR_V  = (2 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR_V}
  D3DX_FILTER_MIRROR_W  = (4 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR_W}
  D3DX_FILTER_MIRROR    = (7 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR}

  D3DX_FILTER_DITHER    = (1 shl 19);
  {$EXTERNALSYM D3DX_FILTER_DITHER}
  D3DX_FILTER_DITHER_DIFFUSION = (2 shl 19);
  {$EXTERNALSYM D3DX_FILTER_DITHER_DIFFUSION}

  D3DX_FILTER_SRGB_IN   = (1 shl 21);
  {$EXTERNALSYM D3DX_FILTER_SRGB_IN}
  D3DX_FILTER_SRGB_OUT  = (2 shl 21);
  {$EXTERNALSYM D3DX_FILTER_SRGB_OUT}
  D3DX_FILTER_SRGB      = (3 shl 21);
  {$EXTERNALSYM D3DX_FILTER_SRGB}


//-----------------------------------------------------------------------------
// D3DX_SKIP_DDS_MIP_LEVELS is used to skip mip levels when loading a DDS file:
//-----------------------------------------------------------------------------

const
  D3DX_SKIP_DDS_MIP_LEVELS_MASK   = $1F;
  {$EXTERNALSYM D3DX_SKIP_DDS_MIP_LEVELS_MASK}
  D3DX_SKIP_DDS_MIP_LEVELS_SHIFT  = 26;
  {$EXTERNALSYM D3DX_SKIP_DDS_MIP_LEVELS_SHIFT}

function D3DX_SKIP_DDS_MIP_LEVELS(levels, filter: DWORD): DWORD;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DX_SKIP_DDS_MIP_LEVELS}



//----------------------------------------------------------------------------
// D3DX_NORMALMAP flags:
// ---------------------
// These flags are used to control how D3DXComputeNormalMap generates normal
// maps.  Any number of these flags may be OR'd together in any combination.
//
//  D3DX_NORMALMAP_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX_NORMALMAP_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX_NORMALMAP_MIRROR
//      Same as specifying D3DX_NORMALMAP_MIRROR_U | D3DX_NORMALMAP_MIRROR_V
//  D3DX_NORMALMAP_INVERTSIGN
//      Inverts the direction of each normal
//  D3DX_NORMALMAP_COMPUTE_OCCLUSION
//      Compute the per pixel Occlusion term and encodes it into the alpha.
//      An Alpha of 1 means that the pixel is not obscured in anyway, and
//      an alpha of 0 would mean that the pixel is completly obscured.
//
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------

const
  D3DX_NORMALMAP_MIRROR_U     = (1 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_MIRROR_U}
  D3DX_NORMALMAP_MIRROR_V     = (2 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_MIRROR_V}
  D3DX_NORMALMAP_MIRROR       = (3 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_MIRROR}
  D3DX_NORMALMAP_INVERTSIGN   = (8 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_INVERTSIGN}
  D3DX_NORMALMAP_COMPUTE_OCCLUSION = (16 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_COMPUTE_OCCLUSION}


//----------------------------------------------------------------------------
// D3DX_CHANNEL flags:
// -------------------
// These flags are used by functions which operate on or more channels
// in a texture.
//
// D3DX_CHANNEL_RED
//     Indicates the red channel should be used
// D3DX_CHANNEL_BLUE
//     Indicates the blue channel should be used
// D3DX_CHANNEL_GREEN
//     Indicates the green channel should be used
// D3DX_CHANNEL_ALPHA
//     Indicates the alpha channel should be used
// D3DX_CHANNEL_LUMINANCE
//     Indicates the luminaces of the red green and blue channels should be
//     used.
//
//----------------------------------------------------------------------------

const
  D3DX_CHANNEL_RED            = (1 shl 0);
  {$EXTERNALSYM D3DX_CHANNEL_RED}
  D3DX_CHANNEL_BLUE           = (1 shl 1);
  {$EXTERNALSYM D3DX_CHANNEL_BLUE}
  D3DX_CHANNEL_GREEN          = (1 shl 2);
  {$EXTERNALSYM D3DX_CHANNEL_GREEN}
  D3DX_CHANNEL_ALPHA          = (1 shl 3);
  {$EXTERNALSYM D3DX_CHANNEL_ALPHA}
  D3DX_CHANNEL_LUMINANCE      = (1 shl 4);
  {$EXTERNALSYM D3DX_CHANNEL_LUMINANCE}


//----------------------------------------------------------------------------
// D3DXIMAGE_FILEFORMAT:
// ---------------------
// This enum is used to describe supported image file formats.
//
//----------------------------------------------------------------------------

type
  PD3DXImageFileFormat = ^TD3DXImageFileFormat;
  _D3DXIMAGE_FILEFORMAT = (
    D3DXIFF_BMP        {= 0},
    D3DXIFF_JPG        {= 1},
    D3DXIFF_TGA        {= 2},
    D3DXIFF_PNG        {= 3},
    D3DXIFF_DDS        {= 4},
    D3DXIFF_PPM        {= 5},
    D3DXIFF_DIB        {= 6},
    D3DXIFF_HDR        {= 7},       //high dynamic range formats
    D3DXIFF_PFM        {= 8}        //
  );
  {$EXTERNALSYM _D3DXIMAGE_FILEFORMAT}
  D3DXIMAGE_FILEFORMAT = _D3DXIMAGE_FILEFORMAT;
  {$EXTERNALSYM D3DXIMAGE_FILEFORMAT}
  TD3DXImageFileFormat = _D3DXIMAGE_FILEFORMAT;


//----------------------------------------------------------------------------
// LPD3DXFILL2D and LPD3DXFILL3D:
// ------------------------------
// Function types used by the texture fill functions.
//
// Parameters:
//  pOut
//      Pointer to a vector which the function uses to return its result.
//      X,Y,Z,W will be mapped to R,G,B,A respectivly.
//  pTexCoord
//      Pointer to a vector containing the coordinates of the texel currently
//      being evaluated.  Textures and VolumeTexture texcoord components
//      range from 0 to 1. CubeTexture texcoord component range from -1 to 1.
//  pTexelSize
//      Pointer to a vector containing the dimensions of the current texel.
//  pData
//      Pointer to user data.
//
//----------------------------------------------------------------------------

type
  //typedef VOID (WINAPI *LPD3DXFILL2D)(D3DXVECTOR4 *pOut,
  //    CONST D3DXVECTOR2 *pTexCoord, CONST D3DXVECTOR2 *pTexelSize, LPVOID pData);
  TD3DXFill2D = procedure (out pOut: TD3DXVector4; const pTexCoord, pTexelSize: TD3DXVector2; var pData); stdcall;
  {$NODEFINE TD3DXFill2D}
  {$HPPEMIT 'typedef LPD3DXFILL2D TD3DXFill2D;'}

  //typedef VOID (WINAPI *LPD3DXFILL3D)(D3DXVECTOR4 *pOut,
  //    CONST D3DXVECTOR3 *pTexCoord, CONST D3DXVECTOR3 *pTexelSize, LPVOID pData);
  TD3DXFill3D = procedure (out pOut: TD3DXVector4; const pTexCoord, pTexelSize: TD3DXVector3; var pData); stdcall;
  {$NODEFINE TD3DXFill3D}
  {$HPPEMIT 'typedef LPD3DXFILL3D TD3DXFill3D;'}



//----------------------------------------------------------------------------
// D3DXIMAGE_INFO:
// ---------------
// This structure is used to return a rough description of what the
// the original contents of an image file looked like.
//
//  Width
//      Width of original image in pixels
//  Height
//      Height of original image in pixels
//  Depth
//      Depth of original image in pixels
//  MipLevels
//      Number of mip levels in original image
//  Format
//      D3D format which most closely describes the data in original image
//  ResourceType
//      D3DRESOURCETYPE representing the type of texture stored in the file.
//      D3DRTYPE_TEXTURE, D3DRTYPE_VOLUMETEXTURE, or D3DRTYPE_CUBETEXTURE.
//  ImageFileFormat
//      D3DXIMAGE_FILEFORMAT representing the format of the image file.
//
//----------------------------------------------------------------------------

type
  PD3DXImageInfo = ^TD3DXImageInfo;
  _D3DXIMAGE_INFO = record
    Width:      LongWord;
    Height:     LongWord;
    Depth:      LongWord;
    MipLevels:  LongWord;
    Format:     TD3DFormat;
    ResourceType: TD3DResourceType;
    ImageFileFormat: TD3DXImageFileFormat;
  end;
  {$EXTERNALSYM _D3DXIMAGE_INFO}
  D3DXIMAGE_INFO = _D3DXIMAGE_INFO;
  {$EXTERNALSYM D3DXIMAGE_INFO}
  TD3DXImageInfo = _D3DXIMAGE_INFO;


//////////////////////////////////////////////////////////////////////////////
// Image File APIs ///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// GetImageInfoFromFile/Resource:
// ------------------------------
// Fills in a D3DXIMAGE_INFO struct with information about an image file.
//
// Parameters:
//  pSrcFile
//      File name of the source image.
//  pSrcModule
//      Module where resource is located, or NULL for module associated
//      with image the os used to create the current process.
//  pSrcResource
//      Resource name
//  pSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pSrcInfo
//      Pointer to a D3DXIMAGE_INFO structure to be filled in with the
//      description of the data in the source image file.
//
//----------------------------------------------------------------------------

function D3DXGetImageInfoFromFileA(
  pSrcFile: PAnsiChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXGetImageInfoFromFileA';
{$EXTERNALSYM D3DXGetImageInfoFromFileA}

function D3DXGetImageInfoFromFileW(
  pSrcFile: PWideChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXGetImageInfoFromFileW';
{$EXTERNALSYM D3DXGetImageInfoFromFileW}

function D3DXGetImageInfoFromFile(
  pSrcFile: PChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXGetImageInfoFromFileA';
{$EXTERNALSYM D3DXGetImageInfoFromFile}


function D3DXGetImageInfoFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXGetImageInfoFromResourceA';
{$EXTERNALSYM D3DXGetImageInfoFromResourceA}

function D3DXGetImageInfoFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXGetImageInfoFromResourceW';
{$EXTERNALSYM D3DXGetImageInfoFromResourceW}

function D3DXGetImageInfoFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXGetImageInfoFromResourceA';
{$EXTERNALSYM D3DXGetImageInfoFromResource}


function D3DXGetImageInfoFromFileInMemory(
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXGetImageInfoFromFileInMemory}


//////////////////////////////////////////////////////////////////////////////
// Load/Save Surface APIs ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DXLoadSurfaceFromFile/Resource:
// ---------------------------------
// Load surface from a file or resource
//
// Parameters:
//  pDestSurface
//      Destination surface, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestRect
//      Destination rectangle, or NULL for entire surface
//  pSrcFile
//      File name of the source image.
//  pSrcModule
//      Module where resource is located, or NULL for module associated
//      with image the os used to create the current process.
//  pSrcResource
//      Resource name
//  pSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pSrcRect
//      Source rectangle, or NULL for entire image
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//  pSrcInfo
//      Pointer to a D3DXIMAGE_INFO structure to be filled in with the
//      description of the data in the source image file, or NULL.
//
//----------------------------------------------------------------------------
function D3DXLoadSurfaceFromFileA(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcFile: PAnsiChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXLoadSurfaceFromFileA';
{$EXTERNALSYM D3DXLoadSurfaceFromFileA}

function D3DXLoadSurfaceFromFileW(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcFile: PWideChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXLoadSurfaceFromFileW';
{$EXTERNALSYM D3DXLoadSurfaceFromFileW}

function D3DXLoadSurfaceFromFile(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcFile: PChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXLoadSurfaceFromFileA';
{$EXTERNALSYM D3DXLoadSurfaceFromFile}



function D3DXLoadSurfaceFromResourceA(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXLoadSurfaceFromResourceA';
{$EXTERNALSYM D3DXLoadSurfaceFromResourceA}

function D3DXLoadSurfaceFromResourceW(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXLoadSurfaceFromResourceW';
{$EXTERNALSYM D3DXLoadSurfaceFromResourceW}

function D3DXLoadSurfaceFromResource(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  hSrcModule: HModule;
  pSrcResource: PChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL name 'D3DXLoadSurfaceFromResourceA';
{$EXTERNALSYM D3DXLoadSurfaceFromResource}



function D3DXLoadSurfaceFromFileInMemory(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXLoadSurfaceFromFileInMemory}



//----------------------------------------------------------------------------
// D3DXLoadSurfaceFromSurface:
// ---------------------------
// Load surface from another surface (with color conversion)
//
// Parameters:
//  pDestSurface
//      Destination surface, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestRect
//      Destination rectangle, or NULL for entire surface
//  pSrcSurface
//      Source surface
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcRect
//      Source rectangle, or NULL for entire surface
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//
//----------------------------------------------------------------------------

function D3DXCreateTextureFromFileInMemoryEx(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9DLL;
{$EXTERNALSYM D3DXCreateTextureFromFileInMemoryEx}


function D3DXCreateTextureFromFileA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9DLL name 'D3DXCreateTextureFromFileA';
{$EXTERNALSYM D3DXCreateTextureFromFileA}

function D3DXCreateTextureFromFileW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9DLL name 'D3DXCreateTextureFromFileW';
{$EXTERNALSYM D3DXCreateTextureFromFileW}

function D3DXCreateTextureFromFile(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9DLL name 'D3DXCreateTextureFromFileA';
{$EXTERNALSYM D3DXCreateTextureFromFile}


(*$HPPEMIT '}  /* namespace D3dx9 */' *)


implementation

function D3DXToRadian(Degree: Single): Single;
begin
  Result:= Degree * (D3DX_PI / 180.0);
end;

function D3DXToDegree(Radian: Single): Single;
begin
  Result:= Radian * (180.0 / D3DX_PI);
end;



//===========================================================================
//
// 16 bit floating point numbers
//
//===========================================================================

function D3DXFloat16(value: Single): TD3DXFloat16;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result, @value, 1);
end;

function D3DXFloat16Equal(const v1, v2: TD3DXFloat16): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (v1.value = v2.value);
end;

function D3DXFloat16ToFloat(value: TD3DXFloat16): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result, @value, 1);
end;



//===========================================================================
//
// Vectors
//
//===========================================================================

//--------------------------
// 2D Vector
//--------------------------

function D3DXVector2(_x, _y: Single): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result.x:= _x; Result.y:= _y;
end;

function D3DXVector2Equal(const v1, v2: TD3DXVector2): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y);
end;


//--------------------------
// 2D Vector (16 bit)
//--------------------------
function D3DXVector2_16F(_x, _y: TD3DXFloat16): TD3DXVector2_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x;
    y:= _y;
  end;
end;

function D3DXVector2_16fEqual(const v1, v2: TD3DXVector2_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (DWORD(v1) = DWORD(v2));
end;

function D3DXVector2_16fFromVector2(const v: TD3DXVector2): TD3DXVector2_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 2);
end;

function D3DXVector2FromVector2_16f(const v: TD3DXVector2_16f): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 2);
end;


//--------------------------
// 3D Vector
//--------------------------

function D3DXVector3(_x, _y, _z: Single): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:=_z;
  end;
end;

function D3DXVector3Equal(const v1, v2: TD3DXVector3): Boolean;
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y) and (v1.z = v2.z);
end;


//--------------------------
// 3D Vector (16 bit)
//--------------------------

function D3DXVector3_16F(_x, _y, _z: TD3DXFloat16): TD3DXVector3_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z;
  end;
end;

function D3DXVector3_16fEqual(const v1, v2: TD3DXVector3_16F): Boolean;
begin
  Result:= (PDWORD(@v1.x)^ = PDWORD(@v2.x)^) and
           (Word  (v1.z)   = Word (v2.z));
end;

function D3DXVector3_16fFromVector3(const v: TD3DXVector3): TD3DXVector3_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 3);
end;

function D3DXVector3FromVector3_16f(const v: TD3DXVector3_16f): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 3);
end;


//--------------------------
// 4D Vector
//--------------------------

function D3DXVector4(_x, _y, _z, _w: Single): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXVector4(xyz: TD3DXVector3; _w: Single): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= xyz.x; y:= xyz.y; z:= xyz.z; w:= _w;
  end;
end;

function D3DXVector4Equal(const v1, v2: TD3DXVector4): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y) and
    (v1.z = v2.z) and (v1.w = v2.w);
end;


//--------------------------
// 4D Vector (16 bit)
//--------------------------
function D3DXVector4_16F(_x, _y, _z, _w: TD3DXFloat16): TD3DXVector4_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXVector4_16F(xyz: TD3DXVector3_16f; _w: TD3DXFloat16): TD3DXVector4_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= xyz.x; y:= xyz.y; z:= xyz.z; w:= _w;
  end;
end;

function D3DXVector4_16fEqual(const v1, v2: TD3DXVector4_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (PDWORD(@v1.x)^ = PDWORD(@v2.x)^) and
           (PDWORD(@v1.z)^ = PDWORD(@v2.z)^);
end;

function D3DXVector4_16fFromVector4(const v: TD3DXVector4): TD3DXVector4_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 4);
end;

function D3DXVector4FromVector4_16f(const v: TD3DXVector4_16f): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 4);
end;


//--------------------------
// 4D Matrix
//--------------------------
function D3DXMatrix(
  _m00, _m01, _m02, _m03,
  _m10, _m11, _m12, _m13,
  _m20, _m21, _m22, _m23,
  _m30, _m31, _m32, _m33: Single): TD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    m[0,0]:= _m00; m[0,1]:= _m01; m[0,2]:= _m02; m[0,3]:= _m03;
    m[1,0]:= _m10; m[1,1]:= _m11; m[1,2]:= _m12; m[1,3]:= _m13;
    m[2,0]:= _m20; m[2,1]:= _m21; m[2,2]:= _m22; m[2,3]:= _m23;
    m[3,0]:= _m30; m[3,1]:= _m31; m[3,2]:= _m32; m[3,3]:= _m33;
  end;
end;

function D3DXMatrixAdd(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;
var
  pOut, p1, p2: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p1:= @m1._11; p2:= @m2._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p1^+p2^;
    Inc(pOut); Inc(p1); Inc(p2);
  end;
  Result:= @mOut;
end;

function D3DXMatrixSubtract(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;
var
  pOut, p1, p2: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p1:= @m1._11; p2:= @m2._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p1^-p2^;
    Inc(pOut); Inc(p1); Inc(p2);
  end;
  Result:= @mOut;
end;

function D3DXMatrixMul(out mOut: TD3DXMatrix; const m: TD3DXMatrix; MulBy: Single): PD3DXMatrix;
var
  pOut, p: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p:= @m._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p^* MulBy;
    Inc(pOut); Inc(p);
  end;
  Result:= @mOut;
end;

function D3DXMatrixEqual(const m1, m2: TD3DXMatrix): Boolean;
begin
  Result:= CompareMem(@m1, @m2, SizeOf(TD3DXMatrix));
end;

//--------------------------
// Quaternion
//--------------------------
function D3DXQuaternion(_x, _y, _z, _w: Single): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXQuaternionAdd(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= q1.x+q2.x; y:= q1.y+q2.y; z:= q1.z+q2.z; w:= q1.w+q2.w;
  end;
end;

function D3DXQuaternionSubtract(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= q1.x-q2.x; y:= q1.y-q2.y; z:= q1.z-q2.z; w:= q1.w-q2.w;
  end;
end;

function D3DXQuaternionEqual(const q1, q2: TD3DXQuaternion): Boolean;
begin
  Result:= (q1.x = q2.x) and (q1.y = q2.y) and
    (q1.z = q2.z) and (q1.w = q2.w);
end;

function D3DXQuaternionScale(out qOut: TD3DXQuaternion; const q: TD3DXQuaternion;
  s: Single): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= q.x*s; y:= q.y*s; z:= q.z*s; w:= q.w*s;
  end;
  Result:= @qOut;
end;


//--------------------------
// Plane
//--------------------------

function D3DXPlane(_a, _b, _c, _d: Single): TD3DXPlane;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    a:= _a; b:= _b; c:= _c; d:= _d;
  end;
end;

function D3DXPlaneEqual(const p1, p2: TD3DXPlane): Boolean;
begin
  Result:=
    (p1.a = p2.a) and (p1.b = p2.b) and
    (p1.c = p2.c) and (p1.d = p2.d);
end;


//--------------------------
// Color
//--------------------------

function D3DXColor(_r, _g, _b, _a: Single): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    r:= _r; g:= _g; b:= _b; a:= _a;
  end;
end;

function D3DXColorToDWord(c: TD3DXColor): DWord;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
var
  dwR, dwG, dwB, dwA: DWORD;
begin
  if c.r > 1.0 then dwR:= 255 else if c.r < 0 then dwR:= 0 else dwR:= DWORD(Trunc(c.r * 255.0 + 0.5));
  if c.g > 1.0 then dwG:= 255 else if c.g < 0 then dwG:= 0 else dwG:= DWORD(Trunc(c.g * 255.0 + 0.5));
  if c.b > 1.0 then dwB:= 255 else if c.b < 0 then dwB:= 0 else dwB:= DWORD(Trunc(c.b * 255.0 + 0.5));
  if c.a > 1.0 then dwA:= 255 else if c.a < 0 then dwA:= 0 else dwA:= DWORD(Trunc(c.a * 255.0 + 0.5));

  Result:= (dwA shl 24) or (dwR shl 16) or (dwG shl 8) or dwB;
end;

function D3DXColorFromDWord(c: DWord): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
var
  f: Single; // = 1/255; //Clootie: Changed from CONST due to Delphi9 inline bug
begin
  f:= (1/255);
  with Result do
  begin
    r:= f * Byte(c shr 16);
    g:= f * Byte(c shr  8);
    b:= f * Byte(c{shr 0});
    a:= f * Byte(c shr 24);
  end;
end;

function D3DXColorEqual(const c1, c2: TD3DXColor): Boolean;
begin
  Result:= (c1.r = c2.r) and (c1.g = c2.g) and (c1.b = c2.b) and (c1.a = c2.a);
end;


//===========================================================================
//
// D3DX math functions:
//
// NOTE:
//  * All these functions can take the same object as in and out parameters.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//===========================================================================

//--------------------------
// 2D Vector
//--------------------------

// "inline"
function D3DXVec2Length(const v: TD3DXVector2): Single;
begin
  with v do Result:= Sqrt(x*x + y*y);
end;

function D3DXVec2LengthSq(const v: TD3DXVector2): Single;
begin
  with v do Result:= x*x + y*y;
end;

function D3DXVec2Dot(const v1, v2: TD3DXVector2): Single;
begin
  Result:= v1.x*v2.x + v1.y*v2.y;
end;

// Z component of ((x1,y1,0) cross (x2,y2,0))
function D3DXVec2CCW(const v1, v2: TD3DXVector2): Single;
begin
  Result:= v1.x*v2.y - v1.y*v2.x;
end;

function D3DXVec2Add(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result.x:= v1.x + v2.x;
  Result.y:= v1.y + v2.y;
end;

function D3DXVec2Subtract(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result.x:= v1.x - v2.x;
  Result.y:= v1.y - v2.y;
end;

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec2Minimize(out vOut: TD3DXVector2; const v1, v2: TD3DXVEctor2): PD3DXVector2;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec2Maximize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  Result:= @vOut;
end;

function D3DXVec2Scale(out vOut: TD3DXVector2; const v: TD3DXVector2; s: Single): PD3DXVector2;
begin
  vOut.x:= v.x*s; vOut.y:= v.y*s;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec2Lerp(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2; s: Single): PD3DXVector2;
begin
  vOut.x:= v1.x + s * (v2.x-v1.x);
  vOut.y:= v1.y + s * (v2.y-v1.y);
  Result:= @vOut;
end;


//--------------------------
// 3D Vector
//--------------------------
function D3DXVec3Length(const v: TD3DXVector3): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z);
end;

function D3DXVec3LengthSq(const v: TD3DXVector3): Single;
begin
  with v do Result:= x*x + y*y + z*z;
end;

function D3DXVec3Dot(const v1, v2: TD3DXVector3): Single;
begin
  Result:= v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
end;

function D3DXVec3Cross(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  vOut.x:= v1.y * v2.z - v1.z * v2.y;
  vOut.y:= v1.z * v2.x - v1.x * v2.z;
  vOut.z:= v1.x * v2.y - v1.y * v2.x;
  Result:= @vOut;
end;

function D3DXVec3Add(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v1.x + v2.x;
    y:= v1.y + v2.y;
    z:= v1.z + v2.z;
  end;
  Result:= @vOut;
end;

function D3DXVec3Subtract(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
  end;
  Result:= @vOut;
end;

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec3Minimize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z < v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec3Maximize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z > v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  Result:= @vOut;
end;

function D3DXVec3Scale(out vOut: TD3DXVector3; const v: TD3DXVector3; s: Single): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v.x * s; y:= v.y * s; z:= v.z * s;
  end;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec3Lerp(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3; s: Single): PD3DXVector3;
begin
  vOut.x:= v1.x + s * (v2.x-v1.x);
  vOut.y:= v1.y + s * (v2.y-v1.y);
  vOut.z:= v1.z + s * (v2.z-v1.z);
  Result:= @vOut;
end;


//--------------------------
// 4D Vector
//--------------------------

function D3DXVec4Length(const v: TD3DXVector4): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z + w*w);
end;

function D3DXVec4LengthSq(const v: TD3DXVector4): Single;
begin
  with v do Result:= x*x + y*y + z*z + w*w
end;

function D3DXVec4Dot(const v1, v2: TD3DXVector4): Single;
begin
  Result:= v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w;
end;

function D3DXVec4Add(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x + v2.x;
    y:= v1.y + v2.y;
    z:= v1.z + v2.z;
    w:= v1.w + v2.w;
  end;
  Result:= @vOut;
end;

function D3DXVec4Subtract(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
    w:= v1.w - v2.w;
  end;
  Result:= @vOut;
end;


// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec4Minimize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z < v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  if v1.w < v2.w then vOut.w:= v1.w else vOut.w:= v2.w;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec4Maximize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z > v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  if v1.w > v2.w then vOut.w:= v1.w else vOut.w:= v2.w;
  Result:= @vOut;
end;

function D3DXVec4Scale(out vOut: TD3DXVector4; const v: TD3DXVector4; s: Single): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v.x * s; y:= v.y * s; z:= v.z * s; w:= v.w * s;
  end;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec4Lerp(out vOut: TD3DXVector4;
  const v1, v2: TD3DXVector4; s: Single): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x + s * (v2.x - v1.x);
    y:= v1.y + s * (v2.y - v1.y);
    z:= v1.z + s * (v2.z - v1.z);
    w:= v1.w + s * (v2.w - v1.w);
  end;
  Result:= @vOut;
end;

//--------------------------
// 4D Matrix
//--------------------------

// inline
function D3DXMatrixIdentity(out mOut: TD3DXMatrix): PD3DXMatrix;
begin
  FillChar(mOut, SizeOf(mOut), 0);
  mOut._11:= 1; mOut._22:= 1; mOut._33:= 1; mOut._44:= 1;
  Result:= @mOut;
end;

function D3DXMatrixIsIdentity(const m: TD3DXMatrix): BOOL;
begin
  with m do Result:=
    (_11 = 1) and (_12 = 0) and (_13 = 0) and (_14 = 0) and
    (_21 = 0) and (_22 = 1) and (_23 = 0) and (_24 = 0) and
    (_31 = 0) and (_32 = 0) and (_33 = 1) and (_34 = 0) and
    (_41 = 0) and (_42 = 0) and (_43 = 0) and (_44 = 1);
end;


//--------------------------
// Quaternion
//--------------------------

// inline

function D3DXQuaternionLength(const q: TD3DXQuaternion): Single;
begin
  with q do Result:= Sqrt(x*x + y*y + z*z + w*w);
end;

// Length squared, or "norm"
function D3DXQuaternionLengthSq(const q: TD3DXQuaternion): Single;
begin
  with q do Result:= x*x + y*y + z*z + w*w;
end;

function D3DXQuaternionDot(const q1, q2: TD3DXQuaternion): Single;
begin
  Result:= q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
end;

function D3DXQuaternionIdentity(out qOut: TD3DXQuaternion): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= 0; y:= 0; z:= 0; w:= 1.0;
  end;
  Result:= @qOut;
end;

function D3DXQuaternionIsIdentity(const q: TD3DXQuaternion): BOOL;
begin
  with q do Result:= (x = 0) and (y = 0) and (z = 0) and (w = 1);
end;

// (-x, -y, -z, w)
function D3DXQuaternionConjugate(out qOut: TD3DXQuaternion;
  const q: TD3DXQuaternion): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= -q.x; y:= -q.y; z:= -q.z; w:= q.w;
  end;
  Result:= @qOut;
end;


//--------------------------
// Plane
//--------------------------

// ax + by + cz + dw
function D3DXPlaneDot(const p: TD3DXPlane; const v: TD3DXVector4): Single;
begin
  with p,v do Result:= a*x + b*y + c*z + d*w;
end;

// ax + by + cz + d
function D3DXPlaneDotCoord(const p: TD3DXPlane; const v: TD3DXVector3): Single;
begin
  with p,v do Result:= a*x + b*y + c*z + d;
end;

// ax + by + cz
function D3DXPlaneDotNormal(const p: TD3DXPlane; const v: TD3DXVector3): Single;
begin
  with p,v do Result:= a*x + b*y + c*z;
end;

function D3DXPlaneScale(out pOut: TD3DXPlane; const pP: TD3DXPlane; s: Single): PD3DXPlane;
begin
  pOut.a := pP.a * s;
  pOut.b := pP.b * s;
  pOut.c := pP.c * s;
  pOut.d := pP.d * s;
  Result := @pOut;
end;


//--------------------------
// Color
//--------------------------

// inline

function D3DXColorNegative(out cOut: TD3DXColor; const c: TD3DXColor): PD3DXColor;
begin
 with cOut do
 begin
   r:= 1.0 - c.r; g:= 1.0 - c.g; b:= 1.0 - c.b;
   a:= c.a;
 end;
 Result:= @cOut;
end;

function D3DXColorAdd(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r + c2.r; g:= c1.g + c2.g; b:= c1.b + c2.b;
    a:= c1.a + c2.a;
  end;
  Result:= @cOut;
end;

function D3DXColorSubtract(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r - c2.r; g:= c1.g - c2.g; b:= c1.b - c2.b;
    a:= c1.a - c2.a;
  end;
  Result:= @cOut;
end;

function D3DXColorScale(out cOut: TD3DXColor; const c: TD3DXColor; s: Single): PD3DXColor;
begin
  with cOut do
  begin
    r:= c.r * s; g:= c.g * s;
    b:= c.b * s; a:= c.a * s;
  end;
  Result:= @cOut;
end;

// (r1*r2, g1*g2, b1*b2, a1*a2)
function D3DXColorModulate(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r * c2.r; g:= c1.g * c2.g;
    b:= c1.b * c2.b; a:= c1.a * c2.a;
  end;
  Result:= @cOut;
end;

// Linear interpolation of r,g,b, and a. C1 + s(C2-C1)
function D3DXColorLerp(out cOut: TD3DXColor; const c1,c2: TD3DXColor; s: Single): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r + s * (c2.r - c1.r);
    g:= c1.g + s * (c2.g - c1.g);
    b:= c1.b + s * (c2.b - c1.b);
    a:= c1.a + s * (c2.a - c1.a);
  end;
  Result:= @cOut;
end;




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9tex.h
//  Content:    D3DX texturing APIs
//
//////////////////////////////////////////////////////////////////////////////

// #define D3DX_SKIP_DDS_MIP_LEVELS(levels, filter) ((((levels) & D3DX_SKIP_DDS_MIP_LEVELS_MASK) << D3DX_SKIP_DDS_MIP_LEVELS_SHIFT) | ((filter) == D3DX_DEFAULT ? D3DX_FILTER_BOX : (filter)))
function D3DX_SKIP_DDS_MIP_LEVELS(levels, filter: DWORD): DWORD;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  if (filter = D3DX_DEFAULT) then filter :=  D3DX_FILTER_BOX;
  Result := ((levels and D3DX_SKIP_DDS_MIP_LEVELS_MASK) shl D3DX_SKIP_DDS_MIP_LEVELS_SHIFT) or filter;
end;


function D3DXTX_VERSION(_Major, _Minor: Byte): DWORD;
begin
  Result := (Ord('T') shl 24) or (Ord('X') shl 16) or (_Major shl 8) or (_Minor);
end;

(*==========================================================================;
 *  File:       d3d9types.h
 *  Content:    Direct3D capabilities include file
 ***************************************************************************)

// #define D3DCOLOR_ARGB(a,r,g,b) \
//     ((D3DCOLOR)((((a)&0xff)<<24)|(((r)&0xff)<<16)|(((g)&0xff)<<8)|((b)&0xff)))
function D3DCOLOR_ARGB(a,r,g,b: DWord): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DCOLOR_RGBA(r,g,b,a) D3DCOLOR_ARGB(a,r,g,b)
function D3DCOLOR_RGBA(r,g,b,a: DWord): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DCOLOR_XRGB(r,g,b)   D3DCOLOR_ARGB(0xff,r,g,b)
function D3DCOLOR_XRGB(r,g,b: DWord): TD3DColor;
begin
  Result := DWORD($FF shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DCOLOR_XYUV(y,u,v)   D3DCOLOR_ARGB(0xff,y,u,v)
function D3DCOLOR_XYUV(y,u,v: DWord): TD3DColor;
begin
  Result := DWORD($FF shl 24) or (y shl 16) or (u shl 8) or v;
end;

// #define D3DCOLOR_AYUV(a,y,u,v) D3DCOLOR_ARGB(a,y,u,v)
function D3DCOLOR_AYUV(a,y,u,v: DWord): TD3DColor;
begin
  Result := (a shl 24) or (y shl 16) or (u shl 8) or v;
end;

// #define D3DCOLOR_COLORVALUE(r,g,b,a) \
//     D3DCOLOR_RGBA((DWORD)((r)*255.f),(DWORD)((g)*255.f),(DWORD)((b)*255.f),(DWORD)((a)*255.f))
function D3DCOLOR_COLORVALUE(r,g,b,a: Single): TD3DColor;
begin
  Result := (round(a * 255) shl 24) or
    (round(r * 255) shl 16) or
    (round(g * 255) shl 8) or
    (round(b * 255));
end;

// #define D3DTS_WORLDMATRIX(index) (D3DTRANSFORMSTATETYPE)(index + 256)
function D3DTS_WORLDMATRIX(index: Byte): TD3DTransformStateType;
begin
  Result:= TD3DTransformStateType(index + 256);
end;

//#define D3DFVF_TEXCOORDSIZE3(CoordIndex) (D3DFVF_TEXTUREFORMAT3 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE3(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT3 shl (CoordIndex * 2 + 16)
end;

//#define D3DFVF_TEXCOORDSIZE2(CoordIndex) (D3DFVF_TEXTUREFORMAT2)
function D3DFVF_TEXCOORDSIZE2(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT2;
end;

//#define D3DFVF_TEXCOORDSIZE4(CoordIndex) (D3DFVF_TEXTUREFORMAT4 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE4(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT4 shl (CoordIndex * 2 + 16)
end;

//#define D3DFVF_TEXCOORDSIZE1(CoordIndex) (D3DFVF_TEXTUREFORMAT1 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE1(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT1 shl (CoordIndex * 2 + 16)
end;

//    #define MAKEFOURCC(ch0, ch1, ch2, ch3)                              \
//                ((DWORD)(BYTE)(ch0) | ((DWORD)(BYTE)(ch1) << 8) |       \
//                ((DWORD)(BYTE)(ch2) << 16) | ((DWORD)(BYTE)(ch3) << 24 ))
function MAKEFOURCC(ch0, ch1, ch2, ch3: Char): DWord;
begin
  Result:= Byte(ch0) or (Byte(ch1) shl 8) or (Byte(ch2) shl 16) or (Byte(ch3) shl 24 );
end;

(*==========================================================================;
 *  File:   d3d9.h
 *  Content:    Direct3D include file
 ****************************************************************************)

//#define MAKE_D3DHRESULT( code )  MAKE_HRESULT( 1, _FACD3D, code )
function MAKE_D3DHRESULT(Code: DWord): DWord;
begin
  Result:= DWord((1 shl 31) or (_FACD3D shl 16)) or Code;
end;

//#define MAKE_D3DSTATUS( code )  MAKE_HRESULT( 0, _FACD3D, code )
function MAKE_D3DSTATUS(Code: DWord): DWord;
begin
  Result:= DWord((0 shl 31) or (_FACD3D shl 16)) or Code;
end;

{$IFDEF DIRECT3D9_DYNAMIC_LINK}
var
  Direct3D9Lib: THandle = 0;

function Direct3D9Loaded: Boolean;
begin
  Result:= Direct3D9Lib <> 0;
end;

function UnLoadDirect3D9: Boolean;
begin
  Result:= True;
  if Direct3D9Loaded then
  begin
    Result:= FreeLibrary(Direct3D9Lib);
    _Direct3DCreate9:= nil;
    Direct3D9Lib:= 0;
  end;
end;

function LoadDirect3D9: Boolean;
const
  ProcName = 'Direct3DCreate9';
  ProcNameEx = 'Direct3DCreate9Ex';
begin
  Result:= Direct3D9Loaded;
  if (not Result) then
  begin
    Direct3D9Lib:= LoadLibrary(Direct3D9dll);
    if Direct3D9Loaded then
    begin
      _Direct3DCreate9:= GetProcAddress(Direct3D9Lib, ProcName);
      Result:= Assigned(_Direct3DCreate9);
      if not Result then UnLoadDirect3D9;
      {$IFDEF DIRECT3D_VERSION_9_VISTA}
      
      Direct3DCreate9Ex:= GetProcAddress(Direct3D9Lib, ProcNameEx);
      {$ENDIF}
    end;
  end;
end;
{$ELSE}
function Direct3D9Loaded: Boolean;
begin // Stub function for static linking
  Result:= True;
end;

function UnLoadDirect3D9: Boolean;
begin // Stub function for static linking
  Result:= True; // should emulate "normal" behaviour
end;

function LoadDirect3D9: Boolean;
begin // Stub function for static linking
  Result:= True;
end;

function _Direct3DCreate9(SDKVersion: LongWord): Pointer; external Direct3D9dll name 'Direct3DCreate9';
{$IFDEF DIRECT3D_VERSION_9_VISTA}
function Direct3DCreate9Ex(SDKVersion: LongWord; out d3d9ex: IDirect3D9Ex): HRESULT; stdcall; external Direct3D9dll;
{$ENDIF}
{$ENDIF}

function Direct3DCreate9(SDKVersion: LongWord): IDirect3D9; stdcall;
begin
{$IFDEF DIRECT3D9_DYNAMIC_LINK}
{$IFDEF DIRECT3D9_DYNAMIC_LINK_EXPLICIT}
  LoadDirect3D9;

{$ENDIF}
{$ENDIF}
  Result:= IDirect3D9(_Direct3DCreate9(SDKVersion));
  if Assigned(Result) then Result._Release; // Delphi autoincrement reference count
end;

{$IFDEF DIRECT3D9_DYNAMIC_LINK}
initialization
{$IFNDEF DIRECT3D9_DYNAMIC_LINK_EXPLICIT}
  LoadDirect3D9;
{$ENDIF}
finalization
  UnLoadDirect3D9;
{$ENDIF}
end.

