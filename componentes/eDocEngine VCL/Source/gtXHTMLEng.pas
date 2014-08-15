{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

unit gtXHTMLEng;

interface
uses Classes, gtConsts, gtHTMLEng, gtDocConsts, gtDocResStrs;

type
  TgtXHTMLEngine = class(TgtHTMLEngine)
  protected
  	function AddXHTMLHeader: String; override;
		function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses gtXHTMLEngDlg;

{ TgtXHTMLEngine }

function TgtXHTMLEngine.AddXHTMLHeader: String;
begin
	Result := '<?xml version="1.0" encoding="UTF-8"?>' + CRLF +
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">';
end;

constructor TgtXHTMLEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileExtension := 'htm';
  FileDescription := SXHTMLDescription;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 104);
{$ENDIF}
end;

function TgtXHTMLEngine.ShowSetupModal: Word;
begin
  with TgtXHTMLEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
