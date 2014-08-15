{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackgroundThreadSync;

interface

uses
  SyncObjs;

type

  {@TppThreadSync }

  TppThreadSync = class(TEvent)
    public
      constructor Create; virtual;

    end;

implementation

uses
  Windows,
  Messages;

{ TppThreadSync }

constructor TppThreadSync.Create;
begin

  inherited Create(nil, False, False, 'ppThreadSync');

end;

end.
