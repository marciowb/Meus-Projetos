/// Unit containing a simple class to create an Hourglass cursor and revert it once a method ends.<para></para>
/// This class is not really related with FlexCel, but it is used in the demos and can be useful for
/// other uses.                                                                                                
unit UWaitCursor;
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface

{$IFDEF FLX_VCL}
  uses Controls, Forms;
{$ENDIF}
{$IFDEF FLX_CLX}
  uses QControls, QForms;
{$ENDIF}
type
  /// <summary>
  /// Helper class that uses reference counting to create an hourglass cursor that will be reverted to the
  /// original cursor once the method ends.
  /// </summary>
  /// <remarks>
  /// Create an instance of TWaitCursor and assign it to a IWaitCursor variable to change the cursor to an
  /// hourglass during the method where the variable is defined.
  /// </remarks>                                                                                          
  IWaitCursor = interface
  end;

  /// <summary>
  /// Helper class that uses reference counting to create an hourglass cursor that will be reverted to the
  /// original cursor once the method ends.
  /// </summary>
  /// <remarks>
  /// Create an instance of TWaitCursor and assign it to a IWaitCursor variable to change the cursor to an
  /// hourglass during the method where the variable is defined.
  /// </remarks>
  TWaitCursor = class(TInterfacedObject, IWaitCursor)
  private
    OldCursor: TCursor;
  public
    /// <summary>
    /// Creates a new instance. Assign the instance returned here to an IWaitCursor, not TWaitCursor, and it will be destroyed automatically.
    /// </summary>
    constructor Create;

    /// <summary>
    /// Destroys the instance. You shouldn't normally call this method, if you are using interfaces the instance will be
    ///  freed automatically when it goes out of scope.
    /// </summary>
    destructor Destroy;override;
  end;

implementation

{ TWaitCursor }

constructor TWaitCursor.Create;
begin
  inherited;
  OldCursor:= Screen.Cursor;
  Screen.Cursor:= crHourGlass;
end;

destructor TWaitCursor.Destroy;
begin
  Screen.Cursor:= OldCursor;
  inherited;

end;

end.
