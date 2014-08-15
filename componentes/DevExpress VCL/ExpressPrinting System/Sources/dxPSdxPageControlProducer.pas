{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSdxPageControlProducer;

interface

{$I cxVer.inc}

uses 
  Classes, Controls, dxPSContainerLnk, dxPageControl;

type
  TdxPSdxPageControlIterator = class(TdxPSWinControlIterator)
  private
    function GetPageControl: TdxPageControl;
  protected
    function GetControl(Index: Integer): TControl; override;
    function GetControlCount: Integer; override;
  public
    property PageControl: TdxPageControl read GetPageControl;  
  end;

  TdxPSdxTabSheetProducer = class(TdxPSRootContainerProducer)
  public
    function Control: TdxTabSheet; reintroduce; overload;
    class function ControlClass: TControlClass; override;
  end;
  
  TdxPSdxPageControlProducer = class(TdxPSRootContainerProducer)
  protected
    function CanProcessChild(AChildControl: TControl): Boolean; override;
    class function IteratorClass: TdxPSWinControlIteratorClass; override;
  public
    function Control: TdxPageControl; reintroduce; overload;
    class function ControlClass: TControlClass; override;
  end;
    
implementation

{ TdxPSdxPageControlIterator }

function TdxPSdxPageControlIterator.GetControl(Index: Integer): TControl;
begin
  Result := PageControl.ActivePage;
end;

function TdxPSdxPageControlIterator.GetControlCount: Integer; 
begin
  Result := Ord(PageControl.PageCount > 0);
end;

function TdxPSdxPageControlIterator.GetPageControl: TdxPageControl;
begin
  Result := TdxPageControl(Control);
end;

{ TdxPSdxTabSheetProducer }

function TdxPSdxTabSheetProducer.Control: TdxTabSheet;
begin
  Result := inherited Control as TdxTabSheet;
end;

class function TdxPSdxTabSheetProducer.ControlClass: TControlClass;
begin
  Result := TdxTabSheet;
end;

{ TdxPSdxPageControlProducer }

function TdxPSdxPageControlProducer.Control: TdxPageControl; 
begin
  Result := inherited Control as TdxPageControl; 
end;
                 
class function TdxPSdxPageControlProducer.ControlClass: TControlClass;
begin
  Result := TdxPageControl;
end;

function TdxPSdxPageControlProducer.CanProcessChild(AChildControl: TControl): Boolean;
begin
  Result := AChildControl = Control.ActivePage;
end;

class function TdxPSdxPageControlProducer.IteratorClass: TdxPSWinControlIteratorClass;
begin
  Result := TdxPSdxPageControlIterator;
end;

procedure RegisterAssistants;
begin
  TdxPSdxTabSheetProducer.Register;
  TdxPSdxPageControlProducer.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSdxPageControlProducer.Unregister;
  TdxPSdxTabSheetProducer.Unregister;
end;

initialization
  RegisterAssistants;
  dxPSContainerLnk.dxPSRegisterContainers([TdxTabSheet, TdxPageControl]);

finalization
  dxPSContainerLnk.dxPSUnregisterContainers([TdxTabSheet, TdxPageControl]);
  UnregisterAssistants;

end.

