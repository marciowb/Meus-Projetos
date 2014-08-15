unit fCustomFieldEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, TypInfo,
  DB, atMetaSql, fCustomEditor;

const
  ftAllowedFieldTypes = [ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftDate, ftTime, ftDateTime,
    ftAutoInc, ftMemo, ftVariant];

  ftAggregFieldTypes = [ftUnknown, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat,
    ftCurrency, ftDate, ftTime, ftDateTime, ftAutoInc];

type
  TfmCustomFieldEditor = class(TfmCustomEditor)
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmCustomFieldEditor: TfmCustomFieldEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCustomFieldEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmCustomFieldEditor.Localize;
begin
  Self.Caption := _str('fmCustomFieldEditor.Self.Caption');
end;

end.

