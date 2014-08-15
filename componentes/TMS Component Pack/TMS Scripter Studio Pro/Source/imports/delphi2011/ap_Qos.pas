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
unit ap_Qos;

interface

uses
  Windows,
  Qos,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatQosLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _flowspecWrapper = class(TatRecordWrapper)
  private
    FTokenRate: ULONG;
    FTokenBucketSize: ULONG;
    FPeakBandwidth: ULONG;
    FLatency: ULONG;
    FDelayVariation: ULONG;
    FServiceType: SERVICETYPE;
    FMaxSduSize: ULONG;
    FMinimumPolicedSize: ULONG;
  public
    constructor Create(ARecord: _flowspec);
    function ObjToRec: _flowspec;
  published
    property TokenRate: ULONG read FTokenRate write FTokenRate;
    property TokenBucketSize: ULONG read FTokenBucketSize write FTokenBucketSize;
    property PeakBandwidth: ULONG read FPeakBandwidth write FPeakBandwidth;
    property Latency: ULONG read FLatency write FLatency;
    property DelayVariation: ULONG read FDelayVariation write FDelayVariation;
    property ServiceType: SERVICETYPE read FServiceType write FServiceType;
    property MaxSduSize: ULONG read FMaxSduSize write FMaxSduSize;
    property MinimumPolicedSize: ULONG read FMinimumPolicedSize write FMinimumPolicedSize;
  end;
  
  QOS_OBJECT_HDRWrapper = class(TatRecordWrapper)
  private
    FObjectType: ULONG;
    FObjectLength: ULONG;
  public
    constructor Create(ARecord: QOS_OBJECT_HDR);
    function ObjToRec: QOS_OBJECT_HDR;
  published
    property ObjectType: ULONG read FObjectType write FObjectType;
    property ObjectLength: ULONG read FObjectLength write FObjectLength;
  end;
  
  _QOS_SD_MODEWrapper = class(TatRecordWrapper)
  private
    FShapeDiscardMode: ULONG;
  public
    constructor Create(ARecord: _QOS_SD_MODE);
    function ObjToRec: _QOS_SD_MODE;
  published
    property ShapeDiscardMode: ULONG read FShapeDiscardMode write FShapeDiscardMode;
  end;
  
  _QOS_SHAPING_RATEWrapper = class(TatRecordWrapper)
  private
    FShapingRate: ULONG;
  public
    constructor Create(ARecord: _QOS_SHAPING_RATE);
    function ObjToRec: _QOS_SHAPING_RATE;
  published
    property ShapingRate: ULONG read FShapingRate write FShapingRate;
  end;
  

implementation

constructor _flowspecWrapper.Create(ARecord: _flowspec);
begin
  inherited Create;
  FTokenRate := ARecord.TokenRate;
  FTokenBucketSize := ARecord.TokenBucketSize;
  FPeakBandwidth := ARecord.PeakBandwidth;
  FLatency := ARecord.Latency;
  FDelayVariation := ARecord.DelayVariation;
  FServiceType := ARecord.ServiceType;
  FMaxSduSize := ARecord.MaxSduSize;
  FMinimumPolicedSize := ARecord.MinimumPolicedSize;
end;

function _flowspecWrapper.ObjToRec: _flowspec;
begin
  result.TokenRate := FTokenRate;
  result.TokenBucketSize := FTokenBucketSize;
  result.PeakBandwidth := FPeakBandwidth;
  result.Latency := FLatency;
  result.DelayVariation := FDelayVariation;
  result.ServiceType := FServiceType;
  result.MaxSduSize := FMaxSduSize;
  result.MinimumPolicedSize := FMinimumPolicedSize;
end;

constructor QOS_OBJECT_HDRWrapper.Create(ARecord: QOS_OBJECT_HDR);
begin
  inherited Create;
  FObjectType := ARecord.ObjectType;
  FObjectLength := ARecord.ObjectLength;
end;

function QOS_OBJECT_HDRWrapper.ObjToRec: QOS_OBJECT_HDR;
begin
  result.ObjectType := FObjectType;
  result.ObjectLength := FObjectLength;
end;

constructor _QOS_SD_MODEWrapper.Create(ARecord: _QOS_SD_MODE);
begin
  inherited Create;
  FShapeDiscardMode := ARecord.ShapeDiscardMode;
end;

function _QOS_SD_MODEWrapper.ObjToRec: _QOS_SD_MODE;
begin
  result.ShapeDiscardMode := FShapeDiscardMode;
end;

constructor _QOS_SHAPING_RATEWrapper.Create(ARecord: _QOS_SHAPING_RATE);
begin
  inherited Create;
  FShapingRate := ARecord.ShapingRate;
end;

function _QOS_SHAPING_RATEWrapper.ObjToRec: _QOS_SHAPING_RATE;
begin
  result.ShapingRate := FShapingRate;
end;



procedure TatQosLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SERVICETYPE_NOTRAFFIC',SERVICETYPE_NOTRAFFIC);
    AddConstant('SERVICETYPE_BESTEFFORT',SERVICETYPE_BESTEFFORT);
    AddConstant('SERVICETYPE_CONTROLLEDLOAD',SERVICETYPE_CONTROLLEDLOAD);
    AddConstant('SERVICETYPE_GUARANTEED',SERVICETYPE_GUARANTEED);
    AddConstant('SERVICETYPE_NETWORK_UNAVAILABLE',SERVICETYPE_NETWORK_UNAVAILABLE);
    AddConstant('SERVICETYPE_GENERAL_INFORMATION',SERVICETYPE_GENERAL_INFORMATION);
    AddConstant('SERVICETYPE_NOCHANGE',SERVICETYPE_NOCHANGE);
    AddConstant('SERVICETYPE_NONCONFORMING',SERVICETYPE_NONCONFORMING);
    AddConstant('SERVICETYPE_NETWORK_CONTROL',SERVICETYPE_NETWORK_CONTROL);
    AddConstant('SERVICETYPE_QUALITATIVE',SERVICETYPE_QUALITATIVE);
    AddConstant('SERVICE_BESTEFFORT',SERVICE_BESTEFFORT);
    AddConstant('SERVICE_CONTROLLEDLOAD',SERVICE_CONTROLLEDLOAD);
    AddConstant('SERVICE_GUARANTEED',SERVICE_GUARANTEED);
    AddConstant('SERVICE_QUALITATIVE',SERVICE_QUALITATIVE);
    AddConstant('SERVICE_NO_TRAFFIC_CONTROL',SERVICE_NO_TRAFFIC_CONTROL);
    AddConstant('SERVICE_NO_QOS_SIGNALING',SERVICE_NO_QOS_SIGNALING);
    AddConstant('QOS_NOT_SPECIFIED',QOS_NOT_SPECIFIED);
    AddConstant('POSITIVE_INFINITY_RATE',POSITIVE_INFINITY_RATE);
    AddConstant('QOS_GENERAL_ID_BASE',QOS_GENERAL_ID_BASE);
    AddConstant('QOS_OBJECT_END_OF_LIST',QOS_OBJECT_END_OF_LIST);
    AddConstant('QOS_OBJECT_SD_MODE',QOS_OBJECT_SD_MODE);
    AddConstant('QOS_OBJECT_SHAPING_RATE',QOS_OBJECT_SHAPING_RATE);
    AddConstant('QOS_OBJECT_DESTADDR',QOS_OBJECT_DESTADDR);
    AddConstant('TC_NONCONF_BORROW',TC_NONCONF_BORROW);
    AddConstant('TC_NONCONF_SHAPE',TC_NONCONF_SHAPE);
    AddConstant('TC_NONCONF_DISCARD',TC_NONCONF_DISCARD);
    AddConstant('TC_NONCONF_BORROW_PLUS',TC_NONCONF_BORROW_PLUS);
  end;
end;

class function TatQosLibrary.LibraryName: string;
begin
  result := 'Qos';
end;

initialization
  RegisterScripterLibrary(TatQosLibrary, True);

{$WARNINGS ON}

end.

