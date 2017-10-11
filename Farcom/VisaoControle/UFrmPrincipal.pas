unit UFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus
  , StdCtrls, ComCtrls, ExtCtrls, pngimage, jpeg
  , UFrmCadastroCompra, GIFImg
  , ULoginUsuario
  ;

type
  TFrmPrincipalFarcon = class(TForm)
    pnlBotoes: TPanel;
    btnCadastroCliente: TLabel;
    Image1: TImage;
    btnSair: TLabel;
    lblCompra: TLabel;
    Label1: TLabel;
    lblSair: TLabel;
    imgLogo: TImage;
    GroupBox1: TGroupBox;
    Image2: TImage;
    lblFuncaoMedico: TLabel;
    lblNomeMedico: TLabel;
    Label2: TLabel;
    procedure miSairClick(Sender: TObject);
    procedure awwClick(Sender: TObject);
    procedure btnCadastroClienteClick(Sender: TObject);
    procedure btnCadastroFarmaciaClick(Sender: TObject);
    procedure btnCadastroClienteMouseLeave(Sender: TObject);
    procedure btnSairMouseLeave(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblCompraClick(Sender: TObject);
    procedure lblCompraMouseLeave(Sender: TObject);
    procedure lblCompraMouseEnter(Sender: TObject);
    procedure btnCadastroClienteMouseEnter(Sender: TObject);
    procedure lblSairMouseLeave(Sender: TObject);
    procedure lblSairMouseEnter(Sender: TObject);
    procedure lblSairClick(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
  private
    { Private declaration }
  public
    { Public declarations }
  end;

var
  FrmPrincipalFarcon: TFrmPrincipalFarcon;

implementation

uses
    UfrmCrud
  , UFrmCadastroCliente
  , UFrmCadastroFarmacia
  ;

{$R *.dfm}

procedure TFrmPrincipalFarcon.btnCadastroClienteClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
end;

procedure TFrmPrincipalFarcon.btnCadastroClienteMouseEnter(Sender: TObject);
begin
  btnCadastroCliente.Color := $0070833D;
end;

procedure TFrmPrincipalFarcon.btnCadastroClienteMouseLeave(Sender: TObject);
begin
  btnCadastroCliente.Color := $00809C3D;
end;

procedure TFrmPrincipalFarcon.btnCadastroFarmaciaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroFarmacia, FrmCadastroFarmacia);
end;

procedure TFrmPrincipalFarcon.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPrincipalFarcon.btnSairMouseLeave(Sender: TObject);
begin
  btnSair.Color := $00A87724;
end;

procedure TFrmPrincipalFarcon.FormShow(Sender: TObject);
begin
  {Remover bordas}
  pnlBotoes.BevelInner := bvNone;
  pnlBotoes.BevelOuter := bvNone;

  imgLogo.left := trunc((FrmPrincipalFarcon.width - imgLogo.width) / 2)+30;
  imgLogo.top := trunc((FrmPrincipalFarcon.height - imgLogo.height) / 2);
  lblNomeMedico.Caption :=  TLoginUsuario.FuncionarioAtual.NOME;
end;

procedure TFrmPrincipalFarcon.Label2MouseEnter(Sender: TObject);
begin
  Label2.Color := $0070833D;
end;

procedure TFrmPrincipalFarcon.Label2MouseLeave(Sender: TObject);
begin
  Label2.Color := $00809C3D;
end;

procedure TFrmPrincipalFarcon.lblCompraClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCompra, FrmCadastroCompra);
end;

procedure TFrmPrincipalFarcon.lblCompraMouseEnter(Sender: TObject);
begin
  lblCompra.Color := $0070833D;
end;

procedure TFrmPrincipalFarcon.lblCompraMouseLeave(Sender: TObject);
begin
  lblCompra.Color := $00809C3D;
end;

procedure TFrmPrincipalFarcon.lblSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipalFarcon.lblSairMouseEnter(Sender: TObject);
begin
  lblSair.Color := $0070833D;
end;

procedure TFrmPrincipalFarcon.lblSairMouseLeave(Sender: TObject);
begin
  lblSair.Color := $00809C3D;
end;

procedure TFrmPrincipalFarcon.miSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipalFarcon.awwClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
end;

end.
