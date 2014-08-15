{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineDrawCommand;

interface

{$I ppIfDef.pas}

uses
  Classes,
  ppDevice, ppOutlineNode;

type

  {@TppOutlineDrawCommand

    Contains the information necessary to render a report outline tree.

    When the report is generated, an OutlineDrawCommand is created and attached
    to each page. The device class that receives the page can render use
    the OutlineDrawCommand to render an appropriate user interface. The screen
    device renders the outline to a tree view structure.
    ReportBuilder Server contains an XHTML device that can render the outline
    to a XHTML/java script page.

    The Completed property indicates whether the outline has been generated
    for the entire report or a partial number of pages. The RootNode property
    provides access to the outline tree structure.}

  {@TppOutlineDrawCommand.Completed

    Indicates whether the outline tree has been generated for the entire report.}

  {@TppOutlineDrawCommand.RootNode

    The root node of the outline tree structure.}

  TppOutlineDrawCommand = class(TppDrawCommand)
    private
      FCompleted: Boolean;
      FRootNode: TppOutlineNode;

    protected

      procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

    public

      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; override;
      procedure Assign(Source: TPersistent); override;
      function Clone: TppOutlineDrawCommand;
      procedure LanguageChanged; virtual;

      property RootNode: TppOutlineNode read FRootNode write FRootNode;

    published

      property Completed: Boolean read FCompleted write FCompleted;

  end; { class, TppOutlineDrawCommand }

implementation

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.Create }

constructor TppOutlineDrawCommand.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCompleted := False;
  FRootNode := nil;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.Destroy }

destructor TppOutlineDrawCommand.Destroy;
begin

  FRootNode.Free;

  inherited Destroy;

end; { destructor, Destroy }

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.GetChildren }

procedure TppOutlineDrawCommand.GetChildren(Proc: TGetChildProc; Root:TComponent);
begin

  Proc(FRootNode);

end; { procedure, GetChildren }

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.EqualTo }

function TppOutlineDrawCommand.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
var
  lOutlineCommand: TppOutlineDrawCommand;
begin

  lOutlineCommand := TppOutlineDrawCommand(aDrawCommand);

  Result := inherited EqualTo(aDrawCommand);
  Result := (Result and (FCompleted = lOutlineCommand.Completed));
  Result := (Result and (FRootNode.EqualTo(lOutlineCommand.RootNode)));

end; { function, EqualTo }

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.Assign }

procedure TppOutlineDrawCommand.Assign(Source: TPersistent);
var
  lOutlineDrawCommand: TppOutlineDrawCommand;
begin

  if (Source is TppOutlineDrawCommand) then
    begin

      lOutlineDrawCommand := TppOutlineDrawCommand(Source);

      FCompleted := lOutlineDrawCommand.Completed;

      if (FRootNode <> nil) then
        FRootNode.Free;

      FRootNode := TppOutlineNode.CloneActiveRootNode(lOutlineDrawCommand.FRootNode);

    end;

end; { procedure, Assign }

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.Clone }

function TppOutlineDrawCommand.Clone: TppOutlineDrawCommand;
begin

  Result := TppOutlineDrawCommand.Create(nil);
  Result.Assign(Self);

end; { function, Clone }

{------------------------------------------------------------------------------}
{ TppOutlineDrawCommand.LanguageChanged }

procedure TppOutlineDrawCommand.LanguageChanged;
begin

end; { function, LanguageChanged }


initialization

  RegisterClasses([TppOutlineDrawCommand]);

finalization

  UnRegisterClasses([TppOutlineDrawCommand]);

end.

