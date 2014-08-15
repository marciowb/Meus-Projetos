{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2007 Gnostice Information Technologies Private Limited  }
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

unit gtFR3ExpReg;

interface
uses
  Classes, gtFR3XportIntf;

procedure Register;

implementation

procedure Register;
begin
	RegisterComponents('eDocEngine Additional', [TgtFR3ExportInterface]);
end;
end.
 