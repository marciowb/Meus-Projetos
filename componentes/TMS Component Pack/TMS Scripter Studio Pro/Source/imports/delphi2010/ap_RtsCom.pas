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
unit ap_RtsCom;

interface

uses
  TpcShrd,
  MsInkAut,
  Manipulations,
  Windows,
  RtsCom,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatRtsComLibrary = class(TatScripterLibrary)
    procedure __GetGUID_GESTURE_DATA(AMachine: TatVirtualMachine);
    procedure __GetGUID_DYNAMIC_RENDERER_CACHED_DATA(AMachine: TatVirtualMachine);
    procedure __GetGUID_MANIPULATION_PROCESSOR_DATA(AMachine: TatVirtualMachine);
    procedure __GetIID_IRealTimeStylus(AMachine: TatVirtualMachine);
    procedure __GetIID_IRealTimeStylus2(AMachine: TatVirtualMachine);
    procedure __GetIID_IRealTimeStylus3(AMachine: TatVirtualMachine);
    procedure __GetIID_IRealTimeStylusSynchronization(AMachine: TatVirtualMachine);
    procedure __GetIID_IStrokeBuilder(AMachine: TatVirtualMachine);
    procedure __GetIID_IStylusPlugin(AMachine: TatVirtualMachine);
    procedure __GetIID_IStylusSyncPlugin(AMachine: TatVirtualMachine);
    procedure __GetIID_IStylusAsyncPlugin(AMachine: TatVirtualMachine);
    procedure __GetIID_IDynamicRenderer(AMachine: TatVirtualMachine);
    procedure __GetIID_IGestureRecognizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_RealTimeStylus(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DynamicRenderer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_GestureRecognizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StrokeBuilder(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ManipulationProcessorRTS(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  StylusInfoWrapper = class(TatRecordWrapper)
  private
    Ftcid: TABLET_CONTEXT_ID;
    Fcid: STYLUS_ID;
    FbIsInvertedCursor: BOOL;
  public
    constructor Create(ARecord: StylusInfo);
    function ObjToRec: StylusInfo;
  published
    property tcid: TABLET_CONTEXT_ID read Ftcid write Ftcid;
    property cid: STYLUS_ID read Fcid write Fcid;
    property bIsInvertedCursor: BOOL read FbIsInvertedCursor write FbIsInvertedCursor;
  end;
  
  GESTURE_DATAWrapper = class(TatRecordWrapper)
  private
    FgestureId: Integer;
    FrecoConfidence: Integer;
    FstrokeCount: Integer;
  public
    constructor Create(ARecord: GESTURE_DATA);
    function ObjToRec: GESTURE_DATA;
  published
    property gestureId: Integer read FgestureId write FgestureId;
    property recoConfidence: Integer read FrecoConfidence write FrecoConfidence;
    property strokeCount: Integer read FstrokeCount write FstrokeCount;
  end;
  
  DYNAMIC_RENDERER_CACHED_DATAWrapper = class(TatRecordWrapper)
  private
    FstrokeId: Integer;
  public
    constructor Create(ARecord: DYNAMIC_RENDERER_CACHED_DATA);
    function ObjToRec: DYNAMIC_RENDERER_CACHED_DATA;
  published
    property strokeId: Integer read FstrokeId write FstrokeId;
  end;
  

implementation

constructor StylusInfoWrapper.Create(ARecord: StylusInfo);
begin
  inherited Create;
  Ftcid := ARecord.tcid;
  Fcid := ARecord.cid;
  FbIsInvertedCursor := ARecord.bIsInvertedCursor;
end;

function StylusInfoWrapper.ObjToRec: StylusInfo;
begin
  result.tcid := Ftcid;
  result.cid := Fcid;
  result.bIsInvertedCursor := FbIsInvertedCursor;
end;

constructor GESTURE_DATAWrapper.Create(ARecord: GESTURE_DATA);
begin
  inherited Create;
  FgestureId := ARecord.gestureId;
  FrecoConfidence := ARecord.recoConfidence;
  FstrokeCount := ARecord.strokeCount;
end;

function GESTURE_DATAWrapper.ObjToRec: GESTURE_DATA;
begin
  result.gestureId := FgestureId;
  result.recoConfidence := FrecoConfidence;
  result.strokeCount := FstrokeCount;
end;

constructor DYNAMIC_RENDERER_CACHED_DATAWrapper.Create(ARecord: DYNAMIC_RENDERER_CACHED_DATA);
begin
  inherited Create;
  FstrokeId := ARecord.strokeId;
end;

function DYNAMIC_RENDERER_CACHED_DATAWrapper.ObjToRec: DYNAMIC_RENDERER_CACHED_DATA;
begin
  result.strokeId := FstrokeId;
end;



procedure TatRtsComLibrary.__GetGUID_GESTURE_DATA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.GUID_GESTURE_DATA)));
  end;
end;

procedure TatRtsComLibrary.__GetGUID_DYNAMIC_RENDERER_CACHED_DATA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.GUID_DYNAMIC_RENDERER_CACHED_DATA)));
  end;
end;

procedure TatRtsComLibrary.__GetGUID_MANIPULATION_PROCESSOR_DATA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.GUID_MANIPULATION_PROCESSOR_DATA)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IRealTimeStylus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IRealTimeStylus)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IRealTimeStylus2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IRealTimeStylus2)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IRealTimeStylus3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IRealTimeStylus3)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IRealTimeStylusSynchronization(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IRealTimeStylusSynchronization)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IStrokeBuilder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IStrokeBuilder)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IStylusPlugin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IStylusPlugin)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IStylusSyncPlugin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IStylusSyncPlugin)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IStylusAsyncPlugin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IStylusAsyncPlugin)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IDynamicRenderer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IDynamicRenderer)));
  end;
end;

procedure TatRtsComLibrary.__GetIID_IGestureRecognizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.IID_IGestureRecognizer)));
  end;
end;

procedure TatRtsComLibrary.__GetCLSID_RealTimeStylus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.CLSID_RealTimeStylus)));
  end;
end;

procedure TatRtsComLibrary.__GetCLSID_DynamicRenderer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.CLSID_DynamicRenderer)));
  end;
end;

procedure TatRtsComLibrary.__GetCLSID_GestureRecognizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.CLSID_GestureRecognizer)));
  end;
end;

procedure TatRtsComLibrary.__GetCLSID_StrokeBuilder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.CLSID_StrokeBuilder)));
  end;
end;

procedure TatRtsComLibrary.__GetCLSID_ManipulationProcessorRTS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(RtsCom.CLSID_ManipulationProcessorRTS)));
  end;
end;

procedure TatRtsComLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('GUID_GESTURE_DATA',tkVariant,__GetGUID_GESTURE_DATA,nil,nil,false,0);
    DefineProp('GUID_DYNAMIC_RENDERER_CACHED_DATA',tkVariant,__GetGUID_DYNAMIC_RENDERER_CACHED_DATA,nil,nil,false,0);
    DefineProp('GUID_MANIPULATION_PROCESSOR_DATA',tkVariant,__GetGUID_MANIPULATION_PROCESSOR_DATA,nil,nil,false,0);
    DefineProp('IID_IRealTimeStylus',tkVariant,__GetIID_IRealTimeStylus,nil,nil,false,0);
    DefineProp('IID_IRealTimeStylus2',tkVariant,__GetIID_IRealTimeStylus2,nil,nil,false,0);
    DefineProp('IID_IRealTimeStylus3',tkVariant,__GetIID_IRealTimeStylus3,nil,nil,false,0);
    DefineProp('IID_IRealTimeStylusSynchronization',tkVariant,__GetIID_IRealTimeStylusSynchronization,nil,nil,false,0);
    DefineProp('IID_IStrokeBuilder',tkVariant,__GetIID_IStrokeBuilder,nil,nil,false,0);
    DefineProp('IID_IStylusPlugin',tkVariant,__GetIID_IStylusPlugin,nil,nil,false,0);
    DefineProp('IID_IStylusSyncPlugin',tkVariant,__GetIID_IStylusSyncPlugin,nil,nil,false,0);
    DefineProp('IID_IStylusAsyncPlugin',tkVariant,__GetIID_IStylusAsyncPlugin,nil,nil,false,0);
    DefineProp('IID_IDynamicRenderer',tkVariant,__GetIID_IDynamicRenderer,nil,nil,false,0);
    DefineProp('IID_IGestureRecognizer',tkVariant,__GetIID_IGestureRecognizer,nil,nil,false,0);
    DefineProp('CLSID_RealTimeStylus',tkVariant,__GetCLSID_RealTimeStylus,nil,nil,false,0);
    DefineProp('CLSID_DynamicRenderer',tkVariant,__GetCLSID_DynamicRenderer,nil,nil,false,0);
    DefineProp('CLSID_GestureRecognizer',tkVariant,__GetCLSID_GestureRecognizer,nil,nil,false,0);
    DefineProp('CLSID_StrokeBuilder',tkVariant,__GetCLSID_StrokeBuilder,nil,nil,false,0);
    DefineProp('CLSID_ManipulationProcessorRTS',tkVariant,__GetCLSID_ManipulationProcessorRTS,nil,nil,false,0);
    AddConstant('RTSDI_AllData',RTSDI_AllData);
    AddConstant('RTSDI_None',RTSDI_None);
    AddConstant('RTSDI_Error',RTSDI_Error);
    AddConstant('RTSDI_RealTimeStylusEnabled',RTSDI_RealTimeStylusEnabled);
    AddConstant('RTSDI_RealTimeStylusDisabled',RTSDI_RealTimeStylusDisabled);
    AddConstant('RTSDI_StylusNew',RTSDI_StylusNew);
    AddConstant('RTSDI_StylusInRange',RTSDI_StylusInRange);
    AddConstant('RTSDI_InAirPackets',RTSDI_InAirPackets);
    AddConstant('RTSDI_StylusOutOfRange',RTSDI_StylusOutOfRange);
    AddConstant('RTSDI_StylusDown',RTSDI_StylusDown);
    AddConstant('RTSDI_Packets',RTSDI_Packets);
    AddConstant('RTSDI_StylusUp',RTSDI_StylusUp);
    AddConstant('RTSDI_StylusButtonUp',RTSDI_StylusButtonUp);
    AddConstant('RTSDI_StylusButtonDown',RTSDI_StylusButtonDown);
    AddConstant('RTSDI_SystemEvents',RTSDI_SystemEvents);
    AddConstant('RTSDI_TabletAdded',RTSDI_TabletAdded);
    AddConstant('RTSDI_TabletRemoved',RTSDI_TabletRemoved);
    AddConstant('RTSDI_CustomStylusDataAdded',RTSDI_CustomStylusDataAdded);
    AddConstant('RTSDI_UpdateMapping',RTSDI_UpdateMapping);
    AddConstant('RTSDI_DefaultEvents',RTSDI_DefaultEvents);
    AddConstant('SyncStylusQueue',SyncStylusQueue);
    AddConstant('AsyncStylusQueueImmediate',AsyncStylusQueueImmediate);
    AddConstant('AsyncStylusQueue',AsyncStylusQueue);
    AddConstant('RTSLT_ObjLock',RTSLT_ObjLock);
    AddConstant('RTSLT_SyncEventLock',RTSLT_SyncEventLock);
    AddConstant('RTSLT_AsyncEventLock',RTSLT_AsyncEventLock);
    AddConstant('RTSLT_ExcludeCallback',RTSLT_ExcludeCallback);
    AddConstant('RTSLT_SyncObjLock',RTSLT_SyncObjLock);
    AddConstant('RTSLT_AsyncObjLock',RTSLT_AsyncObjLock);
    AddConstant('SID_IRealTimeStylus',SID_IRealTimeStylus);
    AddConstant('SID_IRealTimeStylus2',SID_IRealTimeStylus2);
    AddConstant('SID_IRealTimeStylus3',SID_IRealTimeStylus3);
    AddConstant('SID_IRealTimeStylusSynchronization',SID_IRealTimeStylusSynchronization);
    AddConstant('SID_IStrokeBuilder',SID_IStrokeBuilder);
    AddConstant('SID_IStylusPlugin',SID_IStylusPlugin);
    AddConstant('SID_IStylusSyncPlugin',SID_IStylusSyncPlugin);
    AddConstant('SID_IStylusAsyncPlugin',SID_IStylusAsyncPlugin);
    AddConstant('SID_IDynamicRenderer',SID_IDynamicRenderer);
    AddConstant('SID_IGestureRecognizer',SID_IGestureRecognizer);
  end;
end;

class function TatRtsComLibrary.LibraryName: string;
begin
  result := 'RtsCom';
end;

initialization
  RegisterScripterLibrary(TatRtsComLibrary, True);

{$WARNINGS ON}

end.

