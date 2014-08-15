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
unit ap_WinSpool;

interface

uses
  Windows,
  WinSpool,
  Variants,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatWinSpoolLibrary = class(TatScripterLibrary)
    procedure __DeletePrinter(AMachine: TatVirtualMachine);
    procedure __DeletePrinterDriver(AMachine: TatVirtualMachine);
    procedure __DeletePrinterDriverA(AMachine: TatVirtualMachine);
    procedure __DeletePrinterDriverW(AMachine: TatVirtualMachine);
    procedure __AddPrintProcessor(AMachine: TatVirtualMachine);
    procedure __AddPrintProcessorA(AMachine: TatVirtualMachine);
    procedure __AddPrintProcessorW(AMachine: TatVirtualMachine);
    procedure __DeletePrintProcessor(AMachine: TatVirtualMachine);
    procedure __DeletePrintProcessorA(AMachine: TatVirtualMachine);
    procedure __DeletePrintProcessorW(AMachine: TatVirtualMachine);
    procedure __StartPagePrinter(AMachine: TatVirtualMachine);
    procedure __EndPagePrinter(AMachine: TatVirtualMachine);
    procedure __AbortPrinter(AMachine: TatVirtualMachine);
    procedure __EndDocPrinter(AMachine: TatVirtualMachine);
    procedure __ScheduleJob(AMachine: TatVirtualMachine);
    procedure __PrinterProperties(AMachine: TatVirtualMachine);
    procedure __DocumentProperties(AMachine: TatVirtualMachine);
    procedure __DocumentPropertiesA(AMachine: TatVirtualMachine);
    procedure __DocumentPropertiesW(AMachine: TatVirtualMachine);
    procedure __DeletePrinterData(AMachine: TatVirtualMachine);
    procedure __DeletePrinterDataA(AMachine: TatVirtualMachine);
    procedure __DeletePrinterDataW(AMachine: TatVirtualMachine);
    procedure __WaitForPrinterChange(AMachine: TatVirtualMachine);
    procedure __FindClosePrinterChangeNotification(AMachine: TatVirtualMachine);
    procedure __PrinterMessageBox(AMachine: TatVirtualMachine);
    procedure __PrinterMessageBoxA(AMachine: TatVirtualMachine);
    procedure __PrinterMessageBoxW(AMachine: TatVirtualMachine);
    procedure __ClosePrinter(AMachine: TatVirtualMachine);
    procedure __DeleteForm(AMachine: TatVirtualMachine);
    procedure __DeleteFormA(AMachine: TatVirtualMachine);
    procedure __DeleteFormW(AMachine: TatVirtualMachine);
    procedure __DeleteMonitor(AMachine: TatVirtualMachine);
    procedure __DeleteMonitorA(AMachine: TatVirtualMachine);
    procedure __DeleteMonitorW(AMachine: TatVirtualMachine);
    procedure __AddPort(AMachine: TatVirtualMachine);
    procedure __AddPortA(AMachine: TatVirtualMachine);
    procedure __AddPortW(AMachine: TatVirtualMachine);
    procedure __ConfigurePort(AMachine: TatVirtualMachine);
    procedure __ConfigurePortA(AMachine: TatVirtualMachine);
    procedure __ConfigurePortW(AMachine: TatVirtualMachine);
    procedure __DeletePort(AMachine: TatVirtualMachine);
    procedure __DeletePortA(AMachine: TatVirtualMachine);
    procedure __DeletePortW(AMachine: TatVirtualMachine);
    procedure __AddPrinterConnection(AMachine: TatVirtualMachine);
    procedure __AddPrinterConnectionA(AMachine: TatVirtualMachine);
    procedure __AddPrinterConnectionW(AMachine: TatVirtualMachine);
    procedure __DeletePrinterConnection(AMachine: TatVirtualMachine);
    procedure __DeletePrinterConnectionA(AMachine: TatVirtualMachine);
    procedure __DeletePrinterConnectionW(AMachine: TatVirtualMachine);
    procedure __ConnectToPrinterDlg(AMachine: TatVirtualMachine);
    procedure __DeletePrintProvidor(AMachine: TatVirtualMachine);
    procedure __DeletePrintProvidorA(AMachine: TatVirtualMachine);
    procedure __DeletePrintProvidorW(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _PRINTER_INFO_1AWrapper = class(TatRecordWrapper)
  private
    FFlags: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_1A);
    function ObjToRec: _PRINTER_INFO_1A;
  published
    property Flags: DWORD read FFlags write FFlags;
  end;
  
  _PRINTER_INFO_1WWrapper = class(TatRecordWrapper)
  private
    FFlags: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_1W);
    function ObjToRec: _PRINTER_INFO_1W;
  published
    property Flags: DWORD read FFlags write FFlags;
  end;
  
  _PRINTER_INFO_2AWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
    FPriority: DWORD;
    FDefaultPriority: DWORD;
    FStartTime: DWORD;
    FUntilTime: DWORD;
    FStatus: DWORD;
    FcJobs: DWORD;
    FAveragePPM: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_2A);
    function ObjToRec: _PRINTER_INFO_2A;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
    property Priority: DWORD read FPriority write FPriority;
    property DefaultPriority: DWORD read FDefaultPriority write FDefaultPriority;
    property StartTime: DWORD read FStartTime write FStartTime;
    property UntilTime: DWORD read FUntilTime write FUntilTime;
    property Status: DWORD read FStatus write FStatus;
    property cJobs: DWORD read FcJobs write FcJobs;
    property AveragePPM: DWORD read FAveragePPM write FAveragePPM;
  end;
  
  _PRINTER_INFO_2WWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
    FPriority: DWORD;
    FDefaultPriority: DWORD;
    FStartTime: DWORD;
    FUntilTime: DWORD;
    FStatus: DWORD;
    FcJobs: DWORD;
    FAveragePPM: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_2W);
    function ObjToRec: _PRINTER_INFO_2W;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
    property Priority: DWORD read FPriority write FPriority;
    property DefaultPriority: DWORD read FDefaultPriority write FDefaultPriority;
    property StartTime: DWORD read FStartTime write FStartTime;
    property UntilTime: DWORD read FUntilTime write FUntilTime;
    property Status: DWORD read FStatus write FStatus;
    property cJobs: DWORD read FcJobs write FcJobs;
    property AveragePPM: DWORD read FAveragePPM write FAveragePPM;
  end;
  
  _PRINTER_INFO_3Wrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PRINTER_INFO_3);
    function ObjToRec: _PRINTER_INFO_3;
  published
  end;
  
  _PRINTER_INFO_4AWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_4A);
    function ObjToRec: _PRINTER_INFO_4A;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
  end;
  
  _PRINTER_INFO_4WWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_4W);
    function ObjToRec: _PRINTER_INFO_4W;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
  end;
  
  _PRINTER_INFO_5AWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
    FDeviceNotSelectedTimeout: DWORD;
    FTransmissionRetryTimeout: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_5A);
    function ObjToRec: _PRINTER_INFO_5A;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
    property DeviceNotSelectedTimeout: DWORD read FDeviceNotSelectedTimeout write FDeviceNotSelectedTimeout;
    property TransmissionRetryTimeout: DWORD read FTransmissionRetryTimeout write FTransmissionRetryTimeout;
  end;
  
  _PRINTER_INFO_5WWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
    FDeviceNotSelectedTimeout: DWORD;
    FTransmissionRetryTimeout: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_5W);
    function ObjToRec: _PRINTER_INFO_5W;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
    property DeviceNotSelectedTimeout: DWORD read FDeviceNotSelectedTimeout write FDeviceNotSelectedTimeout;
    property TransmissionRetryTimeout: DWORD read FTransmissionRetryTimeout write FTransmissionRetryTimeout;
  end;
  
  _PRINTER_INFO_6Wrapper = class(TatRecordWrapper)
  private
    FdwStatus: DWORD;
  public
    constructor Create(ARecord: _PRINTER_INFO_6);
    function ObjToRec: _PRINTER_INFO_6;
  published
    property dwStatus: DWORD read FdwStatus write FdwStatus;
  end;
  
  _JOB_INFO_1AWrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
    FStatus: DWORD;
    FPriority: DWORD;
    FPosition: DWORD;
    FTotalPages: DWORD;
    FPagesPrinted: DWORD;
  public
    constructor Create(ARecord: _JOB_INFO_1A);
    function ObjToRec: _JOB_INFO_1A;
  published
    property JobId: DWORD read FJobId write FJobId;
    property Status: DWORD read FStatus write FStatus;
    property Priority: DWORD read FPriority write FPriority;
    property Position: DWORD read FPosition write FPosition;
    property TotalPages: DWORD read FTotalPages write FTotalPages;
    property PagesPrinted: DWORD read FPagesPrinted write FPagesPrinted;
  end;
  
  _JOB_INFO_1WWrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
    FStatus: DWORD;
    FPriority: DWORD;
    FPosition: DWORD;
    FTotalPages: DWORD;
    FPagesPrinted: DWORD;
  public
    constructor Create(ARecord: _JOB_INFO_1W);
    function ObjToRec: _JOB_INFO_1W;
  published
    property JobId: DWORD read FJobId write FJobId;
    property Status: DWORD read FStatus write FStatus;
    property Priority: DWORD read FPriority write FPriority;
    property Position: DWORD read FPosition write FPosition;
    property TotalPages: DWORD read FTotalPages write FTotalPages;
    property PagesPrinted: DWORD read FPagesPrinted write FPagesPrinted;
  end;
  
  _JOB_INFO_2AWrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
    FStatus: DWORD;
    FPriority: DWORD;
    FPosition: DWORD;
    FStartTime: DWORD;
    FUntilTime: DWORD;
    FTotalPages: DWORD;
    FSize: DWORD;
    FTime: DWORD;
    FPagesPrinted: DWORD;
  public
    constructor Create(ARecord: _JOB_INFO_2A);
    function ObjToRec: _JOB_INFO_2A;
  published
    property JobId: DWORD read FJobId write FJobId;
    property Status: DWORD read FStatus write FStatus;
    property Priority: DWORD read FPriority write FPriority;
    property Position: DWORD read FPosition write FPosition;
    property StartTime: DWORD read FStartTime write FStartTime;
    property UntilTime: DWORD read FUntilTime write FUntilTime;
    property TotalPages: DWORD read FTotalPages write FTotalPages;
    property Size: DWORD read FSize write FSize;
    property Time: DWORD read FTime write FTime;
    property PagesPrinted: DWORD read FPagesPrinted write FPagesPrinted;
  end;
  
  _JOB_INFO_2WWrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
    FStatus: DWORD;
    FPriority: DWORD;
    FPosition: DWORD;
    FStartTime: DWORD;
    FUntilTime: DWORD;
    FTotalPages: DWORD;
    FSize: DWORD;
    FTime: DWORD;
    FPagesPrinted: DWORD;
  public
    constructor Create(ARecord: _JOB_INFO_2W);
    function ObjToRec: _JOB_INFO_2W;
  published
    property JobId: DWORD read FJobId write FJobId;
    property Status: DWORD read FStatus write FStatus;
    property Priority: DWORD read FPriority write FPriority;
    property Position: DWORD read FPosition write FPosition;
    property StartTime: DWORD read FStartTime write FStartTime;
    property UntilTime: DWORD read FUntilTime write FUntilTime;
    property TotalPages: DWORD read FTotalPages write FTotalPages;
    property Size: DWORD read FSize write FSize;
    property Time: DWORD read FTime write FTime;
    property PagesPrinted: DWORD read FPagesPrinted write FPagesPrinted;
  end;
  
  _JOB_INFO_3Wrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
    FNextJobId: DWORD;
    FReserved: DWORD;
  public
    constructor Create(ARecord: _JOB_INFO_3);
    function ObjToRec: _JOB_INFO_3;
  published
    property JobId: DWORD read FJobId write FJobId;
    property NextJobId: DWORD read FNextJobId write FNextJobId;
    property Reserved: DWORD read FReserved write FReserved;
  end;
  
  _ADDJOB_INFO_1AWrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
  public
    constructor Create(ARecord: _ADDJOB_INFO_1A);
    function ObjToRec: _ADDJOB_INFO_1A;
  published
    property JobId: DWORD read FJobId write FJobId;
  end;
  
  _ADDJOB_INFO_1WWrapper = class(TatRecordWrapper)
  private
    FJobId: DWORD;
  public
    constructor Create(ARecord: _ADDJOB_INFO_1W);
    function ObjToRec: _ADDJOB_INFO_1W;
  published
    property JobId: DWORD read FJobId write FJobId;
  end;
  
  _DRIVER_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _DRIVER_INFO_1A);
    function ObjToRec: _DRIVER_INFO_1A;
  published
  end;
  
  _DRIVER_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _DRIVER_INFO_1W);
    function ObjToRec: _DRIVER_INFO_1W;
  published
  end;
  
  _DRIVER_INFO_2AWrapper = class(TatRecordWrapper)
  private
    FcVersion: DWORD;
  public
    constructor Create(ARecord: _DRIVER_INFO_2A);
    function ObjToRec: _DRIVER_INFO_2A;
  published
    property cVersion: DWORD read FcVersion write FcVersion;
  end;
  
  _DRIVER_INFO_2WWrapper = class(TatRecordWrapper)
  private
    FcVersion: DWORD;
  public
    constructor Create(ARecord: _DRIVER_INFO_2W);
    function ObjToRec: _DRIVER_INFO_2W;
  published
    property cVersion: DWORD read FcVersion write FcVersion;
  end;
  
  _DRIVER_INFO_3AWrapper = class(TatRecordWrapper)
  private
    FcVersion: DWORD;
  public
    constructor Create(ARecord: _DRIVER_INFO_3A);
    function ObjToRec: _DRIVER_INFO_3A;
  published
    property cVersion: DWORD read FcVersion write FcVersion;
  end;
  
  _DRIVER_INFO_3WWrapper = class(TatRecordWrapper)
  private
    FcVersion: DWORD;
  public
    constructor Create(ARecord: _DRIVER_INFO_3W);
    function ObjToRec: _DRIVER_INFO_3W;
  published
    property cVersion: DWORD read FcVersion write FcVersion;
  end;
  
  _DOC_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _DOC_INFO_1A);
    function ObjToRec: _DOC_INFO_1A;
  published
  end;
  
  _DOC_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _DOC_INFO_1W);
    function ObjToRec: _DOC_INFO_1W;
  published
  end;
  
  _FORM_INFO_1AWrapper = class(TatRecordWrapper)
  private
    FFlags: DWORD;
  public
    constructor Create(ARecord: _FORM_INFO_1A);
    function ObjToRec: _FORM_INFO_1A;
  published
    property Flags: DWORD read FFlags write FFlags;
  end;
  
  _FORM_INFO_1WWrapper = class(TatRecordWrapper)
  private
    FFlags: DWORD;
  public
    constructor Create(ARecord: _FORM_INFO_1W);
    function ObjToRec: _FORM_INFO_1W;
  published
    property Flags: DWORD read FFlags write FFlags;
  end;
  
  _DOC_INFO_2AWrapper = class(TatRecordWrapper)
  private
    FdwMode: DWORD;
    FJobId: DWORD;
  public
    constructor Create(ARecord: _DOC_INFO_2A);
    function ObjToRec: _DOC_INFO_2A;
  published
    property dwMode: DWORD read FdwMode write FdwMode;
    property JobId: DWORD read FJobId write FJobId;
  end;
  
  _DOC_INFO_2WWrapper = class(TatRecordWrapper)
  private
    FdwMode: DWORD;
    FJobId: DWORD;
  public
    constructor Create(ARecord: _DOC_INFO_2W);
    function ObjToRec: _DOC_INFO_2W;
  published
    property dwMode: DWORD read FdwMode write FdwMode;
    property JobId: DWORD read FJobId write FJobId;
  end;
  
  _PRINTPROCESSOR_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PRINTPROCESSOR_INFO_1A);
    function ObjToRec: _PRINTPROCESSOR_INFO_1A;
  published
  end;
  
  _PRINTPROCESSOR_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PRINTPROCESSOR_INFO_1W);
    function ObjToRec: _PRINTPROCESSOR_INFO_1W;
  published
  end;
  
  _PORT_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PORT_INFO_1A);
    function ObjToRec: _PORT_INFO_1A;
  published
  end;
  
  _PORT_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PORT_INFO_1W);
    function ObjToRec: _PORT_INFO_1W;
  published
  end;
  
  _PORT_INFO_2AWrapper = class(TatRecordWrapper)
  private
    FfPortType: DWORD;
    FReserved: DWORD;
  public
    constructor Create(ARecord: _PORT_INFO_2A);
    function ObjToRec: _PORT_INFO_2A;
  published
    property fPortType: DWORD read FfPortType write FfPortType;
    property Reserved: DWORD read FReserved write FReserved;
  end;
  
  _PORT_INFO_2WWrapper = class(TatRecordWrapper)
  private
    FfPortType: DWORD;
    FReserved: DWORD;
  public
    constructor Create(ARecord: _PORT_INFO_2W);
    function ObjToRec: _PORT_INFO_2W;
  published
    property fPortType: DWORD read FfPortType write FfPortType;
    property Reserved: DWORD read FReserved write FReserved;
  end;
  
  _PORT_INFO_3AWrapper = class(TatRecordWrapper)
  private
    FdwStatus: DWORD;
    FdwSeverity: DWORD;
  public
    constructor Create(ARecord: _PORT_INFO_3A);
    function ObjToRec: _PORT_INFO_3A;
  published
    property dwStatus: DWORD read FdwStatus write FdwStatus;
    property dwSeverity: DWORD read FdwSeverity write FdwSeverity;
  end;
  
  _PORT_INFO_3WWrapper = class(TatRecordWrapper)
  private
    FdwStatus: DWORD;
    FdwSeverity: DWORD;
  public
    constructor Create(ARecord: _PORT_INFO_3W);
    function ObjToRec: _PORT_INFO_3W;
  published
    property dwStatus: DWORD read FdwStatus write FdwStatus;
    property dwSeverity: DWORD read FdwSeverity write FdwSeverity;
  end;
  
  _MONITOR_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MONITOR_INFO_1A);
    function ObjToRec: _MONITOR_INFO_1A;
  published
  end;
  
  _MONITOR_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MONITOR_INFO_1W);
    function ObjToRec: _MONITOR_INFO_1W;
  published
  end;
  
  _MONITOR_INFO_2AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MONITOR_INFO_2A);
    function ObjToRec: _MONITOR_INFO_2A;
  published
  end;
  
  _MONITOR_INFO_2WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MONITOR_INFO_2W);
    function ObjToRec: _MONITOR_INFO_2W;
  published
  end;
  
  _DATATYPES_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _DATATYPES_INFO_1A);
    function ObjToRec: _DATATYPES_INFO_1A;
  published
  end;
  
  _DATATYPES_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _DATATYPES_INFO_1W);
    function ObjToRec: _DATATYPES_INFO_1W;
  published
  end;
  
  _PRINTER_DEFAULTSAWrapper = class(TatRecordWrapper)
  private
    FDesiredAccess: ACCESS_MASK;
  public
    constructor Create(ARecord: _PRINTER_DEFAULTSA);
    function ObjToRec: _PRINTER_DEFAULTSA;
  published
    property DesiredAccess: ACCESS_MASK read FDesiredAccess write FDesiredAccess;
  end;
  
  _PRINTER_DEFAULTSWWrapper = class(TatRecordWrapper)
  private
    FDesiredAccess: ACCESS_MASK;
  public
    constructor Create(ARecord: _PRINTER_DEFAULTSW);
    function ObjToRec: _PRINTER_DEFAULTSW;
  published
    property DesiredAccess: ACCESS_MASK read FDesiredAccess write FDesiredAccess;
  end;
  
  _PRINTER_NOTIFY_OPTIONS_TYPEWrapper = class(TatRecordWrapper)
  private
    FwType: Word;
    FReserved0: Word;
    FReserved1: DWORD;
    FReserved2: DWORD;
    FCount: DWORD;
  public
    constructor Create(ARecord: _PRINTER_NOTIFY_OPTIONS_TYPE);
    function ObjToRec: _PRINTER_NOTIFY_OPTIONS_TYPE;
  published
    property wType: Word read FwType write FwType;
    property Reserved0: Word read FReserved0 write FReserved0;
    property Reserved1: DWORD read FReserved1 write FReserved1;
    property Reserved2: DWORD read FReserved2 write FReserved2;
    property Count: DWORD read FCount write FCount;
  end;
  
  _PRINTER_NOTIFY_OPTIONSWrapper = class(TatRecordWrapper)
  private
    FVersion: DWORD;
    FFlags: DWORD;
    FCount: DWORD;
  public
    constructor Create(ARecord: _PRINTER_NOTIFY_OPTIONS);
    function ObjToRec: _PRINTER_NOTIFY_OPTIONS;
  published
    property Version: DWORD read FVersion write FVersion;
    property Flags: DWORD read FFlags write FFlags;
    property Count: DWORD read FCount write FCount;
  end;
  
  _PRINTER_NOTIFY_INFO_DATAWrapper = class(TatRecordWrapper)
  private
    FwType: Word;
    FField: Word;
    FReserved: DWORD;
    FId: DWORD;
  public
    constructor Create(ARecord: _PRINTER_NOTIFY_INFO_DATA);
    function ObjToRec: _PRINTER_NOTIFY_INFO_DATA;
  published
    property wType: Word read FwType write FwType;
    property Field: Word read FField write FField;
    property Reserved: DWORD read FReserved write FReserved;
    property Id: DWORD read FId write FId;
  end;
  
  _PRINTER_NOTIFY_INFOWrapper = class(TatRecordWrapper)
  private
    FVersion: DWORD;
    FFlags: DWORD;
    FCount: DWORD;
  public
    constructor Create(ARecord: _PRINTER_NOTIFY_INFO);
    function ObjToRec: _PRINTER_NOTIFY_INFO;
  published
    property Version: DWORD read FVersion write FVersion;
    property Flags: DWORD read FFlags write FFlags;
    property Count: DWORD read FCount write FCount;
  end;
  
  _PROVIDOR_INFO_1AWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PROVIDOR_INFO_1A);
    function ObjToRec: _PROVIDOR_INFO_1A;
  published
  end;
  
  _PROVIDOR_INFO_1WWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PROVIDOR_INFO_1W);
    function ObjToRec: _PROVIDOR_INFO_1W;
  published
  end;
  

implementation

constructor _PRINTER_INFO_1AWrapper.Create(ARecord: _PRINTER_INFO_1A);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function _PRINTER_INFO_1AWrapper.ObjToRec: _PRINTER_INFO_1A;
begin
  result.Flags := FFlags;
end;

constructor _PRINTER_INFO_1WWrapper.Create(ARecord: _PRINTER_INFO_1W);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function _PRINTER_INFO_1WWrapper.ObjToRec: _PRINTER_INFO_1W;
begin
  result.Flags := FFlags;
end;

constructor _PRINTER_INFO_2AWrapper.Create(ARecord: _PRINTER_INFO_2A);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
  FPriority := ARecord.Priority;
  FDefaultPriority := ARecord.DefaultPriority;
  FStartTime := ARecord.StartTime;
  FUntilTime := ARecord.UntilTime;
  FStatus := ARecord.Status;
  FcJobs := ARecord.cJobs;
  FAveragePPM := ARecord.AveragePPM;
end;

function _PRINTER_INFO_2AWrapper.ObjToRec: _PRINTER_INFO_2A;
begin
  result.Attributes := FAttributes;
  result.Priority := FPriority;
  result.DefaultPriority := FDefaultPriority;
  result.StartTime := FStartTime;
  result.UntilTime := FUntilTime;
  result.Status := FStatus;
  result.cJobs := FcJobs;
  result.AveragePPM := FAveragePPM;
end;

constructor _PRINTER_INFO_2WWrapper.Create(ARecord: _PRINTER_INFO_2W);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
  FPriority := ARecord.Priority;
  FDefaultPriority := ARecord.DefaultPriority;
  FStartTime := ARecord.StartTime;
  FUntilTime := ARecord.UntilTime;
  FStatus := ARecord.Status;
  FcJobs := ARecord.cJobs;
  FAveragePPM := ARecord.AveragePPM;
end;

function _PRINTER_INFO_2WWrapper.ObjToRec: _PRINTER_INFO_2W;
begin
  result.Attributes := FAttributes;
  result.Priority := FPriority;
  result.DefaultPriority := FDefaultPriority;
  result.StartTime := FStartTime;
  result.UntilTime := FUntilTime;
  result.Status := FStatus;
  result.cJobs := FcJobs;
  result.AveragePPM := FAveragePPM;
end;

constructor _PRINTER_INFO_3Wrapper.Create(ARecord: _PRINTER_INFO_3);
begin
  inherited Create;
end;

function _PRINTER_INFO_3Wrapper.ObjToRec: _PRINTER_INFO_3;
begin
end;

constructor _PRINTER_INFO_4AWrapper.Create(ARecord: _PRINTER_INFO_4A);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
end;

function _PRINTER_INFO_4AWrapper.ObjToRec: _PRINTER_INFO_4A;
begin
  result.Attributes := FAttributes;
end;

constructor _PRINTER_INFO_4WWrapper.Create(ARecord: _PRINTER_INFO_4W);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
end;

function _PRINTER_INFO_4WWrapper.ObjToRec: _PRINTER_INFO_4W;
begin
  result.Attributes := FAttributes;
end;

constructor _PRINTER_INFO_5AWrapper.Create(ARecord: _PRINTER_INFO_5A);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
  FDeviceNotSelectedTimeout := ARecord.DeviceNotSelectedTimeout;
  FTransmissionRetryTimeout := ARecord.TransmissionRetryTimeout;
end;

function _PRINTER_INFO_5AWrapper.ObjToRec: _PRINTER_INFO_5A;
begin
  result.Attributes := FAttributes;
  result.DeviceNotSelectedTimeout := FDeviceNotSelectedTimeout;
  result.TransmissionRetryTimeout := FTransmissionRetryTimeout;
end;

constructor _PRINTER_INFO_5WWrapper.Create(ARecord: _PRINTER_INFO_5W);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
  FDeviceNotSelectedTimeout := ARecord.DeviceNotSelectedTimeout;
  FTransmissionRetryTimeout := ARecord.TransmissionRetryTimeout;
end;

function _PRINTER_INFO_5WWrapper.ObjToRec: _PRINTER_INFO_5W;
begin
  result.Attributes := FAttributes;
  result.DeviceNotSelectedTimeout := FDeviceNotSelectedTimeout;
  result.TransmissionRetryTimeout := FTransmissionRetryTimeout;
end;

constructor _PRINTER_INFO_6Wrapper.Create(ARecord: _PRINTER_INFO_6);
begin
  inherited Create;
  FdwStatus := ARecord.dwStatus;
end;

function _PRINTER_INFO_6Wrapper.ObjToRec: _PRINTER_INFO_6;
begin
  result.dwStatus := FdwStatus;
end;

constructor _JOB_INFO_1AWrapper.Create(ARecord: _JOB_INFO_1A);
begin
  inherited Create;
  FJobId := ARecord.JobId;
  FStatus := ARecord.Status;
  FPriority := ARecord.Priority;
  FPosition := ARecord.Position;
  FTotalPages := ARecord.TotalPages;
  FPagesPrinted := ARecord.PagesPrinted;
end;

function _JOB_INFO_1AWrapper.ObjToRec: _JOB_INFO_1A;
begin
  result.JobId := FJobId;
  result.Status := FStatus;
  result.Priority := FPriority;
  result.Position := FPosition;
  result.TotalPages := FTotalPages;
  result.PagesPrinted := FPagesPrinted;
end;

constructor _JOB_INFO_1WWrapper.Create(ARecord: _JOB_INFO_1W);
begin
  inherited Create;
  FJobId := ARecord.JobId;
  FStatus := ARecord.Status;
  FPriority := ARecord.Priority;
  FPosition := ARecord.Position;
  FTotalPages := ARecord.TotalPages;
  FPagesPrinted := ARecord.PagesPrinted;
end;

function _JOB_INFO_1WWrapper.ObjToRec: _JOB_INFO_1W;
begin
  result.JobId := FJobId;
  result.Status := FStatus;
  result.Priority := FPriority;
  result.Position := FPosition;
  result.TotalPages := FTotalPages;
  result.PagesPrinted := FPagesPrinted;
end;

constructor _JOB_INFO_2AWrapper.Create(ARecord: _JOB_INFO_2A);
begin
  inherited Create;
  FJobId := ARecord.JobId;
  FStatus := ARecord.Status;
  FPriority := ARecord.Priority;
  FPosition := ARecord.Position;
  FStartTime := ARecord.StartTime;
  FUntilTime := ARecord.UntilTime;
  FTotalPages := ARecord.TotalPages;
  FSize := ARecord.Size;
  FTime := ARecord.Time;
  FPagesPrinted := ARecord.PagesPrinted;
end;

function _JOB_INFO_2AWrapper.ObjToRec: _JOB_INFO_2A;
begin
  result.JobId := FJobId;
  result.Status := FStatus;
  result.Priority := FPriority;
  result.Position := FPosition;
  result.StartTime := FStartTime;
  result.UntilTime := FUntilTime;
  result.TotalPages := FTotalPages;
  result.Size := FSize;
  result.Time := FTime;
  result.PagesPrinted := FPagesPrinted;
end;

constructor _JOB_INFO_2WWrapper.Create(ARecord: _JOB_INFO_2W);
begin
  inherited Create;
  FJobId := ARecord.JobId;
  FStatus := ARecord.Status;
  FPriority := ARecord.Priority;
  FPosition := ARecord.Position;
  FStartTime := ARecord.StartTime;
  FUntilTime := ARecord.UntilTime;
  FTotalPages := ARecord.TotalPages;
  FSize := ARecord.Size;
  FTime := ARecord.Time;
  FPagesPrinted := ARecord.PagesPrinted;
end;

function _JOB_INFO_2WWrapper.ObjToRec: _JOB_INFO_2W;
begin
  result.JobId := FJobId;
  result.Status := FStatus;
  result.Priority := FPriority;
  result.Position := FPosition;
  result.StartTime := FStartTime;
  result.UntilTime := FUntilTime;
  result.TotalPages := FTotalPages;
  result.Size := FSize;
  result.Time := FTime;
  result.PagesPrinted := FPagesPrinted;
end;

constructor _JOB_INFO_3Wrapper.Create(ARecord: _JOB_INFO_3);
begin
  inherited Create;
  FJobId := ARecord.JobId;
  FNextJobId := ARecord.NextJobId;
  FReserved := ARecord.Reserved;
end;

function _JOB_INFO_3Wrapper.ObjToRec: _JOB_INFO_3;
begin
  result.JobId := FJobId;
  result.NextJobId := FNextJobId;
  result.Reserved := FReserved;
end;

constructor _ADDJOB_INFO_1AWrapper.Create(ARecord: _ADDJOB_INFO_1A);
begin
  inherited Create;
  FJobId := ARecord.JobId;
end;

function _ADDJOB_INFO_1AWrapper.ObjToRec: _ADDJOB_INFO_1A;
begin
  result.JobId := FJobId;
end;

constructor _ADDJOB_INFO_1WWrapper.Create(ARecord: _ADDJOB_INFO_1W);
begin
  inherited Create;
  FJobId := ARecord.JobId;
end;

function _ADDJOB_INFO_1WWrapper.ObjToRec: _ADDJOB_INFO_1W;
begin
  result.JobId := FJobId;
end;

constructor _DRIVER_INFO_1AWrapper.Create(ARecord: _DRIVER_INFO_1A);
begin
  inherited Create;
end;

function _DRIVER_INFO_1AWrapper.ObjToRec: _DRIVER_INFO_1A;
begin
end;

constructor _DRIVER_INFO_1WWrapper.Create(ARecord: _DRIVER_INFO_1W);
begin
  inherited Create;
end;

function _DRIVER_INFO_1WWrapper.ObjToRec: _DRIVER_INFO_1W;
begin
end;

constructor _DRIVER_INFO_2AWrapper.Create(ARecord: _DRIVER_INFO_2A);
begin
  inherited Create;
  FcVersion := ARecord.cVersion;
end;

function _DRIVER_INFO_2AWrapper.ObjToRec: _DRIVER_INFO_2A;
begin
  result.cVersion := FcVersion;
end;

constructor _DRIVER_INFO_2WWrapper.Create(ARecord: _DRIVER_INFO_2W);
begin
  inherited Create;
  FcVersion := ARecord.cVersion;
end;

function _DRIVER_INFO_2WWrapper.ObjToRec: _DRIVER_INFO_2W;
begin
  result.cVersion := FcVersion;
end;

constructor _DRIVER_INFO_3AWrapper.Create(ARecord: _DRIVER_INFO_3A);
begin
  inherited Create;
  FcVersion := ARecord.cVersion;
end;

function _DRIVER_INFO_3AWrapper.ObjToRec: _DRIVER_INFO_3A;
begin
  result.cVersion := FcVersion;
end;

constructor _DRIVER_INFO_3WWrapper.Create(ARecord: _DRIVER_INFO_3W);
begin
  inherited Create;
  FcVersion := ARecord.cVersion;
end;

function _DRIVER_INFO_3WWrapper.ObjToRec: _DRIVER_INFO_3W;
begin
  result.cVersion := FcVersion;
end;

constructor _DOC_INFO_1AWrapper.Create(ARecord: _DOC_INFO_1A);
begin
  inherited Create;
end;

function _DOC_INFO_1AWrapper.ObjToRec: _DOC_INFO_1A;
begin
end;

constructor _DOC_INFO_1WWrapper.Create(ARecord: _DOC_INFO_1W);
begin
  inherited Create;
end;

function _DOC_INFO_1WWrapper.ObjToRec: _DOC_INFO_1W;
begin
end;

constructor _FORM_INFO_1AWrapper.Create(ARecord: _FORM_INFO_1A);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function _FORM_INFO_1AWrapper.ObjToRec: _FORM_INFO_1A;
begin
  result.Flags := FFlags;
end;

constructor _FORM_INFO_1WWrapper.Create(ARecord: _FORM_INFO_1W);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function _FORM_INFO_1WWrapper.ObjToRec: _FORM_INFO_1W;
begin
  result.Flags := FFlags;
end;

constructor _DOC_INFO_2AWrapper.Create(ARecord: _DOC_INFO_2A);
begin
  inherited Create;
  FdwMode := ARecord.dwMode;
  FJobId := ARecord.JobId;
end;

function _DOC_INFO_2AWrapper.ObjToRec: _DOC_INFO_2A;
begin
  result.dwMode := FdwMode;
  result.JobId := FJobId;
end;

constructor _DOC_INFO_2WWrapper.Create(ARecord: _DOC_INFO_2W);
begin
  inherited Create;
  FdwMode := ARecord.dwMode;
  FJobId := ARecord.JobId;
end;

function _DOC_INFO_2WWrapper.ObjToRec: _DOC_INFO_2W;
begin
  result.dwMode := FdwMode;
  result.JobId := FJobId;
end;

constructor _PRINTPROCESSOR_INFO_1AWrapper.Create(ARecord: _PRINTPROCESSOR_INFO_1A);
begin
  inherited Create;
end;

function _PRINTPROCESSOR_INFO_1AWrapper.ObjToRec: _PRINTPROCESSOR_INFO_1A;
begin
end;

constructor _PRINTPROCESSOR_INFO_1WWrapper.Create(ARecord: _PRINTPROCESSOR_INFO_1W);
begin
  inherited Create;
end;

function _PRINTPROCESSOR_INFO_1WWrapper.ObjToRec: _PRINTPROCESSOR_INFO_1W;
begin
end;

constructor _PORT_INFO_1AWrapper.Create(ARecord: _PORT_INFO_1A);
begin
  inherited Create;
end;

function _PORT_INFO_1AWrapper.ObjToRec: _PORT_INFO_1A;
begin
end;

constructor _PORT_INFO_1WWrapper.Create(ARecord: _PORT_INFO_1W);
begin
  inherited Create;
end;

function _PORT_INFO_1WWrapper.ObjToRec: _PORT_INFO_1W;
begin
end;

constructor _PORT_INFO_2AWrapper.Create(ARecord: _PORT_INFO_2A);
begin
  inherited Create;
  FfPortType := ARecord.fPortType;
  FReserved := ARecord.Reserved;
end;

function _PORT_INFO_2AWrapper.ObjToRec: _PORT_INFO_2A;
begin
  result.fPortType := FfPortType;
  result.Reserved := FReserved;
end;

constructor _PORT_INFO_2WWrapper.Create(ARecord: _PORT_INFO_2W);
begin
  inherited Create;
  FfPortType := ARecord.fPortType;
  FReserved := ARecord.Reserved;
end;

function _PORT_INFO_2WWrapper.ObjToRec: _PORT_INFO_2W;
begin
  result.fPortType := FfPortType;
  result.Reserved := FReserved;
end;

constructor _PORT_INFO_3AWrapper.Create(ARecord: _PORT_INFO_3A);
begin
  inherited Create;
  FdwStatus := ARecord.dwStatus;
  FdwSeverity := ARecord.dwSeverity;
end;

function _PORT_INFO_3AWrapper.ObjToRec: _PORT_INFO_3A;
begin
  result.dwStatus := FdwStatus;
  result.dwSeverity := FdwSeverity;
end;

constructor _PORT_INFO_3WWrapper.Create(ARecord: _PORT_INFO_3W);
begin
  inherited Create;
  FdwStatus := ARecord.dwStatus;
  FdwSeverity := ARecord.dwSeverity;
end;

function _PORT_INFO_3WWrapper.ObjToRec: _PORT_INFO_3W;
begin
  result.dwStatus := FdwStatus;
  result.dwSeverity := FdwSeverity;
end;

constructor _MONITOR_INFO_1AWrapper.Create(ARecord: _MONITOR_INFO_1A);
begin
  inherited Create;
end;

function _MONITOR_INFO_1AWrapper.ObjToRec: _MONITOR_INFO_1A;
begin
end;

constructor _MONITOR_INFO_1WWrapper.Create(ARecord: _MONITOR_INFO_1W);
begin
  inherited Create;
end;

function _MONITOR_INFO_1WWrapper.ObjToRec: _MONITOR_INFO_1W;
begin
end;

constructor _MONITOR_INFO_2AWrapper.Create(ARecord: _MONITOR_INFO_2A);
begin
  inherited Create;
end;

function _MONITOR_INFO_2AWrapper.ObjToRec: _MONITOR_INFO_2A;
begin
end;

constructor _MONITOR_INFO_2WWrapper.Create(ARecord: _MONITOR_INFO_2W);
begin
  inherited Create;
end;

function _MONITOR_INFO_2WWrapper.ObjToRec: _MONITOR_INFO_2W;
begin
end;

constructor _DATATYPES_INFO_1AWrapper.Create(ARecord: _DATATYPES_INFO_1A);
begin
  inherited Create;
end;

function _DATATYPES_INFO_1AWrapper.ObjToRec: _DATATYPES_INFO_1A;
begin
end;

constructor _DATATYPES_INFO_1WWrapper.Create(ARecord: _DATATYPES_INFO_1W);
begin
  inherited Create;
end;

function _DATATYPES_INFO_1WWrapper.ObjToRec: _DATATYPES_INFO_1W;
begin
end;

constructor _PRINTER_DEFAULTSAWrapper.Create(ARecord: _PRINTER_DEFAULTSA);
begin
  inherited Create;
  FDesiredAccess := ARecord.DesiredAccess;
end;

function _PRINTER_DEFAULTSAWrapper.ObjToRec: _PRINTER_DEFAULTSA;
begin
  result.DesiredAccess := FDesiredAccess;
end;

constructor _PRINTER_DEFAULTSWWrapper.Create(ARecord: _PRINTER_DEFAULTSW);
begin
  inherited Create;
  FDesiredAccess := ARecord.DesiredAccess;
end;

function _PRINTER_DEFAULTSWWrapper.ObjToRec: _PRINTER_DEFAULTSW;
begin
  result.DesiredAccess := FDesiredAccess;
end;

constructor _PRINTER_NOTIFY_OPTIONS_TYPEWrapper.Create(ARecord: _PRINTER_NOTIFY_OPTIONS_TYPE);
begin
  inherited Create;
  FwType := ARecord.wType;
  FReserved0 := ARecord.Reserved0;
  FReserved1 := ARecord.Reserved1;
  FReserved2 := ARecord.Reserved2;
  FCount := ARecord.Count;
end;

function _PRINTER_NOTIFY_OPTIONS_TYPEWrapper.ObjToRec: _PRINTER_NOTIFY_OPTIONS_TYPE;
begin
  result.wType := FwType;
  result.Reserved0 := FReserved0;
  result.Reserved1 := FReserved1;
  result.Reserved2 := FReserved2;
  result.Count := FCount;
end;

constructor _PRINTER_NOTIFY_OPTIONSWrapper.Create(ARecord: _PRINTER_NOTIFY_OPTIONS);
begin
  inherited Create;
  FVersion := ARecord.Version;
  FFlags := ARecord.Flags;
  FCount := ARecord.Count;
end;

function _PRINTER_NOTIFY_OPTIONSWrapper.ObjToRec: _PRINTER_NOTIFY_OPTIONS;
begin
  result.Version := FVersion;
  result.Flags := FFlags;
  result.Count := FCount;
end;

constructor _PRINTER_NOTIFY_INFO_DATAWrapper.Create(ARecord: _PRINTER_NOTIFY_INFO_DATA);
begin
  inherited Create;
  FwType := ARecord.wType;
  FField := ARecord.Field;
  FReserved := ARecord.Reserved;
  FId := ARecord.Id;
end;

function _PRINTER_NOTIFY_INFO_DATAWrapper.ObjToRec: _PRINTER_NOTIFY_INFO_DATA;
begin
  result.wType := FwType;
  result.Field := FField;
  result.Reserved := FReserved;
  result.Id := FId;
end;

constructor _PRINTER_NOTIFY_INFOWrapper.Create(ARecord: _PRINTER_NOTIFY_INFO);
begin
  inherited Create;
  FVersion := ARecord.Version;
  FFlags := ARecord.Flags;
  FCount := ARecord.Count;
end;

function _PRINTER_NOTIFY_INFOWrapper.ObjToRec: _PRINTER_NOTIFY_INFO;
begin
  result.Version := FVersion;
  result.Flags := FFlags;
  result.Count := FCount;
end;

constructor _PROVIDOR_INFO_1AWrapper.Create(ARecord: _PROVIDOR_INFO_1A);
begin
  inherited Create;
end;

function _PROVIDOR_INFO_1AWrapper.ObjToRec: _PROVIDOR_INFO_1A;
begin
end;

constructor _PROVIDOR_INFO_1WWrapper.Create(ARecord: _PROVIDOR_INFO_1W);
begin
  inherited Create;
end;

function _PROVIDOR_INFO_1WWrapper.ObjToRec: _PROVIDOR_INFO_1W;
begin
end;



procedure TatWinSpoolLibrary.__DeletePrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterDriver(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinterDriver(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterDriverA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinterDriverA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterDriverW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinterDriverW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPrintProcessor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPrintProcessor(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPrintProcessorA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPrintProcessorA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPrintProcessorW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPrintProcessorW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrintProcessor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrintProcessor(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrintProcessorA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrintProcessorA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrintProcessorW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrintProcessorW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__StartPagePrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.StartPagePrinter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__EndPagePrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.EndPagePrinter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AbortPrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AbortPrinter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__EndDocPrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.EndDocPrinter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__ScheduleJob(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.ScheduleJob(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__PrinterProperties(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.PrinterProperties(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DocumentProperties(AMachine: TatVirtualMachine);
  var
  Param4Rec: TObject;
  Param4: TDeviceMode;
  AResult: variant;
begin
  with AMachine do
  begin
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is _devicemodeAWrapper) then 
  Param4Rec := _devicemodeAWrapper.Create(Param4);
Param4 := _devicemodeAWrapper(Param4Rec).ObjToRec;
AResult := Integer(WinSpool.DocumentProperties(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),_devicemodeAWrapper(integer(GetInputArg(3))).ObjToRec,Param4,VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
    SetInputArg(4,integer(_devicemodeAWrapper.Create(Param4)));
  end;
end;

procedure TatWinSpoolLibrary.__DocumentPropertiesA(AMachine: TatVirtualMachine);
  var
  Param4Rec: TObject;
  Param4: TDeviceModeA;
  AResult: variant;
begin
  with AMachine do
  begin
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is _devicemodeAWrapper) then 
  Param4Rec := _devicemodeAWrapper.Create(Param4);
Param4 := _devicemodeAWrapper(Param4Rec).ObjToRec;
AResult := Integer(WinSpool.DocumentPropertiesA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),_devicemodeAWrapper(integer(GetInputArg(3))).ObjToRec,Param4,VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
    SetInputArg(4,integer(_devicemodeAWrapper.Create(Param4)));
  end;
end;

procedure TatWinSpoolLibrary.__DocumentPropertiesW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param4Rec: TObject;
  Param4: TDeviceModeW;
  AResult: variant;
begin
  with AMachine do
  begin
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is _devicemodeWWrapper) then 
  Param4Rec := _devicemodeWWrapper.Create(Param4);
Param4 := _devicemodeWWrapper(Param4Rec).ObjToRec;
AResult := Integer(WinSpool.DocumentPropertiesW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),_devicemodeWWrapper(integer(GetInputArg(3))).ObjToRec,Param4,VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
    SetInputArg(4,integer(_devicemodeWWrapper.Create(Param4)));
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.DeletePrinterData(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterDataA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.DeletePrinterDataA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterDataW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.DeletePrinterDataW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__WaitForPrinterChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.WaitForPrinterChange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__FindClosePrinterChangeNotification(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.FindClosePrinterChangeNotification(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__PrinterMessageBox(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.PrinterMessageBox(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),PChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__PrinterMessageBoxA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.PrinterMessageBoxA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),PChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__PrinterMessageBoxW(AMachine: TatVirtualMachine);
  var
  Param3Buf: array[0..127] of WideChar;
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.PrinterMessageBoxW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__ClosePrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.ClosePrinter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeleteForm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeleteForm(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeleteFormA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeleteFormA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeleteFormW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeleteFormW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeleteMonitor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeleteMonitor(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeleteMonitorA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeleteMonitorA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeleteMonitorW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeleteMonitorW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPort(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPortA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPortA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPortW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPortW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__ConfigurePort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.ConfigurePort(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__ConfigurePortA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.ConfigurePortA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__ConfigurePortW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.ConfigurePortW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePort(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePortA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePortA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePortW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePortW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPrinterConnection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPrinterConnection(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPrinterConnectionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPrinterConnectionA(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__AddPrinterConnectionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.AddPrinterConnectionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterConnection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinterConnection(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterConnectionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinterConnectionA(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrinterConnectionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrinterConnectionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__ConnectToPrinterDlg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSpool.ConnectToPrinterDlg(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrintProvidor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrintProvidor(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrintProvidorA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrintProvidorA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.__DeletePrintProvidorW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSpool.DeletePrintProvidorW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSpoolLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DeletePrinter',1,tkVariant,nil,__DeletePrinter,false,0);
    DefineMethod('DeletePrinterDriver',3,tkVariant,nil,__DeletePrinterDriver,false,0);
    DefineMethod('DeletePrinterDriverA',3,tkVariant,nil,__DeletePrinterDriverA,false,0);
    DefineMethod('DeletePrinterDriverW',3,tkVariant,nil,__DeletePrinterDriverW,false,0);
    DefineMethod('AddPrintProcessor',4,tkVariant,nil,__AddPrintProcessor,false,0);
    DefineMethod('AddPrintProcessorA',4,tkVariant,nil,__AddPrintProcessorA,false,0);
    DefineMethod('AddPrintProcessorW',4,tkVariant,nil,__AddPrintProcessorW,false,0);
    DefineMethod('DeletePrintProcessor',3,tkVariant,nil,__DeletePrintProcessor,false,0);
    DefineMethod('DeletePrintProcessorA',3,tkVariant,nil,__DeletePrintProcessorA,false,0);
    DefineMethod('DeletePrintProcessorW',3,tkVariant,nil,__DeletePrintProcessorW,false,0);
    DefineMethod('StartPagePrinter',1,tkVariant,nil,__StartPagePrinter,false,0);
    DefineMethod('EndPagePrinter',1,tkVariant,nil,__EndPagePrinter,false,0);
    DefineMethod('AbortPrinter',1,tkVariant,nil,__AbortPrinter,false,0);
    DefineMethod('EndDocPrinter',1,tkVariant,nil,__EndDocPrinter,false,0);
    DefineMethod('ScheduleJob',2,tkVariant,nil,__ScheduleJob,false,0);
    DefineMethod('PrinterProperties',2,tkVariant,nil,__PrinterProperties,false,0);
    DefineMethod('DocumentProperties',6,tkInteger,nil,__DocumentProperties,false,0).SetVarArgs([4]);
    DefineMethod('DocumentPropertiesA',6,tkInteger,nil,__DocumentPropertiesA,false,0).SetVarArgs([4]);
    DefineMethod('DocumentPropertiesW',6,tkInteger,nil,__DocumentPropertiesW,false,0).SetVarArgs([4]);
    DefineMethod('DeletePrinterData',2,tkInteger,nil,__DeletePrinterData,false,0);
    DefineMethod('DeletePrinterDataA',2,tkInteger,nil,__DeletePrinterDataA,false,0);
    DefineMethod('DeletePrinterDataW',2,tkInteger,nil,__DeletePrinterDataW,false,0);
    DefineMethod('WaitForPrinterChange',2,tkInteger,nil,__WaitForPrinterChange,false,0);
    DefineMethod('FindClosePrinterChangeNotification',1,tkVariant,nil,__FindClosePrinterChangeNotification,false,0);
    DefineMethod('PrinterMessageBox',6,tkInteger,nil,__PrinterMessageBox,false,0);
    DefineMethod('PrinterMessageBoxA',6,tkInteger,nil,__PrinterMessageBoxA,false,0);
    DefineMethod('PrinterMessageBoxW',6,tkInteger,nil,__PrinterMessageBoxW,false,0);
    DefineMethod('ClosePrinter',1,tkVariant,nil,__ClosePrinter,false,0);
    DefineMethod('DeleteForm',2,tkVariant,nil,__DeleteForm,false,0);
    DefineMethod('DeleteFormA',2,tkVariant,nil,__DeleteFormA,false,0);
    DefineMethod('DeleteFormW',2,tkVariant,nil,__DeleteFormW,false,0);
    DefineMethod('DeleteMonitor',3,tkVariant,nil,__DeleteMonitor,false,0);
    DefineMethod('DeleteMonitorA',3,tkVariant,nil,__DeleteMonitorA,false,0);
    DefineMethod('DeleteMonitorW',3,tkVariant,nil,__DeleteMonitorW,false,0);
    DefineMethod('AddPort',3,tkVariant,nil,__AddPort,false,0);
    DefineMethod('AddPortA',3,tkVariant,nil,__AddPortA,false,0);
    DefineMethod('AddPortW',3,tkVariant,nil,__AddPortW,false,0);
    DefineMethod('ConfigurePort',3,tkVariant,nil,__ConfigurePort,false,0);
    DefineMethod('ConfigurePortA',3,tkVariant,nil,__ConfigurePortA,false,0);
    DefineMethod('ConfigurePortW',3,tkVariant,nil,__ConfigurePortW,false,0);
    DefineMethod('DeletePort',3,tkVariant,nil,__DeletePort,false,0);
    DefineMethod('DeletePortA',3,tkVariant,nil,__DeletePortA,false,0);
    DefineMethod('DeletePortW',3,tkVariant,nil,__DeletePortW,false,0);
    DefineMethod('AddPrinterConnection',1,tkVariant,nil,__AddPrinterConnection,false,0);
    DefineMethod('AddPrinterConnectionA',1,tkVariant,nil,__AddPrinterConnectionA,false,0);
    DefineMethod('AddPrinterConnectionW',1,tkVariant,nil,__AddPrinterConnectionW,false,0);
    DefineMethod('DeletePrinterConnection',1,tkVariant,nil,__DeletePrinterConnection,false,0);
    DefineMethod('DeletePrinterConnectionA',1,tkVariant,nil,__DeletePrinterConnectionA,false,0);
    DefineMethod('DeletePrinterConnectionW',1,tkVariant,nil,__DeletePrinterConnectionW,false,0);
    DefineMethod('ConnectToPrinterDlg',2,tkInteger,nil,__ConnectToPrinterDlg,false,0);
    DefineMethod('DeletePrintProvidor',3,tkVariant,nil,__DeletePrintProvidor,false,0);
    DefineMethod('DeletePrintProvidorA',3,tkVariant,nil,__DeletePrintProvidorA,false,0);
    DefineMethod('DeletePrintProvidorW',3,tkVariant,nil,__DeletePrintProvidorW,false,0);
    AddConstant('PRINTER_CONTROL_PAUSE',PRINTER_CONTROL_PAUSE);
    AddConstant('PRINTER_CONTROL_RESUME',PRINTER_CONTROL_RESUME);
    AddConstant('PRINTER_CONTROL_PURGE',PRINTER_CONTROL_PURGE);
    AddConstant('PRINTER_CONTROL_SET_STATUS',PRINTER_CONTROL_SET_STATUS);
    AddConstant('PRINTER_STATUS_PAUSED',PRINTER_STATUS_PAUSED);
    AddConstant('PRINTER_STATUS_ERROR',PRINTER_STATUS_ERROR);
    AddConstant('PRINTER_STATUS_PENDING_DELETION',PRINTER_STATUS_PENDING_DELETION);
    AddConstant('PRINTER_STATUS_PAPER_JAM',PRINTER_STATUS_PAPER_JAM);
    AddConstant('PRINTER_STATUS_PAPER_OUT',PRINTER_STATUS_PAPER_OUT);
    AddConstant('PRINTER_STATUS_MANUAL_FEED',PRINTER_STATUS_MANUAL_FEED);
    AddConstant('PRINTER_STATUS_PAPER_PROBLEM',PRINTER_STATUS_PAPER_PROBLEM);
    AddConstant('PRINTER_STATUS_OFFLINE',PRINTER_STATUS_OFFLINE);
    AddConstant('PRINTER_STATUS_IO_ACTIVE',PRINTER_STATUS_IO_ACTIVE);
    AddConstant('PRINTER_STATUS_BUSY',PRINTER_STATUS_BUSY);
    AddConstant('PRINTER_STATUS_PRINTING',PRINTER_STATUS_PRINTING);
    AddConstant('PRINTER_STATUS_OUTPUT_BIN_FULL',PRINTER_STATUS_OUTPUT_BIN_FULL);
    AddConstant('PRINTER_STATUS_NOT_AVAILABLE',PRINTER_STATUS_NOT_AVAILABLE);
    AddConstant('PRINTER_STATUS_WAITING',PRINTER_STATUS_WAITING);
    AddConstant('PRINTER_STATUS_PROCESSING',PRINTER_STATUS_PROCESSING);
    AddConstant('PRINTER_STATUS_INITIALIZING',PRINTER_STATUS_INITIALIZING);
    AddConstant('PRINTER_STATUS_WARMING_UP',PRINTER_STATUS_WARMING_UP);
    AddConstant('PRINTER_STATUS_TONER_LOW',PRINTER_STATUS_TONER_LOW);
    AddConstant('PRINTER_STATUS_NO_TONER',PRINTER_STATUS_NO_TONER);
    AddConstant('PRINTER_STATUS_PAGE_PUNT',PRINTER_STATUS_PAGE_PUNT);
    AddConstant('PRINTER_STATUS_USER_INTERVENTION',PRINTER_STATUS_USER_INTERVENTION);
    AddConstant('PRINTER_STATUS_OUT_OF_MEMORY',PRINTER_STATUS_OUT_OF_MEMORY);
    AddConstant('PRINTER_STATUS_DOOR_OPEN',PRINTER_STATUS_DOOR_OPEN);
    AddConstant('PRINTER_STATUS_SERVER_UNKNOWN',PRINTER_STATUS_SERVER_UNKNOWN);
    AddConstant('PRINTER_STATUS_POWER_SAVE',PRINTER_STATUS_POWER_SAVE);
    AddConstant('PRINTER_ATTRIBUTE_QUEUED',PRINTER_ATTRIBUTE_QUEUED);
    AddConstant('PRINTER_ATTRIBUTE_DIRECT',PRINTER_ATTRIBUTE_DIRECT);
    AddConstant('PRINTER_ATTRIBUTE_DEFAULT',PRINTER_ATTRIBUTE_DEFAULT);
    AddConstant('PRINTER_ATTRIBUTE_SHARED',PRINTER_ATTRIBUTE_SHARED);
    AddConstant('PRINTER_ATTRIBUTE_NETWORK',PRINTER_ATTRIBUTE_NETWORK);
    AddConstant('PRINTER_ATTRIBUTE_HIDDEN',PRINTER_ATTRIBUTE_HIDDEN);
    AddConstant('PRINTER_ATTRIBUTE_LOCAL',PRINTER_ATTRIBUTE_LOCAL);
    AddConstant('PRINTER_ATTRIBUTE_ENABLE_DEVQ',PRINTER_ATTRIBUTE_ENABLE_DEVQ);
    AddConstant('PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS',PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS);
    AddConstant('PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST',PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST);
    AddConstant('PRINTER_ATTRIBUTE_WORK_OFFLINE',PRINTER_ATTRIBUTE_WORK_OFFLINE);
    AddConstant('PRINTER_ATTRIBUTE_ENABLE_BIDI',PRINTER_ATTRIBUTE_ENABLE_BIDI);
    AddConstant('PRINTER_ATTRIBUTE_RAW_ONLY',PRINTER_ATTRIBUTE_RAW_ONLY);
    AddConstant('NO_PRIORITY',NO_PRIORITY);
    AddConstant('MAX_PRIORITY',MAX_PRIORITY);
    AddConstant('MIN_PRIORITY',MIN_PRIORITY);
    AddConstant('DEF_PRIORITY',DEF_PRIORITY);
    AddConstant('JOB_CONTROL_PAUSE',JOB_CONTROL_PAUSE);
    AddConstant('JOB_CONTROL_RESUME',JOB_CONTROL_RESUME);
    AddConstant('JOB_CONTROL_CANCEL',JOB_CONTROL_CANCEL);
    AddConstant('JOB_CONTROL_RESTART',JOB_CONTROL_RESTART);
    AddConstant('JOB_CONTROL_DELETE',JOB_CONTROL_DELETE);
    AddConstant('JOB_CONTROL_SENT_TO_PRINTER',JOB_CONTROL_SENT_TO_PRINTER);
    AddConstant('JOB_CONTROL_LAST_PAGE_EJECTED',JOB_CONTROL_LAST_PAGE_EJECTED);
    AddConstant('JOB_STATUS_PAUSED',JOB_STATUS_PAUSED);
    AddConstant('JOB_STATUS_ERROR',JOB_STATUS_ERROR);
    AddConstant('JOB_STATUS_DELETING',JOB_STATUS_DELETING);
    AddConstant('JOB_STATUS_SPOOLING',JOB_STATUS_SPOOLING);
    AddConstant('JOB_STATUS_PRINTING',JOB_STATUS_PRINTING);
    AddConstant('JOB_STATUS_OFFLINE',JOB_STATUS_OFFLINE);
    AddConstant('JOB_STATUS_PAPEROUT',JOB_STATUS_PAPEROUT);
    AddConstant('JOB_STATUS_PRINTED',JOB_STATUS_PRINTED);
    AddConstant('JOB_STATUS_DELETED',JOB_STATUS_DELETED);
    AddConstant('JOB_STATUS_BLOCKED_DEVQ',JOB_STATUS_BLOCKED_DEVQ);
    AddConstant('JOB_STATUS_USER_INTERVENTION',JOB_STATUS_USER_INTERVENTION);
    AddConstant('JOB_STATUS_RESTART',JOB_STATUS_RESTART);
    AddConstant('JOB_POSITION_UNSPECIFIED',JOB_POSITION_UNSPECIFIED);
    AddConstant('DI_CHANNEL',DI_CHANNEL);
    AddConstant('DI_READ_SPOOL_JOB',DI_READ_SPOOL_JOB);
    AddConstant('FORM_USER',FORM_USER);
    AddConstant('FORM_BUILTIN',FORM_BUILTIN);
    AddConstant('FORM_PRINTER',FORM_PRINTER);
    AddConstant('PORT_TYPE_WRITE',PORT_TYPE_WRITE);
    AddConstant('PORT_TYPE_READ',PORT_TYPE_READ);
    AddConstant('PORT_TYPE_REDIRECTED',PORT_TYPE_REDIRECTED);
    AddConstant('PORT_TYPE_NET_ATTACHED',PORT_TYPE_NET_ATTACHED);
    AddConstant('PORT_STATUS_TYPE_ERROR',PORT_STATUS_TYPE_ERROR);
    AddConstant('PORT_STATUS_TYPE_WARNING',PORT_STATUS_TYPE_WARNING);
    AddConstant('PORT_STATUS_TYPE_INFO',PORT_STATUS_TYPE_INFO);
    AddConstant('PORT_STATUS_OFFLINE',PORT_STATUS_OFFLINE);
    AddConstant('PORT_STATUS_PAPER_JAM',PORT_STATUS_PAPER_JAM);
    AddConstant('PORT_STATUS_PAPER_OUT',PORT_STATUS_PAPER_OUT);
    AddConstant('PORT_STATUS_OUTPUT_BIN_FULL',PORT_STATUS_OUTPUT_BIN_FULL);
    AddConstant('PORT_STATUS_PAPER_PROBLEM',PORT_STATUS_PAPER_PROBLEM);
    AddConstant('PORT_STATUS_NO_TONER',PORT_STATUS_NO_TONER);
    AddConstant('PORT_STATUS_DOOR_OPEN',PORT_STATUS_DOOR_OPEN);
    AddConstant('PORT_STATUS_USER_INTERVENTION',PORT_STATUS_USER_INTERVENTION);
    AddConstant('PORT_STATUS_OUT_OF_MEMORY',PORT_STATUS_OUT_OF_MEMORY);
    AddConstant('PORT_STATUS_TONER_LOW',PORT_STATUS_TONER_LOW);
    AddConstant('PORT_STATUS_WARMING_UP',PORT_STATUS_WARMING_UP);
    AddConstant('PORT_STATUS_POWER_SAVE',PORT_STATUS_POWER_SAVE);
    AddConstant('PRINTER_ENUM_DEFAULT',PRINTER_ENUM_DEFAULT);
    AddConstant('PRINTER_ENUM_LOCAL',PRINTER_ENUM_LOCAL);
    AddConstant('PRINTER_ENUM_CONNECTIONS',PRINTER_ENUM_CONNECTIONS);
    AddConstant('PRINTER_ENUM_FAVORITE',PRINTER_ENUM_FAVORITE);
    AddConstant('PRINTER_ENUM_NAME',PRINTER_ENUM_NAME);
    AddConstant('PRINTER_ENUM_REMOTE',PRINTER_ENUM_REMOTE);
    AddConstant('PRINTER_ENUM_SHARED',PRINTER_ENUM_SHARED);
    AddConstant('PRINTER_ENUM_NETWORK',PRINTER_ENUM_NETWORK);
    AddConstant('PRINTER_ENUM_EXPAND',PRINTER_ENUM_EXPAND);
    AddConstant('PRINTER_ENUM_CONTAINER',PRINTER_ENUM_CONTAINER);
    AddConstant('PRINTER_ENUM_ICONMASK',PRINTER_ENUM_ICONMASK);
    AddConstant('PRINTER_ENUM_ICON1',PRINTER_ENUM_ICON1);
    AddConstant('PRINTER_ENUM_ICON2',PRINTER_ENUM_ICON2);
    AddConstant('PRINTER_ENUM_ICON3',PRINTER_ENUM_ICON3);
    AddConstant('PRINTER_ENUM_ICON4',PRINTER_ENUM_ICON4);
    AddConstant('PRINTER_ENUM_ICON5',PRINTER_ENUM_ICON5);
    AddConstant('PRINTER_ENUM_ICON6',PRINTER_ENUM_ICON6);
    AddConstant('PRINTER_ENUM_ICON7',PRINTER_ENUM_ICON7);
    AddConstant('PRINTER_ENUM_ICON8',PRINTER_ENUM_ICON8);
    AddConstant('PRINTER_NOTIFY_TYPE',PRINTER_NOTIFY_TYPE);
    AddConstant('JOB_NOTIFY_TYPE',JOB_NOTIFY_TYPE);
    AddConstant('PRINTER_NOTIFY_FIELD_SERVER_NAME',PRINTER_NOTIFY_FIELD_SERVER_NAME);
    AddConstant('PRINTER_NOTIFY_FIELD_PRINTER_NAME',PRINTER_NOTIFY_FIELD_PRINTER_NAME);
    AddConstant('PRINTER_NOTIFY_FIELD_SHARE_NAME',PRINTER_NOTIFY_FIELD_SHARE_NAME);
    AddConstant('PRINTER_NOTIFY_FIELD_PORT_NAME',PRINTER_NOTIFY_FIELD_PORT_NAME);
    AddConstant('PRINTER_NOTIFY_FIELD_DRIVER_NAME',PRINTER_NOTIFY_FIELD_DRIVER_NAME);
    AddConstant('PRINTER_NOTIFY_FIELD_COMMENT',PRINTER_NOTIFY_FIELD_COMMENT);
    AddConstant('PRINTER_NOTIFY_FIELD_LOCATION',PRINTER_NOTIFY_FIELD_LOCATION);
    AddConstant('PRINTER_NOTIFY_FIELD_DEVMODE',PRINTER_NOTIFY_FIELD_DEVMODE);
    AddConstant('PRINTER_NOTIFY_FIELD_SEPFILE',PRINTER_NOTIFY_FIELD_SEPFILE);
    AddConstant('PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR',PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR);
    AddConstant('PRINTER_NOTIFY_FIELD_PARAMETERS',PRINTER_NOTIFY_FIELD_PARAMETERS);
    AddConstant('PRINTER_NOTIFY_FIELD_DATATYPE',PRINTER_NOTIFY_FIELD_DATATYPE);
    AddConstant('PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR',PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR);
    AddConstant('PRINTER_NOTIFY_FIELD_ATTRIBUTES',PRINTER_NOTIFY_FIELD_ATTRIBUTES);
    AddConstant('PRINTER_NOTIFY_FIELD_PRIORITY',PRINTER_NOTIFY_FIELD_PRIORITY);
    AddConstant('PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY',PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY);
    AddConstant('PRINTER_NOTIFY_FIELD_START_TIME',PRINTER_NOTIFY_FIELD_START_TIME);
    AddConstant('PRINTER_NOTIFY_FIELD_UNTIL_TIME',PRINTER_NOTIFY_FIELD_UNTIL_TIME);
    AddConstant('PRINTER_NOTIFY_FIELD_STATUS',PRINTER_NOTIFY_FIELD_STATUS);
    AddConstant('PRINTER_NOTIFY_FIELD_STATUS_STRING',PRINTER_NOTIFY_FIELD_STATUS_STRING);
    AddConstant('PRINTER_NOTIFY_FIELD_CJOBS',PRINTER_NOTIFY_FIELD_CJOBS);
    AddConstant('PRINTER_NOTIFY_FIELD_AVERAGE_PPM',PRINTER_NOTIFY_FIELD_AVERAGE_PPM);
    AddConstant('PRINTER_NOTIFY_FIELD_TOTAL_PAGES',PRINTER_NOTIFY_FIELD_TOTAL_PAGES);
    AddConstant('PRINTER_NOTIFY_FIELD_PAGES_PRINTED',PRINTER_NOTIFY_FIELD_PAGES_PRINTED);
    AddConstant('PRINTER_NOTIFY_FIELD_TOTAL_BYTES',PRINTER_NOTIFY_FIELD_TOTAL_BYTES);
    AddConstant('PRINTER_NOTIFY_FIELD_BYTES_PRINTED',PRINTER_NOTIFY_FIELD_BYTES_PRINTED);
    AddConstant('JOB_NOTIFY_FIELD_PRINTER_NAME',JOB_NOTIFY_FIELD_PRINTER_NAME);
    AddConstant('JOB_NOTIFY_FIELD_MACHINE_NAME',JOB_NOTIFY_FIELD_MACHINE_NAME);
    AddConstant('JOB_NOTIFY_FIELD_PORT_NAME',JOB_NOTIFY_FIELD_PORT_NAME);
    AddConstant('JOB_NOTIFY_FIELD_USER_NAME',JOB_NOTIFY_FIELD_USER_NAME);
    AddConstant('JOB_NOTIFY_FIELD_NOTIFY_NAME',JOB_NOTIFY_FIELD_NOTIFY_NAME);
    AddConstant('JOB_NOTIFY_FIELD_DATATYPE',JOB_NOTIFY_FIELD_DATATYPE);
    AddConstant('JOB_NOTIFY_FIELD_PRINT_PROCESSOR',JOB_NOTIFY_FIELD_PRINT_PROCESSOR);
    AddConstant('JOB_NOTIFY_FIELD_PARAMETERS',JOB_NOTIFY_FIELD_PARAMETERS);
    AddConstant('JOB_NOTIFY_FIELD_DRIVER_NAME',JOB_NOTIFY_FIELD_DRIVER_NAME);
    AddConstant('JOB_NOTIFY_FIELD_DEVMODE',JOB_NOTIFY_FIELD_DEVMODE);
    AddConstant('JOB_NOTIFY_FIELD_STATUS',JOB_NOTIFY_FIELD_STATUS);
    AddConstant('JOB_NOTIFY_FIELD_STATUS_STRING',JOB_NOTIFY_FIELD_STATUS_STRING);
    AddConstant('JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR',JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR);
    AddConstant('JOB_NOTIFY_FIELD_DOCUMENT',JOB_NOTIFY_FIELD_DOCUMENT);
    AddConstant('JOB_NOTIFY_FIELD_PRIORITY',JOB_NOTIFY_FIELD_PRIORITY);
    AddConstant('JOB_NOTIFY_FIELD_POSITION',JOB_NOTIFY_FIELD_POSITION);
    AddConstant('JOB_NOTIFY_FIELD_SUBMITTED',JOB_NOTIFY_FIELD_SUBMITTED);
    AddConstant('JOB_NOTIFY_FIELD_START_TIME',JOB_NOTIFY_FIELD_START_TIME);
    AddConstant('JOB_NOTIFY_FIELD_UNTIL_TIME',JOB_NOTIFY_FIELD_UNTIL_TIME);
    AddConstant('JOB_NOTIFY_FIELD_TIME',JOB_NOTIFY_FIELD_TIME);
    AddConstant('JOB_NOTIFY_FIELD_TOTAL_PAGES',JOB_NOTIFY_FIELD_TOTAL_PAGES);
    AddConstant('JOB_NOTIFY_FIELD_PAGES_PRINTED',JOB_NOTIFY_FIELD_PAGES_PRINTED);
    AddConstant('JOB_NOTIFY_FIELD_TOTAL_BYTES',JOB_NOTIFY_FIELD_TOTAL_BYTES);
    AddConstant('JOB_NOTIFY_FIELD_BYTES_PRINTED',JOB_NOTIFY_FIELD_BYTES_PRINTED);
    AddConstant('PRINTER_NOTIFY_OPTIONS_REFRESH',PRINTER_NOTIFY_OPTIONS_REFRESH);
    AddConstant('PRINTER_NOTIFY_INFO_DISCARDED',PRINTER_NOTIFY_INFO_DISCARDED);
    AddConstant('PRINTER_CHANGE_ADD_PRINTER',PRINTER_CHANGE_ADD_PRINTER);
    AddConstant('PRINTER_CHANGE_SET_PRINTER',PRINTER_CHANGE_SET_PRINTER);
    AddConstant('PRINTER_CHANGE_DELETE_PRINTER',PRINTER_CHANGE_DELETE_PRINTER);
    AddConstant('PRINTER_CHANGE_FAILED_CONNECTION_PRINTER',PRINTER_CHANGE_FAILED_CONNECTION_PRINTER);
    AddConstant('PRINTER_CHANGE_PRINTER',PRINTER_CHANGE_PRINTER);
    AddConstant('PRINTER_CHANGE_ADD_JOB',PRINTER_CHANGE_ADD_JOB);
    AddConstant('PRINTER_CHANGE_SET_JOB',PRINTER_CHANGE_SET_JOB);
    AddConstant('PRINTER_CHANGE_DELETE_JOB',PRINTER_CHANGE_DELETE_JOB);
    AddConstant('PRINTER_CHANGE_WRITE_JOB',PRINTER_CHANGE_WRITE_JOB);
    AddConstant('PRINTER_CHANGE_JOB',PRINTER_CHANGE_JOB);
    AddConstant('PRINTER_CHANGE_ADD_FORM',PRINTER_CHANGE_ADD_FORM);
    AddConstant('PRINTER_CHANGE_SET_FORM',PRINTER_CHANGE_SET_FORM);
    AddConstant('PRINTER_CHANGE_DELETE_FORM',PRINTER_CHANGE_DELETE_FORM);
    AddConstant('PRINTER_CHANGE_FORM',PRINTER_CHANGE_FORM);
    AddConstant('PRINTER_CHANGE_ADD_PORT',PRINTER_CHANGE_ADD_PORT);
    AddConstant('PRINTER_CHANGE_CONFIGURE_PORT',PRINTER_CHANGE_CONFIGURE_PORT);
    AddConstant('PRINTER_CHANGE_DELETE_PORT',PRINTER_CHANGE_DELETE_PORT);
    AddConstant('PRINTER_CHANGE_PORT',PRINTER_CHANGE_PORT);
    AddConstant('PRINTER_CHANGE_ADD_PRINT_PROCESSOR',PRINTER_CHANGE_ADD_PRINT_PROCESSOR);
    AddConstant('PRINTER_CHANGE_DELETE_PRINT_PROCESSOR',PRINTER_CHANGE_DELETE_PRINT_PROCESSOR);
    AddConstant('PRINTER_CHANGE_PRINT_PROCESSOR',PRINTER_CHANGE_PRINT_PROCESSOR);
    AddConstant('PRINTER_CHANGE_ADD_PRINTER_DRIVER',PRINTER_CHANGE_ADD_PRINTER_DRIVER);
    AddConstant('PRINTER_CHANGE_SET_PRINTER_DRIVER',PRINTER_CHANGE_SET_PRINTER_DRIVER);
    AddConstant('PRINTER_CHANGE_DELETE_PRINTER_DRIVER',PRINTER_CHANGE_DELETE_PRINTER_DRIVER);
    AddConstant('PRINTER_CHANGE_PRINTER_DRIVER',PRINTER_CHANGE_PRINTER_DRIVER);
    AddConstant('PRINTER_CHANGE_TIMEOUT',PRINTER_CHANGE_TIMEOUT);
    AddConstant('PRINTER_CHANGE_ALL',PRINTER_CHANGE_ALL);
    AddConstant('PRINTER_ERROR_INFORMATION',PRINTER_ERROR_INFORMATION);
    AddConstant('PRINTER_ERROR_WARNING',PRINTER_ERROR_WARNING);
    AddConstant('PRINTER_ERROR_SEVERE',PRINTER_ERROR_SEVERE);
    AddConstant('PRINTER_ERROR_OUTOFPAPER',PRINTER_ERROR_OUTOFPAPER);
    AddConstant('PRINTER_ERROR_JAM',PRINTER_ERROR_JAM);
    AddConstant('PRINTER_ERROR_OUTOFTONER',PRINTER_ERROR_OUTOFTONER);
    AddConstant('SPLREG_DEFAULT_SPOOL_DIRECTORY',SPLREG_DEFAULT_SPOOL_DIRECTORY);
    AddConstant('SPLREG_PORT_THREAD_PRIORITY_DEFAULT',SPLREG_PORT_THREAD_PRIORITY_DEFAULT);
    AddConstant('SPLREG_PORT_THREAD_PRIORITY',SPLREG_PORT_THREAD_PRIORITY);
    AddConstant('SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT',SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT);
    AddConstant('SPLREG_SCHEDULER_THREAD_PRIORITY',SPLREG_SCHEDULER_THREAD_PRIORITY);
    AddConstant('SPLREG_BEEP_ENABLED',SPLREG_BEEP_ENABLED);
    AddConstant('SPLREG_NET_POPUP',SPLREG_NET_POPUP);
    AddConstant('SPLREG_EVENT_LOG',SPLREG_EVENT_LOG);
    AddConstant('SPLREG_MAJOR_VERSION',SPLREG_MAJOR_VERSION);
    AddConstant('SPLREG_MINOR_VERSION',SPLREG_MINOR_VERSION);
    AddConstant('SPLREG_ARCHITECTURE',SPLREG_ARCHITECTURE);
    AddConstant('SERVER_ACCESS_ADMINISTER',SERVER_ACCESS_ADMINISTER);
    AddConstant('SERVER_ACCESS_ENUMERATE',SERVER_ACCESS_ENUMERATE);
    AddConstant('PRINTER_ACCESS_ADMINISTER',PRINTER_ACCESS_ADMINISTER);
    AddConstant('PRINTER_ACCESS_USE',PRINTER_ACCESS_USE);
    AddConstant('JOB_ACCESS_ADMINISTER',JOB_ACCESS_ADMINISTER);
    AddConstant('SERVER_ALL_ACCESS',SERVER_ALL_ACCESS);
    AddConstant('SERVER_READ',SERVER_READ);
    AddConstant('SERVER_WRITE',SERVER_WRITE);
    AddConstant('SERVER_EXECUTE',SERVER_EXECUTE);
    AddConstant('PRINTER_ALL_ACCESS',PRINTER_ALL_ACCESS);
    AddConstant('PRINTER_READ',PRINTER_READ);
    AddConstant('PRINTER_WRITE',PRINTER_WRITE);
    AddConstant('PRINTER_EXECUTE',PRINTER_EXECUTE);
    AddConstant('JOB_ALL_ACCESS',JOB_ALL_ACCESS);
    AddConstant('JOB_READ',JOB_READ);
    AddConstant('JOB_WRITE',JOB_WRITE);
    AddConstant('JOB_EXECUTE',JOB_EXECUTE);
    AddConstant('winspl',winspl);
  end;
end;

class function TatWinSpoolLibrary.LibraryName: string;
begin
  result := 'WinSpool';
end;

initialization
  RegisterScripterLibrary(TatWinSpoolLibrary, True);

{$WARNINGS ON}

end.

