{**************************************************************************}
{ TatPictureContainer component                                              }
{ for Delphi & C++Builder                                                  }
{ version 1.0                                                              }
{                                                                          }
{ Copyright © 2001 - 2004                                                  }
{   TMS Software                                                           }
{   Email : info@tmssoftware.com                                           }
{   Web : http://www.tmssoftware.com                                       }
{                                                                          }
{ The source code is given as is. The author is not responsible            }
{ for any possible damage done due to the use of this code.                }
{ The component can be freely used in any application. The complete        }
{ source code remains property of the author and may not be distributed,   }
{ published, given or sold in any form as such. No parts of the source     }
{ code can be included in any other component or application without       }
{ written authorization of the author.                                     }
{**************************************************************************}

unit atPictureContainer;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComObj, ActiveX
  {$IFDEF USEWININET}
  , WinInet
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  , System.Runtime.InteropServices
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.


type
  {$I atWIIF.PAS}

  TatPictureItem = class(TCollectionItem)
  private
    FPicture: THTMLPicture;
    FTag: Integer;
    FName: string;
    procedure SetPicture(const Value: THTMLPicture);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Picture: THTMLPicture read FPicture write SetPicture;
    property Name: string read FName write FName;
    property Tag: Integer read FTag write FTag;
  end;

  TatPictureCollection = class(TCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TatPictureItem;
    procedure SetItem(Index: Integer; Value: TatPictureItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner:TComponent);
    function Add: TatPictureItem;
    function Insert(index:integer): TatPictureItem;
    property Items[Index: Integer]: TatPictureItem read GetItem write SetItem;
    function Animate:Boolean;
  end;

  TatPictureContainer = class(TComponent)
  private
    FItems: TatPictureCollection;
    procedure SetItems(const Value: TatPictureCollection);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetVersionNr: Integer;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindPicture(s:string): THTMLPicture; virtual;
  published
    { Published declarations }
    property Items: TatPictureCollection read FItems write SetItems;
    property Version: string read GetVersion write SetVersion;
  end;


implementation

{$IFDEF TMSDOTNET}
uses
  Types, WinUtils;
{$ENDIF}  

{$I atWIIMPL.PAS}

{ TatPictureItem }

procedure TatPictureItem.Assign(Source: TPersistent);
begin
  Name := (Source as TatPictureItem).Name;
  Tag := (Source as TatPictureItem).Tag;
  Picture.Assign((Source as TatPictureItem).Picture)
end;

constructor TatPictureItem.Create(Collection: TCollection);
begin
  inherited;
  FPicture := THTMLPicture.Create;
end;

destructor TatPictureItem.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TatPictureItem.SetPicture(const Value: THTMLPicture);
begin
  FPicture.Assign(Value);
end;

{ TatPictureCollection }

function TatPictureCollection.Add: TatPictureItem;
begin
  Result := TatPictureItem(inherited Add);
end;

function TatPictureCollection.Animate: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Count do
  begin
    if Items[i - 1].Picture.Step then
      Result := True;
  end;

end;

constructor TatPictureCollection.Create(AOwner: TComponent);
begin
  inherited Create(TatPictureItem);
  FOwner := AOwner;
end;

function TatPictureCollection.GetItem(Index: Integer): TatPictureItem;
begin
  Result := TatPictureItem(inherited Items[Index]);
end;

function TatPictureCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TatPictureCollection.Insert(index: Integer): TatPictureItem;
begin
{$IFDEF DELPHI4_LVL}
  Result := TatPictureItem(inherited Insert(Index));
{$ELSE}
  Result := TatPictureItem(inherited Add);
{$ENDIF}  
end;

procedure TatPictureCollection.SetItem(Index: Integer;
  Value: TatPictureItem);
begin
  inherited SetItem(Index, Value);
end;

{ TatPictureContainer }

constructor TatPictureContainer.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TatPictureCollection.Create(Self);
end;

destructor TatPictureContainer.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TatPictureContainer.FindPicture(s: string): THTMLPicture;
var
  i: Integer;
begin
  Result := nil;
  s := Uppercase(s);
  i := 1;
  while i <= Items.Count do
  begin
    if Uppercase(Items.Items[i - 1].Name) = s then
    begin
      Result := Items.Items[i - 1].Picture;
      Break;
    end;
    Inc(i);
  end;
end;

procedure TatPictureContainer.SetItems(const Value: TatPictureCollection);
begin
  FItems := Value;
end;

function TatPictureContainer.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TatPictureContainer.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TatPictureContainer.SetVersion(const Value: string);
begin

end;

end.
