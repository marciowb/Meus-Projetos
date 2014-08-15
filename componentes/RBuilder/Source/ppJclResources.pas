{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the Project JEDI Code Library (JCL). The original header appears     }
{ in the box below.                                                                                }
{                                                                                                  }
{ original unit: JclResources.pas                                                                  }
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
{ The Original Code is JclResources.pas.                                                           }
{                                                                                                  }
{ The Initial Developer of the Original Code is documented in the accompanying                     }
{ help file JCL.chm. Portions created by these individuals are Copyright (C) of these individuals. }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Unit which provides a central place for all resource strings used in the JCL                     }
{                                                                                                  }
{ Unit owner: Marcel van Brakel                                                                    }
{ Last modified: September 5, 2002                                                                 }
{                                                                                                  }
{**************************************************************************************************}

unit ppJclResources;

interface

//--------------------------------------------------------------------------------------------------
// JclRTTI
//--------------------------------------------------------------------------------------------------

resourcestring
  ppJclRsRTTIValueOutOfRange =   'Value out of range (%s).';
  ppJclRsRTTIUnknownIdentifier = 'Unknown identifier ''%s''.';
  ppJclRsRTTIInvalidGUIDString = 'Invalid conversion from string to GUID (%s).';
  ppJclRsRTTIInvalidBaseType   = 'Invalid base type (%s is of type %s).';

  ppJclRsRTTIVar =               'var ';
  ppJclRsRTTIConst =             'const ';
  ppJclRsRTTIArrayOf =           'array of ';
  ppJclRsRTTIOut =               'out ';
  ppJclRsRTTIBits =              'bits';
  ppJclRsRTTIOrdinal =           'ordinal=';
  ppJclRsRTTITrue =              'True';
  ppJclRsRTTIFalse =             'False';
  ppJclRsRTTITypeError =         '???';
  ppJclRsRTTITypeInfoAt =        'Type info: %p';

  ppJclRsRTTIPropRead =          'read';
  ppJclRsRTTIPropWrite =         'write';
  ppJclRsRTTIPropStored =        'stored';

  ppJclRsRTTIField =             'field';
  ppJclRsRTTIStaticMethod =      'static method';
  ppJclRsRTTIVirtualMethod =     'virtual method';

  ppJclRsRTTIIndex =             'index';
  ppJclRsRTTIDefault =           'default';

  ppJclRsRTTIName =              'Name: ';
  ppJclRsRTTIType =              'Type: ';
  ppJclRsRTTIFlags =             'Flags: ';
  ppJclRsRTTIGUID =              'GUID: ';
  ppJclRsRTTITypeKind =          'Type kind: ';
  ppJclRsRTTIOrdinalType =       'Ordinal type: ';
  ppJclRsRTTIMinValue =          'Min value: ';
  ppJclRsRTTIMaxValue =          'Max value: ';
  ppJclRsRTTINameList =          'Names: ';
  ppJclRsRTTIClassName =         'Class name: ';
  ppJclRsRTTIParent =            'Parent: ';
  ppJclRsRTTIPropCount =         'Property count: ';
  ppJclRsRTTIUnitName =          'Unit name: ';
  ppJclRsRTTIBasedOn =           'Based on: ';
  ppJclRsRTTIFloatType =         'Float type: ';
  ppJclRsRTTIMethodKind =        'Method kind: ';
  ppJclRsRTTIParamCount =        'Parameter count: ';
  ppJclRsRTTIReturnType =        'Return type: ';
  ppJclRsRTTIMaxLen =            'Max length: ';
  ppJclRsRTTIElSize =            'Element size: ';
  ppJclRsRTTIElType =            'Element type: ';
  ppJclRsRTTIElNeedCleanup =     'Elements need clean up: ';
  ppJclRsRTTIVarType =           'Variant type: ';


implementation

end.
