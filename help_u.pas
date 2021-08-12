unit help_u;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw;

type
	TfrmHelpWebsite = class(TForm)
		WebBrowserHelp: TWebBrowser;
		btnClose: TButton;
		procedure btnCloseClick(Sender: TObject);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;

var
	frmHelpWebsite: TfrmHelpWebsite;

implementation

{$R *.dfm}

procedure TfrmHelpWebsite.btnCloseClick(Sender: TObject);
begin
	Self.Close;
end;

end.
