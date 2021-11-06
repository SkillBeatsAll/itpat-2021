program JoelCedras_PAT;

uses
  Vcl.Forms,
  login_u in 'login_u.pas' {frmAuthentication},
  verification_u in 'verification_u.pas' {frmPinVerify},
  keygeneration_u in 'keygeneration_u.pas' {frmKeyGeneration},
  help_u in 'help_u.pas' {frmHelpWebsite},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Key Generator';
  Application.CreateForm(TfrmAuthentication, frmAuthentication);
  Application.CreateForm(TfrmPinVerify, frmPinVerify);
  Application.CreateForm(TfrmKeyGeneration, frmKeyGeneration);
  Application.CreateForm(TfrmHelpWebsite, frmHelpWebsite);
  Application.Run;
end.
