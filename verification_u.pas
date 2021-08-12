unit verification_u;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils;

type
	TfrmPinVerify = class(TForm)
		btnSubmitPIN: TButton;
		StaticText1: TStaticText;
		edtPinCode: TEdit;
		lblCredentialsString: TLabel;
		lblInformation: TLabel;
		BalloonHint1: TBalloonHint;
		procedure btnSubmitPINClick(Sender: TObject);
		procedure lblInformationClick(Sender: TObject);
		procedure lblInformationMouseEnter(Sender: TObject);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;

var
	frmPinVerify: TfrmPinVerify;

implementation

uses login_u, keygeneration_u;
// in implementation to avoid a circular reference

{$R *.dfm}

procedure TfrmPinVerify.btnSubmitPINClick(Sender: TObject);
var
	sPin: String;
begin
	sPin := SplitString(lblCredentialsString.Caption, ',')[2];
	// only pin portion from string
	if edtPinCode.Text = sPin then
	begin
		ShowMessage('You have successfully logged into your account!');
		frmKeyGeneration.Show;
		Self.Hide;
		frmAuthentication.Hide;
	end
	else
	begin
		ShowMessage('Invalid PIN code!');
	end;
end;

procedure TfrmPinVerify.lblInformationClick(Sender: TObject);
begin
	frmAuthentication.displayHelpWebsite;
end;

procedure TfrmPinVerify.lblInformationMouseEnter(Sender: TObject);
begin
	lblInformation.Hint :=
		'Enter your PIN Code|Enter the PIN Code provided to you when Signing Up in the corresponding box.'
		+ sLineBreak + 'You can also click on this icon to get more detailed help!'
		+ sLineBreak;
end;

end.
