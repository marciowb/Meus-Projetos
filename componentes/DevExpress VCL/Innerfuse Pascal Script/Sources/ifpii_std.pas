unit ifpii_std;
{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;

{
  Will register files from:
    System
    Classes (Only TComponent and TPersistent)

}

procedure SIRegister_Std_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTObject(CL: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTPersistent(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTComponent(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegister_Std(Cl: TIFPSCompileTimeClassesImporter);

implementation

procedure SIRegisterTObject(CL: TIFPSCompileTimeClassesImporter);
begin
  with cl.Add2(nil, 'TOBJECT') do
  begin
    RegisterMethod('constructor Create');
    RegisterMethod('procedure Free');
  end;
end;

procedure SIRegisterTPersistent(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TObject'), 'TPERSISTENT') do
  begin
    RegisterMethod('procedure Assign(Source: TPersistent)');
  end;
end;

procedure SIRegisterTComponent(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TPersistent'), 'TCOMPONENT') do
  begin
    RegisterMethod('function FindComponent(AName: string): TComponent;');
    RegisterMethod('constructor Create(AOwner: TComponent); virtual;');

    RegisterProperty('Owner', 'TComponent', iptRW);
    RegisterMethod('procedure DESTROYCOMPONENTS');
    RegisterMethod('procedure DESTROYING');
    RegisterMethod('procedure FREENOTIFICATION(ACOMPONENT:TCOMPONENT)');
    RegisterMethod('procedure INSERTCOMPONENT(ACOMPONENT:TCOMPONENT)');
    RegisterMethod('procedure REMOVECOMPONENT(ACOMPONENT:TCOMPONENT)');
    RegisterProperty('COMPONENTS', 'TCOMPONENT INTEGER', iptr);
    RegisterProperty('COMPONENTCOUNT', 'INTEGER', iptr);
    RegisterProperty('COMPONENTINDEX', 'INTEGER', iptrw);
    RegisterProperty('COMPONENTSTATE', 'Byte', iptr);
    RegisterProperty('DESIGNINFO', 'LONGINT', iptrw);
    RegisterProperty('NAME', 'STRING', iptrw);
    RegisterProperty('TAG', 'LONGINT', iptrw);
  end;
end;




procedure SIRegister_Std_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
begin
  cl.se.AddConstantN('csLoading', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csReading', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csWriting', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csDestroying', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csDesigning', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csAncestor', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csUpdating', 'Byte')^.Value.tu8 := 0;
  cl.se.AddConstantN('csFixups', 'Byte')^.Value.tu8 := 0;
  cl.se.AddTypeS('TRect', 'record Left, Top, Right, Bottom: Integer; end;');  
end;

procedure SIRegister_Std(Cl: TIFPSCompileTimeClassesImporter);
begin
  SIRegister_Std_TypesAndConsts(Cl);
  SIRegisterTObject(CL);
  SIRegisterTPersistent(Cl);
  SIRegisterTComponent(Cl);
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)


End.

