{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignerInterface;

interface

type

  IppDesigner = interface
  ['{5C264576-4DE0-43EE-A8B6-33D9D386DFC2}']

    procedure iMessageNotify(aMessageID: Cardinal; aWParam: Word; aOParam: TObject);
    procedure iBeforePropertyChange(aPropertyName: String; aObject: TObject);
    procedure iAfterPropertyChange;
  end;

implementation

end.
