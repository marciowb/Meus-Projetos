{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_OpenGL;

interface

uses
  Windows,
  OpenGL,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatOpenGLLibrary = class(TatScripterLibrary)
    procedure __glAccum(AMachine: TatVirtualMachine);
    procedure __glAlphaFunc(AMachine: TatVirtualMachine);
    procedure __glBegin(AMachine: TatVirtualMachine);
    procedure __glBlendFunc(AMachine: TatVirtualMachine);
    procedure __glCallList(AMachine: TatVirtualMachine);
    procedure __glClear(AMachine: TatVirtualMachine);
    procedure __glClearAccum(AMachine: TatVirtualMachine);
    procedure __glClearColor(AMachine: TatVirtualMachine);
    procedure __glClearDepth(AMachine: TatVirtualMachine);
    procedure __glClearIndex(AMachine: TatVirtualMachine);
    procedure __glClearStencil(AMachine: TatVirtualMachine);
    procedure __glColor3b(AMachine: TatVirtualMachine);
    procedure __glColor3d(AMachine: TatVirtualMachine);
    procedure __glColor3f(AMachine: TatVirtualMachine);
    procedure __glColor3i(AMachine: TatVirtualMachine);
    procedure __glColor3s(AMachine: TatVirtualMachine);
    procedure __glColor3ub(AMachine: TatVirtualMachine);
    procedure __glColor3ui(AMachine: TatVirtualMachine);
    procedure __glColor3us(AMachine: TatVirtualMachine);
    procedure __glColor4b(AMachine: TatVirtualMachine);
    procedure __glColor4d(AMachine: TatVirtualMachine);
    procedure __glColor4f(AMachine: TatVirtualMachine);
    procedure __glColor4i(AMachine: TatVirtualMachine);
    procedure __glColor4s(AMachine: TatVirtualMachine);
    procedure __glColor4ub(AMachine: TatVirtualMachine);
    procedure __glColor4ui(AMachine: TatVirtualMachine);
    procedure __glColor4us(AMachine: TatVirtualMachine);
    procedure __glColor(AMachine: TatVirtualMachine);
    procedure __glColorMask(AMachine: TatVirtualMachine);
    procedure __glColorMaterial(AMachine: TatVirtualMachine);
    procedure __glCopyPixels(AMachine: TatVirtualMachine);
    procedure __glCullFace(AMachine: TatVirtualMachine);
    procedure __glDeleteLists(AMachine: TatVirtualMachine);
    procedure __glDepthFunc(AMachine: TatVirtualMachine);
    procedure __glDepthMask(AMachine: TatVirtualMachine);
    procedure __glDepthRange(AMachine: TatVirtualMachine);
    procedure __glDisable(AMachine: TatVirtualMachine);
    procedure __glDrawBuffer(AMachine: TatVirtualMachine);
    procedure __glEdgeFlag(AMachine: TatVirtualMachine);
    procedure __glEnable(AMachine: TatVirtualMachine);
    procedure __glEnd(AMachine: TatVirtualMachine);
    procedure __glEndList(AMachine: TatVirtualMachine);
    procedure __glEvalCoord1d(AMachine: TatVirtualMachine);
    procedure __glEvalCoord1f(AMachine: TatVirtualMachine);
    procedure __glEvalCoord2d(AMachine: TatVirtualMachine);
    procedure __glEvalCoord2f(AMachine: TatVirtualMachine);
    procedure __glEvalCoord(AMachine: TatVirtualMachine);
    procedure __glEvalMesh1(AMachine: TatVirtualMachine);
    procedure __glEvalMesh2(AMachine: TatVirtualMachine);
    procedure __glEvalMesh(AMachine: TatVirtualMachine);
    procedure __glEvalPoint1(AMachine: TatVirtualMachine);
    procedure __glEvalPoint2(AMachine: TatVirtualMachine);
    procedure __glEvalPoint(AMachine: TatVirtualMachine);
    procedure __glFinish(AMachine: TatVirtualMachine);
    procedure __glFlush(AMachine: TatVirtualMachine);
    procedure __glFogf(AMachine: TatVirtualMachine);
    procedure __glFogi(AMachine: TatVirtualMachine);
    procedure __glFog(AMachine: TatVirtualMachine);
    procedure __glFrontFace(AMachine: TatVirtualMachine);
    procedure __glFrustum(AMachine: TatVirtualMachine);
    procedure __glGenLists(AMachine: TatVirtualMachine);
    procedure __glGetError(AMachine: TatVirtualMachine);
    procedure __glGetPolygonStipple(AMachine: TatVirtualMachine);
    procedure __glGetString(AMachine: TatVirtualMachine);
    procedure __glHint(AMachine: TatVirtualMachine);
    procedure __glIndexMask(AMachine: TatVirtualMachine);
    procedure __glIndexd(AMachine: TatVirtualMachine);
    procedure __glIndexf(AMachine: TatVirtualMachine);
    procedure __glIndexi(AMachine: TatVirtualMachine);
    procedure __glIndexs(AMachine: TatVirtualMachine);
    procedure __glIndex(AMachine: TatVirtualMachine);
    procedure __glInitNames(AMachine: TatVirtualMachine);
    procedure __glIsEnabled(AMachine: TatVirtualMachine);
    procedure __glIsList(AMachine: TatVirtualMachine);
    procedure __glLightModelf(AMachine: TatVirtualMachine);
    procedure __glLightModeli(AMachine: TatVirtualMachine);
    procedure __glLightModel(AMachine: TatVirtualMachine);
    procedure __glLightf(AMachine: TatVirtualMachine);
    procedure __glLighti(AMachine: TatVirtualMachine);
    procedure __glLight(AMachine: TatVirtualMachine);
    procedure __glLineStipple(AMachine: TatVirtualMachine);
    procedure __glLineWidth(AMachine: TatVirtualMachine);
    procedure __glListBase(AMachine: TatVirtualMachine);
    procedure __glLoadIdentity(AMachine: TatVirtualMachine);
    procedure __glLoadName(AMachine: TatVirtualMachine);
    procedure __glLogicOp(AMachine: TatVirtualMachine);
    procedure __glMapGrid1d(AMachine: TatVirtualMachine);
    procedure __glMapGrid1f(AMachine: TatVirtualMachine);
    procedure __glMapGrid2d(AMachine: TatVirtualMachine);
    procedure __glMapGrid2f(AMachine: TatVirtualMachine);
    procedure __glMapGrid(AMachine: TatVirtualMachine);
    procedure __glMaterialf(AMachine: TatVirtualMachine);
    procedure __glMateriali(AMachine: TatVirtualMachine);
    procedure __glMaterial(AMachine: TatVirtualMachine);
    procedure __glMatrixMode(AMachine: TatVirtualMachine);
    procedure __glNewList(AMachine: TatVirtualMachine);
    procedure __glNormal3b(AMachine: TatVirtualMachine);
    procedure __glNormal3d(AMachine: TatVirtualMachine);
    procedure __glNormal3f(AMachine: TatVirtualMachine);
    procedure __glNormal3i(AMachine: TatVirtualMachine);
    procedure __glNormal3s(AMachine: TatVirtualMachine);
    procedure __glNormal(AMachine: TatVirtualMachine);
    procedure __glOrtho(AMachine: TatVirtualMachine);
    procedure __glPassThrough(AMachine: TatVirtualMachine);
    procedure __glPixelStoref(AMachine: TatVirtualMachine);
    procedure __glPixelStorei(AMachine: TatVirtualMachine);
    procedure __glPixelStore(AMachine: TatVirtualMachine);
    procedure __glPixelTransferf(AMachine: TatVirtualMachine);
    procedure __glPixelTransferi(AMachine: TatVirtualMachine);
    procedure __glPixelTransfer(AMachine: TatVirtualMachine);
    procedure __glPixelZoom(AMachine: TatVirtualMachine);
    procedure __glPointSize(AMachine: TatVirtualMachine);
    procedure __glPolygonMode(AMachine: TatVirtualMachine);
    procedure __glPopAttrib(AMachine: TatVirtualMachine);
    procedure __glPopMatrix(AMachine: TatVirtualMachine);
    procedure __glPopName(AMachine: TatVirtualMachine);
    procedure __glPushAttrib(AMachine: TatVirtualMachine);
    procedure __glPushMatrix(AMachine: TatVirtualMachine);
    procedure __glPushName(AMachine: TatVirtualMachine);
    procedure __glRasterPos2d(AMachine: TatVirtualMachine);
    procedure __glRasterPos2f(AMachine: TatVirtualMachine);
    procedure __glRasterPos2i(AMachine: TatVirtualMachine);
    procedure __glRasterPos2s(AMachine: TatVirtualMachine);
    procedure __glRasterPos3d(AMachine: TatVirtualMachine);
    procedure __glRasterPos3f(AMachine: TatVirtualMachine);
    procedure __glRasterPos3i(AMachine: TatVirtualMachine);
    procedure __glRasterPos3s(AMachine: TatVirtualMachine);
    procedure __glRasterPos4d(AMachine: TatVirtualMachine);
    procedure __glRasterPos4f(AMachine: TatVirtualMachine);
    procedure __glRasterPos4i(AMachine: TatVirtualMachine);
    procedure __glRasterPos4s(AMachine: TatVirtualMachine);
    procedure __glRasterPos(AMachine: TatVirtualMachine);
    procedure __glReadBuffer(AMachine: TatVirtualMachine);
    procedure __glRectd(AMachine: TatVirtualMachine);
    procedure __glRectf(AMachine: TatVirtualMachine);
    procedure __glRecti(AMachine: TatVirtualMachine);
    procedure __glRects(AMachine: TatVirtualMachine);
    procedure __glRect(AMachine: TatVirtualMachine);
    procedure __glRenderMode(AMachine: TatVirtualMachine);
    procedure __glRotated(AMachine: TatVirtualMachine);
    procedure __glRotatef(AMachine: TatVirtualMachine);
    procedure __glRotate(AMachine: TatVirtualMachine);
    procedure __glScaled(AMachine: TatVirtualMachine);
    procedure __glScalef(AMachine: TatVirtualMachine);
    procedure __glScale(AMachine: TatVirtualMachine);
    procedure __glScissor(AMachine: TatVirtualMachine);
    procedure __glShadeModel(AMachine: TatVirtualMachine);
    procedure __glStencilFunc(AMachine: TatVirtualMachine);
    procedure __glStencilMask(AMachine: TatVirtualMachine);
    procedure __glStencilOp(AMachine: TatVirtualMachine);
    procedure __glTexCoord1d(AMachine: TatVirtualMachine);
    procedure __glTexCoord1f(AMachine: TatVirtualMachine);
    procedure __glTexCoord1i(AMachine: TatVirtualMachine);
    procedure __glTexCoord1s(AMachine: TatVirtualMachine);
    procedure __glTexCoord2d(AMachine: TatVirtualMachine);
    procedure __glTexCoord2f(AMachine: TatVirtualMachine);
    procedure __glTexCoord2i(AMachine: TatVirtualMachine);
    procedure __glTexCoord2s(AMachine: TatVirtualMachine);
    procedure __glTexCoord3d(AMachine: TatVirtualMachine);
    procedure __glTexCoord3f(AMachine: TatVirtualMachine);
    procedure __glTexCoord3i(AMachine: TatVirtualMachine);
    procedure __glTexCoord3s(AMachine: TatVirtualMachine);
    procedure __glTexCoord4d(AMachine: TatVirtualMachine);
    procedure __glTexCoord4f(AMachine: TatVirtualMachine);
    procedure __glTexCoord4i(AMachine: TatVirtualMachine);
    procedure __glTexCoord4s(AMachine: TatVirtualMachine);
    procedure __glTexCoord(AMachine: TatVirtualMachine);
    procedure __glTexEnvf(AMachine: TatVirtualMachine);
    procedure __glTexEnvi(AMachine: TatVirtualMachine);
    procedure __glTexEnv(AMachine: TatVirtualMachine);
    procedure __glTexGend(AMachine: TatVirtualMachine);
    procedure __glTexGenf(AMachine: TatVirtualMachine);
    procedure __glTexGeni(AMachine: TatVirtualMachine);
    procedure __glTexGen(AMachine: TatVirtualMachine);
    procedure __glTexParameterf(AMachine: TatVirtualMachine);
    procedure __glTexParameteri(AMachine: TatVirtualMachine);
    procedure __glTexParameter(AMachine: TatVirtualMachine);
    procedure __glTranslated(AMachine: TatVirtualMachine);
    procedure __glTranslatef(AMachine: TatVirtualMachine);
    procedure __glTranslate(AMachine: TatVirtualMachine);
    procedure __glVertex2d(AMachine: TatVirtualMachine);
    procedure __glVertex2f(AMachine: TatVirtualMachine);
    procedure __glVertex2i(AMachine: TatVirtualMachine);
    procedure __glVertex2s(AMachine: TatVirtualMachine);
    procedure __glVertex3d(AMachine: TatVirtualMachine);
    procedure __glVertex3f(AMachine: TatVirtualMachine);
    procedure __glVertex3i(AMachine: TatVirtualMachine);
    procedure __glVertex3s(AMachine: TatVirtualMachine);
    procedure __glVertex4d(AMachine: TatVirtualMachine);
    procedure __glVertex4f(AMachine: TatVirtualMachine);
    procedure __glVertex4i(AMachine: TatVirtualMachine);
    procedure __glVertex4s(AMachine: TatVirtualMachine);
    procedure __glVertex(AMachine: TatVirtualMachine);
    procedure __glViewport(AMachine: TatVirtualMachine);
    procedure __gluErrorString(AMachine: TatVirtualMachine);
    procedure __gluErrorUnicodeStringEXT(AMachine: TatVirtualMachine);
    procedure __gluGetString(AMachine: TatVirtualMachine);
    procedure __gluLookAt(AMachine: TatVirtualMachine);
    procedure __gluOrtho2D(AMachine: TatVirtualMachine);
    procedure __gluPerspective(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _POINTFLOATWrapper = class(TatRecordWrapper)
  private
    FX: Single;
    FY: Single;
  public
    constructor Create(ARecord: _POINTFLOAT);
    function ObjToRec: _POINTFLOAT;
  published
    property X: Single read FX write FX;
    property Y: Single read FY write FY;
  end;
  
  _GLYPHMETRICSFLOATWrapper = class(TatRecordWrapper)
  private
    FgmfBlackBoxX: Single;
    FgmfBlackBoxY: Single;
    FgmfCellIncX: Single;
    FgmfCellIncY: Single;
  public
    constructor Create(ARecord: _GLYPHMETRICSFLOAT);
    function ObjToRec: _GLYPHMETRICSFLOAT;
  published
    property gmfBlackBoxX: Single read FgmfBlackBoxX write FgmfBlackBoxX;
    property gmfBlackBoxY: Single read FgmfBlackBoxY write FgmfBlackBoxY;
    property gmfCellIncX: Single read FgmfCellIncX write FgmfCellIncX;
    property gmfCellIncY: Single read FgmfCellIncY write FgmfCellIncY;
  end;
  
  _GLUquadricObjWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _GLUquadricObj);
    function ObjToRec: _GLUquadricObj;
  published
  end;
  
  _GLUtesselatorWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _GLUtesselator);
    function ObjToRec: _GLUtesselator;
  published
  end;
  
  TGLUnurbsObjWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TGLUnurbsObj);
    function ObjToRec: TGLUnurbsObj;
  published
  end;
  

implementation

constructor _POINTFLOATWrapper.Create(ARecord: _POINTFLOAT);
begin
  inherited Create;
  FX := ARecord.X;
  FY := ARecord.Y;
end;

function _POINTFLOATWrapper.ObjToRec: _POINTFLOAT;
begin
  result.X := FX;
  result.Y := FY;
end;

constructor _GLYPHMETRICSFLOATWrapper.Create(ARecord: _GLYPHMETRICSFLOAT);
begin
  inherited Create;
  FgmfBlackBoxX := ARecord.gmfBlackBoxX;
  FgmfBlackBoxY := ARecord.gmfBlackBoxY;
  FgmfCellIncX := ARecord.gmfCellIncX;
  FgmfCellIncY := ARecord.gmfCellIncY;
end;

function _GLYPHMETRICSFLOATWrapper.ObjToRec: _GLYPHMETRICSFLOAT;
begin
  result.gmfBlackBoxX := FgmfBlackBoxX;
  result.gmfBlackBoxY := FgmfBlackBoxY;
  result.gmfCellIncX := FgmfCellIncX;
  result.gmfCellIncY := FgmfCellIncY;
end;

constructor _GLUquadricObjWrapper.Create(ARecord: _GLUquadricObj);
begin
  inherited Create;
end;

function _GLUquadricObjWrapper.ObjToRec: _GLUquadricObj;
begin
end;

constructor _GLUtesselatorWrapper.Create(ARecord: _GLUtesselator);
begin
  inherited Create;
end;

function _GLUtesselatorWrapper.ObjToRec: _GLUtesselator;
begin
end;

constructor TGLUnurbsObjWrapper.Create(ARecord: TGLUnurbsObj);
begin
  inherited Create;
end;

function TGLUnurbsObjWrapper.ObjToRec: TGLUnurbsObj;
begin
end;



procedure TatOpenGLLibrary.__glAccum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glAccum(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glAlphaFunc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glAlphaFunc(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glBegin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glBegin(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glBlendFunc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glBlendFunc(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glCallList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glCallList(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glClear(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glClearAccum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glClearAccum(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glClearColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glClearColor(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glClearDepth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glClearDepth(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glClearIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glClearIndex(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glClearStencil(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glClearStencil(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glColor3b(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3b(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColor3d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3d(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glColor3f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3f(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glColor3i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColor3s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColor3ub(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3ub(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColor3ui(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3ui(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColor3us(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor3us(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColor4b(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4b(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glColor4d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4d(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glColor4f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4f(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glColor4i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glColor4s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glColor4ub(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4ub(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glColor4ui(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4ui(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glColor4us(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor4us(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glColorMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColorMask(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glColorMaterial(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glColorMaterial(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glCopyPixels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glCopyPixels(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
  end;
end;

procedure TatOpenGLLibrary.__glCullFace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glCullFace(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glDeleteLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glDeleteLists(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glDepthFunc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glDepthFunc(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glDepthMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glDepthMask(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glDepthRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glDepthRange(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glDisable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glDisable(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glDrawBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glDrawBuffer(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glEdgeFlag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEdgeFlag(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glEnable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEnable(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEnd;
  end;
end;

procedure TatOpenGLLibrary.__glEndList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEndList;
  end;
end;

procedure TatOpenGLLibrary.__glEvalCoord1d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalCoord1d(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glEvalCoord1f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalCoord1f(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glEvalCoord2d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalCoord2d(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glEvalCoord2f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalCoord2f(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glEvalCoord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalCoord(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glEvalMesh1(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalMesh1(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glEvalMesh2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalMesh2(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
  end;
end;

procedure TatOpenGLLibrary.__glEvalMesh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalMesh(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glEvalPoint1(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalPoint1(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glEvalPoint2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalPoint2(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glEvalPoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glEvalPoint(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glFinish(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFinish;
  end;
end;

procedure TatOpenGLLibrary.__glFlush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFlush;
  end;
end;

procedure TatOpenGLLibrary.__glFogf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFogf(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glFogi(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFogi(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glFog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFog(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glFrontFace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFrontFace(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glFrustum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glFrustum(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4),GetInputArg(5));
  end;
end;

procedure TatOpenGLLibrary.__glGenLists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(OpenGL.glGenLists(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__glGetError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(OpenGL.glGetError);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__glGetPolygonStipple(AMachine: TatVirtualMachine);
  var
  Param0: GLubyte;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
    OpenGL.glGetPolygonStipple(Param0);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOpenGLLibrary.__glGetString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(OpenGL.glGetString(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__glHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glHint(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glIndexMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glIndexMask(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glIndexd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glIndexd(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glIndexf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glIndexf(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glIndexi(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glIndexi(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glIndexs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glIndexs(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glIndex(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glInitNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glInitNames;
  end;
end;

procedure TatOpenGLLibrary.__glIsEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OpenGL.glIsEnabled(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__glIsList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OpenGL.glIsList(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__glLightModelf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLightModelf(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glLightModeli(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLightModeli(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glLightModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLightModel(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glLightf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLightf(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glLighti(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLighti(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glLight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLight(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glLineStipple(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLineStipple(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glLineWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLineWidth(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glListBase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glListBase(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glLoadIdentity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLoadIdentity;
  end;
end;

procedure TatOpenGLLibrary.__glLoadName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLoadName(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glLogicOp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glLogicOp(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glMapGrid1d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMapGrid1d(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glMapGrid1f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMapGrid1f(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glMapGrid2d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMapGrid2d(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),GetInputArg(4),GetInputArg(5));
  end;
end;

procedure TatOpenGLLibrary.__glMapGrid2f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMapGrid2f(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),GetInputArg(4),GetInputArg(5));
  end;
end;

procedure TatOpenGLLibrary.__glMapGrid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMapGrid(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glMaterialf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMaterialf(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glMateriali(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMateriali(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glMaterial(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMaterial(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glMatrixMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glMatrixMode(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glNewList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNewList(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glNormal3b(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNormal3b(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glNormal3d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNormal3d(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glNormal3f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNormal3f(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glNormal3i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNormal3i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glNormal3s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNormal3s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glNormal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glNormal(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glOrtho(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glOrtho(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4),GetInputArg(5));
  end;
end;

procedure TatOpenGLLibrary.__glPassThrough(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPassThrough(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glPixelStoref(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelStoref(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glPixelStorei(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelStorei(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glPixelStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelStore(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glPixelTransferf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelTransferf(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glPixelTransferi(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelTransferi(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glPixelTransfer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelTransfer(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glPixelZoom(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPixelZoom(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glPointSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPointSize(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glPolygonMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPolygonMode(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glPopAttrib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPopAttrib;
  end;
end;

procedure TatOpenGLLibrary.__glPopMatrix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPopMatrix;
  end;
end;

procedure TatOpenGLLibrary.__glPopName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPopName;
  end;
end;

procedure TatOpenGLLibrary.__glPushAttrib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPushAttrib(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glPushMatrix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPushMatrix;
  end;
end;

procedure TatOpenGLLibrary.__glPushName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glPushName(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos2d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos2d(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos2f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos2f(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos2i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos2i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos2s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos2s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos3d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos3d(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos3f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos3f(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos3i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos3i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos3s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos3s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos4d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos4d(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos4f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos4f(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos4i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos4i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos4s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos4s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glRasterPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRasterPos(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glReadBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glReadBuffer(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glRectd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRectd(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRectf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRectf(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRecti(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRecti(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glRects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRects(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRect(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRenderMode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(OpenGL.glRenderMode(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__glRotated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRotated(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRotatef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRotatef(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glRotate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glRotate(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glScaled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glScaled(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glScalef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glScalef(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glScale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glScale(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glScissor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glScissor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glShadeModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glShadeModel(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glStencilFunc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glStencilFunc(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glStencilMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glStencilMask(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glStencilOp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glStencilOp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord1d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord1d(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord1f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord1f(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord1i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord1i(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord1s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord1s(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord2d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord2d(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord2f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord2f(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord2i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord2i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord2s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord2s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord3d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord3d(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord3f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord3f(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord3i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord3i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord3s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord3s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord4d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord4d(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord4f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord4f(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord4i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord4i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord4s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord4s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glTexCoord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexCoord(GetInputArg(0));
  end;
end;

procedure TatOpenGLLibrary.__glTexEnvf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexEnvf(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexEnvi(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexEnvi(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glTexEnv(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexEnv(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexGend(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexGend(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexGenf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexGenf(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexGeni(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexGeni(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glTexGen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexGen(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexParameterf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexParameterf(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTexParameteri(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexParameteri(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glTexParameter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTexParameter(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTranslated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTranslated(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTranslatef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTranslatef(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glTranslate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glTranslate(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glVertex2d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex2d(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glVertex2f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex2f(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glVertex2i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex2i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glVertex2s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex2s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOpenGLLibrary.__glVertex3d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex3d(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glVertex3f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex3f(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatOpenGLLibrary.__glVertex3i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex3i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glVertex3s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex3s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatOpenGLLibrary.__glVertex4d(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex4d(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glVertex4f(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex4f(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__glVertex4i(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex4i(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glVertex4s(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex4s(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__glVertex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glVertex(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOpenGLLibrary.__glViewport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.glViewport(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOpenGLLibrary.__gluErrorString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(OpenGL.gluErrorString(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__gluErrorUnicodeStringEXT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(OpenGL.gluErrorUnicodeStringEXT(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__gluGetString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(OpenGL.gluGetString(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOpenGLLibrary.__gluLookAt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.gluLookAt(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4),GetInputArg(5),GetInputArg(6),GetInputArg(7),GetInputArg(8));
  end;
end;

procedure TatOpenGLLibrary.__gluOrtho2D(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.gluOrtho2D(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.__gluPerspective(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OpenGL.gluPerspective(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatOpenGLLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('glAccum',2,tkNone,nil,__glAccum,false,0);
    DefineMethod('glAlphaFunc',2,tkNone,nil,__glAlphaFunc,false,0);
    DefineMethod('glBegin',1,tkNone,nil,__glBegin,false,0);
    DefineMethod('glBlendFunc',2,tkNone,nil,__glBlendFunc,false,0);
    DefineMethod('glCallList',1,tkNone,nil,__glCallList,false,0);
    DefineMethod('glClear',1,tkNone,nil,__glClear,false,0);
    DefineMethod('glClearAccum',4,tkNone,nil,__glClearAccum,false,0);
    DefineMethod('glClearColor',4,tkNone,nil,__glClearColor,false,0);
    DefineMethod('glClearDepth',1,tkNone,nil,__glClearDepth,false,0);
    DefineMethod('glClearIndex',1,tkNone,nil,__glClearIndex,false,0);
    DefineMethod('glClearStencil',1,tkNone,nil,__glClearStencil,false,0);
    DefineMethod('glColor3b',3,tkNone,nil,__glColor3b,false,0);
    DefineMethod('glColor3d',3,tkNone,nil,__glColor3d,false,0);
    DefineMethod('glColor3f',3,tkNone,nil,__glColor3f,false,0);
    DefineMethod('glColor3i',3,tkNone,nil,__glColor3i,false,0);
    DefineMethod('glColor3s',3,tkNone,nil,__glColor3s,false,0);
    DefineMethod('glColor3ub',3,tkNone,nil,__glColor3ub,false,0);
    DefineMethod('glColor3ui',3,tkNone,nil,__glColor3ui,false,0);
    DefineMethod('glColor3us',3,tkNone,nil,__glColor3us,false,0);
    DefineMethod('glColor4b',4,tkNone,nil,__glColor4b,false,0);
    DefineMethod('glColor4d',4,tkNone,nil,__glColor4d,false,0);
    DefineMethod('glColor4f',4,tkNone,nil,__glColor4f,false,0);
    DefineMethod('glColor4i',4,tkNone,nil,__glColor4i,false,0);
    DefineMethod('glColor4s',4,tkNone,nil,__glColor4s,false,0);
    DefineMethod('glColor4ub',4,tkNone,nil,__glColor4ub,false,0);
    DefineMethod('glColor4ui',4,tkNone,nil,__glColor4ui,false,0);
    DefineMethod('glColor4us',4,tkNone,nil,__glColor4us,false,0);
    DefineMethod('glColor',3,tkNone,nil,__glColor,false,0);
    DefineMethod('glColorMask',4,tkNone,nil,__glColorMask,false,0);
    DefineMethod('glColorMaterial',2,tkNone,nil,__glColorMaterial,false,0);
    DefineMethod('glCopyPixels',5,tkNone,nil,__glCopyPixels,false,0);
    DefineMethod('glCullFace',1,tkNone,nil,__glCullFace,false,0);
    DefineMethod('glDeleteLists',2,tkNone,nil,__glDeleteLists,false,0);
    DefineMethod('glDepthFunc',1,tkNone,nil,__glDepthFunc,false,0);
    DefineMethod('glDepthMask',1,tkNone,nil,__glDepthMask,false,0);
    DefineMethod('glDepthRange',2,tkNone,nil,__glDepthRange,false,0);
    DefineMethod('glDisable',1,tkNone,nil,__glDisable,false,0);
    DefineMethod('glDrawBuffer',1,tkNone,nil,__glDrawBuffer,false,0);
    DefineMethod('glEdgeFlag',1,tkNone,nil,__glEdgeFlag,false,0);
    DefineMethod('glEnable',1,tkNone,nil,__glEnable,false,0);
    DefineMethod('glEnd',0,tkNone,nil,__glEnd,false,0);
    DefineMethod('glEndList',0,tkNone,nil,__glEndList,false,0);
    DefineMethod('glEvalCoord1d',1,tkNone,nil,__glEvalCoord1d,false,0);
    DefineMethod('glEvalCoord1f',1,tkNone,nil,__glEvalCoord1f,false,0);
    DefineMethod('glEvalCoord2d',2,tkNone,nil,__glEvalCoord2d,false,0);
    DefineMethod('glEvalCoord2f',2,tkNone,nil,__glEvalCoord2f,false,0);
    DefineMethod('glEvalCoord',1,tkNone,nil,__glEvalCoord,false,0);
    DefineMethod('glEvalMesh1',3,tkNone,nil,__glEvalMesh1,false,0);
    DefineMethod('glEvalMesh2',5,tkNone,nil,__glEvalMesh2,false,0);
    DefineMethod('glEvalMesh',3,tkNone,nil,__glEvalMesh,false,0);
    DefineMethod('glEvalPoint1',1,tkNone,nil,__glEvalPoint1,false,0);
    DefineMethod('glEvalPoint2',2,tkNone,nil,__glEvalPoint2,false,0);
    DefineMethod('glEvalPoint',1,tkNone,nil,__glEvalPoint,false,0);
    DefineMethod('glFinish',0,tkNone,nil,__glFinish,false,0);
    DefineMethod('glFlush',0,tkNone,nil,__glFlush,false,0);
    DefineMethod('glFogf',2,tkNone,nil,__glFogf,false,0);
    DefineMethod('glFogi',2,tkNone,nil,__glFogi,false,0);
    DefineMethod('glFog',2,tkNone,nil,__glFog,false,0);
    DefineMethod('glFrontFace',1,tkNone,nil,__glFrontFace,false,0);
    DefineMethod('glFrustum',6,tkNone,nil,__glFrustum,false,0);
    DefineMethod('glGenLists',1,tkInteger,nil,__glGenLists,false,0);
    DefineMethod('glGetError',0,tkInteger,nil,__glGetError,false,0);
    DefineMethod('glGetPolygonStipple',1,tkNone,nil,__glGetPolygonStipple,false,0).SetVarArgs([0]);
    DefineMethod('glGetString',1,tkVariant,nil,__glGetString,false,0);
    DefineMethod('glHint',2,tkNone,nil,__glHint,false,0);
    DefineMethod('glIndexMask',1,tkNone,nil,__glIndexMask,false,0);
    DefineMethod('glIndexd',1,tkNone,nil,__glIndexd,false,0);
    DefineMethod('glIndexf',1,tkNone,nil,__glIndexf,false,0);
    DefineMethod('glIndexi',1,tkNone,nil,__glIndexi,false,0);
    DefineMethod('glIndexs',1,tkNone,nil,__glIndexs,false,0);
    DefineMethod('glIndex',1,tkNone,nil,__glIndex,false,0);
    DefineMethod('glInitNames',0,tkNone,nil,__glInitNames,false,0);
    DefineMethod('glIsEnabled',1,tkVariant,nil,__glIsEnabled,false,0);
    DefineMethod('glIsList',1,tkVariant,nil,__glIsList,false,0);
    DefineMethod('glLightModelf',2,tkNone,nil,__glLightModelf,false,0);
    DefineMethod('glLightModeli',2,tkNone,nil,__glLightModeli,false,0);
    DefineMethod('glLightModel',2,tkNone,nil,__glLightModel,false,0);
    DefineMethod('glLightf',3,tkNone,nil,__glLightf,false,0);
    DefineMethod('glLighti',3,tkNone,nil,__glLighti,false,0);
    DefineMethod('glLight',3,tkNone,nil,__glLight,false,0);
    DefineMethod('glLineStipple',2,tkNone,nil,__glLineStipple,false,0);
    DefineMethod('glLineWidth',1,tkNone,nil,__glLineWidth,false,0);
    DefineMethod('glListBase',1,tkNone,nil,__glListBase,false,0);
    DefineMethod('glLoadIdentity',0,tkNone,nil,__glLoadIdentity,false,0);
    DefineMethod('glLoadName',1,tkNone,nil,__glLoadName,false,0);
    DefineMethod('glLogicOp',1,tkNone,nil,__glLogicOp,false,0);
    DefineMethod('glMapGrid1d',3,tkNone,nil,__glMapGrid1d,false,0);
    DefineMethod('glMapGrid1f',3,tkNone,nil,__glMapGrid1f,false,0);
    DefineMethod('glMapGrid2d',6,tkNone,nil,__glMapGrid2d,false,0);
    DefineMethod('glMapGrid2f',6,tkNone,nil,__glMapGrid2f,false,0);
    DefineMethod('glMapGrid',3,tkNone,nil,__glMapGrid,false,0);
    DefineMethod('glMaterialf',3,tkNone,nil,__glMaterialf,false,0);
    DefineMethod('glMateriali',3,tkNone,nil,__glMateriali,false,0);
    DefineMethod('glMaterial',3,tkNone,nil,__glMaterial,false,0);
    DefineMethod('glMatrixMode',1,tkNone,nil,__glMatrixMode,false,0);
    DefineMethod('glNewList',2,tkNone,nil,__glNewList,false,0);
    DefineMethod('glNormal3b',3,tkNone,nil,__glNormal3b,false,0);
    DefineMethod('glNormal3d',3,tkNone,nil,__glNormal3d,false,0);
    DefineMethod('glNormal3f',3,tkNone,nil,__glNormal3f,false,0);
    DefineMethod('glNormal3i',3,tkNone,nil,__glNormal3i,false,0);
    DefineMethod('glNormal3s',3,tkNone,nil,__glNormal3s,false,0);
    DefineMethod('glNormal',3,tkNone,nil,__glNormal,false,0);
    DefineMethod('glOrtho',6,tkNone,nil,__glOrtho,false,0);
    DefineMethod('glPassThrough',1,tkNone,nil,__glPassThrough,false,0);
    DefineMethod('glPixelStoref',2,tkNone,nil,__glPixelStoref,false,0);
    DefineMethod('glPixelStorei',2,tkNone,nil,__glPixelStorei,false,0);
    DefineMethod('glPixelStore',2,tkNone,nil,__glPixelStore,false,0);
    DefineMethod('glPixelTransferf',2,tkNone,nil,__glPixelTransferf,false,0);
    DefineMethod('glPixelTransferi',2,tkNone,nil,__glPixelTransferi,false,0);
    DefineMethod('glPixelTransfer',2,tkNone,nil,__glPixelTransfer,false,0);
    DefineMethod('glPixelZoom',2,tkNone,nil,__glPixelZoom,false,0);
    DefineMethod('glPointSize',1,tkNone,nil,__glPointSize,false,0);
    DefineMethod('glPolygonMode',2,tkNone,nil,__glPolygonMode,false,0);
    DefineMethod('glPopAttrib',0,tkNone,nil,__glPopAttrib,false,0);
    DefineMethod('glPopMatrix',0,tkNone,nil,__glPopMatrix,false,0);
    DefineMethod('glPopName',0,tkNone,nil,__glPopName,false,0);
    DefineMethod('glPushAttrib',1,tkNone,nil,__glPushAttrib,false,0);
    DefineMethod('glPushMatrix',0,tkNone,nil,__glPushMatrix,false,0);
    DefineMethod('glPushName',1,tkNone,nil,__glPushName,false,0);
    DefineMethod('glRasterPos2d',2,tkNone,nil,__glRasterPos2d,false,0);
    DefineMethod('glRasterPos2f',2,tkNone,nil,__glRasterPos2f,false,0);
    DefineMethod('glRasterPos2i',2,tkNone,nil,__glRasterPos2i,false,0);
    DefineMethod('glRasterPos2s',2,tkNone,nil,__glRasterPos2s,false,0);
    DefineMethod('glRasterPos3d',3,tkNone,nil,__glRasterPos3d,false,0);
    DefineMethod('glRasterPos3f',3,tkNone,nil,__glRasterPos3f,false,0);
    DefineMethod('glRasterPos3i',3,tkNone,nil,__glRasterPos3i,false,0);
    DefineMethod('glRasterPos3s',3,tkNone,nil,__glRasterPos3s,false,0);
    DefineMethod('glRasterPos4d',4,tkNone,nil,__glRasterPos4d,false,0);
    DefineMethod('glRasterPos4f',4,tkNone,nil,__glRasterPos4f,false,0);
    DefineMethod('glRasterPos4i',4,tkNone,nil,__glRasterPos4i,false,0);
    DefineMethod('glRasterPos4s',4,tkNone,nil,__glRasterPos4s,false,0);
    DefineMethod('glRasterPos',2,tkNone,nil,__glRasterPos,false,0);
    DefineMethod('glReadBuffer',1,tkNone,nil,__glReadBuffer,false,0);
    DefineMethod('glRectd',4,tkNone,nil,__glRectd,false,0);
    DefineMethod('glRectf',4,tkNone,nil,__glRectf,false,0);
    DefineMethod('glRecti',4,tkNone,nil,__glRecti,false,0);
    DefineMethod('glRects',4,tkNone,nil,__glRects,false,0);
    DefineMethod('glRect',4,tkNone,nil,__glRect,false,0);
    DefineMethod('glRenderMode',1,tkInteger,nil,__glRenderMode,false,0);
    DefineMethod('glRotated',4,tkNone,nil,__glRotated,false,0);
    DefineMethod('glRotatef',4,tkNone,nil,__glRotatef,false,0);
    DefineMethod('glRotate',4,tkNone,nil,__glRotate,false,0);
    DefineMethod('glScaled',3,tkNone,nil,__glScaled,false,0);
    DefineMethod('glScalef',3,tkNone,nil,__glScalef,false,0);
    DefineMethod('glScale',3,tkNone,nil,__glScale,false,0);
    DefineMethod('glScissor',4,tkNone,nil,__glScissor,false,0);
    DefineMethod('glShadeModel',1,tkNone,nil,__glShadeModel,false,0);
    DefineMethod('glStencilFunc',3,tkNone,nil,__glStencilFunc,false,0);
    DefineMethod('glStencilMask',1,tkNone,nil,__glStencilMask,false,0);
    DefineMethod('glStencilOp',3,tkNone,nil,__glStencilOp,false,0);
    DefineMethod('glTexCoord1d',1,tkNone,nil,__glTexCoord1d,false,0);
    DefineMethod('glTexCoord1f',1,tkNone,nil,__glTexCoord1f,false,0);
    DefineMethod('glTexCoord1i',1,tkNone,nil,__glTexCoord1i,false,0);
    DefineMethod('glTexCoord1s',1,tkNone,nil,__glTexCoord1s,false,0);
    DefineMethod('glTexCoord2d',2,tkNone,nil,__glTexCoord2d,false,0);
    DefineMethod('glTexCoord2f',2,tkNone,nil,__glTexCoord2f,false,0);
    DefineMethod('glTexCoord2i',2,tkNone,nil,__glTexCoord2i,false,0);
    DefineMethod('glTexCoord2s',2,tkNone,nil,__glTexCoord2s,false,0);
    DefineMethod('glTexCoord3d',3,tkNone,nil,__glTexCoord3d,false,0);
    DefineMethod('glTexCoord3f',3,tkNone,nil,__glTexCoord3f,false,0);
    DefineMethod('glTexCoord3i',3,tkNone,nil,__glTexCoord3i,false,0);
    DefineMethod('glTexCoord3s',3,tkNone,nil,__glTexCoord3s,false,0);
    DefineMethod('glTexCoord4d',4,tkNone,nil,__glTexCoord4d,false,0);
    DefineMethod('glTexCoord4f',4,tkNone,nil,__glTexCoord4f,false,0);
    DefineMethod('glTexCoord4i',4,tkNone,nil,__glTexCoord4i,false,0);
    DefineMethod('glTexCoord4s',4,tkNone,nil,__glTexCoord4s,false,0);
    DefineMethod('glTexCoord',1,tkNone,nil,__glTexCoord,false,0);
    DefineMethod('glTexEnvf',3,tkNone,nil,__glTexEnvf,false,0);
    DefineMethod('glTexEnvi',3,tkNone,nil,__glTexEnvi,false,0);
    DefineMethod('glTexEnv',3,tkNone,nil,__glTexEnv,false,0);
    DefineMethod('glTexGend',3,tkNone,nil,__glTexGend,false,0);
    DefineMethod('glTexGenf',3,tkNone,nil,__glTexGenf,false,0);
    DefineMethod('glTexGeni',3,tkNone,nil,__glTexGeni,false,0);
    DefineMethod('glTexGen',3,tkNone,nil,__glTexGen,false,0);
    DefineMethod('glTexParameterf',3,tkNone,nil,__glTexParameterf,false,0);
    DefineMethod('glTexParameteri',3,tkNone,nil,__glTexParameteri,false,0);
    DefineMethod('glTexParameter',3,tkNone,nil,__glTexParameter,false,0);
    DefineMethod('glTranslated',3,tkNone,nil,__glTranslated,false,0);
    DefineMethod('glTranslatef',3,tkNone,nil,__glTranslatef,false,0);
    DefineMethod('glTranslate',3,tkNone,nil,__glTranslate,false,0);
    DefineMethod('glVertex2d',2,tkNone,nil,__glVertex2d,false,0);
    DefineMethod('glVertex2f',2,tkNone,nil,__glVertex2f,false,0);
    DefineMethod('glVertex2i',2,tkNone,nil,__glVertex2i,false,0);
    DefineMethod('glVertex2s',2,tkNone,nil,__glVertex2s,false,0);
    DefineMethod('glVertex3d',3,tkNone,nil,__glVertex3d,false,0);
    DefineMethod('glVertex3f',3,tkNone,nil,__glVertex3f,false,0);
    DefineMethod('glVertex3i',3,tkNone,nil,__glVertex3i,false,0);
    DefineMethod('glVertex3s',3,tkNone,nil,__glVertex3s,false,0);
    DefineMethod('glVertex4d',4,tkNone,nil,__glVertex4d,false,0);
    DefineMethod('glVertex4f',4,tkNone,nil,__glVertex4f,false,0);
    DefineMethod('glVertex4i',4,tkNone,nil,__glVertex4i,false,0);
    DefineMethod('glVertex4s',4,tkNone,nil,__glVertex4s,false,0);
    DefineMethod('glVertex',2,tkNone,nil,__glVertex,false,0);
    DefineMethod('glViewport',4,tkNone,nil,__glViewport,false,0);
    DefineMethod('gluErrorString',1,tkVariant,nil,__gluErrorString,false,0);
    DefineMethod('gluErrorUnicodeStringEXT',1,tkVariant,nil,__gluErrorUnicodeStringEXT,false,0);
    DefineMethod('gluGetString',1,tkVariant,nil,__gluGetString,false,0);
    DefineMethod('gluLookAt',9,tkNone,nil,__gluLookAt,false,0);
    DefineMethod('gluOrtho2D',4,tkNone,nil,__gluOrtho2D,false,0);
    DefineMethod('gluPerspective',4,tkNone,nil,__gluPerspective,false,0);
    AddConstant('GL_CURRENT_BIT',GL_CURRENT_BIT);
    AddConstant('GL_POINT_BIT',GL_POINT_BIT);
    AddConstant('GL_LINE_BIT',GL_LINE_BIT);
    AddConstant('GL_POLYGON_BIT',GL_POLYGON_BIT);
    AddConstant('GL_POLYGON_STIPPLE_BIT',GL_POLYGON_STIPPLE_BIT);
    AddConstant('GL_PIXEL_MODE_BIT',GL_PIXEL_MODE_BIT);
    AddConstant('GL_LIGHTING_BIT',GL_LIGHTING_BIT);
    AddConstant('GL_FOG_BIT',GL_FOG_BIT);
    AddConstant('GL_DEPTH_BUFFER_BIT',GL_DEPTH_BUFFER_BIT);
    AddConstant('GL_ACCUM_BUFFER_BIT',GL_ACCUM_BUFFER_BIT);
    AddConstant('GL_STENCIL_BUFFER_BIT',GL_STENCIL_BUFFER_BIT);
    AddConstant('GL_VIEWPORT_BIT',GL_VIEWPORT_BIT);
    AddConstant('GL_TRANSFORM_BIT',GL_TRANSFORM_BIT);
    AddConstant('GL_ENABLE_BIT',GL_ENABLE_BIT);
    AddConstant('GL_COLOR_BUFFER_BIT',GL_COLOR_BUFFER_BIT);
    AddConstant('GL_HINT_BIT',GL_HINT_BIT);
    AddConstant('GL_EVAL_BIT',GL_EVAL_BIT);
    AddConstant('GL_LIST_BIT',GL_LIST_BIT);
    AddConstant('GL_TEXTURE_BIT',GL_TEXTURE_BIT);
    AddConstant('GL_SCISSOR_BIT',GL_SCISSOR_BIT);
    AddConstant('GL_ALL_ATTRIB_BITS',GL_ALL_ATTRIB_BITS);
    AddConstant('GL_FALSE',GL_FALSE);
    AddConstant('GL_TRUE',GL_TRUE);
    AddConstant('GL_POINTS',GL_POINTS);
    AddConstant('GL_LINES',GL_LINES);
    AddConstant('GL_LINE_LOOP',GL_LINE_LOOP);
    AddConstant('GL_LINE_STRIP',GL_LINE_STRIP);
    AddConstant('GL_TRIANGLES',GL_TRIANGLES);
    AddConstant('GL_TRIANGLE_STRIP',GL_TRIANGLE_STRIP);
    AddConstant('GL_TRIANGLE_FAN',GL_TRIANGLE_FAN);
    AddConstant('GL_QUADS',GL_QUADS);
    AddConstant('GL_QUAD_STRIP',GL_QUAD_STRIP);
    AddConstant('GL_POLYGON',GL_POLYGON);
    AddConstant('GL_ACCUM',GL_ACCUM);
    AddConstant('GL_LOAD',GL_LOAD);
    AddConstant('GL_RETURN',GL_RETURN);
    AddConstant('GL_MULT',GL_MULT);
    AddConstant('GL_ADD',GL_ADD);
    AddConstant('GL_NEVER',GL_NEVER);
    AddConstant('GL_LESS',GL_LESS);
    AddConstant('GL_EQUAL',GL_EQUAL);
    AddConstant('GL_LEQUAL',GL_LEQUAL);
    AddConstant('GL_GREATER',GL_GREATER);
    AddConstant('GL_NOTEQUAL',GL_NOTEQUAL);
    AddConstant('GL_GEQUAL',GL_GEQUAL);
    AddConstant('GL_ALWAYS',GL_ALWAYS);
    AddConstant('GL_ZERO',GL_ZERO);
    AddConstant('GL_ONE',GL_ONE);
    AddConstant('GL_SRC_COLOR',GL_SRC_COLOR);
    AddConstant('GL_ONE_MINUS_SRC_COLOR',GL_ONE_MINUS_SRC_COLOR);
    AddConstant('GL_SRC_ALPHA',GL_SRC_ALPHA);
    AddConstant('GL_ONE_MINUS_SRC_ALPHA',GL_ONE_MINUS_SRC_ALPHA);
    AddConstant('GL_DST_ALPHA',GL_DST_ALPHA);
    AddConstant('GL_ONE_MINUS_DST_ALPHA',GL_ONE_MINUS_DST_ALPHA);
    AddConstant('GL_DST_COLOR',GL_DST_COLOR);
    AddConstant('GL_ONE_MINUS_DST_COLOR',GL_ONE_MINUS_DST_COLOR);
    AddConstant('GL_SRC_ALPHA_SATURATE',GL_SRC_ALPHA_SATURATE);
    AddConstant('GL_NONE',GL_NONE);
    AddConstant('GL_FRONT_LEFT',GL_FRONT_LEFT);
    AddConstant('GL_FRONT_RIGHT',GL_FRONT_RIGHT);
    AddConstant('GL_BACK_LEFT',GL_BACK_LEFT);
    AddConstant('GL_BACK_RIGHT',GL_BACK_RIGHT);
    AddConstant('GL_FRONT',GL_FRONT);
    AddConstant('GL_BACK',GL_BACK);
    AddConstant('GL_LEFT',GL_LEFT);
    AddConstant('GL_RIGHT',GL_RIGHT);
    AddConstant('GL_FRONT_AND_BACK',GL_FRONT_AND_BACK);
    AddConstant('GL_AUX0',GL_AUX0);
    AddConstant('GL_AUX1',GL_AUX1);
    AddConstant('GL_AUX2',GL_AUX2);
    AddConstant('GL_AUX3',GL_AUX3);
    AddConstant('GL_NO_ERROR',GL_NO_ERROR);
    AddConstant('GL_INVALID_ENUM',GL_INVALID_ENUM);
    AddConstant('GL_INVALID_VALUE',GL_INVALID_VALUE);
    AddConstant('GL_INVALID_OPERATION',GL_INVALID_OPERATION);
    AddConstant('GL_STACK_OVERFLOW',GL_STACK_OVERFLOW);
    AddConstant('GL_STACK_UNDERFLOW',GL_STACK_UNDERFLOW);
    AddConstant('GL_OUT_OF_MEMORY',GL_OUT_OF_MEMORY);
    AddConstant('GL_2D',GL_2D);
    AddConstant('GL_3D',GL_3D);
    AddConstant('GL_3D_COLOR',GL_3D_COLOR);
    AddConstant('GL_3D_COLOR_TEXTURE',GL_3D_COLOR_TEXTURE);
    AddConstant('GL_4D_COLOR_TEXTURE',GL_4D_COLOR_TEXTURE);
    AddConstant('GL_PASS_THROUGH_TOKEN',GL_PASS_THROUGH_TOKEN);
    AddConstant('GL_POINT_TOKEN',GL_POINT_TOKEN);
    AddConstant('GL_LINE_TOKEN',GL_LINE_TOKEN);
    AddConstant('GL_POLYGON_TOKEN',GL_POLYGON_TOKEN);
    AddConstant('GL_BITMAP_TOKEN',GL_BITMAP_TOKEN);
    AddConstant('GL_DRAW_PIXEL_TOKEN',GL_DRAW_PIXEL_TOKEN);
    AddConstant('GL_COPY_PIXEL_TOKEN',GL_COPY_PIXEL_TOKEN);
    AddConstant('GL_LINE_RESET_TOKEN',GL_LINE_RESET_TOKEN);
    AddConstant('GL_EXP',GL_EXP);
    AddConstant('GL_EXP2',GL_EXP2);
    AddConstant('GL_CW',GL_CW);
    AddConstant('GL_CCW',GL_CCW);
    AddConstant('GL_COEFF',GL_COEFF);
    AddConstant('GL_ORDER',GL_ORDER);
    AddConstant('GL_DOMAIN',GL_DOMAIN);
    AddConstant('GL_PIXEL_MAP_I_TO_I',GL_PIXEL_MAP_I_TO_I);
    AddConstant('GL_PIXEL_MAP_S_TO_S',GL_PIXEL_MAP_S_TO_S);
    AddConstant('GL_PIXEL_MAP_I_TO_R',GL_PIXEL_MAP_I_TO_R);
    AddConstant('GL_PIXEL_MAP_I_TO_G',GL_PIXEL_MAP_I_TO_G);
    AddConstant('GL_PIXEL_MAP_I_TO_B',GL_PIXEL_MAP_I_TO_B);
    AddConstant('GL_PIXEL_MAP_I_TO_A',GL_PIXEL_MAP_I_TO_A);
    AddConstant('GL_PIXEL_MAP_R_TO_R',GL_PIXEL_MAP_R_TO_R);
    AddConstant('GL_PIXEL_MAP_G_TO_G',GL_PIXEL_MAP_G_TO_G);
    AddConstant('GL_PIXEL_MAP_B_TO_B',GL_PIXEL_MAP_B_TO_B);
    AddConstant('GL_PIXEL_MAP_A_TO_A',GL_PIXEL_MAP_A_TO_A);
    AddConstant('GL_CURRENT_COLOR',GL_CURRENT_COLOR);
    AddConstant('GL_CURRENT_INDEX',GL_CURRENT_INDEX);
    AddConstant('GL_CURRENT_NORMAL',GL_CURRENT_NORMAL);
    AddConstant('GL_CURRENT_TEXTURE_COORDS',GL_CURRENT_TEXTURE_COORDS);
    AddConstant('GL_CURRENT_RASTER_COLOR',GL_CURRENT_RASTER_COLOR);
    AddConstant('GL_CURRENT_RASTER_INDEX',GL_CURRENT_RASTER_INDEX);
    AddConstant('GL_CURRENT_RASTER_TEXTURE_COORDS',GL_CURRENT_RASTER_TEXTURE_COORDS);
    AddConstant('GL_CURRENT_RASTER_POSITION',GL_CURRENT_RASTER_POSITION);
    AddConstant('GL_CURRENT_RASTER_POSITION_VALID',GL_CURRENT_RASTER_POSITION_VALID);
    AddConstant('GL_CURRENT_RASTER_DISTANCE',GL_CURRENT_RASTER_DISTANCE);
    AddConstant('GL_POINT_SMOOTH',GL_POINT_SMOOTH);
    AddConstant('GL_POINT_SIZE',GL_POINT_SIZE);
    AddConstant('GL_POINT_SIZE_RANGE',GL_POINT_SIZE_RANGE);
    AddConstant('GL_POINT_SIZE_GRANULARITY',GL_POINT_SIZE_GRANULARITY);
    AddConstant('GL_LINE_SMOOTH',GL_LINE_SMOOTH);
    AddConstant('GL_LINE_WIDTH',GL_LINE_WIDTH);
    AddConstant('GL_LINE_WIDTH_RANGE',GL_LINE_WIDTH_RANGE);
    AddConstant('GL_LINE_WIDTH_GRANULARITY',GL_LINE_WIDTH_GRANULARITY);
    AddConstant('GL_LINE_STIPPLE',GL_LINE_STIPPLE);
    AddConstant('GL_LINE_STIPPLE_PATTERN',GL_LINE_STIPPLE_PATTERN);
    AddConstant('GL_LINE_STIPPLE_REPEAT',GL_LINE_STIPPLE_REPEAT);
    AddConstant('GL_LIST_MODE',GL_LIST_MODE);
    AddConstant('GL_MAX_LIST_NESTING',GL_MAX_LIST_NESTING);
    AddConstant('GL_LIST_BASE',GL_LIST_BASE);
    AddConstant('GL_LIST_INDEX',GL_LIST_INDEX);
    AddConstant('GL_POLYGON_MODE',GL_POLYGON_MODE);
    AddConstant('GL_POLYGON_SMOOTH',GL_POLYGON_SMOOTH);
    AddConstant('GL_POLYGON_STIPPLE',GL_POLYGON_STIPPLE);
    AddConstant('GL_EDGE_FLAG',GL_EDGE_FLAG);
    AddConstant('GL_CULL_FACE',GL_CULL_FACE);
    AddConstant('GL_CULL_FACE_MODE',GL_CULL_FACE_MODE);
    AddConstant('GL_FRONT_FACE',GL_FRONT_FACE);
    AddConstant('GL_LIGHTING',GL_LIGHTING);
    AddConstant('GL_LIGHT_MODEL_LOCAL_VIEWER',GL_LIGHT_MODEL_LOCAL_VIEWER);
    AddConstant('GL_LIGHT_MODEL_TWO_SIDE',GL_LIGHT_MODEL_TWO_SIDE);
    AddConstant('GL_LIGHT_MODEL_AMBIENT',GL_LIGHT_MODEL_AMBIENT);
    AddConstant('GL_SHADE_MODEL',GL_SHADE_MODEL);
    AddConstant('GL_COLOR_MATERIAL_FACE',GL_COLOR_MATERIAL_FACE);
    AddConstant('GL_COLOR_MATERIAL_PARAMETER',GL_COLOR_MATERIAL_PARAMETER);
    AddConstant('GL_COLOR_MATERIAL',GL_COLOR_MATERIAL);
    AddConstant('GL_FOG',GL_FOG);
    AddConstant('GL_FOG_INDEX',GL_FOG_INDEX);
    AddConstant('GL_FOG_DENSITY',GL_FOG_DENSITY);
    AddConstant('GL_FOG_START',GL_FOG_START);
    AddConstant('GL_FOG_END',GL_FOG_END);
    AddConstant('GL_FOG_MODE',GL_FOG_MODE);
    AddConstant('GL_FOG_COLOR',GL_FOG_COLOR);
    AddConstant('GL_DEPTH_RANGE',GL_DEPTH_RANGE);
    AddConstant('GL_DEPTH_TEST',GL_DEPTH_TEST);
    AddConstant('GL_DEPTH_WRITEMASK',GL_DEPTH_WRITEMASK);
    AddConstant('GL_DEPTH_CLEAR_VALUE',GL_DEPTH_CLEAR_VALUE);
    AddConstant('GL_DEPTH_FUNC',GL_DEPTH_FUNC);
    AddConstant('GL_ACCUM_CLEAR_VALUE',GL_ACCUM_CLEAR_VALUE);
    AddConstant('GL_STENCIL_TEST',GL_STENCIL_TEST);
    AddConstant('GL_STENCIL_CLEAR_VALUE',GL_STENCIL_CLEAR_VALUE);
    AddConstant('GL_STENCIL_FUNC',GL_STENCIL_FUNC);
    AddConstant('GL_STENCIL_VALUE_MASK',GL_STENCIL_VALUE_MASK);
    AddConstant('GL_STENCIL_FAIL',GL_STENCIL_FAIL);
    AddConstant('GL_STENCIL_PASS_DEPTH_FAIL',GL_STENCIL_PASS_DEPTH_FAIL);
    AddConstant('GL_STENCIL_PASS_DEPTH_PASS',GL_STENCIL_PASS_DEPTH_PASS);
    AddConstant('GL_STENCIL_REF',GL_STENCIL_REF);
    AddConstant('GL_STENCIL_WRITEMASK',GL_STENCIL_WRITEMASK);
    AddConstant('GL_MATRIX_MODE',GL_MATRIX_MODE);
    AddConstant('GL_NORMALIZE',GL_NORMALIZE);
    AddConstant('GL_VIEWPORT',GL_VIEWPORT);
    AddConstant('GL_MODELVIEW_STACK_DEPTH',GL_MODELVIEW_STACK_DEPTH);
    AddConstant('GL_PROJECTION_STACK_DEPTH',GL_PROJECTION_STACK_DEPTH);
    AddConstant('GL_TEXTURE_STACK_DEPTH',GL_TEXTURE_STACK_DEPTH);
    AddConstant('GL_MODELVIEW_MATRIX',GL_MODELVIEW_MATRIX);
    AddConstant('GL_PROJECTION_MATRIX',GL_PROJECTION_MATRIX);
    AddConstant('GL_TEXTURE_MATRIX',GL_TEXTURE_MATRIX);
    AddConstant('GL_ATTRIB_STACK_DEPTH',GL_ATTRIB_STACK_DEPTH);
    AddConstant('GL_ALPHA_TEST',GL_ALPHA_TEST);
    AddConstant('GL_ALPHA_TEST_FUNC',GL_ALPHA_TEST_FUNC);
    AddConstant('GL_ALPHA_TEST_REF',GL_ALPHA_TEST_REF);
    AddConstant('GL_DITHER',GL_DITHER);
    AddConstant('GL_BLEND_DST',GL_BLEND_DST);
    AddConstant('GL_BLEND_SRC',GL_BLEND_SRC);
    AddConstant('GL_BLEND',GL_BLEND);
    AddConstant('GL_LOGIC_OP_MODE',GL_LOGIC_OP_MODE);
    AddConstant('GL_LOGIC_OP',GL_LOGIC_OP);
    AddConstant('GL_AUX_BUFFERS',GL_AUX_BUFFERS);
    AddConstant('GL_DRAW_BUFFER',GL_DRAW_BUFFER);
    AddConstant('GL_READ_BUFFER',GL_READ_BUFFER);
    AddConstant('GL_SCISSOR_BOX',GL_SCISSOR_BOX);
    AddConstant('GL_SCISSOR_TEST',GL_SCISSOR_TEST);
    AddConstant('GL_INDEX_CLEAR_VALUE',GL_INDEX_CLEAR_VALUE);
    AddConstant('GL_INDEX_WRITEMASK',GL_INDEX_WRITEMASK);
    AddConstant('GL_COLOR_CLEAR_VALUE',GL_COLOR_CLEAR_VALUE);
    AddConstant('GL_COLOR_WRITEMASK',GL_COLOR_WRITEMASK);
    AddConstant('GL_INDEX_MODE',GL_INDEX_MODE);
    AddConstant('GL_RGBA_MODE',GL_RGBA_MODE);
    AddConstant('GL_DOUBLEBUFFER',GL_DOUBLEBUFFER);
    AddConstant('GL_STEREO',GL_STEREO);
    AddConstant('GL_RENDER_MODE',GL_RENDER_MODE);
    AddConstant('GL_PERSPECTIVE_CORRECTION_HINT',GL_PERSPECTIVE_CORRECTION_HINT);
    AddConstant('GL_POINT_SMOOTH_HINT',GL_POINT_SMOOTH_HINT);
    AddConstant('GL_LINE_SMOOTH_HINT',GL_LINE_SMOOTH_HINT);
    AddConstant('GL_POLYGON_SMOOTH_HINT',GL_POLYGON_SMOOTH_HINT);
    AddConstant('GL_FOG_HINT',GL_FOG_HINT);
    AddConstant('GL_TEXTURE_GEN_S',GL_TEXTURE_GEN_S);
    AddConstant('GL_TEXTURE_GEN_T',GL_TEXTURE_GEN_T);
    AddConstant('GL_TEXTURE_GEN_R',GL_TEXTURE_GEN_R);
    AddConstant('GL_TEXTURE_GEN_Q',GL_TEXTURE_GEN_Q);
    AddConstant('GL_PIXEL_MAP_I_TO_I_SIZE',GL_PIXEL_MAP_I_TO_I_SIZE);
    AddConstant('GL_PIXEL_MAP_S_TO_S_SIZE',GL_PIXEL_MAP_S_TO_S_SIZE);
    AddConstant('GL_PIXEL_MAP_I_TO_R_SIZE',GL_PIXEL_MAP_I_TO_R_SIZE);
    AddConstant('GL_PIXEL_MAP_I_TO_G_SIZE',GL_PIXEL_MAP_I_TO_G_SIZE);
    AddConstant('GL_PIXEL_MAP_I_TO_B_SIZE',GL_PIXEL_MAP_I_TO_B_SIZE);
    AddConstant('GL_PIXEL_MAP_I_TO_A_SIZE',GL_PIXEL_MAP_I_TO_A_SIZE);
    AddConstant('GL_PIXEL_MAP_R_TO_R_SIZE',GL_PIXEL_MAP_R_TO_R_SIZE);
    AddConstant('GL_PIXEL_MAP_G_TO_G_SIZE',GL_PIXEL_MAP_G_TO_G_SIZE);
    AddConstant('GL_PIXEL_MAP_B_TO_B_SIZE',GL_PIXEL_MAP_B_TO_B_SIZE);
    AddConstant('GL_PIXEL_MAP_A_TO_A_SIZE',GL_PIXEL_MAP_A_TO_A_SIZE);
    AddConstant('GL_UNPACK_SWAP_BYTES',GL_UNPACK_SWAP_BYTES);
    AddConstant('GL_UNPACK_LSB_FIRST',GL_UNPACK_LSB_FIRST);
    AddConstant('GL_UNPACK_ROW_LENGTH',GL_UNPACK_ROW_LENGTH);
    AddConstant('GL_UNPACK_SKIP_ROWS',GL_UNPACK_SKIP_ROWS);
    AddConstant('GL_UNPACK_SKIP_PIXELS',GL_UNPACK_SKIP_PIXELS);
    AddConstant('GL_UNPACK_ALIGNMENT',GL_UNPACK_ALIGNMENT);
    AddConstant('GL_PACK_SWAP_BYTES',GL_PACK_SWAP_BYTES);
    AddConstant('GL_PACK_LSB_FIRST',GL_PACK_LSB_FIRST);
    AddConstant('GL_PACK_ROW_LENGTH',GL_PACK_ROW_LENGTH);
    AddConstant('GL_PACK_SKIP_ROWS',GL_PACK_SKIP_ROWS);
    AddConstant('GL_PACK_SKIP_PIXELS',GL_PACK_SKIP_PIXELS);
    AddConstant('GL_PACK_ALIGNMENT',GL_PACK_ALIGNMENT);
    AddConstant('GL_MAP_COLOR',GL_MAP_COLOR);
    AddConstant('GL_MAP_STENCIL',GL_MAP_STENCIL);
    AddConstant('GL_INDEX_SHIFT',GL_INDEX_SHIFT);
    AddConstant('GL_INDEX_OFFSET',GL_INDEX_OFFSET);
    AddConstant('GL_RED_SCALE',GL_RED_SCALE);
    AddConstant('GL_RED_BIAS',GL_RED_BIAS);
    AddConstant('GL_ZOOM_X',GL_ZOOM_X);
    AddConstant('GL_ZOOM_Y',GL_ZOOM_Y);
    AddConstant('GL_GREEN_SCALE',GL_GREEN_SCALE);
    AddConstant('GL_GREEN_BIAS',GL_GREEN_BIAS);
    AddConstant('GL_BLUE_SCALE',GL_BLUE_SCALE);
    AddConstant('GL_BLUE_BIAS',GL_BLUE_BIAS);
    AddConstant('GL_ALPHA_SCALE',GL_ALPHA_SCALE);
    AddConstant('GL_ALPHA_BIAS',GL_ALPHA_BIAS);
    AddConstant('GL_DEPTH_SCALE',GL_DEPTH_SCALE);
    AddConstant('GL_DEPTH_BIAS',GL_DEPTH_BIAS);
    AddConstant('GL_MAX_EVAL_ORDER',GL_MAX_EVAL_ORDER);
    AddConstant('GL_MAX_LIGHTS',GL_MAX_LIGHTS);
    AddConstant('GL_MAX_CLIP_PLANES',GL_MAX_CLIP_PLANES);
    AddConstant('GL_MAX_TEXTURE_SIZE',GL_MAX_TEXTURE_SIZE);
    AddConstant('GL_MAX_PIXEL_MAP_TABLE',GL_MAX_PIXEL_MAP_TABLE);
    AddConstant('GL_MAX_ATTRIB_STACK_DEPTH',GL_MAX_ATTRIB_STACK_DEPTH);
    AddConstant('GL_MAX_MODELVIEW_STACK_DEPTH',GL_MAX_MODELVIEW_STACK_DEPTH);
    AddConstant('GL_MAX_NAME_STACK_DEPTH',GL_MAX_NAME_STACK_DEPTH);
    AddConstant('GL_MAX_PROJECTION_STACK_DEPTH',GL_MAX_PROJECTION_STACK_DEPTH);
    AddConstant('GL_MAX_TEXTURE_STACK_DEPTH',GL_MAX_TEXTURE_STACK_DEPTH);
    AddConstant('GL_MAX_VIEWPORT_DIMS',GL_MAX_VIEWPORT_DIMS);
    AddConstant('GL_SUBPIXEL_BITS',GL_SUBPIXEL_BITS);
    AddConstant('GL_INDEX_BITS',GL_INDEX_BITS);
    AddConstant('GL_RED_BITS',GL_RED_BITS);
    AddConstant('GL_GREEN_BITS',GL_GREEN_BITS);
    AddConstant('GL_BLUE_BITS',GL_BLUE_BITS);
    AddConstant('GL_ALPHA_BITS',GL_ALPHA_BITS);
    AddConstant('GL_DEPTH_BITS',GL_DEPTH_BITS);
    AddConstant('GL_STENCIL_BITS',GL_STENCIL_BITS);
    AddConstant('GL_ACCUM_RED_BITS',GL_ACCUM_RED_BITS);
    AddConstant('GL_ACCUM_GREEN_BITS',GL_ACCUM_GREEN_BITS);
    AddConstant('GL_ACCUM_BLUE_BITS',GL_ACCUM_BLUE_BITS);
    AddConstant('GL_ACCUM_ALPHA_BITS',GL_ACCUM_ALPHA_BITS);
    AddConstant('GL_NAME_STACK_DEPTH',GL_NAME_STACK_DEPTH);
    AddConstant('GL_AUTO_NORMAL',GL_AUTO_NORMAL);
    AddConstant('GL_MAP1_COLOR_4',GL_MAP1_COLOR_4);
    AddConstant('GL_MAP1_INDEX',GL_MAP1_INDEX);
    AddConstant('GL_MAP1_NORMAL',GL_MAP1_NORMAL);
    AddConstant('GL_MAP1_TEXTURE_COORD_1',GL_MAP1_TEXTURE_COORD_1);
    AddConstant('GL_MAP1_TEXTURE_COORD_2',GL_MAP1_TEXTURE_COORD_2);
    AddConstant('GL_MAP1_TEXTURE_COORD_3',GL_MAP1_TEXTURE_COORD_3);
    AddConstant('GL_MAP1_TEXTURE_COORD_4',GL_MAP1_TEXTURE_COORD_4);
    AddConstant('GL_MAP1_VERTEX_3',GL_MAP1_VERTEX_3);
    AddConstant('GL_MAP1_VERTEX_4',GL_MAP1_VERTEX_4);
    AddConstant('GL_MAP2_COLOR_4',GL_MAP2_COLOR_4);
    AddConstant('GL_MAP2_INDEX',GL_MAP2_INDEX);
    AddConstant('GL_MAP2_NORMAL',GL_MAP2_NORMAL);
    AddConstant('GL_MAP2_TEXTURE_COORD_1',GL_MAP2_TEXTURE_COORD_1);
    AddConstant('GL_MAP2_TEXTURE_COORD_2',GL_MAP2_TEXTURE_COORD_2);
    AddConstant('GL_MAP2_TEXTURE_COORD_3',GL_MAP2_TEXTURE_COORD_3);
    AddConstant('GL_MAP2_TEXTURE_COORD_4',GL_MAP2_TEXTURE_COORD_4);
    AddConstant('GL_MAP2_VERTEX_3',GL_MAP2_VERTEX_3);
    AddConstant('GL_MAP2_VERTEX_4',GL_MAP2_VERTEX_4);
    AddConstant('GL_MAP1_GRID_DOMAIN',GL_MAP1_GRID_DOMAIN);
    AddConstant('GL_MAP1_GRID_SEGMENTS',GL_MAP1_GRID_SEGMENTS);
    AddConstant('GL_MAP2_GRID_DOMAIN',GL_MAP2_GRID_DOMAIN);
    AddConstant('GL_MAP2_GRID_SEGMENTS',GL_MAP2_GRID_SEGMENTS);
    AddConstant('GL_TEXTURE_1D',GL_TEXTURE_1D);
    AddConstant('GL_TEXTURE_2D',GL_TEXTURE_2D);
    AddConstant('GL_TEXTURE_WIDTH',GL_TEXTURE_WIDTH);
    AddConstant('GL_TEXTURE_HEIGHT',GL_TEXTURE_HEIGHT);
    AddConstant('GL_TEXTURE_COMPONENTS',GL_TEXTURE_COMPONENTS);
    AddConstant('GL_TEXTURE_BORDER_COLOR',GL_TEXTURE_BORDER_COLOR);
    AddConstant('GL_TEXTURE_BORDER',GL_TEXTURE_BORDER);
    AddConstant('GL_DONT_CARE',GL_DONT_CARE);
    AddConstant('GL_FASTEST',GL_FASTEST);
    AddConstant('GL_NICEST',GL_NICEST);
    AddConstant('GL_AMBIENT',GL_AMBIENT);
    AddConstant('GL_DIFFUSE',GL_DIFFUSE);
    AddConstant('GL_SPECULAR',GL_SPECULAR);
    AddConstant('GL_POSITION',GL_POSITION);
    AddConstant('GL_SPOT_DIRECTION',GL_SPOT_DIRECTION);
    AddConstant('GL_SPOT_EXPONENT',GL_SPOT_EXPONENT);
    AddConstant('GL_SPOT_CUTOFF',GL_SPOT_CUTOFF);
    AddConstant('GL_CONSTANT_ATTENUATION',GL_CONSTANT_ATTENUATION);
    AddConstant('GL_LINEAR_ATTENUATION',GL_LINEAR_ATTENUATION);
    AddConstant('GL_QUADRATIC_ATTENUATION',GL_QUADRATIC_ATTENUATION);
    AddConstant('GL_COMPILE',GL_COMPILE);
    AddConstant('GL_COMPILE_AND_EXECUTE',GL_COMPILE_AND_EXECUTE);
    AddConstant('GL_BYTE',GL_BYTE);
    AddConstant('GL_UNSIGNED_BYTE',GL_UNSIGNED_BYTE);
    AddConstant('GL_SHORT',GL_SHORT);
    AddConstant('GL_UNSIGNED_SHORT',GL_UNSIGNED_SHORT);
    AddConstant('GL_INT',GL_INT);
    AddConstant('GL_UNSIGNED_INT',GL_UNSIGNED_INT);
    AddConstant('GL_FLOAT',GL_FLOAT);
    AddConstant('GL_2_BYTES',GL_2_BYTES);
    AddConstant('GL_3_BYTES',GL_3_BYTES);
    AddConstant('GL_4_BYTES',GL_4_BYTES);
    AddConstant('GL_CLEAR',GL_CLEAR);
    AddConstant('GL_AND',GL_AND);
    AddConstant('GL_AND_REVERSE',GL_AND_REVERSE);
    AddConstant('GL_COPY',GL_COPY);
    AddConstant('GL_AND_INVERTED',GL_AND_INVERTED);
    AddConstant('GL_NOOP',GL_NOOP);
    AddConstant('GL_XOR',GL_XOR);
    AddConstant('GL_OR',GL_OR);
    AddConstant('GL_NOR',GL_NOR);
    AddConstant('GL_EQUIV',GL_EQUIV);
    AddConstant('GL_INVERT',GL_INVERT);
    AddConstant('GL_OR_REVERSE',GL_OR_REVERSE);
    AddConstant('GL_COPY_INVERTED',GL_COPY_INVERTED);
    AddConstant('GL_OR_INVERTED',GL_OR_INVERTED);
    AddConstant('GL_NAND',GL_NAND);
    AddConstant('GL_SET',GL_SET);
    AddConstant('GL_EMISSION',GL_EMISSION);
    AddConstant('GL_SHININESS',GL_SHININESS);
    AddConstant('GL_AMBIENT_AND_DIFFUSE',GL_AMBIENT_AND_DIFFUSE);
    AddConstant('GL_COLOR_INDEXES',GL_COLOR_INDEXES);
    AddConstant('GL_MODELVIEW',GL_MODELVIEW);
    AddConstant('GL_PROJECTION',GL_PROJECTION);
    AddConstant('GL_TEXTURE',GL_TEXTURE);
    AddConstant('GL_COLOR',GL_COLOR);
    AddConstant('GL_DEPTH',GL_DEPTH);
    AddConstant('GL_STENCIL',GL_STENCIL);
    AddConstant('GL_COLOR_INDEX',GL_COLOR_INDEX);
    AddConstant('GL_STENCIL_INDEX',GL_STENCIL_INDEX);
    AddConstant('GL_DEPTH_COMPONENT',GL_DEPTH_COMPONENT);
    AddConstant('GL_RED',GL_RED);
    AddConstant('GL_GREEN',GL_GREEN);
    AddConstant('GL_BLUE',GL_BLUE);
    AddConstant('GL_ALPHA',GL_ALPHA);
    AddConstant('GL_RGB',GL_RGB);
    AddConstant('GL_RGBA',GL_RGBA);
    AddConstant('GL_LUMINANCE',GL_LUMINANCE);
    AddConstant('GL_LUMINANCE_ALPHA',GL_LUMINANCE_ALPHA);
    AddConstant('GL_BITMAP',GL_BITMAP);
    AddConstant('GL_POINT',GL_POINT);
    AddConstant('GL_LINE',GL_LINE);
    AddConstant('GL_FILL',GL_FILL);
    AddConstant('GL_RENDER',GL_RENDER);
    AddConstant('GL_FEEDBACK',GL_FEEDBACK);
    AddConstant('GL_SELECT',GL_SELECT);
    AddConstant('GL_FLAT',GL_FLAT);
    AddConstant('GL_SMOOTH',GL_SMOOTH);
    AddConstant('GL_KEEP',GL_KEEP);
    AddConstant('GL_REPLACE',GL_REPLACE);
    AddConstant('GL_INCR',GL_INCR);
    AddConstant('GL_DECR',GL_DECR);
    AddConstant('GL_VENDOR',GL_VENDOR);
    AddConstant('GL_RENDERER',GL_RENDERER);
    AddConstant('GL_VERSION',GL_VERSION);
    AddConstant('GL_EXTENSIONS',GL_EXTENSIONS);
    AddConstant('GL_S',GL_S);
    AddConstant('GL_T',GL_T);
    AddConstant('GL_R',GL_R);
    AddConstant('GL_Q',GL_Q);
    AddConstant('GL_MODULATE',GL_MODULATE);
    AddConstant('GL_DECAL',GL_DECAL);
    AddConstant('GL_TEXTURE_ENV_MODE',GL_TEXTURE_ENV_MODE);
    AddConstant('GL_TEXTURE_ENV_COLOR',GL_TEXTURE_ENV_COLOR);
    AddConstant('GL_TEXTURE_ENV',GL_TEXTURE_ENV);
    AddConstant('GL_EYE_LINEAR',GL_EYE_LINEAR);
    AddConstant('GL_OBJECT_LINEAR',GL_OBJECT_LINEAR);
    AddConstant('GL_SPHERE_MAP',GL_SPHERE_MAP);
    AddConstant('GL_TEXTURE_GEN_MODE',GL_TEXTURE_GEN_MODE);
    AddConstant('GL_OBJECT_PLANE',GL_OBJECT_PLANE);
    AddConstant('GL_EYE_PLANE',GL_EYE_PLANE);
    AddConstant('GL_NEAREST',GL_NEAREST);
    AddConstant('GL_LINEAR',GL_LINEAR);
    AddConstant('GL_NEAREST_MIPMAP_NEAREST',GL_NEAREST_MIPMAP_NEAREST);
    AddConstant('GL_LINEAR_MIPMAP_NEAREST',GL_LINEAR_MIPMAP_NEAREST);
    AddConstant('GL_NEAREST_MIPMAP_LINEAR',GL_NEAREST_MIPMAP_LINEAR);
    AddConstant('GL_LINEAR_MIPMAP_LINEAR',GL_LINEAR_MIPMAP_LINEAR);
    AddConstant('GL_TEXTURE_MAG_FILTER',GL_TEXTURE_MAG_FILTER);
    AddConstant('GL_TEXTURE_MIN_FILTER',GL_TEXTURE_MIN_FILTER);
    AddConstant('GL_TEXTURE_WRAP_S',GL_TEXTURE_WRAP_S);
    AddConstant('GL_TEXTURE_WRAP_T',GL_TEXTURE_WRAP_T);
    AddConstant('GL_CLAMP',GL_CLAMP);
    AddConstant('GL_REPEAT',GL_REPEAT);
    AddConstant('GL_CLIP_PLANE0',GL_CLIP_PLANE0);
    AddConstant('GL_CLIP_PLANE1',GL_CLIP_PLANE1);
    AddConstant('GL_CLIP_PLANE2',GL_CLIP_PLANE2);
    AddConstant('GL_CLIP_PLANE3',GL_CLIP_PLANE3);
    AddConstant('GL_CLIP_PLANE4',GL_CLIP_PLANE4);
    AddConstant('GL_CLIP_PLANE5',GL_CLIP_PLANE5);
    AddConstant('GL_LIGHT0',GL_LIGHT0);
    AddConstant('GL_LIGHT1',GL_LIGHT1);
    AddConstant('GL_LIGHT2',GL_LIGHT2);
    AddConstant('GL_LIGHT3',GL_LIGHT3);
    AddConstant('GL_LIGHT4',GL_LIGHT4);
    AddConstant('GL_LIGHT5',GL_LIGHT5);
    AddConstant('GL_LIGHT6',GL_LIGHT6);
    AddConstant('GL_LIGHT7',GL_LIGHT7);
    AddConstant('GL_EXT_vertex_array',GL_EXT_vertex_array);
    AddConstant('GL_WIN_swap_hint',GL_WIN_swap_hint);
    AddConstant('GL_VERTEX_ARRAY_EXT',GL_VERTEX_ARRAY_EXT);
    AddConstant('GL_NORMAL_ARRAY_EXT',GL_NORMAL_ARRAY_EXT);
    AddConstant('GL_COLOR_ARRAY_EXT',GL_COLOR_ARRAY_EXT);
    AddConstant('GL_INDEX_ARRAY_EXT',GL_INDEX_ARRAY_EXT);
    AddConstant('GL_TEXTURE_COORD_ARRAY_EXT',GL_TEXTURE_COORD_ARRAY_EXT);
    AddConstant('GL_EDGE_FLAG_ARRAY_EXT',GL_EDGE_FLAG_ARRAY_EXT);
    AddConstant('GL_VERTEX_ARRAY_SIZE_EXT',GL_VERTEX_ARRAY_SIZE_EXT);
    AddConstant('GL_VERTEX_ARRAY_TYPE_EXT',GL_VERTEX_ARRAY_TYPE_EXT);
    AddConstant('GL_VERTEX_ARRAY_STRIDE_EXT',GL_VERTEX_ARRAY_STRIDE_EXT);
    AddConstant('GL_VERTEX_ARRAY_COUNT_EXT',GL_VERTEX_ARRAY_COUNT_EXT);
    AddConstant('GL_NORMAL_ARRAY_TYPE_EXT',GL_NORMAL_ARRAY_TYPE_EXT);
    AddConstant('GL_NORMAL_ARRAY_STRIDE_EXT',GL_NORMAL_ARRAY_STRIDE_EXT);
    AddConstant('GL_NORMAL_ARRAY_COUNT_EXT',GL_NORMAL_ARRAY_COUNT_EXT);
    AddConstant('GL_COLOR_ARRAY_SIZE_EXT',GL_COLOR_ARRAY_SIZE_EXT);
    AddConstant('GL_COLOR_ARRAY_TYPE_EXT',GL_COLOR_ARRAY_TYPE_EXT);
    AddConstant('GL_COLOR_ARRAY_STRIDE_EXT',GL_COLOR_ARRAY_STRIDE_EXT);
    AddConstant('GL_COLOR_ARRAY_COUNT_EXT',GL_COLOR_ARRAY_COUNT_EXT);
    AddConstant('GL_INDEX_ARRAY_TYPE_EXT',GL_INDEX_ARRAY_TYPE_EXT);
    AddConstant('GL_INDEX_ARRAY_STRIDE_EXT',GL_INDEX_ARRAY_STRIDE_EXT);
    AddConstant('GL_INDEX_ARRAY_COUNT_EXT',GL_INDEX_ARRAY_COUNT_EXT);
    AddConstant('GL_TEXTURE_COORD_ARRAY_SIZE_EXT',GL_TEXTURE_COORD_ARRAY_SIZE_EXT);
    AddConstant('GL_TEXTURE_COORD_ARRAY_TYPE_EXT',GL_TEXTURE_COORD_ARRAY_TYPE_EXT);
    AddConstant('GL_TEXTURE_COORD_ARRAY_STRIDE_EXT',GL_TEXTURE_COORD_ARRAY_STRIDE_EXT);
    AddConstant('GL_TEXTURE_COORD_ARRAY_COUNT_EXT',GL_TEXTURE_COORD_ARRAY_COUNT_EXT);
    AddConstant('GL_EDGE_FLAG_ARRAY_STRIDE_EXT',GL_EDGE_FLAG_ARRAY_STRIDE_EXT);
    AddConstant('GL_EDGE_FLAG_ARRAY_COUNT_EXT',GL_EDGE_FLAG_ARRAY_COUNT_EXT);
    AddConstant('GL_VERTEX_ARRAY_POINTER_EXT',GL_VERTEX_ARRAY_POINTER_EXT);
    AddConstant('GL_NORMAL_ARRAY_POINTER_EXT',GL_NORMAL_ARRAY_POINTER_EXT);
    AddConstant('GL_COLOR_ARRAY_POINTER_EXT',GL_COLOR_ARRAY_POINTER_EXT);
    AddConstant('GL_INDEX_ARRAY_POINTER_EXT',GL_INDEX_ARRAY_POINTER_EXT);
    AddConstant('GL_TEXTURE_COORD_ARRAY_POINTER_EXT',GL_TEXTURE_COORD_ARRAY_POINTER_EXT);
    AddConstant('GL_EDGE_FLAG_ARRAY_POINTER_EXT',GL_EDGE_FLAG_ARRAY_POINTER_EXT);
    AddConstant('WGL_FONT_LINES',WGL_FONT_LINES);
    AddConstant('WGL_FONT_POLYGONS',WGL_FONT_POLYGONS);
    AddConstant('GLU_VERSION_1_1',GLU_VERSION_1_1);
    AddConstant('GLU_INVALID_ENUM',GLU_INVALID_ENUM);
    AddConstant('GLU_INVALID_VALUE',GLU_INVALID_VALUE);
    AddConstant('GLU_OUT_OF_MEMORY',GLU_OUT_OF_MEMORY);
    AddConstant('GLU_INCOMPATIBLE_GL_VERSION',GLU_INCOMPATIBLE_GL_VERSION);
    AddConstant('GLU_VERSION',GLU_VERSION);
    AddConstant('GLU_EXTENSIONS',GLU_EXTENSIONS);
    AddConstant('GLU_TRUE',GLU_TRUE);
    AddConstant('GLU_FALSE',GLU_FALSE);
    AddConstant('GLU_SMOOTH',GLU_SMOOTH);
    AddConstant('GLU_FLAT',GLU_FLAT);
    AddConstant('GLU_NONE',GLU_NONE);
    AddConstant('GLU_POINT',GLU_POINT);
    AddConstant('GLU_LINE',GLU_LINE);
    AddConstant('GLU_FILL',GLU_FILL);
    AddConstant('GLU_SILHOUETTE',GLU_SILHOUETTE);
    AddConstant('GLU_OUTSIDE',GLU_OUTSIDE);
    AddConstant('GLU_INSIDE',GLU_INSIDE);
    AddConstant('GLU_TESS_MAX_COORD',GLU_TESS_MAX_COORD);
    AddConstant('GLU_TESS_WINDING_RULE',GLU_TESS_WINDING_RULE);
    AddConstant('GLU_TESS_BOUNDARY_ONLY',GLU_TESS_BOUNDARY_ONLY);
    AddConstant('GLU_TESS_TOLERANCE',GLU_TESS_TOLERANCE);
    AddConstant('GLU_TESS_WINDING_ODD',GLU_TESS_WINDING_ODD);
    AddConstant('GLU_TESS_WINDING_NONZERO',GLU_TESS_WINDING_NONZERO);
    AddConstant('GLU_TESS_WINDING_POSITIVE',GLU_TESS_WINDING_POSITIVE);
    AddConstant('GLU_TESS_WINDING_NEGATIVE',GLU_TESS_WINDING_NEGATIVE);
    AddConstant('GLU_TESS_WINDING_ABS_GEQ_TWO',GLU_TESS_WINDING_ABS_GEQ_TWO);
    AddConstant('GLU_TESS_BEGIN',GLU_TESS_BEGIN);
    AddConstant('GLU_TESS_VERTEX',GLU_TESS_VERTEX);
    AddConstant('GLU_TESS_END',GLU_TESS_END);
    AddConstant('GLU_TESS_ERROR',GLU_TESS_ERROR);
    AddConstant('GLU_TESS_EDGE_FLAG',GLU_TESS_EDGE_FLAG);
    AddConstant('GLU_TESS_COMBINE',GLU_TESS_COMBINE);
    AddConstant('GLU_TESS_ERROR1',GLU_TESS_ERROR1);
    AddConstant('GLU_TESS_ERROR2',GLU_TESS_ERROR2);
    AddConstant('GLU_TESS_ERROR3',GLU_TESS_ERROR3);
    AddConstant('GLU_TESS_ERROR4',GLU_TESS_ERROR4);
    AddConstant('GLU_TESS_ERROR5',GLU_TESS_ERROR5);
    AddConstant('GLU_TESS_ERROR6',GLU_TESS_ERROR6);
    AddConstant('GLU_TESS_ERROR7',GLU_TESS_ERROR7);
    AddConstant('GLU_TESS_ERROR8',GLU_TESS_ERROR8);
    AddConstant('GLU_TESS_MISSING_BEGIN_POLYGON',GLU_TESS_MISSING_BEGIN_POLYGON);
    AddConstant('GLU_TESS_MISSING_BEGIN_CONTOUR',GLU_TESS_MISSING_BEGIN_CONTOUR);
    AddConstant('GLU_TESS_MISSING_END_POLYGON',GLU_TESS_MISSING_END_POLYGON);
    AddConstant('GLU_TESS_MISSING_END_CONTOUR',GLU_TESS_MISSING_END_CONTOUR);
    AddConstant('GLU_TESS_COORD_TOO_LARGE',GLU_TESS_COORD_TOO_LARGE);
    AddConstant('GLU_TESS_NEED_COMBINE_CALLBACK',GLU_TESS_NEED_COMBINE_CALLBACK);
    AddConstant('GLU_AUTO_LOAD_MATRIX',GLU_AUTO_LOAD_MATRIX);
    AddConstant('GLU_CULLING',GLU_CULLING);
    AddConstant('GLU_SAMPLING_TOLERANCE',GLU_SAMPLING_TOLERANCE);
    AddConstant('GLU_DISPLAY_MODE',GLU_DISPLAY_MODE);
    AddConstant('GLU_PARAMETRIC_TOLERANCE',GLU_PARAMETRIC_TOLERANCE);
    AddConstant('GLU_SAMPLING_METHOD',GLU_SAMPLING_METHOD);
    AddConstant('GLU_U_STEP',GLU_U_STEP);
    AddConstant('GLU_V_STEP',GLU_V_STEP);
    AddConstant('GLU_PATH_LENGTH',GLU_PATH_LENGTH);
    AddConstant('GLU_PARAMETRIC_ERROR',GLU_PARAMETRIC_ERROR);
    AddConstant('GLU_DOMAIN_DISTANCE',GLU_DOMAIN_DISTANCE);
    AddConstant('GLU_MAP1_TRIM_2',GLU_MAP1_TRIM_2);
    AddConstant('GLU_MAP1_TRIM_3',GLU_MAP1_TRIM_3);
    AddConstant('GLU_OUTLINE_POLYGON',GLU_OUTLINE_POLYGON);
    AddConstant('GLU_OUTLINE_PATCH',GLU_OUTLINE_PATCH);
    AddConstant('GLU_NURBS_ERROR1',GLU_NURBS_ERROR1);
    AddConstant('GLU_NURBS_ERROR2',GLU_NURBS_ERROR2);
    AddConstant('GLU_NURBS_ERROR3',GLU_NURBS_ERROR3);
    AddConstant('GLU_NURBS_ERROR4',GLU_NURBS_ERROR4);
    AddConstant('GLU_NURBS_ERROR5',GLU_NURBS_ERROR5);
    AddConstant('GLU_NURBS_ERROR6',GLU_NURBS_ERROR6);
    AddConstant('GLU_NURBS_ERROR7',GLU_NURBS_ERROR7);
    AddConstant('GLU_NURBS_ERROR8',GLU_NURBS_ERROR8);
    AddConstant('GLU_NURBS_ERROR9',GLU_NURBS_ERROR9);
    AddConstant('GLU_NURBS_ERROR10',GLU_NURBS_ERROR10);
    AddConstant('GLU_NURBS_ERROR11',GLU_NURBS_ERROR11);
    AddConstant('GLU_NURBS_ERROR12',GLU_NURBS_ERROR12);
    AddConstant('GLU_NURBS_ERROR13',GLU_NURBS_ERROR13);
    AddConstant('GLU_NURBS_ERROR14',GLU_NURBS_ERROR14);
    AddConstant('GLU_NURBS_ERROR15',GLU_NURBS_ERROR15);
    AddConstant('GLU_NURBS_ERROR16',GLU_NURBS_ERROR16);
    AddConstant('GLU_NURBS_ERROR17',GLU_NURBS_ERROR17);
    AddConstant('GLU_NURBS_ERROR18',GLU_NURBS_ERROR18);
    AddConstant('GLU_NURBS_ERROR19',GLU_NURBS_ERROR19);
    AddConstant('GLU_NURBS_ERROR20',GLU_NURBS_ERROR20);
    AddConstant('GLU_NURBS_ERROR21',GLU_NURBS_ERROR21);
    AddConstant('GLU_NURBS_ERROR22',GLU_NURBS_ERROR22);
    AddConstant('GLU_NURBS_ERROR23',GLU_NURBS_ERROR23);
    AddConstant('GLU_NURBS_ERROR24',GLU_NURBS_ERROR24);
    AddConstant('GLU_NURBS_ERROR25',GLU_NURBS_ERROR25);
    AddConstant('GLU_NURBS_ERROR26',GLU_NURBS_ERROR26);
    AddConstant('GLU_NURBS_ERROR27',GLU_NURBS_ERROR27);
    AddConstant('GLU_NURBS_ERROR28',GLU_NURBS_ERROR28);
    AddConstant('GLU_NURBS_ERROR29',GLU_NURBS_ERROR29);
    AddConstant('GLU_NURBS_ERROR30',GLU_NURBS_ERROR30);
    AddConstant('GLU_NURBS_ERROR31',GLU_NURBS_ERROR31);
    AddConstant('GLU_NURBS_ERROR32',GLU_NURBS_ERROR32);
    AddConstant('GLU_NURBS_ERROR33',GLU_NURBS_ERROR33);
    AddConstant('GLU_NURBS_ERROR34',GLU_NURBS_ERROR34);
    AddConstant('GLU_NURBS_ERROR35',GLU_NURBS_ERROR35);
    AddConstant('GLU_NURBS_ERROR36',GLU_NURBS_ERROR36);
    AddConstant('GLU_NURBS_ERROR37',GLU_NURBS_ERROR37);
    AddConstant('glu32',glu32);
  end;
end;

class function TatOpenGLLibrary.LibraryName: string;
begin
  result := 'OpenGL';
end;

initialization
  RegisterScripterLibrary(TatOpenGLLibrary, True);

{$WARNINGS ON}

end.

