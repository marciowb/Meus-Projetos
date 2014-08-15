unit IDEDialog;

{$I ASCRIPT.INC}

interface
uses Classes, Dialogs,
  {$IFDEF THEMED_IDE}
  AdvAppStyler,
  AdvStyleIF,
  {$ENDIF}
  IDEMain, fIDEEditor; 

type
  TIDECloseAction = (icaCloseAll, icaNothing);

  TIDEDialog = class(TComponent)
  private
    FEngine: TIDEEngine;
    FIDEForm: TIDEEditorForm;
    //FScripter: TIDEScripter;
    FTitle: string;
    FCloseAction: TIDECloseAction;
    FOnCreateIDEForm: TNotifyEvent;
    FOnShowIDEForm: TNotifyEvent;
    {$IFDEF THEMED_IDE}
    FAppStyler: TAdvAppStyler;
    {$ENDIF}
    //FCloseProjectOnExit: boolean;
    function GetEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
    {$IFDEF THEMED_IDE}
    procedure SetAppStyler(const Value: TAdvAppStyler);
    {$ENDIF}
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    property OnCreateIDEForm: TNotifyEvent read FOnCreateIDEForm write FOnCreateIDEForm;
    property OnShowIDEForm: TNotifyEvent read FOnShowIDEForm write FOnShowIDEForm;
  published
    property Engine: TIDEEngine read GetEngine write SetEngine;
    property Title: string read FTitle write FTitle;
    property IDECloseAction: TIDECloseAction read FCloseAction write FCloseAction;
    {$IFDEF THEMED_IDE}
    property AppStyler: TAdvAppStyler read FAppStyler write SetAppStyler;
    {$ENDIF}
    //property CloseProjectOnExit: boolean read FCloseProjectOnExit write FCloseProjectOnExit;
  end;


implementation

{ TIDEDialog }

constructor TIDEDialog.Create(AOwner: TComponent);
begin
  inherited;
  FTitle := 'Scripter Studio Pro IDE - %s';
  FCloseAction := icaCloseAll;
  //FIDEForm := TIDEEditorForm.Create(nil);
end;

destructor TIDEDialog.Destroy;
begin
  {FIDEForm.Free;
  FIDEForm := nil;}
  inherited;
end;

procedure TIDEDialog.Execute;
begin
  if Engine = nil then
    raise EIDEException.Create('Engine component not defined in TIDEDialog component.');

  //FIDEForm.Scripter := FScripter;
  FIDEForm := TIDEEditorForm.Create(nil);
  try
    FIDEForm.AttachEngine(FEngine);
    if Assigned(FOnCreateIDEForm) then
      FOnCreateIDEForm(FIDEForm);
    FIDEForm.OnNotifyShow := FOnShowIDEForm;

    FIDEForm.Title := FTitle;
    case FCloseAction of
      icaCloseAll: FIDEForm.CloseAllOnExit := true;
      icaNothing: FIDEForm.CloseAllOnExit := false;
    end;

    {$IFDEF THEMED_IDE}
    FIDEForm.AppStyler := FAppStyler;
    {$ENDIF} 

    FIDEForm.ShowModal;
    FIDEForm.DetachEngine; 
  finally
    FIDEForm.Free;
    FIDEForm := nil;
  end;
end;

function TIDEDialog.GetEngine: TIDEEngine;
begin
  result := FEngine;
end;

procedure TIDEDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
  {$IFDEF THEMED_IDE}
  if (Operation = opRemove) and (AComponent = FAppStyler) then
    FAppStyler := nil;
  {$ENDIF}
end;

{$IFDEF THEMED_IDE}
procedure TIDEDialog.SetAppStyler(const Value: TAdvAppStyler);
begin
  if FAppStyler <> Value then
  begin
    if FAppStyler <> nil then
      FAppStyler.RemoveFreeNotification(Self);
    FAppStyler := Value;
    if FAppStyler <> nil then
      FAppStyler.FreeNotification(Self);
  end;
end;
{$ENDIF}

procedure TIDEDialog.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
      FEngine.RemoveFreeNotification(Self);
    FEngine := Value;
    if FEngine <> nil then
      FEngine.FreeNotification(Self);
  end;
end;

end.

