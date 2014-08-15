{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }
  
unit ppTB2Consts;
{ $jrsoftware: tb2k/Source/TB2Consts.pas,v 1.7 2002/11/14 18:07:19 jr Exp $ }

interface

resourcestring
  { Exceptions }
  ppSTBToolbarIndexOutOfBounds = 'Toolbar item index out of range';
  ppSTBToolbarItemReinserted = 'Toolbar item already inserted';
  ppSTBViewerNotFound = 'An item viewer associated the specified item could not be found';

  { TTBChevronItem }
  ppSTBChevronItemMoreButtonsHint = 'More Buttons|';

  { TTBMRUListItem }
  ppSTBMRUListItemDefCaption = '(MRU List)';

  { TTBMDIWindowItem }
  ppSTBMDIWindowItemDefCaption = '(Window List)';

  { TTBDock exception messages }
  ppSTBDockParentNotAllowed = 'A TTBDock control cannot be placed inside a tool window or another TTBDock';
  ppSTBDockCannotChangePosition = 'Cannot change Position of a TTBDock if it already contains controls';

  { TTBCustomDockableWindow exception messages }
  ppSTBToolwinNameNotSet = 'Cannot save dockable window''s position because Name property is not set';
  ppSTBToolwinDockedToNameNotSet = 'Cannot save dockable window''s position because DockedTo''s Name property not set';

implementation

end.
