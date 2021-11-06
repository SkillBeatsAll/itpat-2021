{ Joel Cedras, Grade 10 2021 - IT PAT | https://github.com/SkillBeatsAll/itpat-2021 }

unit keygeneration_u;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
	Vcl.CheckLst,
	Vcl.ExtCtrls, ClipBrd;

type
	TfrmKeyGeneration = class(TForm)
		pgcGenerationType: TPageControl;
		tabPasswords: TTabSheet;
		tabSerials: TTabSheet;
		chklstPasswordType: TCheckListBox;
		ledtPasswordLength: TLabeledEdit;
		ledtPassword: TLabeledEdit;
		btnGeneratePassword: TButton;
		cboKeyType: TComboBox;
		StaticText1: TStaticText;
		edtCustomText: TEdit;
		StaticText2: TStaticText;
		StaticText3: TStaticText;
		edtKeyLength: TEdit;
		memSerials: TMemo;
		StaticText4: TStaticText;
		cboDelimiter: TCheckBox;
		edtDelimiter: TEdit;
		StaticText5: TStaticText;
		StaticText6: TStaticText;
		edtDelimiterLocation: TEdit;
		btnGenerateKey: TButton;
		btnCopy: TButton;
		btnClearMemo: TButton;
		StaticText7: TStaticText;
		lblInformation: TLabel;
		BalloonHint1: TBalloonHint;
		procedure btnGeneratePasswordClick(Sender: TObject);
		procedure cboKeyTypeChange(Sender: TObject);
		procedure btnGenerateKeyClick(Sender: TObject);
		procedure cboDelimiterClick(Sender: TObject);
		procedure btnClearMemoClick(Sender: TObject);
		procedure btnCopyClick(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure pgcGenerationTypeChange(Sender: TObject);
		procedure lblInformationMouseEnter(Sender: TObject);
		procedure lblInformationClick(Sender: TObject);
	private
		{ Private declarations }
		/// <summary> Generates a password based on user-defined characters
		/// </summary>
		/// <param name="bUppercaseSelected"> Whether the password should contain uppercase characters
		/// </param>
		/// <param name="bLowercaseSelected"> Whether the password should contain lowercase characters
		/// </param>
		/// <param name="bNumericSelected"> Whether the password should contain numeric characters
		/// </param>
		/// <param name="bSpecialSelected"> Whether the password should contain special characters
		/// </param>
		/// <returns> (string) A randomly generated password, based on provided specifications
		/// </returns>
		function GeneratePassword(bUppercaseSelected: Boolean;
			bLowercaseSelected: Boolean; bNumericSelected: Boolean;
			bSpecialSelected: Boolean; iPwdLength: Integer): String;
		/// <summary> Generates a random letter for use in serial key generation
		/// </summary>
		/// <param name="bUppercase"> Whether the letter should be uppercase
		/// </param>
		/// <returns> (char) A randomly generated letter
		/// </returns>
		function GenerateRandomLetter(bUppercase: Boolean): Char;
	public
		{ Public declarations }
	end;

var
	frmKeyGeneration: TfrmKeyGeneration;

implementation

uses login_u;

{$R *.dfm}

// random letter function for serial key generation
function TfrmKeyGeneration.GenerateRandomLetter(bUppercase: Boolean): Char;
var
	caseState: byte; // byte is a smaller integer (for efficiency sake)
begin
	if not bUppercase then
		caseState := 32
	else
		caseState := 0;
	Result := chr(random(26) + 65 + caseState);
	// get a random ascii char dependent on upper(lower)case
end;

procedure TfrmKeyGeneration.lblInformationClick(Sender: TObject);
begin
	frmAuthentication.displayHelpWebsite;
end;

procedure TfrmKeyGeneration.lblInformationMouseEnter(Sender: TObject);
begin
	// when the mouse enters the info label, determine the appropriate hint by checking the current tab.
	if pgcGenerationType.ActivePage.Caption = 'Passwords' then
	begin
		lblInformation.Hint :=
			'Generate a Password|Select a password type(s) and specify the length of your password and then click on the generate button!'
			+ sLineBreak +
			'You can also click on this icon to get more detailed help!' + sLineBreak;
	end
	else
	begin
		lblInformation.Hint :=
			'Generate a Serial Key(s)|Select a key type and specify the length of your key and then click Generate'
			+ sLineBreak +
			'Add a delimiter by specifying the delimiter and its location. (optional)'
			+ sLineBreak +
			'With Delimiter: FA32-RED3-423A                  Without Delimiter: FA32RED3423A'
			+ sLineBreak +
			'You can also click on this icon to get more detailed help!' + sLineBreak;
	end;
end;

// change form caption depending on current page
procedure TfrmKeyGeneration.pgcGenerationTypeChange(Sender: TObject);
begin
	if pgcGenerationType.ActivePage.Caption = 'Passwords' then
		frmKeyGeneration.Caption := 'Key Generation | Passwords'
	else
		frmKeyGeneration.Caption := 'Key Generation | Serial Keys';
end;

// function that handles password generation (called when generate password button is clicked)
function TfrmKeyGeneration.GeneratePassword(bUppercaseSelected: Boolean;
	bLowercaseSelected: Boolean; bNumericSelected: Boolean;
	bSpecialSelected: Boolean; iPwdLength: Integer): String;
const
	sUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	sLower = 'abcdefghijklmnopqrstuvwxyz';
	sNumeric = '0123456789';
	sSpecial = '~!@#$%^&*():;[]{}<>,.?/\|';
var
	sAllowedChars, sPassword: String;
begin
	// checking the type(s) of password and adding that to the character pool to choose from (sAllowedChars)
	if bUppercaseSelected then
		sAllowedChars := sAllowedChars + sUpper;
	if bLowercaseSelected then
		sAllowedChars := sAllowedChars + sLower;
	if bNumericSelected then
		sAllowedChars := sAllowedChars + sNumeric;
	if bSpecialSelected then
		sAllowedChars := sAllowedChars + sSpecial;

	// generates the password from the character pool
	repeat
		sPassword := sPassword + sAllowedChars[random(Length(sAllowedChars)) + 1];
	until (Length(sPassword) = iPwdLength);

	Result := sPassword; // output of function (password)

end;

// handles serial key generation
procedure TfrmKeyGeneration.btnGenerateKeyClick(Sender: TObject);
var
	sSerialKey, sCustomText: String;
	iKeyLength, iDelimiterPosition, i: Integer;
begin
	if cboKeyType.ItemIndex > -1 then
	begin // <- if selected key type (-1 is not selected)
		if Length(edtKeyLength.Text) > 0 then
		begin // <- if key length is greater than 0; if not, return error.
			Try
				iKeyLength := StrToInt(edtKeyLength.Text);
				// alternative: if TryStrToInt(edtKeyLength.Text, iKeyLength)
			Except
				ShowMessage('"' + edtKeyLength.Text + '" is an invalid key length');
				Exit;
			End;

			case cboKeyType.ItemIndex of
				0: // Numbers (0-9)
					begin
						for i := 1 to iKeyLength do
						begin
							sSerialKey := sSerialKey + IntToStr(random(10));
						end;
					end;
				1: // Uppercase (A-Z)
					begin
						for i := 1 to iKeyLength do
						begin
							sSerialKey := sSerialKey + GenerateRandomLetter(true);
						end;
					end;
				2: // Lowercase (a-z)
					begin
						for i := 1 to iKeyLength do
						begin
							sSerialKey := sSerialKey + GenerateRandomLetter(false);
						end;
					end;
				3: // Uppercase (A-Z) + Numbers (0-9)
					begin
						for i := 1 to iKeyLength do
						begin
							if random(2) = 1 then
								sSerialKey := sSerialKey + IntToStr(random(10))
							else
								sSerialKey := sSerialKey + GenerateRandomLetter(true);
						end;
					end;
				4: // Lowercase (a-z) + Numbers (0-9)
					begin
						for i := 1 to iKeyLength do
						begin
							if random(2) = 1 then
								sSerialKey := sSerialKey + IntToStr(random(10))
							else
								sSerialKey := sSerialKey + GenerateRandomLetter(false);
						end;
					end;
				5: // Uppercase (A-Z) + Lowercase (a-z) +  Numbers (0-9)
					begin
						for i := 1 to iKeyLength do
						begin
							if random(2) = 1 then
								sSerialKey := sSerialKey + IntToStr(random(10))
							else if random(2) = 1 then
								sSerialKey := sSerialKey + GenerateRandomLetter(true)
							else
								sSerialKey := sSerialKey + GenerateRandomLetter(false);
						end;
					end;
				6: // Custom
					begin
						sCustomText := edtCustomText.Text;
						if Length(sCustomText) > 0 then
							for i := 1 to iKeyLength do
								sSerialKey := sSerialKey + sCustomText
									[random(Length(sCustomText)) + 1]
						else
						begin
							ShowMessage('The Custom Text field cannot be empty.');
							// feedback
							Exit;
						end;
					end;
			end;

			if cboDelimiter.Checked then
			// if delimiter selected, check if its valid.
			begin
				Try
					iDelimiterPosition := StrToInt(edtDelimiterLocation.Text);
				Except
					ShowMessage('"' + edtDelimiterLocation.Text +
						'" is an invalid delimiter location.');
					Exit;
				end;

				if iDelimiterPosition > 0 then
				begin
					i := 1;
					repeat
						// formula for inserting delimiter appropriately
						Insert(edtDelimiter.Text, sSerialKey, (i * iDelimiterPosition));
						iKeyLength := iKeyLength + 1;
						i := i + 1;
					until ((i * iDelimiterPosition) > iKeyLength);
				end
				else
				begin
					ShowMessage('Delimiter Location must be greater than 0.');
					// feedback
					Exit;
				end;
			end;

			memSerials.Lines.Add(sSerialKey); // add key to memobox

		end
		else
		begin
			ShowMessage('The serial key length must be greater than 0.'); // feedback
			Exit;
		end;
	end
	else
	begin
		ShowMessage
			('You must select a serial key type! Select one from the dropdown box.');
		// feedback
		Exit;
	end;

end;

procedure TfrmKeyGeneration.cboDelimiterClick(Sender: TObject);
begin
	if cboDelimiter.Checked then
	// if delimiter checked, enable edit box, else disable.
	begin
		edtDelimiter.Enabled := true;
		edtDelimiterLocation.Enabled := true;
	end
	else
	begin
		edtDelimiter.Enabled := false;
		edtDelimiterLocation.Enabled := false;
	end;

end;

procedure TfrmKeyGeneration.cboKeyTypeChange(Sender: TObject);
begin
	if cboKeyType.Text = 'Custom' then
		// if custom key type, enable edit box, else disbale.
		edtCustomText.Enabled := true
	else
		edtCustomText.Enabled := false;

end;

// handle proper application closing
procedure TfrmKeyGeneration.FormClose(Sender: TObject;
	var Action: TCloseAction);
begin
	Application.Terminate;
end;

// clear memo box
procedure TfrmKeyGeneration.btnClearMemoClick(Sender: TObject);
begin
	memSerials.Lines.Clear;
end;

// copy to clipboard (using ClipBrd delphi unit)
procedure TfrmKeyGeneration.btnCopyClick(Sender: TObject);
begin
	Clipboard.AsText := memSerials.Lines.DelimitedText;
	// .DelimitedText to delimit each serial key using ','
end;

procedure TfrmKeyGeneration.btnGeneratePasswordClick(Sender: TObject);
var
	bIsUppercase, bIsLowercase, bIsNumeric, bIsSpecial: Boolean;
begin
	// declare type(s) of password
	if chklstPasswordType.Checked[0] then // if uppercase checked
		bIsUppercase := true
	else
		bIsUppercase := false;
	if chklstPasswordType.Checked[1] then // if lowercase checked
		bIsLowercase := true
	else
		bIsLowercase := false;
	if chklstPasswordType.Checked[2] then // if numbers checked
		bIsNumeric := true
	else
		bIsNumeric := false;
	if chklstPasswordType.Checked[3] then // if special chars checked
		bIsSpecial := true
	else
		bIsSpecial := false;

	// ensure password meets requirements, else exit procedure.
	if not bIsUppercase and not bIsLowercase and not bIsNumeric and not bIsSpecial
	then
	begin
		ShowMessage('You must select a password type.');
		Exit;
	end
	else if (ledtPasswordLength.Text = '') or
		(StrToInt(ledtPasswordLength.Text) < 5) then
	begin
		ShowMessage('The password length cannot be less than 5.');
		Exit;
	end;

	ledtPassword.Text := GeneratePassword(bIsUppercase, bIsLowercase, bIsNumeric,
		bIsSpecial, StrToInt(ledtPasswordLength.Text));
	// stores result of generatepassword function in the edit box (calls function)
end;

end.
