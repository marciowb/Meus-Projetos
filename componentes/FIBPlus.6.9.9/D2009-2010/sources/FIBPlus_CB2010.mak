# ---------------------------------------------------------------------------
!if !$d(BCB)
BCB = $(MAKEDIR)\..
!endif

# ---------------------------------------------------------------------------
PROJPATH = 
OBJOUT =
LPAR =  
PROJECT = $(PROJPATH)\FIBPlus_CB2010.bpl
OBJFILES = FIBPlus_CB2010.obj RegFIBPlus.obj VariantRtn.obj DSContainer.obj \
      FIB.obj FIBConsts.obj FIBDataBase.obj FIBDataSet.obj \
      FIBMiscellaneous.obj FIBQuery.obj FIBSQLMonitor.obj \
      ib_errorcodes.obj ib_externals.obj IB_Install.obj \
      IB_InstallHeader.obj IB_Intf.obj IB_Services.obj ibase.obj \
      pFIBArray.obj pFIBCacheQueries.obj pFIBDatabase.obj \
      pFIBDataInfo.obj pFIBDataSet.obj pFIBErrorHandler.obj \
      pFIBEventLists.obj pFIBFieldsDescr.obj pFIBProps.obj \
      pFIBQuery.obj pFIBStoredProc.obj RegUtils.obj SQLTxtRtns.obj \
      StdFuncs.obj StrUtil.obj CommonIB.obj pFIBScripter.obj \
      SIBFIBEA.obj pFIBSQLLog.obj FIBDBLoginDlg.obj \
      pFIBInterfaces.obj IBBlobFilter.obj FIBCloneComponents.obj \
      pFIBLists.obj DBParsers.obj FIBCacheManage.obj SIBGlobals.obj \
      SIBAPI.obj SIBEABase.obj pTestInfo.obj FibSafeTimer.obj
RESFILES = FIBPlus_CB2010.res FIBPlus.dcr
MAINSOURCE = FIBPlus_CB2010.cpp
RESDEPEN = $(RESFILES) FIBDBLoginDlg.dfm
LIBFILES = 
IDLFILES = 
IDLGENFILES = 
LIBRARIES = 
PACKAGES = rtl.bpi dbrtl.bpi vcl.bpi vcldb.bpi vclsmp.bpi
SPARELIBS = 
DEFFILE = 
OTHERFILES = 
# ---------------------------------------------------------------------------
DEBUGLIBPATH = $(BCB)\lib\debug
RELEASELIBPATH = $(BCB)\lib\release
USERDEFINES = 
SYSDEFINES = NO_STRICT;USEPACKAGES
INCLUDEPATH = 
LIBPATH = 
WARNINGS= -w-par
PATHCPP = .;
PATHASM = .;
PATHPAS = .;
PATHRC = .;
PATHOBJ = .;$(LIBPATH)
# ---------------------------------------------------------------------------
CFLAG1 = -Od -Hc -Vx -Ve -X- -a8 -b- -k- -vi -c -tWM
IDLCFLAGS = -I$(BCB)\include -I$(BCB)\include\vcl -src_suffix cpp -boa
PFLAGS = 
RFLAGS = 
AFLAGS = /mx /w2 /zn
LFLAGS = $(LPAR) -D"FIBPlus C++" -aa -Tpp -Gpd -x -Gn -Gl -Gi -v
# ---------------------------------------------------------------------------
ALLOBJ = c0pkg32.obj $(PACKAGES) sysinit.obj $(OBJFILES)
ALLRES = $(RESFILES)
ALLLIB = $(LIBFILES) $(LIBRARIES) import32.lib cp32mt.lib
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# MAKE SECTION
# ---------------------------------------------------------------------------
# This section of the project file is not used by the BCB IDE.  It is for
# the benefit of building from the command-line using the MAKE utility.
# ---------------------------------------------------------------------------

.autodepend
# ---------------------------------------------------------------------------
!if "$(USERDEFINES)" != ""
AUSERDEFINES = -d$(USERDEFINES:;= -d)
!else
AUSERDEFINES =
!endif

!if !$d(BCC32)
BCC32 = bcc32
!endif

!if !$d(CPP32)
CPP32 = cpp32
!endif

!if !$d(DCC32)
DCC32 = dcc32
!endif

!if !$d(TASM32)
TASM32 = tasm32
!endif

!if !$d(LINKER)
LINKER = ilink32
!endif

!if !$d(BRCC32)
BRCC32 = brcc32
!endif


# ---------------------------------------------------------------------------
!if $d(PATHCPP)
.PATH.CPP = $(PATHCPP)
.PATH.C   = $(PATHCPP)
!endif

!if $d(PATHPAS)
.PATH.PAS = $(PATHPAS)
!endif

!if $d(PATHASM)
.PATH.ASM = $(PATHASM)
!endif

!if $d(PATHRC)
.PATH.RC  = $(PATHRC)
!endif

!if $d(PATHOBJ)
.PATH.OBJ  = $(PATHOBJ)
!endif
# ---------------------------------------------------------------------------
$(PROJECT): $(OTHERFILES) $(IDLGENFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(BCB)\BIN\$(LINKER) @&&!
    $(LFLAGS) -L$(LIBPATH) +
    $(ALLOBJ), +
    $(PROJECT),, +
    $(ALLLIB), +
    $(DEFFILE), +
    $(ALLRES)
!
# ---------------------------------------------------------------------------
.pas.hpp:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(LIBPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.pas.obj:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(LIBPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.cpp.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(OBJOUT) {$< }

.c.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(OBJOUT) {$< }

.c.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.cpp.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.asm.obj:
    $(BCB)\BIN\$(TASM32) $(AFLAGS) -i$(INCLUDEPATH:;= -i) $(AUSERDEFINES) -d$(SYSDEFINES:;= -d) $<, $@

.rc.res:
    $(BCB)\BIN\$(BRCC32) $(RFLAGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -fo$@ $<

# ---------------------------------------------------------------------------




