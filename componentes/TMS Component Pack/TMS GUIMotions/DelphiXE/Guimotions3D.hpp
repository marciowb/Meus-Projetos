// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GUIMotions3D.pas' rev: 22.00

#ifndef Guimotions3dHPP
#define Guimotions3dHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
#include "d3d9.h"
#include "d3d9types.h"
#include "d3d9caps.h"
#include "d3dx9.h"
namespace D3dx9
{
#include "dxsdkver.h"
DECLARE_DINTERFACE_TYPE(IDirect3D9);
DECLARE_DINTERFACE_TYPE(IDirect3DDevice9);
DECLARE_DINTERFACE_TYPE(IDirect3DStateBlock9);
DECLARE_DINTERFACE_TYPE(IDirect3DSwapChain9);
DECLARE_DINTERFACE_TYPE(IDirect3DResource9);
DECLARE_DINTERFACE_TYPE(IDirect3DVertexDeclaration9);
DECLARE_DINTERFACE_TYPE(IDirect3DVertexShader9);
DECLARE_DINTERFACE_TYPE(IDirect3DPixelShader9);
DECLARE_DINTERFACE_TYPE(IDirect3DBaseTexture9);
DECLARE_DINTERFACE_TYPE(IDirect3DTexture9);
DECLARE_DINTERFACE_TYPE(IDirect3DVolumeTexture9);
DECLARE_DINTERFACE_TYPE(IDirect3DCubeTexture9);
DECLARE_DINTERFACE_TYPE(IDirect3DVertexBuffer9);
DECLARE_DINTERFACE_TYPE(IDirect3DIndexBuffer9);
DECLARE_DINTERFACE_TYPE(IDirect3DSurface9);
DECLARE_DINTERFACE_TYPE(IDirect3DVolume9);
DECLARE_DINTERFACE_TYPE(IDirect3DQuery9);
typedef D3DXFLOAT16       TD3DXFloat16;
typedef D3DXFLOAT16      *PD3DXFloat16;
typedef D3DXVECTOR2       TD3DXVector2;
typedef D3DXVECTOR2      *PD3DXVector2;
typedef D3DXVECTOR2_16F       TD3DXVector2_16F;
typedef D3DXVECTOR2_16F      *PD3DXVector2_16F;
typedef D3DXVECTOR3       TD3DXVector3;
typedef D3DXVECTOR3      *PD3DXVector3;
typedef D3DXVECTOR3_16F       TD3DXVector3_16F;
typedef D3DXVECTOR3_16F      *PD3DXVector3_16F;
typedef D3DXVECTOR4       TD3DXVector4;
typedef D3DXVECTOR4      *PD3DXVector4;
typedef D3DXVECTOR4_16F       TD3DXVector4_16F;
typedef D3DXVECTOR4_16F      *PD3DXVector4_16F;
typedef D3DXMATRIX        TD3DXMatrix;
typedef D3DXMATRIX       *PD3DXMatrix;
typedef D3DXMATRIX      **PPD3DXMatrix;
typedef D3DXQUATERNION TD3DXQuaternion;
typedef D3DXPLANE TD3DXPlane;
typedef D3DXCOLOR TD3DXColor;
typedef D3DXCOLOR *PD3DXColor;
DECLARE_DINTERFACE_TYPE(ID3DXMatrixStack);
DECLARE_DINTERFACE_TYPE(ID3DXBuffer);
DECLARE_DINTERFACE_TYPE(ID3DXSprite);
DECLARE_DINTERFACE_TYPE(ID3DXFont);
DECLARE_DINTERFACE_TYPE(ID3DXBaseMesh);
DECLARE_DINTERFACE_TYPE(ID3DXMesh);
DECLARE_DINTERFACE_TYPE(ID3DXPMesh);
typedef LPD3DXFILL2D TD3DXFill2D;
typedef LPD3DXFILL3D TD3DXFill3D;
}  /* namespace D3dx9 */

namespace Guimotions3d
{
//-- type declarations -------------------------------------------------------
typedef _D3DCOLORVALUE *PD3DColorValue;

typedef _D3DCOLORVALUE TD3DColorValue;

typedef _D3DRECT *PD3DRect;

typedef _D3DRECT TD3DRect;

typedef _D3DMATRIX *PD3DMatrix;

typedef _D3DMATRIX TD3DMatrix;

typedef _D3DVIEWPORT9 *PD3DViewport9;

typedef _D3DVIEWPORT9 TD3DViewport9;

typedef _D3DCLIPSTATUS9 *PD3DClipStatus9;

typedef _D3DCLIPSTATUS9 TD3DClipStatus9;

typedef _D3DMATERIAL9 *PD3DMaterial9;

typedef _D3DMATERIAL9 TD3DMaterial9;

typedef _D3DLIGHTTYPE TD3DLightType;

typedef _D3DLIGHT9 *PD3DLight9;

typedef _D3DLIGHT9 TD3DLight9;

typedef unsigned TD3DShadeMode;

typedef unsigned TD3DFillMode;

typedef unsigned TD3DBlend;

typedef unsigned TD3DBlendOp;

typedef unsigned TD3DTextureAddress;

typedef unsigned TD3DCull;

typedef unsigned TD3DCmpFunc;

typedef unsigned TD3DStencilOp;

typedef unsigned TD3DFogMode;

typedef unsigned TD3DZBufferType;

typedef _D3DPRIMITIVETYPE TD3DPrimitiveType;

typedef unsigned TD3DTransformStateType;

typedef unsigned TD3DRenderStateType;

typedef unsigned TD3DMaterialSource;

typedef unsigned TD3DTextureStageStateType;

typedef _D3DSAMPLERSTATETYPE TD3DSamplerStateType;

typedef unsigned TD3DTextureOp;

typedef unsigned TD3DTextureFilterType;

typedef _D3DDECLUSAGE TD3DDeclUsage;

typedef _D3DDECLMETHOD TD3DDeclMethod;

typedef _D3DDECLTYPE TD3DDeclType;

typedef _D3DVERTEXELEMENT9 *PD3DVertexElement9;

typedef _D3DVERTEXELEMENT9 TD3DVertexElement9;

typedef unsigned TD3DShaderInstructionOpcodeType;

typedef _D3DSHADER_COMPARISON TD3DShaderComparison;

typedef unsigned TD3DSamplerTextureType;

typedef unsigned TD3DShaderParamRegisterType;

typedef _D3DSHADER_MISCTYPE_OFFSETS TD3DShaderMiscTypeOffsets;

typedef _D3DVS_RASTOUT_OFFSETS TD3DVSRastoutOffsets;

typedef unsigned TD3DVSAddressModeType;

typedef unsigned TD3DShaderAddressModeType;

typedef unsigned TD3DShaderParamSRCModType;

typedef _D3DBASISTYPE TD3DBasisType;

typedef _D3DDEGREETYPE TD3DDegreeType;

typedef _D3DPATCHEDGESTYLE TD3DPatchEdgeStyle;

typedef _D3DSTATEBLOCKTYPE TD3DStateBlockType;

typedef unsigned TD3DVertexBlendFlags;

typedef unsigned TD3DTextureTransformFlags;

typedef _D3DDEVTYPE TD3DDevType;

typedef _D3DMULTISAMPLE_TYPE TD3DMultiSampleType;

typedef unsigned *PD3DFormat;

typedef unsigned TD3DFormat;

typedef _D3DDISPLAYMODE *PD3DDisplayMode;

typedef _D3DDISPLAYMODE TD3DDisplayMode;

typedef _D3DDEVICE_CREATION_PARAMETERS *PD3DDeviceCreationParameters;

typedef _D3DDEVICE_CREATION_PARAMETERS TD3DDeviceCreationParameters;

typedef _D3DSWAPEFFECT TD3DSwapEffect;

typedef _D3DPOOL TD3DPool;

typedef _D3DPRESENT_PARAMETERS_ *PD3DPresentParameters;

typedef _D3DPRESENT_PARAMETERS_ TD3DPresentParameters;

typedef _D3DGAMMARAMP *PD3DGammaRamp;

typedef _D3DGAMMARAMP TD3DGammaRamp;

typedef _D3DBACKBUFFER_TYPE TD3DBackbufferType;

typedef _D3DRESOURCETYPE TD3DResourceType;

typedef _D3DCUBEMAP_FACES TD3DCubemapFaces;

typedef _D3DVERTEXBUFFER_DESC *PD3DVertexBufferDesc;

typedef _D3DVERTEXBUFFER_DESC TD3DVertexBufferDesc;

typedef _D3DINDEXBUFFER_DESC *PD3DIndexBufferDesc;

typedef _D3DINDEXBUFFER_DESC TD3DIndexBufferDesc;

typedef _D3DSURFACE_DESC *PD3DSurfaceDesc;

typedef _D3DSURFACE_DESC TD3DSurfaceDesc;

typedef _D3DVOLUME_DESC *PD3DVolumeDesc;

typedef _D3DVOLUME_DESC TD3DVolumeDesc;

typedef _D3DLOCKED_RECT *PD3DLockedRect;

typedef _D3DLOCKED_RECT TD3DLockedRect;

typedef _D3DBOX *PD3DBox;

typedef _D3DBOX TD3DBox;

typedef _D3DLOCKED_BOX *PD3DLockedBox;

typedef _D3DLOCKED_BOX TD3DLockedBox;

typedef _D3DRANGE *PD3DRange;

typedef _D3DRANGE TD3DRange;

typedef _D3DRECTPATCH_INFO *PD3DRectPatchInfo;

typedef _D3DRECTPATCH_INFO TD3DRectPatchInfo;

typedef _D3DTRIPATCH_INFO *PD3DTriPatchInfo;

typedef _D3DTRIPATCH_INFO TD3DTriPatchInfo;

typedef _D3DADAPTER_IDENTIFIER9 *PD3DAdapterIdentifier9;

typedef _D3DADAPTER_IDENTIFIER9 TD3DAdapterIdentifier9;

typedef _D3DRASTER_STATUS *PD3DRasterStatus;

typedef _D3DRASTER_STATUS TD3DRasterStatus;

typedef unsigned TD3DDebugMonitorTokens;

typedef unsigned TD3DQueryType;

typedef _D3DRESOURCESTATS *PD3DResourceStats;

typedef _D3DRESOURCESTATS TD3DResourceStats;

typedef _D3DDEVINFO_RESOURCEMANAGER *PD3DDevInfoResourceManager;

typedef _D3DDEVINFO_RESOURCEMANAGER TD3DDevInfoResourceManager;

typedef _D3DDEVINFO_D3DVERTEXSTATS *PD3DDevInfoD3DVertexStats;

typedef _D3DDEVINFO_D3DVERTEXSTATS TD3DDevInfoD3DVertexStats;

typedef _D3DDEVINFO_VCACHE *PD3DDevInfoVCache;

typedef _D3DDEVINFO_VCACHE TD3DDevInfoVCache;

typedef _D3DDEVINFO_D3D9PIPELINETIMINGS *PD3DDevInfoD3D9PipelineTimings;

typedef _D3DDEVINFO_D3D9PIPELINETIMINGS TD3DDevInfoD3D9PipelineTimings;

typedef _D3DDEVINFO_D3D9INTERFACETIMINGS *PD3DDevInfoD3D9InterfaceTimings;

typedef _D3DDEVINFO_D3D9INTERFACETIMINGS TD3DDevInfoD3D9InterfaceTimings;

typedef _D3DDEVINFO_D3D9STAGETIMINGS *PD3DDevInfoD3D9StageTimings;

typedef _D3DDEVINFO_D3D9STAGETIMINGS TD3DDevInfoD3D9StageTimings;

typedef _D3DDEVINFO_D3D9BANDWIDTHTIMINGS *PD3DDevInfoD3D9BandwidthTimings;

typedef _D3DDEVINFO_D3D9BANDWIDTHTIMINGS TD3DDevInfoD3D9BandwidthTimings;

typedef _D3DDEVINFO_D3D9CACHEUTILIZATION *PD3DDevInfoD3D9CacheUtilization;

typedef _D3DDEVINFO_D3D9CACHEUTILIZATION TD3DDevInfoD3D9CacheUtilization;

typedef _D3DVSHADERCAPS2_0 *PD3DVShaderCaps2_0;

typedef _D3DVSHADERCAPS2_0 TD3DVShaderCaps2_0;

typedef _D3DPSHADERCAPS2_0 *PD3DPShaderCaps2_0;

typedef _D3DPSHADERCAPS2_0 TD3DPShaderCaps2_0;

typedef _D3DCAPS9 *PD3DCaps9;

typedef _D3DCAPS9 TD3DCaps9;

typedef PD3DAdapterIdentifier9 PD3DAdapter_Identifier9;

typedef PD3DDeviceCreationParameters PD3DDevice_Creation_Parameters;

typedef PD3DDevInfoD3DVertexStats PD3DDevInfo_D3DVertexStats;

typedef PD3DDevInfoResourceManager PD3DDevInfo_ResourceManager;

typedef PD3DDevInfoVCache PD3DDevInfo_VCache;

typedef PD3DIndexBufferDesc PD3DIndexBuffer_Desc;

typedef PD3DLockedBox PD3DLocked_Box;

typedef PD3DLockedRect PD3DLocked_Rect;

typedef PD3DPresentParameters PD3DPresent_Parameters;

typedef PD3DRasterStatus PD3DRaster_Status;

typedef PD3DRectPatchInfo PD3DRectPatch_Info;

typedef PD3DSurfaceDesc PD3DSurface_Desc;

typedef PD3DTriPatchInfo PD3DTriPatch_Info;

typedef PD3DVertexBufferDesc PD3DVertexBuffer_Desc;

typedef PD3DVolumeDesc PD3DVolume_Desc;

typedef _D3DADAPTER_IDENTIFIER9 TD3DAdapter_Identifier9;

typedef _D3DBACKBUFFER_TYPE TD3DBackBuffer_Type;

typedef _D3DCUBEMAP_FACES TD3DCubeMap_Faces;

typedef _D3DDEVICE_CREATION_PARAMETERS TD3DDevice_Creation_Parameters;

typedef _D3DDEVINFO_D3DVERTEXSTATS TD3DDevInfo_D3DVertexStats;

typedef _D3DDEVINFO_RESOURCEMANAGER TD3DDevInfo_ResourceManager;

typedef _D3DDEVINFO_VCACHE TD3DDevInfo_VCache;

typedef _D3DINDEXBUFFER_DESC TD3DIndexBuffer_Desc;

typedef _D3DLOCKED_BOX TD3DLocked_Box;

typedef _D3DLOCKED_RECT TD3DLocked_Rect;

typedef _D3DMULTISAMPLE_TYPE TD3DMultiSample_Type;

typedef _D3DPRESENT_PARAMETERS_ TD3DPresent_Parameters;

typedef _D3DRASTER_STATUS TD3DRaster_Status;

typedef _D3DRECTPATCH_INFO TD3DRectPatch_Info;

typedef unsigned TD3DSampler_Texture_Type;

typedef unsigned TD3DShader_AddressMode_Type;

typedef _D3DSHADER_COMPARISON TD3DShader_Comparison;

typedef unsigned TD3DShader_Instruction_Opcode_Type;

typedef _D3DSHADER_MISCTYPE_OFFSETS TD3DShader_MiscType_Offsets;

typedef unsigned TD3DShader_Param_Register_Type;

typedef unsigned TD3DShader_Param_SRCMod_Type;

typedef _D3DSURFACE_DESC TD3DSurface_Desc;

typedef _D3DTRIPATCH_INFO TD3DTriPatch_Info;

typedef _D3DVERTEXBUFFER_DESC TD3DVertexBuffer_Desc;

typedef _D3DVOLUME_DESC TD3DVolume_Desc;

typedef unsigned TD3DVS_AddressMode_Type;

typedef _D3DVS_RASTOUT_OFFSETS TD3DVS_RastOut_Offsets;

typedef void * *PPointer;

typedef char * *PPAnsiChar;

typedef TD3DXVector3_16F *PD3DXVector3_16F;

typedef PD3DXMatrix *PPD3DXMatrix;

typedef _D3DMATRIX *PD3DXMatrixA16;

typedef _D3DMATRIX TD3DXMatrixA16;

typedef TD3DXQuaternion *PD3DXQuaternion;

typedef TD3DXPlane *PD3DXPlane;

typedef _di_ID3DXBuffer *PID3DXBuffer;

typedef _D3DXFONT_DESCA *PD3DXFontDescA;

typedef _D3DXFONT_DESCW *PD3DXFontDescW;

typedef PD3DXFontDescA PD3DXFontDesc;

typedef _D3DXFONT_DESCA TD3DXFontDescA;

typedef _D3DXFONT_DESCW TD3DXFontDescW;

typedef _D3DXFONT_DESCA TD3DXFontDesc;

typedef _D3DXPATCHMESHTYPE TD3DXPatchMeshType;

typedef unsigned TD3DXMesh;

typedef _D3DXPATCHMESH TD3DXPatchMesh;

typedef _D3DXMESHSIMP TD3DXMeshSimp;

typedef unsigned TD3DXCleanType;

typedef System::StaticArray<_D3DVERTEXELEMENT9, 65> TFVFDeclaration;

typedef unsigned D3DXTANGENT;

typedef unsigned TD3DXTangent;

typedef _D3DXIMT TD3DXIMT;

typedef _D3DXUVATLAS TD3DXUVAtlas;

typedef _D3DXATTRIBUTERANGE *PD3DXAttributeRange;

typedef _D3DXATTRIBUTERANGE TD3DXAttributeRange;

typedef _D3DXMATERIAL *PD3DXMaterial;

typedef _D3DXMATERIAL TD3DXMaterial;

typedef _D3DXEFFECTDEFAULTTYPE TD3DXEffectDefaultType;

typedef _D3DXEFFECTDEFAULT *PD3DXEffectDefault;

typedef _D3DXEFFECTDEFAULT TD3DXEffectDefault;

typedef _D3DXEFFECTINSTANCE *PD3DXEffectInstance;

typedef _D3DXEFFECTINSTANCE TD3DXEffectInstance;

typedef _D3DXATTRIBUTEWEIGHTS *PD3DXAttributeWeights;

typedef _D3DXATTRIBUTEWEIGHTS TD3DXAttributeWeights;

typedef unsigned TD3DXWeldEpsilonsFlags;

typedef _D3DXWELDEPSILONS *PD3DXWeldEpsilons;

typedef _D3DXWELDEPSILONS TD3DXWeldEpsilons;

typedef _di_ID3DXMesh *PID3DXMesh;

typedef _D3DXIMAGE_FILEFORMAT *PD3DXImageFileFormat;

typedef _D3DXIMAGE_FILEFORMAT TD3DXImageFileFormat;

typedef _D3DXIMAGE_INFO *PD3DXImageInfo;

typedef _D3DXIMAGE_INFO TD3DXImageInfo;

//-- var, const, procedure ---------------------------------------------------
#define d3dx9MicrosoftDLL L"d3dx9_33.dll"
#define d3dx9BorlandDLL L"d3dx9_33.dll"
#define d3dx9dll L"d3dx9_33.dll"
static const unsigned iTrue = 0x1;
static const unsigned iFalse = 0x0;
static const int D3DFMT_ATI2 = 0x32495441;
static const int MAKE_D3DHRESULT_R = -2005532672;
static const int MAKE_D3DSTATUS_R = 0x8760000;
#define Direct3D9dll L"d3d9.dll"
extern PACKAGE TD3DXFloat16 D3DXFloat16Zero;
extern PACKAGE TD3DXVector2 D3DXVector2Zero;
extern PACKAGE TD3DXVector2_16F D3DXVector2_16fZero;
extern PACKAGE _D3DVECTOR D3DXVector3Zero;
extern PACKAGE TD3DXVector3_16F D3DXVector3_16fZero;
extern PACKAGE TD3DXVector4 D3DXVector4Zero;
extern PACKAGE TD3DXVector4_16F D3DXVector4_16fZero;
extern PACKAGE TD3DXPlane D3DXPlaneZero;
static const int MAKE_D3DXFERR_D = -2005532672;
extern PACKAGE TD3DXFloat16 __fastcall D3DXFloat16(float value);
extern PACKAGE bool __fastcall D3DXFloat16Equal(const TD3DXFloat16 v1, const TD3DXFloat16 v2);
extern PACKAGE float __fastcall D3DXFloat16ToFloat(TD3DXFloat16 value);
extern PACKAGE TD3DXVector2 __fastcall D3DXVector2(float _x, float _y);
extern PACKAGE bool __fastcall D3DXVector2Equal(const TD3DXVector2 &v1, const TD3DXVector2 &v2);
extern PACKAGE TD3DXVector2_16F __fastcall D3DXVector2_16F(TD3DXFloat16 _x, TD3DXFloat16 _y);
extern PACKAGE bool __fastcall D3DXVector2_16fEqual(const TD3DXVector2_16F v1, const TD3DXVector2_16F v2);
extern PACKAGE TD3DXVector2_16F __fastcall D3DXVector2_16fFromVector2(const TD3DXVector2 &v);
extern PACKAGE TD3DXVector2 __fastcall D3DXVector2FromVector2_16f(const TD3DXVector2_16F v);
extern PACKAGE _D3DVECTOR __fastcall D3DXVector3(float _x, float _y, float _z);
extern PACKAGE bool __fastcall D3DXVector3Equal(const _D3DVECTOR &v1, const _D3DVECTOR &v2);
extern PACKAGE TD3DXVector3_16F __fastcall D3DXVector3_16F(TD3DXFloat16 _x, TD3DXFloat16 _y, TD3DXFloat16 _z);
extern PACKAGE bool __fastcall D3DXVector3_16fEqual(const TD3DXVector3_16F &v1, const TD3DXVector3_16F &v2);
extern PACKAGE TD3DXVector3_16F __fastcall D3DXVector3_16fFromVector3(const _D3DVECTOR &v);
extern PACKAGE _D3DVECTOR __fastcall D3DXVector3FromVector3_16f(const TD3DXVector3_16F &v);
extern PACKAGE TD3DXVector4 __fastcall D3DXVector4(float _x, float _y, float _z, float _w)/* overload */;
extern PACKAGE TD3DXVector4 __fastcall D3DXVector4(const _D3DVECTOR &xyz, float _w)/* overload */;
extern PACKAGE bool __fastcall D3DXVector4Equal(const TD3DXVector4 &v1, const TD3DXVector4 &v2);
extern PACKAGE TD3DXVector4_16F __fastcall D3DXVector4_16F(TD3DXFloat16 _x, TD3DXFloat16 _y, TD3DXFloat16 _z, TD3DXFloat16 _w)/* overload */;
extern PACKAGE TD3DXVector4_16F __fastcall D3DXVector4_16F(const TD3DXVector3_16F &xyz, TD3DXFloat16 _w)/* overload */;
extern PACKAGE bool __fastcall D3DXVector4_16fEqual(const TD3DXVector4_16F &v1, const TD3DXVector4_16F &v2);
extern PACKAGE TD3DXVector4_16F __fastcall D3DXVector4_16fFromVector4(const TD3DXVector4 &v);
extern PACKAGE TD3DXVector4 __fastcall D3DXVector4FromVector4_16f(const TD3DXVector4_16F &v);
extern PACKAGE _D3DMATRIX __fastcall D3DXMatrix(float _m00, float _m01, float _m02, float _m03, float _m10, float _m11, float _m12, float _m13, float _m20, float _m21, float _m22, float _m23, float _m30, float _m31, float _m32, float _m33);
extern PACKAGE PD3DXMatrix __fastcall D3DXMatrixAdd(/* out */ _D3DMATRIX &mOut, const _D3DMATRIX &m1, const _D3DMATRIX &m2);
extern PACKAGE PD3DXMatrix __fastcall D3DXMatrixSubtract(/* out */ _D3DMATRIX &mOut, const _D3DMATRIX &m1, const _D3DMATRIX &m2);
extern PACKAGE PD3DXMatrix __fastcall D3DXMatrixMul(/* out */ _D3DMATRIX &mOut, const _D3DMATRIX &m, float MulBy);
extern PACKAGE bool __fastcall D3DXMatrixEqual(const _D3DMATRIX &m1, const _D3DMATRIX &m2);
extern PACKAGE TD3DXQuaternion __fastcall D3DXQuaternion(float _x, float _y, float _z, float _w);
extern PACKAGE TD3DXQuaternion __fastcall D3DXQuaternionAdd(const TD3DXQuaternion &q1, const TD3DXQuaternion &q2);
extern PACKAGE TD3DXQuaternion __fastcall D3DXQuaternionSubtract(const TD3DXQuaternion &q1, const TD3DXQuaternion &q2);
extern PACKAGE bool __fastcall D3DXQuaternionEqual(const TD3DXQuaternion &q1, const TD3DXQuaternion &q2);
extern PACKAGE PD3DXQuaternion __fastcall D3DXQuaternionScale(/* out */ TD3DXQuaternion &qOut, const TD3DXQuaternion &q, float s);
extern PACKAGE TD3DXPlane __fastcall D3DXPlane(float _a, float _b, float _c, float _d);
extern PACKAGE bool __fastcall D3DXPlaneEqual(const TD3DXPlane &p1, const TD3DXPlane &p2);
extern PACKAGE _D3DCOLORVALUE __fastcall D3DXColor(float _r, float _g, float _b, float _a);
extern PACKAGE unsigned __fastcall D3DXColorToDWord(const _D3DCOLORVALUE &c);
extern PACKAGE _D3DCOLORVALUE __fastcall D3DXColorFromDWord(unsigned c);
extern PACKAGE bool __fastcall D3DXColorEqual(const _D3DCOLORVALUE &c1, const _D3DCOLORVALUE &c2);
extern PACKAGE bool __fastcall Direct3D9Loaded(void);
extern PACKAGE bool __fastcall UnLoadDirect3D9(void);
extern PACKAGE bool __fastcall LoadDirect3D9(void);
extern "C" void * __stdcall _Direct3DCreate9(unsigned SDKVersion);

}	/* namespace Guimotions3d */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Guimotions3d;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Guimotions3dHPP
