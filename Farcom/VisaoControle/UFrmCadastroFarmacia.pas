unit UFrmCadastroFarmacia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmCRUD, Menus, StdCtrls, pngimage, ExtCtrls, Mask
  , UFarmacia
  , Umunicipio
  , URegraCRUDFarmacia
  , URepositorioMunicipioJSON
  , UUtilitarios
  , UEntidade;

type
  TFrmCadastroFarmacia = class(TFrmCRUD)
    aaa: TLabel;
    edEmail: TLabeledEdit;
    edNTelefone: TMaskEdit;
    edNome: TLabeledEdit;
    edCnpj: TMaskEdit;
    Label1: TLabel;
    gbEndereco: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cbEstado: TComboBox;
    cbMunicipio: TComboBox;
    edBairro: TLabeledEdit;
    edRua: TLabeledEdit;
    edNumero: TLabeledEdit;
    edCep: TLabeledEdit;
    edComplemento: TLabeledEdit;
    edHoraAbertura: TMaskEdit;
    edHoraFechamento: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    procedure Image1Click(Sender: TObject);
    procedure cbEstadoChange(Sender: TObject);
    procedure cbMunicipioExit(Sender: TObject);
  protected
    FFARMACIA: TFARMACIA;
    FMUNICIPIO: TMunicipio;

    FRegraCRUDFarmacia: TRegraCRUDFarmacia;
    FRepositorioMunicipio: TRepositorioMunicipioJSON;

    procedure Inicializa; override;
    procedure Finaliza; override;
    procedure PreencheEntidade; override;
    procedure PreencheFormulario; override;
    procedure PosicionaCursorPrimeiroCampo; override;
    procedure HabilitaCampos(const ceTipoOperacaoUsuario: TTipoOperacaoUsuario); override;
  end;

var
  FrmCadastroFarmacia: TFrmCadastroFarmacia;

implementation

uses
  UOpcaoPesquisa;

{$R *.dfm}

procedure TFrmCadastroFarmacia.cbEstadoChange(Sender: TObject);
begin
  inherited;
  cbMunicipio.Items.Text := PreencheComInfromacoesEstadoMunicipio(False, cbEstado.Text).Text;
end;

procedure TFrmCadastroFarmacia.cbMunicipioExit(Sender: TObject);
begin
  inherited;
  //FFARMACIA.MUNICIPIO := FRepositorioMunicipio.RetornaPorUFEstadoNomeMunicipio(cbEstado.Text, cbMunicipio.Text);
end;

procedure TFrmCadastroFarmacia.Finaliza;
begin
  inherited;
  FreeAndNil(FRepositorioMunicipio);
end;

procedure TFrmCadastroFarmacia.HabilitaCampos(
  const ceTipoOperacaoUsuario: TTipoOperacaoUsuario);
begin
  inherited;
  gbInformacoes.Enabled := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  gbEndereco.Enabled    := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
end;

procedure TFrmCadastroFarmacia.Image1Click(Sender: TObject);
begin
  inherited;
  if gbEndereco.Left = 121 then
    begin
      gbEndereco.Left     := 30;
      gbEndereco.Width    := gbEndereco.Width   +90;
      gbInformacoes.Width := gbInformacoes.Width+90;
    end
  else
    begin
      gbEndereco.Left     := 121;
      gbEndereco.Width    := gbEndereco.Width   -90;
      gbInformacoes.Width := gbInformacoes.Width-90;
    end;
end;

procedure TFrmCadastroFarmacia.Inicializa;
begin
  inherited;
  DefineEntidade(@FFarmacia, TFarmacia);
  DefineRegraCRUD(@FRegraCRUDFarmacia, TRegraCRUDFarmacia);

  AdicionaOpcaoPesquisa(TOpcaoPesquisa.Create
    .DefineVisao(TBL_FARMACIA)
    .DefineNomeCampoRetorno(FLD_ENTIDADE_ID)
    .AdicionaFiltro(FLD_MUNICIPIO_NOME)
    .DefineNomePesquisa(STR_MUNICIPIO));

  //cbEstado.Items.Text := PreencheComInfromacoesEstadoMunicipio(True, 'SC').Text;

  FRepositorioMunicipio := TRepositorioMunicipioJSON.Create;
end;

procedure TFrmCadastroFarmacia.PosicionaCursorPrimeiroCampo;
begin
  inherited;
  ednome.SetFocus;
end;

procedure TFrmCadastroFarmacia.PreencheEntidade;
begin
  inherited;
  FFARMACIA.NOME            := edNome.Text;
  FFARMACIA.CNPJ            := edCnpj.Text;
  FFARMACIA.EMAIL           := edEmail.Text;
  FFARMACIA.TELEFONE        := edNTelefone.Text;
  FFARMACIA.HORA_ABERTURA   := StrToTime(edHoraAbertura.Text);
  FFARMACIA.HORA_FECHAMENTO := StrToTime(edHoraFechamento.Text);

  FFARMACIA.CEP             := edCep.Text;
  FFARMACIA.BAIRRO          := edBairro.Text;
  FFARMACIA.ENDERECO        := edRua.Text;
  FFARMACIA.COMPLEMENTO     := edComplemento.Text;
  FFARMACIA.TELEFONE        := edNumero.Text;


end;

procedure TFrmCadastroFarmacia.PreencheFormulario;
begin
  inherited;
  edNome.Text                := FFARMACIA.NOME;
  edCnpj.Text                := FFARMACIA.CNPJ;
  edEmail.Text               := FFARMACIA.EMAIL;
  edNTelefone.Text           := FFARMACIA.TELEFONE;
  edHoraAbertura.Text        := TimeToStr(FFARMACIA.HORA_ABERTURA);
  edHoraFechamento.Text      := TimeToStr(FFARMACIA.HORA_FECHAMENTO);

  edCep.Text                 := FFARMACIA.CEP;
  edBairro.Text              := FFARMACIA.BAIRRO;
  edRua.Text                 := FFARMACIA.ENDERECO;
  edComplemento.Text         := FFARMACIA.COMPLEMENTO;
  edNumero.Text              := FFARMACIA.TELEFONE;
end;

end.
