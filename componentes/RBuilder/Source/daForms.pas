{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daForms;

interface

{$I ppIfDef.pas}

uses
  Types,
  Classes, Controls, ExtCtrls, Forms, Dialogs, Graphics, Messages, StdCtrls,
  ComCtrls, ppTypes, ppForms, ppClass, daSQL;

type

  { TdaCustomLinkDataViewDialog }

  TdaCustomLinkDataViewDialog = class (TppForm)
    public
      procedure AddSQLObjects(aSQLObjects: TList); virtual; abstract;
      function Execute: Boolean; virtual; abstract;
      procedure SetDetailSQL(aSQL: TdaSQL); virtual; abstract;
      function GetMasterSQL: TdaSQL; virtual; abstract;
  end;


  { TdaScrollBox

    When a visual link is selected and the delete key is pressed, the ScrollBox actually handles
    the keystroke - even though this component does not have any OnKey events.  Thus we have to
    create a descendant in order to capture the keystroke when the delete key is hit. }

  TdaScrollBox = class(TScrollBox)
    protected
      function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
          override;
    public
      property OnKeyDown;
  end; {class, TdaScrollBox}


 { TdaCustomDataViewDialog }

  TdaCustomDataViewDialog = class(TppForm)
    private
      FDataView: TComponent;

    protected
      procedure SetDataView(aDataView: TComponent); virtual;

    public
      constructor Create(aOwner: TComponent); override;

      property DataView: TComponent read FDataView write SetDataView;

  end; {class, TdaCustomDataViewDialog}


  { TdaCustomPreviewDataDialog}

  TdaCustomPreviewDataDialog = class(TdaCustomDataViewDialog)
    private
      FShowMagicFields: Boolean;

    public
      constructor Create(aOwner: TComponent); override;

      property ShowMagicFields: Boolean read FShowMagicFields write FShowMagicFields;

  end; {class, TdaCustomPreviewDataDialog}


  { TdaCustomDesignDataDialog}

  TdaCustomDesignDataDialog = class(TdaCustomDataViewDialog)

  end; {class, TdaCustomDesignDataDialog}


implementation

{******************************************************************************
 *
 ** C U S T O M   D A T A V I E W   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaCustomDataViewDialog.Create }

constructor TdaCustomDataViewDialog.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataView := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaCustomDataViewDialog.SetDataView }

procedure TdaCustomDataViewDialog.SetDataView(aDataView: TComponent);
begin
  FDataView := aDataView;
end; {procedure, SetDataView}


{******************************************************************************
 *
 ** C U S T O M   P R E V I E W   D A T A   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaCustomPreviewDataDialog.Create }

constructor TdaCustomPreviewDataDialog.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FShowMagicFields := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaCustomPreviewDataDialog.DoMouseWheel }

function TdaScrollBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin

  // respond to mouse wheel
  VertScrollBar.Position := VertScrollBar.Position - WheelDelta;

 Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);

end;

{------------------------------------------------------------------------------}
{ TdaCustomPreviewDataDialog.MouseDown }

procedure TdaScrollBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  // get focus - needed to receive mouse wheel events
  SetFocus();

  inherited;

end;



end.
