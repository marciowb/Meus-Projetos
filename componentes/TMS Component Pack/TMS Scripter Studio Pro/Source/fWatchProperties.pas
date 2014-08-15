unit fWatchProperties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, atScript;

type
  TWatchDialogMode = (wmDebug, wmScripter);

  TfmWatchProperties = class(TForm)
    Label1: TLabel;
    edExpression: TEdit;
    chEnabled: TCheckBox;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FWatchMode: TWatchDialogMode;
    FScripterWatch : TatScripterWatch;
    FScripterWatches: TatScripterWatches;
    FDebugWatch: TatDebugWatch;
    FDebugWatches: TatDebugWatches;
    procedure SetScripterWatch(const Value: TatScripterWatch);
    procedure SetScripterWatches(const Value: TatScripterWatches);
    procedure SetDebugWatch(const Value: TatDebugWatch);
    procedure SetDebugWatches(const Value: TatDebugWatches);
  public
    { Public declarations }
    property ScripterWatch: TatScripterWatch read FScripterWatch write SetScripterWatch;
    property ScripterWatches: TatScripterWatches read FScripterWatches write SetScripterWatches;
    property DebugWatch: TatDebugWatch read FDebugWatch write SetDebugWatch;
    property DebugWatches: TatDebugWatches read FDebugWatches write SetDebugWatches;
  end;

var
  fmWatchProperties: TfmWatchProperties;

implementation

{$R *.DFM}

{ TfmWatchProperties }

procedure TfmWatchProperties.SetDebugWatch(const Value: TatDebugWatch);
begin
  FWatchMode := wmDebug;
  FDebugWatch := Value;
  if not Assigned(FDebugWatch) then
  begin
    { clear watch properties on the form }
    edExpression.Text       := '';
    chEnabled.Checked       := True;
  end
  else
  begin
    edExpression.Text       := FDebugWatch.Expression;
    chEnabled.Checked       := FDebugWatch.Enabled;
  end;
end;


procedure TfmWatchProperties.SetDebugWatches(
  const Value: TatDebugWatches);
begin
  FDebugWatches := Value;
  FWatchMode := wmDebug;
end;

procedure TfmWatchProperties.SetScripterWatch(const Value: TatScripterWatch);
begin
  FWatchMode := wmScripter;
  FScripterWatch := Value;
  if not Assigned(FScripterWatch) then
  begin
    { clear watch properties on the form }
    edExpression.Text       := '';
    chEnabled.Checked       := True;
  end
  else
  begin
    edExpression.Text       := FScripterWatch.Expression;
    chEnabled.Checked       := FScripterWatch.Enabled;
  end;
end;


procedure TfmWatchProperties.SetScripterWatches(
  const Value: TatScripterWatches);
begin
  FScripterWatches := Value;
  FWatchMode := wmScripter;
end;

procedure TfmWatchProperties.btOkClick(Sender: TObject);
begin
  Case FWatchMode of
    wmScripter:
      begin
        if not Assigned(FScripterWatch) then
          FScripterWatch := FScripterWatches.Add;
        { save properties into debug watch item }
        with FScripterWatch do
        begin
          Expression    := edExpression.Text;
          Enabled       := chEnabled.Checked;
        end;
        FScripterWatch.Evaluate;
      end;
    wmDebug:
      begin
        if not Assigned(FDebugWatch) then
          FDebugWatch := FDebugWatches.Add;
        { save properties into debug watch item }
        with FDebugWatch do
        begin
          Expression    := edExpression.Text;
          Enabled       := chEnabled.Checked;
        end;
        FDebugWatches.Evaluate(FDebugWatch);
      end
  end;
end;

procedure TfmWatchProperties.FormShow(Sender: TObject);
begin
  edExpression.SetFocus;
end;

end.
