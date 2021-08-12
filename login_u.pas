// CREDIT FOR ICONS: Icons8.com, Flaticon.com

unit login_u;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Math,
	StrUtils, RegularExpressions;

type
	TfrmAuthentication = class(TForm)
		btnSignIn: TButton;
		btnRegister: TButton;
		lblStatus: TLabel;
		edtEmailAddress: TEdit;
		edtPassword: TEdit;
		StaticText1: TStaticText;
		StaticText2: TStaticText;
		imgCaptcha: TImage;
		btnNewCaptcha: TButton;
		StaticText3: TStaticText;
		edtCaptchaInput: TEdit;
		lblInformation: TLabel;
		BalloonHint1: TBalloonHint;
		procedure FormCreate(Sender: TObject);
		procedure btnNewCaptchaClick(Sender: TObject);
		procedure btnSignInClick(Sender: TObject);
		procedure btnRegisterClick(Sender: TObject);
		procedure lblInformationClick(Sender: TObject);
		procedure lblInformationMouseEnter(Sender: TObject);
	private
		{ Private declarations }
		/// <summary> Generates text for use in a captcha.
		/// </summary>
		/// <returns> (string) Randomly generated text
		/// </returns>
		function generateCaptchaText: String;
	public
		{ Public declarations }
		/// <summary> Displays the help form with the help website pre-loaded.
		/// </summary>
		/// <returns> (boolean) True
		/// </returns>
		function displayHelpWebsite: Boolean;
	end;

var
	frmAuthentication: TfrmAuthentication;
	sCaptchaSolution: String;
	tCredentialsFile: TextFile;

implementation

uses verification_u, help_u;
{$R *.dfm}

// handle generating a new captcha
procedure TfrmAuthentication.btnNewCaptchaClick(Sender: TObject);
var
	i: Integer; // used in for loop
begin
	sCaptchaSolution := generateCaptchaText; // generate text for captcha
	imgCaptcha.Picture := Nil; // reset captcha
	// makes text transparent so it can be drawn over
	imgCaptcha.Canvas.Brush.Style := bsClear;

	// set text settings
	imgCaptcha.Canvas.Font.Size := 30;
	imgCaptcha.Canvas.Font.Color := RandomRange(0, 17000000);
	imgCaptcha.Canvas.Font.Style := [fsBold, fsItalic];
	imgCaptcha.Canvas.TextOut(1, RandomRange(1, 13), sCaptchaSolution);
	// output text at x: 1, y: random from 1 to 13

	// add random lines to make captcha hard for bots to solve:
	for i := 0 to 20 do
	begin
		imgCaptcha.Canvas.Pen.Color := Random(6969420); // pen color randomize
		// handles drawing of lines
		imgCaptcha.Canvas.MoveTo(Random(imgCaptcha.Width),
			Random(imgCaptcha.Height));
		imgCaptcha.Canvas.LineTo(Random(imgCaptcha.Width),
			Random(imgCaptcha.Height));
	end;
end;

// handle new user registration
procedure TfrmAuthentication.btnRegisterClick(Sender: TObject);
var
	sCredentials, sCurrentLine: String;
	iGeneratedPin: Integer;
	bAlreadyRegistered: Boolean;
	emailRegex: TRegEx;
begin
	iGeneratedPin := RandomRange(1000, 9999); // random range is the pin code
	emailRegex := TRegEx.Create
		('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$');
	if edtCaptchaInput.Text = sCaptchaSolution then
	begin // <- if captcha is solved correctly, continue
		if not(edtEmailAddress.Text = '') and not(edtPassword.Text = '') then
		begin // <- if email + password is not blank
			if emailRegex.Match(edtEmailAddress.Text).Success then
			// check if the email is in a valid format
			begin
				Reset(tCredentialsFile);
				bAlreadyRegistered := False;
				while not Eof(tCredentialsFile) do
				// Eof = end of file; while not at the end of the file
				begin
					Readln(tCredentialsFile, sCurrentLine);
					if sCurrentLine.Contains(edtEmailAddress.Text + ',') then
					// check if their email is in the system
					begin
						bAlreadyRegistered := True;
						Break;
					end
					else
						bAlreadyRegistered := False;
				end;
				CloseFile(tCredentialsFile);

				if not bAlreadyRegistered then
				// if they arent registered, register them
				begin
					sCredentials := edtEmailAddress.Text + ',' + edtPassword.Text + ',' +
						IntToStr(iGeneratedPin);
					Append(tCredentialsFile);
					writeLn(tCredentialsFile, sCredentials);
					CloseFile(tCredentialsFile);
					ShowMessage('Successfully registered!' + sLineBreak +
						'Please write your PIN code down, as you require it for all logins: '
						+ IntToStr(iGeneratedPin)); // output feedback: registered + pin
				end
				else
				begin
					ShowMessage('You are already registered!');
					// output feedback: already registered
					btnNewCaptchaClick(Nil); // generate new captcha
				end;

			end
			else
			begin
				ShowMessage('Your email address is not in the correct format.' +
					sLineBreak + 'It must look like this: example@example.com');
			end;
		end
		else
		begin // <- if email / password blank, dont continue.
			ShowMessage('Your email address or password cannot be blank.');
			// feedback (email/pass blank)
		end;
	end
	else // <- if captcha is wrong, display error, regenerate.
	begin
		ShowMessage('You have incorrectly solved the captcha.');
		// feedback (captcha wrong)
		btnNewCaptchaClick(Nil);
	end;

end;

// handle signing in of user
procedure TfrmAuthentication.btnSignInClick(Sender: TObject);
var
	sCurrentLine: String;
	bLoginFound: Boolean;
begin
	if not(edtCaptchaInput.Text = sCaptchaSolution) then
	begin
		ShowMessage('You have incorrectly solved the captcha.');
		// feedback (captcha wrong)
		btnNewCaptchaClick(Nil);
		Exit;
	end;
	Reset(tCredentialsFile);

	bLoginFound := False; // set to false to avoid initialization warning
	// while loop to populate listbox with credentials
	while not Eof(tCredentialsFile) do
	// Eof = end of file; while not at the end of the file
	begin
		Readln(tCredentialsFile, sCurrentLine);
		if sCurrentLine.Contains(edtEmailAddress.Text + ',' + edtPassword.Text + ',')
		then
		begin
			bLoginFound := True;
			Break;
		end
		else
			bLoginFound := False;
	end;
	CloseFile(tCredentialsFile);

	if not bLoginFound then // if login not found, feedback
	begin
		lblStatus.Font.Color := clRed;
		lblStatus.Caption := 'Invalid email address or password!';
		// feedback, in red (pass/email wrong)
	end
	else
	begin // login found, continue with pin verification
		frmPinVerify.Show;
		frmPinVerify.lblCredentialsString.Caption := sCurrentLine;
	end;

end;

procedure TfrmAuthentication.FormCreate(Sender: TObject);
begin
	Randomize;

	// begin credentials file handling ->
	// assign file to variable tCredentialsFile
	AssignFile(tCredentialsFile, 'credentials.txt');

	// if file doesnt exist, try to create
	if not FileExists('credentials.txt') then
	begin
		Try
			FileClose(FileCreate('credentials.txt'));
		Finally
			// if failed to make file, display error and explain.
			if not FileExists('credentials.txt') then
			begin
				ShowMessage('Credentials file does not exist.' + sLineBreak +
					'Create a file called credentials.txt in the current directory and rerun the program.');
				Application.Terminate;
			end;
		End;
	end;
	// <- END credentials file handling

	btnNewCaptchaClick(Nil); // start form with captcha
end;

// function generates random text for a captcha
function TfrmAuthentication.generateCaptchaText;
var
	sGeneratedCaptcha: String;
	i: Integer; // used in for loop
begin
	sGeneratedCaptcha := '';
	for i := 1 to 5 + Random(4) do
	begin
		sGeneratedCaptcha := sGeneratedCaptcha + chr(33 + Random(93));
		// random character from ascii table within normal keyboard characters
	end;
	Result := sGeneratedCaptcha; // output of function

end;

// function to handle displaying of help website
function TfrmAuthentication.displayHelpWebsite;
begin
	frmHelpWebsite.Show; // show help form
	frmHelpWebsite.WebBrowserHelp.Navigate('file://' + GetCurrentDir +
		'/HELP WEBSITE/Key Generator.html'); // navigate to help website
	Result := True;
end;

procedure TfrmAuthentication.lblInformationClick(Sender: TObject);
begin
	displayHelpWebsite; // calls function
end;

procedure TfrmAuthentication.lblInformationMouseEnter(Sender: TObject);
begin
	lblInformation.Hint :=
		'Register or Sign Up|Enter your email address and password in the corresponding boxes and solve the captcha below!'
		+ sLineBreak + 'You can also click on this icon to get more detailed help!'
		+ sLineBreak;
end;

end.
