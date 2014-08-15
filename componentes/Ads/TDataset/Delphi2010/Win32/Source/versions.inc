
{$IFDEF VER80}
   {$DEFINE ADSDELPHI1}
{$ENDIF}
{$IFDEF VER90}
   {$DEFINE ADSDELPHI2}
{$ENDIF}
{$IFDEF VER100}
   {$DEFINE ADSDELPHI3}
{$ENDIF}
{$IFDEF VER120}
   {$DEFINE ADSDELPHI4}
{$ENDIF}
{$IFDEF VER130}
   {$DEFINE ADSDELPHI5}
{$ENDIF}
{$IFDEF VER140}
   {$DEFINE ADSDELPHI6}
{$ENDIF}
{$IFDEF VER150}
   {$DEFINE ADSDELPHI7}
{$ENDIF}
{$IFDEF VER170}
   {$DEFINE ADSDELPHI2005}
{$ENDIF}
{$IFDEF VER180}
   {$DEFINE ADSDELPHI2006}
{$ENDIF}
{$IFDEF VER185}
   {$DEFINE ADSDELPHI2007}
   // In Delphi2007 both VER180 and VER185 are defined because it is
   // a "non-breaking" release. This messes with our logic below, so
   // undefine ADSDELPHI2006 here.
   // Here.
   {$UNDEF ADSDELPHI2006}
{$ENDIF}
{$IFDEF VER200}
   {$DEFINE ADSDELPHI2008}
{$ENDIF}
{$IFDEF VER210}
   {$DEFINE ADSDELPHI2010}
{$ENDIF}
{$IFDEF VER220}
   {$DEFINE ADSDELPHIXE}
{$ENDIF}
{$IFDEF VER93}
   {$DEFINE ADSCBUILDER1}
{$ENDIF}
{$IFDEF VER110}
   {$DEFINE ADSCBUILDER3}
   {$ObjExportAll On}
{$ENDIF}
{$IFDEF VER125}
   {$DEFINE ADSCBUILDER4}
   {$ObjExportAll On}
{$ENDIF}
{$IFDEF CBUILDER}
   {$ObjExportAll On}
{$ENDIF}

{ !!! BIG TBD JTH !!! }
{$IFDEF FPC}
   {$DEFINE ADSDELPHI2007}

   {$IFDEF LINUX}
      {$LINKLIB stdc++}
      {$LINKLIB adsloc}
   {$ENDIF}
{$ENDIF}

{$IFNDEF ADSDELPHI1}
   {$IFNDEF ADSDELPHI2}
      {$IFNDEF ADSCBUILDER1}

         {$DEFINE ADSDELPHI3_OR_NEWER }
         {$IFNDEF ADSDELPHI3 }

            {$DEFINE ADSCBUILDER3_OR_NEWER }
            {$IFNDEF ADSCBUILDER3}

               {$DEFINE ADSDELPHI4_OR_NEWER }
               {$IFNDEF ADSDELPHI4}

                  {$DEFINE ADSCBUILDER4_OR_NEWER }
                  {$IFNDEF ADSCBUILDER4}

                     {$DEFINE ADSDELPHI5_OR_NEWER }
                     {$IFNDEF ADSDELPHI5}

                        {$DEFINE ADSDELPHI6_OR_NEWER}
                        {$IFNDEF ADSDELPHI6}

                           {$DEFINE ADSDELPHI7_OR_NEWER}
                           {$IFNDEF ADSDELPHI7}

                              {$DEFINE ADSDELPHI2005_OR_NEWER}
                              {$IFNDEF ADSDELPHI2005}

                                 {$DEFINE ADSDELPHI2006_OR_NEWER}
                                 {$IFNDEF ADSDELPHI2006}

                                    {$DEFINE ADSDELPHI2007_OR_NEWER}
                                    {$IFNDEF ADSDELPHI2007}

                                       {$DEFINE ADSDELPHI2008_OR_NEWER}
                                       {$IFNDEF ADSDELPHI2008}

                                          {$DEFINE ADSDELPHI2010_OR_NEWER}
                                          {$IFNDEF ADSDELPHI2010}

                                             {$DEFINE ADSDELPHIXE_OR_NEWER}
                                             {$IFNDEF ADSDELPHIXE}

                                                This version of Delphi/C++Builder is not yet supported!

                                             {$ENDIF}

                                          {$ENDIF}

                                       {$ENDIF}
                                    {$ENDIF}
                                 {$ENDIF}
                              {$ENDIF}
                           {$ENDIF}
                        {$ENDIF}
                     {$ENDIF}
                  {$ENDIF}
               {$ENDIF}
            {$ENDIF}
         {$ENDIF}
      {$ENDIF}
   {$ENDIF}
{$ENDIF}


