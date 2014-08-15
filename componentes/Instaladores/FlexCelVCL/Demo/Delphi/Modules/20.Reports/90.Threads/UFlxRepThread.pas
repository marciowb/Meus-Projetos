unit UFlxRepThread;

interface

uses
  Classes,UExcelAdapter, XLSAdapter, UCustomFlexCelReport, UFlexcelReport, UThreadData, UBDEThreadData, SysUtils;

type
  TFlxRepThread = class(TThread)
  private
    Dm: TThreadData;
    BDEThreadData: TBDEThreadData;
    FFileName: string;
    BasePath: string;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    ErrMsg: string;
    property FileName: string read FFileName;
    constructor Create(const aBDEThreadData: TBDEThreadData; const aBasePath: string);
    procedure Finish;

  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TFlxRepThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TFlxRepThread }

constructor TFlxRepThread.Create(const aBDEThreadData: TBDEThreadData; const aBasePath: string);
begin
  inherited Create(True);
  FreeOnTerminate:=true;
  FFileName:= IntToStr(random(10000)) + IntToStr(random(10000))+'.xls';
  BDEThreadData := aBDEThreadData;
  BasePath := aBasePath;
end;

procedure TFlxRepThread.Execute;
begin
  ErrMsg:='';
  try
    Dm:=TThreadData.Create(nil);
    try
      Dm.XLSAdapter.BasePathToOpen := BasePath;
      BDEThreadData.FillMemoryDataSets(Dm); //We do this to avoid calling BDE from threads. Not that we could use TFlxMemTables in virtual mode ehere as data doesn't change, but we fill them with real data to emulate a real environment.

      //this is just for testing... we hope there will be no repeated filenames
      Dm.FlxRep.FileName:=FFilename;
      Dm.FlxRep.Run;
    finally
      FreeAndNil(Dm);
    end; //finally
    if Terminated then ErrMsg:='Canceled';
  except
    //Clear the Exception
    on e: Exception do ErrMsg:=e.Message;
  end; //Except
end;

procedure TFlxRepThread.Finish;
begin
  if Dm<>nil then Dm.FlxRep.Cancel;
  Terminate;
end;

end.
