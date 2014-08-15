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
unit ap_MidConst;

interface

uses
  MidConst,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatMidConstLibrary = class(TatScripterLibrary)
    procedure __GetCATID_MIDASAppServer(AMachine: TatVirtualMachine);
    procedure __GetCATID_MIDASInterceptor(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMidConstLibrary.__GetCATID_MIDASAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MidConst.CATID_MIDASAppServer)));
  end;
end;

procedure TatMidConstLibrary.__GetCATID_MIDASInterceptor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MidConst.CATID_MIDASInterceptor)));
  end;
end;

procedure TatMidConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('CATID_MIDASAppServer',tkVariant,__GetCATID_MIDASAppServer,nil,nil,false,0);
    DefineProp('CATID_MIDASInterceptor',tkVariant,__GetCATID_MIDASInterceptor,nil,nil,false,0);
    AddConstant('MIDAS_CatDesc',MIDAS_CatDesc);
    AddConstant('MIDASInterceptor_CatDesc',MIDASInterceptor_CatDesc);
    AddConstant('SCatImplBaseKey',SCatImplBaseKey);
    AddConstant('SCatImplKey',SCatImplKey);
    AddConstant('MIDAS_DLL',MIDAS_DLL);
    AddConstant('SClsid',SClsid);
    AddConstant('SPooled',SPooled);
    AddConstant('SMaxObjects',SMaxObjects);
    AddConstant('STimeout',STimeout);
    AddConstant('SSingleton',SSingleton);
    AddConstant('SSockets',SSockets);
    AddConstant('SWeb',SWeb);
    AddConstant('SFlagOn',SFlagOn);
    AddConstant('SFlagOff',SFlagOff);
    AddConstant('MINDATAPACKETSIZE',MINDATAPACKETSIZE);
    AddConstant('SMidasLib',SMidasLib);
    AddConstant('SProviderNotExported',SProviderNotExported);
    AddConstant('SNoDataProvider',SNoDataProvider);
    AddConstant('SInvalidDataPacket',SInvalidDataPacket);
    AddConstant('SRefreshError',SRefreshError);
    AddConstant('SProviderInvalid',SProviderInvalid);
    AddConstant('SServerNameBlank',SServerNameBlank);
    AddConstant('SRepositoryIdBlank',SRepositoryIdBlank);
    AddConstant('SAggsGroupingLevel',SAggsGroupingLevel);
    AddConstant('SAggsNoSuchLevel',SAggsNoSuchLevel);
    AddConstant('SNoCircularReference',SNoCircularReference);
    AddConstant('SErrorLoadingMidas',SErrorLoadingMidas);
    AddConstant('SCannotCreateDataSet',SCannotCreateDataSet);
    AddConstant('SInvalidClone',SInvalidClone);
    AddConstant('SCDSDlgOpenCaption',SCDSDlgOpenCaption);
    AddConstant('SNoConnectToBroker',SNoConnectToBroker);
    AddConstant('SSocketReadError',SSocketReadError);
    AddConstant('SInvalidProviderName',SInvalidProviderName);
    AddConstant('SBadVariantType',SBadVariantType);
    AddConstant('SInvalidAction',SInvalidAction);
    AddConstant('SNoParentConnection',SNoParentConnection);
    AddConstant('SBlankChildName',SBlankChildName);
    AddConstant('SInvalidResponse',SInvalidResponse);
    AddConstant('SRecordNotFound',SRecordNotFound);
    AddConstant('STooManyRecordsModified',STooManyRecordsModified);
    AddConstant('SInvalidOptParamType',SInvalidOptParamType);
    AddConstant('SMissingDataSet',SMissingDataSet);
    AddConstant('SConstraintFailed',SConstraintFailed);
    AddConstant('SField',SField);
    AddConstant('SReadOnlyProvider',SReadOnlyProvider);
    AddConstant('SNoKeySpecified',SNoKeySpecified);
    AddConstant('SFieldNameTooLong',SFieldNameTooLong);
    AddConstant('SNoDataSets',SNoDataSets);
    AddConstant('SRecConstFail',SRecConstFail);
    AddConstant('SFieldConstFail',SFieldConstFail);
    AddConstant('SDefExprFail',SDefExprFail);
    AddConstant('SArrayElementError',SArrayElementError);
    AddConstant('SNoTableName',SNoTableName);
    AddConstant('SNoEditsAllowed',SNoEditsAllowed);
    AddConstant('SNoDeletesAllowed',SNoDeletesAllowed);
    AddConstant('SNoInsertsAllowed',SNoInsertsAllowed);
    AddConstant('SCannotChangeCommandText',SCannotChangeCommandText);
    AddConstant('SAggregatesActive',SAggregatesActive);
    AddConstant('SNoServers',SNoServers);
    AddConstant('SConnectionMissing',SConnectionMissing);
    AddConstant('SNoCircularConnection',SNoCircularConnection);
    AddConstant('SReturnError',SReturnError);
    AddConstant('SNoWinSock2',SNoWinSock2);
    AddConstant('SURLRequired',SURLRequired);
    AddConstant('SDefaultURL',SDefaultURL);
    AddConstant('SInvalidURL',SInvalidURL);
    AddConstant('SServerIsBusy',SServerIsBusy);
    AddConstant('SObjectNotAvailable',SObjectNotAvailable);
    AddConstant('SMasterNotOpen',SMasterNotOpen);
  end;
end;

class function TatMidConstLibrary.LibraryName: string;
begin
  result := 'MidConst';
end;

initialization
  RegisterScripterLibrary(TatMidConstLibrary, True);

{$WARNINGS ON}

end.

