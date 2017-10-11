unit UFrmCadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmCRUD, Menus, pngimage, ExtCtrls, StdCtrls, Mask, ComCtrls
  , UCliente
  , UMunicipio
  , URegraCRUDClienteJSON
  , URepositorioMunicipioJSON
  , URepositorio
  , UEntidade
  , UUtilitarios;

type
  TFrmCadastroCliente = class(TFrmCRUD)
    Label5: TLabel;
    CPF: TLabel;
    lblRg: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    edNome: TLabeledEdit;
    edEmail: TLabeledEdit;
    dtpDataNascimento: TDateTimePicker;
    edNCelular: TMaskEdit;
    edNResidencial: TMaskEdit;
    edCpf: TMaskEdit;
    edRg: TMaskEdit;
    edDataEmissao: TDateTimePicker;
    edOrgaoEmissor: TLabeledEdit;
    Image2: TImage;
    gbEndereco: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbEstado: TComboBox;
    cbMunicipio: TComboBox;
    edBairro: TLabeledEdit;
    edRua: TLabeledEdit;
    edNumero: TLabeledEdit;
    edCep: TLabeledEdit;
    edComplemento: TLabeledEdit;
    procedure Image1Click(Sender: TObject);
    procedure cbEstadoExit(Sender: TObject);
    procedure cbMunicipioExit(Sender: TObject);
  protected
    FCLIENTE: TCliente;
    FMUNICIPIO: TMunicipio;

    FRegraCRUDCliente: TRegraCRUDClienteJSON;
    FRepositorioMunicipio: TRepositorioMunicipioJSON;

    procedure Inicializa; override;
    procedure Finaliza; override;
    procedure PreencheEntidade; override;
    procedure PreencheFormulario; override;
    procedure PosicionaCursorPrimeiroCampo; override;
    procedure HabilitaCampos(const ceTipoOperacaoUsuario: TTipoOperacaoUsuario); override;
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

uses
  UOpcaoPesquisa;

{$R *.dfm}

procedure TFrmCadastroCliente.cbEstadoExit(Sender: TObject);
begin
  inherited;
  //cbMunicipio.Items.Text := PreencheComInfromacoesEstadoMunicipio(False, cbEstado.Text).Text;
end;

procedure TFrmCadastroCliente.cbMunicipioExit(Sender: TObject);
begin
  inherited;
//  FCLIENTE.MUNICIPIO := FRepositorioMunicipio.RetornaPorUFEstadoNomeMunicipio(cbEstado.Text, cbMunicipio.Text);
end;

procedure TFrmCadastroCliente.Finaliza;
begin
  inherited;
  FreeAndNil(FRepositorioMunicipio);
end;

procedure TFrmCadastroCliente.HabilitaCampos(
  const ceTipoOperacaoUsuario: TTipoOperacaoUsuario);
begin
  inherited;
  gbInformacoes.Enabled := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  gbEndereco.Enabled    := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
end;

procedure TFrmCadastroCliente.Image1Click(Sender: TObject);
begin
  inherited;
  if gbEndereco.Left = 120 then
    begin
      gbEndereco.Left     := 30;
      gbEndereco.Width    := gbEndereco.Width +90;
      gbInformacoes.Width := gbInformacoes.Width +90;
    end
  else
    begin
      gbEndereco.Left     := 120;
      gbEndereco.Width    := gbEndereco.Width -90;
      gbInformacoes.Width := gbInformacoes.Width -90 ;
    end;
end;

procedure TFrmCadastroCliente.Inicializa;
begin
  inherited;
  DefineEntidade(@FCLIENTE, TCLIENTE);
  DefineRegraCRUD(@FRegraCRUDCliente, TRegraCRUDClienteJSON);

  AdicionaOpcaoPesquisa(TOpcaoPesquisa.Create
    .DefineVisao(TBL_CLIENTE)
    .DefineNomeCampoRetorno(FLD_ENTIDADE_ID)
    .AdicionaFiltro(fld_cliente_nome)
    .DefineNomePesquisa(STR_CLIENTE));

  //cbEstado.Items.Text := PreencheComInfromacoesEstadoMunicipio(True, 'SC').Text;

  FRepositorioMunicipio := TRepositorioMunicipioJSON.Create;
end;

procedure TFrmCadastroCliente.PosicionaCursorPrimeiroCampo;
begin
  inherited;
  ednome.SetFocus;
end;

procedure TFrmCadastroCliente.PreencheEntidade;
begin
  inherited;
  FCLIENTE.CPF               := edCpf.Text;
  FCLIENTE.NOME              := edNOME.Text;
  FCLIENTE.DATA_NASCIMENTO   := dtpDataNascimento.DateTime;
  FCLIENTE.EMAIL             := edEmail.Text;
  FCLIENTE.TELEFONE          := edNResidencial.Text;
  FCLIENTE.CELULAR           := edNCelular.Text;
  FCLIENTE.RG                := edRg.Text;
  FCLIENTE.RG_ORGAO_EMISSOR  := edOrgaoEmissor.Text;
  FCLIENTE.RG_DATA_EMISSAO   := edDataEmissao.DateTime;
  FCLIENTE.CEP               := edCep.Text;
  FCLIENTE.BAIRRO            := edBairro.Text;
  FCLIENTE.ENDERECO          := edRua.Text;
  FCLIENTE.COMPLEMENTO       := edComplemento.Text;
  FCLIENTE.NUMERO            := StrToIntDef(edNumero.Text, 0);
  //Teste
  FCLIENTE.MUNICIPIO    := TMUNICIPIO.Create;
  FCLIENTE.MUNICIPIO.ID := 42;
end;

procedure TFrmCadastroCliente.PreencheFormulario;
begin
  inherited;
  edCpf.Text                 := FCLIENTE.CPF;
  edNome.Text                := FCLIENTE.NOME;
  dtpDataNascimento.DateTime := FCLIENTE.DATA_NASCIMENTO;
  edEmail.Text               := FCLIENTE.EMAIL;
  edNResidencial.Text        := IntToStr(FCLIENTE.NUMERO);
  edNCelular.Text            := FCLIENTE.CELULAR;
  edRg.Text                  := FCLIENTE.RG;
  edOrgaoEmissor.Text        := FCLIENTE.RG_ORGAO_EMISSOR;
  edDataEmissao.DateTime     := FCLIENTE.RG_DATA_EMISSAO;
  edCep.Text                 := FCLIENTE.CEP;
  edBairro.Text              := FCLIENTE.BAIRRO;
  edRua.Text                 := FCLIENTE.ENDERECO;
  edComplemento.Text         := FCLIENTE.COMPLEMENTO;
  edNumero.Text              := IntToStr(FCLIENTE.NUMERO);
end;

end.
