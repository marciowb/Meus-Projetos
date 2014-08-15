unit ppPopupMenuBase;

interface

uses
  Classes,
  ppIniStorage,
  ppTBX;

type

  {TppPopupMenuBase}
  TppPopupMenuBase = class(TppTBXPopupMenu)
  protected
    procedure CreateItems; virtual;
  public
    constructor Create(Owner: TComponent); override;
    function AddChildItem: TppTBXItem;
    function AddSeparator: TppTBXSeparatorItem;
    function InsertSeparator(aIndex: Integer): TppTBXSeparatorItem;
    procedure LanguageChanged; virtual;
  end;

implementation

{******************************************************************************
 *
 **  Popup Menu Base
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPopupMenuBase.Create}

constructor TppPopupMenuBase.Create(Owner: TComponent);
begin

  inherited;

  CreateItems;

end;

{------------------------------------------------------------------------------}
{ TppPopupMenuBase.AddChildItem}

function TppPopupMenuBase.AddChildItem: TppTBXItem;
begin
  Result := TppTBXItem.Create(nil);
  Items.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppPopupMenuBase.AddSeparator}

function TppPopupMenuBase.AddSeparator: TppTBXSeparatorItem;
begin
  Result := TppTBXSeparatorItem.Create(nil);
  Result.Tag := -1;
  Items.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppPopupMenuBase.CreateControls}

procedure TppPopupMenuBase.CreateItems;
begin

  {descendents can add code here}

end;

{------------------------------------------------------------------------------}
{ TppDesignPopupMenu.InsertSeparator}

function TppPopupMenuBase.InsertSeparator(aIndex: Integer): TppTBXSeparatorItem;
begin

  Result := TppTBXSeparatorItem.Create(nil);
  Items.Insert(aIndex, Result);

end;

{------------------------------------------------------------------------------}
{ TppPopupMenuBase.LanguageChanged}

procedure TppPopupMenuBase.LanguageChanged;
begin

  {descendents can add code here}

end;



end.
