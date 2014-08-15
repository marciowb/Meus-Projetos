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
unit ap_MsInkAut;

interface

uses
  Tpcshrd,
  Windows,
  ActiveX,
  MsInkAut,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatMsInkAutLibrary = class(TatScripterLibrary)
    procedure __GetIID_IInkRectangle(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkExtendedProperty(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkExtendedProperties(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkDrawingAttributes(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkTransform(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkGesture(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkCursor(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkCursors(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkCursorButton(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkCursorButtons(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkTablet(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkTablet2(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkTablet3(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkTablets(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkStrokeDisp(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkStrokes(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkCustomStrokes(AMachine: TatVirtualMachine);
    procedure __GetIID__IInkStrokesEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkDisp(AMachine: TatVirtualMachine);
    procedure __GetIID__IInkEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRenderer(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkCollector(AMachine: TatVirtualMachine);
    procedure __GetIID__IInkCollectorEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkOverlay(AMachine: TatVirtualMachine);
    procedure __GetIID__IInkOverlayEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkPicture(AMachine: TatVirtualMachine);
    procedure __GetIID__IInkPictureEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognizer(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognizer2(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognizers(AMachine: TatVirtualMachine);
    procedure __GetIID__IInkRecognitionEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognizerContext(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognizerContext2(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognitionResult(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognitionAlternate(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognitionAlternates(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkRecognizerGuide(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkWordList(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkWordList2(AMachine: TatVirtualMachine);
    procedure __GetIID_IInk(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkLineInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_ISketchInk(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkDisp(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkOverlay(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkPicture(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkCollector(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkDrawingAttributes(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkRectangle(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkRenderer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkTransform(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkRecognizers(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkRecognizerContext(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkRecognizerGuide(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkTablets(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkWordList(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkStrokes(AMachine: TatVirtualMachine);
    procedure __GetCLSID_Ink(AMachine: TatVirtualMachine);
    procedure __GetCLSID_SketchInk(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_X(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_Y(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_Z(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_PACKET_STATUS(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_TIMER_TICK(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_SERIAL_NUMBER(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_NORMAL_PRESSURE(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_TANGENT_PRESSURE(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_BUTTON_PRESSURE(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_X_TILT_ORIENTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_Y_TILT_ORIENTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_AZIMUTH_ORIENTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_ALTITUDE_ORIENTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_TWIST_ORIENTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_PITCH_ROTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_ROLL_ROTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_YAW_ROTATION(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_WIDTH(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_HEIGHT(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_FINGERCONTACTCONFIDENCE(AMachine: TatVirtualMachine);
    procedure __GetGUID_PACKETPROPERTY_GUID_DEVICE_CONTACT_ID(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  INKMETRICWrapper = class(TatRecordWrapper)
  private
    FiHeight: Integer;
    FiFontAscent: Integer;
    FiFontDescent: Integer;
    FdwFlags: DWORD;
    Fcolor: COLORREF;
  public
    constructor Create(ARecord: INKMETRIC);
    function ObjToRec: INKMETRIC;
  published
    property iHeight: Integer read FiHeight write FiHeight;
    property iFontAscent: Integer read FiFontAscent write FiFontAscent;
    property iFontDescent: Integer read FiFontDescent write FiFontDescent;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property color: COLORREF read Fcolor write Fcolor;
  end;
  
  _InkRecoGuideWrapper = class(TatRecordWrapper)
  private
    FcRows: Integer;
    FcColumns: Integer;
    Fmidline: Integer;
  public
    constructor Create(ARecord: _InkRecoGuide);
    function ObjToRec: _InkRecoGuide;
  published
    property cRows: Integer read FcRows write FcRows;
    property cColumns: Integer read FcColumns write FcColumns;
    property midline: Integer read Fmidline write Fmidline;
  end;
  

implementation

constructor INKMETRICWrapper.Create(ARecord: INKMETRIC);
begin
  inherited Create;
  FiHeight := ARecord.iHeight;
  FiFontAscent := ARecord.iFontAscent;
  FiFontDescent := ARecord.iFontDescent;
  FdwFlags := ARecord.dwFlags;
  Fcolor := ARecord.color;
end;

function INKMETRICWrapper.ObjToRec: INKMETRIC;
begin
  result.iHeight := FiHeight;
  result.iFontAscent := FiFontAscent;
  result.iFontDescent := FiFontDescent;
  result.dwFlags := FdwFlags;
  result.color := Fcolor;
end;

constructor _InkRecoGuideWrapper.Create(ARecord: _InkRecoGuide);
begin
  inherited Create;
  FcRows := ARecord.cRows;
  FcColumns := ARecord.cColumns;
  Fmidline := ARecord.midline;
end;

function _InkRecoGuideWrapper.ObjToRec: _InkRecoGuide;
begin
  result.cRows := FcRows;
  result.cColumns := FcColumns;
  result.midline := Fmidline;
end;



procedure TatMsInkAutLibrary.__GetIID_IInkRectangle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRectangle)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkExtendedProperty(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkExtendedProperty)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkExtendedProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkExtendedProperties)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkDrawingAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkDrawingAttributes)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkTransform(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkTransform)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkGesture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkGesture)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkCursor)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkCursors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkCursors)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkCursorButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkCursorButton)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkCursorButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkCursorButtons)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkTablet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkTablet)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkTablet2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkTablet2)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkTablet3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkTablet3)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkTablets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkTablets)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkStrokeDisp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkStrokeDisp)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkStrokes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkStrokes)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkCustomStrokes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkCustomStrokes)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID__IInkStrokesEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID__IInkStrokesEvents)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkDisp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkDisp)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID__IInkEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID__IInkEvents)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRenderer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRenderer)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkCollector(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkCollector)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID__IInkCollectorEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID__IInkCollectorEvents)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkOverlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkOverlay)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID__IInkOverlayEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID__IInkOverlayEvents)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkPicture)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID__IInkPictureEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID__IInkPictureEvents)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognizer)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognizer2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognizer2)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognizers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognizers)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID__IInkRecognitionEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID__IInkRecognitionEvents)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognizerContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognizerContext)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognizerContext2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognizerContext2)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognitionResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognitionResult)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognitionAlternate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognitionAlternate)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognitionAlternates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognitionAlternates)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkRecognizerGuide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkRecognizerGuide)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkWordList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkWordList)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkWordList2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkWordList2)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInk)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_IInkLineInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_IInkLineInfo)));
  end;
end;

procedure TatMsInkAutLibrary.__GetIID_ISketchInk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.IID_ISketchInk)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkDisp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkDisp)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkOverlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkOverlay)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkPicture)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkCollector(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkCollector)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkDrawingAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkDrawingAttributes)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkRectangle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkRectangle)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkRenderer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkRenderer)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkTransform(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkTransform)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkRecognizers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkRecognizers)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkRecognizerContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkRecognizerContext)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkRecognizerGuide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkRecognizerGuide)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkTablets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkTablets)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkWordList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkWordList)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_InkStrokes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_InkStrokes)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_Ink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_Ink)));
  end;
end;

procedure TatMsInkAutLibrary.__GetCLSID_SketchInk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.CLSID_SketchInk)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_X(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_X)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_Y(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_Y)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_Z(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_Z)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_PACKET_STATUS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_PACKET_STATUS)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_TIMER_TICK(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_TIMER_TICK)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_SERIAL_NUMBER(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_SERIAL_NUMBER)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_NORMAL_PRESSURE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_NORMAL_PRESSURE)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_TANGENT_PRESSURE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_TANGENT_PRESSURE)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_BUTTON_PRESSURE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_BUTTON_PRESSURE)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_X_TILT_ORIENTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_X_TILT_ORIENTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_Y_TILT_ORIENTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_Y_TILT_ORIENTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_AZIMUTH_ORIENTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_AZIMUTH_ORIENTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_ALTITUDE_ORIENTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_ALTITUDE_ORIENTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_TWIST_ORIENTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_TWIST_ORIENTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_PITCH_ROTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_PITCH_ROTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_ROLL_ROTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_ROLL_ROTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_YAW_ROTATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_YAW_ROTATION)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_WIDTH(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_WIDTH)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_HEIGHT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_HEIGHT)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_FINGERCONTACTCONFIDENCE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_FINGERCONTACTCONFIDENCE)));
  end;
end;

procedure TatMsInkAutLibrary.__GetGUID_PACKETPROPERTY_GUID_DEVICE_CONTACT_ID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut.GUID_PACKETPROPERTY_GUID_DEVICE_CONTACT_ID)));
  end;
end;

procedure TatMsInkAutLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('IID_IInkRectangle',tkVariant,__GetIID_IInkRectangle,nil,nil,false,0);
    DefineProp('IID_IInkExtendedProperty',tkVariant,__GetIID_IInkExtendedProperty,nil,nil,false,0);
    DefineProp('IID_IInkExtendedProperties',tkVariant,__GetIID_IInkExtendedProperties,nil,nil,false,0);
    DefineProp('IID_IInkDrawingAttributes',tkVariant,__GetIID_IInkDrawingAttributes,nil,nil,false,0);
    DefineProp('IID_IInkTransform',tkVariant,__GetIID_IInkTransform,nil,nil,false,0);
    DefineProp('IID_IInkGesture',tkVariant,__GetIID_IInkGesture,nil,nil,false,0);
    DefineProp('IID_IInkCursor',tkVariant,__GetIID_IInkCursor,nil,nil,false,0);
    DefineProp('IID_IInkCursors',tkVariant,__GetIID_IInkCursors,nil,nil,false,0);
    DefineProp('IID_IInkCursorButton',tkVariant,__GetIID_IInkCursorButton,nil,nil,false,0);
    DefineProp('IID_IInkCursorButtons',tkVariant,__GetIID_IInkCursorButtons,nil,nil,false,0);
    DefineProp('IID_IInkTablet',tkVariant,__GetIID_IInkTablet,nil,nil,false,0);
    DefineProp('IID_IInkTablet2',tkVariant,__GetIID_IInkTablet2,nil,nil,false,0);
    DefineProp('IID_IInkTablet3',tkVariant,__GetIID_IInkTablet3,nil,nil,false,0);
    DefineProp('IID_IInkTablets',tkVariant,__GetIID_IInkTablets,nil,nil,false,0);
    DefineProp('IID_IInkStrokeDisp',tkVariant,__GetIID_IInkStrokeDisp,nil,nil,false,0);
    DefineProp('IID_IInkStrokes',tkVariant,__GetIID_IInkStrokes,nil,nil,false,0);
    DefineProp('IID_IInkCustomStrokes',tkVariant,__GetIID_IInkCustomStrokes,nil,nil,false,0);
    DefineProp('IID__IInkStrokesEvents',tkVariant,__GetIID__IInkStrokesEvents,nil,nil,false,0);
    DefineProp('IID_IInkDisp',tkVariant,__GetIID_IInkDisp,nil,nil,false,0);
    DefineProp('IID__IInkEvents',tkVariant,__GetIID__IInkEvents,nil,nil,false,0);
    DefineProp('IID_IInkRenderer',tkVariant,__GetIID_IInkRenderer,nil,nil,false,0);
    DefineProp('IID_IInkCollector',tkVariant,__GetIID_IInkCollector,nil,nil,false,0);
    DefineProp('IID__IInkCollectorEvents',tkVariant,__GetIID__IInkCollectorEvents,nil,nil,false,0);
    DefineProp('IID_IInkOverlay',tkVariant,__GetIID_IInkOverlay,nil,nil,false,0);
    DefineProp('IID__IInkOverlayEvents',tkVariant,__GetIID__IInkOverlayEvents,nil,nil,false,0);
    DefineProp('IID_IInkPicture',tkVariant,__GetIID_IInkPicture,nil,nil,false,0);
    DefineProp('IID__IInkPictureEvents',tkVariant,__GetIID__IInkPictureEvents,nil,nil,false,0);
    DefineProp('IID_IInkRecognizer',tkVariant,__GetIID_IInkRecognizer,nil,nil,false,0);
    DefineProp('IID_IInkRecognizer2',tkVariant,__GetIID_IInkRecognizer2,nil,nil,false,0);
    DefineProp('IID_IInkRecognizers',tkVariant,__GetIID_IInkRecognizers,nil,nil,false,0);
    DefineProp('IID__IInkRecognitionEvents',tkVariant,__GetIID__IInkRecognitionEvents,nil,nil,false,0);
    DefineProp('IID_IInkRecognizerContext',tkVariant,__GetIID_IInkRecognizerContext,nil,nil,false,0);
    DefineProp('IID_IInkRecognizerContext2',tkVariant,__GetIID_IInkRecognizerContext2,nil,nil,false,0);
    DefineProp('IID_IInkRecognitionResult',tkVariant,__GetIID_IInkRecognitionResult,nil,nil,false,0);
    DefineProp('IID_IInkRecognitionAlternate',tkVariant,__GetIID_IInkRecognitionAlternate,nil,nil,false,0);
    DefineProp('IID_IInkRecognitionAlternates',tkVariant,__GetIID_IInkRecognitionAlternates,nil,nil,false,0);
    DefineProp('IID_IInkRecognizerGuide',tkVariant,__GetIID_IInkRecognizerGuide,nil,nil,false,0);
    DefineProp('IID_IInkWordList',tkVariant,__GetIID_IInkWordList,nil,nil,false,0);
    DefineProp('IID_IInkWordList2',tkVariant,__GetIID_IInkWordList2,nil,nil,false,0);
    DefineProp('IID_IInk',tkVariant,__GetIID_IInk,nil,nil,false,0);
    DefineProp('IID_IInkLineInfo',tkVariant,__GetIID_IInkLineInfo,nil,nil,false,0);
    DefineProp('IID_ISketchInk',tkVariant,__GetIID_ISketchInk,nil,nil,false,0);
    DefineProp('CLSID_InkDisp',tkVariant,__GetCLSID_InkDisp,nil,nil,false,0);
    DefineProp('CLSID_InkOverlay',tkVariant,__GetCLSID_InkOverlay,nil,nil,false,0);
    DefineProp('CLSID_InkPicture',tkVariant,__GetCLSID_InkPicture,nil,nil,false,0);
    DefineProp('CLSID_InkCollector',tkVariant,__GetCLSID_InkCollector,nil,nil,false,0);
    DefineProp('CLSID_InkDrawingAttributes',tkVariant,__GetCLSID_InkDrawingAttributes,nil,nil,false,0);
    DefineProp('CLSID_InkRectangle',tkVariant,__GetCLSID_InkRectangle,nil,nil,false,0);
    DefineProp('CLSID_InkRenderer',tkVariant,__GetCLSID_InkRenderer,nil,nil,false,0);
    DefineProp('CLSID_InkTransform',tkVariant,__GetCLSID_InkTransform,nil,nil,false,0);
    DefineProp('CLSID_InkRecognizers',tkVariant,__GetCLSID_InkRecognizers,nil,nil,false,0);
    DefineProp('CLSID_InkRecognizerContext',tkVariant,__GetCLSID_InkRecognizerContext,nil,nil,false,0);
    DefineProp('CLSID_InkRecognizerGuide',tkVariant,__GetCLSID_InkRecognizerGuide,nil,nil,false,0);
    DefineProp('CLSID_InkTablets',tkVariant,__GetCLSID_InkTablets,nil,nil,false,0);
    DefineProp('CLSID_InkWordList',tkVariant,__GetCLSID_InkWordList,nil,nil,false,0);
    DefineProp('CLSID_InkStrokes',tkVariant,__GetCLSID_InkStrokes,nil,nil,false,0);
    DefineProp('CLSID_Ink',tkVariant,__GetCLSID_Ink,nil,nil,false,0);
    DefineProp('CLSID_SketchInk',tkVariant,__GetCLSID_SketchInk,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_X',tkVariant,__GetGUID_PACKETPROPERTY_GUID_X,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_Y',tkVariant,__GetGUID_PACKETPROPERTY_GUID_Y,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_Z',tkVariant,__GetGUID_PACKETPROPERTY_GUID_Z,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_PACKET_STATUS',tkVariant,__GetGUID_PACKETPROPERTY_GUID_PACKET_STATUS,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_TIMER_TICK',tkVariant,__GetGUID_PACKETPROPERTY_GUID_TIMER_TICK,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_SERIAL_NUMBER',tkVariant,__GetGUID_PACKETPROPERTY_GUID_SERIAL_NUMBER,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_NORMAL_PRESSURE',tkVariant,__GetGUID_PACKETPROPERTY_GUID_NORMAL_PRESSURE,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_TANGENT_PRESSURE',tkVariant,__GetGUID_PACKETPROPERTY_GUID_TANGENT_PRESSURE,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_BUTTON_PRESSURE',tkVariant,__GetGUID_PACKETPROPERTY_GUID_BUTTON_PRESSURE,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_X_TILT_ORIENTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_X_TILT_ORIENTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_Y_TILT_ORIENTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_Y_TILT_ORIENTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_AZIMUTH_ORIENTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_AZIMUTH_ORIENTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_ALTITUDE_ORIENTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_ALTITUDE_ORIENTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_TWIST_ORIENTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_TWIST_ORIENTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_PITCH_ROTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_PITCH_ROTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_ROLL_ROTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_ROLL_ROTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_YAW_ROTATION',tkVariant,__GetGUID_PACKETPROPERTY_GUID_YAW_ROTATION,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_WIDTH',tkVariant,__GetGUID_PACKETPROPERTY_GUID_WIDTH,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_HEIGHT',tkVariant,__GetGUID_PACKETPROPERTY_GUID_HEIGHT,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_FINGERCONTACTCONFIDENCE',tkVariant,__GetGUID_PACKETPROPERTY_GUID_FINGERCONTACTCONFIDENCE,nil,nil,false,0);
    DefineProp('GUID_PACKETPROPERTY_GUID_DEVICE_CONTACT_ID',tkVariant,__GetGUID_PACKETPROPERTY_GUID_DEVICE_CONTACT_ID,nil,nil,false,0);
    AddConstant('SID_IInkRectangle',SID_IInkRectangle);
    AddConstant('SID_IInkExtendedProperty',SID_IInkExtendedProperty);
    AddConstant('SID_IInkExtendedProperties',SID_IInkExtendedProperties);
    AddConstant('SID_IInkDrawingAttributes',SID_IInkDrawingAttributes);
    AddConstant('SID_IInkTransform',SID_IInkTransform);
    AddConstant('SID_IInkGesture',SID_IInkGesture);
    AddConstant('SID_IInkCursor',SID_IInkCursor);
    AddConstant('SID_IInkCursors',SID_IInkCursors);
    AddConstant('SID_IInkCursorButton',SID_IInkCursorButton);
    AddConstant('SID_IInkCursorButtons',SID_IInkCursorButtons);
    AddConstant('SID_IInkTablet',SID_IInkTablet);
    AddConstant('SID_IInkTablet2',SID_IInkTablet2);
    AddConstant('SID_IInkTablet3',SID_IInkTablet3);
    AddConstant('SID_IInkTablets',SID_IInkTablets);
    AddConstant('SID_IInkStrokeDisp',SID_IInkStrokeDisp);
    AddConstant('SID_IInkStrokes',SID_IInkStrokes);
    AddConstant('SID_IInkCustomStrokes',SID_IInkCustomStrokes);
    AddConstant('SID__IInkStrokesEvents',SID__IInkStrokesEvents);
    AddConstant('SID_IInkDisp',SID_IInkDisp);
    AddConstant('SID__IInkEvents',SID__IInkEvents);
    AddConstant('SID_IInkRenderer',SID_IInkRenderer);
    AddConstant('SID_IInkCollector',SID_IInkCollector);
    AddConstant('SID__IInkCollectorEvents',SID__IInkCollectorEvents);
    AddConstant('SID_IInkOverlay',SID_IInkOverlay);
    AddConstant('SID__IInkOverlayEvents',SID__IInkOverlayEvents);
    AddConstant('SID_IInkPicture',SID_IInkPicture);
    AddConstant('SID__IInkPictureEvents',SID__IInkPictureEvents);
    AddConstant('SID_IInkRecognizer',SID_IInkRecognizer);
    AddConstant('SID_IInkRecognizer2',SID_IInkRecognizer2);
    AddConstant('SID_IInkRecognizers',SID_IInkRecognizers);
    AddConstant('SID__IInkRecognitionEvents',SID__IInkRecognitionEvents);
    AddConstant('SID_IInkRecognizerContext',SID_IInkRecognizerContext);
    AddConstant('SID_IInkRecognizerContext2',SID_IInkRecognizerContext2);
    AddConstant('SID_IInkRecognitionResult',SID_IInkRecognitionResult);
    AddConstant('SID_IInkRecognitionAlternate',SID_IInkRecognitionAlternate);
    AddConstant('SID_IInkRecognitionAlternates',SID_IInkRecognitionAlternates);
    AddConstant('SID_IInkRecognizerGuide',SID_IInkRecognizerGuide);
    AddConstant('SID_IInkWordList',SID_IInkWordList);
    AddConstant('SID_IInkWordList2',SID_IInkWordList2);
    AddConstant('SID_IInk',SID_IInk);
    AddConstant('SID_IInkLineInfo',SID_IInkLineInfo);
    AddConstant('SID_ISketchInk',SID_ISketchInk);
    AddConstant('IMF_FONT_SELECTED_IN_HDC',IMF_FONT_SELECTED_IN_HDC);
    AddConstant('IMF_ITALIC',IMF_ITALIC);
    AddConstant('IMF_BOLD',IMF_BOLD);
    AddConstant('TCF_ALLOW_RECOGNITION',TCF_ALLOW_RECOGNITION);
    AddConstant('TCF_FORCE_RECOGNITION',TCF_FORCE_RECOGNITION);
    AddConstant('INK_SERIALIZED_FORMAT',INK_SERIALIZED_FORMAT);
    AddConstant('ISC_FirstElement',ISC_FirstElement);
    AddConstant('ISC_AllElements',ISC_AllElements);
    AddConstant('STR_GUID_X',STR_GUID_X);
    AddConstant('STR_GUID_Y',STR_GUID_Y);
    AddConstant('STR_GUID_Z',STR_GUID_Z);
    AddConstant('STR_GUID_PAKETSTATUS',STR_GUID_PAKETSTATUS);
    AddConstant('STR_GUID_TIMERTICK',STR_GUID_TIMERTICK);
    AddConstant('STR_GUID_SERIALNUMBER',STR_GUID_SERIALNUMBER);
    AddConstant('STR_GUID_NORMALPRESSURE',STR_GUID_NORMALPRESSURE);
    AddConstant('STR_GUID_TANGENTPRESSURE',STR_GUID_TANGENTPRESSURE);
    AddConstant('STR_GUID_BUTTONPRESSURE',STR_GUID_BUTTONPRESSURE);
    AddConstant('STR_GUID_XTILTORIENTATION',STR_GUID_XTILTORIENTATION);
    AddConstant('STR_GUID_YTILTORIENTATION',STR_GUID_YTILTORIENTATION);
    AddConstant('STR_GUID_AZIMUTHORIENTATION',STR_GUID_AZIMUTHORIENTATION);
    AddConstant('STR_GUID_ALTITUDEORIENTATION',STR_GUID_ALTITUDEORIENTATION);
    AddConstant('STR_GUID_TWISTORIENTATION',STR_GUID_TWISTORIENTATION);
    AddConstant('STR_GUID_PITCHROTATION',STR_GUID_PITCHROTATION);
    AddConstant('STR_GUID_ROLLROTATION',STR_GUID_ROLLROTATION);
    AddConstant('STR_GUID_YAWROTATION',STR_GUID_YAWROTATION);
    AddConstant('STR_GUID_WIDTH',STR_GUID_WIDTH);
    AddConstant('STR_GUID_HEIGHT',STR_GUID_HEIGHT);
    AddConstant('STR_GUID_FINGERCONTACTCONFIDENCE',STR_GUID_FINGERCONTACTCONFIDENCE);
    AddConstant('STR_GUID_DEVICE_CONTACT_ID',STR_GUID_DEVICE_CONTACT_ID);
    AddConstant('INKRECOGNITIONPROPERTY_LINENUMBER',INKRECOGNITIONPROPERTY_LINENUMBER);
    AddConstant('INKRECOGNITIONPROPERTY_BOXNUMBER',INKRECOGNITIONPROPERTY_BOXNUMBER);
    AddConstant('INKRECOGNITIONPROPERTY_SEGMENTATION',INKRECOGNITIONPROPERTY_SEGMENTATION);
    AddConstant('INKRECOGNITIONPROPERTY_HOTPOINT',INKRECOGNITIONPROPERTY_HOTPOINT);
    AddConstant('INKRECOGNITIONPROPERTY_MAXIMUMSTROKECOUNT',INKRECOGNITIONPROPERTY_MAXIMUMSTROKECOUNT);
    AddConstant('INKRECOGNITIONPROPERTY_POINTSPERINCH',INKRECOGNITIONPROPERTY_POINTSPERINCH);
    AddConstant('INKRECOGNITIONPROPERTY_CONFIDENCELEVEL',INKRECOGNITIONPROPERTY_CONFIDENCELEVEL);
    AddConstant('INKRECOGNITIONPROPERTY_LINEMETRICS',INKRECOGNITIONPROPERTY_LINEMETRICS);
    AddConstant('FACTOID_NONE',FACTOID_NONE);
    AddConstant('FACTOID_DEFAULT',FACTOID_DEFAULT);
    AddConstant('FACTOID_SYSTEMDICTIONARY',FACTOID_SYSTEMDICTIONARY);
    AddConstant('FACTOID_WORDLIST',FACTOID_WORDLIST);
    AddConstant('FACTOID_EMAIL',FACTOID_EMAIL);
    AddConstant('FACTOID_WEB',FACTOID_WEB);
    AddConstant('FACTOID_ONECHAR',FACTOID_ONECHAR);
    AddConstant('FACTOID_NUMBER',FACTOID_NUMBER);
    AddConstant('FACTOID_DIGIT',FACTOID_DIGIT);
    AddConstant('FACTOID_NUMBERSIMPLE',FACTOID_NUMBERSIMPLE);
    AddConstant('FACTOID_CURRENCY',FACTOID_CURRENCY);
    AddConstant('FACTOID_POSTALCODE',FACTOID_POSTALCODE);
    AddConstant('FACTOID_PERCENT',FACTOID_PERCENT);
    AddConstant('FACTOID_DATE',FACTOID_DATE);
    AddConstant('FACTOID_TIME',FACTOID_TIME);
    AddConstant('FACTOID_TELEPHONE',FACTOID_TELEPHONE);
    AddConstant('FACTOID_FILENAME',FACTOID_FILENAME);
    AddConstant('FACTOID_UPPERCHAR',FACTOID_UPPERCHAR);
    AddConstant('FACTOID_LOWERCHAR',FACTOID_LOWERCHAR);
    AddConstant('FACTOID_PUNCCHAR',FACTOID_PUNCCHAR);
    AddConstant('FACTOID_JAPANESECOMMON',FACTOID_JAPANESECOMMON);
    AddConstant('FACTOID_CHINESESIMPLECOMMON',FACTOID_CHINESESIMPLECOMMON);
    AddConstant('FACTOID_CHINESETRADITIONALCOMMON',FACTOID_CHINESETRADITIONALCOMMON);
    AddConstant('FACTOID_KOREANCOMMON',FACTOID_KOREANCOMMON);
    AddConstant('FACTOID_HIRAGANA',FACTOID_HIRAGANA);
    AddConstant('FACTOID_KATAKANA',FACTOID_KATAKANA);
    AddConstant('FACTOID_KANJICOMMON',FACTOID_KANJICOMMON);
    AddConstant('FACTOID_KANJIRARE',FACTOID_KANJIRARE);
    AddConstant('FACTOID_BOPOMOFO',FACTOID_BOPOMOFO);
    AddConstant('FACTOID_JAMO',FACTOID_JAMO);
    AddConstant('FACTOID_HANGULCOMMON',FACTOID_HANGULCOMMON);
    AddConstant('FACTOID_HANGULRARE',FACTOID_HANGULRARE);
    AddConstant('IBBM_Default',IBBM_Default);
    AddConstant('IBBM_NoCurveFit',IBBM_NoCurveFit);
    AddConstant('IBBM_CurveFit',IBBM_CurveFit);
    AddConstant('IBBM_PointsOnly',IBBM_PointsOnly);
    AddConstant('IBBM_Union',IBBM_Union);
    AddConstant('IBBM_Last',IBBM_Last);
    AddConstant('IEF_CopyFromOriginal',IEF_CopyFromOriginal);
    AddConstant('IEF_RemoveFromOriginal',IEF_RemoveFromOriginal);
    AddConstant('IEF_Default',IEF_Default);
    AddConstant('IEF_All',IEF_All);
    AddConstant('IPF_InkSerializedFormat',IPF_InkSerializedFormat);
    AddConstant('IPF_Base64InkSerializedFormat',IPF_Base64InkSerializedFormat);
    AddConstant('IPF_GIF',IPF_GIF);
    AddConstant('IPF_Base64GIF',IPF_Base64GIF);
    AddConstant('IPF_Last',IPF_Last);
    AddConstant('IPCM_Default',IPCM_Default);
    AddConstant('IPCM_MaximumCompression',IPCM_MaximumCompression);
    AddConstant('IPCM_NoCompression',IPCM_NoCompression);
    AddConstant('IPT_Ball',IPT_Ball);
    AddConstant('IPT_Rectangle',IPT_Rectangle);
    AddConstant('IPT_Last',IPT_Last);
    AddConstant('IRO_Black',IRO_Black);
    AddConstant('IRO_NotMergePen',IRO_NotMergePen);
    AddConstant('IRO_MaskNotPen',IRO_MaskNotPen);
    AddConstant('IRO_NotCopyPen',IRO_NotCopyPen);
    AddConstant('IRO_MaskPenNot',IRO_MaskPenNot);
    AddConstant('IRO_Not',IRO_Not);
    AddConstant('IRO_XOrPen',IRO_XOrPen);
    AddConstant('IRO_NotMaskPen',IRO_NotMaskPen);
    AddConstant('IRO_MaskPen',IRO_MaskPen);
    AddConstant('IRO_NotXOrPen',IRO_NotXOrPen);
    AddConstant('IRO_NoOperation',IRO_NoOperation);
    AddConstant('IRO_MergeNotPen',IRO_MergeNotPen);
    AddConstant('IRO_CopyPen',IRO_CopyPen);
    AddConstant('IRO_MergePenNot',IRO_MergePenNot);
    AddConstant('IRO_MergePen',IRO_MergePen);
    AddConstant('IRO_White',IRO_White);
    AddConstant('IRO_Last',IRO_Last);
    AddConstant('IMP_Default',IMP_Default);
    AddConstant('IMP_Arrow',IMP_Arrow);
    AddConstant('IMP_Crosshair',IMP_Crosshair);
    AddConstant('IMP_Ibeam',IMP_Ibeam);
    AddConstant('IMP_SizeNESW',IMP_SizeNESW);
    AddConstant('IMP_SizeNS',IMP_SizeNS);
    AddConstant('IMP_SizeNWSE',IMP_SizeNWSE);
    AddConstant('IMP_SizeWE',IMP_SizeWE);
    AddConstant('IMP_UpArrow',IMP_UpArrow);
    AddConstant('IMP_Hourglass',IMP_Hourglass);
    AddConstant('IMP_NoDrop',IMP_NoDrop);
    AddConstant('IMP_ArrowHourglass',IMP_ArrowHourglass);
    AddConstant('IMP_ArrowQuestion',IMP_ArrowQuestion);
    AddConstant('IMP_SizeAll',IMP_SizeAll);
    AddConstant('IMP_Hand',IMP_Hand);
    AddConstant('IMP_Custom',IMP_Custom);
    AddConstant('ICB_Copy',ICB_Copy);
    AddConstant('ICB_Cut',ICB_Cut);
    AddConstant('ICB_ExtractOnly',ICB_ExtractOnly);
    AddConstant('ICB_DelayedCopy',ICB_DelayedCopy);
    AddConstant('ICB_Default',ICB_Default);
    AddConstant('ICB_Last',ICB_Last);
    AddConstant('ICF_None',ICF_None);
    AddConstant('ICF_InkSerializedFormat',ICF_InkSerializedFormat);
    AddConstant('ICF_SketchInk',ICF_SketchInk);
    AddConstant('ICF_TextInk',ICF_TextInk);
    AddConstant('ICF_EnhancedMetafile',ICF_EnhancedMetafile);
    AddConstant('ICF_Metafile',ICF_Metafile);
    AddConstant('ICF_Bitmap',ICF_Bitmap);
    AddConstant('ICF_PasteMask',ICF_PasteMask);
    AddConstant('ICF_CopyMask',ICF_CopyMask);
    AddConstant('ICF_Default',ICF_Default);
    AddConstant('ICF_Last',ICF_Last);
    AddConstant('SHR_None',SHR_None);
    AddConstant('SHR_NW',SHR_NW);
    AddConstant('SHR_SE',SHR_SE);
    AddConstant('SHR_NE',SHR_NE);
    AddConstant('SHR_SW',SHR_SW);
    AddConstant('SHR_E',SHR_E);
    AddConstant('SHR_W',SHR_W);
    AddConstant('SHR_N',SHR_N);
    AddConstant('SHR_S',SHR_S);
    AddConstant('SHR_Selection',SHR_Selection);
    AddConstant('IRS_NoError',IRS_NoError);
    AddConstant('IRS_Interrupted',IRS_Interrupted);
    AddConstant('IRS_ProcessFailed',IRS_ProcessFailed);
    AddConstant('IRS_InkAddedFailed',IRS_InkAddedFailed);
    AddConstant('IRS_SetAutoCompletionModeFailed',IRS_SetAutoCompletionModeFailed);
    AddConstant('IRS_SetStrokesFailed',IRS_SetStrokesFailed);
    AddConstant('IRS_SetGuideFailed',IRS_SetGuideFailed);
    AddConstant('IRS_SetFlagsFailed',IRS_SetFlagsFailed);
    AddConstant('IRS_SetFactoidFailed',IRS_SetFactoidFailed);
    AddConstant('IRS_SetPrefixSuffixFailed',IRS_SetPrefixSuffixFailed);
    AddConstant('IRS_SetWordListFailed',IRS_SetWordListFailed);
    AddConstant('DISPID_IRTop',DISPID_IRTop);
    AddConstant('DISPID_IRLeft',DISPID_IRLeft);
    AddConstant('DISPID_IRBottom',DISPID_IRBottom);
    AddConstant('DISPID_IRRight',DISPID_IRRight);
    AddConstant('DISPID_IRGetRectangle',DISPID_IRGetRectangle);
    AddConstant('DISPID_IRSetRectangle',DISPID_IRSetRectangle);
    AddConstant('DISPID_IRData',DISPID_IRData);
    AddConstant('DISPID_IEPGuid',DISPID_IEPGuid);
    AddConstant('DISPID_IEPData',DISPID_IEPData);
    AddConstant('DISPID_IEPs_NewEnum',DISPID_IEPs_NewEnum);
    AddConstant('DISPID_IEPsItem',DISPID_IEPsItem);
    AddConstant('DISPID_IEPsCount',DISPID_IEPsCount);
    AddConstant('DISPID_IEPsAdd',DISPID_IEPsAdd);
    AddConstant('DISPID_IEPsRemove',DISPID_IEPsRemove);
    AddConstant('DISPID_IEPsClear',DISPID_IEPsClear);
    AddConstant('DISPID_IEPsDoesPropertyExist',DISPID_IEPsDoesPropertyExist);
    AddConstant('DISPID_DAHeight',DISPID_DAHeight);
    AddConstant('DISPID_DAColor',DISPID_DAColor);
    AddConstant('DISPID_DAWidth',DISPID_DAWidth);
    AddConstant('DISPID_DAFitToCurve',DISPID_DAFitToCurve);
    AddConstant('DISPID_DAIgnorePressure',DISPID_DAIgnorePressure);
    AddConstant('DISPID_DAAntiAliased',DISPID_DAAntiAliased);
    AddConstant('DISPID_DATransparency',DISPID_DATransparency);
    AddConstant('DISPID_DARasterOperation',DISPID_DARasterOperation);
    AddConstant('DISPID_DAPenTip',DISPID_DAPenTip);
    AddConstant('DISPID_DAClone',DISPID_DAClone);
    AddConstant('DISPID_DAExtendedProperties',DISPID_DAExtendedProperties);
    AddConstant('DISPID_ITReset',DISPID_ITReset);
    AddConstant('DISPID_ITTranslate',DISPID_ITTranslate);
    AddConstant('DISPID_ITRotate',DISPID_ITRotate);
    AddConstant('DISPID_ITReflect',DISPID_ITReflect);
    AddConstant('DISPID_ITShear',DISPID_ITShear);
    AddConstant('DISPID_ITScale',DISPID_ITScale);
    AddConstant('DISPID_ITeM11',DISPID_ITeM11);
    AddConstant('DISPID_ITeM12',DISPID_ITeM12);
    AddConstant('DISPID_ITeM21',DISPID_ITeM21);
    AddConstant('DISPID_ITeM22',DISPID_ITeM22);
    AddConstant('DISPID_ITeDx',DISPID_ITeDx);
    AddConstant('DISPID_ITeDy',DISPID_ITeDy);
    AddConstant('DISPID_ITGetTransform',DISPID_ITGetTransform);
    AddConstant('DISPID_ITSetTransform',DISPID_ITSetTransform);
    AddConstant('DISPID_ITData',DISPID_ITData);
    AddConstant('IAG_AllGestures',IAG_AllGestures);
    AddConstant('IAG_NoGesture',IAG_NoGesture);
    AddConstant('IAG_Scratchout',IAG_Scratchout);
    AddConstant('IAG_Triangle',IAG_Triangle);
    AddConstant('IAG_Square',IAG_Square);
    AddConstant('IAG_Star',IAG_Star);
    AddConstant('IAG_Check',IAG_Check);
    AddConstant('IAG_Curlicue',IAG_Curlicue);
    AddConstant('IAG_DoubleCurlicue',IAG_DoubleCurlicue);
    AddConstant('IAG_Circle',IAG_Circle);
    AddConstant('IAG_DoubleCircle',IAG_DoubleCircle);
    AddConstant('IAG_SemiCircleLeft',IAG_SemiCircleLeft);
    AddConstant('IAG_SemiCircleRight',IAG_SemiCircleRight);
    AddConstant('IAG_ChevronUp',IAG_ChevronUp);
    AddConstant('IAG_ChevronDown',IAG_ChevronDown);
    AddConstant('IAG_ChevronLeft',IAG_ChevronLeft);
    AddConstant('IAG_ChevronRight',IAG_ChevronRight);
    AddConstant('IAG_ArrowUp',IAG_ArrowUp);
    AddConstant('IAG_ArrowDown',IAG_ArrowDown);
    AddConstant('IAG_ArrowLeft',IAG_ArrowLeft);
    AddConstant('IAG_ArrowRight',IAG_ArrowRight);
    AddConstant('IAG_Up',IAG_Up);
    AddConstant('IAG_Down',IAG_Down);
    AddConstant('IAG_Left',IAG_Left);
    AddConstant('IAG_Right',IAG_Right);
    AddConstant('IAG_UpDown',IAG_UpDown);
    AddConstant('IAG_DownUp',IAG_DownUp);
    AddConstant('IAG_LeftRight',IAG_LeftRight);
    AddConstant('IAG_RightLeft',IAG_RightLeft);
    AddConstant('IAG_UpLeftLong',IAG_UpLeftLong);
    AddConstant('IAG_UpRightLong',IAG_UpRightLong);
    AddConstant('IAG_DownLeftLong',IAG_DownLeftLong);
    AddConstant('IAG_DownRightLong',IAG_DownRightLong);
    AddConstant('IAG_UpLeft',IAG_UpLeft);
    AddConstant('IAG_UpRight',IAG_UpRight);
    AddConstant('IAG_DownLeft',IAG_DownLeft);
    AddConstant('IAG_DownRight',IAG_DownRight);
    AddConstant('IAG_LeftUp',IAG_LeftUp);
    AddConstant('IAG_LeftDown',IAG_LeftDown);
    AddConstant('IAG_RightUp',IAG_RightUp);
    AddConstant('IAG_RightDown',IAG_RightDown);
    AddConstant('IAG_Exclamation',IAG_Exclamation);
    AddConstant('IAG_Tap',IAG_Tap);
    AddConstant('IAG_DoubleTap',IAG_DoubleTap);
    AddConstant('ISG_Tap',ISG_Tap);
    AddConstant('ISG_DoubleTap',ISG_DoubleTap);
    AddConstant('ISG_RightTap',ISG_RightTap);
    AddConstant('ISG_Drag',ISG_Drag);
    AddConstant('ISG_RightDrag',ISG_RightDrag);
    AddConstant('ISG_HoldEnter',ISG_HoldEnter);
    AddConstant('ISG_HoldLeave',ISG_HoldLeave);
    AddConstant('ISG_HoverEnter',ISG_HoverEnter);
    AddConstant('ISG_HoverLeave',ISG_HoverLeave);
    AddConstant('ISG_Flick',ISG_Flick);
    AddConstant('ISG_First',ISG_First);
    AddConstant('ISG_Last',ISG_Last);
    AddConstant('IRC_Strong',IRC_Strong);
    AddConstant('IRC_Intermediate',IRC_Intermediate);
    AddConstant('IRC_Poor',IRC_Poor);
    AddConstant('DISPID_IGId',DISPID_IGId);
    AddConstant('DISPID_IGGetHotPoint',DISPID_IGGetHotPoint);
    AddConstant('DISPID_IGConfidence',DISPID_IGConfidence);
    AddConstant('DISPID_ICsrName',DISPID_ICsrName);
    AddConstant('DISPID_ICsrId',DISPID_ICsrId);
    AddConstant('DISPID_ICsrDrawingAttributes',DISPID_ICsrDrawingAttributes);
    AddConstant('DISPID_ICsrButtons',DISPID_ICsrButtons);
    AddConstant('DISPID_ICsrInverted',DISPID_ICsrInverted);
    AddConstant('DISPID_ICsrTablet',DISPID_ICsrTablet);
    AddConstant('DISPID_ICs_NewEnum',DISPID_ICs_NewEnum);
    AddConstant('DISPID_ICsItem',DISPID_ICsItem);
    AddConstant('DISPID_ICsCount',DISPID_ICsCount);
    AddConstant('ICBS_Unavailable',ICBS_Unavailable);
    AddConstant('ICBS_Up',ICBS_Up);
    AddConstant('ICBS_Down',ICBS_Down);
    AddConstant('ICBS_Last',ICBS_Last);
    AddConstant('DISPID_ICBName',DISPID_ICBName);
    AddConstant('DISPID_ICBId',DISPID_ICBId);
    AddConstant('DISPID_ICBState',DISPID_ICBState);
    AddConstant('DISPID_ICBs_NewEnum',DISPID_ICBs_NewEnum);
    AddConstant('DISPID_ICBsItem',DISPID_ICBsItem);
    AddConstant('DISPID_ICBsCount',DISPID_ICBsCount);
    AddConstant('THWC_Integrated',THWC_Integrated);
    AddConstant('THWC_CursorMustTouch',THWC_CursorMustTouch);
    AddConstant('THWC_HardProximity',THWC_HardProximity);
    AddConstant('THWC_CursorsHavePhysicalIds',THWC_CursorsHavePhysicalIds);
    AddConstant('TPMU_Default',TPMU_Default);
    AddConstant('TPMU_Inches',TPMU_Inches);
    AddConstant('TPMU_Centimeters',TPMU_Centimeters);
    AddConstant('TPMU_Degrees',TPMU_Degrees);
    AddConstant('TPMU_Radians',TPMU_Radians);
    AddConstant('TPMU_Seconds',TPMU_Seconds);
    AddConstant('TPMU_Pounds',TPMU_Pounds);
    AddConstant('TPMU_Grams',TPMU_Grams);
    AddConstant('DISPID_ITName',DISPID_ITName);
    AddConstant('DISPID_ITPlugAndPlayId',DISPID_ITPlugAndPlayId);
    AddConstant('DISPID_ITPropertyMetrics',DISPID_ITPropertyMetrics);
    AddConstant('DISPID_ITIsPacketPropertySupported',DISPID_ITIsPacketPropertySupported);
    AddConstant('DISPID_ITMaximumInputRectangle',DISPID_ITMaximumInputRectangle);
    AddConstant('DISPID_ITHardwareCapabilities',DISPID_ITHardwareCapabilities);
    AddConstant('TDK_Mouse',TDK_Mouse);
    AddConstant('TDK_Pen',TDK_Pen);
    AddConstant('TDK_Touch',TDK_Touch);
    AddConstant('DISPID_IT2DeviceKind',DISPID_IT2DeviceKind);
    AddConstant('DISPID_IT3IsMultiTouch',DISPID_IT3IsMultiTouch);
    AddConstant('DISPID_IT3MaximumCursors',DISPID_IT3MaximumCursors);
    AddConstant('DISPID_ITs_NewEnum',DISPID_ITs_NewEnum);
    AddConstant('DISPID_ITsItem',DISPID_ITsItem);
    AddConstant('DISPID_ITsDefaultTablet',DISPID_ITsDefaultTablet);
    AddConstant('DISPID_ITsCount',DISPID_ITsCount);
    AddConstant('DISPID_ITsIsPacketPropertySupported',DISPID_ITsIsPacketPropertySupported);
    AddConstant('DISPID_ISDInkIndex',DISPID_ISDInkIndex);
    AddConstant('DISPID_ISDID',DISPID_ISDID);
    AddConstant('DISPID_ISDGetBoundingBox',DISPID_ISDGetBoundingBox);
    AddConstant('DISPID_ISDDrawingAttributes',DISPID_ISDDrawingAttributes);
    AddConstant('DISPID_ISDFindIntersections',DISPID_ISDFindIntersections);
    AddConstant('DISPID_ISDGetRectangleIntersections',DISPID_ISDGetRectangleIntersections);
    AddConstant('DISPID_ISDClip',DISPID_ISDClip);
    AddConstant('DISPID_ISDHitTestCircle',DISPID_ISDHitTestCircle);
    AddConstant('DISPID_ISDNearestPoint',DISPID_ISDNearestPoint);
    AddConstant('DISPID_ISDSplit',DISPID_ISDSplit);
    AddConstant('DISPID_ISDExtendedProperties',DISPID_ISDExtendedProperties);
    AddConstant('DISPID_ISDInk',DISPID_ISDInk);
    AddConstant('DISPID_ISDBezierPoints',DISPID_ISDBezierPoints);
    AddConstant('DISPID_ISDPolylineCusps',DISPID_ISDPolylineCusps);
    AddConstant('DISPID_ISDBezierCusps',DISPID_ISDBezierCusps);
    AddConstant('DISPID_ISDSelfIntersections',DISPID_ISDSelfIntersections);
    AddConstant('DISPID_ISDPacketCount',DISPID_ISDPacketCount);
    AddConstant('DISPID_ISDPacketSize',DISPID_ISDPacketSize);
    AddConstant('DISPID_ISDPacketDescription',DISPID_ISDPacketDescription);
    AddConstant('DISPID_ISDDeleted',DISPID_ISDDeleted);
    AddConstant('DISPID_ISDGetPacketDescriptionPropertyMetrics',DISPID_ISDGetPacketDescriptionPropertyMetrics);
    AddConstant('DISPID_ISDGetPoints',DISPID_ISDGetPoints);
    AddConstant('DISPID_ISDSetPoints',DISPID_ISDSetPoints);
    AddConstant('DISPID_ISDGetPacketData',DISPID_ISDGetPacketData);
    AddConstant('DISPID_ISDGetPacketValuesByProperty',DISPID_ISDGetPacketValuesByProperty);
    AddConstant('DISPID_ISDSetPacketValuesByProperty',DISPID_ISDSetPacketValuesByProperty);
    AddConstant('DISPID_ISDGetFlattenedBezierPoints',DISPID_ISDGetFlattenedBezierPoints);
    AddConstant('DISPID_ISDScaleToRectangle',DISPID_ISDScaleToRectangle);
    AddConstant('DISPID_ISDTransform',DISPID_ISDTransform);
    AddConstant('DISPID_ISDMove',DISPID_ISDMove);
    AddConstant('DISPID_ISDRotate',DISPID_ISDRotate);
    AddConstant('DISPID_ISDShear',DISPID_ISDShear);
    AddConstant('DISPID_ISDScale',DISPID_ISDScale);
    AddConstant('DISPID_ISs_NewEnum',DISPID_ISs_NewEnum);
    AddConstant('DISPID_ISsItem',DISPID_ISsItem);
    AddConstant('DISPID_ISsCount',DISPID_ISsCount);
    AddConstant('DISPID_ISsValid',DISPID_ISsValid);
    AddConstant('DISPID_ISsInk',DISPID_ISsInk);
    AddConstant('DISPID_ISsAdd',DISPID_ISsAdd);
    AddConstant('DISPID_ISsAddStrokes',DISPID_ISsAddStrokes);
    AddConstant('DISPID_ISsRemove',DISPID_ISsRemove);
    AddConstant('DISPID_ISsRemoveStrokes',DISPID_ISsRemoveStrokes);
    AddConstant('DISPID_ISsToString',DISPID_ISsToString);
    AddConstant('DISPID_ISsModifyDrawingAttributes',DISPID_ISsModifyDrawingAttributes);
    AddConstant('DISPID_ISsGetBoundingBox',DISPID_ISsGetBoundingBox);
    AddConstant('DISPID_ISsScaleToRectangle',DISPID_ISsScaleToRectangle);
    AddConstant('DISPID_ISsTransform',DISPID_ISsTransform);
    AddConstant('DISPID_ISsMove',DISPID_ISsMove);
    AddConstant('DISPID_ISsRotate',DISPID_ISsRotate);
    AddConstant('DISPID_ISsShear',DISPID_ISsShear);
    AddConstant('DISPID_ISsScale',DISPID_ISsScale);
    AddConstant('DISPID_ISsClip',DISPID_ISsClip);
    AddConstant('DISPID_ISsRecognitionResult',DISPID_ISsRecognitionResult);
    AddConstant('DISPID_ISsRemoveRecognitionResult',DISPID_ISsRemoveRecognitionResult);
    AddConstant('DISPID_ICSs_NewEnum',DISPID_ICSs_NewEnum);
    AddConstant('DISPID_ICSsItem',DISPID_ICSsItem);
    AddConstant('DISPID_ICSsCount',DISPID_ICSsCount);
    AddConstant('DISPID_ICSsAdd',DISPID_ICSsAdd);
    AddConstant('DISPID_ICSsRemove',DISPID_ICSsRemove);
    AddConstant('DISPID_ICSsClear',DISPID_ICSsClear);
    AddConstant('DISPID_SEStrokesAdded',DISPID_SEStrokesAdded);
    AddConstant('DISPID_SEStrokesRemoved',DISPID_SEStrokesRemoved);
    AddConstant('DISPID_IStrokes',DISPID_IStrokes);
    AddConstant('DISPID_IExtendedProperties',DISPID_IExtendedProperties);
    AddConstant('DISPID_IGetBoundingBox',DISPID_IGetBoundingBox);
    AddConstant('DISPID_IDeleteStrokes',DISPID_IDeleteStrokes);
    AddConstant('DISPID_IDeleteStroke',DISPID_IDeleteStroke);
    AddConstant('DISPID_IExtractStrokes',DISPID_IExtractStrokes);
    AddConstant('DISPID_IExtractWithRectangle',DISPID_IExtractWithRectangle);
    AddConstant('DISPID_IDirty',DISPID_IDirty);
    AddConstant('DISPID_ICustomStrokes',DISPID_ICustomStrokes);
    AddConstant('DISPID_IClone',DISPID_IClone);
    AddConstant('DISPID_IHitTestCircle',DISPID_IHitTestCircle);
    AddConstant('DISPID_IHitTestWithRectangle',DISPID_IHitTestWithRectangle);
    AddConstant('DISPID_IHitTestWithLasso',DISPID_IHitTestWithLasso);
    AddConstant('DISPID_INearestPoint',DISPID_INearestPoint);
    AddConstant('DISPID_ICreateStrokes',DISPID_ICreateStrokes);
    AddConstant('DISPID_ICreateStroke',DISPID_ICreateStroke);
    AddConstant('DISPID_IAddStrokesAtRectangle',DISPID_IAddStrokesAtRectangle);
    AddConstant('DISPID_IClip',DISPID_IClip);
    AddConstant('DISPID_ISave',DISPID_ISave);
    AddConstant('DISPID_ILoad',DISPID_ILoad);
    AddConstant('DISPID_ICreateStrokeFromPoints',DISPID_ICreateStrokeFromPoints);
    AddConstant('DISPID_IClipboardCopyWithRectangle',DISPID_IClipboardCopyWithRectangle);
    AddConstant('DISPID_IClipboardCopy',DISPID_IClipboardCopy);
    AddConstant('DISPID_ICanPaste',DISPID_ICanPaste);
    AddConstant('DISPID_IClipboardPaste',DISPID_IClipboardPaste);
    AddConstant('DISPID_IEInkAdded',DISPID_IEInkAdded);
    AddConstant('DISPID_IEInkDeleted',DISPID_IEInkDeleted);
    AddConstant('DISPID_IRGetViewTransform',DISPID_IRGetViewTransform);
    AddConstant('DISPID_IRSetViewTransform',DISPID_IRSetViewTransform);
    AddConstant('DISPID_IRGetObjectTransform',DISPID_IRGetObjectTransform);
    AddConstant('DISPID_IRSetObjectTransform',DISPID_IRSetObjectTransform);
    AddConstant('DISPID_IRDraw',DISPID_IRDraw);
    AddConstant('DISPID_IRDrawStroke',DISPID_IRDrawStroke);
    AddConstant('DISPID_IRPixelToInkSpace',DISPID_IRPixelToInkSpace);
    AddConstant('DISPID_IRInkSpaceToPixel',DISPID_IRInkSpaceToPixel);
    AddConstant('DISPID_IRPixelToInkSpaceFromPoints',DISPID_IRPixelToInkSpaceFromPoints);
    AddConstant('DISPID_IRInkSpaceToPixelFromPoints',DISPID_IRInkSpaceToPixelFromPoints);
    AddConstant('DISPID_IRMeasure',DISPID_IRMeasure);
    AddConstant('DISPID_IRMeasureStroke',DISPID_IRMeasureStroke);
    AddConstant('DISPID_IRMove',DISPID_IRMove);
    AddConstant('DISPID_IRRotate',DISPID_IRRotate);
    AddConstant('DISPID_IRScale',DISPID_IRScale);
    AddConstant('ICEI_DefaultEvents',ICEI_DefaultEvents);
    AddConstant('ICEI_CursorDown',ICEI_CursorDown);
    AddConstant('ICEI_Stroke',ICEI_Stroke);
    AddConstant('ICEI_NewPackets',ICEI_NewPackets);
    AddConstant('ICEI_NewInAirPackets',ICEI_NewInAirPackets);
    AddConstant('ICEI_CursorButtonDown',ICEI_CursorButtonDown);
    AddConstant('ICEI_CursorButtonUp',ICEI_CursorButtonUp);
    AddConstant('ICEI_CursorInRange',ICEI_CursorInRange);
    AddConstant('ICEI_CursorOutOfRange',ICEI_CursorOutOfRange);
    AddConstant('ICEI_SystemGesture',ICEI_SystemGesture);
    AddConstant('ICEI_TabletAdded',ICEI_TabletAdded);
    AddConstant('ICEI_TabletRemoved',ICEI_TabletRemoved);
    AddConstant('ICEI_MouseDown',ICEI_MouseDown);
    AddConstant('ICEI_MouseMove',ICEI_MouseMove);
    AddConstant('ICEI_MouseUp',ICEI_MouseUp);
    AddConstant('ICEI_MouseWheel',ICEI_MouseWheel);
    AddConstant('ICEI_DblClick',ICEI_DblClick);
    AddConstant('ICEI_AllEvents',ICEI_AllEvents);
    AddConstant('IMF_Left',IMF_Left);
    AddConstant('IMF_Right',IMF_Right);
    AddConstant('IMF_Middle',IMF_Middle);
    AddConstant('IKM_Shift',IKM_Shift);
    AddConstant('IKM_Control',IKM_Control);
    AddConstant('IKM_Alt',IKM_Alt);
    AddConstant('DISPID_ICEStroke',DISPID_ICEStroke);
    AddConstant('DISPID_ICECursorDown',DISPID_ICECursorDown);
    AddConstant('DISPID_ICENewPackets',DISPID_ICENewPackets);
    AddConstant('DISPID_ICENewInAirPackets',DISPID_ICENewInAirPackets);
    AddConstant('DISPID_ICECursorButtonDown',DISPID_ICECursorButtonDown);
    AddConstant('DISPID_ICECursorButtonUp',DISPID_ICECursorButtonUp);
    AddConstant('DISPID_ICECursorInRange',DISPID_ICECursorInRange);
    AddConstant('DISPID_ICECursorOutOfRange',DISPID_ICECursorOutOfRange);
    AddConstant('DISPID_ICESystemGesture',DISPID_ICESystemGesture);
    AddConstant('DISPID_ICEGesture',DISPID_ICEGesture);
    AddConstant('DISPID_ICETabletAdded',DISPID_ICETabletAdded);
    AddConstant('DISPID_ICETabletRemoved',DISPID_ICETabletRemoved);
    AddConstant('DISPID_IOEPainting',DISPID_IOEPainting);
    AddConstant('DISPID_IOEPainted',DISPID_IOEPainted);
    AddConstant('DISPID_IOESelectionChanging',DISPID_IOESelectionChanging);
    AddConstant('DISPID_IOESelectionChanged',DISPID_IOESelectionChanged);
    AddConstant('DISPID_IOESelectionMoving',DISPID_IOESelectionMoving);
    AddConstant('DISPID_IOESelectionMoved',DISPID_IOESelectionMoved);
    AddConstant('DISPID_IOESelectionResizing',DISPID_IOESelectionResizing);
    AddConstant('DISPID_IOESelectionResized',DISPID_IOESelectionResized);
    AddConstant('DISPID_IOEStrokesDeleting',DISPID_IOEStrokesDeleting);
    AddConstant('DISPID_IOEStrokesDeleted',DISPID_IOEStrokesDeleted);
    AddConstant('DISPID_IPEChangeUICues',DISPID_IPEChangeUICues);
    AddConstant('DISPID_IPEClick',DISPID_IPEClick);
    AddConstant('DISPID_IPEDblClick',DISPID_IPEDblClick);
    AddConstant('DISPID_IPEInvalidated',DISPID_IPEInvalidated);
    AddConstant('DISPID_IPEMouseDown',DISPID_IPEMouseDown);
    AddConstant('DISPID_IPEMouseEnter',DISPID_IPEMouseEnter);
    AddConstant('DISPID_IPEMouseHover',DISPID_IPEMouseHover);
    AddConstant('DISPID_IPEMouseLeave',DISPID_IPEMouseLeave);
    AddConstant('DISPID_IPEMouseMove',DISPID_IPEMouseMove);
    AddConstant('DISPID_IPEMouseUp',DISPID_IPEMouseUp);
    AddConstant('DISPID_IPEMouseWheel',DISPID_IPEMouseWheel);
    AddConstant('DISPID_IPESizeModeChanged',DISPID_IPESizeModeChanged);
    AddConstant('DISPID_IPEStyleChanged',DISPID_IPEStyleChanged);
    AddConstant('DISPID_IPESystemColorsChanged',DISPID_IPESystemColorsChanged);
    AddConstant('DISPID_IPEKeyDown',DISPID_IPEKeyDown);
    AddConstant('DISPID_IPEKeyPress',DISPID_IPEKeyPress);
    AddConstant('DISPID_IPEKeyUp',DISPID_IPEKeyUp);
    AddConstant('DISPID_IPEResize',DISPID_IPEResize);
    AddConstant('DISPID_IPESizeChanged',DISPID_IPESizeChanged);
    AddConstant('IOEM_Ink',IOEM_Ink);
    AddConstant('IOEM_Delete',IOEM_Delete);
    AddConstant('IOEM_Select',IOEM_Select);
    AddConstant('IOEM_Last',IOEM_Last);
    AddConstant('IOAM_Behind',IOAM_Behind);
    AddConstant('IOAM_InFront',IOAM_InFront);
    AddConstant('IOAM_Last',IOAM_Last);
    AddConstant('IPSM_AutoSize',IPSM_AutoSize);
    AddConstant('IPSM_CenterImage',IPSM_CenterImage);
    AddConstant('IPSM_Normal',IPSM_Normal);
    AddConstant('IPSM_StretchImage',IPSM_StretchImage);
    AddConstant('IPSM_Last',IPSM_Last);
    AddConstant('IOERM_StrokeErase',IOERM_StrokeErase);
    AddConstant('IOERM_PointErase',IOERM_PointErase);
    AddConstant('IOERM_Last',IOERM_Last);
    AddConstant('ICM_InkOnly',ICM_InkOnly);
    AddConstant('ICM_GestureOnly',ICM_GestureOnly);
    AddConstant('ICM_InkAndGesture',ICM_InkAndGesture);
    AddConstant('ICM_Last',ICM_Last);
    AddConstant('DISPID_ICEnabled',DISPID_ICEnabled);
    AddConstant('DISPID_ICHwnd',DISPID_ICHwnd);
    AddConstant('DISPID_ICPaint',DISPID_ICPaint);
    AddConstant('DISPID_ICText',DISPID_ICText);
    AddConstant('DISPID_ICDefaultDrawingAttributes',DISPID_ICDefaultDrawingAttributes);
    AddConstant('DISPID_ICRenderer',DISPID_ICRenderer);
    AddConstant('DISPID_ICInk',DISPID_ICInk);
    AddConstant('DISPID_ICAutoRedraw',DISPID_ICAutoRedraw);
    AddConstant('DISPID_ICCollectingInk',DISPID_ICCollectingInk);
    AddConstant('DISPID_ICSetEventInterest',DISPID_ICSetEventInterest);
    AddConstant('DISPID_ICGetEventInterest',DISPID_ICGetEventInterest);
    AddConstant('DISPID_IOEditingMode',DISPID_IOEditingMode);
    AddConstant('DISPID_IOSelection',DISPID_IOSelection);
    AddConstant('DISPID_IOAttachMode',DISPID_IOAttachMode);
    AddConstant('DISPID_IOHitTestSelection',DISPID_IOHitTestSelection);
    AddConstant('DISPID_IODraw',DISPID_IODraw);
    AddConstant('DISPID_IPPicture',DISPID_IPPicture);
    AddConstant('DISPID_IPSizeMode',DISPID_IPSizeMode);
    AddConstant('DISPID_IPBackColor',DISPID_IPBackColor);
    AddConstant('DISPID_ICCursors',DISPID_ICCursors);
    AddConstant('DISPID_ICMarginX',DISPID_ICMarginX);
    AddConstant('DISPID_ICMarginY',DISPID_ICMarginY);
    AddConstant('DISPID_ICSetWindowInputRectangle',DISPID_ICSetWindowInputRectangle);
    AddConstant('DISPID_ICGetWindowInputRectangle',DISPID_ICGetWindowInputRectangle);
    AddConstant('DISPID_ICTablet',DISPID_ICTablet);
    AddConstant('DISPID_ICSetAllTabletsMode',DISPID_ICSetAllTabletsMode);
    AddConstant('DISPID_ICSetSingleTabletIntegratedMode',DISPID_ICSetSingleTabletIntegratedMode);
    AddConstant('DISPID_ICCollectionMode',DISPID_ICCollectionMode);
    AddConstant('DISPID_ICSetGestureStatus',DISPID_ICSetGestureStatus);
    AddConstant('DISPID_ICGetGestureStatus',DISPID_ICGetGestureStatus);
    AddConstant('DISPID_ICDynamicRendering',DISPID_ICDynamicRendering);
    AddConstant('DISPID_ICDesiredPacketDescription',DISPID_ICDesiredPacketDescription);
    AddConstant('DISPID_IOEraserMode',DISPID_IOEraserMode);
    AddConstant('DISPID_IOEraserWidth',DISPID_IOEraserWidth);
    AddConstant('DISPID_ICMouseIcon',DISPID_ICMouseIcon);
    AddConstant('DISPID_ICMousePointer',DISPID_ICMousePointer);
    AddConstant('DISPID_IPInkEnabled',DISPID_IPInkEnabled);
    AddConstant('DISPID_ICSupportHighContrastInk',DISPID_ICSupportHighContrastInk);
    AddConstant('DISPID_IOSupportHighContrastSelectionUI',DISPID_IOSupportHighContrastSelectionUI);
    AddConstant('DISPID_RecoClsid',DISPID_RecoClsid);
    AddConstant('DISPID_RecoName',DISPID_RecoName);
    AddConstant('DISPID_RecoVendor',DISPID_RecoVendor);
    AddConstant('DISPID_RecoCapabilities',DISPID_RecoCapabilities);
    AddConstant('DISPID_RecoLanguageID',DISPID_RecoLanguageID);
    AddConstant('DISPID_RecoPreferredPacketDescription',DISPID_RecoPreferredPacketDescription);
    AddConstant('DISPID_RecoCreateRecognizerContext',DISPID_RecoCreateRecognizerContext);
    AddConstant('DISPID_RecoSupportedProperties',DISPID_RecoSupportedProperties);
    AddConstant('IRC_DontCare',IRC_DontCare);
    AddConstant('IRC_Object',IRC_Object);
    AddConstant('IRC_FreeInput',IRC_FreeInput);
    AddConstant('IRC_LinedInput',IRC_LinedInput);
    AddConstant('IRC_BoxedInput',IRC_BoxedInput);
    AddConstant('IRC_CharacterAutoCompletionInput',IRC_CharacterAutoCompletionInput);
    AddConstant('IRC_RightAndDown',IRC_RightAndDown);
    AddConstant('IRC_LeftAndDown',IRC_LeftAndDown);
    AddConstant('IRC_DownAndLeft',IRC_DownAndLeft);
    AddConstant('IRC_DownAndRight',IRC_DownAndRight);
    AddConstant('IRC_ArbitraryAngle',IRC_ArbitraryAngle);
    AddConstant('IRC_Lattice',IRC_Lattice);
    AddConstant('IRC_AdviseInkChange',IRC_AdviseInkChange);
    AddConstant('IRC_StrokeReorder',IRC_StrokeReorder);
    AddConstant('IRC_Personalizable',IRC_Personalizable);
    AddConstant('DISPID_RecoId',DISPID_RecoId);
    AddConstant('DISPID_RecoUnicodeRanges',DISPID_RecoUnicodeRanges);
    AddConstant('DISPID_IRecos_NewEnum',DISPID_IRecos_NewEnum);
    AddConstant('DISPID_IRecosItem',DISPID_IRecosItem);
    AddConstant('DISPID_IRecosCount',DISPID_IRecosCount);
    AddConstant('DISPID_IRecosGetDefaultRecognizer',DISPID_IRecosGetDefaultRecognizer);
    AddConstant('IRCACM_Full',IRCACM_Full);
    AddConstant('IRCACM_Prefix',IRCACM_Prefix);
    AddConstant('IRCACM_Random',IRCACM_Random);
    AddConstant('IRM_None',IRM_None);
    AddConstant('IRM_WordModeOnly',IRM_WordModeOnly);
    AddConstant('IRM_Coerce',IRM_Coerce);
    AddConstant('IRM_TopInkBreaksOnly',IRM_TopInkBreaksOnly);
    AddConstant('IRM_PrefixOk',IRM_PrefixOk);
    AddConstant('IRM_LineMode',IRM_LineMode);
    AddConstant('IRM_DisablePersonalization',IRM_DisablePersonalization);
    AddConstant('IRM_AutoSpace',IRM_AutoSpace);
    AddConstant('IRM_Max',IRM_Max);
    AddConstant('DISPID_IRERecognitionWithAlternates',DISPID_IRERecognitionWithAlternates);
    AddConstant('DISPID_IRERecognition',DISPID_IRERecognition);
    AddConstant('DISPID_IRecoCtx_Strokes',DISPID_IRecoCtx_Strokes);
    AddConstant('DISPID_IRecoCtx_CharacterAutoCompletionMode',DISPID_IRecoCtx_CharacterAutoCompletionMode);
    AddConstant('DISPID_IRecoCtx_Factoid',DISPID_IRecoCtx_Factoid);
    AddConstant('DISPID_IRecoCtx_WordList',DISPID_IRecoCtx_WordList);
    AddConstant('DISPID_IRecoCtx_Recognizer',DISPID_IRecoCtx_Recognizer);
    AddConstant('DISPID_IRecoCtx_Guide',DISPID_IRecoCtx_Guide);
    AddConstant('DISPID_IRecoCtx_Flags',DISPID_IRecoCtx_Flags);
    AddConstant('DISPID_IRecoCtx_PrefixText',DISPID_IRecoCtx_PrefixText);
    AddConstant('DISPID_IRecoCtx_SuffixText',DISPID_IRecoCtx_SuffixText);
    AddConstant('DISPID_IRecoCtx_StopRecognition',DISPID_IRecoCtx_StopRecognition);
    AddConstant('DISPID_IRecoCtx_Clone',DISPID_IRecoCtx_Clone);
    AddConstant('DISPID_IRecoCtx_Recognize',DISPID_IRecoCtx_Recognize);
    AddConstant('DISPID_IRecoCtx_StopBackgroundRecognition',DISPID_IRecoCtx_StopBackgroundRecognition);
    AddConstant('DISPID_IRecoCtx_EndInkInput',DISPID_IRecoCtx_EndInkInput);
    AddConstant('DISPID_IRecoCtx_BackgroundRecognize',DISPID_IRecoCtx_BackgroundRecognize);
    AddConstant('DISPID_IRecoCtx_BackgroundRecognizeWithAlternates',DISPID_IRecoCtx_BackgroundRecognizeWithAlternates);
    AddConstant('DISPID_IRecoCtx_IsStringSupported',DISPID_IRecoCtx_IsStringSupported);
    AddConstant('DISPID_IRecoCtx2_EnabledUnicodeRanges',DISPID_IRecoCtx2_EnabledUnicodeRanges);
    AddConstant('IRAS_Start',IRAS_Start);
    AddConstant('IRAS_DefaultCount',IRAS_DefaultCount);
    AddConstant('IRAS_All',IRAS_All);
    AddConstant('DISPID_InkRecognitionResult_TopString',DISPID_InkRecognitionResult_TopString);
    AddConstant('DISPID_InkRecognitionResult_TopAlternate',DISPID_InkRecognitionResult_TopAlternate);
    AddConstant('DISPID_InkRecognitionResult_Strokes',DISPID_InkRecognitionResult_Strokes);
    AddConstant('DISPID_InkRecognitionResult_TopConfidence',DISPID_InkRecognitionResult_TopConfidence);
    AddConstant('DISPID_InkRecognitionResult_AlternatesFromSelection',DISPID_InkRecognitionResult_AlternatesFromSelection);
    AddConstant('DISPID_InkRecognitionResult_ModifyTopAlternate',DISPID_InkRecognitionResult_ModifyTopAlternate);
    AddConstant('DISPID_InkRecognitionResult_SetResultOnStrokes',DISPID_InkRecognitionResult_SetResultOnStrokes);
    AddConstant('DISPID_InkRecoAlternate_String',DISPID_InkRecoAlternate_String);
    AddConstant('DISPID_InkRecoAlternate_LineNumber',DISPID_InkRecoAlternate_LineNumber);
    AddConstant('DISPID_InkRecoAlternate_Baseline',DISPID_InkRecoAlternate_Baseline);
    AddConstant('DISPID_InkRecoAlternate_Midline',DISPID_InkRecoAlternate_Midline);
    AddConstant('DISPID_InkRecoAlternate_Ascender',DISPID_InkRecoAlternate_Ascender);
    AddConstant('DISPID_InkRecoAlternate_Descender',DISPID_InkRecoAlternate_Descender);
    AddConstant('DISPID_InkRecoAlternate_Confidence',DISPID_InkRecoAlternate_Confidence);
    AddConstant('DISPID_InkRecoAlternate_Strokes',DISPID_InkRecoAlternate_Strokes);
    AddConstant('DISPID_InkRecoAlternate_GetStrokesFromStrokeRanges',DISPID_InkRecoAlternate_GetStrokesFromStrokeRanges);
    AddConstant('DISPID_InkRecoAlternate_GetStrokesFromTextRange',DISPID_InkRecoAlternate_GetStrokesFromTextRange);
    AddConstant('DISPID_InkRecoAlternate_GetTextRangeFromStrokes',DISPID_InkRecoAlternate_GetTextRangeFromStrokes);
    AddConstant('DISPID_InkRecoAlternate_GetPropertyValue',DISPID_InkRecoAlternate_GetPropertyValue);
    AddConstant('DISPID_InkRecoAlternate_LineAlternates',DISPID_InkRecoAlternate_LineAlternates);
    AddConstant('DISPID_InkRecoAlternate_ConfidenceAlternates',DISPID_InkRecoAlternate_ConfidenceAlternates);
    AddConstant('DISPID_InkRecoAlternate_AlternatesWithConstantPropertyValues',DISPID_InkRecoAlternate_AlternatesWithConstantPropertyValues);
    AddConstant('DISPID_InkRecognitionAlternates_NewEnum',DISPID_InkRecognitionAlternates_NewEnum);
    AddConstant('DISPID_InkRecognitionAlternates_Item',DISPID_InkRecognitionAlternates_Item);
    AddConstant('DISPID_InkRecognitionAlternates_Count',DISPID_InkRecognitionAlternates_Count);
    AddConstant('DISPID_InkRecognitionAlternates_Strokes',DISPID_InkRecognitionAlternates_Strokes);
    AddConstant('DISPID_IRGWritingBox',DISPID_IRGWritingBox);
    AddConstant('DISPID_IRGDrawnBox',DISPID_IRGDrawnBox);
    AddConstant('DISPID_IRGRows',DISPID_IRGRows);
    AddConstant('DISPID_IRGColumns',DISPID_IRGColumns);
    AddConstant('DISPID_IRGMidline',DISPID_IRGMidline);
    AddConstant('DISPID_IRGGuideData',DISPID_IRGGuideData);
    AddConstant('DISPID_InkWordList_AddWord',DISPID_InkWordList_AddWord);
    AddConstant('DISPID_InkWordList_RemoveWord',DISPID_InkWordList_RemoveWord);
    AddConstant('DISPID_InkWordList_Merge',DISPID_InkWordList_Merge);
    AddConstant('DISPID_InkWordList2_AddWords',DISPID_InkWordList2_AddWords);
    AddConstant('InkMinTransparencyValue',InkMinTransparencyValue);
    AddConstant('InkMaxTransparencyValue',InkMaxTransparencyValue);
    AddConstant('InkCollectorClipInkToMargin',InkCollectorClipInkToMargin);
    AddConstant('InkCollectorDefaultMargin',InkCollectorDefaultMargin);
  end;
end;

class function TatMsInkAutLibrary.LibraryName: string;
begin
  result := 'MsInkAut';
end;

initialization
  RegisterScripterLibrary(TatMsInkAutLibrary, True);

{$WARNINGS ON}

end.

