{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppFormWrapper;

{$I ppIfDef.pas}

interface

uses
  Classes, Forms, Graphics,
  ppComm, ppUtils;


type


  {@TppFormWrapper

    The form wrapper class contains many of the properties and events found in a
    standard Delphi form. It is used by classes which must implement many of the
    common properties, events and methods found in a form. When the Show
    procedure or ShowModal function is called, FormWrapper assigns the values of
    its properties and events to the form.  The descendant usually creates and
    configures the form in the BeforeShowForm function and frees the form in the
    AfterShowForm procedure.  The Descendant returns a handle to the created
    form via the GetForm method, which must be implemented for FormWrapper to
    function properly.}

  {@TppFormWrapper.FormCaption

    The FormCaption property is the text that appears in the upper left corner
    of the form.}

  {@TppFormWrapper.FormHeight

    The FormHeight property of a control is the vertical size of the window in
    pixels.}

  {@TppFormWrapper.FormIcon

    The FormIcon property is the graphical icon that appears in the upper left
    corner of the window.}

  {@TppFormWrapper.FormLeft

    The FormLeft property of a control is the horizontal coordinate of the left
    edge of the window relative to the screen. The value is expressed in
    pixels.}

  {@TppFormWrapper.FormPosition

    The FormPosition property determines the size and placement of the window
    when it appears in your application. These are the possible values:

    <Table>
    Value	               Meaning
    --------------       ---------
    poDesigned	         The form appears positioned on the screen and with the
                         same height and width as it had at design time.
    poDefault	           The form appears in a position on the screen and with a
                         height and width determined by Windows. Each time you
                         run the application, the form moves slightly down and
                         to the right. The right side of the form is always near
                         the far right side of the screen, and the bottom of the
                         form is always near the bottom of the screen,
                         regardless of the screen's resolution.
    poDefaultPosOnly	   The form displays with the size you created it at
                         design time, but Windows chooses its position on the
                         screen. Each time you run the application, the form
                         moves slightly down and to the right. When the form can
                         no longer move down and to the right and keep the same
                         size while remaining entirely visible on the screen,
                         the form displays at the top-left corner of the screen
    poDefaultSizeOnly	   The form appears in the position you left it at design
                         time, but Windows chooses its size. The right side of
                         the form is always near the far right side of the
                         screen, and the bottom of the form is always near the
                         bottom of the screen, regardless of the screen's
                         resolution.
    poScreenCenter	     The form remains the size you left it at design time,
                         but is positioned in the center of the screen.
    </Table>

    The default value is poDesigned.}

  {@TppFormWrapper.FormState

    The FormState determines the initial state of the form. These are the
    possible values:

    <Table>
    Value	        Meaning
    -----------   -------
    wsNormal   	  The form appears neither maximized nor minimized
    wsMaximized	  The form is maximized
    wsMinimized	  The form is minimized
    </Table>

    The default value is wsNormal.}

  {@TppFormWrapper.FormStyle

    Run-time only. The FormStyle describes the style of the form. The possible
    values are

    <Table>
    Value	       Meaning
    ----------   ---------
    fsNormal	   The form is neither an MDI parent window nor an MDI child window
    fsMDIChild	 The form is an MDI child window.
    fsMDIForm	   The form is an MDI parent window.
    fsStayOnTop  This form remains on top of the desktop and of other forms in
                 the project.
    </Table>

    The default value is wsNormal.

    Note: You should set the FormStyle property prior to the designer being
    shown for the first time.}

  {@TppFormWrapper.FormTag

    The FormTag property is not used by Delphi or ReportBuilder. It is provided
    for the convenience of storing additional integer value or pointer
    information for special needs in an application.}

  {@TppFormWrapper.FormTop

    The FormTop property of a control is the vertical coordinate of the top edge
    of the window relative to the screen. The value is expressed in pixels.}

  {@TppFormWrapper.FormWidth

    The FormWidth property of a control is the horizontal size of the window in
    pixels.}

  {@TppFormWrapper.OnActivate

    The OnActivate event for a form occurs when the form becomes active. A form
    becomes active when focus is transferred to it (when the user clicks on the
    form, for example).

    Note: The OnActivate event of the application (TApplication), not the form,
    occurs when Windows switches control from another application to your
    application.}

  {@TppFormWrapper.OnClose

    The OnClose event specifies which event handler to call when the window is
    about to close. A form is closed by the Close method or when the user
    chooses Close from the form's system menu.

    The TCloseEvent type points to a method that handles the closing of a form.
    The value of the Action parameter determines if the form actually closes.
    These are the possible values of Action::

    <Table>
    Value	      Meaning
    --------    ---------
    caNone	    The form is not allowed to close, so nothing happens.
    caHide	    The form is not closed, but just hidden. Your application can
                still access a hidden form.
    caFree	    The form is closed and all allocated memory for the form is
                freed.
    caMinimize	The form is minimized, rather than closed. This is the default
                action for MDI child forms.
    </Table>

    To close a form and free it in an OnClose event, set Action to caFree. The
    default is caHide.}

  {@TppFormWrapper.OnCloseQuery

    The OnCloseQuery event occurs when an action to close the form takes
    place--that is, when the Close method is called or when the user chooses
    Close from the form's System menu. An OnCloseQuery event handler contains a
    Boolean CanClose variable that determines whether a form is allowed to
    close. It's default value is True.

    You can use an OnCloseQuery event handler to ask users if they are sure they
    really want the form closed immediately. For example, you can use the
    handler to display a message box that prompts the user to save a file before
    closing the form.

    The TCloseQueryEvent type points to the method that determines whether a
    form can be closed. The value of the CanClose parameter determines if the
    form can close or not.}

  {@TppFormWrapper.OnCreate

    The OnCreate event specifies which event handler to call when the window is
    first created. You can write code in the event handler that sets initial
    values for properties and does any processing you want to occur before the
    user begins interacting with the window.
    When a form is being created and its Visible property is True, the following
    events occur in the order listed:

            OnCreate
            OnShow
            OnActivate}

  {@TppFormWrapper.OnDeactivate

    The OnDeactivate event for a form occurs when the form becomes inactive. A
    form becomes inactive when focus is transferred to another window.

    Note: The OnDeactivate event of the application (TApplication), not the
    form, occurs when Windows switches control from your application to another
    application.}

  {@TppFormWrapper.OnDestroy

    The OnDestroy event occurs when the designer is about to be destroyed. A
    form is destroyed by the Destroy, Free, or Release methods, or when the main
    form of the application is closed.}

  {@TppFormWrapper.OnHide

    The OnHide event occurs just before the form is hidden on the screen. Use
    the OnHide event to specify any special processing you want to happen just
    before the form disappears.}

  {@TppFormWrapper.OnResize

    The OnResize event occurs whenever the form is resized while an application
    is running. Use the OnResize event handler when you want something to happen
    in your application when the form is resized.}

  {@TppFormWrapper.OnShow

    The OnShow event occurs just before a form becomes visible. Use the OnShow
    event to specify any special processing you want to happen before the form
    appears.}


  {@TppFormWrapper.GetForm

    When the FormWrapper descendant class has instantiated the form, it should
    return the handle to the form via this function.  If the form has not been
    instantiated the descendant should return nil.  Usually a descendant will
    instantiate the form in the BeforeShowForm event.  The FormWrapper will then
    apply the pass-thru property and event values to the form before calling
    either Show or ShowModal.}

  TppFormWrapper = class(TppCommunicator)
    private
      FFormCaption: String;
      FFormIcon: TIcon;
      FFormPosition: TPosition;
      FFormHeight: Integer;
      FFormLeft: Integer;
      FFormState: TWindowState;
      FFormStyle: TFormStyle;
      FFormTag: LongInt;
      FFormTop: Integer;
      FFormWidth: Integer;

      {events}
      FOnActivate: TNotifyEvent;
      FOnClose: TCloseEvent;
      FOnCreate: TNotifyEvent;
      FOnDeactivate: TNotifyEvent;
      FOnDestroy: TNotifyEvent;
      FOnCloseQuery: TCloseQueryEvent;
      FOnHide: TNotifyEvent;
      FOnResize: TNotifyEvent;
      FOnShow: TNotifyEvent;

      procedure FormCloseEvent(Sender: TObject; var Action: TCloseAction);
      procedure IconChange(Sender: TObject);
      function  GetFormHeight: Integer;
      function  GetFormLeft: Integer;
      function  GetFormStyle: TFormStyle;
      function  GetFormTop: Integer;
      function  GetFormWidth: Integer;
      function  GetFormState: TWindowState;
      function  GetFormTag: LongInt;
      procedure SetFormCaption(aCaption: String);
      procedure SetFormStyle(aFormStyle: TFormStyle);
      procedure SetFormHeight(aHeight: Integer);
      procedure SetFormIcon(aIcon: TIcon);
      procedure SetFormLeft(aLeft: Integer);
      procedure SetFormPosition(aPosition: TPosition);
      procedure SetFormTop(aTop: Integer);
      procedure SetFormWidth(aWidth: Integer);
      procedure SetFormState(aFormState: TWindowState);
      procedure SetFormTag(aTag: LongInt);

      {events}
      procedure SetOnActivate(aNotifyEvent: TNotifyEvent);
      procedure SetOnClose(aCloseEvent: TCloseEvent);
      procedure SetOnCloseQuery(aCloseQueryEvent: TCloseQueryEvent);
      procedure SetOnCreate(aNotifyEvent: TNotifyEvent);
      procedure SetOnDeactivate(aNotifyEvent: TNotifyEvent);
      procedure SetOnDestroy(aNotifyEvent: TNotifyEvent);
      procedure SetOnHide(aNotifyEvent: TNotifyEvent);
      procedure SetOnResize(aNotifyEvent: TNotifyEvent);
      procedure SetOnShow(aNotifyEvent: TNotifyEvent);

    protected
      function  GetForm: TForm; virtual; abstract;

      procedure AfterShowForm; virtual;
      function  BeforeShowForm: Boolean; virtual;
      procedure PropertiesToForm; virtual;

      {form wrapper properties}
      property FormCaption: String read FFormCaption write SetFormCaption;
      property Form: TForm read GetForm;
      property FormStyle: TFormStyle read GetFormStyle write SetFormStyle default fsNormal;
      property FormIcon: TIcon read FFormIcon write SetFormIcon;
      property FormPosition: TPosition read FFormPosition write SetFormPosition;
      property FormHeight: Integer read GetFormHeight write SetFormHeight;
      property FormLeft: Integer read GetFormLeft write SetFormLeft;
      property FormTag: LongInt read GetFormTag write SetFormTag default 0;
      property FormTop: Integer read GetFormTop write SetFormTop;
      property FormWidth: Integer read GetFormWidth write SetFormWidth;
      property FormState: TWindowState read GetFormState write SetFormState default wsNormal;

      {events}
      property OnActivate: TNotifyEvent read FOnActivate write SetOnActivate;
      property OnClose: TCloseEvent read FOnClose write SetOnClose;
      property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write SetOnCloseQuery;
      property OnCreate: TNotifyEvent read FOnCreate write SetOnCreate;
      property OnDeactivate: TNotifyEvent read FOnDeactivate write SetOnDeactivate;
      property OnDestroy: TNotifyEvent read FOnDestroy write SetOnDestroy;
      property OnHide: TNotifyEvent read FOnHide write SetOnHide;
      property OnResize: TNotifyEvent read FOnResize write SetOnResize;
      property OnShow: TNotifyEvent read FOnShow write SetOnShow;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure BringToFront;
      procedure Close;
      procedure Hide;
      procedure Invalidate;
      procedure SendToBack;
      procedure SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
      procedure Show;
      procedure ShowModal;

  end; {class, TppFormWrapper}

implementation

{design-time bitmaps}
{$R ppIDEBmp.res}

{design-time strings}
{$R rbIDE.res}


{******************************************************************************
 *
 ** F O R M   W R A P P E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFormWrapper.Create }

constructor TppFormWrapper.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FFormCaption       := ppLoadStr(580); {Report Explorer}
  FFormHeight        := 400;
  FFormIcon          := TIcon.Create;
  FFormIcon.OnChange := IconChange;
  FFormLeft          := 100;
  FFormPosition      := poScreenCenter;
  FFormStyle         := fsNormal;
  FFormTop           := 50;
  FFormWidth         := 600;
  FFormState         := wsNormal;
  FFormTag           := 0;

  {events }
  FOnActivate        := nil;
  FOnClose           := nil;
  FOnCloseQuery      := nil;
  FOnCreate          := nil;
  FOnDeactivate      := nil;
  FOnDestroy         := nil;
  FOnHide            := nil;
  FOnShow            := nil;
  FOnResize          := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFormWrapper.Destroy }

destructor TppFormWrapper.Destroy;
begin

  FFormIcon.Free;

  inherited Destroy;

end; {destructor, Destroy}


{@TppFormWrapper.BeforeShowForm
 The FormWrapper class calls BeforeShowForm whenever the Show or ShowModal
 procedure is called. If this function returns False, the form will not be
 displayed. BeforeShowForm is usually used by a FormWrapper descendant to
 instantiate and configure the form.  After BeforeShowForm completes,
 FormWrapper applies the pass-thru property and event values.}

function TppFormWrapper.BeforeShowForm: Boolean;
begin
  Result := True;
end; {function, BeforeShowForm}


{@TppFormWrapper.AfterShowForm
 The FormWrapper class calls AfterShowForm after the Show or ShowModal procedure
 has completed. AfterShowForm is always called after the form has closed,
 regardless of whether the form was shown modally or non-modally.}

procedure TppFormWrapper.AfterShowForm;
begin

end; {function, AfterShowForm}


{@TppFormWrapper.Show
 The Show method makes the designer visible by setting its Visible property to
 True. If the Show method of a form is called and the form is somehow obscured,
 Show tries to make the form visible by bringing it to the front with the
 BringToFront method.}

procedure TppFormWrapper.Show;
begin

  if not(BeforeShowForm) then Exit;

  PropertiesToForm;

  if Assigned(FOnCreate) and (GetForm <> nil) then FOnCreate(GetForm);

  if (GetForm <> nil) then
    begin
      GetForm.OnClose := FormCloseEvent;

      GetForm.Show;
    end;

end; {procedure, Show}


{@TppFormWrapper.ShowModal
 The ShowModal method makes a form the active form, just like Show, but also
 makes the form modal; therefore the user must put the form away before the
 application can continue to run.}

procedure TppFormWrapper.ShowModal;
begin

  if not(BeforeShowForm) then Exit;

  try
    PropertiesToForm;

    if Assigned(FOnCreate) and (GetForm <> nil) then FOnCreate(GetForm);

    GetForm.ShowModal;

  finally
    AfterShowForm;

  end;

end; {procedure, ShowModal}

{------------------------------------------------------------------------------}
{ TppFormWrapper.FormCloseEvent }

procedure TppFormWrapper.FormCloseEvent(Sender: TObject; var Action: TCloseAction);
begin

  if Assigned(FOnClose) then FOnClose(Sender, Action);

  AfterShowForm;

end; {procedure, FormCloseEvent}

{------------------------------------------------------------------------------}
{ TppFormWrapper.PropertiesToForm }

procedure TppFormWrapper.PropertiesToForm;
var
  lForm: TForm;
begin

  lForm := GetForm;

  if (lForm = nil) then Exit;

  if (csDesigning in ComponentState) then Exit;

  lForm.Caption := FFormCaption;

  if (FFormIcon <> nil) and not(FormIcon.Empty) then
    lForm.Icon := FFormIcon;

  lForm.Tag := FFormTag;

   {pass-thru events}
   lForm.OnActivate    := FOnActivate;
   lForm.OnClose       := FOnClose;
   lForm.OnCloseQuery  := FOnCloseQuery;
   lForm.OnDeactivate  := FOnDeactivate;
   lForm.OnHide        := FOnHide;
   lForm.OnResize      := FOnResize;
   lForm.OnShow        := FOnShow;

end; {procedure, PropertiesToForm}


{@TppFormWrapper.Close
 The Close method closes the form. Calling the Close method on a form
 corresponds to the user selecting the Close menu item on the form's System
 menu. The Close method first calls the CloseQuery method to determine if the
 form can close. If CloseQuery returns False, the close operation is aborted.
 Otherwise, if CloseQuery returns True, the code attached to the OnClose event
 is executed. The CloseAction parameter of the OnClose event controls how the
 form is actually closed.}

procedure TppFormWrapper.Close;
begin
  if (GetForm <> nil) then
    GetForm.Close;
end; {procedure, Close}


{@TppFormWrapper.Hide
 The Hide method makes the window invisible by setting the Visible property of
 the form to False. Although a form or control that is hidden is not visible,
 you can still set the properties of the form or control, or call its methods.}

procedure TppFormWrapper.Hide;
begin
  if (GetForm <> nil) then
    GetForm.Hide;
end; {procedure, Hide}


{@TppFormWrapper.Invalidate
 The Invalidate method method forces the window to repaint as soon as possible.}

procedure TppFormWrapper.Invalidate;
begin
  if (GetForm <> nil) then
    GetForm.Invalidate;
end; {procedure, Invalidate}


{@TppFormWrapper.BringToFront
 The BringToFront method puts the window in front of all other forms.
 BringToFront is especially useful for making certain that the window is
 visible.}

procedure TppFormWrapper.BringToFront;
begin
  if (GetForm <> nil) then
    GetForm.BringToFront;
end; {procedure, BringToFront}


{@TppFormWrapper.SendToBack
 The SendToBack method puts the window behind all other forms.}

procedure TppFormWrapper.SendToBack;
begin
  if (GetForm <> nil) then
    GetForm.SendToBack;
end; {procedure, SendToBack}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormStyle }

function TppFormWrapper.GetFormStyle: TFormStyle;
begin
  if (GetForm = nil) then
    Result := FFormStyle
  else
    Result := GetForm.FormStyle;
end; {function, GetFormStyle}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormHeight }

function TppFormWrapper.GetFormHeight: Integer;
begin
  if (GetForm = nil) then
    Result := FFormHeight
  else
    Result := GetForm.Height;
end; {function, GetFormHeight}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormLeft }

function TppFormWrapper.GetFormLeft: Integer;
begin
  if (GetForm = nil) then
    Result := FFormLeft
  else
    Result := GetForm.Left;
end; {function, GetFormLeft}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormTop }

function TppFormWrapper.GetFormTop: Integer;
begin
  if (GetForm = nil) then
    Result := FFormTop
  else
    Result := GetForm.Top;
end; {function, GetFormTop}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormWidth }

function TppFormWrapper.GetFormWidth: Integer;
begin
  if (GetForm = nil) then
    Result := FFormWidth
  else
    Result := GetForm.Width;
end; {function, GetFormWidth}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormState }

function TppFormWrapper.GetFormState: TWindowState;
begin
  if (GetForm = nil) then
    Result := FFormState
  else
    Result := GetForm.WindowState;
end; {function, GetFormState}

{------------------------------------------------------------------------------}
{ TppFormWrapper.GetFormTag }

function TppFormWrapper.GetFormTag: LongInt;
begin
  if (GetForm = nil) then
    Result := FFormTag
  else
    Result := GetForm.Tag;
end; {function, GetFormTag}


{@TppFormWrapper.SetBounds
 The SetBounds method sets window boundary properties, FormLeft, FormTop,
 FormWidth, and FormHeight, to the values passed in aLeft, aTop, aWidth, and
 aHeight, respectively.}

procedure TppFormWrapper.SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin
  if (GetForm <> nil) then
    GetForm.SetBounds(aLeft, aTop, aWidth, aHeight);
end; {procedure, SetBounds}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormCaption }

procedure TppFormWrapper.SetFormCaption(aCaption: String);
begin
  FFormCaption := aCaption;

  if (GetForm <> nil) then
    GetForm.Caption := FFormCaption;
end; {procedure, SetFormCaption}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormStyle }

procedure TppFormWrapper.SetFormStyle(aFormStyle: TFormStyle);
begin
  FFormStyle := aFormStyle;

  if (GetForm <> nil) then
    GetForm.FormStyle := FFormStyle;
end; {procedure, SetFormStyle}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormHeight }

procedure TppFormWrapper.SetFormHeight(aHeight: Integer);
begin
  FFormHeight := aHeight;

  if (GetForm <> nil) then
    GetForm.Height := FFormHeight;
end; {procedure, SetFormHeight}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormIcon }

procedure TppFormWrapper.SetFormIcon(aIcon: TIcon);
begin
  FFormIcon.Assign(aIcon);
end; {procedure, SetFormIcon}

{------------------------------------------------------------------------------}
{ TppFormWrapper.IconChange }

procedure TppFormWrapper.IconChange(Sender: TObject);
begin
  if (GetForm <> nil) then
    GetForm.Icon := FFormIcon;
end; {procedure, IconChange}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormLeft }

procedure TppFormWrapper.SetFormLeft(aLeft: Integer);
begin
  FFormLeft:= aLeft;

  if (GetForm <> nil) then
    GetForm.Left := FFormLeft;
end; {procedure, SetFormLeft}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormTop }

procedure TppFormWrapper.SetFormTop(aTop: Integer);
begin
  FFormTop:= aTop;

  if (GetForm <> nil) then
    GetForm.Top := FFormTop;
end; {procedure, SetFormTop}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormWidth }

procedure TppFormWrapper.SetFormWidth(aWidth: Integer);
begin
  FFormWidth := aWidth;

  if (GetForm <> nil) then
    GetForm.Width := FFormWidth;
end; {procedure, SetFormWidth}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormState }

procedure TppFormWrapper.SetFormState(aFormState: TWindowState);
begin
  FFormState := aFormState;

  if (GetForm <> nil) then
    GetForm.WindowState := aFormState;
end; {procedure, SetFormState}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormTag }

procedure TppFormWrapper.SetFormTag(aTag: LongInt);
begin
  FFormTag := aTag;

  if (GetForm <> nil) then
    GetForm.Tag := aTag;

end; {procedure, SetFormTag}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetFormPosition }

procedure TppFormWrapper.SetFormPosition(aPosition: TPosition);
begin

  FFormPosition := aPosition;

  if (GetForm <> nil) then
    GetForm.Position := FFormPosition;


end; {procedure, SetFormPosition}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnCreate }

procedure TppFormWrapper.SetOnCreate(aNotifyEvent: TNotifyEvent);
begin
  FOnCreate := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnCreate := FOnCreate;

end; {procedure, SetOnCreate}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnDestroy }

procedure TppFormWrapper.SetOnDestroy(aNotifyEvent: TNotifyEvent);
begin
  FOnDestroy := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnDestroy := FOnDestroy;

end; {procedure, SetOnDestroy}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnActivate }

procedure TppFormWrapper.SetOnActivate(aNotifyEvent: TNotifyEvent);
begin
  FOnActivate := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnActivate := FOnActivate;

end; {procedure, SetOnActivate}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnShow }

procedure TppFormWrapper.SetOnShow(aNotifyEvent: TNotifyEvent);
begin

  FOnShow := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnShow := FOnShow;

end; {procedure, SetOnShow}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnResize }

procedure TppFormWrapper.SetOnResize(aNotifyEvent: TNotifyEvent);
begin

  FOnResize := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnResize := FOnResize;

end; {procedure, SetOnResize}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnHide }

procedure TppFormWrapper.SetOnHide(aNotifyEvent: TNotifyEvent);
begin

  FOnHide := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnShow := FOnHide;

end; {procedure, SetOnHide}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnDeactivate }

procedure TppFormWrapper.SetOnDeactivate(aNotifyEvent: TNotifyEvent);
begin
  FOnDeactivate := aNotifyEvent;

  if (GetForm <> nil) then
    GetForm.OnDeactivate := FOnDeactivate;

end; {procedure, SetOnDeactivate}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnClose }

procedure TppFormWrapper.SetOnClose(aCloseEvent: TCloseEvent);
begin
  FOnClose := aCloseEvent;

  if (GetForm <> nil) then
    GetForm.OnClose := FOnClose;

end; {procedure, SetOnClose}

{------------------------------------------------------------------------------}
{ TppFormWrapper.SetOnCloseQuery }

procedure TppFormWrapper.SetOnCloseQuery(aCloseQueryEvent: TCloseQueryEvent);
begin
  FOnCloseQuery := aCloseQueryEvent;

  if (GetForm <> nil) then
    GetForm.OnCloseQuery := FOnCloseQuery;

end; {procedure, SetOnCloseQuery}



end.
