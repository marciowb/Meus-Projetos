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
unit ap_MPlayer;

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  Graphics,
  Messages,
  MMSystem,
  Dialogs,
  SysUtils,
  MPlayer,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatMPlayerLibrary = class(TatScripterLibrary)
    procedure __TMediaPlayerCreate(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerDestroy(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerOpen(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerClose(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerPlay(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerStop(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerPause(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerStep(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerBack(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerPrevious(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerNext(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerStartRecording(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerEject(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerSave(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerPauseOnly(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerResume(AMachine: TatVirtualMachine);
    procedure __TMediaPlayerRewind(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerTrackLength(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerTrackPosition(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerCapabilities(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerError(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerErrorMessage(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerStart(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerLength(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerTracks(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerFrames(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerFrames(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerMode(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerPosition(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerPosition(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerWait(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerWait(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerNotify(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerNotify(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerNotifyValue(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerStartPos(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerStartPos(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerEndPos(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerEndPos(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerDeviceID(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerTimeFormat(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerTimeFormat(AMachine: TatVirtualMachine);
    procedure __GetTMediaPlayerDisplayRect(AMachine: TatVirtualMachine);
    procedure __SetTMediaPlayerDisplayRect(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EMCIDeviceErrorClass = class of EMCIDeviceError;
  TMediaPlayerClass = class of TMediaPlayer;

  TatMPlayerDispatcher = class(TatEventDispatcher)
  private
    procedure __EMPNotify( Sender: TObject;  Button: TMPBtnType; var DoDefault: Boolean);
    procedure __EMPPostNotify( Sender: TObject;  Button: TMPBtnType);
  end;

  TMPButtonWrapper = class(TatRecordWrapper)
  private
    FVisible: Boolean;
    FEnabled: Boolean;
    FColored: Boolean;
    FAuto: Boolean;
  public
    constructor Create(ARecord: TMPButton);
    function ObjToRec: TMPButton;
  published
    property Visible: Boolean read FVisible write FVisible;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Colored: Boolean read FColored write FColored;
    property Auto: Boolean read FAuto write FAuto;
  end;
  

implementation

constructor TMPButtonWrapper.Create(ARecord: TMPButton);
begin
  inherited Create;
  FVisible := ARecord.Visible;
  FEnabled := ARecord.Enabled;
  FColored := ARecord.Colored;
  FAuto := ARecord.Auto;
end;

function TMPButtonWrapper.ObjToRec: TMPButton;
begin
  result.Visible := FVisible;
  result.Enabled := FEnabled;
  result.Colored := FColored;
  result.Auto := FAuto;
end;



procedure TatMPlayerLibrary.__TMediaPlayerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMediaPlayerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Destroy;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Open;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Close;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerPlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Play;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerStop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Stop;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerPause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Pause;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerStep(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Step;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerBack(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Back;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerPrevious(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Previous;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerNext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Next;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerStartRecording(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).StartRecording;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerEject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Eject;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerSave(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Save;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerPauseOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).PauseOnly;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerResume(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Resume;
  end;
end;

procedure TatMPlayerLibrary.__TMediaPlayerRewind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Rewind;
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerTrackLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).TrackLength[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerTrackPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).TrackPosition[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerCapabilities(AMachine: TatVirtualMachine);
var
PropValueSet: TMPDevCapsSet;
begin
  with AMachine do
  begin
    PropValueSet := TMediaPlayer(CurrentObject).Capabilities;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).Error));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerErrorMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMediaPlayer(CurrentObject).ErrorMessage);
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).Start));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).Length));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerTracks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).Tracks));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerFrames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).Frames));
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerFrames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Frames:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMediaPlayer(CurrentObject).Mode);
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).Position));
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Position:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerWait(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMediaPlayer(CurrentObject).Wait);
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerWait(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Wait:=GetInputArg(0);
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerNotify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMediaPlayer(CurrentObject).Notify);
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerNotify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).Notify:=GetInputArg(0);
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerNotifyValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMediaPlayer(CurrentObject).NotifyValue);
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerStartPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).StartPos));
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerStartPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).StartPos:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerEndPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).EndPos));
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerEndPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).EndPos:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerDeviceID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMediaPlayer(CurrentObject).DeviceID));
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerTimeFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMediaPlayer(CurrentObject).TimeFormat);
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerTimeFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).TimeFormat:=GetInputArg(0);
  end;
end;

procedure TatMPlayerLibrary.__GetTMediaPlayerDisplayRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TMediaPlayer(CurrentObject).DisplayRect)));
  end;
end;

procedure TatMPlayerLibrary.__SetTMediaPlayerDisplayRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMediaPlayer(CurrentObject).DisplayRect:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatMPlayerDispatcher.__EMPNotify( Sender: TObject;  Button: TMPBtnType; var DoDefault: Boolean);
var
  ButtonTemp: variant;
  DoDefaultTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      EMPNotify(BeforeCall)(Sender,Button,DoDefault);
    ButtonTemp := Button;
    DoDefaultTemp := DoDefault;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ButtonTemp,DoDefaultTemp]);
    DoDefault := DoDefaultTemp;
    if AssignedMethod(AfterCall) then
      EMPNotify(AfterCall)(Sender,Button,DoDefault);
  end;
end;

procedure TatMPlayerDispatcher.__EMPPostNotify( Sender: TObject;  Button: TMPBtnType);
var
  ButtonTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      EMPPostNotify(BeforeCall)(Sender,Button);
    ButtonTemp := Button;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ButtonTemp]);
    if AssignedMethod(AfterCall) then
      EMPPostNotify(AfterCall)(Sender,Button);
  end;
end;

procedure TatMPlayerLibrary.Init;
begin
  With Scripter.DefineClass(EMCIDeviceError) do
  begin
  end;
  With Scripter.DefineClass(TMediaPlayer) do
  begin
    DefineMethod('Create',1,tkClass,TMediaPlayer,__TMediaPlayerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMediaPlayerDestroy,false,0);
    DefineMethod('Open',0,tkNone,nil,__TMediaPlayerOpen,false,0);
    DefineMethod('Close',0,tkNone,nil,__TMediaPlayerClose,false,0);
    DefineMethod('Play',0,tkNone,nil,__TMediaPlayerPlay,false,0);
    DefineMethod('Stop',0,tkNone,nil,__TMediaPlayerStop,false,0);
    DefineMethod('Pause',0,tkNone,nil,__TMediaPlayerPause,false,0);
    DefineMethod('Step',0,tkNone,nil,__TMediaPlayerStep,false,0);
    DefineMethod('Back',0,tkNone,nil,__TMediaPlayerBack,false,0);
    DefineMethod('Previous',0,tkNone,nil,__TMediaPlayerPrevious,false,0);
    DefineMethod('Next',0,tkNone,nil,__TMediaPlayerNext,false,0);
    DefineMethod('StartRecording',0,tkNone,nil,__TMediaPlayerStartRecording,false,0);
    DefineMethod('Eject',0,tkNone,nil,__TMediaPlayerEject,false,0);
    DefineMethod('Save',0,tkNone,nil,__TMediaPlayerSave,false,0);
    DefineMethod('PauseOnly',0,tkNone,nil,__TMediaPlayerPauseOnly,false,0);
    DefineMethod('Resume',0,tkNone,nil,__TMediaPlayerResume,false,0);
    DefineMethod('Rewind',0,tkNone,nil,__TMediaPlayerRewind,false,0);
    DefineProp('TrackLength',tkInteger,__GetTMediaPlayerTrackLength,nil,nil,false,1);
    DefineProp('TrackPosition',tkInteger,__GetTMediaPlayerTrackPosition,nil,nil,false,1);
    DefineProp('Capabilities',tkInteger,__GetTMediaPlayerCapabilities,nil,nil,false,0);
    DefineProp('Error',tkInteger,__GetTMediaPlayerError,nil,nil,false,0);
    DefineProp('ErrorMessage',tkVariant,__GetTMediaPlayerErrorMessage,nil,nil,false,0);
    DefineProp('Start',tkInteger,__GetTMediaPlayerStart,nil,nil,false,0);
    DefineProp('Length',tkInteger,__GetTMediaPlayerLength,nil,nil,false,0);
    DefineProp('Tracks',tkInteger,__GetTMediaPlayerTracks,nil,nil,false,0);
    DefineProp('Frames',tkInteger,__GetTMediaPlayerFrames,__SetTMediaPlayerFrames,nil,false,0);
    DefineProp('Mode',tkEnumeration,__GetTMediaPlayerMode,nil,nil,false,0);
    DefineProp('Position',tkInteger,__GetTMediaPlayerPosition,__SetTMediaPlayerPosition,nil,false,0);
    DefineProp('Wait',tkVariant,__GetTMediaPlayerWait,__SetTMediaPlayerWait,nil,false,0);
    DefineProp('Notify',tkVariant,__GetTMediaPlayerNotify,__SetTMediaPlayerNotify,nil,false,0);
    DefineProp('NotifyValue',tkEnumeration,__GetTMediaPlayerNotifyValue,nil,nil,false,0);
    DefineProp('StartPos',tkInteger,__GetTMediaPlayerStartPos,__SetTMediaPlayerStartPos,nil,false,0);
    DefineProp('EndPos',tkInteger,__GetTMediaPlayerEndPos,__SetTMediaPlayerEndPos,nil,false,0);
    DefineProp('DeviceID',tkInteger,__GetTMediaPlayerDeviceID,nil,nil,false,0);
    DefineProp('TimeFormat',tkEnumeration,__GetTMediaPlayerTimeFormat,__SetTMediaPlayerTimeFormat,nil,false,0);
    DefineProp('DisplayRect',tkVariant,__GetTMediaPlayerDisplayRect,__SetTMediaPlayerDisplayRect,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(EMPNotify), TatMPlayerDispatcher, @TatMPlayerDispatcher.__EMPNotify);
  DefineEventAdapter(TypeInfo(EMPPostNotify), TatMPlayerDispatcher, @TatMPlayerDispatcher.__EMPPostNotify);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('btPlay',btPlay);
    AddConstant('btPause',btPause);
    AddConstant('btStop',btStop);
    AddConstant('btNext',btNext);
    AddConstant('btPrev',btPrev);
    AddConstant('btStep',btStep);
    AddConstant('btBack',btBack);
    AddConstant('btRecord',btRecord);
    AddConstant('btEject',btEject);
    AddConstant('mgEnabled',mgEnabled);
    AddConstant('mgDisabled',mgDisabled);
    AddConstant('mgColored',mgColored);
    AddConstant('dtAutoSelect',dtAutoSelect);
    AddConstant('dtAVIVideo',dtAVIVideo);
    AddConstant('dtCDAudio',dtCDAudio);
    AddConstant('dtDAT',dtDAT);
    AddConstant('dtDigitalVideo',dtDigitalVideo);
    AddConstant('dtMMMovie',dtMMMovie);
    AddConstant('dtOther',dtOther);
    AddConstant('dtOverlay',dtOverlay);
    AddConstant('dtScanner',dtScanner);
    AddConstant('dtSequencer',dtSequencer);
    AddConstant('dtVCR',dtVCR);
    AddConstant('dtVideodisc',dtVideodisc);
    AddConstant('dtWaveAudio',dtWaveAudio);
    AddConstant('tfMilliseconds',tfMilliseconds);
    AddConstant('tfHMS',tfHMS);
    AddConstant('tfMSF',tfMSF);
    AddConstant('tfFrames',tfFrames);
    AddConstant('tfSMPTE24',tfSMPTE24);
    AddConstant('tfSMPTE25',tfSMPTE25);
    AddConstant('tfSMPTE30',tfSMPTE30);
    AddConstant('tfSMPTE30Drop',tfSMPTE30Drop);
    AddConstant('tfBytes',tfBytes);
    AddConstant('tfSamples',tfSamples);
    AddConstant('tfTMSF',tfTMSF);
    AddConstant('mpNotReady',mpNotReady);
    AddConstant('mpStopped',mpStopped);
    AddConstant('mpPlaying',mpPlaying);
    AddConstant('mpRecording',mpRecording);
    AddConstant('mpSeeking',mpSeeking);
    AddConstant('mpPaused',mpPaused);
    AddConstant('mpOpen',mpOpen);
    AddConstant('nvSuccessful',nvSuccessful);
    AddConstant('nvSuperseded',nvSuperseded);
    AddConstant('nvAborted',nvAborted);
    AddConstant('nvFailure',nvFailure);
    AddConstant('mpCanStep',mpCanStep);
    AddConstant('mpCanEject',mpCanEject);
    AddConstant('mpCanPlay',mpCanPlay);
    AddConstant('mpCanRecord',mpCanRecord);
    AddConstant('mpUsesWindow',mpUsesWindow);
  end;
end;

class function TatMPlayerLibrary.LibraryName: string;
begin
  result := 'MPlayer';
end;

initialization
  RegisterScripterLibrary(TatMPlayerLibrary, True);

{$WARNINGS ON}

end.

