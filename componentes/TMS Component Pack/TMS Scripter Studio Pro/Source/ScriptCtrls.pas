{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit ScriptCtrls;

{$I ASCRIPT.INC}

interface
uses
  Windows, SysUtils, Classes, Graphics, ComCtrls, ExtCtrls, ImgList, atScript, AdvMemo;

type
  /// Summary:
  ///   Used by the source explorer control to indicate the meaning of each tree node in the tree view 
  TScriptItemType = (
    itFolder,         /// Node is a folder (contains sub nodes)
    itFunction,       /// Node corresponds to a script function 
    itProcedure,      /// Node corresponds to a script procedure   
    itVariable,       /// Node corresponds to a script variable  
    itUnit            /// Node corresponds to a unit used by script  
  );

  /// Summary:
  ///   A tree view control that displays script source code information (declared functions, variables, etc.)
  /// Description:
  ///   TSourceExplorer is a tree view visual control that displays information about a script source code, showing
  ///   in a visual tree all procedures, functions and variables declared in script, and also the used units.
  ///   The component works attached to a TAdvMemo. It plugs into OnChange event of the memo and whenever the script source
  ///   code is changed in the memo, it updates itself automatically. 
  TSourceExplorer = class(TCustomTreeView)
  private
    FScripter: TatCustomScripter;
    FImages : TCustomImageList;
    FAdvMemo: TAdvMemo;
    FTimer: TTimer;
    FTempSource: TStrings;
    FCompileThread: TThread;
    FScript: TatScript;
    FRecompile: boolean;
    FOldChange: TNotifyEvent;
    procedure BuildTree(AInfo: TatScriptInfo);
    function AddScriptNode(AName: string; AType: TScriptItemType;
      AParent: TTreeNode = nil; AObject: TObject = nil): TTreeNode;
    procedure CheckImages;
    procedure SetAdvMemo(const Value: TAdvMemo);
    procedure TimerEvent(Sender: TObject);
    procedure CompilationFinished(Sender: TObject);
    procedure AssignChangeEvent(AMemo: TAdvMemo);
    procedure UnassignChangeEvent(AMemo: TAdvMemo);
    procedure SetScripter(const Value: TatCustomScripter);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DblClick; override;
    procedure Loaded; override;
    procedure AdvMemoChange(Sender: TObject); virtual;
    function CanEdit(Node: TTreeNode): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    /// Summary:
    ///   Refreshes the tree view, updating the information displayed.
    /// Description:
    ///   Call UpdateTree to update the tree view content. It will perform a recompilation of the script,
    ///   extract the information from it and update the items in the tree view
    /// Parameters:
    ///   ASource - Contains the script source code to be displayed. If do not use this parameter, the content of memo will be used.
    procedure UpdateTree; overload;
    procedure UpdateTree(ASource: TStrings); overload;
  published
  
    /// Summary:
    ///   Points to the scripter component used to compile the script and extract information from it. You must inform
    ///   a scripter component, otherwise the control will not work.
    property Scripter: TatCustomScripter read FScripter write SetScripter;
    
    /// Summary:
    ///   Points to the TAdvMemo component that will be in sync with the source explorer
    /// Description:
    ///   You can optionally set AdvMemo property to associate a memo with the source explorer. When you do that, source explorer
    ///   plugs an event handler to the TAdvMemo.OnChange event, so that when the memo changes, the source explorer is automatically
    ///   updated. If you don't set AdvMemo property, you will have to manually ask for the source explorer to update itself,
    ///   using the UpdateTree method
    /// See Also:
    ///   UpdateTree
    property AdvMemo: TAdvMemo read FAdvMemo write SetAdvMemo;

    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Indent;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Visible;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

{$R ScriptCtrls.res}

type
  TCompileThread = class(TThread)
  private
    FControl: TSourceExplorer;
  public
    constructor Create(AControl: TSourceExplorer);
    procedure Execute; override;
    destructor Destroy; override;
  end;

{ TSourceExplorer }

procedure TSourceExplorer.CheckImages;

  {$WARNINGS OFF}
  procedure LoadItemBitmap(AResName: PChar);
  var
    aBitmap: TBitmap;
    aMask: TBitmap;
  begin
    aBitmap := TBitmap.Create;
    aMask := TBitmap.Create;
    try
      aBitmap.Handle := LoadBitmap(HInstance, AResName);
      aMask.Assign(aBitmap);
      aMask.Mask(aMask.Canvas.Pixels[0, aMask.Height - 1]);
      Images.Add(aBitmap, aMask);
    finally
      aBitmap.Free;
      aMask.Free;
    end;
  end;
  {$WARNINGS ON}

begin
  if not (csDesigning in ComponentState) then
  begin
    if not Assigned(Images) then
    begin
      FImages := TCustomImageList.Create(self);
      FImages.Width := 16;
      FImages.Height := 16;
      Images := FImages;
      LoadItemBitmap('SCR_FOLDER');
      LoadItemBitmap('SCR_FUNCTION');
      LoadItemBitmap('SCR_PROCEDURE');
      LoadItemBitmap('SCR_VARIABLE');
      LoadItemBitmap('SCR_UNIT');
    end;
  end;
end;

function TSourceExplorer.AddScriptNode(AName: string; AType: TScriptItemType;
  AParent: TTreeNode = nil; AObject: TObject = nil): TTreeNode;
begin
  {Find a child which has the same name. Works because there is only two level in the three}
  if AParent <> nil then
    result := AParent.GetFirstChild
  else
    result := Items.GetFirstNode;
  while result <> nil do
  begin
    if CompareText(result.Text, AName) = 0 then
      break
    else
      result := result.getNextSibling;
  end;

  {if the child is not found, create one}
  if result = nil then
    result := Items.AddChild(AParent, AName);
  result.ImageIndex := Ord(AType);
  result.StateIndex := result.ImageIndex;
  result.SelectedIndex := result.ImageIndex;
  {$WARNINGS OFF}
  result.Data := AObject;
  {$WARNINGS ON}
end;

procedure TSourceExplorer.BuildTree(AInfo: TatScriptInfo);

  procedure AddProcedures;
  var
    ANode: TTreeNode;
    c: integer;
  begin
    ANode := AddScriptNode('Procedures', itFolder);
    for c := 0 to AInfo.Routines.Count - 1 do
      if (not AInfo.Routines[c].Internal) and (AInfo.Routines[c] <> AInfo.MainRoutine) then
      begin
        if AInfo.Routines[c].IsFunction then
          AddScriptNode(AInfo.Routines[c].Name, itFunction, ANode, AInfo.Routines[c])
        else
          AddScriptNode(AInfo.Routines[c].Name, itProcedure, ANode, AInfo.Routines[c])
      end;
  end;

  procedure AddGlobals;
  var
    ANode: TTreeNode;
    c: integer;
  begin
    ANode := AddScriptNode('Variables', itFolder);
    for c := 0 to AInfo.Globals.Count - 1 do
      if not AInfo.Globals[c].Internal then
      begin
        AddScriptNode(AInfo.Globals[c].VarName, itVariable, ANode, AInfo.Globals[c])
      end;
  end;

  procedure AddUnits;
  var
    ANode: TTreeNode;
    c: integer;
  begin
    ANode := AddScriptNode('Uses', itFolder);
    for c := 0 to AInfo.Script.UsedUnits.Count - 1 do
    begin
      AddScriptNode(AInfo.Script.UsedUnits[c].UnitName, itUnit, ANode, AInfo.Script.UsedUnits[c]);
    end;
  end;

  procedure MarkNodesForDelete(ANode: TTreeNode);
  begin
    while ANode <> nil do
    begin
      {$WARNINGS OFF}
      ANode.Data := Pointer(-1);
      {$WARNINGS ON}
      ANode := ANode.GetNext;
    end;
  end;

  procedure DeleteMarkedNodes(ANode: TTreeNode);
  var
    PrevNode: TTreeNode;
  begin
    while ANode <> nil do
    begin
      {$WARNINGS OFF}
      if integer(ANode.Data) = -1 then
      {$WARNINGS ON}
      begin
        PrevNode := ANode.GetPrev;
        ANode.Free;
        if PrevNode <> nil then
          ANode := PrevNode.GetNext
        else
          ANode := Items.GetFirstNode;
      end else
        ANode := ANode.GetNext;
    end;
  end;

begin
  CheckImages;
  Items.BeginUpdate;
  try
    MarkNodesForDelete(Items.GetFirstNode);

    if (AInfo.Routines.Count > 0) and
      ((AInfo.Routines.Count > 1) or (AInfo.Routines[0] <> AInfo.MainRoutine)) then
      AddProcedures;
    if AInfo.Globals.Count > 0 then
      AddGlobals;
    if (AInfo.Script <> nil) and (AInfo.Script.UsedUnits.Count > 0) then
      AddUnits;

    DeleteMarkedNodes(Items.GetFirstNode);
    AlphaSort;
  finally
    Items.EndUpdate;
  end;
end;

constructor TSourceExplorer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldChange := nil;
  FRecompile := false;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 1000;
  FTimer.Enabled := false;
  FTimer.OnTimer := TimerEvent;
  FScript := nil;
  FTempSource := TStringList.Create;
end;

destructor TSourceExplorer.Destroy;
begin
  if FAdvMemo <> nil then
    UnassignChangeEvent(FAdvMemo);

  FTimer.Free;

  if FCompileThread <> nil then
  begin
    TerminateThread(FCompileThread.Handle, 0);
  end;
  FCompileThread := nil;

  FTempSource.Free;

  if Assigned(FImages) then
    FImages.Free;    
  if FScript <> nil then
  begin
    FScript.Free;
    FScript := nil;
  end;
  inherited;
end;

procedure TSourceExplorer.UpdateTree;
begin
  if FAdvMemo <> nil then
  begin
    UpdateTree(FAdvMemo.Lines);
  end;
end;

procedure TSourceExplorer.TimerEvent(Sender: TObject);
var
  OldCurrentScript: TatScript;
begin
  {if there is a request for recompilation but the compilethread is not finished yet,
   then wait for the next timer event, until the thread is finished}
  if FRecompile and (FCompileThread <> nil) then
    Exit;
  FTimer.Enabled := false;
  if FScripter <> nil then
  begin
    {if there is not a thread running, then run the thread to compile} 
    if FCompileThread = nil then
    begin
      FRecompile := false;
      if FScript <> nil then
        FScript.Free;
      OldCurrentScript := FScripter.CurrentScript;
      FScript := FScripter.Scripts.Add;
      FScript.SourceCode.Assign(FTempSource);
      FScripter.CurrentScript := OldCurrentScript;
      FCompileThread := TCompileThread.Create(self);
      FCompileThread.OnTerminate := CompilationFinished;
      if FCompileThread.Suspended then
        FCompileThread.Resume;
    end else
    begin
      {if the thread is running, then wait for the thread to finish and then recompile}
      FRecompile := true;
    end;
  end;
end;

procedure TSourceExplorer.UpdateTree(ASource: TStrings);
begin
  FTempSource.Assign(ASource);
  FTimer.Enabled := false;
  FTimer.Enabled := true;
end;

procedure TSourceExplorer.SetAdvMemo(const Value: TAdvMemo);
begin
  if FAdvMemo <> nil then
    UnassignChangeEvent(FAdvMemo);
  FAdvMemo := Value;
  if FAdvMemo <> nil then
  begin
    FAdvMemo.FreeNotification(Self);
    UpdateTree(FAdvMemo.Lines);
    if not (csLoading in ComponentState) then
      AssignChangeEvent(FAdvMemo);
  end;
end;

procedure TSourceExplorer.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if FAdvMemo = AComponent then FAdvMemo := nil;
    if FScripter = AComponent then FScripter := nil;
  end; 
end;

procedure TSourceExplorer.DblClick;
var
  ALine: integer;
  ACol: integer;
  ATopLine: integer;
begin
  inherited;
  if (Selected <> nil) and (FAdvMemo <> nil) then
  begin
    ALine := -1;
    ATopLine := -1;
    {$WARNINGS OFF}
    if TObject(Selected.Data) is TatRoutineInfo then
    begin
      ALine := LineNumberFromInstruction(TatRoutineInfo(Selected.Data).DeclarationInstruction) + 3;
      ATopLine := ALine - 3;
    end else
    if TObject(Selected.Data) is TatVariableInfo then
    begin
      if FScript <> nil then
        FScript.GetRowColFromSource(TatVariableInfo(Selected.Data).DeclarationSourcePos, ALine, ACol);
    end else
    if TObject(Selected.Data) is TatUsedUnit then
    begin
      ALine := 1;                                        
    end;
    {$WARNINGS ON}

    if ALine > 0 then
    begin
      {Set TopLine before Line}
      if ATopLine > 0 then
        FAdvMemo.TopLine := ATopLine;
      FAdvMemo.SetCursor(0, ALine - 1);
      if FAdvMemo.CanFocus then
        FAdvMemo.SetFocus;
    end;
  end;
end;

procedure TSourceExplorer.CompilationFinished(Sender: TObject);
begin
  BuildTree(FScript.ScriptInfo);
  if FRecompile then
    FTimer.Enabled := true;
end;

procedure TSourceExplorer.Loaded;
begin
  inherited;
  if not Assigned(FOldChange) and (FAdvMemo <> nil) then
    AssignChangeEvent(FAdvMemo);
end;

procedure TSourceExplorer.AssignChangeEvent(AMemo: TAdvMemo);
begin
  if (AMemo <> nil) and not (csDesigning in ComponentState) then
  begin
    FOldChange := AMemo.OnChange;
    AMemo.OnChange := AdvMemoChange;
  end;
end;

procedure TSourceExplorer.UnassignChangeEvent(AMemo: TAdvMemo);
begin
  if (AMemo <> nil) and not (csDesigning in ComponentState) then
  begin
    AMemo.OnChange := FOldChange;
    FOldChange := nil;
  end;
end;

procedure TSourceExplorer.AdvMemoChange(Sender: TObject);
begin
  if FAdvMemo <> nil then
    UpdateTree(FAdvMemo.Lines);
  if Assigned(FOldChange) then
    FOldChange(FAdvMemo); 
end;

function TSourceExplorer.CanEdit(Node: TTreeNode): Boolean;
begin
  result := False;
end;

procedure TSourceExplorer.SetScripter(const Value: TatCustomScripter);
begin
  FScripter := Value;
  if FScripter <> nil then
    FScripter.FreeNotification(Self);
end;

{ TCompileThread }

constructor TCompileThread.Create(AControl: TSourceExplorer);
begin
  FControl := AControl;
  inherited Create(true); 
  FreeOnTerminate:=true;
end;

destructor TCompileThread.Destroy;
begin
  FControl.FCompileThread := nil;
  inherited;
end;

procedure TCompileThread.Execute;
begin
  try
    try
      FControl.FScript.SilentCompile;
      FControl.FScript.ExpandDebugInfo(false);
      {Make the FScript independent of the Fscripter now, so that we don't have to worried
       about destruction}
      FControl.FScript.Collection := nil;
    except
    end;
  finally
    Terminate;
    if Suspended then Resume;
  end;
end;

end.
