unit fWatches;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, IDEMain;

type
  TfmWatches = class(TForm)
    IDEWatchListView: TIDEWatchListView;
  private
    function GetEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
    { Private declarations }
  public
    { Public declarations }
    property Engine: TIDEEngine read GetEngine write SetEngine;
  end;

implementation

{$R *.DFM}

{ TfmWatches }

function TfmWatches.GetEngine: TIDEEngine;
begin
  result :=   IDEWatchListView.Engine;
end;

procedure TfmWatches.SetEngine(const Value: TIDEEngine);
begin
  IDEWatchListView.Engine := Value;
end;

end.
