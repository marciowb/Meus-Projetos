// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_graphics.pas' rev: 21.00

#ifndef Ap_graphicsHPP
#define Ap_graphicsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ap_types.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_graphics
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatGraphicsLibrary;
class PASCALIMPLEMENTATION TatGraphicsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TGraphicsObjectHandleAllocated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFontHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFontHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFontPixelsPerInch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFontPixelsPerInch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPenCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPenDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPenAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPenHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPenHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBrushCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBrushDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBrushAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBrushBitmap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBrushBitmap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBrushHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBrushHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontRecallCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPenRecallCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBrushRecallCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasArc(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasBrushCopy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasChord(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasDraw(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasDrawFocusRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasEllipse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasFillRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasFloodFill(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasFrameRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasLineTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasLock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasMoveTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasPie(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasRectangle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasRefresh(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasRoundRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasStretchDraw(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasTextExtent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasTextHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasTextOut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasTextRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasTextWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasTryLock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCanvasUnlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomCanvasClipRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomCanvasCanvasOrientation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomCanvasPenPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomCanvasPenPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomCanvasPixels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomCanvasPixels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomCanvasTextFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomCanvasTextFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasArc(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasBrushCopy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasChord(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasCopyRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasDraw(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasDrawFocusRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasEllipse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasFillRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasFloodFill(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasFrameRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasHandleAllocated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasLineTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasMoveTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasPie(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasRectangle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasRefresh(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasRoundRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasStretchDraw(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasTextExtent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasTextOut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasTextRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCanvasHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicEquals(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicLoadFromFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicSaveToFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicLoadFromClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicSaveToClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicSetSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicEmpty(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTGraphicHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicModified(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTGraphicModified(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicPalette(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTGraphicPalette(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicPaletteModified(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTGraphicPaletteModified(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicTransparent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTGraphicTransparent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTGraphicWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTGraphicSupportsPartialTransparency(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureLoadFromFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureSaveToFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureLoadFromClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureSaveToClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureSupportsClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPictureAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPictureBitmap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPictureBitmap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPictureGraphic(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPictureGraphic(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPictureHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPictureIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPictureIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPictureMetafile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPictureMetafile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPictureWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileCanvasCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileCanvasCreateWithComment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileCanvasDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSharedImageDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileImageDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileHandleAllocated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileSaveToFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileLoadFromClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileSaveToClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileReleaseHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMetafileSetSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileCreatedBy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileDescription(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileEnhanced(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMetafileEnhanced(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMetafileHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileMMWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMetafileMMWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileMMHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMetafileMMHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMetafileInch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMetafileInch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapImageDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapDormant(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapFreeImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapHandleAllocated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapLoadFromClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapMask(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapReleaseHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapReleaseMaskHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapReleasePalette(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapSaveToClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapSetSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapLoadFromResourceName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitmapLoadFromResourceID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapHandleType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapHandleType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapIgnorePalette(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapIgnorePalette(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapMaskHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapMaskHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapMonochrome(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapMonochrome(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapPixelFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapPixelFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapTransparentColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapTransparentColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapTransparentMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapTransparentMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitmapAlphaFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitmapAlphaFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconImageDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconAssignTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconHandleAllocated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconLoadFromClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconReleaseHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconSaveToClipboardFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconSetSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconLoadFromResourceName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconLoadFromResourceID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTIconHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTIconHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ColorToRGB(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ColorToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringToColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ColorToIdent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IdentToColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharsetToIdent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IdentToCharset(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDIBSizes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDIB(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyPalette(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PaletteChanged(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FreeMemoryContexts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDefFontCharSet(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TransparentStretchBlt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AllocPatternBitmap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __BytesPerScanline(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDefFontData(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDefFontData(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetSystemPalette16(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetSystemPalette16(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDDBsOnly(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDDBsOnly(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasLock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasTextHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasTextWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasTryLock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCanvasUnlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasClipRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasLockCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasCanvasOrientation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasPenPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCanvasPenPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasPixels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCanvasPixels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCanvasTextFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCanvasTextFlags(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatGraphicsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatGraphicsLibrary(void) { }
	
};


typedef TMetaClass* EInvalidGraphicClass;

typedef TMetaClass* EInvalidGraphicOperationClass;

typedef TMetaClass* TGraphicsObjectClass;

typedef TMetaClass* TFontClass;

typedef TMetaClass* TPenClass;

typedef TMetaClass* TBrushClass;

typedef TMetaClass* TFontRecallClass;

typedef TMetaClass* TPenRecallClass;

typedef TMetaClass* TBrushRecallClass;

typedef TMetaClass* TCustomCanvasClass;

typedef TMetaClass* TCanvasClass;

typedef TMetaClass* TGraphicClass;

typedef TMetaClass* TPictureClass;

typedef TMetaClass* TMetafileCanvasClass;

typedef TMetaClass* TSharedImageClass;

typedef TMetaClass* TMetafileImageClass;

typedef TMetaClass* TMetafileClass;

typedef TMetaClass* TBitmapImageClass;

typedef TMetaClass* TBitmapClass;

typedef TMetaClass* TIconImageClass;

typedef TMetaClass* TIconClass;

class DELPHICLASS TCursorOrIconWrapper;
class PASCALIMPLEMENTATION TCursorOrIconWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FReserved;
	System::Word FwType;
	System::Word FCount;
	
public:
	__fastcall TCursorOrIconWrapper(const Graphics::TCursorOrIcon &ARecord);
	Graphics::TCursorOrIcon __fastcall ObjToRec(void);
	
__published:
	__property System::Word Reserved = {read=FReserved, write=FReserved, nodefault};
	__property System::Word wType = {read=FwType, write=FwType, nodefault};
	__property System::Word Count = {read=FCount, write=FCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCursorOrIconWrapper(void) { }
	
};


class DELPHICLASS TIconRecWrapper;
class PASCALIMPLEMENTATION TIconRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FWidth;
	System::Byte FHeight;
	System::Word FColors;
	System::Word FReserved1;
	System::Word FReserved2;
	int FDIBSize;
	int FDIBOffset;
	
public:
	__fastcall TIconRecWrapper(const Graphics::TIconRec &ARecord);
	Graphics::TIconRec __fastcall ObjToRec(void);
	
__published:
	__property System::Byte Width = {read=FWidth, write=FWidth, nodefault};
	__property System::Byte Height = {read=FHeight, write=FHeight, nodefault};
	__property System::Word Colors = {read=FColors, write=FColors, nodefault};
	__property System::Word Reserved1 = {read=FReserved1, write=FReserved1, nodefault};
	__property System::Word Reserved2 = {read=FReserved2, write=FReserved2, nodefault};
	__property int DIBSize = {read=FDIBSize, write=FDIBSize, nodefault};
	__property int DIBOffset = {read=FDIBOffset, write=FDIBOffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TIconRecWrapper(void) { }
	
};


class DELPHICLASS TResDataWrapper;
class PASCALIMPLEMENTATION TResDataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FHandle;
	
public:
	__fastcall TResDataWrapper(Graphics::TResData ARecord);
	Graphics::TResData __fastcall ObjToRec(void);
	
__published:
	__property unsigned Handle = {read=FHandle, write=FHandle, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TResDataWrapper(void) { }
	
};


class DELPHICLASS TFontDataWrapper;
class PASCALIMPLEMENTATION TFontDataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HFONT FHandle;
	int FHeight;
	int FOrientation;
	Graphics::TFontPitch FPitch;
	Graphics::TFontStylesBase FStyle;
	Graphics::TFontCharset FCharset;
	
public:
	__fastcall TFontDataWrapper(const Graphics::TFontData &ARecord);
	Graphics::TFontData __fastcall ObjToRec(void);
	
__published:
	__property HFONT Handle = {read=FHandle, write=FHandle, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int Orientation = {read=FOrientation, write=FOrientation, nodefault};
	__property Graphics::TFontPitch Pitch = {read=FPitch, write=FPitch, nodefault};
	__property Graphics::TFontStylesBase Style = {read=FStyle, write=FStyle, nodefault};
	__property Graphics::TFontCharset Charset = {read=FCharset, write=FCharset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFontDataWrapper(void) { }
	
};


class DELPHICLASS TPenDataWrapper;
class PASCALIMPLEMENTATION TPenDataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HPEN FHandle;
	Graphics::TColor FColor;
	int FWidth;
	Graphics::TPenStyle FStyle;
	
public:
	__fastcall TPenDataWrapper(const Graphics::TPenData &ARecord);
	Graphics::TPenData __fastcall ObjToRec(void);
	
__published:
	__property HPEN Handle = {read=FHandle, write=FHandle, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property Graphics::TPenStyle Style = {read=FStyle, write=FStyle, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPenDataWrapper(void) { }
	
};


class DELPHICLASS TBrushDataWrapper;
class PASCALIMPLEMENTATION TBrushDataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HBRUSH FHandle;
	Graphics::TColor FColor;
	Graphics::TBitmap* FBitmap;
	Graphics::TBrushStyle FStyle;
	bool FOwnsBitmap;
	
public:
	__fastcall TBrushDataWrapper(const Graphics::TBrushData &ARecord);
	Graphics::TBrushData __fastcall ObjToRec(void);
	
__published:
	__property HBRUSH Handle = {read=FHandle, write=FHandle, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=FBitmap};
	__property Graphics::TBrushStyle Style = {read=FStyle, write=FStyle, nodefault};
	__property bool OwnsBitmap = {read=FOwnsBitmap, write=FOwnsBitmap, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TBrushDataWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_graphics */
using namespace Ap_graphics;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_graphicsHPP
