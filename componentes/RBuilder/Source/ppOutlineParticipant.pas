{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineParticipant;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppComm,
  ppOutlineSettings;

type

  { IppOutlineParticipant }

  IppOutlineParticipant = interface
    ['{7AAD7F8C-39CA-402C-B816-D5EACE900829}']

    function iOutlineGetChildren: TList;
    function iOutlineGetParent: TppCommunicator;
    function iOutlineNodeCreatorClass: TComponentClass;
    function iOutlineSettings: TppOutlineSettings;
    procedure iOutlineSettingsChanged;

  end; { interface, IppOutlineParticipant }

implementation

end.

