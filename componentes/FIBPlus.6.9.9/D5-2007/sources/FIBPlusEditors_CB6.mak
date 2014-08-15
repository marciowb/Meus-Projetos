# ---------------------------------------------------------------------------
!if !$d(BCB)
BCB = $(MAKEDIR)\..
!endif

# ---------------------------------------------------------------------------
PROJPATH = 
OBJOUT =
LPAR =  
PROJECT = $(PROJPATH)\FIBPlusEditors_CB6.bpl
OBJFILES = FIBPlusEditors_CB6.obj editors\EdDataSetInfo.obj editors\EdErrorInfo.obj \
    editors\EdFieldInfo.obj editors\EdParamToFields.obj editors\FIBDataSQLEditor.obj \
	editors\FIBSQLEditor.obj editors\fraAutoUpdEditor.obj editors\fraConditionsEdit.obj \
	editors\fraDSSQLEdit.obj editors\fraSQLEdit.obj editors\pFIBAutoUpdEditor.obj \
	editors\pFIBConditionsEdit.obj editors\pFIBDataSetOptions.obj \
    editors\RegFIBPlusEditors.obj editors\pFIBDBEdit.obj editors\pFIBTrEdit.obj \
    editors\ToCodeEditor.obj editors\ToCodeEditorIntfs.obj
RESFILES = FIBPlusEditors_CB6.res
MAINSOURCE = FIBPlusEditors_CB6.cpp
RESDEPEN = $(RESFILES) editors\EdDataSetInfo.dfm editors\EdErrorInfo.dfm editors\EdFieldInfo.dfm \
    editors\EdParamToFields.dfm editors\FIBDataSQLEditor.dfm editors\FIBSQLEditor.dfm \
	editors\fraAutoUpdEditor.dfm editors\fraConditionsEdit.dfm editors\fraDSSQLEdit.dfm \
	editors\fraSQLEdit.dfm editors\pFIBAutoUpdEditor.dfm editors\pFIBConditionsEdit.dfm \
	editors\pFIBDataSetOptions.dfm editors\pFIBDBEdit.dfm editors\pFIBTrEdit.dfm 
LIBFILES = 
IDLFILES = 
IDLGENFILES = 
LIBRARIES = vcldbx.lib
PACKAGES = FIBPlus_CB6.bpi rtl.bpi vcl.bpi dbrtl.bpi vcldb.bpi designide.bpi
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
PATHPAS = .;editors
PATHRC = .;
PATHOBJ = .;$(LIBPATH)
# ---------------------------------------------------------------------------
CFLAG1 = -Od -Hc -Vx -Ve -X- -a8 -b- -k- -vi -c -tWM
IDLCFLAGS = -Ieditors -I$(BCB)\include -I$(BCB)\include\vcl -I.. -src_suffix cpp -boa
PFLAGS = 
RFLAGS = 
AFLAGS = /mx /w2 /zn
LFLAGS = $(LPAR) -D"FIBPlus C++ Property Editors" -aa -Tpp -Gpd -x -Gn -Gl -Gi -v
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




