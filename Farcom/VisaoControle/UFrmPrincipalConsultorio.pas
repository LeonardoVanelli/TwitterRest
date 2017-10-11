unit UFrmPrincipalConsultorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls
  ,  UfrmCadastroPrescricao
  ,  UFrmCadastroCliente
  ,  ULoginUsuario
  ,  UDialogo
  ,  UFrmCRUD
  ,  Buttons, ComCtrls, ExtCtrls, pngimage, jpeg;

type
  TfrmPrincipalConsultorio = class(TForm)
    Panel1: TPanel;
    btnCadastroCliente: TLabel;
    lblPrescricao: TLabel;
    lblSair: TLabel;
    Image2: TImage;
    imgLogo: TImage;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Image1: TImage;
    lblFuncaoMedico: TLabel;
    lblNomeMedico: TLabel;
    Label2: TLabel;
    procedure BitBtn4Click(Sender: TObject);
    procedure lblPrescricaoClick(Sender: TObject);
    procedure lblPrescricaoMouseLeave(Sender: TObject);
    procedure lblPrescricaoMouseEnter(Sender: TObject);
    procedure btnCadastroClienteMouseEnter(Sender: TObject);
    procedure btnCadastroClienteMouseLeave(Sender: TObject);
    procedure lblSairClick(Sender: TObject);
    procedure lblSairMouseEnter(Sender: TObject);
    procedure lblSairMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure btnCadastroClienteClick(Sender: TObject);
  public
    destructor Destroy; override;

  end;

var
  frmPrincipalConsultorio: TfrmPrincipalConsultorio;

implementation

{$R *.dfm}

procedure TfrmPrincipalConsultorio.BitBtn4Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroPrescricao, FrmCadastroPrescricao);
end;

procedure TfrmPrincipalConsultorio.btnCadastroClienteClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
end;

procedure TfrmPrincipalConsultorio.btnCadastroClienteMouseEnter(
  Sender: TObject);
begin
  btnCadastroCliente.Color := $00718936;
end;

procedure TfrmPrincipalConsultorio.btnCadastroClienteMouseLeave(
  Sender: TObject);
begin
  btnCadastroCliente.Color := $00809C3D;
end;

destructor TfrmPrincipalConsultorio.Destroy;
begin
  inherited;
end;

procedure TfrmPrincipalConsultorio.FormShow(Sender: TObject);
begin
  imgLogo.left := trunc((frmPrincipalConsultorio.width - imgLogo.width) / 2)+30;
  imgLogo.top := trunc((frmPrincipalConsultorio.height - imgLogo.height) / 2);
  lblNomeMedico.Caption :=  TLoginUsuario.FuncionarioAtual.NOME;
end;

procedure TfrmPrincipalConsultorio.Label2MouseEnter(Sender: TObject);
begin
  Label2.Color := $00718936;
end;

procedure TfrmPrincipalConsultorio.Label2MouseLeave(Sender: TObject);
begin
  Label2.Color := $00809C3D;
end;

procedure TfrmPrincipalConsultorio.lblSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipalConsultorio.lblSairMouseEnter(Sender: TObject);
begin
  lblSair.Color := $00718936;
end;

procedure TfrmPrincipalConsultorio.lblSairMouseLeave(Sender: TObject);
begin
  lblSair.Color := $00809C3D;
end;

procedure TfrmPrincipalConsultorio.lblPrescricaoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroPrescricao, FrmCadastroPrescricao);
end;

procedure TfrmPrincipalConsultorio.lblPrescricaoMouseEnter(Sender: TObject);
begin
  lblPrescricao.Color := $00718936;
end;

procedure TfrmPrincipalConsultorio.lblPrescricaoMouseLeave(Sender: TObject);
begin
  lblPrescricao.Color := $00809C3D;
end;

end.
