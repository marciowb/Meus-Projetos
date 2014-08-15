// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Webimage.pas' rev: 21.00

#ifndef WebimageHPP
#define WebimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Wininet.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Webimage
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPicturePosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpCenter, bpTiled, bpStretched, bpStretchedWithAspectRatio };
#pragma option pop

struct TInternetContent;
typedef TInternetContent *PInternetContent;

class DELPHICLASS TWebPicture;
struct TInternetContent
{
	
public:
	void *HResource;
	bool Complete;
	TWebPicture* WebPicture;
};


typedef void __fastcall (__closure *TDownloadErrorEvent)(System::TObject* Sender, System::UnicodeString err);

typedef void __fastcall (__closure *TDownloadCompleteEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TDownloadCancelEvent)(System::TObject* Sender, bool &Cancel);

typedef void __fastcall (__closure *TDownloadProgressEvent)(System::TObject* Sender, unsigned dwSize, unsigned dwTotSize);

class DELPHICLASS TDownLoadThread;
class PASCALIMPLEMENTATION TDownLoadThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TWebPicture* Webpicture;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TDownLoadThread(TWebPicture* AWebPicture);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TDownLoadThread(void) { }
	
};


class DELPHICLASS THelperWnd;
class PASCALIMPLEMENTATION THelperWnd : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	Classes::TNotifyEvent FOnTimer;
	MESSAGE void __fastcall WMTimer(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Msg);
	
public:
	__fastcall virtual THelperWnd(Classes::TComponent* AOwner);
	__fastcall virtual ~THelperWnd(void);
	virtual void __fastcall CreateWnd(void);
	
__published:
	__property Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
public:
	/* TWinControl.CreateParented */ inline __fastcall THelperWnd(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TWebPicture : public Graphics::TGraphic
{
	typedef Graphics::TGraphic inherited;
	
private:
	_di_IPicture gpPicture;
	Classes::TMemoryStream* FDatastream;
	bool FIsEmpty;
	bool FStretched;
	int FLogPixX;
	int FLogPixY;
	System::UnicodeString FID;
	System::UnicodeString FURL;
	int FFrame;
	Classes::TNotifyEvent FOnFrameChange;
	System::Word FFrameXPos;
	System::Word FFrameYPos;
	System::Word FFrameXSize;
	System::Word FFrameYSize;
	bool FFrameTransp;
	System::Word FFrameDisposal;
	System::Word FAnimMaxX;
	System::Word FAnimMaxY;
	bool FCheckContentLength;
	bool FAsynch;
	bool FThreadBusy;
	TDownloadProgressEvent FOnDownLoadProgress;
	TDownloadCancelEvent FOnDownLoadCancel;
	TDownloadCompleteEvent FOnDownLoadComplete;
	TDownloadErrorEvent FOnDownLoadError;
	void __fastcall LoadPicture(void);
	int __fastcall GetFrameCount(void);
	bool __fastcall IsGIFFile(void);
	int __fastcall GetFrameTime(int i);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall ReadData(Classes::TStream* Stream);
	virtual void __fastcall WriteData(Classes::TStream* Stream);
	virtual void __fastcall Draw(Graphics::TCanvas* ACanvas, const Types::TRect &Rect);
	void __fastcall SetFrame(const int Value);
	void __fastcall DownLoadError(System::UnicodeString err);
	void __fastcall DownLoadComplete(void);
	void __fastcall DownLoadCancel(bool &cancel);
	void __fastcall DownLoadProgress(unsigned dwSize, unsigned dwTotSize);
	void __fastcall DownLoad(void);
	
public:
	__fastcall virtual TWebPicture(void);
	__fastcall virtual ~TWebPicture(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromResourceName(unsigned Instance, const System::UnicodeString ResName);
	void __fastcall LoadFromResourceID(unsigned Instance, int ResID);
	void __fastcall LoadFromURL(System::UnicodeString url);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, unsigned AData, HPALETTE APalette);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, unsigned &AData, HPALETTE &APalette);
	__property System::UnicodeString ID = {read=FID, write=FID};
	__property bool IsGIF = {read=IsGIFFile, nodefault};
	__property int FrameCount = {read=GetFrameCount, nodefault};
	__property int FrameTime[int i] = {read=GetFrameTime};
	int __fastcall GetMaxHeight(void);
	int __fastcall GetMaxWidth(void);
	__property bool Busy = {read=FThreadBusy, nodefault};
	__property bool Asynch = {read=FAsynch, write=FAsynch, nodefault};
	__property bool CheckContentLength = {read=FCheckContentLength, write=FCheckContentLength, nodefault};
	
__published:
	__property bool Stretch = {read=FStretched, write=FStretched, nodefault};
	__property int Frame = {read=FFrame, write=SetFrame, nodefault};
	__property Classes::TNotifyEvent OnFrameChange = {read=FOnFrameChange, write=FOnFrameChange};
	__property TDownloadErrorEvent OnDownLoadError = {read=FOnDownLoadError, write=FOnDownLoadError};
	__property TDownloadCompleteEvent OnDownLoadComplete = {read=FOnDownLoadComplete, write=FOnDownLoadComplete};
	__property TDownloadCancelEvent OnDownLoadCancel = {read=FOnDownLoadCancel, write=FOnDownLoadCancel};
	__property TDownloadProgressEvent OnDownLoadProgress = {read=FOnDownLoadProgress, write=FOnDownLoadProgress};
};


class DELPHICLASS TWebImage;
class PASCALIMPLEMENTATION TWebImage : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FAutoSize;
	TWebPicture* FWebPicture;
	TPicturePosition FPicturePosition;
	TDownloadCancelEvent FOnDownLoadCancel;
	TDownloadCompleteEvent FOnDownLoadComplete;
	TDownloadErrorEvent FOnDownLoadError;
	TDownloadProgressEvent FOnDownLoadProgress;
	THelperWnd* FHelperWnd;
	int FTimerCount;
	int FNextCount;
	bool FAnimatedGif;
	bool FAnimate;
	Classes::TNotifyEvent FOnFrameChange;
	System::UnicodeString FURL;
	bool FAsynch;
	bool FCheckContentLength;
	void __fastcall SetWebPicture(const TWebPicture* Value);
	void __fastcall PictureChanged(System::TObject* sender);
	void __fastcall SetPicturePosition(const TPicturePosition Value);
	void __fastcall DownLoadError(System::TObject* Sender, System::UnicodeString err);
	void __fastcall DownLoadComplete(System::TObject* Sender);
	void __fastcall DownLoadCancel(System::TObject* Sender, bool &cancel);
	void __fastcall DownLoadProgress(System::TObject* Sender, unsigned dwSize, unsigned dwTotSize);
	void __fastcall SetAnimate(const bool Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall Timer(System::TObject* Sender);
	void __fastcall FrameChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TWebImage(Classes::TComponent* aOwner);
	__fastcall virtual ~TWebImage(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SaveToFile(System::UnicodeString Filename);
	
__published:
	__property bool Animate = {read=FAnimate, write=SetAnimate, nodefault};
	__property bool Async = {read=FAsynch, write=FAsynch, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, nodefault};
	__property bool CheckContentLength = {read=FCheckContentLength, write=FCheckContentLength, nodefault};
	__property TWebPicture* WebPicture = {read=FWebPicture, write=SetWebPicture};
	__property TPicturePosition PicturePosition = {read=FPicturePosition, write=SetPicturePosition, nodefault};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Hint;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnStartDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnStartDrag;
	__property TDownloadErrorEvent OnDownLoadError = {read=FOnDownLoadError, write=FOnDownLoadError};
	__property TDownloadCompleteEvent OnDownLoadComplete = {read=FOnDownLoadComplete, write=FOnDownLoadComplete};
	__property TDownloadCancelEvent OnDownLoadCancel = {read=FOnDownLoadCancel, write=FOnDownLoadCancel};
	__property TDownloadProgressEvent OnDownLoadProgress = {read=FOnDownLoadProgress, write=FOnDownLoadProgress};
	__property Classes::TNotifyEvent OnFrameChange = {read=FOnFrameChange, write=FOnFrameChange};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Webimage */
using namespace Webimage;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WebimageHPP
