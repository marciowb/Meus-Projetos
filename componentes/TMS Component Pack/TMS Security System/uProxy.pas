{***********************************************************************}
{ TMS Security System                                                   }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}

unit uProxy;

interface

uses
  Classes;

type
  TuilProxy = class(TComponent)
  private
    FVisible: Boolean;
    FEnabled: Boolean;
    FSetVisible: TNotifyEvent;
    FSetEnabled: TNotifyEvent;
    FReadOnly: Boolean;
    FSetReadOnly: TNotifyEvent;
    procedure SetEnabled(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
  protected
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property Visible: Boolean read FVisible write SetVisible;
    property OnSetEnabled: TNotifyEvent read FSetEnabled write FSetEnabled;
    property OnSetVisible: TNotifyEvent read FSetVisible write FSetVisible;
    property OnSetReadOnly: TNotifyEvent read FSetReadOnly write FSetReadOnly;
  end;

implementation



{ TuilProxy }

procedure TuilProxy.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  if Assigned(FSetEnabled) then
    FSetEnabled(Self);
end;

procedure TuilProxy.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
  if Assigned(FSetReadOnly) then
    FSetReadOnly(Self);
end;

procedure TuilProxy.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  if Assigned(FSetVisible) then
    FSetVisible(Self);
end;

end.
