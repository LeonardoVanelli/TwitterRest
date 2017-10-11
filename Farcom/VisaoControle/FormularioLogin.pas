unit FormularioLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons
  , UfrmPrincipalConsultorio
  , UFrmPrincipal, pngimage, jpeg;

type
  TFrmLoginT = class(TForm)
    pnlCabecalho: TPanel;
    pnlBotoes: TPanel;
    lblCabecalho: TLabel;
    Panel1: TPanel;
    edSenha: TLabeledEdit;
    edLogin: TLabeledEdit;
    Image2: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure StaticText1Click(Sender: TObject);
    procedure Entrar;
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StaticText2Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  FrmLoginT: TFrmLoginT;
  UsuarioReferenteFarmacia: boolean;

implementation

{$R *.dfm}

uses
    ULoginUsuario
  , UDialogo
  ;

procedure TFrmLoginT.edSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
      Entrar;
end;

procedure TFrmLoginT.Entrar;
begin
  try
    TLoginUsuario.Unico.ValidaLogin(edLogin.Text, edSenha.Text);
    ModalResult := mrYes;
  except
    on E: Exception do
      TDialogo.Excecao(E);
  end;
end;

procedure TFrmLoginT.StaticText1Click(Sender: TObject);
begin
  Entrar;
end;

procedure TFrmLoginT.StaticText2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  CloseModal;
end;

end.
