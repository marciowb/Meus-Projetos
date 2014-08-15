{***************************************************************************}
{ TMS GuiMotions                                                            }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2011                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit GUIMotions;

{$R Guimotions.res}
                                                                        
{$I TMSDEFS.INC}

{$DEFINE USETHREADS}
{$DEFINE LOADALLONSCROLL}

interface

uses
  Classes, Controls, Graphics,
  Windows, Forms, Messages,
  StdCtrls, ExtCtrls,
  SysUtils, Dialogs,
  GUIMotions3D, Math, Jpeg;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 2; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.
  DATE_VER = 'FEB, 2011'; // Month version

  // v1.0.0.1 : Improved memory usage for iqNone mode.
  // v1.0.0.2 : Added exception handling on picture.loadfromfile.
  //          : Improved Image quality in zoomstate when loading image with quality iqNone.
  // v1.0.0.3 : Added support for displaying floating points.
  // v1.0.1.0 : Added Left and Right click on Images to allow zoom or allow alternate image
  //          : Improved browse through images with arrows on scrollbar
  // v1.0.1.1 : Fixed Performance issues
  // v1.0.1.2 : Fixed Scrollbar slider position
  //          : Fixed issue with Cursor
  //          : Fixed stop animation when (csDestroying in ComponentState)
  // v1.0.2.0 : New SelectedScaleFactor to change selected image default size
  //          : Improved Threadloading
  //          : Improved navigator handling
  // v1.1.0.0 : New : Programmatic control of animation
  // v1.1.0.1 : Fixed : Floating point division by zero when only one image is loaded
  //          : Fixed : Access violation when only one image is loaded
  // v1.1.0.2 : Fixed : Creation of 2 threads instead of one.
  // v1.1.1.0 : New : ImageStripMargin to position the imagestrip image wall
  //          : Fixed : Visible image count in Carousel mode.
  // v1.1.1.1 : Fixed : Issue with Alternate image Vertex buffer
  // v1.1.1.2 : Improved : Double Click image
  //          : Fixed : Issue with disappearing images
  // v1.1.1.3 : Fixed : Issue with runtime creating and selecting images
  // v1.1.1.4 : Fixed : Issue with repainting after clearing images
  // v1.1.1.5 : Improved : Updating images with UpdateImage at runtime
  // v1.1.1.6 : Fixed : issue with list index out of bounds
  // v1.1.1.7 : Fixed : ansistring warning
  // v1.1.1.8 : Fixed : Issue with Double-clicking called twice
  // v1.2.0.0 : New : Delphi and C++Builder XE support
  // v1.2.0.1 : Fixed : Issue in imagestrip index


Const
  AnimationMargin = 0.005;
  AnimationGlowMargin = 0.1;
  CountVertices = 200;
  D3DFVF_CUSTOMVERTEX = (D3DFVF_XYZ or D3DFVF_DIFFUSE or D3DFVF_TEX1);

type
  TCustomVertex = packed record
    position: TD3DVector;
    Color: DWord;
    tu, tv: Single;
  end;

  {$IFDEF USETHREADS}
  TImageThreadStatus = (stNone, stInitialized, stStarted, stLoaded);
  {$ENDIF}

  TVertexArray = array[0..(CountVertices * 2) - 1] of TCustomVertex;

  TGUIMotions = class;

  TGUIMotionsImage = class;     

  TGUIMotionsImageArray = array of TGUIMotionsImage;

  TGUIMotionsPageState = (psPageLeft, psPageRight);

  TGUIMotionsImageState = (isDefault, isNormal, isSkewLeft, isSkewRight);

  TGUIMotionsImageLoading = (ilLoadOnDemandAndRelease, ilLoadOnDemand, ilLoadAll);

  TGUIMotionsImageMode = (imNormal, imAspectRatio);

  TGUIMotionsImageQuality = (iqNone, iqSelected, iqFull);

  TGUIMotionsAnimationMode = (amCarousel, amImageBandLeft, amImageBandRight, amConicalInnerBand,
                              amConicalOuterBand, amImageStrip, amRoloDex, amBook);

  TGUIMotionsPosition = (spTopLeft, spTopRight, spBottomLeft, spBottomRight, spTopCenter, spBottomCenter, spCustom);

  TGUIMotionsImageSelected = (sNormal, sAlternate);

  TGUIMotionsImageZoomed = (zZoomedOut, zZoomedIn);

  TGUIMotionsDblClickEvent = procedure(Sender: TObject; Image: integer) of object;

  TGUIMotionsImageEvent = procedure(Sender: TObject; Image: integer; var AllowZoom: Boolean; device: IDirect3DDevice9) of object;
  
  TGUIMotionsImageLeftClickEvent = procedure(Sender: TObject; Image: integer; var AllowZoom: Boolean; device: IDirect3DDevice9) of object;

  TGUIMotionsImageRightClickEvent = procedure(Sender: TObject; Image: integer; var AllowAlternate: Boolean; device: IDirect3DDevice9) of object;

  TGUIMotionsAlternateImageLeftClickEvent = procedure(Sender: TObject; Image: integer; var AllowZoom: Boolean; device: IDirect3DDevice9) of object;

  TGUIMotionsAlternateImageRightClickEvent = procedure(Sender: TObject; Image: integer; var AllowAlternate: Boolean; device: IDirect3DDevice9) of object;

  TGUIMotionsImageSelectedEvent = procedure(Sender: TObject; Image: integer; ImageRectangle: TRect) of object;

  TGUIMotionsImageZoomedEvent = procedure(Sender: TObject; Image: integer; ImageRectangle: TRect) of object;

  TGUIMotionsImageChangedEvent = procedure(Sender: TObject; PreviousImage, CurrentImage: integer; device: IDirect3DDevice9) of object;

  TGUIMotionsImageCustomDrawEvent = procedure(Sender: TObject; Image: integer; Picture: Graphics.TBitmap) of object;

  TGUIMotionsImageLoadedEvent = procedure(Sender: TObject; Image: integer; alternate: Boolean) of object;

  TGUIMotionsCaptionMode = (cmNone, cmFileName, cmFullPath);

  {$IFDEF USETHREADS}
  TImageLoaderThread = class(TThread)
  private
    GUIMotions: TGUIMotions;
  protected
    procedure Execute; override;
  public
    constructor Create(AGUIMotions: TGUIMotions);
  end;
  {$ENDIF}
  TGUIMotionsImage = class(TCollectionItem)
  private
    faw, fah, fw, fh, fhaspect, fwaspect, fhaspectalt, fwaspectalt: integer;
    FAc: Boolean;
    F3DImagePositionX: integer;
    F3DImagePositionY: integer;
    F3DImageWidth: integer;
    F3DImageHeight: integer;
    FAlternate: Boolean;
    FBookanimated, FImageBandAnimated: Boolean;
    FCaption, FFullCaption: String;
    FCIndex: integer;
    FControl: TControl;
    FHTotalx, FHTotaly: double;
    FImageSprite: ID3DXSprite;
    FImageCenterV: TD3DXVector2;
    FImageSelected: TGUIMotionsImageSelected;
    FImageZoomed: TGUIMotionsImageZoomed;
    FImageClicked: Boolean;
    FMatrix: TD3DXMatrix;
    FMouseActionIn, FMouseHandled, FMouseActionOut, FAnimateAlternate, FAnimateNormal: Boolean;
    FTo1, FTo2, FTo3, FTo4, FAnimCylinder, FSlideX, FSlideY, FScaleX, FScaleY, FSliding, FNormalize,
      FNormalizeAndScaleDownLeft, FNormalizeAndScaleDownRight,
        FNormalizeAndScaleUp, FNormalizeAndScaleDown: Boolean;
    FOwner: TGUIMotions;
    FpVertices, fpGlowVertices: Pointer;
    FGlowOpacity: Byte;
    FPictureDistance: integer;
    FPictureLocation: String;
    {$IFDEF USETHREADS}
    FThreadedPictureLocation: string;
    FThreadStatus: TImageThreadStatus;
    {$ENDIF}
    FPicture: TPicture;
    FAlternatePicture: TPicture;
    FAlternatePictureLocation: String;
    FPositionV: TD3DXVector3;
    FRIndex: integer;
    FState: TGUIMotionsImageState;
    FScaleDown, FScaleUp, FSkewLeft, FSkewRight: Boolean;
    FSPInit, FVBInit: Boolean;
    FScaleV: TD3DXVector2;
    FIsSelected: Boolean;
    FShowCaption: Boolean;
    FToX, FToY, FSToX, FSToY: Double;
    FTexture, FAltTexture: IDirect3DTexture9;
    FCylinderVertex, FCylinderMirrorVertex, FVertex, FGlowVertex, FAltVertex: TVertexArray;
    FFakeVertex, FVertexPosition: TVertexArray;
    fxFrom, fxTo: Single;
    FBusy: boolean;
    FReload: Boolean;
    FTag: integer;
    FObject: TObject;
    FOwnsObject: boolean;
    FData: string;
    procedure SetCaption(const Value: String);
    procedure SetAlternatePicture(const Value: TPicture);
    procedure SetPicture(const Value: TPicture);
    procedure SetAlternatePictureLocation(const Value: String);
    procedure SetPictureLocation(const Value: String);
    procedure SetControl(const Value: TControl);
    procedure SetThreadedPictureLocation(const Value: String);
    procedure SetThreadStatus(const Value: TImageThreadStatus);
    procedure SetFullCaption(const Value: String);
  protected
    property Busy: boolean read FBusy write FBusy;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ApplyNewVB(v: TVertexArray);
    procedure ApplyNewGlowVB(v: TVertexArray);
    procedure DisplayCaption;
    procedure DoMouseActions;
    procedure DrawGlow;    
    procedure DrawMirror;
    procedure CheckDrawMirror;
    procedure FillCylinderVertex;
    procedure FillVertex(var v: TVertexArray; alternate: Boolean);
    procedure FillGlowVertex(var v: TVertexArray);
    procedure AnimateCylinderVertex(delta: Single);
    procedure Update;
    procedure CreateImage;
    procedure InitImage(x, y, ToX, ToY: Single);
    procedure SetImagePosition(J, k, i: integer; w, h: single);
    procedure SetX(var x: Single; cc: integer);
    procedure SetupMatrices;
    procedure renderimage;
    function AnimateAlternate: Boolean;
    function AnimateNormal: Boolean;
    function Get3DDevice: IDirect3DDevice9;
    function GetImagePosition: TPoint;
    function GetPictureRectangle: TRect;
    function GetOriginalPictureWidth: integer;
    function GetOriginalPictureHeight: integer;
    function GetPictureAspectHeight: integer;
    function InitVB: HRESULT;
    function InitSprite(Image: integer): HRESULT;
    function Normalize: Boolean;
    function SkewLeft:Boolean;
    function SkewRight: Boolean;
    function ScaleDown: Boolean;
    function ScaleUp: Boolean;
    function ZoomIn: Boolean;
    function ZoomOut: Boolean;
    property Control: TControl read FControl write SetControl;
    property ImageSelected: TGUIMotionsImageSelected read FImageSelected;
    property ImageZoomed: TGUIMotionsImageZoomed read FImageZoomed;
    property ImageState: TGUIMotionsImageState read FState;
    procedure UpdateImage;
  published
    property AlternatePicture: TPicture read FAlternatePicture write SetAlternatePicture;
    property AlternatePictureLocation: String read FAlternatePictureLocation write SetAlternatePictureLocation;
    property Caption: String read FCaption write SetCaption;
    property FullCaption: String read FFullCaption write SetFullCaption;
    property Data: string read FData write FData;
    property Picture: TPicture read FPicture write SetPicture;
    property PictureLocation: String read FPictureLocation write SetPictureLocation;
    {$IFDEF USETHREADS}
    property ThreadedPictureLocation: String read FThreadedPictureLocation write SetThreadedPictureLocation;
    property ThreadStatus: TImageThreadStatus read FThreadStatus write SetThreadStatus;
    {$ENDIF}
    property Tag: integer read FTag write FTag;
    property ItemObject: TObject read FObject write FObject;
    property OwnsObject: boolean read FOwnsObject write FOwnsObject;
  end;

  TGUIMotionsImages = class(TOwnedCollection)
  private
    FOnChange: TNotifyEvent;
    FOwner: TGUIMotions;
    function GetItem(Index: Integer): TGUIMotionsImage;
    procedure SetItem(Index: Integer; const Value: TGUIMotionsImage);
  public
    constructor Create(AOwner: TGUIMotions);
    function GetItemClass: TCollectionItemClass; virtual;
    function Add:TGUIMotionsImage;
    {$IFDEF USETHREADS}
    procedure Clear;
    {$ENDIF}
    function Insert(index:integer): TGUIMotionsImage;
    property Items[Index: Integer]: TGUIMotionsImage read GetItem write SetItem; default;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGUIMotionsScrollBar = class(TPersistent)
  private
    FOwner: TGUIMotions;
    FArrowColor: TColor;
    FLeft, FTop, FWidth, FHeight: integer;
    FSliderColor: TColor;
    FOverLay: TColor;
    FColor: TColor;
    FVisible: Boolean;
    FVertex: TVertexArray;
    fpVertices: Pointer;
    FScrollBarSprite: ID3DXSprite;
    FVertexBuffer: IDirect3DVertexBuffer9;
    FMatrix: TD3DXMatrix;
    FPositionV, FScrollBarCenterV, FScaleV: TD3DXVector3;
    FOverLayAlphaBottom: Byte;
    FOverLayAlphaTop: Byte;
    FColorAlpha: Byte;
    FSlideAlpha: Byte;
    FTrackerColor: TColor;
    FTrackerAlpha: Byte;
    FTrackerHeight: integer;
    FPosition: TGUIMotionsPosition;
    FSlideHeight: integer;
    FSlideWidth: integer;
    procedure SetArrowColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetSlideColor(const Value: TColor);
    procedure SetVisible(const Value: Boolean);
    procedure SetOverLayAlphaBottom(const Value: Byte);
    procedure SetOverLayAlphaTop(const Value: Byte);
    procedure SetOverLayColor(const Value: TColor);
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetTop(const Value: integer);
    procedure SetColorAlpha(const Value: Byte);
    procedure SetSlideAlpha(const Value: Byte);
    procedure SetTrackerAlpha(const Value: Byte);
    procedure SetTrackerColor(const Value: TColor);
    procedure SetSlideHeight(const Value: integer);
    procedure SetTrackerHeight(const Value: integer);
    procedure SetSlideWidth(const Value: integer);
    procedure SetPosition(const Value: TGUIMotionsPosition);
  protected
    procedure InitSliderPos(pos: Single);
    function GetSliderPosByImageIndex(Image: integer): Single;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ArrowColor: TColor read FArrowColor write SetArrowColor default clBtnHighlight;
    property Color: TColor read FColor write SetColor default clBlue;
    property ColorAlpha: Byte read FColorAlpha write SetColorAlpha default 125;
    property SlideColor: TColor read FSliderColor write SetSlideColor default clBlue;
    property SlideAlpha: Byte read FSlideAlpha write SetSlideAlpha default 125;
    property SlideHeight: integer read FSlideHeight write SetSlideHeight default 15;
    property SlideWidth: integer read FSlideWidth write SetSlideWidth default 30;
    property TrackerColor: TColor read FTrackerColor write SetTrackerColor default clBlue;
    property TrackerAlpha: Byte read FTrackerAlpha write SetTrackerAlpha default 255;
    property TrackerHeight: integer read FTrackerHeight write SetTrackerHeight default 3;
    property Visible: Boolean read FVisible write SetVisible default false;
    property OverLayColor: TColor read FOverLay write SetOverLayColor default clWhite;
    property OverLayAlphaTop: Byte read FOverLayAlphaTop write SetOverLayAlphaTop default 150;
    property OverLayAlphaBottom: Byte read FOverLayAlphaBottom write SetOverLayAlphaBottom default 0;
    property Position: TGUIMotionsPosition read FPosition write SetPosition default spBottomCenter;
    property Width: integer read FWidth write SetWidth default 250;
    property Height: integer read FHeight write SetHeight default 25;
    property Left: integer read FLeft write SetLeft default 0;
    property Top: integer read FTop write SetTop default 0;
  end;

  TGuiMotionsImageStripPosition = (ispAuto, ispMargin);

  TGUIMotions = class(TCustomControl)
  private
    FReload: Boolean;
    FVersion: string;  
    FMouseDown: Boolean;
    FReset: Boolean;
    FErrorOccured: Boolean;
    FSlideOutDistance: integer;
    FMouseOnSlider: Boolean;
    FSliderCapture: Boolean;
    FPageState: TGUIMotionsPageState;
    FAnimationMode: TGUIMotionsAnimationMode;
    FAnimationFactor: integer;
    FAnCarousel, FAnRolodex, FAnBook, FAnImageStrip, FAnStacked: TTimer;
    FBackColor: TColor;
    FCaptionFont: TFont;
    FCaptionD3DFont: ID3DXFont;
    FCaptionLeft: integer;
    FCaptionTop: integer;
    FCy, FMy, FCx, FMx: integer;
    FPrevCC, FSelected, FPrevSelected: integer;
    FD3D: IDirect3D9;
    FD3DDevice: IDirect3DDevice9;
    FD3DInitialized: Boolean;
    FOnImageClick: TGUIMotionsImageEvent;
    FOnImageDblClick: TGUIMotionsDblClickEvent;
    FOnImageSelected: TGUIMotionsImageSelectedEvent;
    FOnImageZoomed: TGUIMotionsImageZoomedEvent;
    FOnImageUnZoom: TGUIMotionsImageZoomedEvent;
    FOnAlternateImageClick: TGUIMotionsImageEvent;
    FOnImageChanged: TGUIMotionsImageChangedEvent;
    FOnImageCustomDraw: TGUIMotionsImageCustomDrawEvent;
    FOnImageCustomAlternateDraw: TGUIMotionsImageCustomDrawEvent;
    FOnImageLoaded: TGUIMotionsImageLoadedEvent;
    FMirror: Boolean;
    FMirrorColor, FGlowColor: TColor;
    FImages: TGUIMotionsImages;
    FImageQuality: TGUIMotionsImageQuality;
    FImageRowCount: integer;
    FPreLoadFont: ID3DXFont;
    FImageLoading: TGUIMotionsImageLoading;
    FShowImageCount, FStartImageCount: integer;
    FScrollBar: TGUIMotionsScrollBar;
    FShowPreLoader: Boolean;
    FVertexBuffer, FVertexGlowBuffer: IDirect3DVertexBuffer9;
    FGlowSprite: ID3DXSprite;
    Fj, Fk: integer;
    Fx: Single;
    FCaptionMode: TGuiMotionsCaptionMode;
    FPictureDistance: integer;
    FPictureWidth: integer;
    FSkewPercentage: integer;
    FPictureHeightZoomed: integer;
    FPictureWidthZoomed: integer;
    FPictureHeight: integer;
    FGlowSize: integer;
    FGlow: Boolean;
    FMirrorBottomAlpha: Byte;
    FMirrorTopAlpha: Byte;
    FCaptionPosition: TGUIMotionsPosition;
    FGlowAnimation: Boolean;
    FDisableRender, FDisableMouseRender, FDisableMouseAlternateRender: Boolean;
    FImageMode: TGUIMotionsImageMode;
    FDefaultPicture: TPicture;
    FDefaultAlternatePicture: TPicture;
    FLookup: string;
    FKeyboardLookup: boolean;
    {$IFDEF USETHREADS}
    FImageLoaderThread : TImageLoaderThread;
    FThreadDone: boolean;
    FOnImageLeftClick: TGUIMotionsImageLeftClickEvent;
    FOnImageRightClick: TGUIMotionsImageRightClickEvent;
    FOnAlternateImageLeftClick: TGUIMotionsAlternateImageLeftClickEvent;
    FOnAlternateImageRightClick: TGUIMotionsAlternateImageRightClickEvent;
    {$ENDIF}
    FSelectedScaleFactor: single;
    FAllowInteraction: boolean;
    FImageStripMargin: integer;
    FImageStripPosition: TGuiMotionsImageStripPosition;
    procedure SetImages(const Value: TGUIMotionsImages);
    procedure SetBackColor(const Value: TColor);
    procedure SetRendering(const Value: TGUIMotionsImageLoading);
    procedure SetImageQuality(const Value: TGUIMotionsImageQuality);
    procedure SetAnimationMode(const Value: TGUIMotionsAnimationMode);
    procedure SetImageRowCount(const Value: integer);
    procedure SetAnimationFactor(const Value: integer);
    procedure SetCaptionLeft(const Value: integer);
    procedure SetCaptionTop(const Value: integer);
    procedure SetMirror(const Value: Boolean);
    procedure SetMirrorColor(const Value: TColor);
    procedure SetPictureDistance(const Value: integer);
    procedure SetPictureHeight(const Value: integer);
    procedure SetPictureWidth(const Value: integer);
    procedure SetSkewPercentage(const Value: integer);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetGlowColor(const Value: TColor);
    procedure SetGlowSize(const Value: integer);
    procedure SetGlow(const Value: Boolean);
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMEraseBkGnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure SetScrollBar(const Value: TGUIMotionsScrollBar);
    procedure SetMirrorBottomAlpha(const Value: Byte);
    procedure SetMirrorTopAlpha(const Value: Byte);
    procedure SetCaptionPosition(const Value: TGUIMotionsPosition);
    procedure SetGlowAnimation(const Value: Boolean);
    procedure SetImageMode(const Value: TGUIMotionsImageMode);
    procedure SetSelected(const Value: Integer);
    procedure SetSlideOutDistance(const Value: integer);
    procedure SetDefaultAlternatePicture(const Value: TPicture);
    procedure SetDefaultPicture(const Value: TPicture);
    procedure SetKeyboardLookup(const Value: Boolean);
    procedure SetPictureHeightZoomed(const Value: integer);
    procedure SetPictureWidthZoomed(const Value: integer);
    {$IFDEF USETHREADS}
    procedure ThreadDone(Sender: TObject);
    procedure SetCaptionMode(const Value: TGUIMotionsCaptionMode);
    {$ENDIF}
    function GetVersion: string;
    procedure SetSelectedScaleFactor(const Value: single);
    procedure SetAllowInteraction(const Value: boolean);
    procedure SetImageStripMargin(const Value: integer);
    procedure SetImageStripPosition(const Value: TGuiMotionsImageStripPosition);
  protected
    function ImageAtXY(X, Y: integer): integer;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure PaintBackGround;
    procedure CheckDeviceLost;
    procedure CheckMouseActionLeft;
    procedure CheckMouseActionRight;
    procedure AlternateImageClick(Image: integer; var AllowZoom: Boolean; device: IDirect3DDevice9); virtual;    
    procedure AlternateImageLeftClick(Image: integer; var AllowZoom: Boolean; device: IDirect3DDevice9); virtual;
    procedure AlternateImageRightClick(Image: integer; var AllowAlternate: Boolean; device: IDirect3DDevice9); virtual;
    procedure DoImageUnZoom(Image: integer; ImageRectangle: TRect); virtual;
    procedure DoImageZoomed(Image: integer; ImageRectangle: TRect); virtual;
    procedure DoDblClick(Image: Integer); virtual;
    procedure DoImageSelected(Image: integer; ImageRectangle: TRect); virtual;
    procedure ImageClick(var AllowZoom: Boolean; device: IDirect3DDevice9; Image: integer);    
    procedure ImageLeftClick(var AllowZoom: Boolean; device: IDirect3DDevice9; Image: integer); virtual;
    procedure ImageRightClick(var AllowAlternate: Boolean; device: IDirect3DDevice9; Image: integer); virtual;
    procedure ImageCustomDraw(Picture: Graphics.TBitmap; Image: integer);
    procedure ImageCustomAlternateDraw(Picture: Graphics.TBitmap; Image: integer);
    procedure ImageChanged(device: IDirect3DDevice9; PreviousImage, CurrentImage: integer);
    procedure ImageLoaded(Index: integer; Alternate: Boolean);
    procedure InitImageVertexAlpha(Alpha: single; ItemVisible: integer);
    /////////////////////////////
    //Handles animation
    procedure AnimateCarousel(Sender: TObject); //1
    procedure AnimateRoloDex(Sender: TObject); //2
    procedure AnimateBook(Sender: TObject); //3
    procedure AnimateImageStrip(Sender: TObject); //4
    procedure AnimateStackedPictures(Sender: TObject); //5
    //Handles animation calculation
    procedure AnimateCarouselImage(Image: integer); //1
    procedure AnimatePictureRoll(Image: integer); //2
    procedure AnimatePictureTurn(Image: integer); //3
    procedure AnimatePicture(Image: integer); //4
    procedure AnimateStackedPicture(Image: integer); //5
    //Handles animation rendering
    procedure RenderCarousel; //1
    procedure RenderRoloDex; //2
    procedure RenderBook; //3
    procedure RenderImageStrip; //4
    procedure RenderStackedPictures; //5
    //ScrollBar
    procedure ApplyScrollBarVB;
    procedure RenderScrollBar; //global
    /////////////////////////////
    procedure D3DFree(ForceD3DFree: Boolean);
    procedure InitScrollBar;
    procedure SetSelectedQuality(Image: integer);
    procedure SetCount(Image: integer);
    procedure SetPageState(Image: integer);
    procedure InitD3DFonts;
    procedure PreLoadImages;
    procedure Preload;
    procedure Initialize;
    procedure ResetImageStatus(Xpos, Ypos, Image: integer; DoSelectImage: Boolean);
    procedure Resize; override;
    procedure Timers(enabled: Boolean);
    procedure StopAllTimers;
    procedure InitImages;
    procedure InitImagePositions;    
    function BuildPresentationParameters: TD3DPresentParameters;
    function CheckGlow: Boolean;
    function GetSliderPosition: TPoint;
    function GetSliderPositionImage: integer;
    function InitD3D: HRESULT;
    function NormalImages: TGUIMotionsImageArray;
    function ShiftImages: TGUIMotionsImageArray;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    {$IFDEF USETHREADS}
    procedure StopThread;
    procedure StartThread;
    procedure AddThreadedImageLocationsFromFolder(AFolder: string);    
    {$ENDIF}
    procedure Assign(Source: TPersistent); override;
    procedure AddImagesFromFolder(AFolder: string);
    procedure AddImageLocationsFromFolder(AFolder: string);
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Render; //global
    procedure Reset;
    procedure Init;
    procedure Click; override;
    procedure MouseWheelHandler(var Message: TMessage); override;
    procedure Zoom;
    procedure NextImage;
    procedure PreviousImage;
    procedure LastImage;
    procedure FirstImage;
    procedure Alternate;
    procedure NavigateImage(X, Y: integer; Button: TMouseButton; AllowInt: Boolean);
    procedure SelectImage(Image: integer);
    procedure EnableRendering(Enabled: Boolean);
    procedure EnableReset(Enabled: Boolean);
    procedure EnableMouseRendering(Enabled: Boolean);
    function GetCurrentSelectedImage: integer;
    function GetRenderingCount: integer;
    function GetLoadingImagesCount: integer;
    property PageState: TGUIMotionsPageState read FPageState;
    function GetVersionNr: Integer;
    function GetVersionString: string;
    function GetStartCount: integer;
    function GetCountVisible: integer;
    procedure UpdateImages;
  published
    property Version: string read GetVersion;
    property AllowInteraction: boolean read FAllowInteraction write SetAllowInteraction default true;
    property AnimationMode: TGUIMotionsAnimationMode read FAnimationMode write SetAnimationMode default amCarousel;
    property AnimationFactor: integer read FAnimationFactor write SetAnimationFactor default 15;
    property SelectedScaleFactor: single read FSelectedScaleFactor write SetSelectedScaleFactor;
    property BackColor: TColor read FBackColor write SetBackColor default clGray;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property CaptionLeft: integer read FCaptionLeft write SetCaptionLeft default 0;
    property CaptionTop: integer read FCaptionTop write SetCaptionTop default 0;
    property CaptionPosition: TGUIMotionsPosition read FCaptionPosition write SetCaptionPosition default spBottomCenter;
    property DefaultPicture: TPicture read FDefaultPicture write SetDefaultPicture;
    property DefaultAlternatePicture: TPicture read FDefaultAlternatePicture write SetDefaultAlternatePicture;
    property Images: TGUIMotionsImages read FImages write SetImages;
    property ImageQuality: TGUIMotionsImageQuality read FImageQuality write SetImageQuality default iqSelected;
    property ImageMode: TGUIMotionsImageMode read FImageMode write SetImageMode default imNormal;
    property ImageRowCount: integer read FImageRowCount write SetImageRowCount default 3;
    property ImageStripMargin: integer read FImageStripMargin write SetImageStripMargin default 0;
    property ImageStripPosition: TGuiMotionsImageStripPosition read FImageStripPosition write SetImageStripPosition default ispAuto;
    property ImageLoading: TGUIMotionsImageLoading read FImageLoading write SetRendering default ilLoadOnDemand;
    property ImageSelected: Integer read FSelected write SetSelected default 0;
    property KeyboardLookup: Boolean read FKeyboardLookup write SetKeyboardLookup default false;
    property Align;
    property Hint;
    property ShowHint;
    //Picture
    property Mirror: Boolean read FMirror write SetMirror default true;
    property MirrorColor: TColor read FMirrorColor write SetMirrorColor default clWhite;
    property MirrorTopAlpha: Byte read FMirrorTopAlpha write SetMirrorTopAlpha default 150;
    property MirrorBottomAlpha: Byte read FMirrorBottomAlpha write SetMirrorBottomAlpha default 0;
    property GlowAnimation: Boolean read FGlowAnimation write SetGlowAnimation default true;
    property Glow: Boolean read FGlow write SetGlow default false;
    property GlowColor: TColor read FGlowColor write SetGlowColor default clWhite;
    property GlowSize: integer read FGlowSize write SetGlowSize default 4;
    property PictureWidth: integer read FPictureWidth write SetPictureWidth default 200;
    property PictureHeight: integer read FPictureHeight write SetPictureHeight default 200;
    property PictureWidthZoomed: integer read FPictureWidthZoomed write SetPictureWidthZoomed default 350;
    property PictureHeightZoomed: integer read FPictureHeightZoomed write SetPictureHeightZoomed default 350;
    property PictureDistance: integer read FPictureDistance write SetPictureDistance default 70;
    property SlideOutDistance: integer read FSlideOutDistance write SetSlideOutDistance default 50;
    property SkewPercentage: integer read FSkewPercentage write SetSkewPercentage default 80;
    property CaptionMode: TGUIMotionsCaptionMode read FCaptionMode write SetCaptionMode default cmFileName;
    property ScrollBar: TGUIMotionsScrollBar read FScrollBar write SetScrollBar;
   
    property OnImageClick: TGUIMotionsImageEvent read FOnImageClick write FOnImageClick;
    property OnImageLeftClick: TGUIMotionsImageLeftClickEvent read FOnImageLeftClick write FOnImageLeftClick;
    property OnImageRightClick: TGUIMotionsImageRightClickEvent read FOnImageRightClick write FOnImageRightClick;
    property OnImageDblClick: TGUIMotionsDblClickEvent read FOnImageDblClick write FOnImageDblClick;
    property OnAlternateImageClick: TGUIMotionsImageEvent read FOnAlternateImageClick write FOnAlternateImageClick;    
    property OnAlternateImageLeftClick: TGUIMotionsAlternateImageLeftClickEvent read FOnAlternateImageLeftClick write FOnAlternateImageLeftClick;
    property OnAlternateImageRightClick: TGUIMotionsAlternateImageRightClickEvent read FOnAlternateImageRightClick write FOnAlternateImageRightClick;
    property OnImageChanged: TGUIMotionsImageChangedEvent read FOnImageChanged write FOnImageChanged;
    property OnImageCustomDraw: TGUIMotionsImageCustomDrawEvent read FOnImageCustomDraw write FOnImageCustomDraw;
    property OnImageCustomAlternateDraw: TGUIMotionsImageCustomDrawEvent read FOnImageCustomAlternateDraw write FOnImageCustomAlternateDraw;
    property OnImageLoaded: TGUIMotionsImageLoadedEvent read FOnImageLoaded write FOnImageLoaded;
    property OnImageSelected: TGUIMotionsImageSelectedEvent read FOnImageSelected write FOnImageSelected;
    property OnImageZoomed: TGUIMotionsImageZoomedEvent read FOnImageZoomed write FOnImageZoomed;
    property OnImageUnZoom: TGUIMotionsImageZoomedEvent read FOnImageUnZoom write FOnImageUnZoom;

    property OnKeyPress;
    property OnKeyDown;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    {$IFDEF DELPHI2006_LVL}
    property OnMouseLeave;
    property OnMouseEnter;
    {$ENDIF}
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TMS GUIMotions', [TGUIMotions]);
end;

function AnimateDouble(var Start: Single; Stop, Delta: Single; Margin: Single): Boolean;
begin
  Result := false;
  if (Start > Stop - Margin) and (Start < Stop + Margin) then
  begin
    Start := Stop;
    Result := true;
  end
  else
  begin
    if Start < Stop then
      Start := Start + Delta
    else
      Start := Start - Delta;
  end;
end;

procedure TGUIMotions.AnimateCarousel(Sender: TObject);
var
  I: Integer;
  d: Single;
  disable: integer;
begin
  if (csDestroying in ComponentState) then
    exit;

  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      // SLIDE
      d := Abs(FPositionV.x - FTox) / AnimationFactor;
      FSliding := AnimateDouble(FPositionV.x, FTox, d, AnimationMargin);

       //NORMALIZE
      if FNormalizeAndScaleUp then
      begin
        if not FNormalize then
          FNormalize := Normalize;

        if not FScaleUp then
          FScaleUp := ScaleUp;

        if FNormalize and FScaleUp then
          FNormalizeAndScaleUp := false;
      end;

      //SKEWLEFT
      if FNormalizeAndScaleDownLeft then
      begin
        if not fNormalize then
          FNormalize := Normalize;

        if not FScaleDown then
          FScaleDown := ScaleDown;

        if not FSkewLeft then
          FSkewLeft := SkewLeft;

        if FNormalize and FScaleDown and FSkewLeft then
          FNormalizeAndScaleDownLeft := false;
      end;

      //SKEWRIGHT
      if FNormalizeAndScaleDownRight then
      begin
        if not FNormalize then
          FNormalize := Normalize;

        if not FScaleDown then
          FScaleDown := ScaleDown;

        if not FSkewRight then
          FSkewRight := SkewRight;

        if FNormalize and FScaleDown and FSkewright then
          FNormalizeAndScaleDownRight := false;
      end;

      DoMouseActions;
    end;
  end;                                      

  disable := 0;
  for i := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      if not FNormalizeAndScaleUp and FSliding then
        Inc(disable);
    end;
  end;

  if disable = Images.Count then
    FDisableRender := true;

  RenderCarousel;
end;

procedure TGUIMotions.AnimateImageStrip(Sender: TObject);
var
  i: integer;
  d: Double;
  disable: integer;
begin
  if (csDestroying in ComponentState) then
    exit;
    
  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      // SLIDE X
      d := Abs(FPositionV.x - FTox) / AnimationFactor;
      FSlideX := AnimateDouble(FPositionV.x, FTox, d, AnimationMargin);

      // SLIDE Y
      d := Abs(FPositionV.y - FToy) / AnimationFactor;
      FSlideY := AnimateDouble(FPositionV.y, FToy, d, AnimationMargin);

      case AnimationMode of
        amConicalInnerBand, amConicalOuterBand:
        begin
          // TRANSFORM CYLINDER
          if FAc then
          begin
            d := Abs(fxFrom - fxTo) / AnimationFactor;
            FAnimCylinder := AnimateDouble(fxFrom, fxTo, d, 1);
            AnimateCylinderVertex(fxfrom);
          end;
        end;
      end;

      //NORMALIZE
      if FNormalizeAndScaleUp then
      begin
        if not FNormalize then
          FNormalize := Normalize;

        if not FScaleUp then
          FScaleUp := ScaleUp;

        if FNormalize and FScaleUp then
          FNormalizeAndScaleUp := false;
      end;

      //NORMALIZE
      if FNormalizeAndScaleDown then
      begin
        if not fNormalize then
          FNormalize := Normalize;

        if not FScaleDown then
          FScaleDown := ScaleDown;

         if FNormalize and FScaleDown then
           FNormalizeAndScaleDown := false;
      end;
      DoMouseActions;      
    end;
  end;

  RenderImageStrip;

  disable := 0;
  for i := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      if i = GetCurrentSelectedImage then
      begin
        if not FNormalizeAndScaleUp and FSlideX and FSlideY then
          Inc(disable);
      end
      else
      begin
        if not FNormalizeAndScaleDown and FSlideX and FSlideY then
          Inc(disable);
      end;
    end;
  end;

  if disable = Images.Count then
    FDisableRender := true;

end;

procedure TGUIMotions.Preload;
begin
  FDisableRender := true;
  case ImageLoading of
    ilLoadOnDemandAndRelease, ilLoadOnDemand: PreLoadImages;
  end;
  FDisableRender := false;
end;

procedure TGUIMotions.SetScrollBar(const Value: TGUIMotionsScrollBar);
begin
  if FScrollBar <> Value then
    FScrollBar.Assign(Value);
end;

procedure TGUIMotions.SetSelected(const Value: Integer);
begin
  if FSelected <> value then
  begin
    FSelected := Value;
    SelectImage(Value);
  end;
end;

procedure TGUIMotions.SetSelectedQuality(Image: integer);
begin
  case FImageQuality of
    iqSelected:
    begin

      FDisableRender := true;

      //PREVIOUS IMAGE
      FImages[GetCurrentSelectedImage].InitSprite(-1);
      //SELECTED IMAGE
      FImages[Image].InitSprite(Image);

      FDisableRender := False;
    end;
  end;
end;

procedure TGUIMotions.SetSelectedScaleFactor(const Value: single);
begin
  if (FSelectedScaleFactor <> value) and (value >= 0.5) then
  begin
    FSelectedScaleFactor := Value;
    EnableMouseRendering(true);
    if Images.Count > 0 then
      SelectImage(GetCurrentSelectedImage);
    Changed;
  end;
end;

function TGUIMotions.GetRenderingCount: integer;
var
  s: integer;
  {$IFDEF LOADALLONSCROLL}
  cnt, cc: integer;
  {$ENDIF}
begin
  s := 0;
  case ImageLoading of
    ilLoadOnDemand, ilLoadOnDemandAndRelease:
    begin
      s := FShowImageCount;
      {$IFDEF LOADALLONSCROLL}
      cc := GetCurrentSelectedImage;
      cnt := Abs(cc - GetCountVisible) + 1;
      if Abs(cc - FPrevCC) > cnt then
      begin
        if cc < FPrevCC then
          s := FPrevCC + cnt
        else if cc > FPrevCC then
          s := cc + cnt;
      end;
      {$ENDIF}
    end;
    ilLoadAll: s := Images.Count;
  end;

  if s > Images.Count then
    s := Images.Count;

  Result := s;

  Result := Max(0, Min(Result, Images.Count));
end;

function TGUIMotions.GetSliderPosition: TPoint;
begin
  with ScrollBar do
    Result := Point(Round(Left + FVertex[26].position.x), Round(Top));
end;

function TGUIMotions.GetSliderPositionImage: integer;
var
  rwc: Single;
  arrow: Single;
begin
  with ScrollBar do
  begin
    arrow := FVertex[5].position.X;
    rwc := FWidth - SlideWidth - (arrow) * 2;
    Result := Round((Images.Count - 1) / rwc * (GetSliderPosition.X - arrow));
  end;
end;

function TGUIMotions.GetStartCount: integer;
  {$IFDEF LOADALLONSCROLL}
var
  cc: integer;
  cnt: integer;
  {$ENDIF}
begin
  Result := GetCountVisible;
  case ImageLoading of
    ilLoadAll: Result := 0;
    ilLoadOnDemandAndRelease, ilLoadOnDemand:
    begin
      {$IFDEF LOADALLONSCROLL}
      cc := GetCurrentSelectedImage;
      cnt := Abs(cc - Result);
      if Abs(cc - FPrevCC) > cnt then
      begin
        if cc > FPrevCC then
          Result := FPrevCC
        else if cc < FPrevCC then
          Result := cc - cnt;
      end;
      {$ENDIF}
    end;
  end;
  result := Max(0, Min(Result, Images.Count - 1));
end;

function TGUIMotions.GetVersion: string;
begin
  Result := Fversion;
end;

function TGUIMotions.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

function TGUIMotions.GetVersionString: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' + IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn))) + ' ' + DATE_VER;
end;

procedure TGUIMotionsImage.SetX(var x: Single; cc: integer);
var
  cw, ii, ofs, cwidth: integer;
begin
  cw := FOwner.PictureWidth;
  ofs := cw;
  cwidth := (Fowner.Width - cw) div 2;
  x := 0;
  if Index < cc then
  begin
    x := cwidth - (ofs + ((cc - 1) - Index) * cw);
  end
  else if Index > cc then
  begin
    ii := Index - cc - 1;
    x := cwidth + (ofs + ii * cw);
  end
  else if Index = cc then
  begin
    x := cwidth;
  end;
end;

procedure TGUIMotions.AnimatePicture(Image: integer);
var
  ccprev, start, stop, cc, i, ii, cw, ofs: integer;
  shiftx, shifty, x, y, cwidth: Single;
begin
  FDisableRender := false;
  SetSelectedQuality(Image);
  ccprev := GetCurrentSelectedImage;
  SetCount(Image);
  Preload;
  cc := GetCurrentSelectedImage;
  
  case AnimationMode of
  amImageStrip:
    begin
      for I := 0 to Images.Count - 1 do
      begin
        with Images[i] do
        begin
          cw := PictureWidth;
          ofs := cw;
          cwidth := (Self.Width - cw) / 2;

          if Images[I].FCIndex < Images[cc].FCIndex then
          begin
            FTox := cwidth - (ofs + ((Images[cc].FCIndex - 1) - Images[I].FCIndex) * cw);
          end
          else if Images[I].FCIndex > Images[cc].FCIndex then
          begin
            ii := Images[I].FCIndex - Images[cc].FCIndex - 1;
            FTox := cwidth + (ofs + ii * cw);
          end
          else if Images[I].FCIndex = Images[cc].FCIndex then
          begin
            FTox := cwidth;
          end;

          if I = cc then
          begin
            FToy := (Fowner.Height - GetPictureAspectHeight) / 2;
            FNormalizeAndScaleUp := true;
            FNormalize := false;
            FScaleUp := false;
            FScaleDown := true;
          end
          else
          begin
            case FOwner.ImageStripPosition of
              ispAuto: FToy := (Fowner.Height - GetPictureAspectHeight) / (FOwner.ImageRowCount + 1) + (FRIndex * GetPictureAspectHeight);
              ispMargin: FToy := FOwner.ImageStripMargin + (FRIndex * GetPictureAspectHeight);
            end;
            FNormalizeAndScaleDown := true;
            FNormalize := false;
            FScaleDown := false;
            FScaleUp := true;
          end;
        end;
      end;
    end;
    amConicalInnerBand, amConicalOuterBand:
    begin
      start := cc;
      stop := GetRenderingCount - 1;
      for I := start to stop do
      begin
        with FImages[I] do
        begin
          Fx := CountVertices * (Index - cc);

          if ccprev > cc then
          begin
            fxTo := fx;
            fxFrom := fx - CountVertices;
          end
          else
          begin
            fxTo := fx;
            fxFrom := fx + CountVertices;
          end;

          FillCylinderVertex;
          SetX(x, cc);
          FHTotalx := PictureWidth - FHTotalx;
          shiftx := 0;
          shifty := 0;
          if Index > cc then
          begin
            FHTotalx := FHTotalx + FOwner.FImages[Index - 1].FHTotalx;
            FHTotaly := FHTotaly + FOwner.FImages[Index - 1].FHTotaly;
            shiftx := FOwner.FImages[Index - 1].FHTotalx;
            shifty := FOwner.FImages[Index - 1].FHTotaly;
          end;

          x := x - shiftx;
          y := ((FOwner.Height - GetPictureAspectHeight) / 2) + shifty;

          Ftox := x;

          if I <> cc then
          begin
            FToy := y;
            FNormalizeAndScaleDown := true;
            FNormalize := true;
            FScaleDown := false;
            FScaleUp := true;
            FAc := true;
          end
          else
          begin
            FToy := y;
            FNormalizeAndScaleUp := true;
            FNormalize := true;
            FScaleDown := true;
            FScaleUp := false;
            FAc := false;
            FillVertex(FVertex, false);
            FillVertex(FAltVertex, true);
          end;
        end;
      end;

      stop := 0;
      for I := start downto stop do
      begin
        with FImages[I] do
        begin
          Fx := CountVertices * (Index - cc);
          if ccprev > cc then
          begin
            fxTo := fx;
            fxFrom := fx - CountVertices;
          end
          else
          begin
            fxTo := fx;
            fxFrom := fx + CountVertices;
          end;          

          FillCylinderVertex;
          SetX(x, cc);
          FHtotalx := PictureWidth - FHTotalx;
          shiftx := 0;
          shifty := 0;
          if Index < cc then
          begin
            FHTotalx := FHTotalx + FOwner.FImages[Index + 1].FHTotalx;
            FHTotaly := FHTotaly + FOwner.FImages[Index + 1].FHTotaly;
            shiftx := FHTotalx;
            shifty := FHTotaly;
          end;

          x := x + shiftx;
          y := ((FOwner.Height - GetPictureAspectHeight) / 2) - shifty;

          Ftox := x;
          Ftoy := y;

          if I <> cc then
          begin
            FToy := y;
            FNormalizeAndScaleDown := true;
            FNormalize := true;
            FScaleDown := false;
            FScaleUp := true;
            FAc := true;
          end
          else
          begin
            FToy := y;
            FNormalizeAndScaleUp := true;
            FNormalize := true;
            FScaleDown := true;
            FScaleUp := false;
            FAc := false;
            FillVertex(FVertex, false);
            FillVertex(FAltVertex, true);            
          end;
        end;
      end;
    end;
  end;
end;

procedure TGUIMotions.AnimatePictureRoll(Image: integer);
var
  i, cc, p: integer;
begin
  FDisableRender := false;
  SetSelectedQuality(Image);
  SetCount(Image);
  Preload;

  cc := GetCurrentSelectedImage;

  if cc < Image then
    FPageState := psPageLeft
  else
    FPageState := psPageRight;

  for I := 0 to Images.Count - 1 do
  begin
    with Images[i] do
    begin
      if I < cc then
      begin
        p := GetPictureAspectHeight + Min((cc - I) * 3, 30);
        FVertexPosition[3].position.y := -p;
        FVertexPosition[2].position.y := -p;
      end
      else if I >= cc then
      begin
        p := GetPictureAspectHeight + Min((I - cc) * 3, 30);
        FVertexPosition[3].position.y := p;
        FVertexPosition[2].position.y := p;
      end;

      FNormalizeAndScaleDown := true;
      FNormalize := true;
      FScaleDown := true;
      FScaleUp := true;
    end;
  end;
end;

procedure TGUIMotions.SetPageState(Image: integer);
begin
  if GetCurrentSelectedImage < Image then
    FPageState := psPageLeft
  else
    FPageState := psPageRight;
end;

procedure TGUIMotions.SetPictureDistance(const Value: integer);
begin
  if FPictureDistance <> value then
  begin
    FPictureDistance := Value;
  end;
end;

procedure TGUIMotions.SetPictureHeight(const Value: integer);
begin
  if FPictureHeight <> value then
  begin
    FPictureHeight := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetPictureHeightZoomed(const Value: integer);
begin
  if FPictureHeightZoomed <> value then
    FPictureHeightZoomed := Max(FPictureHeight, Value);
end;

procedure TGUIMotions.SetPictureWidth(const Value: integer);
begin
  if FPictureWidth <> value then
  begin
    FPictureWidth := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetPictureWidthZoomed(const Value: integer);
begin
  if FPictureWidthZoomed <> value then
    FPictureWidthZoomed := Max(FPictureWidth, value);
end;

procedure TGUIMotions.AnimatePictureTurn(Image: integer);
var
  i, cc, p: integer;
begin
  FDisableRender := false;
  SetSelectedQuality(Image);
  SetCount(Image);
  SetPageState(Image);
  Preload;

  cc := GetCurrentSelectedImage;
  for I := 0 to Images.Count - 1 do
  begin
    with Images[i] do
    begin
      if I < cc then
      begin
        p := PictureWidth + Min((cc - I) * 3, 30);
        FVertexPosition[1].position.x := -p;
        FVertexPosition[3].position.x := -p;
        FVertexPosition[5].position.x := -p;
        FVertexPosition[7].position.x := -p;
      end
      else if I >= cc then
      begin
        p := PictureWidth + Min((I - cc) * 3, 30);
        FVertexPosition[1].position.x := p;
        FVertexPosition[3].position.x := p;
        FVertexPosition[5].position.x := p;
        FVertexPosition[7].position.x := p;
      end;

      FNormalizeAndScaleDown := true;
      FNormalize := true;
      FScaleDown := false;
      FScaleUp := true;
    end;
  end;
end;

procedure TGUIMotions.AnimateRoloDex(Sender: TObject);
var
  i, disable: integer;
  d1, d2: Double;
begin
  if (csDestroying in ComponentState) then
    exit;

  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      d1 := Abs(FVertex[2].position.y - FvertexPosition[2].position.y) / AnimationFactor;
      Fto1 := AnimateDouble(FVertex[2].position.y,FvertexPosition[2].position.y, d1, AnimationMargin);

      if Abs(FVertex[2].position.y) > GetPictureAspectHeight div 5 then
      begin
        d2 := Abs(FVertex[3].position.y - FvertexPosition[3].position.y) / AnimationFactor;
        Fto2 := AnimateDouble(FVertex[3].position.y,FvertexPosition[3].position.y, d2, AnimationMargin);
      end;

      FBookanimated := (FVertex[3].position.y < 0);

      //NORMALIZE
      if FNormalizeAndScaleDown then
      begin
        if not fNormalize then
          FNormalize := Normalize;

        if not FScaleDown then
          FScaleDown := ScaleDown;

         if FNormalize and FScaleDown then
           FNormalizeAndScaleDown := false;
      end;

      DoMouseActions;
    end;
  end;

  RenderRoloDex;

  disable := 0;
  for i := 0 to Images.Count - 1 do
    with Images[I] do
      if not FNormalizeAndScaleDown and Fto1 and Fto2 then
        Inc(disable);

  if disable = Images.Count then
    FDisableRender := true;
end;

procedure TGUIMotions.AnimateStackedPicture(Image: integer);
var
  i, ii, cx, cy, cc: integer;
  cw, ofs, v: double;
begin
  FDisableRender := false;
  SetSelectedQuality(Image);
  SetCount(Image);
  Preload;

  cc := GetCurrentSelectedImage;
  for I := 0 to Images.Count - 1 do
  begin
    with Images[i] do
    begin
      cw := PictureDistance;
      ofs := cw;
      cx := (Self.Width - PictureWidth) div 2;
      cy := (Self.Height - GetPictureAspectHeight) div 2;

      if I < cc then
      begin
        v := (ofs + ((cc - 1) - i) * cw);
        case AnimationMode of
          amImageBandLeft:
          begin
            FTox := cx + v;
            FSToX := FTox / cx;
          end;
          amImageBandRight:
          begin
            FTox := cx - v;
            FSToX := (Self.Width - Ftox) / (Self.Width - cx) ;
          end;
        end;
        Ftoy := cy + v;
        FSToY := FStox;
      end
      else if I > cc then
      begin
        ii := i - cc - 1;
        v := (ofs + ii * cw);
        case AnimationMode of
          amImageBandLeft:
          begin
            FTox := cx - v;
            FSToX := Ftox / cx;
          end;
          amImageBandRight:
          begin
            FTox := cx + v;
            FSToX := (Self.Width - Ftox) / (Self.Width - cx) ;
          end;
        end;
        FSToY := FStox;
        FToY := cy - v;
      end
      else if I = cc then
      begin
        FToX := cx;
        FToy := cy;
        FSToX := 1;
        FSToY := 1;
      end;
    end;
  end;
end;

procedure TGUIMotions.AnimateStackedPictures(Sender: TObject);
var
  i, disable: integer;
  dx, dy, sx, sy: Double;
begin
  if (csDestroying in ComponentState) then
    exit;
    
  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      // SLIDE X
      dx := Abs(FPositionV.x - FTox) / FAnimationFactor;
      FSlideX := AnimateDouble(FPositionV.x, FTox, Dx, AnimationMargin);

      // SLIDE Y
      dy := Abs(FPositionV.y - FToy) / FAnimationFactor;
      FSlideY := AnimateDouble(FPositionV.y, FToy, Dy, AnimationMargin);

      if (Images[GetCurrentSelectedImage].ImageZoomed = zZoomedOut) then
      begin
        //SCALE X
        sx := Abs(FScaleV.x - FSToX) / FAnimationFactor;
        FScaleX := AnimateDouble(FScaleV.x, FStox, sx, AnimationMargin);

        //SCALE Y
        sy := Abs(FScaleV.y - FSToY) / FAnimationFactor;
        FScaleY := AnimateDouble(FScaleV.y, FStoy, sy, AnimationMargin);
      end;

      DoMouseActions;
    end;
  end;

  RenderStackedPictures;

  disable := 0;
  for I := 0 to Images.Count - 1 do
    with Images[I] do
      if FSlideX and FSlideY and FScaleX and FScaleY then
        Inc(disable);

  if disable = Images.Count then
    FDisableRender := true;

end;

procedure TGUIMotions.ApplyScrollBarVB;
begin
  with ScrollBar do
  begin
    if FVertexBuffer = nil then
      exit;

    if FAILED(FVertexBuffer.Lock(0, SizeOf(FVertex), fpVertices, 0))
    then Exit;

    CopyMemory(fpVertices, @FVertex, SizeOf(FVertex));

    FVertexBuffer.Unlock;
  end;
end;

procedure TGUIMotions.Assign(Source: TPersistent);
begin
  if (Source is TGUIMotions) then
  begin
    FAllowInteraction := (Source as TGUIMotions).AllowInteraction;
    FAnimationMode := (Source as TGUIMotions).AnimationMode;
    FAnimationFactor := (Source as TGUIMotions).AnimationFactor;
    FBackColor := (Source as TGUIMotions).BackColor;
    FCaptionFont.Assign((Source as TGUIMotions).CaptionFont);
    FCaptionLeft := (Source as TGUIMotions).CaptionLeft;
    FCaptionTop := (Source as TGUIMotions).CaptionTop;
    FCaptionPosition := (Source as TGUIMotions).CaptionPosition;
    FImages.Assign((Source as TGUIMotions).Images);
    FImageQuality := (Source as TGUIMotions).ImageQuality;
    FImageMode := (Source as TGUIMotions).ImageMode;
    FImageRowCount := (Source as TGUIMotions).ImageRowCount;
    FImageLoading := (Source as TGUIMotions).ImageLoading;
    FMirror := (Source as TGUIMotions).Mirror;
    Align := (Source as TGUIMotions).Align;
    FMirrorColor := (Source as TGUIMotions).MirrorColor;
    FMirrorTopAlpha := (Source as TGUIMotions).MirrorTopAlpha;
    FMirrorBottomAlpha := (Source as TGUIMotions).MirrorBottomAlpha;
    FGlow := (Source as TGUIMotions).Glow;
    FGlowColor := (Source as TGUIMotions).GlowColor;
    FGlowSize := (Source as TGUIMotions).GlowSize;
    FPictureWidth := (Source as TGUIMotions).PictureWidth;
    FPictureHeight := (Source as TGUIMotions).PictureHeight;
    FPictureDistance := (Source as TGUIMotions).PictureDistance;
    FSkewPercentage := (Source as TGUIMotions).SkewPercentage;
    FCaptionMode := (Source as TGUIMotions).CaptionMode;
    FScrollBar.Assign((Source as TGUIMotions).ScrollBar);
    FImageStripMargin := (source as TGUIMotions).ImageStripMargin;
    FImageStripPosition := (Source as TGUIMotions).ImageStripPosition;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.BeginUpdate;
begin
  StopThread;
end;

function TGUIMotions.BuildPresentationParameters: TD3DPresentParameters;
var
  d3dpp: TD3DPresentParameters;
  d3ddm: TD3DDisplayMode;
  total: DWORD;  
begin
  // Set up the structure used to create the D3DDevice
  FillChar(d3dpp, SizeOf(d3dpp), 0);
  d3dpp.Windowed := True;
  d3dpp.SwapEffect := D3DSWAPEFFECT_DISCARD;
  d3dpp.BackBufferFormat := D3DFMT_UNKNOWN;
  d3dpp.EnableAutoDepthStencil := True;
  d3dpp.AutoDepthStencilFormat := D3DFMT_D16;
  d3dpp.BackBufferWidth := Self.Width;
  d3dpp.BackBufferHeight := Self.Height;

  FD3D.GetAdapterDisplayMode(D3DADAPTER_DEFAULT, d3ddm);

  if Succeeded(FD3D.CheckDeviceMultiSampleType(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, d3ddm.Format,
    true, D3DMULTISAMPLE_NONMASKABLE, @total))then
    begin
      d3dpp.MultiSampleType :=  D3DMULTISAMPLE_NONMASKABLE;
      d3dpp.MultiSampleQuality := total - 1;
    end;

  Result := d3dpp;
end;

procedure TGUIMotionsImage.SetImagePosition(J, k, i: integer; w, h: single);
var
  cc: integer;
  p, x, y, tox, toy, shiftx, shifty: single;
begin
  x := 0;
  y := 0;
  tox := 0;
  toy := 0;
  case Fowner.AnimationMode of
    amCarousel:
    begin
      x := w + (I * FOwner.PictureWidth);
      y := h;
      Tox := x;
    end;
    amImageBandRight:
    begin
      x := w + (I * FOwner.PictureWidth div 2);
      y := h + (I * GetPictureAspectHeight div 4);
      Tox := x;
      toy := y;
    end;
    amImageBandLeft:
    begin
      x := w - (I * FOwner.PictureWidth div 2);
      y := h - (I * GetPictureAspectHeight div 4);
      Tox := x;
      toy := y;
    end;
    amBook:
    begin
      x := w;
      y := (FOwner.Height - GetPictureAspectHeight) / 2;
      tox := x;
      cc := FOwner.FSelected;
      if Index < cc then
      begin
        p := Fowner.PictureWidth + Min((cc - Index) * 3, 30);
        FFakeVertex[1].position.x := -p;
        FFakeVertex[3].position.x := -p;
        FFakeVertex[5].position.x := -p;
        FFakeVertex[7].position.x := -p;
      end
      else if Index >= cc then
      begin
        p := Fowner.PictureWidth + Min((Index - cc) * 3, 30);
        FFakeVertex[1].position.x := p;
        FFakeVertex[3].position.x := p;
        FFakeVertex[5].position.x := p;
        FFakeVertex[7].position.x := p;
      end;
    end;
    amRoloDex:
    begin
      x := w;
      y := h;
      tox := x;
      cc := FOwner.FSelected;
      if Index < cc then
      begin
        p := GetPictureAspectHeight + Min((cc - Index) * 3, 30);
        FVertex[3].position.y := -p;
        FVertex[2].position.y := -p;
      end
      else if Index >= cc then
      begin
        p := GetPictureAspectHeight + Min((Index - cc) * 3, 30);
        FVertex[3].position.y := p;
        FVertex[2].position.y := p;
      end;
    end;
    amConicalInnerBand, amConicalOuterBand:
    begin
      FHTotalX := FOwner.PictureWidth - FHTotalX;
      if Index > FOwner.GetCurrentSelectedImage then
      begin
        FHTotalX := FHTotalX + FOwner.FImages[Index - 1].FHTotalx;
        FHTotalY := FHTotalY + FOwner.FImages[Index - 1].FHTotaly;
      end
      else if Index < FOwner.GetCurrentSelectedImage then
      begin
        FHTotalX := FHTotalX + FOwner.FImages[Index + 1].FHTotalx;
        FHTotalY := FHTotalY + FOwner.FImages[Index + 1].FHTotaly;
      end;

      shiftx := 0;
      shifty := 0;

      if Index > FOwner.GetCurrentSelectedImage then
      begin
        shiftx := FOwner.FImages[Index - 1].FHTotalx;
        shifty := FOwner.FImages[Index - 1].FHTotaly;
      end
      else if Index < FOwner.GetCurrentSelectedImage then
      begin
        shiftx := FHTotalx;
        shifty := FHTotaly;
      end;

      x := w + (index * FOwner.PictureWidth) + shiftx;
      y := h + shifty;

      tox := x;
      toy := y;
    end;
    amImageStrip:
    begin
      x := w + (J * FOwner.PictureWidth);
      y := 0;
      case FOwner.ImageStripPosition of
        ispAuto: y := (Fowner.Height - GetPictureAspectHeight) div (FOwner.ImageRowCount + 1) + (K * GetPictureAspectHeight);
        ispMargin: y := FOwner.ImageStripMargin + (K * GetPictureAspectHeight);
      end;
      Tox := x;
      toy := y;
      FCIndex := J;
      FRIndex := K;
    end;
  end;
  InitImage(x, y, tox, toy)
end;

procedure TGUIMotions.PreLoadImages;
var
  i, j, K: Integer;
  w, h: Single;
begin
  FDisableRender := true;
  case ImageLoading of
    ilLoadOnDemandAndRelease:
    begin
      for I := 0 to GetStartCount do
      begin
        with Images[I] do
        begin
          if FTexture <> nil then
          begin
            FSPInit := false;
            FTexture._AddRef;
            FTexture._Release;
            FTexture := nil;
          end;
        end;
      end;
      for I := GetStartCount + GetRenderingCount to Images.Count - 1 do
      begin
        with Images[I] do
        begin
          if FTexture <> nil then
          begin
            FSPInit := false;
            FTexture._AddRef;
            FTexture._Release;
            FTexture := nil;
          end;
        end;
      end;
    end;
  end;

  //Start row and columnIndex
  K := Images[FStartImageCount - 1].FRIndex + 1;
  J := Images[FStartImageCount - 1].FCIndex;

  if K >= ImageRowCount then
  begin
    Inc(J);
    K := 0;
  end;

  for I := GetStartCount to GetRenderingCount - 1 do
  begin
    with Images[I] do
    begin
      if not FSPInit then
      begin
        if Succeeded(InitSprite(GetCurrentSelectedImage)) then
        begin
          w := (Self.Width - PictureWidth) / 2;
          h := (Self.Height - GetPictureAspectHeight) / 2;
          if I > FStartImageCount then
          begin
            K := Images[I - 1].FRIndex + 1;
            J := Images[I - 1].FCIndex;
            if K >= ImageRowCount then
            begin
              Inc(J);
              K := 0;
            end;
          end;

          FSPInit := true;
          if FSPInit and not FVBInit then
            if Succeeded(InitVB) then
              FVBInit := true;

          if FVBInit then
            SetImagePosition(J, K, I, w, h);

        end;
      end;
    end;
  end;
  FDisableRender := false;
end;

procedure TGUIMotions.PreviousImage;
begin
  ResetImageStatus(-1, -1, GetCurrentSelectedImage - 1, true);
end;

procedure TGUIMotions.AnimateBook(Sender: TObject);
var
  i: integer;
  d1, d2: Double;
  to1, to2, to3, to4: single;
  disable: integer;
begin
  if (csDestroying in ComponentState) then
    exit;
    
  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      to1 := FVertexPosition[1].position.x;
      to2 := FvertexPosition[3].position.x;
      to3 := FvertexPosition[7].position.x;
      to4 := FvertexPosition[5].position.x;

      d1 := Abs(FFakeVertex[1].position.x - to1) / AnimationFactor;
      FTo1 := AnimateDouble(FFakeVertex[1].position.x,to1, d1, AnimationMargin);

      if Abs(FFakeVertex[1].position.x) > PictureWidth div 5 then
      begin
        d2 := Abs(FFakeVertex[3].position.x - to2) / AnimationFactor;
        FTo2 := AnimateDouble(FFakeVertex[3].position.x,to2, d2, AnimationMargin);
      end;

      d1 := Abs(FFakeVertex[7].position.x - to3) / AnimationFactor;
      FTo3 := AnimateDouble(FFakeVertex[7].position.x,to3, d1, AnimationMargin);

      if Abs(FFakeVertex[7].position.x) > PictureWidth div 5 then
      begin
        d2 := Abs(FFakeVertex[5].position.x - to4) / AnimationFactor;
        FTo4 := AnimateDouble(FFakeVertex[5].position.x,to4, d2, AnimationMargin);
      end;

      FBookanimated := (FFakeVertex[3].position.x < -(PictureWidth / 3));

      d1 := Abs(FVertex[2].position.y - FvertexPosition[2].position.y) / AnimationFactor;
      Fto1 := AnimateDouble(FVertex[2].position.y,FvertexPosition[2].position.y, d1, AnimationMargin);

      if Abs(FVertex[2].position.y) > GetPictureAspectHeight div 5 then
      begin
        d2 := Abs(FVertex[3].position.y - FvertexPosition[3].position.y) / AnimationFactor;
        Fto2 := AnimateDouble(FVertex[3].position.y,FvertexPosition[3].position.y, d2, AnimationMargin);
      end;


      //NORMALIZE
      if FNormalizeAndScaleDown then
      begin
        if not fNormalize then
          FNormalize := Normalize;

        if not FScaleDown then
          FScaleDown := ScaleDown;

         if FNormalize and FScaleDown then
           FNormalizeAndScaleDown := false;
      end;

      DoMouseActions;
    end;
  end;

  RenderBook;  

  disable := 0;
  for i := 0 to Images.Count - 1 do
    with Images[I] do
      if not FNormalizeAndScaleDown and Fto1 and Fto2 and Fto3 and Fto4 then
        Inc(disable);

  if disable = Images.Count then
    FDisableRender := true;
end;

procedure TGUIMotions.AnimateCarouselImage(Image: integer);
var
  I, ii, cc: integer;
  cw, cww: Double;
  c: Double;
  ofs: Double;
begin
  FDisableRender := false;
  SetSelectedQuality(Image);
  SetCount(Image);
  Preload;

  cc := GetCurrentSelectedImage;
  for I := 0 to Images.Count - 1 do
  begin
    with Images[i] do
    begin
      cw := PictureWidth;
      cww := PictureDistance;
      ofs := cw * Max(1, (SelectedScaleFactor - 1));
      c := (Self.Width - PictureWidth) div 2;
      if i < cc then
      begin
        FTox := c - (ofs + ((cc - 1) - i) * cww);
        if not (FState = isSkewLeft) then
        begin
          FNormalizeAndScaleUp := false;
          FNormalizeAndScaleDownRight := false;
          FNormalizeAndScaleDownLeft := true;
        end;
      end
      else if i > cc then
      begin
        ii := (i - cc - 1);
        FTox := c + (ofs + ii * cww);
        if not (FState = isSkewRight) then
        begin
          FNormalizeAndScaleDownRight := true;
          FNormalizeAndScaleUp := false;
          FNormalizeAndScaleDownLeft := false;
        end;
      end
      else
      begin
        FTox := c;
        if not (FState = isNormal) then
        begin
          FNormalizeAndScaleUp := true;
          FNormalizeAndScaleDownLeft := false;
          FNormalizeAndScaleDownRight := false;
        end;
      end;
      //INIT
      FNormalize := false;
      FSkewRight := false;
      FSkewLeft := false;
      FScaleDown := false;
      FScaleUp := false;
    end;
  end;
end;

procedure TGUIMotions.CheckDeviceLost;
begin
  if FD3DDevice.TestCooperativeLevel = D3DERR_DEVICENOTRESET then
  begin
    FDisableRender := true;
    if FD3DInitialized then
      if Succeeded(FD3DDevice.TestCooperativeLevel) then
        FD3DDevice.Reset(BuildPresentationParameters);

    Reset;
  end;
end;

function TGUIMotions.CheckGlow: Boolean;
begin
  Result := true;
  if Images.Count > 0 then
    with Images[GetCurrentSelectedImage] do
      if Glow and not FAlternate then
        if FGlowOpacity < 255 then
          Result := false;
end;

procedure TGUIMotions.CheckMouseActionLeft;
var
  cc, i: integer;
  wleft, wright: single;
  allowzoom: Boolean;
begin
  cc := GetCurrentSelectedImage;
  if Images[cc].FImageZoomed = zZoomedIn then
    DoImageUnZoom(cc, Images[cc].GetPictureRectangle);

  FDisableMouseRender := false;
  with Images[cc] do
  begin
    FImageClicked := true;
    allowzoom := true;
    
    if FImageSelected = sNormal then
      ImageClick(allowzoom, FD3DDevice, cc)
    else
      AlternateImageClick(cc, allowzoom, FD3DDevice);
    
    if FImageSelected = sNormal then
      ImageLeftClick(allowzoom, FD3DDevice, cc)
    else
      AlternateImageLeftClick(cc, allowzoom, FD3DDevice);

    if not allowzoom then
    begin
      FDisableMouseRender := true;
      exit;
    end;

    if (FImageZoomed = zZoomedIn) then
    begin
      FMouseActionOut := true;
      FMouseActionIn := false;
      FImageBandAnimated := false;
      FImageZoomed := zZoomedOut;
      wleft := -width / 2;
      wright := -wleft;
      case AnimationMode of
        amImageBandLeft, amImageBandRight: FToX := (Width - PictureWidth) div 2;
      end;
    end
    else
    begin
      FMouseActionOut := false;
      FMouseActionIn := true;
      FImageBandAnimated := true;
      FImageZoomed := zZoomedIn;
      wLeft := width / 2;
      wRight := -wleft;
      case AnimationMode of
        amImageBandRight, amImageBandLeft: FToX := (Width - PictureWidth) div 2;
      end;
    end;

    for I := 0 to Images.Count - 1 do
    begin
      with Images[I] do
      begin
        if I <> cc then
        begin
          if AnimationMode = amImageBandRight then
            FToX := Ftox + wright
          else if AnimationMode = amImageBandLeft then
            Ftox := Ftox + wleft;
        end;
      end;
    end;
  end;
end;

procedure TGUIMotions.CheckMouseActionRight;
var
  cc: integer;
  allowalternate, check: Boolean;
begin
  FDisableMouseAlternateRender := false;
  cc := GetCurrentSelectedImage;
  with FImages[cc] do
  begin
    allowalternate := true;
    if FImageSelected = sNormal then
      ImageRightClick(allowalternate, FD3DDevice, cc)
    else
      AlternateImageRightClick(cc, allowalternate, FD3DDevice);

    if not allowalternate then
      exit;

    check := true;
    case AnimationMode of
      amBook, amRoloDex, amImageBandRight, amImageBandLeft: check := (FImageZoomed = zZoomedIn);
    end;

    if FAlternate and check then
    begin
      case FImageSelected of
        sAlternate:
        begin
          FImageSelected := sNormal;
          FNormalize := false;
          FAnimateNormal := true;
          FAnimateAlternate := false;
        end;
        sNormal:
        begin
          FImageSelected := sAlternate;
          FAnimateAlternate := true;
          FAnimateNormal := false;
        end;
      end;

      FDisableRender := true;
      InitSprite(-1);
      SetSelectedQuality(cc);
      FDisableRender := false;
    end
    else
      FDisableMouseAlternateRender := true;
  end;
end;

procedure TGUIMotions.Click;
begin
  inherited;
  Self.SetFocus;
end;

constructor TGUIMotions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAllowInteraction := true;
  FSelectedScaleFactor := 2;  
  ControlStyle := ControlStyle + [csAcceptsControls];
  FReset := true;
  Width := 640;
  Height := 480;
  TabStop := true;
  DoubleBuffered := True;
  FCaptionPosition := spBottomCenter;
  FGlow := false;
  FGlowColor := clWhite;
  FGlowAnimation := true;
  FMirror := true;
  FGlowSize := 4;
  FPictureWidth := 200;
  FPictureHeight := 200;
  FPictureWidthZoomed := 350;
  FPictureHeightZoomed := 350;
  FMirrorBottomAlpha := 0;
  FMirrorTopAlpha := 150;
  FSkewPercentage := 80;
  FMirrorColor := clWhite;
  FPictureDistance := 70;
  FCaptionMode := cmFileName;
  FSlideOutDistance := 50;
  FImageMode := imNormal;
  FDisableMouseRender := true;
  FDisableMouseAlternateRender := true;
  FVersion := GetVersionString;
  FImageStripMargin := 30;
  FImageStripPosition := ispAuto;

  //flow
  FAnCarousel := TTimer.Create(Self);
  FAnCarousel.Enabled := false;
  FAnCarousel.Interval := 10;
  FAnCarousel.OnTimer := AnimateCarousel;
  //Rolodex
  FanRolodex := TTimer.Create(Self);
  FanRolodex.Enabled := false;
  FanRolodex.Interval := 10;
  FanRolodex.OnTimer := AnimateRoloDex;
  //Book
  FAnBook := TTimer.Create(Self);
  FAnBook.Enabled := false;
  FAnBook.Interval := 10;
  FAnBook.OnTimer := AnimateBook;
  //piclens
  FAnImageStrip := TTimer.Create(Self);
  FAnImageStrip.Enabled := false;
  FAnImageStrip.Interval := 10;
  FAnImageStrip.OnTimer := AnimateImageStrip;
  //stacked
  FanStacked := TTimer.Create(Self);
  FanStacked.Enabled := false;
  FanStacked.Interval := 10;
  FanStacked.OnTimer := AnimateStackedPictures;

  FAnimationFactor := 15;
  FImageRowCount := 3;
  FStartImageCount := 9;
  FShowImageCount := 9;
  FSelected := 0;

  FShowPreLoader := false;
  FBackColor := clGray;
  FImageLoading := ilLoadOnDemand;
  FImageQuality := iqSelected;
  FAnimationMode := amCarousel;

  FImageLoaderThread := nil;

  FImages := TGUIMotionsImages.Create(Self);
  FScrollBar := TGUIMotionsScrollBar.Create(Self);

  FCaptionFont := TFont.Create;
  FCaptionFont.Size := 30;

  FDefaultPicture := TPicture.Create;
  FDefaultAlternatePicture := TPicture.Create;

  FKeyboardLookup := false;
end;

procedure TGUIMotions.InitD3DFonts;
var
  weight, nheight: integer;
  s: ansistring;
begin
  weight := 0;
  if fsBold in Font.Style then
    weight := FW_BOLD;

  nHeight := Font.Height;

  s := AnsiString(Font.Name);

  D3DXCreateFont(FD3DDevice, nHeight, 0, weight, 0, fsItalic in Font.Style,
    Font.Charset, OUT_DEFAULT_PRECIS, ANTIALIASED_QUALITY, DEFAULT_PITCH or FF_DONTCARE,
    PAnsiChar(s), FPreLoadFont);


 weight := 0;
  if fsBold in FCaptionFont.Style then
    weight := FW_BOLD;

  nHeight := FCaptionFont.Height;

  s := AnsiString(CaptionFont.Name);

  D3DXCreateFont(FD3DDevice, nHeight, 0, weight, 0, fsItalic in FCaptionFont.Style,
    FCaptionFont.Charset, OUT_DEFAULT_PRECIS, ANTIALIASED_QUALITY ,DEFAULT_PITCH or FF_DONTCARE,
    PAnsiChar(s), FCaptionD3DFont);

end;

procedure TGUIMotions.Initialize;
begin
  if (FImages.Count = 0) or ((AnimationMode = amImageStrip) and (FImageRowCount = 0)) then
    Exit;

  if Images.Count < FStartImageCount then
    FStartImageCount := Images.Count;

  InitImages;
  InitScrollBar;
end;

procedure TGUIMotions.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Images.Count = 0) or (not AllowInteraction) then
    exit;

  FImages[GetCurrentSelectedImage].FIsSelected := false;
  case Key of
    VK_SPACE: CheckMouseActionRight;
    VK_RETURN: CheckMouseActionLeft;  
    VK_LEFT: ResetImageStatus(-1, -1, GetCurrentSelectedImage - 1, true);
    VK_RIGHT: ResetImageStatus(-1, -1, GetCurrentSelectedImage + 1, true);
    VK_HOME: ResetImageStatus(-1, -1, 0, true);
    VK_END: ResetImageStatus(-1, -1, Images.Count - 1, true);
    VK_NEXT:
      begin
        if (GetCurrentSelectedImage < Images.Count - 1 - 10) then
          ResetImageStatus(-1, -1, GetCurrentSelectedImage + 10, true)
        else
          ResetImageStatus(-1, -1, Images.Count - 1, true);
      end;
    VK_PRIOR:
      begin
        if (GetCurrentSelectedImage >= 10) then
          ResetImageStatus(-1, -1, GetCurrentSelectedImage - 10, true)
        else
          ResetImageStatus(-1, -1, 0, true);
      end;
  end;

  if (Key in [VK_LEFT, VK_RIGHT, VK_SPACE, VK_RETURN, VK_HOME, VK_END]) then
    FLookup := '';

  ScrollBar.InitSliderPos(ScrollBar.GetSliderPosByImageIndex(GetCurrentSelectedImage));
  FImages[GetCurrentSelectedImage].FIsSelected := true;  
end;

procedure TGUIMotions.KeyPress(var Key: char);
var
  i: integer;
  flg: boolean;
begin
  inherited;

  if not AllowInteraction then
    Exit;

  if (Key >= '0') and (Key <= 'z') then
    FLookup := FLookup + key;

  if Key = #8 then
  begin
    if Length(FLookup) > 0 then
      Delete(FLookup, Length(FLookup), 1);
  end;

  flg := false;

  for i := 0 to Images.Count - 1 do
  begin
    if pos(Uppercase(FLookup), Uppercase(Images[i].Caption)) = 1 then
    begin
      SelectImage(i);
      flg := true;
      break;
    end;
  end;

  if not flg then
    FLookup := '';
end;

procedure TGUIMotions.LastImage;
begin
  ResetImageStatus(-1, -1, Images.Count - 1, true);
end;

procedure TGUIMotions.Loaded;
begin
  if Images.Count <> 0 then
    Initialize;

  inherited;
end;

destructor TGUIMotions.Destroy;
begin
  {$IFDEF USETHREADS}
  StopThread;
  {$ENDIF}
  FAnCarousel.Free;
  FanRolodex.Free;
  FAnImageStrip.Free;
  FAnBook.free;
  FanStacked.Free;
  FCaptionFont.Free;
  D3DFree(true);
  FScrollBar.Free;  
  FImages.Free;
  FDefaultPicture.Free;
  FDefaultAlternatePicture.Free;
  inherited Destroy;
end;

procedure TGUIMotions.DoImageSelected(Image: integer; ImageRectangle: TRect);
begin
  if Assigned(FOnImageSelected) then
    FOnImageSelected(Self, Image, ImageRectangle);
end;

procedure TGUIMotions.DoImageUnZoom(Image: integer; ImageRectangle: TRect);
begin
  if Assigned(FOnImageUnZoom) then
    FOnImageUnZoom(Self, Image, ImageRectangle);
end;

procedure TGUIMotions.EnableMouseRendering(Enabled: Boolean);
begin
  FDisableMouseRender := not enabled;
  FDisableMouseAlternateRender := not enabled;
end;

procedure TGUIMotions.EnableRendering(Enabled: Boolean);
begin
  FDisableRender := not enabled;
end;

procedure TGUIMotions.EnableReset(Enabled: Boolean);
begin
  FReset := Enabled;
end;

procedure TGUIMotions.EndUpdate;
begin
  StartThread;
end;

procedure TGUIMotions.FirstImage;
begin
  ResetImageStatus(-1, -1, 0, true);
end;

procedure TGUIMotionsImage.DisplayCaption;
var
  r, rcal: TRect;
  c: TD3DColor;
  bg: TColor;
  rc, gc, bc: Byte;
  hscroll, tw, th: integer;
  txt: String;
  s: AnsiString;
begin

  case FOwner.CaptionMode of
    cmNone: Exit;
    cmFileName: txt := Caption;
    cmFullPath: txt := FullCaption;
  end;

  bg := ColorToRGB(Fowner.FCaptionFont.Color);
  rc := bg;
  gc := bg shr 8;
  bc := bg shr 16;

  hscroll := 0;
  if FOwner.ScrollBar.Visible and (FOwner.FScrollBar.Position = FOwner.FCaptionPosition) then
    hscroll := FOwner.ScrollBar.Height + 2;

  c := D3DCOLOR_ARGB(255, rc, gc, bc);

  s := AnsiString(txt);

  Fowner.FCaptionD3DFont.DrawTextA(nil, PAnsiChar(s), -1, @rcal, DT_CALCRECT, c);
  tw := rcal.Right - rcal.Left;
  th := rcal.Bottom - rcal.Top;
  case FOwner.FCaptionPosition of
    spTopLeft:  r := Bounds(0, hscroll, tw, th);
    spTopRight:  r := Bounds(FOwner.Width - tw, hscroll, tw, th);
    spBottomLeft:  r := Bounds(0, FOwner.Height - th - hscroll, tw, th);
    spBottomRight:  r := Bounds(FOwner.Width - tw, FOwner.Height - th - hscroll, tw, th);
    spTopCenter:  r := Bounds((FOwner.Width - tw) div 2, hscroll, tw, th);
    spBottomCenter:  r := Bounds((FOwner.Width - tw) div 2, FOwner.Height - th - hscroll, tw, th);
    spCustom:  r := Bounds(FOwner.CaptionLeft, Fowner.CaptionTop, tw, th);
  end;

  Fowner.FCaptionD3DFont.DrawTextA(nil, PAnsiChar(s), Length(s), @r, 0, c);
end;

procedure TGUIMotionsImage.DoMouseActions;
begin
  //ZOOM IN
  if FMouseActionIn then
  begin
    if ZoomIn then
    begin
      FOwner.FDisableMouseRender := true;
      FMouseActionIn := false;
    end;
  end;

  //ZOOM OUT
  if FMouseActionOut then
  begin
    if ZoomOut then
    begin
      FOwner.FDisableMouseRender := true;
      FMouseActionOut := false;
    end;
  end;

  if FAnimateAlternate then
  begin
    if AnimateAlternate then
    begin
      FAnimateAlternate := false;
      Fowner.FDisableMouseAlternateRender := true;
    end;
  end;

  if FAnimateNormal then
  begin
    if AnimateNormal then
    begin
      Fowner.FDisableMouseAlternateRender := true;
      FAnimateNormal := false;
    end;
  end;
end;

procedure TGUIMotionsImage.DrawGlow;
begin
  FOwner.FGlowSprite._Begin(D3DXSPRITE_ALPHABLEND);
  SetupMatrices;
  ApplyNewGlowVB(FGlowVertex);
  Get3DDevice.SetStreamSource(0, Fowner.FVertexGlowBuffer, 0, SizeOf(TCustomVertex));
  Get3DDevice.SetFVF(D3DFVF_CUSTOMVERTEX);
  //LEFT
  Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
  //RIGHT
  Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 4, 2);
  //TOP
  Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 8, 2);
  //BOTTOM
  Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 12, 2);
  FOwner.FGlowSprite._End;
end;

procedure TGUIMotionsImage.DrawMirror;
begin
  if FOwner.Mirror then
  begin
    case Fowner.AnimationMode of
      amConicalInnerBand, amConicalOuterBand:
      begin
        if FAc then
        begin
          ApplyNewVB(FCylinderMirrorVertex);
          Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, CountVertices - 2)
        end
        else
          Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 4, 2);
      end;
      amImageStrip:
      begin
        if FRIndex = FOwner.FImageRowCount - 1 then
          Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 4, 2);
      end;
      else
      begin
        Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
        Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 4, 2);
      end;
    end;
  end;
end;

procedure TGUIMotionsImage.FillVertex(var v: TVertexArray; alternate: Boolean);
var
  pw, ph, pwx, phx: single;
  check: Boolean;
begin
  pw := FOwner.PictureWidth;
  ph := FOwner.PictureHeight;

  if alternate then
  begin
    FImageSelected := sAlternate;
    pwx := pw
  end
  else
    pwx := 0;

  if (FOwner.ImageMode = imAspectRatio) then
  begin
    phx := Fowner.FPictureHeight;
    if (Fowner.ImageMode = imAspectRatio) then
    begin
      check := true;
      case FOwner.AnimationMode of
        amImageStrip: check := (Index = FOwner.GetCurrentSelectedImage);
      end;

      if not alternate then
      begin
        if check then
        begin
          if (fhaspect <> 0) and (fwaspect <> 0) then          
            phx := Round(Fowner.FPictureHeight * (fhaspect / fwaspect))
        end
        else
          phx := FOwner.PictureHeight;
      end
      else
      begin
        if FAlternate then
          if (fhaspectalt <> 0) and (fwaspectalt <> 0) then
            phx := Round(Fowner.FPictureHeight * (fhaspectalt / fwaspectalt));
      end;
    end;
  end
  else
    phx := ph;

  FImageSelected := sNormal;

  with v[0] do
  begin
    position := D3DXVector3(pwx, 0, 0);
    tu := 0;
    tv := 0;
    Color := D3DCOLOR_ARGB(255, 255, 255, 255);
  end;

  with v[1] do
  begin
    position := D3DXVector3(pw, 0, 0);
    tu := 1;
    tv := 0;
    Color := D3DCOLOR_ARGB(255, 255, 255, 255);
  end;

  with v[2] do
  begin
    position := D3DXVector3(pwx, phx, 0);
    tu := 0;
    tv := 1;
    Color := D3DCOLOR_ARGB(255, 255, 255, 255);
  end;

  with v[3] do
  begin
    position := D3DXVector3(pw, phx, 0);
    tu := 1;
    tv := 1;
    Color := D3DCOLOR_ARGB(255, 255, 255, 255);
  end;

  //Mirror with alpha
  with v[4] do
  begin
    position := D3DXVector3(pwx, phx, 0);
    tu := 0;
    tv := 1;
    Color := D3DCOLOR_ARGB(FOwner.FMirrorTopAlpha, 255, 255, 255);
  end;

  with v[5] do
  begin
    position := D3DXVector3(pw, phx, 0);
    tu := 1;
    tv := 1;
    Color := D3DCOLOR_ARGB(FOwner.FMirrorTopAlpha, 255, 255, 255);
  end;

  with v[6] do
  begin
    position := D3DXVector3(pwx, phx * 2, 0);
    tu := 0;
    tv := 0;
    Color := D3DCOLOR_ARGB(FOwner.FMirrorBottomAlpha, 255, 255, 255);
  end;

  with v[7] do
  begin
    position := D3DXVector3(pw, phx * 2, 0);
    tu := 1;
    tv := 0;
    Color := D3DCOLOR_ARGB(FOwner.FMirrorBottomAlpha, 255, 255, 255);
  end;
end;

procedure TGUIMotionsImage.FillCylinderVertex;
var
  k: Integer;
  w, hs, an, cs, angle, csw, csh, wd, wh: Double;
begin
  FHTotalx := 0;
  FHtotaly := 0;
  wd := 0;
  wh := 0;
  an := 90 / CountVertices / (Fowner.Width * 2 / FOwner.PictureWidth);
  w := Fowner.PictureWidth / ((CountVertices - 1) / 2);
  k := 0;
  while k < CountVertices / 2 do
  begin
    angle := DegToRad(Min(90, an * Fowner.Fx));
    cs := Cos(angle);
    hs := Sin(angle);
    if FOwner.AnimationMode = amConicalOuterBand then
      hs := -hs;

    csw := cs * w;
    wd := wd + csw;
    csh := hs * w;
    wh := wh + csh;

    FHTotalx := FHTotalx + cs * (Fowner.PictureWidth / (CountVertices / 2));
    FHTotaly := FHTotaly + hs * (FOwner.PictureHeight / (CountVertices / 2));

    Inc(K);
    if Index <> FOwner.GetCurrentSelectedImage then
      Fowner.Fx := FOwner.Fx + 1;

  end;
end;

procedure TGUIMotionsImage.FillGlowVertex(var v: TVertexArray);
var
  c: TColor;
  a, r, g, b: Byte;
  pw, ph: integer;
  gs: Single;
begin
  pw := FOwner.PictureWidth;
  ph := GetPictureAspectHeight;
  a := FGlowOpacity;
  c := ColorToRGB(FOwner.GlowColor);
  r := c;
  g := c shr 8;
  b := c shr 16;
  gs := FOwner.GlowSize;

  //LEFT
  with v[0] do
  begin
    position := D3DXVector3(-gs, -gs, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  with v[1] do
  begin
    position := D3DXVector3(0, 0, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  with v[2] do
  begin
    position := D3DXVector3(-gs, ph + gs, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  with v[3] do
  begin
    position := D3DXVector3(0, ph, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  //RIGHT
  with v[4] do
  begin
    position := D3DXVector3(pw, 0, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  with v[5] do
  begin
    position := D3DXVector3(gs + pw, -gs, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  with v[6] do
  begin
    position := D3DXVector3(pw, ph, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  with v[7] do
  begin
    position := D3DXVector3(gs + pw, ph + gs, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  //TOP
  with v[8] do
  begin
    position := D3DXVector3(-gs, -gs, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  with v[9] do
  begin
    position := D3DXVector3(0, 0, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  with v[10] do
  begin
    position := D3DXVector3(pw + gs, -gs, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  with v[11] do
  begin
    position := D3DXVector3(pw, 0, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  //BOTTOM
  with v[12] do
  begin
    position := D3DXVector3(0, ph, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  with v[13] do
  begin
    position := D3DXVector3(-gs, gs + ph, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;

  with v[14] do
  begin
    position := D3DXVector3(pw, ph, 0);
    Color := D3DCOLOR_ARGB(a, r, g, b);
  end;

  with v[15] do
  begin
    position := D3DXVector3(pw + gs, gs + ph, 0);
    Color := D3DCOLOR_ARGB(0, r, g, b);
  end;
end;

function TGUIMotions.GetLoadingImagesCount: integer;
var
  k, i: integer;
begin
  k := 0;
  for I := FStartImageCount to FShowImageCount - 1 do
    with Images[I] do
      if not FSPInit then
        Inc(k);

  result := k;
end;

function TGUIMotions.GetCountVisible: integer;
var
  cc, sic: integer;
  w, cww, cw: single;
begin
  cc := GetCurrentSelectedImage;
  sic := 0;
  result := sic;

  if images.Count = 0 then
    Exit;

  case AnimationMode of
    amImageStrip:
    begin
      w := (Width / 2) + PictureWidth;
      sic := (Round(w / PictureWidth) * (FImageRowCount)) - Images[cc].FRIndex;
      Result := Max(0, cc - sic);
    end;
    amCarousel:
    begin
      cw := PictureWidth;
      cww := PictureDistance;
      sic := Round((Width / 2) / (cw - cww));
      Result := cc - sic;
    end;
    amRoloDex, amBook:
    begin
      cw := PictureWidth;
      cww := (PictureDistance / 2);
      w := (Width + cw + cww) / 2;
      sic := Round(w / (cw - cww)) + 1;
      Result := Max(0, cc - sic);
    end;
    amConicalInnerBand, amConicalOuterBand:
    begin
      cw := PictureWidth;
      w := Width / 2;
      sic := Round(w / cw);
      Result := Max(0, cc - sic);
    end;
    amImageBandLeft, amImageBandRight:
    begin
      cw := (PictureHeight / 2);
      w := Width / 2;
      sic := Round(w / cw);
      Result := Max(0, cc - sic);
    end;
  end;
end;

function TGUIMotions.GetCurrentSelectedImage: integer;
var
 c: integer;
begin
  Result := 0;
  if Images.Count > 0 then
  begin
    c := Images.Count - 1;
    if FSelected > c then
      FSelected := c;

    Result := Min(Images.Count - 1, Max(0, FSelected));
  end;
end;

function TGUIMotionsImage.GetPictureAspectHeight: Integer;
var
  check: Boolean;
begin
  Result := Fowner.FPictureHeight;
  if (Fowner.ImageMode = imAspectRatio) then
  begin
    check := true;
    case FOwner.AnimationMode of
      amImageStrip: check := (Index = FOwner.GetCurrentSelectedImage);
    end;

    if check then
    begin
      if (FImageSelected = sNormal) then
        if (fhaspect <> 0) and (fwaspect <> 0) then
          Result := Round(Fowner.FPictureHeight * (fhaspect / fwaspect))
      else
        if FAlternate then
          if (fhaspectalt <> 0) and (fwaspectalt <> 0) then
            Result := Round(Fowner.FPictureHeight * (fhaspectalt / fwaspectalt))
          else
            Result := 0;
    end;
  end;
end;

function TGUIMotionsImage.GetPictureRectangle: TRect;
var
  w, h, x, y: integer;
begin
  x := F3DImagePositionX;
  y := F3DImagePositionY;
  w := F3DImageWidth;
  h := F3DImageHeight;
  Result := Rect(x, y, x + w, y + h);
end;

procedure TGUIMotions.Init;
begin
  Reset;
end;

function TGUIMotions.InitD3D: HRESULT;
var
  d3dpp: TD3DPresentParameters;
begin
  try
    Result:= E_FAIL;

    // Create the D3D object.
    FD3D := Direct3DCreate9(D3D_SDK_VERSION);
    if (FD3D = nil) then Exit;

    d3dpp := BuildPresentationParameters;

    // Create the D3DDevice
    Result:= FD3D.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, WindowHandle,
      D3DCREATE_HARDWARE_VERTEXPROCESSING or D3DCREATE_FPU_PRESERVE, @d3dpp, FD3DDevice);

    if FAILED(Result) then
    begin
      //Try with SOFTWARE Vertex processing
      Result:= FD3D.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, WindowHandle,
      D3DCREATE_SOFTWARE_VERTEXPROCESSING or D3DCREATE_FPU_PRESERVE, @d3dpp, FD3DDevice);
        if Failed(Result) then
        begin
          Result := E_FAIL;
          Exit;
        end;
    end;

    InitD3DFonts;
  except
    on E : Exception do
    begin
      Result := E_FAIL;
    end;
  end;
end;

function TGUIMotionsImage.ScaleDown: Boolean;
var
  r1, r2: Boolean;
  d: Double;
begin
  d := Abs(FScaleV.x - 1) / FOwner.FAnimationFactor;
  r1 := AnimateDouble(FscaleV.x, 1, d, AnimationMargin);

  d := Abs(FScaleV.y - 1) / FOwner.FAnimationFactor;
  r2 := AnimateDouble(FscaleV.y, 1, d, AnimationMargin);

  result := r1 and r2;
end;

function TGUIMotionsImage.ScaleUp: Boolean;
var
  r1, r2: Boolean;
  d: Double;
begin
  if Fowner.Images[FOwner.GetCurrentSelectedImage].FImageZoomed = zZoomedOut then
  begin
    d := Abs(FScaleV.x - FOwner.FSelectedScaleFactor) / FOwner.FAnimationFactor;
    r1 := AnimateDouble(FScaleV.x, FOwner.FSelectedScaleFactor, d, AnimationMargin);

    d := Abs(FScaleV.y - FOwner.FSelectedScaleFactor) / FOwner.FAnimationFactor;
    r2 := AnimateDouble(FScaleV.y, FOwner.FSelectedScaleFactor, d, AnimationMargin);

    result := r1 and r2;
  end
  else
    result := true;
end;

procedure TGUIMotions.SelectImage(Image: integer);
var
  i: integer;
begin
  if (Image >= 0) and (Image <= Images.Count - 1) then
  begin
    FMouseDown := false;

    if (Image > Images.Count - 1) then
      Image := Images.Count - 1;


    ResetImageStatus(-1, -1, Image, false);

    FPrevSelected := GetCurrentSelectedImage;
    FPrevCC := GetCurrentSelectedImage;

    for I := 0 to Images.Count - 1 do
    begin
      Images[I].FImageClicked := false;
      Images[I].FIsSelected := false;
    end;

    case AnimationMode of
      amConicalOuterBand, amConicalInnerBand: AnimatePicture(Image) ;
      amCarousel: AnimateCarouselImage(Image);
      amBook: AnimatePictureTurn(Image);
      amRolodex: AnimatePictureRoll(Image);
      amImageStrip: AnimatePicture(Image);
      amImageBandLeft, amImageBandRight: AnimateStackedPicture(Image);
    end;

    ScrollBar.InitSliderPos(ScrollBar.GetSliderPosByImageIndex(GetCurrentSelectedImage));
  end;
end;

procedure TGUIMotions.SetAnimationMode(const Value: TGUIMotionsAnimationMode);
begin
  if FAnimationMode <> Value then
  begin
    FAnimationMode := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetBackColor(const Value: TColor);
begin
  if FBackColor <> value then
  begin
    FBackColor := Value;
    if not (csLoading in Componentstate) then
    begin
      if Images.Count > 0 then
      begin
        EnableRendering(true);
        Render;
      end
      else
        PaintBackGround;
    end;
  end;
end;

procedure TGUIMotions.SetCaptionFont(const Value: TFont);
begin
  if FCaptionFont <> value then
  begin
    FCaptionFont.Assign(Value);
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetCaptionLeft(const Value: integer);
begin
  if FCaptionLeft <> value then
  begin
    FCaptionLeft := Value;
  end;
end;

procedure TGUIMotions.SetCaptionMode(const Value: TGUIMotionsCaptionMode);
begin
  if FCaptionMode <> value then
  begin
    FCaptionMode := Value;
    if not (csLoading in Componentstate) then
    begin
      EnableRendering(true);
      Render;
    end;
  end;
end;

procedure TGUIMotions.SetCaptionPosition(const Value: TGUIMotionsPosition);
begin
  if FCaptionPosition <> value then
  begin
    FCaptionPosition := Value;
  end;
end;

procedure TGUIMotions.SetCaptionTop(const Value: integer);
begin
  if FCaptionTop <> value then
  begin
    FCaptionTop := Value;
  end;
end;

procedure TGUIMotions.SetCount(Image: integer);
var
  cw, cww, w: integer;
begin
  FSelected := Min(Images.Count - 1, Image);
  case AnimationMode of
    amImageStrip:
    begin
      FShowImageCount := Min(FImages.Count, FSelected + ((Width div PictureWidth) * (FImageRowCount)) - Images[FSelected].FRIndex);
    end;
    amCarousel, amRoloDex, amBook:
    begin
      cw := PictureWidth;
      cww := PictureDistance;
      w := Width;
      FShowImageCount := Min(FImages.Count, FSelected + w div (cw - cww) + 1);
    end;
    amConicalInnerBand, amConicalOuterBand, amImageBandLeft, amImageBandRight:
    begin
      cw := PictureHeight div 2;
      w := Width;
      FShowImageCount := Min(FImages.Count, FSelected + (w div cw));
    end;
  end;

  ImageChanged(FD3DDevice, FPrevSelected, Image);  
end;

procedure TGUIMotions.SetDefaultAlternatePicture(const Value: TPicture);
begin
  FDefaultAlternatePicture.Assign(Value);
end;

procedure TGUIMotions.SetDefaultPicture(const Value: TPicture);
begin
  FDefaultPicture.Assign(Value);
end;

procedure TGUIMotions.SetGlow(const Value: Boolean);
begin
  if FGlow <> Value then
  begin
    FGlow := Value;
  end;
end;

procedure TGUIMotions.SetGlowAnimation(const Value: Boolean);
begin
  if FGlowAnimation <> value then
  begin
    FGlowAnimation := Value;
  end;
end;

procedure TGUIMotions.SetGlowColor(const Value: TColor);
begin
  if FGlowColor <> value then
  begin
    FGlowColor := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetGlowSize(const Value: integer);
begin
  if FGlowSize <> value then
  begin
    FGlowSize := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetImageMode(const Value: TGUIMotionsImageMode);
begin
  if FImageMode <> value then
  begin
    FImageMode := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetImageQuality(const Value: TGUIMotionsImageQuality);
begin
  if FImageQuality <> value then
  begin
    FImageQuality := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetImageRowCount(const Value: integer);
begin
  if FImageRowCount <> value then
  begin
    FImageRowCount := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetImages(const Value: TGUIMotionsImages);
begin
  if FImages <> value then
  begin
    FImages.Assign(Value);
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetImageStripMargin(const Value: integer);
begin
  if FImageStripMargin <> value then
  begin
    FImageStripMargin := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetImageStripPosition(
  const Value: TGuiMotionsImageStripPosition);
begin
  if FImageStripPosition <> value then
  begin
    FImageStripPosition := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetKeyboardLookup(const Value: Boolean);
begin
  FKeyboardLookup := Value;
  FLookup := '';
end;

procedure TGUIMotions.SetMirror(const Value: Boolean);
begin
  if FMirror <> Value then
  begin
    FMirror := Value;
  end;
end;

procedure TGUIMotions.SetMirrorBottomAlpha(const Value: Byte);
begin
  if FMirrorBottomAlpha <> value then
  begin
    FMirrorBottomAlpha := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetMirrorColor(const Value: TColor);
begin
  if FMirrorColor <> value then
  begin
    FMirrorColor := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetMirrorTopAlpha(const Value: Byte);
begin
  if FMirrorTopAlpha <> value then
  begin
    FMirrorTopAlpha := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetRendering(const Value: TGUIMotionsImageLoading);
begin
  if FImageLoading <> Value then
  begin
    FImageLoading := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetSkewPercentage(const Value: integer);
begin
  if (FSkewPercentage <> value) and (Value >= 0) and (Value <= 100) then
  begin
    FSkewPercentage := Value;
    if not (csLoading in Componentstate) then
      Reset;
  end;
end;

procedure TGUIMotions.SetSlideOutDistance(const Value: integer);
begin
  if FSlideOutDistance <> value then
    FSlideOutDistance := Value;
end;

procedure TGUIMotions.SetAllowInteraction(const Value: boolean);
begin
  if FAllowInteraction <> value then
    FAllowInteraction := Value;
end;

procedure TGUIMotions.SetAnimationFactor(const Value: integer);
begin
  if FAnimationFactor <> Value then
    FAnimationFactor := Value;
end;

function TGUIMotionsImage.SkewLeft: Boolean;
var
  r1, r2, r3, r4: Boolean;
  s: integer;
  d: Double;
  ph: integer;
begin
  ph := GetPictureAspectHeight;
  s := (ph * ((100 - Fowner.FSkewPercentage) div 2)) div 100;

  d := Abs(FVertex[1].position.y - s) / FOwner.FAnimationFactor;
  r1 := AnimateDouble(FVertex[1].position.y, s, d, d);

  d := Abs(FVertex[3].position.y - ph - s) / FOwner.FAnimationFactor;
  r2 := AnimateDouble(FVertex[3].position.y, ph - s, d, d);

  // mirror
  d := Abs(FVertex[5].position.y - ph - s) / FOwner.FAnimationFactor;
  r3 := AnimateDouble(FVertex[5].position.y, ph - s, d, d);

  d := Abs(FVertex[7].position.y - (ph * 2) - s) / FOwner.FAnimationFactor;
  r4 := AnimateDouble(FVertex[7].position.y, (ph * 2) - s, d, d);

  Result := r1 and r2 and r3 and r4;
end;

function TGUIMotionsImage.SkewRight: Boolean;
var
  r1, r2, r3, r4: Boolean;
  s: integer;
  d: Double;
  ph: integer;
begin
  ph := GetPictureAspectHeight;
  s := (ph * ((100 - FOwner.FSkewPercentage) div 2)) div 100;

  d := Abs(Fvertex[0].position.y - s) / FOwner.FAnimationFactor;
  r1 := AnimateDouble(FVertex[0].position.y, s, d, d);

  d := Abs(Fvertex[2].position.y - ph - s) / FOwner.FAnimationFactor;
  r2 := AnimateDouble(FVertex[2].position.y, ph - s, d, d);

  // mirror
  d := Abs(Fvertex[4].position.y - ph - s) / FOwner.FAnimationFactor;
  r3 := AnimateDouble(FVertex[4].position.y, ph - s, d, d);

  d := Abs(Fvertex[6].position.y - (ph * 2) - s) / FOwner.FAnimationFactor;
  r4 := AnimateDouble(FVertex[6].position.y, (ph * 2) - s, d, d);

  Result := r1 and r2 and r3 and r4;
end;

procedure TGUIMotionsImage.Update;
begin
  InitSprite(Index);
end;

procedure TGUIMotionsImage.UpdateImage;
begin
  InitSprite(Index);
end;

function TGUIMotionsImage.ZoomIn: Boolean;
var
  r1, r2: Boolean;
  dx, dy: Double;
  w, h: Double;
  i, cc: integer;
begin
// TODO
  w := (FOwner.PictureWidthZoomed / FOwner.PictureWidth);
  h := (FOwner.PictureHeightZoomed / GetPictureAspectHeight);

  case Fowner.AnimationMode of
    amCarousel, amConicalInnerBand, amConicalOuterBand, amImageStrip:
    begin
      w := Max(2, w);
      h := Max(2, h);
    end;
    else
    begin
      w := Max(1, w);
      h := Max(1, h);
    end;
  end;

  dx := Abs(FScaleV.X - w) / FOwner.AnimationFactor;
  dy := Abs(FScaleV.y - h) / FOwner.AnimationFactor;

  r1 := AnimateDouble(FScaleV.x, w, dx, AnimationMargin);
  r2 := AnimateDouble(FScaleV.y, h, dy, AnimationMargin);

  cc := FOwner.GetCurrentSelectedImage;
  case Fowner.AnimationMode of
    amCarousel, amImageStrip, amConicalInnerBand, amConicalOuterBand:
    begin
      for i := 0 to Fowner.Images.count - 1 do
      begin
        with Fowner.Images[I] do
        begin
          if i < cc then
            Ftox := Ftox - (dx * Fowner.FSlideOutDistance)
          else if i > cc then
            Ftox := Ftox + (dx * Fowner.FSlideOutDistance);
        end;
      end;
    end;
  end;

  result := r1 and r2;
end;

function TGUIMotionsImage.ZoomOut: Boolean;
var
  r1, r2: Boolean;
  dx, dy: Double;
  w, h: Double;
  cc, i: integer;
begin
  case Fowner.AnimationMode of
    amCarousel, amConicalInnerBand, amConicalOuterBand, amImageStrip:
    begin
      w := 2;
      h := 2;
    end;
    else
    begin
      w := 1;
      h := 1;
    end;
  end;

  dx := Abs(FScaleV.X - w) / FOwner.AnimationFactor;
  dy := Abs(FScaleV.y - h) / FOwner.AnimationFactor;

  r1 := AnimateDouble(FScaleV.x, w, dx, AnimationMargin);
  r2 := AnimateDouble(FScaleV.y, h, dy, AnimationMargin);

  cc := FOwner.GetCurrentSelectedImage;
  case Fowner.AnimationMode of
    amCarousel, amImageStrip, amConicalInnerBand, amConicalOuterBand:
    begin
      for i := 0 to Fowner.Images.count - 1 do
      begin
        with Fowner.Images[I] do
        begin
          if i < cc then
            Ftox := Ftox + (dx * Fowner.FSlideOutDistance)
          else if i > cc then
            Ftox := Ftox - (dx * Fowner.FSlideOutDistance);
        end;
      end;
    end;
  end;

  result := r1 and r2;
end;

function TGUIMotions.ShiftImages: TGUIMotionsImageArray;
var
  i, c, s, cc, count: integer;
  draworder: TGUIMotionsImageArray;
begin
  cc := GetCurrentSelectedImage;
  s := GetRenderingCount;
  count := GetStartCount;
  SetLength(draworder, s - count);
  c := 1;
  for I := count to s - 1 do
  begin
    with Images[I] do
    begin
      if I < cc then
        draworder[I - count] := Images[I]
      else if I > cc then
      begin
        draworder[s - count - c] := Images[I];
        Inc(c);
      end
      else
      begin
        draworder[s - count - c] := Images[I];
        Inc(c);
      end;
    end;
  end;

  Result := draworder;
end;

{$IFDEF USETHREADS}
procedure TGUIMotions.ThreadDone(Sender: TObject);
begin
  FThreadDone := true;
end;
{$ENDIF}

procedure TGUIMotions.Timers(enabled: Boolean);
begin
  case AnimationMode of
    amCarousel: FAnCarousel.Enabled := enabled;
    amImageBandLeft:   FAnStacked.Enabled := enabled;
    amImageBandRight:   FAnStacked.Enabled := enabled;
    amConicalInnerBand:  FAnImageStrip.Enabled := enabled;
    amConicalOuterBand:  FAnImageStrip.Enabled := enabled;
    amImageStrip:  FAnImageStrip.Enabled := enabled;
    amRoloDex:  FAnRolodex.Enabled := enabled;
    amBook: FAnBook.Enabled := enabled;
  end;
end;

procedure TGUIMotions.UpdateImages;
var
  I: Integer;
begin
  EnableRendering(true);
  EnableMouseRendering(true);
  for I := 0 to Images.Count - 1 do
    Images[I].UpdateImage;
end;

{$IFDEF USETHREADS}
procedure TGUIMotions.StartThread;
begin
  if not Assigned(FImageLoaderThread) then
  begin
    FImageLoaderThread := TImageLoaderThread.Create(Self);
    FImageLoaderThread.OnTerminate := ThreadDone;
    FImageLoaderThread.Priority := tpLowest;
  end;
end;
{$ENDIF}

procedure TGUIMotions.StopAllTimers;
begin
  FAnCarousel.Enabled := false;
  FAnStacked.Enabled := false;
  FAnStacked.Enabled := false;
  FAnImageStrip.Enabled := false;
  FAnImageStrip.Enabled := false;
  FAnImageStrip.Enabled := false;
  FAnRolodex.Enabled := false;
  FAnBook.Enabled := false;
end;

{$IFDEF USETHREADS}
procedure TGUIMotions.StopThread;
begin
  if Assigned(FImageLoaderThread) then
  begin
    FImageLoaderThread.Terminate;

    while not FThreadDone do
    begin
      Application.ProcessMessages;
    end;

    FreeAndNil(FImageLoaderThread);
  end;
end;
{$ENDIF}

procedure TGUIMotions.WMEraseBkGnd(var Msg: TMessage);
begin
  if not (csDesigning in ComponentState) then
    msg.Result := 1
  else
    inherited;
end;

procedure TGUIMotions.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TGUIMotions.NavigateImage(X, Y: integer; Button: TMouseButton; AllowInt: Boolean);
var
  cc, c: integer;
begin
  if not AllowInt then
    Exit;

  FSliderCapture := false;

  if not FMouseDown then
    Exit;

  FMouseDown := false;

  if FMouseOnSlider or (Images.Count = 0) then
    Exit;

  if ((X > fCx - 2) and (X < fcx + 2)) or ((Y > fCy - 2) and (y < fcy + 2)) then
  begin
    cc := GetCurrentSelectedImage;
    if PtInRect(Images[cc].GetPictureRectangle, Point(X, Y)) or (Images[cc].FImageZoomed = zZoomedIn) then
    begin
      case Button of
        mbLeft: CheckMouseActionLeft;
        mbRight: CheckMouseActionRight;
      end;
    end
    else
    begin
      ResetImageStatus(X, Y, -1, true);
    end;
  end
  else
  begin
    cc := GetCurrentSelectedImage;
    FImages[GetCurrentSelectedImage].FIsSelected := false;
    case FAnimationMode of
      amRoloDex, amImageBandLeft, amImageBandRight:
      begin
        c := Round(Abs(Fcy - FMy) / PictureHeight);
        if FCy < FMy then
          ResetImageStatus(-1, -1, cc - c, true)
        else
          ResetImageStatus(-1, -1, cc + c, true);
      end;
      amBook, amCarousel, amConicalInnerBand, amConicalOuterBand, amImageStrip:
      begin
        c := Round(Abs(Fcx - FMx) / PictureWidth);
        if FCx < FMx then
          ResetImageStatus(-1, -1, cc - c, true)
        else
          ResetImageStatus(-1, -1, cc + c, true);
      end;
    end;
    ScrollBar.InitSliderPos(ScrollBar.GetSliderPosByImageIndex(GetCurrentSelectedImage));    
    FImages[GetCurrentSelectedImage].FIsSelected := true;    
  end;
end;

procedure TGUIMotions.NextImage;
begin
  ResetImageStatus(-1, -1, GetCurrentSelectedImage + 1, true);
end;

function TGUIMotions.NormalImages: TGUIMotionsImageArray;
var
  i, s, count: integer;
  draworder: TGUIMotionsImageArray;
begin
  s := GetRenderingCount;

  count := 0;
  for I := 0 to s - 1 do
    with Images[I] do
      if FPositionV.y > Self.Height + GetPictureAspectHeight then
        count := Max(count, I);

  SetLength(draworder, s - count);
  
  for I := count to s - 1 do
      draworder[s - 1 - I] := Images[I];
      
  Result := draworder;
end;

procedure TGUIMotions.paint;
begin
  inherited;
  if Images.Count > 0 then
  begin
    if not (csLoading in ComponentState) then
    begin
      EnableRendering(true);
      Render;
    end;
  end
  else
    PaintBackGround;
end;

procedure TGUIMotions.PaintBackGround;
begin
//  if not FD3DInitialized then
//begin
    Canvas.Brush.Color := BackColor;
    Canvas.FillRect(ClientRect);
//end;
end;

procedure TGUIMotions.RenderRoloDex;
begin
  Render;
end;

procedure TGUIMotions.RenderScrollBar;
begin
  with ScrollBar do
  begin
    if not FVisible then Exit;

    FScrollBarSprite._Begin(D3DXSPRITE_ALPHABLEND);
    ApplyScrollBarVB;
    D3DXMatrixTransformation2D(FMatrix, @FScrollBarCenterV,0,@FScaleV,@FScrollBarCenterV,0,@FPositionV);
    FD3DDevice.SetTransform(D3DTS_WORLD, FMatrix);
    FD3DDevice.SetStreamSource(0, FVertexBuffer, 0, SizeOf(TCustomVertex));
    FD3DDevice.SetFVF(D3DFVF_CUSTOMVERTEX);
    //Rectangle Left
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
    //Rectangle Center
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 7, 2);
    //Rectangle Right
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 11, 2);
    //Transparent overlay
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 18, 2);
    //TrackLine
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 22, 2);
    //Slider
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 26, 2);
    //Triangle Left
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 4, 1);
    //Triangle Right
    FD3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 15, 1);

    FScrollBarSprite._End;
  end;
end;

procedure TGUIMotions.RenderStackedPictures;
begin
  Render;
end;

procedure TGUIMotions.Reset;
var
  i: integer;
begin
  if not FReset then
    exit;

  StopAllTimers;
  StopThread;
  D3DFree(false);
  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      FAc := false;
      FAlternate := false;
      FBookanimated := false;
      FImageBandAnimated := false;
      FCIndex := 0;
      FHTotalx := 0;
      FHTotaly := 0;
      FImageSelected := sNormal;
      FImageZoomed := zZoomedOut;
      FImageClicked := false;
      FMouseActionIn := false;
      FMouseHandled := false;
      FMouseActionOut := false;
      FAnimateAlternate := false;
      FAnimateNormal := false;
      FTo1 := false;
      FTo2 := false;
      FTo3 := false;
      FTo4 := false;
      FAnimCylinder := false;
      FSlideX := false;
      FSlideY := false;
      FScaleX := false;
      FScaleY := false;
      FSliding := false;
      FNormalize := false;
      FNormalizeAndScaleDownLeft := false;
      FNormalizeAndScaleDownRight := false;
      FNormalizeAndScaleUp := false;
      FNormalizeAndScaleDown := false;
      FGlowOpacity := 255;
      FRIndex := 0;
      FState := isDefault;
      FScaleDown := false;
      FScaleUp := false;
      FSkewLeft := false;
      FSkewRight := false;
      FSPInit := false;
      FVBInit := false;
      FIsSelected := false;
      FToX := 0;
      FToY := 0;
      FSToX := 0;
      FSToY := 0;
      fxFrom := 0;
      fxTo := 0;
      FBusy := false;
    end;
  end;

  FD3DInitialized := false;
  FErrorOccured := false;
  FMouseOnSlider := false;
  FSliderCapture := false;
  FPageState := psPageLeft;
  FCy := 0;
  FMy := 0;
  FCx := 0;
  FMx := 0;
  FPrevSelected := 0;
  FShowImageCount := 9;
  FStartImageCount := 9;
  Fj := 0;
  Fk := 0;
  Fx := 0;
  FDisableRender := true;
  FDisableMouseRender := true;
  FDisableMouseAlternateRender := true;
  FStartImageCount := 9;
  FShowImageCount := 9;

  Initialize;
  StartThread;
end;

procedure TGUIMotions.ResetImageStatus(Xpos, Ypos, Image: integer; DoSelectImage: Boolean);
var
  cc, I, cstart, cstop: integer;
  reverse: Boolean;
begin
  cc := GetCurrentSelectedImage;
  cstart := Images.Count - 1;
  cstop := 0;
  I := 0;
  reverse := false;

  if (AnimationMode <> amImageBandLeft) and (Animationmode <> amImageBandRight) then
  begin
    if (Xpos < Images[cc].FPositionV.x) then
    begin
      reverse := true;
      I := cstart;
    end
    else if Xpos > Images[cc].FPositionV.x + PictureWidth then
    begin
      reverse := false;
      I := 0;
    end;
  end
  else
  begin
    reverse := false;
    I := 0;
  end;

  Images[cc].FMouseActionIn := false;
  case AnimationMode of
    amRoloDex: Images[cc].FMouseActionOut := true;
    amBook: Images[cc].FMouseActionOut := true;
    else
      Images[cc].FMouseActionOut := false;
  end;
  Images[cc].FMouseHandled := false;
  Images[cc].FImageSelected := sNormal;
  Images[cc].FImageZoomed := zZoomedOut;
  Images[cc].FAnimateNormal := true;
  Images[cc].FAnimateAlternate := false;
  Images[cc].FImageBandAnimated := false;
  Images[cc].FBookanimated := false;
  Images[cc].FNormalize := false;
  Images[cc].FScaleDown := false;
  Images[cc].FScaleUp := false;
  Images[cc].FScaleUp := false;
  Images[cc].FSkewLeft := false;
  Images[cc].FSkewRight := false;

  if DoSelectImage then
  begin
    if (Xpos <> -1) and (Ypos <> -1) then
    begin
      while cstart >= cstop do
      begin
        if PtInRect(Images[I].GetPictureRectangle, Point(Xpos, Ypos)) then
        begin
          SelectImage(I);
          ScrollBar.InitSliderPos(ScrollBar.GetSliderPosByImageIndex(I));
          Images[I].FIsSelected := true;
          break;
        end;

        if reverse then
        begin
          Dec(cstart);
          Dec(I);
        end
        else
        begin
          Inc(cstop);
          Inc(I);
        end;
      end;
    end
    else
      SelectImage(Image);
  end;

  FReload := true;
end;

procedure TGUIMotions.Resize;
begin
  if FD3DInitialized then
    if Succeeded(FD3DDevice.TestCooperativeLevel) then
      FD3DDevice.Reset(BuildPresentationParameters);
end;

procedure TGUIMotions.Render;
var
  i: integer;
  img: TGUIMotionsImageArray;
  bg: TColor;
  rc, gc, bc: Byte;
  c, k: integer;
  cc: integer;
  r: TRect;
begin
  if (not FD3DInitialized) or (Images.Count = 0) then
    Exit;

  CheckDeviceLost;

  if FDisableMouseRender then
  begin
    cc := GetCurrentSelectedImage;
    with Images[cc] do
    begin
      r := GetPictureRectangle;
      if (ImageZoomed = zZoomedIn) then
        DoImageZoomed(cc, r);
    end;
  end;

  if CheckGlow and FDisableRender and FDisableMouseRender and FDisableMouseAlternateRender then
  begin
    cc := GetCurrentSelectedImage;
    with Images[cc] do
    begin
      r := GetPictureRectangle;
      if not (ImageZoomed = zZoomedIn) then
        DoImageSelected(cc, r);
    end;

    exit;
  end;

  img := nil;

  bg := ColorToRGB(BackColor);
  rc := bg;
  gc := bg shr 8;
  bc := bg shr 16;

  FD3DDevice.Clear(0, nil, D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER, D3DCOLOR_ARGB(0, rc, gc, bc), 1.0, 0);

  if (SUCCEEDED(FD3DDevice.BeginScene)) then
  begin
    case AnimationMode of
      amRolodex, amBook:
      begin
        if FPrevSelected < GetCurrentSelectedImage then
        begin
          c := GetCurrentSelectedImage;
          k := GetCurrentSelectedImage - 1;
        end
        else
        begin
          c := GetCurrentSelectedImage - 1;
          k := GetCurrentSelectedImage;
        end;

        if c < 0 then
          c := 0;

        if k < 0 then
          k := 0;

        for I:= GetRenderingCount - 1 downto c do
        begin
          with FImages[I] do
            RenderImage;
        end;

        for I:= 0 to k do
        begin
          with FImages[I] do
            RenderImage;
        end;

        if FImages[FPrevSelected].FBookAnimated then
          FImages[GetCurrentSelectedImage].RenderImage;

      end;
      amCarousel, amImageStrip, amConicalOuterBand, amConicalInnerBand:
      begin
        img := ShiftImages;
        for I:= 0 to Length(img) - 1 do
        begin
          with img[I] do
            RenderImage;
        end;
      end;
      amImageBandLeft, amImageBandRight:
      begin
        img := NormalImages;
        for I:= 0 to Length(img) - 1 do
        begin
          with img[I] do
            if FImageBandAnimated then
            begin
              if Index <> GetCurrentSelectedImage then
                RenderImage;
            end
            else
              RenderImage;
        end;

        if FImages[GetCurrentSelectedImage].FImageBandAnimated then
          Images[GetCurrentSelectedImage].RenderImage;
      end;
    end;

    with Images[GetCurrentSelectedImage] do
      if (Caption <> '') then
        DisplayCaption;

    RenderScrollBar;

    for I := 0 to Images.Count - 1 do
    begin
      with Images[I] do
      begin
        //GET NEW PICTURE X, Y, Width, Height
        F3DImagePositionY := Round(FPositionV.y - (FImageCenterV.y * FScaleV.y) + FImageCenterV.y);
        F3DImagePositionX := Round(FPositionV.X - (FImageCenterV.x * FScaleV.x) + FImageCenterV.x);
        F3DImageWidth := Round(FOwner.PictureWidth * FScaleV.x);
        F3DImageHeight := Round(GetPictureAspectHeight * FScaleV.y);
      end;
    end;

    FD3DDevice.EndScene;
  end;

  FD3DDevice.Present(nil, nil, 0, nil);
end;

procedure TGUIMotions.RenderBook;
begin
  Render;
end;

procedure TGUIMotions.RenderCarousel;
begin
  Render;
end;

procedure TGUIMotions.RenderImageStrip;
begin
  Render;
end;

procedure TGUIMotions.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  rl, rr, rm, rsl: TRect;
begin
  inherited;
  if Images.Count = 0 then
    Exit;

  with ScrollBar do
  begin
    rl := Bounds(Round(FPositionV.x + FVertex[16].position.x), Round(FPositionV.y + FVertex[16].position.y),
      Round(FVertex[15].position.X - FVertex[16].position.X), Round(FHeight / 2));

    rr := Bounds(Round(FPositionV.x + FVertex[4].position.x), Round(FPositionV.y + FVertex[5].position.y),
      Round(FVertex[5].position.X - FVertex[4].position.X), Round(FHeight / 2));

    rm := Bounds(Round(FPositionV.x + Fvertex[0].position.X), Round(FPositionV.y + FVertex[1].position.y),
      FScrollBar.Width, FScrollBar.Height);

    rsl := Bounds(round(GetSliderPosition.X + ScrollBar.FPositionV.x), round(GetSliderPosition.Y + ScrollBar.FPositionV.y),
      ScrollBar.SlideWidth, ScrollBar.SlideHeight);

    if PtInRect(rl, Point(X, Y)) then
      ResetImageStatus(-1, -1, GetCurrentSelectedImage + 1, true)
    else if PtInRect(rr, Point(X, Y)) then
      ResetImageStatus(-1, -1, GetCurrentSelectedImage - 1, true)
    else if PtInRect(rm, Point(X, Y)) and not PtInRect(rsl, Point(X, Y)) then
    begin
      if X < rsl.Left then
        ResetImageStatus(-1, -1, GetCurrentSelectedImage - 10, true)
      else
        ResetImageStatus(-1, -1, GetCurrentSelectedImage + 10, true);
    end;

    ScrollBar.InitSliderPos(ScrollBar.GetSliderPosByImageIndex(GetCurrentSelectedImage));      
  end;

  FMouseDown := true;

  FCx := x;
  FCy := y;
  if FMouseOnSlider then
    FSliderCapture := true;
end;

procedure TGUIMotions.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ptSlider: TPoint;
  rr, rl: TRect;
begin
  inherited;

  if (Images.Count = 0) or (not AllowInteraction) then
    exit;

  Cursor := crArrow;


  with ScrollBar do
  begin
    rr := Bounds(Round(FPositionV.x + FVertex[16].position.x), Round(FPositionV.y + FVertex[16].position.y),
      Round(FVertex[15].position.X - FVertex[16].position.X), Round(FHeight / 2));

    if PtInRect(rr, Point(X, Y)) then
      Cursor := crHandPoint;

    rl := Bounds(Round(FPositionV.x + FVertex[4].position.x), Round(FPositionV.y + FVertex[5].position.y),
      Round(FVertex[5].position.X - FVertex[4].position.X), Round(FHeight / 2));

    if PtInRect(rl, Point(X, Y)) then
      Cursor := crHandPoint;

  end;

  FMx := X;
  FMy := Y;
  ptSlider := GetSliderPosition;
  if not FSliderCapture then
  begin
    if PtInRect(Bounds(round(ptSlider.X + ScrollBar.FPositionV.x), round(ptSlider.Y + ScrollBar.FPositionV.y), ScrollBar.SlideWidth, ScrollBar.SlideHeight), ScreenToClient(Mouse.CursorPos)) then
    begin
      Cursor := crHandPoint;
      FMouseOnSlider := true;
    end
    else
      FMouseOnSlider := false;
  end
  else
  begin
    ScrollBar.InitSliderPos(X - ScrollBar.FPositionV.x - (ScrollBar.SlideWidth / 2));
    FImages[GetCurrentSelectedImage].FIsSelected := false;
    ResetImageStatus(-1, -1, GetSliderPositionImage, true);
    FImages[GetCurrentSelectedImage].FIsSelected := true;
  end;
end;

procedure TGUIMotions.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  cc: Integer;
begin
  inherited;

  FSliderCapture := false;
  if FMouseOnSlider or (Images.Count = 0) then
    Exit;

  if ((Message.XPos > fCx - 2) and (Message.XPos < fcx + 2)) or ((Message.YPos > fCy - 2) and (Message.YPos < fcy + 2)) then
  begin
    cc := ImageAtXY(Message.XPos, Message.YPos);
    if (cc <> -1) then
      DoDblClick(cc);
  end;
end;


procedure TGUIMotions.Zoom;
var
  cc, x, y: integer;
begin
  cc := GetCurrentSelectedImage;
  FMouseDown := true;
  with Images[cc] do
  begin
    x := GetPictureRectangle.Left;
    y := GetPictureRectangle.Top;
    FCx := x;
    FCy := Y;
    NavigateImage(x, y, mbLeft, true);
  end;
end;

procedure TGUIMotions.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  NavigateImage(X, Y, Button, AllowInteraction);
end;

procedure TGUIMotions.MouseWheelHandler(var Message: TMessage);
begin
  inherited;
  if (Images.Count = 0) or (not AllowInteraction) then
    exit;

  case Message.Msg of
    WM_MOUSEWHEEL:
    begin
      FImages[GetCurrentSelectedImage].FIsSelected := false;
      if Message.WParam < 0 then
        ResetImageStatus(-1, -1, GetCurrentSelectedImage - 1, true)
      else
        ResetImageStatus(-1, -1, GetCurrentSelectedImage + 1, true);

      ScrollBar.InitSliderPos(ScrollBar.GetSliderPosByImageIndex(GetCurrentSelectedImage));
      FImages[GetCurrentSelectedImage].FIsSelected := true;
    end;
  end;
end;

function TGUIMotionsImage.Normalize: Boolean;
var
  r1, r2, r3, r4, r5, r6, r7, r8: Boolean;
  d: Double;
  ph: integer;
  check: boolean;
begin
  if FOwner.FImageMode = imAspectRatio then
  begin
    check := true;
    case FOwner.AnimationMode of
      amImageStrip: check := (Index = FOwner.GetCurrentSelectedImage);
    end;

    if check then
    begin
      if (fhaspect <> 0) and (fwaspect <> 0) then
        ph := Round(Fowner.FPictureHeight * (fhaspect / fwaspect))
      else
        ph := 0;
    end
    else
      ph := FOwner.PictureHeight;
  end
  else
    ph := GetPictureAspectHeight;

  d := FVertex[1].position.y / FOwner.FAnimationFactor;
  r1 := AnimateDouble(FVertex[1].position.y, 0, d, AnimationMargin);

  d := Abs(FVertex[3].position.y - ph) / FOwner.FAnimationFactor;
  r2 := AnimateDouble(FVertex[3].position.y, ph, d, AnimationMargin);

  // mirror
  d := Abs(FVertex[5].position.y - ph) / FOwner.FAnimationFactor;
  r3 := AnimateDouble(FVertex[5].position.y, ph, d, AnimationMargin);

  d := Abs(FVertex[7].position.y - (ph * 2)) / FOwner.FAnimationFactor;
  r4 := AnimateDouble(FVertex[7].position.y, ph * 2, d, AnimationMargin);

  d := FVertex[0].position.y / FOwner.FAnimationFactor;
  r5 := AnimateDouble(FVertex[0].position.y, 0, d, AnimationMargin);

  d := Abs(FVertex[2].position.y - ph) / FOwner.FAnimationFactor;
  r6 := AnimateDouble(FVertex[2].position.y, ph, d, AnimationMargin);

  // mirror

  d := Abs(FVertex[4].position.y - ph) / FOwner.FAnimationFactor;
  r7 := AnimateDouble(FVertex[4].position.y, ph, d, AnimationMargin);

  d := Abs(FVertex[6].position.y - (ph * 2)) / FOwner.FAnimationFactor;
  r8 := AnimateDouble(FVertex[6].position.y, ph * 2, d, AnimationMargin);


  Result := r1 and r2 and r3 and r4 and r5 and r6 and r7 and r8;
end;

procedure TGUIMotionsImage.RenderImage;
var
  w, h: integer;
begin
  if FReload then
  begin
    FVBInit := false;
    FSPInit := false;
    CreateImage;
    w := (fowner.Width - FOwner.PictureWidth) div 2;
    h := (fowner.Height - GetPictureAspectHeight) div 2;
    SetImagePosition(FCIndex, FRIndex, index, w, h);
    FReload := false;
  end;

  if not FVBInit and not FSPInit and not Assigned(FImageSprite) then
    exit;

  FImageSprite._Begin(D3DXSPRITE_ALPHABLEND);
  case FOwner.AnimationMode of
    amBook:
    begin
      if FAnimateAlternate then
        ApplyNewVB(FVertex)
      else
        ApplyNewVB(FFakeVertex);
    end;
    else
      ApplyNewVB(FVertex);
  end;

  SetupMatrices;
  Get3DDevice.SetTexture(0, FTexture);
  Get3DDevice.SetStreamSource(0, Fowner.FVertexBuffer, 0, SizeOf(TCustomVertex));
  Get3DDevice.SetFVF(D3DFVF_CUSTOMVERTEX);

  case Fowner.AnimationMode of
    amConicalInnerBand, amConicalOuterBand:
    begin
      if FAc then
      begin
        ApplyNewVB(FCylinderVertex);
        Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, CountVertices - 2);
      end
      else
        Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
    end;
  else
    Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
  end;

  if FImageSelected = sNormal then
    CheckDrawMirror;

  if FImageSelected = sAlternate then
  begin
    ApplyNewVB(FAltVertex);
    Get3DDevice.SetTexture(0, FAltTexture);
    Get3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
    CheckDrawMirror;
  end;

  FImageSprite._End;

  if (FVertex[2].position.y = GetPictureAspectHeight) and (FVertex[3].position.y = GetPictureAspectHeight) and FIsSelected and (FVertex[0].position.x <= AnimationGlowMargin)
    and (FVertex[1].position.x >= FOwner.PictureWidth - AnimationGlowMargin)
      and (FVertex[0].position.y <= AnimationGlowMargin)
        and (FVertex[1].position.y <= AnimationGlowMargin)
          and Fowner.Glow and (FOwner.AnimationMode <> amRoloDex)
            and (FOwner.AnimationMode <> amBook) then
            begin
              if FOwner.FGlowAnimation then
              begin
                FGlowOpacity := Min(255, Round(FGlowOpacity + Abs(FGlowOpacity - 255) / FOwner.AnimationFactor));
                if FGlowOpacity >= 250 then
                  FGlowOpacity := 255;

                FillGlowVertex(FGlowVertex);
              end
              else
                FGlowOpacity := 255;

              DrawGlow;
            end
            else
            begin
              FGlowOpacity := 0;
            end;

end;

procedure TGUIMotions.CreateWnd;
begin
  inherited;
  Initialize;
  {$IFDEF USETHREADS}
  FThreadDone := false;
  StartThread;
  {$ENDIF}
end;

procedure TGUIMotionsImage.CreateImage;
begin
  if not FSPInit then
    FSPInit := Succeeded(InitSprite(FOwner.GetCurrentSelectedImage));

  if FSPInit then
    InitVB;
end;

procedure TGUIMotions.InitImagePositions;
var
  i, w, h: integer;
begin
  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      w := (Width - PictureWidth) div 2;
      h := (Height - GetPictureAspectHeight) div 2;
      SetImagePosition(FOwner.Fj, FOwner.FK, Index, w, h);
      Inc(FOwner.FK);
      if FOwner.FK >= Fowner.ImageRowCount then
      begin
        Inc(FOwner.FJ);
        FOwner.FK := 0;
      end;
    end;
  end;
end;

procedure TGUIMotions.InitImages;
var
  I, start, stop: Integer;
  bg: TColor;
  rc, gc, bc: Byte;
begin
  if not FD3DInitialized then
    FD3DInitialized := Succeeded(InitD3D);

  if FD3DInitialized then
  begin
    bg := ColorToRGB(BackColor);
    rc := bg;
    gc := bg shr 8;
    bc := bg shr 16;

    //Clear the backbuffer to a black color
    FD3DDevice.Clear(0, nil, D3DCLEAR_TARGET, D3DCOLOR_ARGB(0, rc, gc, bc), 1.0, 0);
    FD3DDevice.Present(nil, nil, 0, nil);

    start := 0;
    stop := GetRenderingCount - 1;
    for I := start to stop do
      FImages[I].CreateImage;

    InitImagePositions;

    //Create sprite for Glow
    D3DXCreateSprite(FD3DDevice, FGlowSprite);
    Timers(true);
    SelectImage(GetCurrentSelectedImage);
    Images[GetCurrentSelectedImage].FIsSelected := true;
  end;
end;

procedure TGUIMotions.InitImageVertexAlpha(Alpha: single; ItemVisible: integer);
var
  i, a: integer;
begin
  for I := GetStartCount to GetRenderingCount - 1 do
  begin
    if I <> itemvisible then
    begin
      a := Round(alpha);
    end
    else
    begin
      a := 255;
    end;
    with Images[I] do
    begin
      with FVertex[0] do
        Color := D3DCOLOR_ARGB(a, 255, 255, 255);

      with FVertex[1] do
        Color := D3DCOLOR_ARGB(a, 255, 255, 255);

      with FVertex[2] do
        Color := D3DCOLOR_ARGB(a, 255, 255, 255);

      with FVertex[3] do
        Color := D3DCOLOR_ARGB(a, 255, 255, 255);
    end;
  end;
end;

procedure TGUIMotions.InitScrollBar;
var
  c, cs, ca, co, ct: TColor;
  r, g, b: Byte;
  rs, gs, bs: Byte;
  ra, ga, ba: Byte;
  ro, go, bo: Byte;
  rt, gt, bt: Byte;
  rw, rwc: Single;
  slidepos: single;
begin
  with FScrollBar do
  begin
    if not FVisible or not FD3DInitialized then Exit;

    if FVertexBuffer = nil then
      if FAILED(FD3DDevice.CreateVertexBuffer(CountVertices * 2 * SizeOf(TCustomVertex), 0,
        D3DFVF_CUSTOMVERTEX, D3DPOOL_MANAGED, FVertexBuffer, nil))
      then exit;

    D3DXCreateSprite(FD3DDevice, FScrollBarSprite);

    //Color
    c := ColorToRGB(FColor);
    r := c;
    g := c shr 8;
    b := c shr 16;

    //SlideColor
    cs := ColorToRGB(FSliderColor);
    rs := cs;
    gs := cs shr 8;
    bs := cs shr 16;

    //ArrowColor
    ca := ColorToRGB(FArrowColor);
    ra := ca;
    ga := ca shr 8;
    ba := ca shr 16;

    //Transparent Overlay Color
    co := ColorToRGB(FOverlay);
    ro := co;
    go := co shr 8;
    bo := co shr 16;

    //SlideColor
    ct := ColorToRGB(FTrackerColor);
    rt := ct;
    gt := ct shr 8;
    bt := ct shr 16;


    rw := FWidth * 10 / 100;  //10 % of width;
    rwc := FWidth - rw;

    case FPosition of
      spTopLeft:
      begin
        FPositionV.x := 0;
        FPositionV.y := 0;
      end;
      spTopRight:
      begin
        FPositionV.x := FOwner.Width - FWidth;
        FPositionV.y := 0;
      end;
      spBottomLeft:
      begin
        FPositionV.x := 0;
        FPositionV.y := FOwner.Height - FHeight;
      end;
      spBottomRight:
      begin
        FPositionV.x := FOwner.Width - FWidth;
        FPositionV.y := FOwner.Height - FHeight;
      end;
      spTopCenter:
      begin
        FPositionV.x := (FOwner.Width - FWidth) / 2;
        FPositionV.y := 0;
      end;
      spBottomCenter:
      begin
        FPositionV.x := (FOwner.Width - FWidth) / 2;
        FPositionV.y := FOwner.Height - FHeight;
      end;
      spCustom:
      begin
        FPositionV.x := FLeft;
        FPositionV.y := FTop;
      end;
    end;

    FScaleV.x := 1;
    FScaleV.y := 1;

    FScrollBarCenterV.x := FWidth / 2;
    FScrollBarCenterV.y := FHeight / 2;

    //RECTANGLE LEFT
    with FVertex[0] do
    begin
      position := D3DXVector3(0, 0, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[1] do
    begin
      position := D3DXVector3(rw, 0, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[2] do
    begin
      position := D3DXVector3(0, FHeight, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[3] do
    begin
      position := D3DXVector3(rw, FHeight, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    //TRIANGLE LEFT
    with FVertex[4] do
    begin
      position := D3DXVector3(rw / 4, FHeight / 2, 0);
      Color := D3DCOLOR_ARGB(255, ra, ga, ba);
    end;

    with FVertex[5] do
    begin
      position := D3DXVector3(rw / 4 * 2, FHeight / 4, 0);
      Color := D3DCOLOR_ARGB(255, ra, ga, ba);
    end;

    with FVertex[6] do
    begin
      position := D3DXVector3(rw / 4 * 2, FHeight / 4 * 3, 0);
      Color := D3DCOLOR_ARGB(255, ra, ga, ba);
    end;

    //RECTANGLE CENTER
    with FVertex[7] do
    begin
      position := D3DXVector3(rw, 0, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[8] do
    begin
      position := D3DXVector3(rwc, 0, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[9] do
    begin
      position := D3DXVector3(rw, FHeight, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[10] do
    begin
      position := D3DXVector3(rwc, FHeight, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    //RECTANGLE RIGHT
    with FVertex[11] do
    begin
      position := D3DXVector3(rwc, 0, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[12] do
    begin
      position := D3DXVector3(rwc + rw, 0, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[13] do
    begin
      position := D3DXVector3(rwc, FHeight, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    with FVertex[14] do
    begin
      position := D3DXVector3(rwc + rw, FHeight, 0);
      Color := D3DCOLOR_ARGB(FColorAlpha, r, g, b);
    end;

    //TRIANGLE RIGHT
    with FVertex[15] do
    begin
      position := D3DXVector3((rw / 4 * 3) + rwc, FHeight / 2, 0);
      Color := D3DCOLOR_ARGB(255, ra, ga, ba);
    end;

    with FVertex[16] do
    begin
      position := D3DXVector3((rw / 4 * 2) + rwc, FHeight / 4, 0);
      Color := D3DCOLOR_ARGB(255, ra, ga, ba);
    end;

    with FVertex[17] do
    begin
      position := D3DXVector3((rw / 4 * 2) + rwc, FHeight / 4 * 3, 0);
      Color := D3DCOLOR_ARGB(255, ra, ga, ba);
    end;

    //TRANSPARENT OVERLAY
    with FVertex[18] do
    begin
      position := D3DXVector3(0, 0, 0);
      Color := D3DCOLOR_ARGB(FOverLayAlphaTop, ro, go, bo);
    end;

    with FVertex[19] do
    begin
      position := D3DXVector3(rwc + rw, 0, 0);
      Color := D3DCOLOR_ARGB(FOverLayAlphaTop, ro, go, bo);
    end;

    with FVertex[20] do
    begin
      position := D3DXVector3(0, FHeight / 2, 0);
      Color := D3DCOLOR_ARGB(FOverLayAlphaBottom, ro, go, bo);
    end;

    with FVertex[21] do
    begin
      position := D3DXVector3(rwc + rw, FHeight / 2, 0);
      Color := D3DCOLOR_ARGB(FOverLayAlphaBottom, ro, go, bo);
    end;

    //TrackLine
    with FVertex[22] do
    begin
      position := D3DXVector3(rw / 4 * 2, (FHeight / 2) - (FTrackerHeight / 2), 0);
      Color := D3DCOLOR_ARGB(FTrackerAlpha, rt, gt, bt);
    end;

    with FVertex[23] do
    begin
      position := D3DXVector3((rw / 4 * 2) + rwc, (FHeight / 2) - (FTrackerHeight / 2), 0);
      Color := D3DCOLOR_ARGB(FTrackerAlpha, rt, gt, bt);
    end;

    with FVertex[24] do
    begin
      position := D3DXVector3((rw / 4 * 2), (FHeight / 2) + (FTrackerHeight / 2), 0);
      Color := D3DCOLOR_ARGB(FTrackerAlpha, rt, gt, bt);
    end;

    with FVertex[25] do
    begin
      position := D3DXVector3((rw / 4 * 2) + rwc, (FHeight / 2) + (FTrackerHeight / 2), 0);
      Color := D3DCOLOR_ARGB(FTrackerAlpha, rt, gt, bt);
    end;

    //Slider
    with FVertex[26] do
      Color := D3DCOLOR_ARGB(FSlideAlpha, rs, gs, bs);

    with FVertex[27] do
      Color := D3DCOLOR_ARGB(FSlideAlpha, rs, gs, bs);

    with FVertex[28] do
      Color := D3DCOLOR_ARGB(FSlideAlpha, rs, gs, bs);

    with FVertex[29] do
      Color := D3DCOLOR_ARGB(FSlideAlpha, rs, gs, bs);

    InitSliderPos(GetSliderPosByImageIndex(GetCurrentSelectedImage));

  end;
end;

procedure TGUIMotions.D3DFree(ForceD3DFree: Boolean);
var
  I: Integer;
begin
  for I := 0 to Images.Count - 1 do
  begin
    with Images[I] do
    begin
      if FImageSprite <> nil then
      begin
        FImageSprite._AddRef;
        FImageSprite._Release;
        FImageSprite := nil;
      end;

      if FTexture <> nil then
      begin
        FTexture._AddRef;
        FTexture._Release;
        FTexture := nil;
      end;
    end;
  end;

  if ScrollBar.FVertexBuffer <> nil then
  begin
    ScrollBar.FVertexBuffer._AddRef;
    ScrollBar.FVertexBuffer._Release;
    ScrollBar.FVertexBuffer := nil;
  end;

  if ScrollBar.FScrollBarSprite <> nil then
  begin
    ScrollBar.FScrollBarSprite._AddRef;
    ScrollBar.FScrollBarSprite._Release;
    ScrollBar.FScrollBarSprite := nil;
  end;

  if FCaptionD3DFont <> nil then
  begin
    FCaptionD3DFont._AddRef;
    FCaptionD3DFont._Release;
    FCaptionD3DFont := nil;
  end;  

  if (FVertexBuffer <> nil) then
  begin
    FVertexBuffer._AddRef;
    FVertexBuffer._Release;
    FVertexBuffer := nil;
  end;

  if (FVertexGlowBuffer <> nil) then
  begin
    FVertexGlowBuffer._AddRef;
    FVertexGlowBuffer._Release;
    FVertexGlowBuffer := nil;
  end;

  if (FPreLoadFont <> nil) then
  begin
    FPreLoadFont._AddRef;
    FPreLoadFont._Release;
    FPreLoadFont := nil;
  end;

  if ForceD3DFree then
  begin
    if (FD3DDevice <> nil) then
    begin
      FD3DDevice._AddRef;
      FD3DDevice._Release;
      FD3DDevice := nil;
    end;

    if (FD3D <> nil) then
    begin
      FD3D._AddRef;
      FD3D._Release;
      FD3D := nil;
    end;
  end;
end;

{ TGUIMotionsImage }

procedure TGUIMotions.AddImagesFromFolder(AFolder: string);
var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Images.Add do
    begin
      FCaption := ExtractFileName(s);
      FFullCaption := s;
      try
        FPicture.LoadFromFile(s);
      except
        FPicture.Graphic := nil;
      end;
    end;
  end;

begin
  if FindFirst(AFolder,faAnyFile,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
end;

procedure TGUIMotions.AddImageLocationsFromFolder(AFolder: string);
var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Images.Add do
    begin
      FCaption := ExtractFileName(s);
      FFullCaption := s;
      FPictureLocation := s;
    end;
  end;

begin
  if FindFirst(AFolder,faAnyFile,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
end;

{$IFDEF USETHREADS}
procedure TGUIMotions.AddThreadedImageLocationsFromFolder(AFolder: string);
var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Images.Add do
    begin
      FCaption := ExtractFileName(s);
      FFullCaption := s;
      FThreadedPictureLocation := s;
      FThreadStatus := stInitialized;
    end;
  end;

begin
  if FindFirst(AFolder,faAnyFile,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
end;
{$ENDIF}

procedure TGUIMotions.Alternate;
var
  cc, x, y: integer;
begin
  cc := GetCurrentSelectedImage;
  FMouseDown := true;
  with Images[cc] do
  begin
    x := GetPictureRectangle.Left;
    y := GetPictureRectangle.Top;
    FCx := x;
    FCy := Y;
    NavigateImage(x, y, mbRight, true);
  end;
end;

procedure TGUIMotions.AlternateImageClick(Image: integer; var AllowZoom: Boolean; device: IDirect3DDevice9);
begin
  if Assigned(FOnAlternateImageClick) then
    FOnAlternateImageClick(Self, Image, AllowZoom, device);
end;

procedure TGUIMotions.AlternateImageLeftClick(Image: integer;
  var AllowZoom: Boolean; device: IDirect3DDevice9);
begin
  if Assigned(FOnAlternateImageLeftClick) then
    FOnAlternateImageLeftClick(Self, Image, AllowZoom, device);
end;

procedure TGUIMotions.AlternateImageRightClick(Image: integer;
  var AllowAlternate: Boolean; device: IDirect3DDevice9);
begin
  if Assigned(FOnAlternateImageRightClick) then
    FOnAlternateImageRightClick(Self, Image, AllowAlternate, device);
end;

procedure TGUIMotions.DoDblClick(Image: integer);
begin
  if Assigned(OnImageDblClick) then
    OnImageDblClick(Self, Image);
end;

function TGUIMotionsImage.AnimateAlternate: Boolean;
var
  r1, r2, r3, r4: Boolean;
  d: Double;
  pw: integer;
begin
  r3 := false;
  r4 := false;

  pw := FOwner.PictureWidth;

  d := Abs(FVertex[0].position.x - pw) / FOwner.AnimationFactor;
  r1 := AnimateDouble(FVertex[0].position.x, pw, d, AnimationMargin);
  FVertex[6].position.x := FVertex[0].position.x;
  FAltVertex[1].position.x := FVertex[0].position.x;
  FAltVertex[7].position.x := FVertex[6].position.x;

  d := Abs(FVertex[1].position.x) / FOwner.AnimationFactor;
  r2 := AnimateDouble(FVertex[1].position.x, 0, d, AnimationMargin);
  FVertex[7].position.x := FVertex[1].position.x;
  FAltVertex[0].position.x := FVertex[1].position.x;
  FAltVertex[6].position.x := FVertex[7].position.x;

  if FVertex[0].position.x >= pw / 3 then
  begin
    d := Abs(FVertex[2].position.x - pw) / FOwner.AnimationFactor;
    r3 := AnimateDouble(FVertex[2].position.x, pw, d, AnimationMargin);
    FVertex[4].position.x := FVertex[2].position.x;
    FAltVertex[3].position.x := FVertex[2].position.x;
    FAltVertex[5].position.x := FVertex[4].position.x;

    d := Abs(FVertex[3].position.x) / FOwner.AnimationFactor;
    r4 := AnimateDouble(FVertex[3].position.x, 0, d, AnimationMargin);
    FVertex[5].position.x := FVertex[3].position.x;
    FAltVertex[2].position.x := FVertex[3].position.x;
    FAltVertex[4].position.x := FVertex[5].position.x;
  end;

  Result := r1 and r2 and r3 and r4;
end;


procedure TGUIMotionsImage.AnimateCylinderVertex(delta: single);
var
  I, k: Integer;
  w, hs, an, cs, angle, csw, csh, wd, wh: Double;
  cm: TColor;
  r, g, b: Byte;
begin
  cm := ColorToRGB(FOwner.MirrorColor);
  r := cm;
  g := cm shr 8;
  b := cm shr 16;
  i := 0;
  FHTotalx := 0;
  FHtotaly := 0;
  wd := 0;
  wh := 0;
  an := 90 / CountVertices / (Fowner.Width * 2 / FOwner.PictureWidth);
  w := Fowner.PictureWidth / ((CountVertices - 1) / 2);
  k := 0;
  while k < CountVertices / 2 do
  begin
    angle := DegToRad(Min(89, an * delta));
    cs := Cos(angle);
    hs := Sin(angle);
    if FOwner.AnimationMode = AMConicalOuterBand then
      hs := -hs;

    csw := cs * w;
    wd := wd + csw;
    csh := hs * w;
    wh := wh + csh;

    FCylinderVertex[I].position := D3DXVector3(wd, wh, 0);
    FCylinderVertex[I].tu := K / ((CountVertices - 1) / 2);
    FCylinderVertex[I].tv := 0;
    FCylinderVertex[I].Color := D3DCOLOR_ARGB(255, 255, 255, 255);

    FCylinderVertex[I + 1].position := D3DXVector3(wd, GetPictureAspectHeight + wh, 0);
    FCylinderVertex[I + 1].tu := K / ((CountVertices - 1) / 2);
    FCylinderVertex[I + 1].tv := 1;
    FCylinderVertex[I + 1].Color := D3DCOLOR_ARGB(255, 255, 255, 255);

    FCylinderMirrorVertex[I].position := D3DXVector3(wd, GetPictureAspectHeight + wh, 0);
    FCylinderMirrorVertex[I].tu := K / ((CountVertices - 1) / 2);
    FCylinderMirrorVertex[I].tv := 1;
    FCylinderMirrorVertex[I].Color := D3DCOLOR_ARGB(FOwner.FMirrorTopAlpha, r, g, b);

    FCylinderMirrorVertex[I + 1].position := D3DXVector3(wd, (GetPictureAspectHeight * 2) + wh, 0);
    FCylinderMirrorVertex[I + 1].tu := K / ((CountVertices - 1) / 2);
    FCylinderMirrorVertex[I + 1].tv := 0;
    FCylinderMirrorVertex[I + 1].Color := D3DCOLOR_ARGB(FOwner.FMirrorBottomAlpha, r, g, b);

    I := i + 2;
    Inc(K);

    if FOwner.GetCurrentSelectedImage <> Index then
      delta := delta + 1;

  end;
end;

function TGUIMotionsImage.AnimateNormal: Boolean;
var
  r1, r2, r3, r4: Boolean;
  d: Double;
  pw: integer;
begin
  r3 := false;
  r4 := false;

  pw := FOwner.PictureWidth;

  d := Abs(FVertex[0].position.x) / FOwner.AnimationFactor;
  r1 := AnimateDouble(FVertex[0].position.x, 0, d, AnimationMargin);
  FVertex[6].position.x := FVertex[0].position.x;
  FAltVertex[1].position.x := FVertex[0].position.x;
  FAltVertex[7].position.x := FVertex[6].position.x;

  d := Abs(FVertex[1].position.x - pw) / FOwner.AnimationFactor;
  r2 := AnimateDouble(FVertex[1].position.x, pw, d, AnimationMargin);
  FVertex[7].position.x := FVertex[1].position.x;
  FAltVertex[0].position.x := FVertex[1].position.x;
  FAltVertex[6].position.x := FVertex[7].position.x;

  if FVertex[1].position.x >= pw / 3 then
  begin
    d := Abs(FVertex[2].position.x) / FOwner.AnimationFactor;
    r3 := AnimateDouble(FVertex[2].position.x, 0, d, AnimationMargin);
    FVertex[4].position.x := FVertex[2].position.x;
    FAltVertex[3].position.x := FVertex[2].position.x;
    FAltVertex[5].position.x := FVertex[4].position.x;

    d := Abs(FVertex[3].position.x - pw) / FOwner.AnimationFactor;
    r4 := AnimateDouble(FVertex[3].position.x, pw, d, AnimationMargin);
    FVertex[5].position.x := FVertex[3].position.x;
    FAltVertex[2].position.x := FVertex[3].position.x;
    FAltVertex[4].position.x := FVertex[5].position.x;
  end;

  Result := r1 and r2 and r3 and r4;
end;

procedure TGUIMotionsImage.SetupMatrices;
var
  ph: integer;
begin
  case FOwner.AnimationMode of
    amImageStrip:
    begin
      ph := Fowner.FPictureHeight;
      if (Fowner.ImageMode = imAspectRatio) then
      begin
        if (FImageSelected = sNormal) then
          if (fhaspect <> 0) and (fwaspect <> 0) then
            ph := Round(Fowner.FPictureHeight * (fhaspect / fwaspect))
        else
          if FAlternate then
            if (fhaspectalt <> 0) and (fwaspectalt <> 0) then
              ph := Round(Fowner.FPictureHeight * (fhaspectalt / fwaspectalt))
            else
              ph := 0;
      end;

      FImageCenterV.x := Fowner.PictureWidth / 2;
      FImageCenterV.y := ph / 2;
    end;
  end;

  D3DXMatrixTransformation2D(FMatrix, @FImageCenterV,0,@FScaleV,@FImageCenterV,0,@FPositionV);
  Get3DDevice.SetTransform(D3DTS_WORLD, FMatrix);
end;

procedure TGUIMotionsImage.ApplyNewGlowVB(v: TVertexArray);
begin
  if Fowner.FVertexGlowBuffer = nil then
    exit;

  if FAILED(Fowner.FVertexGlowBuffer.Lock(0, SizeOf(v), fpGlowVertices, 0))
  then Exit;

  CopyMemory(fpGlowVertices, @v, SizeOf(v));

  Fowner.FVertexGlowBuffer.Unlock;
end;

procedure TGUIMotionsImage.ApplyNewVB(v: TVertexArray);
begin
  if Fowner.FVertexBuffer = nil then
    exit;

  if FAILED(Fowner.FVertexBuffer.Lock(0, SizeOf(v), fpVertices, 0))
  then Exit;

  CopyMemory(fpVertices, @v, SizeOf(v));

  Fowner.FVertexBuffer.Unlock;
end;

procedure TGUIMotionsImage.Assign(Source: TPersistent);
begin
  if (Source is TGUIMotionsImage) then
  begin
    AlternatePicture.Assign((Source as TGUIMotionsImage).AlternatePicture);
    AlternatePictureLocation := (Source as TGUIMotionsImage).AlternatePictureLocation;
    Caption := (source as TGUIMotionsImage).Caption;
    FullCaption := (Source as TGUIMotionsImage).FullCaption;
    Picture.Assign((Source as TGUIMotionsImage).Picture);
    PictureLocation := (Source as TGUIMotionsImage).PictureLocation;
    Tag := (Source as TGUIMotionsImage).Tag;
    ItemObject := (Source as TGUIMotionsImage).ItemObject;
    OwnsObject := (Source as TGUIMotionsImage).OwnsObject;
    Data := (Source as TGUIMotionsImage).Data;
  end;
end;

procedure TGUIMotionsImage.CheckDrawMirror;
var
  cc: integer;
  check: Boolean;
begin
  check := true;
  case FOwner.AnimationMode of
    amImageBandRight, amRoloDex, amBook: check := not (FImageZoomed = zZoomedIn);
    amImageStrip: check := not FIsSelected;
  end;

  if check then
  begin
    cc := FOwner.GetCurrentSelectedImage;
    case FOwner.AnimationMode of
      amRoloDex:
      begin
        if Index = cc then
          DrawMirror;
      end;
      amBook:
      begin
        if (Index = cc) or (Index = cc - 1) then
          DrawMirror;
      end;
    else
      DrawMirror;
    end;
  end;
end;

procedure TGUIMotions.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  inherited;
//  msg.Result := 1;
end;

constructor TGUIMotionsImage.Create(Collection: TCollection);
begin
  inherited;
  Fowner := (Collection as TGUIMotionsImages).FOwner;
  FState := isDefault;
  FPictureDistance := 70;
  FCaption := '';
  FGlowOpacity := 255;  
  FShowCaption := false;
  FPicture := TPicture.Create;
  FAlternatePicture := TPicture.Create;

  if FOwner.Images.Count < FOwner.FStartImageCount then
    FOwner.FStartImageCount := FOwner.Images.Count;
end;

destructor TGUIMotionsImage.Destroy;
begin
  FPicture.Free;
  FAlternatePicture.Free;

  if OwnsObject and (ItemObject <> nil) then
    ItemObject.Free;

  inherited;
end;

function TGUIMotionsImage.Get3DDevice: IDirect3DDevice9;
begin
  Result := Fowner.FD3DDevice;
end;

function TGUIMotionsImage.GetOriginalPictureHeight: integer;
begin
  Result := Picture.Height;
end;

function TGUIMotionsImage.GetImagePosition: TPoint;
begin
  Result := Point(Round(FPositionV.x), Round(FPositionV.y));
end;

function TGUIMotionsImage.GetOriginalPictureWidth: integer;
begin
  Result := Picture.Width;
end;

function TGUIMotions.ImageAtXY(X, Y: integer): integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Images.Count - 1 do
  begin
    if PtInRect(Images[I].GetPictureRectangle, Point(X, Y)) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TGUIMotions.ImageChanged(device: IDirect3DDevice9; PreviousImage,
  CurrentImage: integer);
begin
  if Assigned(FOnImageChanged) then
    FOnImageChanged(Self, PreviousImage, CurrentImage, device);
end;

procedure TGUIMotions.ImageClick(var allowzoom: Boolean; device: IDirect3DDevice9; Image: integer);
begin
  if Assigned(FOnImageClick) then
    FOnImageClick(self, Image, AllowZoom, device);
end;

procedure TGUIMotions.ImageLeftClick(var AllowZoom: Boolean;
  device: IDirect3DDevice9; Image: integer);
begin
  if Assigned(FOnImageLeftClick) then
    FOnImageLeftClick(Self, Image, AllowZoom, device);
end;

procedure TGUIMotions.ImageLoaded(Index: integer; Alternate: Boolean);
begin
  if Assigned(FOnImageLoaded) then
    FOnImageLoaded(Self, Index, Alternate);
end;

procedure TGUIMotions.ImageRightClick(var AllowAlternate: Boolean;
  device: IDirect3DDevice9; Image: integer);
begin
  if Assigned(FOnImageRightClick) then
    FOnImageRightClick(Self, Image, AllowAlternate, device);
end;

procedure TGUIMotions.DoImageZoomed(Image: integer; ImageRectangle: TRect);
begin
  if Assigned(FOnImageZoomed) then
    FOnImageZoomed(Self, Image, ImageRectangle);
end;

procedure TGUIMotions.ImageCustomDraw(Picture: graphics.TBitmap; Image: integer);
begin
  if Assigned(FOnImageCustomDraw) then
    FOnImageCustomDraw(Self, Image, Picture);
end;

procedure TGUIMotions.ImageCustomAlternateDraw(Picture: graphics.TBitmap; Image: integer);
begin
  if Assigned(FOnImageCustomAlternateDraw) then
    FOnImageCustomAlternateDraw(Self, Image, Picture);
end;

procedure TGUIMotionsImage.InitImage(x, y, ToX, ToY: Single);
begin
  FPositionV.x := x;
  FPositionV.y := y;

  FImageCenterV.x := Fowner.PictureWidth / 2;
  FImageCenterV.y := GetPictureAspectHeight / 2;

  FScaleV.x := 1;
  FScaleV.y := 1;

  if not FReload then
  begin
    FToX := ToX;
    FToY := ToY;
  end;
end;

function TGUIMotionsImage.InitSprite(Image: integer): HRESULT;
var
  hr: HRESULT;
  s, sc: TMemoryStream;
  p, a: TPicture;
  pc, ac: Graphics.TBitmap;
  wres, hres: integer;
  ratio: Double;
begin
  hr := E_FAIL;

  s := nil;
  p := nil;
  a := nil;
  try
    p := TPicture.Create;
    a := TPicture.Create;

    if (FPicture.Graphic = nil) and (FPictureLocation = '') then
    begin
      if Assigned(FOwner.OnImageCustomDraw) then
      begin
        p.Bitmap.Width := 0;
        p.Bitmap.Height := 0;
        p.Bitmap.PixelFormat := pf24bit;
        FOwner.ImageCustomDraw(p.Bitmap,Index)
      end
      else
      begin
        p.Graphic := nil;
        if (FOwner.DefaultPicture.Graphic <> nil) then
        begin
          if not FOwner.DefaultPicture.Graphic.Empty then
            p.Assign(FOwner.DefaultPicture);
        end;
      end;
    end
    else
    begin
      if FPictureLocation <> '' then
      begin
        try
          p.LoadFromFile(FPictureLocation)
        except
          p.Graphic := nil;
        end;
      end
      else if FPicture.Graphic <> nil then
        p.Assign(FPicture);
    end;

    if (p.Graphic <> nil) then
    begin
      fhaspect := p.Height;
      fwaspect := p.Width;
      case FOwner.FImageQuality of
        iqNone:
        begin
          if FThreadedPictureLocation <> '' then
          begin
            fh := Fowner.PictureHeightZoomed;
            fw := Fowner.PictureWidthZoomed;
          end
          else
          begin
            fh := Fowner.PictureHeight;
            fw := Fowner.PictureWidth;
          end;
        end;
        iqFull:
        begin
          fh := fhaspect;
          fw := fwaspect;
        end;
        iqSelected:
        begin
          if (Index = Image) then
          begin
            fh := fhaspect;
            fw := fwaspect;
          end
          else
          begin
            fh := FOwner.PictureHeight;
            fw := FOwner.PictureWidth;
          end;
        end;
      end;

      sc := TMemoryStream.Create;

      if (p.Width > 0) or (p.Height > 0) then
        ratio := (FOwner.PictureWidth * FOwner.PictureHeight) / (p.Width * p.Height)
      else
        ratio := 0;

      if (ratio < 0.7) and (Index <> FOwner.GetCurrentSelectedImage) then
      begin
        pc := Graphics.TBitmap.Create;
        pc.Width := fw;
        pc.Height := fh;
        pc.Canvas.StretchDraw(Rect(0, 0, fw, fh), p.Graphic);
        pc.savetostream(sc);
        wres := fw;
        hres := fh;
        pc.Free;
      end
      else
      begin
        p.Graphic.SaveToStream(sc);
        wres := p.Width;
        hres := p.Height;
      end;

      hr := hr and D3DXCreateTextureFromFileInMemoryEx(Get3DDevice, sc.Memory, sc.Size, wres, hres, 1, 0,
        D3DFMT_UNKNOWN, D3DPOOL_DEFAULT, D3DX_FILTER_NONE, D3DX_FILTER_NONE, 0, nil, nil, FTexture);

      sc.Free;
      FOwner.ImageLoaded(Index, False);
    end;

    if (FAlternatePicture.Graphic = nil) and (FAlternatePictureLocation = '') then
    begin
      if Assigned(FOwner.OnImageCustomAlternateDraw) then
      begin
        a.Bitmap.Width := 0;
        a.Bitmap.Height := 0;
        a.Bitmap.PixelFormat := pf24bit;
        FOwner.ImageCustomAlternateDraw(a.Bitmap,Index);
      end
      else
      begin
        a.Graphic := nil;
        if (FOwner.DefaultAlternatePicture.Graphic <> nil) then
        begin
          if not FOwner.DefaultAlternatePicture.Graphic.Empty then
            a.Assign(FOwner.DefaultAlternatePicture);
        end;
      end;
    end
    else
    begin
      if FAlternatePictureLocation <> '' then
      begin
        try
          a.LoadFromFile(FAlternatePictureLocation)
        except
          a.Graphic := nil;
        end;
      end
      else if FAlternatePicture.Graphic <> nil then
        a.Assign(FAlternatePicture);
    end;

    if (a.Graphic <> nil) then
    begin
      fhaspectalt := a.Height;
      fwaspectalt := a.Width;
      case FOwner.FImageQuality of
        iqNone:
        begin
          fah := Fowner.PictureHeight;
          faw := Fowner.PictureWidth;
        end;
        iqFull:
        begin
          fah := fhaspectalt;
          faw := fwaspectalt;
        end;
        iqSelected:
        begin
          if Index = Image then
          begin
            fah := fhaspectalt;
            faw := fwaspectalt;
          end
          else
          begin
            fah := Fowner.PictureHeight;
            faw := FOwner.PictureWidth;
          end;
        end;
      end;

      sc := TMemoryStream.Create;
      ratio := (FOwner.PictureWidth * FOwner.PictureHeight) / (a.Width * a.Height);

      if ratio < 0.7 then
      begin
        ac := Graphics.TBitmap.Create;
        ac.Width := faw;
        ac.Height := fah;
        ac.Canvas.StretchDraw(Rect(0, 0, faw, fah), a.Graphic);
        ac.savetostream(sc);
        wres := faw;
        hres := fah;
        ac.Free;
      end
      else
      begin
        a.Graphic.SaveToStream(sc);
        wres := a.Width;
        hres := a.Height;
      end;

      hr := hr and D3DXCreateTextureFromFileInMemoryEx(Get3DDevice, sc.Memory, sc.Size, wres, hres, 1, 0,
        D3DFMT_UNKNOWN, D3DPOOL_DEFAULT, D3DX_FILTER_NONE, D3DX_FILTER_NONE, 0, nil, nil, FAltTexture);

      sc.Free;
      FAlternate := true;
      FOwner.ImageLoaded(Index, true);
    end
    else
      FAlternate := false;

    if not Assigned(FImageSprite) then
      hr := hr and D3DXCreateSprite(Get3DDevice, FImageSprite);
      
    Result := hr;

    p.Free;
    a.free;

  except
    on E : Exception do
    begin
      Result := E_FAIL;
      p.Free;
      a.free;
      s.Free;
      FOwner.FErrorOccured := true;
    end;
  end;
end;

function TGUIMotionsImage.InitVB: HRESULT;
begin
  Result := E_FAIL;

  if FOwner.FVertexBuffer = nil then
    if FAILED(Get3DDevice.CreateVertexBuffer(CountVertices * 2 * SizeOf(TCustomVertex), 0,
      D3DFVF_CUSTOMVERTEX, D3DPOOL_MANAGED, Fowner.FVertexBuffer, nil))
    then exit;

  if FOwner.FVertexGlowBuffer = nil then
    if FAILED(Get3DDevice.CreateVertexBuffer(CountVertices * 2 * SizeOf(TCustomVertex), 0,
      D3DFVF_CUSTOMVERTEX, D3DPOOL_MANAGED, Fowner.FVertexGlowBuffer, nil))
    then exit;

  if (FOwner.AnimationMode = amConicalInnerBand) or (FOwner.AnimationMode = amConicalOuterBand) then
    FillCylinderVertex
  else
  begin
    FillGlowVertex(FGlowVertex);
    FillVertex(FVertex, false);
    FillVertex(FFakeVertex, false);
    FillVertex(FAltVertex, true);
  end;

  Result := D3D_OK;
end;

procedure TGUIMotionsImage.SetAlternatePicture(const Value: TPicture);
begin
  if FAlternatePicture <> value then
  begin
    FAlternatePicture.Assign(Value);
    if not (csLoading in Fowner.Componentstate) then
      Fowner.Reset;
  end;
end;

procedure TGUIMotionsImage.SetAlternatePictureLocation(const Value: String);
begin
  if FAlternatePictureLocation <> value then
  begin
    FAlternatePictureLocation := Value;
    if not (csLoading in Fowner.Componentstate) then
      Fowner.Reset;
  end;
end;

procedure TGUIMotionsImage.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
  end;
end;

procedure TGUIMotionsImage.SetControl(const Value: TControl);
begin
  if FControl <> value then
  begin
    FControl := Value;
  end;
end;

procedure TGUIMotionsImage.SetFullCaption(const Value: String);
begin
  if FFullCaption <> value then
    FFullCaption := Value;
end;

procedure TGUIMotionsImage.SetPicture(const Value: TPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    if not (csLoading in Fowner.Componentstate) then
      Fowner.Reset;
  end;
end;

procedure TGUIMotionsImage.SetPictureLocation(const Value: String);
begin
  if FPictureLocation <> value then
  begin
    FPictureLocation := Value;
    if not (csLoading in Fowner.Componentstate) then
      Fowner.Reset;
  end;
end;

procedure TGUIMotionsImage.SetThreadedPictureLocation(const Value: String);
begin
  if FThreadedPictureLocation <> value then
    FThreadedPictureLocation := Value;
end;

procedure TGUIMotionsImage.SetThreadStatus(const Value: TImageThreadStatus);
begin
  if FThreadStatus <> value then
    FThreadStatus := Value;
end;

{ TGUIMotionsImages }

function TGUIMotionsImages.Add: TGUIMotionsImage;
begin   
  Result := TGUIMotionsImage(inherited Add);
end;

{$IFDEF USETHREADS}
procedure TGUIMotionsImages.Clear;
begin
  FOwner.StopThread;

  inherited Clear;
  FOwner.Invalidate;

  FOwner.StartThread;
end;
{$ENDIF}

constructor TGUIMotionsImages.Create(AOwner: TGUIMotions);
begin
  inherited Create(AOwner, GetItemClass);
  FOwner := AOwner;
end;

function TGUIMotionsImages.GetItem(Index: Integer): TGUIMotionsImage;
begin
  Result := TGUIMotionsImage(inherited GetItem(Index));
end;

function TGUIMotionsImages.GetItemClass: TCollectionItemClass;
begin
  Result := TGUIMotionsImage;
end;

function TGUIMotionsImages.Insert(index: integer): TGUIMotionsImage;
begin
  {$IFDEF DELPHI4_LVL}
  Result := TGUIMotionsImage(inherited Insert(Index));
  {$ELSE}
  Result := TGUIMotionsImage(inherited Add);
  {$ENDIF}
end;

procedure TGUIMotionsImages.SetItem(Index: Integer;
  const Value: TGUIMotionsImage);
begin
  inherited SetItem(Index, Value);
end;

{ TGuiMotionsScrollBar }

procedure TGUIMotionsScrollBar.Assign(Source: TPersistent);
begin
  if (Source is TGUIMotionsScrollBar) then
  begin
    ArrowColor := (Source as TGUIMotionsScrollBar).ArrowColor;
    Color := (Source as TGUIMotionsScrollBar).Color;
    ColorAlpha := (Source as TGUIMotionsScrollBar).ColorAlpha;
    SlideColor := (Source as TGUIMotionsScrollBar).SlideColor;
    SlideHeight := (Source as TGUIMotionsScrollBar).SlideHeight;
    SlideWidth := (Source as TGUIMotionsScrollBar).SlideWidth;
    TrackerColor := (Source as TGUIMotionsScrollBar).TrackerColor;
    TrackerAlpha := (Source as TGUIMotionsScrollBar).TrackerAlpha;
    TrackerHeight := (Source as TGUIMotionsScrollBar).TrackerHeight;
    Visible := (Source as TGUIMotionsScrollBar).Visible;
    OverLayColor := (Source as TGUIMotionsScrollBar).OverLayColor;
    OverLayAlphaTop := (Source as TGUIMotionsScrollBar).OverLayAlphaTop;
    OverLayAlphaBottom := (Source as TGUIMotionsScrollBar).OverLayAlphaBottom;
    Width := (Source as TGUIMotionsScrollBar).Width;
    Height := (Source as TGUIMotionsScrollBar).Height;
    Left := (Source as TGUIMotionsScrollBar).Left;
    Top := (Source as TGUIMotionsScrollBar).Top;
    Position := (source as TGUIMotionsScrollBar).Position;
  end;
end;

constructor TGUIMotionsScrollBar.Create(AOwner: TComponent);
begin
  FOwner := TGUIMotions(AOwner);
  FArrowColor := clBtnHighlight;
  FColor := clBlue;
  FOverLay := clWhite;
  FOverLayAlphaBottom := 0;
  FOverLayAlphaTop := 150;
  FColorAlpha := 125;
  FTrackerAlpha := 255;
  FTrackerHeight := 3;
  FTrackerColor := clBlue;
  FSliderColor := clBlue;
  FSlideAlpha := 125;
  FSlideHeight := 15;
  FSlideWidth := 30;
  FWidth := 250;
  FHeight := 25;
  FLeft := 0;
  FTop := 0;
  FPosition := spBottomCenter;
  FVisible := false;
end;

destructor TGUIMotionsScrollBar.Destroy;
begin
  inherited;
end;

function TGUIMotionsScrollBar.GetSliderPosByImageIndex(Image: integer): Single;
var
  arrow, rwc: Single;
begin
  arrow := FVertex[5].position.X;
  rwc := FWidth - SlideWidth - (arrow) * 2;
  if FOwner.Images.Count > 1 then
    Result := arrow + ((rwc / (FOwner.Images.Count - 1)) * Image)
  else
    Result := arrow;
end;


procedure TGUIMotionsScrollBar.InitSliderPos(pos: Single);
begin
  if (pos >= FVertex[5].position.X) and (pos <= FWidth - FSlideWidth - FVertex[5].position.X) then
  begin
    with FVertex[26] do
      position := D3DXVector3(pos, (FHeight / 2) - (FSlideHeight / 2), 0);

    with FVertex[27] do
      position := D3DXVector3(pos + FSlideWidth, (FHeight / 2) - (FSlideHeight / 2), 0);

    with FVertex[28] do
      position := D3DXVector3(pos, (FHeight / 2) + (FSlideHeight / 2), 0);

    with FVertex[29] do
      position := D3DXVector3(pos + FSlideWidth, (FHeight / 2) + (FSlideHeight / 2), 0);
  end;
end;

procedure TGUIMotionsScrollBar.SetArrowColor(const Value: TColor);
begin
  if FArrowColor <> value then
  begin
    FArrowColor := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetColorAlpha(const Value: Byte);
begin
  if FColorAlpha <> value then
  begin
    FColorAlpha := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetHeight(const Value: integer);
begin
  if FHeight <> value then
  begin
    FHeight := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetOverLayAlphaBottom(const Value: Byte);
begin
  if FOverLayAlphaBottom <> value then
  begin
    FOverLayAlphaBottom := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetOverLayAlphaTop(const Value: Byte);
begin
  if FOverLayAlphaTop <> value then
  begin
    FOverLayAlphaTop := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetOverLayColor(const Value: TColor);
begin
  if FOverLay <> value then
  begin
    FOverLay := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetPosition(const Value: TGUIMotionsPosition);
begin
  if FPosition <> value then
  begin
    FPosition := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetSlideAlpha(const Value: Byte);
begin
  if FSlideAlpha <> value then
  begin
    FSlideAlpha := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetSlideColor(const Value: TColor);
begin
  if FSliderColor <> value then
  begin
    FSliderColor := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetSlideHeight(const Value: integer);
begin
  if FSlideHeight <> value then
  begin
    FSlideHeight := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetSlideWidth(const Value: integer);
begin
  if FSlideWidth <> value then
  begin
    FSlideWidth := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetTrackerAlpha(const Value: Byte);
begin
  if FTrackerAlpha <> value then
  begin
    FTrackerAlpha := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetTrackerColor(const Value: TColor);
begin
  if FTrackerColor <> value then
  begin
    FTrackerColor := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetTrackerHeight(const Value: integer);
begin
  if FTrackerHeight <> value then
  begin
    FTrackerHeight := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;

procedure TGUIMotionsScrollBar.SetWidth(const Value: integer);
begin
  if FWidth <> value then
  begin
    FWidth := Value;
    if not (csLoading in Fowner.Componentstate) then
    begin
      FOwner.InitScrollBar;
      FOwner.EnableRendering(true);
      FOwner.Render;
    end;
  end;
end;


{$IFDEF USETHREADS}

{ TImageLoaderThread }

constructor TImageLoaderThread.Create(AGUIMotions: TGUIMotions);
begin
  GUIMotions := AGUIMotions;
  inherited Create(False);
end;

procedure TImageLoaderThread.Execute;
var
  i: integer;
  pic: TPicture;
  pc: graphics.TBitmap;
  gotImage: boolean;
begin
  if not GUIMotions.FD3DInitialized and (csDesigning in GUIMotions.ComponentState) then
    Exit;

  pic := TPicture.Create;
  while (1 > 0) and not Terminated do
  begin
    gotImage := false;
    for i := GUIMotions.GetStartCount to GUIMotions.GetRenderingCount - 1 do
    begin
      if Terminated or Guimotions.FReload then
      begin
        Guimotions.FReload := false;
        break;
      end;

      if GUIMotions.Images[i].FThreadStatus = stInitialized then
      begin
        gotImage := true;
        GUIMotions.Images[i].FThreadStatus := stStarted;

        if Terminated then
          break;

        with GUIMotions.images[i] do
        begin
          case GUIMotions.FImageQuality of
            iqNone:
            begin
              try
                pic.LoadFromFile(GUIMotions.Images[i].FThreadedPictureLocation);
              except
                pic.Graphic := nil;
              end;

              if pic.Graphic <> nil then
              begin
                pc := graphics.TBitmap.Create;

                pc.Width := GUIMotions.PictureWidthZoomed;
                pc.Height := GUIMotions.PictureHeightZoomed;

                pc.Canvas.Lock;
                pc.Canvas.StretchDraw(Rect(0, 0, pc.Width, pc.Height), pic.Graphic);

                pc.Canvas.Unlock;
                GUIMotions.Images[i].Picture.Assign(pc);
                pc.Free;
              end
              else
                Guimotions.Images[i].Picture.Graphic := nil;
            end;
            iqSelected, iqFull:
            begin
              try
                GUIMotions.Images[i].Picture.LoadFromFile(GUIMotions.Images[i].FThreadedPictureLocation);
              except
                GUIMotions.Images[i].Picture.Graphic := nil;
              end;
            end;
          end;
        end;

        if Terminated then
          break;

        GUIMotions.Images[i].FThreadStatus := stLoaded;
        GUIMotions.Images[i].FReload := true;
        GUIMotions.EnableMouseRendering(true);
        GUIMotions.EnableRendering(true);
        if i = GUIMotions.GetCurrentSelectedImage then
        begin
          with Guimotions.Images[GUIMotions.GetCurrentSelectedImage] do
          begin
            FScaleV.x := 1;
            FScaleV.y := 1;
            GUIMotions.SelectImage(I);
          end;
        end;
      end;
    end;

    if not gotImage then sleep(10);

  end;
  pic.Free;
end;
{$ENDIF}

{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}

end.




