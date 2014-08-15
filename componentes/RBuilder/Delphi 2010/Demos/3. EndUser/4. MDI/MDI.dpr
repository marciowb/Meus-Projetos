program mdi;

uses
  Forms,
  mdichild in 'mdichild.pas' {frmInvisible},
  mdiform in 'Mdiform.pas' {frmMDIParent};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMDIParent, frmMDIParent);
  Application.Run;
end.
