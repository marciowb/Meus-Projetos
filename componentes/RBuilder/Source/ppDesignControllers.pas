{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignControllers;

interface

uses
  Classes,
  
  ppComm,
  ppClass,

  ppDesignObserver,
  ppDesignDialogController,
  ppDesignDocumentController,
  ppDesignSelectionController,
  ppDesignWorkspaceController,
  ppDesignWorkspaceView,
  ppDesignEventHub;

type


  {TppDesignConrollers}
  TppDesignControllers = class(TppDesignObserver)
  private
    FDialogController: TppDesignDialogController;
    FDocumentController: TppDesignDocumentController;
    FSelectionController: TppDesignSelectionController;
    FWorkspaceController: TppDesignWorkspaceController;
    FWorkspaceView: TppDesignWorkspaceView;
    
    procedure SetWorkspaceView(const Value: TppDesignWorkspaceView);

  protected
    procedure SetEventHub(aEventHub: TppDesignEventHub); override;

  public
    constructor Create(aOwner: TComponent); override;

    // controllers used by tools
    property DialogController: TppDesignDialogController read FDialogController;
    property DocumentController: TppDesignDocumentController read FDocumentController;
    property SelectionController: TppDesignSelectionController read FSelectionController;
    property WorkspaceController: TppDesignWorkspaceController read FWorkspaceController;

    property WorkspaceView: TppDesignWorkspaceView read FWorkspaceView write SetWorkspaceView;

  end;

implementation


constructor TppDesignControllers.Create(aOwner: TComponent);
begin

  inherited;

  FDialogController := TppDesignDialogController.Create(aOwner);
  FDocumentController := TppDesignDocumentController.Create(aOwner);
  FSelectionController := TppDesignSelectionController.Create(aOwner);
  FWorkspaceController := TppDesignWorkspaceController.Create(aOwner);

end;

{------------------------------------------------------------------------------}
{TppDesignObserver.SetEventHub}

procedure TppDesignControllers.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (EventHub <> aEventHub) then
    begin
      FDialogController.EventHub := aEventHub;
      FDocumentController.EventHub := aEventHub;
      FSelectionController.EventHub := aEventHub;
      FWorkspaceController.EventHub := aEventHub;
    end;

  inherited;
  
end;

procedure TppDesignControllers.SetWorkspaceView(const Value: TppDesignWorkspaceView);
begin

  if FWorkspaceView <> Value then
    begin
      FWorkspaceView := Value;
      FDialogController.WorkspaceView := FWorkspaceView;
      FDocumentController.WorkspaceView := FWorkspaceView;
      FSelectionController.WorkspaceView := FWorkspaceView;
      FWorkspaceController.WorkspaceView := FWorkspaceView;
    end;

end;

end.
