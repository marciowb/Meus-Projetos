{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarDsgnUtils;

{$I cxVer.inc}

interface

uses
  Classes,
 {$IFDEF DELPHI6}
 DesignIntf, ComponentDesigner,
 DesignEditors
 {$ELSE}
 DsgnIntf, LibIntf
 {$ENDIF};

type
 {$IFDEF DELPHI6}
  IDelphiDesigner = IDesigner;
  IDelphiIDE = IDesignEnvironment;
  ILibrary = IComponentDesigner;
  IPersistent = TPersistent;
  IComponent = TComponent;
 {$ELSE}
  IDelphiDesigner = IFormDesigner;
 {$ENDIF}

function MakeIComponent(Component: TComponent): IComponent;
function MakeIPersistent(Persistent: TPersistent): IPersistent;
function TryExtractComponent(Component: IPersistent): TComponent;
function TryExtractPersistent(Persistent: IPersistent): TPersistent;

implementation

function MakeIComponent(Component: TComponent): IComponent;
begin
 {$IFDEF DELPHI6}
  Result := Component;
 {$ELSE}
  Result := DsgnIntf.MakeIComponent(Component);
 {$ENDIF}
end;

function MakeIPersistent(Persistent: TPersistent): IPersistent;
begin
 {$IFDEF DELPHI6}
  Result := Persistent;
 {$ELSE}
  Result := DsgnIntf.MakeIPersistent(Persistent);
 {$ENDIF}
end;

function TryExtractComponent(Component: IPersistent): TComponent;
begin
 {$IFDEF DELPHI6}
  Result := TComponent(Component);
 {$ELSE}
  Result := DsgnIntf.TryExtractComponent(IComponent(Component));
 {$ENDIF}
end;

function TryExtractPersistent(Persistent: IPersistent): TPersistent;
begin
 {$IFDEF DELPHI6}
  Result := Persistent;
 {$ELSE}  
  Result := DsgnIntf.TryExtractPersistent(Persistent);
 {$ENDIF}
end;

end.

