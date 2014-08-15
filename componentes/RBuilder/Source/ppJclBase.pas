{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the Project JEDI Code Library (JCL). The original header appears     }
{ in the box below.                                                                                }
{                                                                                                  }
{ original unit: JclBase.pas                                                                       }
{                                                                                                  }
{ This unit is a subset of the original. It contains only types, classes and methods,              }
{ required to support the JvInspector and related classes. A prefix of pp has been added           }
{ to all classes and methods to differentiate them from the original. This has been done to        }
{ avoid conflicts for users that install ReportBuilder and the JCL.                                }
{                                                                                                  }
{**************************************************************************************************}

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclBase.pas.                                                                }
{                                                                                                  }
{ The Initial Developer of the Original Code is documented in the accompanying                     }
{ help file JCL.chm. Portions created by these individuals are Copyright (C) of these individuals. }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ This unit contains generic JCL base classes and routines to support earlier                      }
{ versions of Delphi as well as FPC.                                                               }
{                                                                                                  }
{ Unit owner: Marcel van Brakel                                                                    }
{ Last modified: July 5, 2002                                                                      }
{                                                                                                  }
{**************************************************************************************************}

unit ppJclBase;

interface

uses
  SysUtils;

//--------------------------------------------------------------------------------------------------
// EppJclError
//--------------------------------------------------------------------------------------------------

type
  EppJclError = class (Exception)
  public
    constructor CreateResRec(ResStringRec: PResStringRec);
    constructor CreateResRecFmt(ResStringRec: PResStringRec; const Args: array of const);
  end;


implementation

//==================================================================================================
// EppJclError
//==================================================================================================

constructor EppJclError.CreateResRec(ResStringRec: PResStringRec);
begin
  inherited Create(LoadResString(ResStringRec));
end;

constructor EppJclError.CreateResRecFmt(ResStringRec: PResStringRec; const Args: array of const);
begin
  inherited CreateFmt(LoadResString(ResStringRec), Args);
end;


end.
