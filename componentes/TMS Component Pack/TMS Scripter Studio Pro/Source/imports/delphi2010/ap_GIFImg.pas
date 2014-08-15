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
unit ap_GIFImg;

interface

uses
  SysUtils,
  Windows,
  Graphics,
  ExtCtrls,
  Classes,
  GIFImg,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatGIFImgLibrary = class(TatScripterLibrary)
    procedure __TGIFItemCreate(AMachine: TatVirtualMachine);
    procedure __TGIFItemSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFItemLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFItemSaveToFile(AMachine: TatVirtualMachine);
    procedure __TGIFItemLoadFromFile(AMachine: TatVirtualMachine);
    procedure __GetTGIFItemVersion(AMachine: TatVirtualMachine);
    procedure __GetTGIFItemImage(AMachine: TatVirtualMachine);
    procedure __TGIFListCreate(AMachine: TatVirtualMachine);
    procedure __TGIFListDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFListAdd(AMachine: TatVirtualMachine);
    procedure __TGIFListClear(AMachine: TatVirtualMachine);
    procedure __TGIFListDelete(AMachine: TatVirtualMachine);
    procedure __TGIFListExchange(AMachine: TatVirtualMachine);
    procedure __TGIFListFirst(AMachine: TatVirtualMachine);
    procedure __TGIFListIndexOf(AMachine: TatVirtualMachine);
    procedure __TGIFListInsert(AMachine: TatVirtualMachine);
    procedure __TGIFListLast(AMachine: TatVirtualMachine);
    procedure __TGIFListMove(AMachine: TatVirtualMachine);
    procedure __TGIFListRemove(AMachine: TatVirtualMachine);
    procedure __TGIFListSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFListLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFListItems(AMachine: TatVirtualMachine);
    procedure __SetTGIFListItems(AMachine: TatVirtualMachine);
    procedure __GetTGIFListCount(AMachine: TatVirtualMachine);
    procedure __GetTGIFListList(AMachine: TatVirtualMachine);
    procedure __GetTGIFListImage(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapCreate(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapColor2RGB(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapRGB2Color(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapAssign(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapIndexOf(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapAdd(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapAddUnique(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapDelete(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapClear(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapOptimize(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapChanged(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapImportPalette(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapImportDIBColors(AMachine: TatVirtualMachine);
    procedure __TGIFColorMapExportPalette(AMachine: TatVirtualMachine);
    procedure __GetTGIFColorMapColors(AMachine: TatVirtualMachine);
    procedure __SetTGIFColorMapColors(AMachine: TatVirtualMachine);
    procedure __GetTGIFColorMapCount(AMachine: TatVirtualMachine);
    procedure __GetTGIFColorMapOptimized(AMachine: TatVirtualMachine);
    procedure __SetTGIFColorMapOptimized(AMachine: TatVirtualMachine);
    procedure __GetTGIFColorMapBitsPerPixel(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderCreate(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderAssign(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderClear(AMachine: TatVirtualMachine);
    procedure __TGIFHeaderPrepare(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderVersion(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderWidth(AMachine: TatVirtualMachine);
    procedure __SetTGIFHeaderWidth(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderHeight(AMachine: TatVirtualMachine);
    procedure __SetTGIFHeaderHeight(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderBackgroundColorIndex(AMachine: TatVirtualMachine);
    procedure __SetTGIFHeaderBackgroundColorIndex(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderBackgroundColor(AMachine: TatVirtualMachine);
    procedure __SetTGIFHeaderBackgroundColor(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderAspectRatio(AMachine: TatVirtualMachine);
    procedure __SetTGIFHeaderAspectRatio(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderColorMap(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderBitsPerPixel(AMachine: TatVirtualMachine);
    procedure __GetTGIFHeaderColorResolution(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionCreate(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionAssign(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFExtensionExtensionType(AMachine: TatVirtualMachine);
    procedure __GetTGIFExtensionFrame(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionListCreate(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionListAssign(AMachine: TatVirtualMachine);
    procedure __TGIFExtensionListLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFExtensionListExtensions(AMachine: TatVirtualMachine);
    procedure __SetTGIFExtensionListExtensions(AMachine: TatVirtualMachine);
    procedure __GetTGIFExtensionListFrame(AMachine: TatVirtualMachine);
    procedure __TGIFFrameCreate(AMachine: TatVirtualMachine);
    procedure __TGIFFrameDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFFrameClear(AMachine: TatVirtualMachine);
    procedure __TGIFFrameDormant(AMachine: TatVirtualMachine);
    procedure __TGIFFrameSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFFrameLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFFrameAssign(AMachine: TatVirtualMachine);
    procedure __TGIFFrameDraw(AMachine: TatVirtualMachine);
    procedure __TGIFFrameStretchDraw(AMachine: TatVirtualMachine);
    procedure __TGIFFrameCrop(AMachine: TatVirtualMachine);
    procedure __TGIFFrameMerge(AMachine: TatVirtualMachine);
    procedure __TGIFFrameScaleRect(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameHasBitmap(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameHasBitmap(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameLeft(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameLeft(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameTop(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameTop(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameWidth(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameWidth(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameHeight(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameHeight(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameBoundsRect(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameBoundsRect(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameClientRect(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameInterlaced(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameInterlaced(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameColorMap(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameActiveColorMap(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameDataSize(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameExtensions(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameVersion(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameColorResolution(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameBitsPerPixel(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameBitmap(AMachine: TatVirtualMachine);
    procedure __SetTGIFFrameBitmap(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameMask(AMachine: TatVirtualMachine);
    procedure __GetTGIFFramePalette(AMachine: TatVirtualMachine);
    procedure __SetTGIFFramePalette(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameEmpty(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameTransparent(AMachine: TatVirtualMachine);
    procedure __GetTGIFFrameGraphicControlExtension(AMachine: TatVirtualMachine);
    procedure __GetTGIFFramePixels(AMachine: TatVirtualMachine);
    procedure __SetTGIFFramePixels(AMachine: TatVirtualMachine);
    procedure __TGIFTrailerSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFTrailerLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFGraphicControlExtensionCreate(AMachine: TatVirtualMachine);
    procedure __TGIFGraphicControlExtensionDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFGraphicControlExtensionSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFGraphicControlExtensionLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFGraphicControlExtensionDelay(AMachine: TatVirtualMachine);
    procedure __SetTGIFGraphicControlExtensionDelay(AMachine: TatVirtualMachine);
    procedure __GetTGIFGraphicControlExtensionTransparent(AMachine: TatVirtualMachine);
    procedure __SetTGIFGraphicControlExtensionTransparent(AMachine: TatVirtualMachine);
    procedure __GetTGIFGraphicControlExtensionTransparentColorIndex(AMachine: TatVirtualMachine);
    procedure __SetTGIFGraphicControlExtensionTransparentColorIndex(AMachine: TatVirtualMachine);
    procedure __GetTGIFGraphicControlExtensionTransparentColor(AMachine: TatVirtualMachine);
    procedure __SetTGIFGraphicControlExtensionTransparentColor(AMachine: TatVirtualMachine);
    procedure __GetTGIFGraphicControlExtensionUserInput(AMachine: TatVirtualMachine);
    procedure __SetTGIFGraphicControlExtensionUserInput(AMachine: TatVirtualMachine);
    procedure __GetTGIFGraphicControlExtensionDisposal(AMachine: TatVirtualMachine);
    procedure __SetTGIFGraphicControlExtensionDisposal(AMachine: TatVirtualMachine);
    procedure __TGIFTextExtensionCreate(AMachine: TatVirtualMachine);
    procedure __TGIFTextExtensionDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFTextExtensionSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFTextExtensionLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionLeft(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionLeft(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionTop(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionTop(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionGridWidth(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionGridWidth(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionGridHeight(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionGridHeight(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionCharWidth(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionCharWidth(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionCharHeight(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionCharHeight(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionForegroundColorIndex(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionForegroundColorIndex(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionForegroundColor(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionBackgroundColorIndex(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionBackgroundColorIndex(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionBackgroundColor(AMachine: TatVirtualMachine);
    procedure __GetTGIFTextExtensionText(AMachine: TatVirtualMachine);
    procedure __SetTGIFTextExtensionText(AMachine: TatVirtualMachine);
    procedure __TGIFCommentExtensionCreate(AMachine: TatVirtualMachine);
    procedure __TGIFCommentExtensionDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFCommentExtensionSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFCommentExtensionLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFCommentExtensionText(AMachine: TatVirtualMachine);
    procedure __SetTGIFCommentExtensionText(AMachine: TatVirtualMachine);
    procedure __TGIFApplicationExtensionCreate(AMachine: TatVirtualMachine);
    procedure __TGIFApplicationExtensionDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFApplicationExtensionSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFApplicationExtensionLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFApplicationExtensionIdentifier(AMachine: TatVirtualMachine);
    procedure __SetTGIFApplicationExtensionIdentifier(AMachine: TatVirtualMachine);
    procedure __GetTGIFApplicationExtensionAuthentication(AMachine: TatVirtualMachine);
    procedure __SetTGIFApplicationExtensionAuthentication(AMachine: TatVirtualMachine);
    procedure __TGIFBlockCreate(AMachine: TatVirtualMachine);
    procedure __TGIFBlockDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFBlockSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFBlockLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFBlockSize(AMachine: TatVirtualMachine);
    procedure __TGIFUnknownAppExtensionCreate(AMachine: TatVirtualMachine);
    procedure __TGIFUnknownAppExtensionDestroy(AMachine: TatVirtualMachine);
    procedure __GetTGIFUnknownAppExtensionBlocks(AMachine: TatVirtualMachine);
    procedure __TGIFAppExtNSLoopCreate(AMachine: TatVirtualMachine);
    procedure __GetTGIFAppExtNSLoopLoops(AMachine: TatVirtualMachine);
    procedure __SetTGIFAppExtNSLoopLoops(AMachine: TatVirtualMachine);
    procedure __GetTGIFAppExtNSLoopBufferSize(AMachine: TatVirtualMachine);
    procedure __SetTGIFAppExtNSLoopBufferSize(AMachine: TatVirtualMachine);
    procedure __TGIFImageListCreate(AMachine: TatVirtualMachine);
    procedure __TGIFImageListLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFImageListSaveToStream(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageListFrames(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageListFrames(AMachine: TatVirtualMachine);
    procedure __TGIFImageCreate(AMachine: TatVirtualMachine);
    procedure __TGIFImageDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFImageDormant(AMachine: TatVirtualMachine);
    procedure __TGIFImageSaveToStream(AMachine: TatVirtualMachine);
    procedure __TGIFImageLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TGIFImageAdd(AMachine: TatVirtualMachine);
    procedure __TGIFImagePack(AMachine: TatVirtualMachine);
    procedure __TGIFImageOptimizeColorMap(AMachine: TatVirtualMachine);
    procedure __TGIFImageOptimize(AMachine: TatVirtualMachine);
    procedure __TGIFImageClear(AMachine: TatVirtualMachine);
    procedure __TGIFImageWarning(AMachine: TatVirtualMachine);
    procedure __TGIFImageAssign(AMachine: TatVirtualMachine);
    procedure __TGIFImageLoadFromClipboardFormat(AMachine: TatVirtualMachine);
    procedure __TGIFImageSaveToClipboardFormat(AMachine: TatVirtualMachine);
    procedure __TGIFImageEffectiveBackgroundColor(AMachine: TatVirtualMachine);
    procedure __TGIFImageStopDraw(AMachine: TatVirtualMachine);
    procedure __TGIFImageSuspendDraw(AMachine: TatVirtualMachine);
    procedure __TGIFImageResumeDraw(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageGlobalColorMap(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageVersion(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageImages(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageColorResolution(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageBitsPerPixel(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageBackgroundColorIndex(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageBackgroundColorIndex(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageBackgroundColor(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageBackgroundColor(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageAspectRatio(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageAspectRatio(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageIsTransparent(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageDrawBackgroundColor(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageDrawBackgroundColor(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageColorReduction(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageColorReduction(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageReductionBits(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageReductionBits(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageDitherMode(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageDitherMode(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageAnimationSpeed(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageAnimationSpeed(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageBitmap(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageAnimate(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageAnimate(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageAnimateLoop(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageAnimateLoop(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageDithering(AMachine: TatVirtualMachine);
    procedure __SetTGIFImageDithering(AMachine: TatVirtualMachine);
    procedure __GetTGIFImageShouldDither(AMachine: TatVirtualMachine);
    procedure __TCustomGIFRendererCreate(AMachine: TatVirtualMachine);
    procedure __TCustomGIFRendererDraw(AMachine: TatVirtualMachine);
    procedure __TCustomGIFRendererNextFrame(AMachine: TatVirtualMachine);
    procedure __TCustomGIFRendererStartAnimation(AMachine: TatVirtualMachine);
    procedure __TCustomGIFRendererStopAnimation(AMachine: TatVirtualMachine);
    procedure __TCustomGIFRendererHaltAnimation(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererSpeed(AMachine: TatVirtualMachine);
    procedure __SetTCustomGIFRendererSpeed(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererTransparent(AMachine: TatVirtualMachine);
    procedure __SetTCustomGIFRendererTransparent(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererBackgroundColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomGIFRendererBackgroundColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererAnimate(AMachine: TatVirtualMachine);
    procedure __SetTCustomGIFRendererAnimate(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererFrameIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomGIFRendererFrameIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererImage(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererTargetCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererTargetRect(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererFrame(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererLoopMax(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererLoopCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererAnimating(AMachine: TatVirtualMachine);
    procedure __GetTCustomGIFRendererBitmap(AMachine: TatVirtualMachine);
    procedure __TGIFRendererCreate(AMachine: TatVirtualMachine);
    procedure __TGIFRendererDestroy(AMachine: TatVirtualMachine);
    procedure __TGIFRendererDraw(AMachine: TatVirtualMachine);
    procedure __TGIFRendererStartAnimation(AMachine: TatVirtualMachine);
    procedure __TGIFRendererStopAnimation(AMachine: TatVirtualMachine);
    procedure __TGIFRendererHaltAnimation(AMachine: TatVirtualMachine);
    procedure __GetTGIFRendererBackground(AMachine: TatVirtualMachine);
    procedure __GetTGIFRendererFrameDelay(AMachine: TatVirtualMachine);
    procedure __GetTGIFRendererDisposal(AMachine: TatVirtualMachine);
    procedure __GetTGIFRendererPrevDisposal(AMachine: TatVirtualMachine);
    procedure __GetTGIFRendererPrevFrame(AMachine: TatVirtualMachine);
    procedure __TColorLookupCreate(AMachine: TatVirtualMachine);
    procedure __TColorLookupLookup(AMachine: TatVirtualMachine);
    procedure __GetTColorLookupColors(AMachine: TatVirtualMachine);
    procedure __TFastColorLookupCreate(AMachine: TatVirtualMachine);
    procedure __TFastColorLookupDestroy(AMachine: TatVirtualMachine);
    procedure __TFastColorLookupLookup(AMachine: TatVirtualMachine);
    procedure __TSlowColorLookupCreate(AMachine: TatVirtualMachine);
    procedure __TSlowColorLookupDestroy(AMachine: TatVirtualMachine);
    procedure __TSlowColorLookupLookup(AMachine: TatVirtualMachine);
    procedure __TNetscapeColorLookupCreate(AMachine: TatVirtualMachine);
    procedure __TNetscapeColorLookupLookup(AMachine: TatVirtualMachine);
    procedure __TGrayWindowsLookupCreate(AMachine: TatVirtualMachine);
    procedure __TGrayWindowsLookupLookup(AMachine: TatVirtualMachine);
    procedure __TGrayScaleLookupCreate(AMachine: TatVirtualMachine);
    procedure __TGrayScaleLookupLookup(AMachine: TatVirtualMachine);
    procedure __TMonochromeLookupCreate(AMachine: TatVirtualMachine);
    procedure __TMonochromeLookupLookup(AMachine: TatVirtualMachine);
    procedure __WebPalette(AMachine: TatVirtualMachine);
    procedure __ReduceColors(AMachine: TatVirtualMachine);
    procedure __CreateOptimizedPaletteFromManyBitmaps(AMachine: TatVirtualMachine);
    procedure __InternalGetDIBSizes(AMachine: TatVirtualMachine);
    procedure __InternalGetDIB(AMachine: TatVirtualMachine);
    procedure __Register(AMachine: TatVirtualMachine);
    procedure __GetCF_GIF(AMachine: TatVirtualMachine);
    procedure __SetCF_GIF(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultTransparent(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultTransparent(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultAnimate(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultAnimate(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultAnimationLoop(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultAnimationLoop(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultDithering(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultDithering(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultColorReduction(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultColorReduction(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultColorReductionBits(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultColorReductionBits(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultDitherMode(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultDitherMode(AMachine: TatVirtualMachine);
    procedure __GetGIFImageDefaultAnimationSpeed(AMachine: TatVirtualMachine);
    procedure __SetGIFImageDefaultAnimationSpeed(AMachine: TatVirtualMachine);
    procedure __GetDoAutoDither(AMachine: TatVirtualMachine);
    procedure __SetDoAutoDither(AMachine: TatVirtualMachine);
    procedure __GetPaletteDevice(AMachine: TatVirtualMachine);
    procedure __SetPaletteDevice(AMachine: TatVirtualMachine);
    procedure __GetGIFImageRenderOnLoad(AMachine: TatVirtualMachine);
    procedure __SetGIFImageRenderOnLoad(AMachine: TatVirtualMachine);
    procedure __GetGIFImageOptimizeOnStream(AMachine: TatVirtualMachine);
    procedure __SetGIFImageOptimizeOnStream(AMachine: TatVirtualMachine);
    procedure __GetBitmapAllocationThreshold(AMachine: TatVirtualMachine);
    procedure __SetBitmapAllocationThreshold(AMachine: TatVirtualMachine);
    procedure __GetGIFDelayExp(AMachine: TatVirtualMachine);
    procedure __SetGIFDelayExp(AMachine: TatVirtualMachine);
    procedure __GetGIFDefaultDelay(AMachine: TatVirtualMachine);
    procedure __SetGIFDefaultDelay(AMachine: TatVirtualMachine);
    procedure __GetGIFMinimumDelay(AMachine: TatVirtualMachine);
    procedure __SetGIFMinimumDelay(AMachine: TatVirtualMachine);
    procedure __GetGIFMaximumDelay(AMachine: TatVirtualMachine);
    procedure __SetGIFMaximumDelay(AMachine: TatVirtualMachine);
    procedure __GetGIFFileBufferSize(AMachine: TatVirtualMachine);
    procedure __SetGIFFileBufferSize(AMachine: TatVirtualMachine);
    procedure __GetGIFDefaultTransparentColor(AMachine: TatVirtualMachine);
    procedure __SetGIFDefaultTransparentColor(AMachine: TatVirtualMachine);
    procedure __GetGIFClearOnLoop(AMachine: TatVirtualMachine);
    procedure __SetGIFClearOnLoop(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  GIFExceptionClass = class of GIFException;
  TGIFItemClass = class of TGIFItem;
  TGIFListClass = class of TGIFList;
  TGIFColorMapClass = class of TGIFColorMap;
  TGIFHeaderClass = class of TGIFHeader;
  TGIFExtensionClass = class of TGIFExtension;
  TGIFExtensionListClass = class of TGIFExtensionList;
  TGIFFrameClass = class of TGIFFrame;
  TGIFTrailerClass = class of TGIFTrailer;
  TGIFGraphicControlExtensionClass = class of TGIFGraphicControlExtension;
  TGIFTextExtensionClass = class of TGIFTextExtension;
  TGIFCommentExtensionClass = class of TGIFCommentExtension;
  TGIFApplicationExtensionClass = class of TGIFApplicationExtension;
  TGIFBlockClass = class of TGIFBlock;
  TGIFUnknownAppExtensionClass = class of TGIFUnknownAppExtension;
  TGIFAppExtNSLoopClass = class of TGIFAppExtNSLoop;
  TGIFImageListClass = class of TGIFImageList;
  TGIFImageClass = class of TGIFImage;
  TCustomGIFRendererClass = class of TCustomGIFRenderer;
  TGIFRendererClass = class of TGIFRenderer;
  TColorLookupClass = class of TColorLookup;
  TFastColorLookupClass = class of TFastColorLookup;
  TSlowColorLookupClass = class of TSlowColorLookup;
  TNetscapeColorLookupClass = class of TNetscapeColorLookup;
  TGrayWindowsLookupClass = class of TGrayWindowsLookup;
  TGrayScaleLookupClass = class of TGrayScaleLookup;
  TMonochromeLookupClass = class of TMonochromeLookup;

  TatGIFImgDispatcher = class(TatEventDispatcher)
  private
    procedure __TGIFWarning( Sender: TObject;  Severity: TGIFSeverity; const Msg: string);
  end;

  TGIFColorWrapper = class(TatRecordWrapper)
  private
    FRed: byte;
    FGreen: byte;
    FBlue: byte;
  public
    constructor Create(ARecord: TGIFColor);
    function ObjToRec: TGIFColor;
  published
    property Red: byte read FRed write FRed;
    property Green: byte read FGreen write FGreen;
    property Blue: byte read FBlue write FBlue;
  end;
  
  TUsageCountWrapper = class(TatRecordWrapper)
  private
    FCount: integer;
    FIndex: integer;
  public
    constructor Create(ARecord: TUsageCount);
    function ObjToRec: TUsageCount;
  published
    property Count: integer read FCount write FCount;
    property Index: integer read FIndex write FIndex;
  end;
  
  TLogicalScreenDescriptorWrapper = class(TatRecordWrapper)
  private
    FScreenWidth: word;
    FScreenHeight: word;
    FPackedFields: byte;
    FBackgroundColorIndex: byte;
    FAspectRatio: byte;
  public
    constructor Create(ARecord: TLogicalScreenDescriptor);
    function ObjToRec: TLogicalScreenDescriptor;
  published
    property ScreenWidth: word read FScreenWidth write FScreenWidth;
    property ScreenHeight: word read FScreenHeight write FScreenHeight;
    property PackedFields: byte read FPackedFields write FPackedFields;
    property BackgroundColorIndex: byte read FBackgroundColorIndex write FBackgroundColorIndex;
    property AspectRatio: byte read FAspectRatio write FAspectRatio;
  end;
  
  TImageDescriptorWrapper = class(TatRecordWrapper)
  private
    FSeparator: byte;
    FLeft: word;
    FTop: word;
    FWidth: word;
    FHeight: word;
    FPackedFields: byte;
  public
    constructor Create(ARecord: TImageDescriptor);
    function ObjToRec: TImageDescriptor;
  published
    property Separator: byte read FSeparator write FSeparator;
    property Left: word read FLeft write FLeft;
    property Top: word read FTop write FTop;
    property Width: word read FWidth write FWidth;
    property Height: word read FHeight write FHeight;
    property PackedFields: byte read FPackedFields write FPackedFields;
  end;
  
  TGIFGCERecWrapper = class(TatRecordWrapper)
  private
    FBlockSize: byte;
    FPackedFields: Byte;
    FDelayTime: Word;
    FTransparentColorIndex: Byte;
    FTerminator: Byte;
  public
    constructor Create(ARecord: TGIFGCERec);
    function ObjToRec: TGIFGCERec;
  published
    property BlockSize: byte read FBlockSize write FBlockSize;
    property PackedFields: Byte read FPackedFields write FPackedFields;
    property DelayTime: Word read FDelayTime write FDelayTime;
    property TransparentColorIndex: Byte read FTransparentColorIndex write FTransparentColorIndex;
    property Terminator: Byte read FTerminator write FTerminator;
  end;
  
  TGIFPlainTextExtensionRecWrapper = class(TatRecordWrapper)
  private
    FBlockSize: byte;
    FLeft: Word;
    FTop: Word;
    FWidth: Word;
    FHeight: Word;
    FCellWidth: Byte;
    FCellHeight: Byte;
    FTextFGColorIndex: Byte;
    FTextBGColorIndex: Byte;
  public
    constructor Create(ARecord: TGIFPlainTextExtensionRec);
    function ObjToRec: TGIFPlainTextExtensionRec;
  published
    property BlockSize: byte read FBlockSize write FBlockSize;
    property Left: Word read FLeft write FLeft;
    property Top: Word read FTop write FTop;
    property Width: Word read FWidth write FWidth;
    property Height: Word read FHeight write FHeight;
    property CellWidth: Byte read FCellWidth write FCellWidth;
    property CellHeight: Byte read FCellHeight write FCellHeight;
    property TextFGColorIndex: Byte read FTextFGColorIndex write FTextFGColorIndex;
    property TextBGColorIndex: Byte read FTextBGColorIndex write FTextBGColorIndex;
  end;
  
  TGIFApplicationRecWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TGIFApplicationRec);
    function ObjToRec: TGIFApplicationRec;
  published
  end;
  

implementation

constructor TGIFColorWrapper.Create(ARecord: TGIFColor);
begin
  inherited Create;
  FRed := ARecord.Red;
  FGreen := ARecord.Green;
  FBlue := ARecord.Blue;
end;

function TGIFColorWrapper.ObjToRec: TGIFColor;
begin
  result.Red := FRed;
  result.Green := FGreen;
  result.Blue := FBlue;
end;

constructor TUsageCountWrapper.Create(ARecord: TUsageCount);
begin
  inherited Create;
  FCount := ARecord.Count;
  FIndex := ARecord.Index;
end;

function TUsageCountWrapper.ObjToRec: TUsageCount;
begin
  result.Count := FCount;
  result.Index := FIndex;
end;

constructor TLogicalScreenDescriptorWrapper.Create(ARecord: TLogicalScreenDescriptor);
begin
  inherited Create;
  FScreenWidth := ARecord.ScreenWidth;
  FScreenHeight := ARecord.ScreenHeight;
  FPackedFields := ARecord.PackedFields;
  FBackgroundColorIndex := ARecord.BackgroundColorIndex;
  FAspectRatio := ARecord.AspectRatio;
end;

function TLogicalScreenDescriptorWrapper.ObjToRec: TLogicalScreenDescriptor;
begin
  result.ScreenWidth := FScreenWidth;
  result.ScreenHeight := FScreenHeight;
  result.PackedFields := FPackedFields;
  result.BackgroundColorIndex := FBackgroundColorIndex;
  result.AspectRatio := FAspectRatio;
end;

constructor TImageDescriptorWrapper.Create(ARecord: TImageDescriptor);
begin
  inherited Create;
  FSeparator := ARecord.Separator;
  FLeft := ARecord.Left;
  FTop := ARecord.Top;
  FWidth := ARecord.Width;
  FHeight := ARecord.Height;
  FPackedFields := ARecord.PackedFields;
end;

function TImageDescriptorWrapper.ObjToRec: TImageDescriptor;
begin
  result.Separator := FSeparator;
  result.Left := FLeft;
  result.Top := FTop;
  result.Width := FWidth;
  result.Height := FHeight;
  result.PackedFields := FPackedFields;
end;

constructor TGIFGCERecWrapper.Create(ARecord: TGIFGCERec);
begin
  inherited Create;
  FBlockSize := ARecord.BlockSize;
  FPackedFields := ARecord.PackedFields;
  FDelayTime := ARecord.DelayTime;
  FTransparentColorIndex := ARecord.TransparentColorIndex;
  FTerminator := ARecord.Terminator;
end;

function TGIFGCERecWrapper.ObjToRec: TGIFGCERec;
begin
  result.BlockSize := FBlockSize;
  result.PackedFields := FPackedFields;
  result.DelayTime := FDelayTime;
  result.TransparentColorIndex := FTransparentColorIndex;
  result.Terminator := FTerminator;
end;

constructor TGIFPlainTextExtensionRecWrapper.Create(ARecord: TGIFPlainTextExtensionRec);
begin
  inherited Create;
  FBlockSize := ARecord.BlockSize;
  FLeft := ARecord.Left;
  FTop := ARecord.Top;
  FWidth := ARecord.Width;
  FHeight := ARecord.Height;
  FCellWidth := ARecord.CellWidth;
  FCellHeight := ARecord.CellHeight;
  FTextFGColorIndex := ARecord.TextFGColorIndex;
  FTextBGColorIndex := ARecord.TextBGColorIndex;
end;

function TGIFPlainTextExtensionRecWrapper.ObjToRec: TGIFPlainTextExtensionRec;
begin
  result.BlockSize := FBlockSize;
  result.Left := FLeft;
  result.Top := FTop;
  result.Width := FWidth;
  result.Height := FHeight;
  result.CellWidth := FCellWidth;
  result.CellHeight := FCellHeight;
  result.TextFGColorIndex := FTextFGColorIndex;
  result.TextBGColorIndex := FTextBGColorIndex;
end;

constructor TGIFApplicationRecWrapper.Create(ARecord: TGIFApplicationRec);
begin
  inherited Create;
end;

function TGIFApplicationRecWrapper.ObjToRec: TGIFApplicationRec;
begin
end;



procedure TatGIFImgLibrary.__TGIFItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFItemClass(CurrentClass.ClassRef).Create(TGIFImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFItemSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFItem(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFItemLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFItem(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFItemSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFItem(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__TGIFItemLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFItem(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFItemVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFItem(CurrentObject).Version);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFItemImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFItem(CurrentObject).Image));
  end;
end;

procedure TatGIFImgLibrary.__TGIFListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFListClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFList(CurrentObject).Add(TGIFItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFListClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Clear;
  end;
end;

procedure TatGIFImgLibrary.__TGIFListDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFListExchange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Exchange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFListFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFList(CurrentObject).First);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFListIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFList(CurrentObject).IndexOf(TGIFItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFListInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Insert(VarToInteger(GetInputArg(0)),TGIFItem(Integer(GetInputArg(1))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFListLast(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFList(CurrentObject).Last);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFListMove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Move(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFListRemove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFList(CurrentObject).Remove(TGIFItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFListSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFListLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TGIFItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFListCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFList(CurrentObject).Count));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFListList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFList(CurrentObject).List));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFListImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFList(CurrentObject).Image));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFColorMapClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapColor2RGB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGIFColorWrapper.Create(TGIFColorMapClass(CurrentClass.ClassRef).Color2RGB(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapRGB2Color(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TGIFColorMapClass(CurrentClass.ClassRef).RGB2Color(TGIFColorWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFColorMap(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFColorMap(CurrentObject).Add(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapAddUnique(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFColorMap(CurrentObject).AddUnique(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Clear;
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapOptimize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TGIFColorMap(CurrentObject).Optimize;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Changed;
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapImportPalette(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).ImportPalette(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapImportDIBColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).ImportDIBColors(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFColorMapExportPalette(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFColorMap(CurrentObject).ExportPalette);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFColorMapColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFColorMap(CurrentObject).Colors[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFColorMapColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Colors[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFColorMapCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFColorMap(CurrentObject).Count));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFColorMapOptimized(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFColorMap(CurrentObject).Optimized);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFColorMapOptimized(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFColorMap(CurrentObject).Optimized:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFColorMapBitsPerPixel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFColorMap(CurrentObject).BitsPerPixel));
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFHeaderClass(CurrentClass.ClassRef).Create(TGIFImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).Clear;
  end;
end;

procedure TatGIFImgLibrary.__TGIFHeaderPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).Prepare;
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFHeader(CurrentObject).Version);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).Width));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFHeaderWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).Width:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).Height));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFHeaderHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).Height:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderBackgroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).BackgroundColorIndex));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFHeaderBackgroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).BackgroundColorIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFHeader(CurrentObject).BackgroundColor);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFHeaderBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).BackgroundColor:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderAspectRatio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).AspectRatio));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFHeaderAspectRatio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFHeader(CurrentObject).AspectRatio:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).ColorMap));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderBitsPerPixel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).BitsPerPixel));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFHeaderColorResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFHeader(CurrentObject).ColorResolution));
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFExtensionClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtension(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtension(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtension(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtension(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFExtensionExtensionType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFExtension(CurrentObject).ExtensionType));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFExtensionFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFExtension(CurrentObject).Frame));
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFExtensionListClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionListAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtensionList(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFExtensionListLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtensionList(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFExtensionListExtensions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFExtensionList(CurrentObject).Extensions[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFExtensionListExtensions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFExtensionList(CurrentObject).Extensions[VarToInteger(GetArrayIndex(0))]:=TGIFExtension(Integer(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFExtensionListFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFExtensionList(CurrentObject).Frame));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFFrameClass(CurrentClass.ClassRef).Create(TGIFImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Clear;
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameDormant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Dormant;
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Draw(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameStretchDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).StretchDraw(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameCrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Crop;
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameMerge(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Merge(TGIFFrame(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFFrameScaleRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TGIFFrame(CurrentObject).ScaleRect(TRectWrapper(integer(GetInputArg(0))).ObjToRec)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameHasBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFFrame(CurrentObject).HasBitmap);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameHasBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).HasBitmap:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Left));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Left:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Top));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Top:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Width));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Width:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Height));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Height:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameBoundsRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TGIFFrame(CurrentObject).BoundsRect)));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameBoundsRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).BoundsRect:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameClientRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TGIFFrame(CurrentObject).ClientRect)));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameInterlaced(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFFrame(CurrentObject).Interlaced);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameInterlaced(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Interlaced:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).ColorMap));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameActiveColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).ActiveColorMap));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).DataSize));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameExtensions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Extensions));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFFrame(CurrentObject).Version);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameColorResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).ColorResolution));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameBitsPerPixel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).BitsPerPixel));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Bitmap));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFrameBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Bitmap:=TBitmap(Integer(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Mask));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFramePalette(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Palette));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFramePalette(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Palette:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameEmpty(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFFrame(CurrentObject).Empty);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFFrame(CurrentObject).Transparent);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFrameGraphicControlExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).GraphicControlExtension));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFFramePixels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFFrame(CurrentObject).Pixels[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFFramePixels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFFrame(CurrentObject).Pixels[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__TGIFTrailerSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTrailer(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFTrailerLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTrailer(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFGraphicControlExtensionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFGraphicControlExtensionClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFGraphicControlExtensionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFGraphicControlExtensionSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFGraphicControlExtensionLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFGraphicControlExtensionDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFGraphicControlExtension(CurrentObject).Delay));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFGraphicControlExtensionDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).Delay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFGraphicControlExtensionTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFGraphicControlExtension(CurrentObject).Transparent);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFGraphicControlExtensionTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).Transparent:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFGraphicControlExtensionTransparentColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFGraphicControlExtension(CurrentObject).TransparentColorIndex));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFGraphicControlExtensionTransparentColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).TransparentColorIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFGraphicControlExtensionTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFGraphicControlExtension(CurrentObject).TransparentColor);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFGraphicControlExtensionTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).TransparentColor:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFGraphicControlExtensionUserInput(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFGraphicControlExtension(CurrentObject).UserInput);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFGraphicControlExtensionUserInput(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).UserInput:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFGraphicControlExtensionDisposal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFGraphicControlExtension(CurrentObject).Disposal);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFGraphicControlExtensionDisposal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFGraphicControlExtension(CurrentObject).Disposal:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__TGIFTextExtensionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFTextExtensionClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFTextExtensionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFTextExtensionSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFTextExtensionLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).Left));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).Left:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).Top));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).Top:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionGridWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).GridWidth));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionGridWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).GridWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionGridHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).GridHeight));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionGridHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).GridHeight:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionCharWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).CharWidth));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionCharWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).CharWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionCharHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).CharHeight));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionCharHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).CharHeight:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionForegroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).ForegroundColorIndex));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionForegroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).ForegroundColorIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionForegroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFTextExtension(CurrentObject).ForegroundColor);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionBackgroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).BackgroundColorIndex));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionBackgroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).BackgroundColorIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFTextExtension(CurrentObject).BackgroundColor);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFTextExtensionText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFTextExtension(CurrentObject).Text));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFTextExtensionText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFTextExtension(CurrentObject).Text:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFCommentExtensionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFCommentExtensionClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFCommentExtensionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFCommentExtension(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFCommentExtensionSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFCommentExtension(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFCommentExtensionLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFCommentExtension(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFCommentExtensionText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFCommentExtension(CurrentObject).Text));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFCommentExtensionText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFCommentExtension(CurrentObject).Text:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFApplicationExtensionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFApplicationExtensionClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFApplicationExtensionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFApplicationExtension(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFApplicationExtensionSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFApplicationExtension(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFApplicationExtensionLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFApplicationExtension(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFApplicationExtensionIdentifier(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFApplicationExtension(CurrentObject).Identifier);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFApplicationExtensionIdentifier(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFApplicationExtension(CurrentObject).Identifier:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFApplicationExtensionAuthentication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFApplicationExtension(CurrentObject).Authentication);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFApplicationExtensionAuthentication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFApplicationExtension(CurrentObject).Authentication:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__TGIFBlockCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFBlockClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFBlockDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFBlock(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFBlockSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFBlock(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFBlockLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFBlock(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFBlockSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFBlock(CurrentObject).Size));
  end;
end;

procedure TatGIFImgLibrary.__TGIFUnknownAppExtensionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFUnknownAppExtensionClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFUnknownAppExtensionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFUnknownAppExtension(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFUnknownAppExtensionBlocks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFUnknownAppExtension(CurrentObject).Blocks));
  end;
end;

procedure TatGIFImgLibrary.__TGIFAppExtNSLoopCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFAppExtNSLoopClass(CurrentClass.ClassRef).Create(TGIFFrame(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFAppExtNSLoopLoops(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFAppExtNSLoop(CurrentObject).Loops));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFAppExtNSLoopLoops(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFAppExtNSLoop(CurrentObject).Loops:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFAppExtNSLoopBufferSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFAppExtNSLoop(CurrentObject).BufferSize));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFAppExtNSLoopBufferSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFAppExtNSLoop(CurrentObject).BufferSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFImageListClass(CurrentClass.ClassRef).Create(TGIFImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageListLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImageList(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageListSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImageList(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageListFrames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImageList(CurrentObject).Frames[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageListFrames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImageList(CurrentObject).Frames[VarToInteger(GetArrayIndex(0))]:=TGIFFrame(Integer(GetInputArg(0)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFImageClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageDormant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Dormant;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFImage(CurrentObject).Add(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFImagePack(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Pack;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageOptimizeColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).OptimizeColorMap;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageOptimize(AMachine: TatVirtualMachine);
  var
  Param0: TGIFOptimizeOptions;
begin
  with AMachine do
  begin
IntToSet(Param0, VarToInteger(GetInputArg(0)), SizeOf(Param0));
    Case InputArgCount of
      1: TGIFImage(CurrentObject).Optimize(Param0);
      2: TGIFImage(CurrentObject).Optimize(Param0,GetInputArg(1));
      3: TGIFImage(CurrentObject).Optimize(Param0,GetInputArg(1),GetInputArg(2));
      4: TGIFImage(CurrentObject).Optimize(Param0,GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)));
    end;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Clear;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageWarning(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Warning(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageLoadFromClipboardFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).LoadFromClipboardFormat(VarToInteger(GetInputArg(0)),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageSaveToClipboardFormat(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  Param1: THandle;
  Param2: HPALETTE;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
    TGIFImage(CurrentObject).SaveToClipboardFormat(Param0,Param1,Param2);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageEffectiveBackgroundColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TGIFImage(CurrentObject).EffectiveBackgroundColor;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageStopDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).StopDraw;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageSuspendDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).SuspendDraw;
  end;
end;

procedure TatGIFImgLibrary.__TGIFImageResumeDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).ResumeDraw;
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageGlobalColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).GlobalColorMap));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).Version);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).Images));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageColorResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).ColorResolution));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageBitsPerPixel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).BitsPerPixel));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageBackgroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).BackgroundColorIndex));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageBackgroundColorIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).BackgroundColorIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).BackgroundColor);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).BackgroundColor:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageAspectRatio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).AspectRatio));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageAspectRatio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).AspectRatio:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageIsTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).IsTransparent);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageDrawBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).DrawBackgroundColor);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageDrawBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).DrawBackgroundColor:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageColorReduction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).ColorReduction);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageColorReduction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).ColorReduction:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageReductionBits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).ReductionBits));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageReductionBits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).ReductionBits:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageDitherMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).DitherMode);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageDitherMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).DitherMode:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageAnimationSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).AnimationSpeed));
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageAnimationSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).AnimationSpeed:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFImage(CurrentObject).Bitmap));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).Animate);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Animate:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageAnimateLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).AnimateLoop);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageAnimateLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).AnimateLoop:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageDithering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).Dithering);
  end;
end;

procedure TatGIFImgLibrary.__SetTGIFImageDithering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFImage(CurrentObject).Dithering:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFImageShouldDither(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFImage(CurrentObject).ShouldDither);
  end;
end;

procedure TatGIFImgLibrary.__TCustomGIFRendererCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomGIFRendererClass(CurrentClass.ClassRef).Create(TGIFImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TCustomGIFRendererDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).Draw(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatGIFImgLibrary.__TCustomGIFRendererNextFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).NextFrame;
  end;
end;

procedure TatGIFImgLibrary.__TCustomGIFRendererStartAnimation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).StartAnimation;
  end;
end;

procedure TatGIFImgLibrary.__TCustomGIFRendererStopAnimation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).StopAnimation;
  end;
end;

procedure TatGIFImgLibrary.__TCustomGIFRendererHaltAnimation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).HaltAnimation;
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).Speed));
  end;
end;

procedure TatGIFImgLibrary.__SetTCustomGIFRendererSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).Speed:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomGIFRenderer(CurrentObject).Transparent);
  end;
end;

procedure TatGIFImgLibrary.__SetTCustomGIFRendererTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).Transparent:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomGIFRenderer(CurrentObject).BackgroundColor);
  end;
end;

procedure TatGIFImgLibrary.__SetTCustomGIFRendererBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).BackgroundColor:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomGIFRenderer(CurrentObject).Animate);
  end;
end;

procedure TatGIFImgLibrary.__SetTCustomGIFRendererAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).Animate:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererFrameIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).FrameIndex));
  end;
end;

procedure TatGIFImgLibrary.__SetTCustomGIFRendererFrameIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGIFRenderer(CurrentObject).FrameIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).Image));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererTargetCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).TargetCanvas));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererTargetRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TCustomGIFRenderer(CurrentObject).TargetRect)));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).Frame));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererLoopMax(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).LoopMax));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererLoopCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).LoopCount));
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererAnimating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomGIFRenderer(CurrentObject).Animating);
  end;
end;

procedure TatGIFImgLibrary.__GetTCustomGIFRendererBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGIFRenderer(CurrentObject).Bitmap));
  end;
end;

procedure TatGIFImgLibrary.__TGIFRendererCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGIFRendererClass(CurrentClass.ClassRef).Create(TGIFImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGIFRendererDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFRenderer(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TGIFRendererDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFRenderer(CurrentObject).Draw(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatGIFImgLibrary.__TGIFRendererStartAnimation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFRenderer(CurrentObject).StartAnimation;
  end;
end;

procedure TatGIFImgLibrary.__TGIFRendererStopAnimation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFRenderer(CurrentObject).StopAnimation;
  end;
end;

procedure TatGIFImgLibrary.__TGIFRendererHaltAnimation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGIFRenderer(CurrentObject).HaltAnimation;
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFRendererBackground(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFRenderer(CurrentObject).Background));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFRendererFrameDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFRenderer(CurrentObject).FrameDelay));
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFRendererDisposal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFRenderer(CurrentObject).Disposal);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFRendererPrevDisposal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGIFRenderer(CurrentObject).PrevDisposal);
  end;
end;

procedure TatGIFImgLibrary.__GetTGIFRendererPrevFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGIFRenderer(CurrentObject).PrevFrame));
  end;
end;

procedure TatGIFImgLibrary.__TColorLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColorLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TColorLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TColorLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgLibrary.__GetTColorLookupColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TColorLookup(CurrentObject).Colors));
  end;
end;

procedure TatGIFImgLibrary.__TFastColorLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFastColorLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TFastColorLookupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFastColorLookup(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TFastColorLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TFastColorLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgLibrary.__TSlowColorLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSlowColorLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TSlowColorLookupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSlowColorLookup(CurrentObject).Destroy;
  end;
end;

procedure TatGIFImgLibrary.__TSlowColorLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TSlowColorLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgLibrary.__TNetscapeColorLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TNetscapeColorLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TNetscapeColorLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TNetscapeColorLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgLibrary.__TGrayWindowsLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGrayWindowsLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGrayWindowsLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TGrayWindowsLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgLibrary.__TGrayScaleLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGrayScaleLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TGrayScaleLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TGrayScaleLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgLibrary.__TMonochromeLookupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMonochromeLookupClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__TMonochromeLookupLookup(AMachine: TatVirtualMachine);
  var
  Param3: BYTE;
  Param4: BYTE;
  Param5: BYTE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(TMonochromeLookup(CurrentObject).Lookup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatGIFImgDispatcher.__TGIFWarning( Sender: TObject;  Severity: TGIFSeverity; const Msg: string);
var
  SeverityTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGIFWarning(BeforeCall)(Sender,Severity,Msg);
    SeverityTemp := Severity;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,SeverityTemp,Msg]);
    if AssignedMethod(AfterCall) then
      TGIFWarning(AfterCall)(Sender,Severity,Msg);
  end;
end;

procedure TatGIFImgLibrary.__WebPalette(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(GIFImg.WebPalette);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__ReduceColors(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(GIFImg.ReduceColors(TBitmap(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__CreateOptimizedPaletteFromManyBitmaps(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(GIFImg.CreateOptimizedPaletteFromManyBitmaps(TList(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGIFImgLibrary.__InternalGetDIBSizes(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  Param2: longInt;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
    GIFImg.InternalGetDIBSizes(VarToInteger(GetInputArg(0)),Param1,Param2,GetInputArg(3));
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatGIFImgLibrary.__InternalGetDIB(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
Param3 := GetInputArg(3);
AResult := GIFImg.InternalGetDIB(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,Param3,GetInputArg(4));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
    SetInputArg(3,Param3);
  end;
end;

procedure TatGIFImgLibrary.__Register(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.Register;
  end;
end;

procedure TatGIFImgLibrary.__GetCF_GIF(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.CF_GIF));
  end;
end;

procedure TatGIFImgLibrary.__SetCF_GIF(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.CF_GIF:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageDefaultTransparent);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultTransparent:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageDefaultAnimate);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultAnimate:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultAnimationLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageDefaultAnimationLoop);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultAnimationLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultAnimationLoop:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultDithering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageDefaultDithering);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultDithering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultDithering:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultColorReduction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageDefaultColorReduction);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultColorReduction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultColorReduction:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultColorReductionBits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFImageDefaultColorReductionBits));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultColorReductionBits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultColorReductionBits:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultDitherMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageDefaultDitherMode);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultDitherMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultDitherMode:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageDefaultAnimationSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFImageDefaultAnimationSpeed));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageDefaultAnimationSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageDefaultAnimationSpeed:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetDoAutoDither(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.DoAutoDither);
  end;
end;

procedure TatGIFImgLibrary.__SetDoAutoDither(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.DoAutoDither:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetPaletteDevice(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.PaletteDevice);
  end;
end;

procedure TatGIFImgLibrary.__SetPaletteDevice(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.PaletteDevice:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageRenderOnLoad(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageRenderOnLoad);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageRenderOnLoad(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageRenderOnLoad:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFImageOptimizeOnStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFImageOptimizeOnStream);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFImageOptimizeOnStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFImageOptimizeOnStream:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetBitmapAllocationThreshold(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.BitmapAllocationThreshold));
  end;
end;

procedure TatGIFImgLibrary.__SetBitmapAllocationThreshold(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.BitmapAllocationThreshold:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFDelayExp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFDelayExp));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFDelayExp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFDelayExp:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFDefaultDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFDefaultDelay));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFDefaultDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFDefaultDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFMinimumDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFMinimumDelay));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFMinimumDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFMinimumDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFMaximumDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFMaximumDelay));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFMaximumDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFMaximumDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFFileBufferSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(GIFImg.GIFFileBufferSize));
  end;
end;

procedure TatGIFImgLibrary.__SetGIFFileBufferSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFFileBufferSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGIFImgLibrary.__GetGIFDefaultTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFDefaultTransparentColor);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFDefaultTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFDefaultTransparentColor:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.__GetGIFClearOnLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(GIFImg.GIFClearOnLoop);
  end;
end;

procedure TatGIFImgLibrary.__SetGIFClearOnLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GIFImg.GIFClearOnLoop:=GetInputArg(0);
  end;
end;

procedure TatGIFImgLibrary.Init;
begin
  With Scripter.DefineClass(GIFException) do
  begin
  end;
  With Scripter.DefineClass(TGIFItem) do
  begin
    DefineMethod('Create',1,tkClass,TGIFItem,__TGIFItemCreate,true,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFItemSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFItemLoadFromStream,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TGIFItemSaveToFile,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TGIFItemLoadFromFile,false,0);
    DefineProp('Version',tkEnumeration,__GetTGIFItemVersion,nil,nil,false,0);
    DefineProp('Image',tkClass,__GetTGIFItemImage,nil,TGIFImage,false,0);
  end;
  With Scripter.DefineClass(TGIFList) do
  begin
    DefineMethod('Create',0,tkClass,TGIFList,__TGIFListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFListDestroy,false,0);
    DefineMethod('Add',1,tkInteger,nil,__TGIFListAdd,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TGIFListClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TGIFListDelete,false,0);
    DefineMethod('Exchange',2,tkNone,nil,__TGIFListExchange,false,0);
    DefineMethod('First',0,tkClass,TGIFItem,__TGIFListFirst,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TGIFListIndexOf,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TGIFListInsert,false,0);
    DefineMethod('Last',0,tkClass,TGIFItem,__TGIFListLast,false,0);
    DefineMethod('Move',2,tkNone,nil,__TGIFListMove,false,0);
    DefineMethod('Remove',1,tkInteger,nil,__TGIFListRemove,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFListSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFListLoadFromStream,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTGIFListItems,__SetTGIFListItems,TGIFItem,false,1);
    DefineProp('Count',tkInteger,__GetTGIFListCount,nil,nil,false,0);
    DefineProp('List',tkClass,__GetTGIFListList,nil,TList,false,0);
    DefineProp('Image',tkClass,__GetTGIFListImage,nil,TGIFImage,false,0);
  end;
  With Scripter.DefineClass(TGIFColorMap) do
  begin
    DefineMethod('Create',0,tkClass,TGIFColorMap,__TGIFColorMapCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFColorMapDestroy,false,0);
    DefineMethod('Color2RGB',1,tkVariant,nil,__TGIFColorMapColor2RGB,true,0);
    DefineMethod('RGB2Color',1,tkEnumeration,nil,__TGIFColorMapRGB2Color,true,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFColorMapSaveToStream,false,0);
    DefineMethod('LoadFromStream',2,tkNone,nil,__TGIFColorMapLoadFromStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TGIFColorMapAssign,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TGIFColorMapIndexOf,false,0);
    DefineMethod('Add',1,tkInteger,nil,__TGIFColorMapAdd,false,0);
    DefineMethod('AddUnique',1,tkInteger,nil,__TGIFColorMapAddUnique,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TGIFColorMapDelete,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TGIFColorMapClear,false,0);
    DefineMethod('Optimize',0,tkVariant,nil,__TGIFColorMapOptimize,false,0);
    DefineMethod('Changed',0,tkNone,nil,__TGIFColorMapChanged,false,0);
    DefineMethod('ImportPalette',1,tkNone,nil,__TGIFColorMapImportPalette,false,0);
    DefineMethod('ImportDIBColors',1,tkNone,nil,__TGIFColorMapImportDIBColors,false,0);
    DefineMethod('ExportPalette',0,tkInteger,nil,__TGIFColorMapExportPalette,false,0);
    DefaultProperty := DefineProp('Colors',tkEnumeration,__GetTGIFColorMapColors,__SetTGIFColorMapColors,nil,false,1);
    DefineProp('Count',tkInteger,__GetTGIFColorMapCount,nil,nil,false,0);
    DefineProp('Optimized',tkVariant,__GetTGIFColorMapOptimized,__SetTGIFColorMapOptimized,nil,false,0);
    DefineProp('BitsPerPixel',tkInteger,__GetTGIFColorMapBitsPerPixel,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TGIFHeader) do
  begin
    DefineMethod('Create',1,tkClass,TGIFHeader,__TGIFHeaderCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFHeaderDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TGIFHeaderAssign,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFHeaderSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFHeaderLoadFromStream,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TGIFHeaderClear,false,0);
    DefineMethod('Prepare',0,tkNone,nil,__TGIFHeaderPrepare,false,0);
    DefineProp('Version',tkEnumeration,__GetTGIFHeaderVersion,nil,nil,false,0);
    DefineProp('Width',tkInteger,__GetTGIFHeaderWidth,__SetTGIFHeaderWidth,nil,false,0);
    DefineProp('Height',tkInteger,__GetTGIFHeaderHeight,__SetTGIFHeaderHeight,nil,false,0);
    DefineProp('BackgroundColorIndex',tkInteger,__GetTGIFHeaderBackgroundColorIndex,__SetTGIFHeaderBackgroundColorIndex,nil,false,0);
    DefineProp('BackgroundColor',tkEnumeration,__GetTGIFHeaderBackgroundColor,__SetTGIFHeaderBackgroundColor,nil,false,0);
    DefineProp('AspectRatio',tkInteger,__GetTGIFHeaderAspectRatio,__SetTGIFHeaderAspectRatio,nil,false,0);
    DefineProp('ColorMap',tkClass,__GetTGIFHeaderColorMap,nil,TGIFColorMap,false,0);
    DefineProp('BitsPerPixel',tkInteger,__GetTGIFHeaderBitsPerPixel,nil,nil,false,0);
    DefineProp('ColorResolution',tkInteger,__GetTGIFHeaderColorResolution,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TGIFExtension) do
  begin
    DefineMethod('Create',1,tkClass,TGIFExtension,__TGIFExtensionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFExtensionDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TGIFExtensionAssign,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFExtensionSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFExtensionLoadFromStream,false,0);
    DefineProp('ExtensionType',tkInteger,__GetTGIFExtensionExtensionType,nil,nil,false,0);
    DefineProp('Frame',tkClass,__GetTGIFExtensionFrame,nil,TGIFFrame,false,0);
  end;
  With Scripter.DefineClass(TGIFExtensionList) do
  begin
    DefineMethod('Create',1,tkClass,TGIFExtensionList,__TGIFExtensionListCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TGIFExtensionListAssign,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFExtensionListLoadFromStream,false,0);
    DefaultProperty := DefineProp('Extensions',tkClass,__GetTGIFExtensionListExtensions,__SetTGIFExtensionListExtensions,TGIFExtension,false,1);
    DefineProp('Frame',tkClass,__GetTGIFExtensionListFrame,nil,TGIFFrame,false,0);
  end;
  With Scripter.DefineClass(TGIFFrame) do
  begin
    DefineMethod('Create',1,tkClass,TGIFFrame,__TGIFFrameCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFFrameDestroy,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TGIFFrameClear,false,0);
    DefineMethod('Dormant',0,tkNone,nil,__TGIFFrameDormant,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFFrameSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFFrameLoadFromStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TGIFFrameAssign,false,0);
    DefineMethod('Draw',4,tkNone,nil,__TGIFFrameDraw,false,0);
    DefineMethod('StretchDraw',4,tkNone,nil,__TGIFFrameStretchDraw,false,0);
    DefineMethod('Crop',0,tkNone,nil,__TGIFFrameCrop,false,0);
    DefineMethod('Merge',1,tkNone,nil,__TGIFFrameMerge,false,0);
    DefineMethod('ScaleRect',1,tkVariant,nil,__TGIFFrameScaleRect,false,0);
    DefineProp('HasBitmap',tkVariant,__GetTGIFFrameHasBitmap,__SetTGIFFrameHasBitmap,nil,false,0);
    DefineProp('Left',tkInteger,__GetTGIFFrameLeft,__SetTGIFFrameLeft,nil,false,0);
    DefineProp('Top',tkInteger,__GetTGIFFrameTop,__SetTGIFFrameTop,nil,false,0);
    DefineProp('Width',tkInteger,__GetTGIFFrameWidth,__SetTGIFFrameWidth,nil,false,0);
    DefineProp('Height',tkInteger,__GetTGIFFrameHeight,__SetTGIFFrameHeight,nil,false,0);
    DefineProp('BoundsRect',tkVariant,__GetTGIFFrameBoundsRect,__SetTGIFFrameBoundsRect,nil,false,0);
    DefineProp('ClientRect',tkVariant,__GetTGIFFrameClientRect,nil,nil,false,0);
    DefineProp('Interlaced',tkVariant,__GetTGIFFrameInterlaced,__SetTGIFFrameInterlaced,nil,false,0);
    DefineProp('ColorMap',tkClass,__GetTGIFFrameColorMap,nil,TGIFColorMap,false,0);
    DefineProp('ActiveColorMap',tkClass,__GetTGIFFrameActiveColorMap,nil,TGIFColorMap,false,0);
    DefineProp('DataSize',tkInteger,__GetTGIFFrameDataSize,nil,nil,false,0);
    DefineProp('Extensions',tkClass,__GetTGIFFrameExtensions,nil,TGIFExtensionList,false,0);
    DefineProp('Version',tkEnumeration,__GetTGIFFrameVersion,nil,nil,false,0);
    DefineProp('ColorResolution',tkInteger,__GetTGIFFrameColorResolution,nil,nil,false,0);
    DefineProp('BitsPerPixel',tkInteger,__GetTGIFFrameBitsPerPixel,nil,nil,false,0);
    DefineProp('Bitmap',tkClass,__GetTGIFFrameBitmap,__SetTGIFFrameBitmap,TBitmap,false,0);
    DefineProp('Mask',tkInteger,__GetTGIFFrameMask,nil,nil,false,0);
    DefineProp('Palette',tkInteger,__GetTGIFFramePalette,__SetTGIFFramePalette,nil,false,0);
    DefineProp('Empty',tkVariant,__GetTGIFFrameEmpty,nil,nil,false,0);
    DefineProp('Transparent',tkVariant,__GetTGIFFrameTransparent,nil,nil,false,0);
    DefineProp('GraphicControlExtension',tkClass,__GetTGIFFrameGraphicControlExtension,nil,TGIFGraphicControlExtension,false,0);
    DefineProp('Pixels',tkInteger,__GetTGIFFramePixels,__SetTGIFFramePixels,nil,false,2);
  end;
  With Scripter.DefineClass(TGIFTrailer) do
  begin
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFTrailerSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFTrailerLoadFromStream,false,0);
  end;
  With Scripter.DefineClass(TGIFGraphicControlExtension) do
  begin
    DefineMethod('Create',1,tkClass,TGIFGraphicControlExtension,__TGIFGraphicControlExtensionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFGraphicControlExtensionDestroy,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFGraphicControlExtensionSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFGraphicControlExtensionLoadFromStream,false,0);
    DefineProp('Delay',tkInteger,__GetTGIFGraphicControlExtensionDelay,__SetTGIFGraphicControlExtensionDelay,nil,false,0);
    DefineProp('Transparent',tkVariant,__GetTGIFGraphicControlExtensionTransparent,__SetTGIFGraphicControlExtensionTransparent,nil,false,0);
    DefineProp('TransparentColorIndex',tkInteger,__GetTGIFGraphicControlExtensionTransparentColorIndex,__SetTGIFGraphicControlExtensionTransparentColorIndex,nil,false,0);
    DefineProp('TransparentColor',tkEnumeration,__GetTGIFGraphicControlExtensionTransparentColor,__SetTGIFGraphicControlExtensionTransparentColor,nil,false,0);
    DefineProp('UserInput',tkVariant,__GetTGIFGraphicControlExtensionUserInput,__SetTGIFGraphicControlExtensionUserInput,nil,false,0);
    DefineProp('Disposal',tkEnumeration,__GetTGIFGraphicControlExtensionDisposal,__SetTGIFGraphicControlExtensionDisposal,nil,false,0);
  end;
  With Scripter.DefineClass(TGIFTextExtension) do
  begin
    DefineMethod('Create',1,tkClass,TGIFTextExtension,__TGIFTextExtensionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFTextExtensionDestroy,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFTextExtensionSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFTextExtensionLoadFromStream,false,0);
    DefineProp('Left',tkInteger,__GetTGIFTextExtensionLeft,__SetTGIFTextExtensionLeft,nil,false,0);
    DefineProp('Top',tkInteger,__GetTGIFTextExtensionTop,__SetTGIFTextExtensionTop,nil,false,0);
    DefineProp('GridWidth',tkInteger,__GetTGIFTextExtensionGridWidth,__SetTGIFTextExtensionGridWidth,nil,false,0);
    DefineProp('GridHeight',tkInteger,__GetTGIFTextExtensionGridHeight,__SetTGIFTextExtensionGridHeight,nil,false,0);
    DefineProp('CharWidth',tkInteger,__GetTGIFTextExtensionCharWidth,__SetTGIFTextExtensionCharWidth,nil,false,0);
    DefineProp('CharHeight',tkInteger,__GetTGIFTextExtensionCharHeight,__SetTGIFTextExtensionCharHeight,nil,false,0);
    DefineProp('ForegroundColorIndex',tkInteger,__GetTGIFTextExtensionForegroundColorIndex,__SetTGIFTextExtensionForegroundColorIndex,nil,false,0);
    DefineProp('ForegroundColor',tkEnumeration,__GetTGIFTextExtensionForegroundColor,nil,nil,false,0);
    DefineProp('BackgroundColorIndex',tkInteger,__GetTGIFTextExtensionBackgroundColorIndex,__SetTGIFTextExtensionBackgroundColorIndex,nil,false,0);
    DefineProp('BackgroundColor',tkEnumeration,__GetTGIFTextExtensionBackgroundColor,nil,nil,false,0);
    DefineProp('Text',tkClass,__GetTGIFTextExtensionText,__SetTGIFTextExtensionText,TStrings,false,0);
  end;
  With Scripter.DefineClass(TGIFCommentExtension) do
  begin
    DefineMethod('Create',1,tkClass,TGIFCommentExtension,__TGIFCommentExtensionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFCommentExtensionDestroy,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFCommentExtensionSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFCommentExtensionLoadFromStream,false,0);
    DefineProp('Text',tkClass,__GetTGIFCommentExtensionText,__SetTGIFCommentExtensionText,TStrings,false,0);
  end;
  With Scripter.DefineClass(TGIFApplicationExtension) do
  begin
    DefineMethod('Create',1,tkClass,TGIFApplicationExtension,__TGIFApplicationExtensionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFApplicationExtensionDestroy,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFApplicationExtensionSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFApplicationExtensionLoadFromStream,false,0);
    DefineProp('Identifier',tkVariant,__GetTGIFApplicationExtensionIdentifier,__SetTGIFApplicationExtensionIdentifier,nil,false,0);
    DefineProp('Authentication',tkVariant,__GetTGIFApplicationExtensionAuthentication,__SetTGIFApplicationExtensionAuthentication,nil,false,0);
  end;
  With Scripter.DefineClass(TGIFBlock) do
  begin
    DefineMethod('Create',1,tkClass,TGIFBlock,__TGIFBlockCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFBlockDestroy,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFBlockSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFBlockLoadFromStream,false,0);
    DefineProp('Size',tkInteger,__GetTGIFBlockSize,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TGIFUnknownAppExtension) do
  begin
    DefineMethod('Create',1,tkClass,TGIFUnknownAppExtension,__TGIFUnknownAppExtensionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFUnknownAppExtensionDestroy,false,0);
    DefineProp('Blocks',tkClass,__GetTGIFUnknownAppExtensionBlocks,nil,TList,false,0);
  end;
  With Scripter.DefineClass(TGIFAppExtNSLoop) do
  begin
    DefineMethod('Create',1,tkClass,TGIFAppExtNSLoop,__TGIFAppExtNSLoopCreate,true,0);
    DefineProp('Loops',tkInteger,__GetTGIFAppExtNSLoopLoops,__SetTGIFAppExtNSLoopLoops,nil,false,0);
    DefineProp('BufferSize',tkInteger,__GetTGIFAppExtNSLoopBufferSize,__SetTGIFAppExtNSLoopBufferSize,nil,false,0);
  end;
  With Scripter.DefineClass(TGIFImageList) do
  begin
    DefineMethod('Create',1,tkClass,TGIFImageList,__TGIFImageListCreate,true,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFImageListLoadFromStream,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFImageListSaveToStream,false,0);
    DefaultProperty := DefineProp('Frames',tkClass,__GetTGIFImageListFrames,__SetTGIFImageListFrames,TGIFFrame,false,1);
  end;
  With Scripter.DefineClass(TGIFImage) do
  begin
    DefineMethod('Create',0,tkClass,TGIFImage,__TGIFImageCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFImageDestroy,false,0);
    DefineMethod('Dormant',0,tkNone,nil,__TGIFImageDormant,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TGIFImageSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TGIFImageLoadFromStream,false,0);
    DefineMethod('Add',1,tkClass,TGIFFrame,__TGIFImageAdd,false,0);
    DefineMethod('Pack',0,tkNone,nil,__TGIFImagePack,false,0);
    DefineMethod('OptimizeColorMap',0,tkNone,nil,__TGIFImageOptimizeColorMap,false,0);
    DefineMethod('Optimize',4,tkNone,nil,__TGIFImageOptimize,false,3);
    DefineMethod('Clear',0,tkNone,nil,__TGIFImageClear,false,0);
    DefineMethod('Warning',3,tkNone,nil,__TGIFImageWarning,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TGIFImageAssign,false,0);
    DefineMethod('LoadFromClipboardFormat',3,tkNone,nil,__TGIFImageLoadFromClipboardFormat,false,0);
    DefineMethod('SaveToClipboardFormat',3,tkNone,nil,__TGIFImageSaveToClipboardFormat,false,0).SetVarArgs([0,1,2]);
    DefineMethod('EffectiveBackgroundColor',0,tkEnumeration,nil,__TGIFImageEffectiveBackgroundColor,false,0);
    DefineMethod('StopDraw',0,tkNone,nil,__TGIFImageStopDraw,false,0);
    DefineMethod('SuspendDraw',0,tkNone,nil,__TGIFImageSuspendDraw,false,0);
    DefineMethod('ResumeDraw',0,tkNone,nil,__TGIFImageResumeDraw,false,0);
    DefineProp('GlobalColorMap',tkClass,__GetTGIFImageGlobalColorMap,nil,TGIFColorMap,false,0);
    DefineProp('Version',tkEnumeration,__GetTGIFImageVersion,nil,nil,false,0);
    DefineProp('Images',tkClass,__GetTGIFImageImages,nil,TGIFImageList,false,0);
    DefineProp('ColorResolution',tkInteger,__GetTGIFImageColorResolution,nil,nil,false,0);
    DefineProp('BitsPerPixel',tkInteger,__GetTGIFImageBitsPerPixel,nil,nil,false,0);
    DefineProp('BackgroundColorIndex',tkInteger,__GetTGIFImageBackgroundColorIndex,__SetTGIFImageBackgroundColorIndex,nil,false,0);
    DefineProp('BackgroundColor',tkEnumeration,__GetTGIFImageBackgroundColor,__SetTGIFImageBackgroundColor,nil,false,0);
    DefineProp('AspectRatio',tkInteger,__GetTGIFImageAspectRatio,__SetTGIFImageAspectRatio,nil,false,0);
    DefineProp('IsTransparent',tkVariant,__GetTGIFImageIsTransparent,nil,nil,false,0);
    DefineProp('DrawBackgroundColor',tkEnumeration,__GetTGIFImageDrawBackgroundColor,__SetTGIFImageDrawBackgroundColor,nil,false,0);
    DefineProp('ColorReduction',tkEnumeration,__GetTGIFImageColorReduction,__SetTGIFImageColorReduction,nil,false,0);
    DefineProp('ReductionBits',tkInteger,__GetTGIFImageReductionBits,__SetTGIFImageReductionBits,nil,false,0);
    DefineProp('DitherMode',tkEnumeration,__GetTGIFImageDitherMode,__SetTGIFImageDitherMode,nil,false,0);
    DefineProp('AnimationSpeed',tkInteger,__GetTGIFImageAnimationSpeed,__SetTGIFImageAnimationSpeed,nil,false,0);
    DefineProp('Bitmap',tkClass,__GetTGIFImageBitmap,nil,TBitmap,false,0);
    DefineProp('Animate',tkVariant,__GetTGIFImageAnimate,__SetTGIFImageAnimate,nil,false,0);
    DefineProp('AnimateLoop',tkEnumeration,__GetTGIFImageAnimateLoop,__SetTGIFImageAnimateLoop,nil,false,0);
    DefineProp('Dithering',tkEnumeration,__GetTGIFImageDithering,__SetTGIFImageDithering,nil,false,0);
    DefineProp('ShouldDither',tkVariant,__GetTGIFImageShouldDither,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomGIFRenderer) do
  begin
    DefineMethod('Create',1,tkClass,TCustomGIFRenderer,__TCustomGIFRendererCreate,true,0);
    DefineMethod('Draw',2,tkNone,nil,__TCustomGIFRendererDraw,false,0);
    DefineMethod('NextFrame',0,tkNone,nil,__TCustomGIFRendererNextFrame,false,0);
    DefineMethod('StartAnimation',0,tkNone,nil,__TCustomGIFRendererStartAnimation,false,0);
    DefineMethod('StopAnimation',0,tkNone,nil,__TCustomGIFRendererStopAnimation,false,0);
    DefineMethod('HaltAnimation',0,tkNone,nil,__TCustomGIFRendererHaltAnimation,false,0);
    DefineProp('Speed',tkInteger,__GetTCustomGIFRendererSpeed,__SetTCustomGIFRendererSpeed,nil,false,0);
    DefineProp('Transparent',tkVariant,__GetTCustomGIFRendererTransparent,__SetTCustomGIFRendererTransparent,nil,false,0);
    DefineProp('BackgroundColor',tkEnumeration,__GetTCustomGIFRendererBackgroundColor,__SetTCustomGIFRendererBackgroundColor,nil,false,0);
    DefineProp('Animate',tkVariant,__GetTCustomGIFRendererAnimate,__SetTCustomGIFRendererAnimate,nil,false,0);
    DefineProp('FrameIndex',tkInteger,__GetTCustomGIFRendererFrameIndex,__SetTCustomGIFRendererFrameIndex,nil,false,0);
    DefineProp('Image',tkClass,__GetTCustomGIFRendererImage,nil,TGIFImage,false,0);
    DefineProp('TargetCanvas',tkClass,__GetTCustomGIFRendererTargetCanvas,nil,TCanvas,false,0);
    DefineProp('TargetRect',tkVariant,__GetTCustomGIFRendererTargetRect,nil,nil,false,0);
    DefineProp('Frame',tkClass,__GetTCustomGIFRendererFrame,nil,TGIFFrame,false,0);
    DefineProp('LoopMax',tkInteger,__GetTCustomGIFRendererLoopMax,nil,nil,false,0);
    DefineProp('LoopCount',tkInteger,__GetTCustomGIFRendererLoopCount,nil,nil,false,0);
    DefineProp('Animating',tkVariant,__GetTCustomGIFRendererAnimating,nil,nil,false,0);
    DefineProp('Bitmap',tkClass,__GetTCustomGIFRendererBitmap,nil,TBitmap,false,0);
  end;
  With Scripter.DefineClass(TGIFRenderer) do
  begin
    DefineMethod('Create',1,tkClass,TGIFRenderer,__TGIFRendererCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGIFRendererDestroy,false,0);
    DefineMethod('Draw',2,tkNone,nil,__TGIFRendererDraw,false,0);
    DefineMethod('StartAnimation',0,tkNone,nil,__TGIFRendererStartAnimation,false,0);
    DefineMethod('StopAnimation',0,tkNone,nil,__TGIFRendererStopAnimation,false,0);
    DefineMethod('HaltAnimation',0,tkNone,nil,__TGIFRendererHaltAnimation,false,0);
    DefineProp('Background',tkClass,__GetTGIFRendererBackground,nil,TBitmap,false,0);
    DefineProp('FrameDelay',tkInteger,__GetTGIFRendererFrameDelay,nil,nil,false,0);
    DefineProp('Disposal',tkEnumeration,__GetTGIFRendererDisposal,nil,nil,false,0);
    DefineProp('PrevDisposal',tkEnumeration,__GetTGIFRendererPrevDisposal,nil,nil,false,0);
    DefineProp('PrevFrame',tkClass,__GetTGIFRendererPrevFrame,nil,TGIFFrame,false,0);
  end;
  With Scripter.DefineClass(TColorLookup) do
  begin
    DefineMethod('Create',1,tkClass,TColorLookup,__TColorLookupCreate,true,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TColorLookupLookup,false,0).SetVarArgs([3,4,5]);
    DefineProp('Colors',tkInteger,__GetTColorLookupColors,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TFastColorLookup) do
  begin
    DefineMethod('Create',1,tkClass,TFastColorLookup,__TFastColorLookupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFastColorLookupDestroy,false,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TFastColorLookupLookup,false,0).SetVarArgs([3,4,5]);
  end;
  With Scripter.DefineClass(TSlowColorLookup) do
  begin
    DefineMethod('Create',1,tkClass,TSlowColorLookup,__TSlowColorLookupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSlowColorLookupDestroy,false,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TSlowColorLookupLookup,false,0).SetVarArgs([3,4,5]);
  end;
  With Scripter.DefineClass(TNetscapeColorLookup) do
  begin
    DefineMethod('Create',1,tkClass,TNetscapeColorLookup,__TNetscapeColorLookupCreate,true,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TNetscapeColorLookupLookup,false,0).SetVarArgs([3,4,5]);
  end;
  With Scripter.DefineClass(TGrayWindowsLookup) do
  begin
    DefineMethod('Create',1,tkClass,TGrayWindowsLookup,__TGrayWindowsLookupCreate,true,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TGrayWindowsLookupLookup,false,0).SetVarArgs([3,4,5]);
  end;
  With Scripter.DefineClass(TGrayScaleLookup) do
  begin
    DefineMethod('Create',1,tkClass,TGrayScaleLookup,__TGrayScaleLookupCreate,true,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TGrayScaleLookupLookup,false,0).SetVarArgs([3,4,5]);
  end;
  With Scripter.DefineClass(TMonochromeLookup) do
  begin
    DefineMethod('Create',1,tkClass,TMonochromeLookup,__TMonochromeLookupCreate,true,0);
    DefineMethod('Lookup',6,tkInteger,nil,__TMonochromeLookupLookup,false,0).SetVarArgs([3,4,5]);
  end;
  DefineEventAdapter(TypeInfo(TGIFWarning), TatGIFImgDispatcher, @TatGIFImgDispatcher.__TGIFWarning);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('WebPalette',0,tkInteger,nil,__WebPalette,false,0);
    DefineMethod('ReduceColors',5,tkClass,TBitmap,__ReduceColors,false,0);
    DefineMethod('CreateOptimizedPaletteFromManyBitmaps',4,tkInteger,nil,__CreateOptimizedPaletteFromManyBitmaps,false,0);
    DefineMethod('InternalGetDIBSizes',4,tkNone,nil,__InternalGetDIBSizes,false,0).SetVarArgs([1,2]);
    DefineMethod('InternalGetDIB',5,tkVariant,nil,__InternalGetDIB,false,0).SetVarArgs([2,3]);
    DefineMethod('Register',0,tkNone,nil,__Register,false,0);
    DefineProp('CF_GIF',tkInteger,__GetCF_GIF,__SetCF_GIF,nil,false,0);
    DefineProp('GIFImageDefaultTransparent',tkVariant,__GetGIFImageDefaultTransparent,__SetGIFImageDefaultTransparent,nil,false,0);
    DefineProp('GIFImageDefaultAnimate',tkVariant,__GetGIFImageDefaultAnimate,__SetGIFImageDefaultAnimate,nil,false,0);
    DefineProp('GIFImageDefaultAnimationLoop',tkEnumeration,__GetGIFImageDefaultAnimationLoop,__SetGIFImageDefaultAnimationLoop,nil,false,0);
    DefineProp('GIFImageDefaultDithering',tkEnumeration,__GetGIFImageDefaultDithering,__SetGIFImageDefaultDithering,nil,false,0);
    DefineProp('GIFImageDefaultColorReduction',tkEnumeration,__GetGIFImageDefaultColorReduction,__SetGIFImageDefaultColorReduction,nil,false,0);
    DefineProp('GIFImageDefaultColorReductionBits',tkInteger,__GetGIFImageDefaultColorReductionBits,__SetGIFImageDefaultColorReductionBits,nil,false,0);
    DefineProp('GIFImageDefaultDitherMode',tkEnumeration,__GetGIFImageDefaultDitherMode,__SetGIFImageDefaultDitherMode,nil,false,0);
    DefineProp('GIFImageDefaultAnimationSpeed',tkInteger,__GetGIFImageDefaultAnimationSpeed,__SetGIFImageDefaultAnimationSpeed,nil,false,0);
    DefineProp('DoAutoDither',tkVariant,__GetDoAutoDither,__SetDoAutoDither,nil,false,0);
    DefineProp('PaletteDevice',tkVariant,__GetPaletteDevice,__SetPaletteDevice,nil,false,0);
    DefineProp('GIFImageRenderOnLoad',tkVariant,__GetGIFImageRenderOnLoad,__SetGIFImageRenderOnLoad,nil,false,0);
    DefineProp('GIFImageOptimizeOnStream',tkVariant,__GetGIFImageOptimizeOnStream,__SetGIFImageOptimizeOnStream,nil,false,0);
    DefineProp('BitmapAllocationThreshold',tkInteger,__GetBitmapAllocationThreshold,__SetBitmapAllocationThreshold,nil,false,0);
    DefineProp('GIFDelayExp',tkInteger,__GetGIFDelayExp,__SetGIFDelayExp,nil,false,0);
    DefineProp('GIFDefaultDelay',tkInteger,__GetGIFDefaultDelay,__SetGIFDefaultDelay,nil,false,0);
    DefineProp('GIFMinimumDelay',tkInteger,__GetGIFMinimumDelay,__SetGIFMinimumDelay,nil,false,0);
    DefineProp('GIFMaximumDelay',tkInteger,__GetGIFMaximumDelay,__SetGIFMaximumDelay,nil,false,0);
    DefineProp('GIFFileBufferSize',tkInteger,__GetGIFFileBufferSize,__SetGIFFileBufferSize,nil,false,0);
    DefineProp('GIFDefaultTransparentColor',tkEnumeration,__GetGIFDefaultTransparentColor,__SetGIFDefaultTransparentColor,nil,false,0);
    DefineProp('GIFClearOnLoop',tkVariant,__GetGIFClearOnLoop,__SetGIFClearOnLoop,nil,false,0);
    AddConstant('gvUnknown',gvUnknown);
    AddConstant('gv87a',gv87a);
    AddConstant('gv89a',gv89a);
    AddConstant('gsInfo',gsInfo);
    AddConstant('gsWarning',gsWarning);
    AddConstant('gsError',gsError);
    AddConstant('dmNone',dmNone);
    AddConstant('dmNoDisposal',dmNoDisposal);
    AddConstant('dmBackground',dmBackground);
    AddConstant('dmPrevious',dmPrevious);
    AddConstant('rmNone',rmNone);
    AddConstant('rmWindows20',rmWindows20);
    AddConstant('rmWindows256',rmWindows256);
    AddConstant('rmWindowsGray',rmWindowsGray);
    AddConstant('rmMonochrome',rmMonochrome);
    AddConstant('rmGrayScale',rmGrayScale);
    AddConstant('rmNetscape',rmNetscape);
    AddConstant('rmQuantize',rmQuantize);
    AddConstant('rmQuantizeWindows',rmQuantizeWindows);
    AddConstant('rmPalette',rmPalette);
    AddConstant('dmNearest',dmNearest);
    AddConstant('dmFloydSteinberg',dmFloydSteinberg);
    AddConstant('dmStucki',dmStucki);
    AddConstant('dmSierra',dmSierra);
    AddConstant('dmJaJuNI',dmJaJuNI);
    AddConstant('dmSteveArche',dmSteveArche);
    AddConstant('dmBurkes',dmBurkes);
    AddConstant('ooCrop',ooCrop);
    AddConstant('ooMerge',ooMerge);
    AddConstant('ooCleanup',ooCleanup);
    AddConstant('ooColorMap',ooColorMap);
    AddConstant('glDisabled',glDisabled);
    AddConstant('glEnabled',glEnabled);
    AddConstant('glContinously',glContinously);
    AddConstant('gdDisabled',gdDisabled);
    AddConstant('gdEnabled',gdEnabled);
    AddConstant('gdAuto',gdAuto);
    AddConstant('GIFVersion',GIFVersion);
    AddConstant('GIFVersionMajor',GIFVersionMajor);
    AddConstant('GIFVersionMinor',GIFVersionMinor);
    AddConstant('GIFVersionRelease',GIFVersionRelease);
    AddConstant('GIFMaxColors',GIFMaxColors);
  end;
end;

class function TatGIFImgLibrary.LibraryName: string;
begin
  result := 'GIFImg';
end;

initialization
  RegisterScripterLibrary(TatGIFImgLibrary, True);

{$WARNINGS ON}

end.

