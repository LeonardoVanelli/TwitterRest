unit UFrmCadastroPrescricao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmCRUD, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls
  , UEntidade
  , UUtilitarios
  , UPrescricao
  , UFuncionario
  , UCliente
  , UProduto
  , ULoginUsuario
  , URepositorioFuncionarioJSON
  , URepositorioClienteJSON
  , URepositorioMedicamentoJSON
  , URegraCRUDPrescricaoJSON, Grids, DBGrids, pngimage
   {,Udm};

type
  TFrmCadastroPrescricao = class(TFrmCRUD)
    lvMedicamentos: TListView;
    pnlMedicamento: TPanel;
    Label2: TLabel;
    Vencimento: TLabel;
    edMedicamento: TEdit;
    btnLocalizarMedicamento: TButton;
    stDescricaoMedicamento: TStaticText;
    mmInstrucaoDosagem: TMemo;
    btnAdicionar: TButton;
    btnRemover: TButton;
    dtpVencimento: TDateTimePicker;
    stApresentacao: TStaticText;
    Label1: TLabel;
    Label3: TLabel;
    stNomeMedico: TStaticText;
    RadioGroup1: TRadioGroup;
    edPaciente: TEdit;
    btnLocalizarPaciente: TButton;
    stNomeDoPaciente: TStaticText;
    Label4: TLabel;
    imgCancelar: TLabel;
    imgFinalizar2: TLabel;
    imgFinalizar: TImage;
    procedure edMedicamentoExit(Sender: TObject);
    procedure edPacienteExit(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure imgFinalizarClick(Sender: TObject);
  protected
    FPRESCRICAO: TPrescricao;
    FFUNCIONARIO: TFuncionario;
    FCLIENTE: TCliente;
    FMEDICAMENTO: TMedicamento;
    FRepositorioFuncionario: TRepositorioFuncionarioJSON;
    FRepositorioCliente    : TRepositorioClienteJSON;
    FRepositorioMedicamentoJSON: TRepositorioMedicamentoJSON;
    FRegraCRUDPrescricao: TRegraCRUDPrescricaoJSON;
    FPacienteAtual: Integer;

    procedure Inicializa; override;
    procedure Finaliza; override;
    procedure PreencheEntidade; override;
    procedure PreencheFormulario; override;
    procedure HabilitaCampos(const ceTipoOperacaoUsuario: TTipoOperacaoUsuario); override;
    procedure PosicionaCursorPrimeiroCampo; override;
    procedure LimpaCampos; override;
  end;

var
  FrmCadastroPrescricao: TFrmCadastroPrescricao;

implementation

uses
    UOpcaoPesquisa
  , UFrmPesquisa
  , UDialogo
  , UMunicipio
  ;

{$R *.dfm}

{ TFrmCadastroPrescricao }

procedure TFrmCadastroPrescricao.btnAdicionarClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  inherited;
  ListItem         := lvMedicamentos.Items.Add;
  ListItem.Caption := FPRESCRICAO.MEDICAMENTO.NOME;
  ListItem.SubItems.Add(FPRESCRICAO.MEDICAMENTO.APRESENTACAO);
  ListItem.SubItems.Add(mmInstrucaoDosagem.Text);
    //Saber se a receita tem vencimento
  if DateToStr(dtpVencimento.Date) <> DateToStr(now) then
    ListItem.SubItems.Add(DateToStr(dtpVencimento.Date))
  else
    ListItem.SubItems.Add('Sem Vencimento');
end;

procedure TFrmCadastroPrescricao.btnGravarClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem         := lvMedicamentos.Items.Add;
  ListItem.Caption := FPRESCRICAO.MEDICAMENTO.NOME;
  ListItem.SubItems.Add(FPRESCRICAO.MEDICAMENTO.APRESENTACAO);
  ListItem.SubItems.Add(mmInstrucaoDosagem.Text);
    //Saber se a receita tem vencimento
  if DateToStr(dtpVencimento.Date) <> DateToStr(now) then
    ListItem.SubItems.Add(DateToStr(dtpVencimento.Date))
  else
    ListItem.SubItems.Add('Sem Vencimento');

  inherited;
  LimpaCampos;
  btnNovoClick(Sender);
  HabilitaCampos(touInsercao);

  stNomeMedico.Caption := TLoginUsuario.FuncionarioAtual.NOME;
  edPaciente.Text := IntToStr(FPacienteAtual);
  edPaciente.OnExit(Sender);

  gbInformacoes.Enabled := false;
  edMedicamento.SetFocus;
end;

procedure TFrmCadastroPrescricao.btnLimparClick(Sender: TObject);
begin
  LimpaCampos;
  lvMedicamentos.Items.Clear;
  stNomeMedico.Caption := TLoginUsuario.FuncionarioAtual.NOME;
end;

procedure TFrmCadastroPrescricao.btnRemoverClick(Sender: TObject);
begin
  inherited;
  mmInstrucaoDosagem.Text := EmptyStr;
  dtpVencimento.Date := now;
  edMedicamento.Text := EmptyStr;
  stDescricaoMedicamento.Caption := EmptyStr;
  stApresentacao.Caption := EmptyStr;
  edMedicamento.SetFocus;
  stNomeMedico.Caption := UsuarioLogado.NOME;
end;

procedure TFrmCadastroPrescricao.edMedicamentoExit(Sender: TObject);
begin
    FPRESCRICAO.MEDICAMENTO := TMEDICAMENTO.Create;
  if (edMedicamento.Text <> EmptyStr) Then
    begin
      if StrToInt(edMedicamento.Text) < 26051 then
        begin
          try
            FPRESCRICAO.MEDICAMENTO := FRepositorioMedicamentoJSON.RetornaPeloID(StrToInt(edMedicamento.Text));
            if FPRESCRICAO.MEDICAMENTO = nil then
              raise EValidacaoNegocio.Create('Medicamento com codigo '+ edPaciente.Text+ ' não encontrado')
            else
              begin
                stDescricaoMedicamento.Caption := FPRESCRICAO.MEDICAMENTO.NOME;
                stApresentacao.Caption := FPRESCRICAO.MEDICAMENTO.APRESENTACAO;
              end;
          except
            on E: Exception do
              begin
                TDialogo.Excecao(E);
                edMedicamento.SetFocus;
              end;
          end;
        end
        else
          begin
            ShowMessage('Produto com id: '+ edMedicamento.Text+ ' não encontrado');
            edMedicamento.Text := EmptyStr;
            edMedicamento.SetFocus;
          end;
    end;
end;

procedure TFrmCadastroPrescricao.edPacienteExit(Sender: TObject);
begin
  stNomeDoPaciente.Caption := EmptyStr;

  if Trim(edPaciente.Text) <> EmptyStr Then
    try
      FPRESCRICAO.CLIENTE := FRepositorioCliente.RetornaPeloID(StrToInt(edPaciente.Text));
      if FPRESCRICAO.CLIENTE = nil then
        raise EValidacaoNegocio.Create('Paciente com codigo '+ edPaciente.Text+ ' não encontrado')
      else
        begin
          FPacienteAtual := FPRESCRICAO.CLIENTE.ID;
          stNomeDoPaciente.Caption := FPRESCRICAO.CLIENTE.NOME;
        end;
    except
      on E: Exception do
        begin
           TDialogo.Excecao(E);
          edPaciente.SetFocus;
        end
  end;
end;

procedure TFrmCadastroPrescricao.Finaliza;
begin
  inherited;
end;

procedure TFrmCadastroPrescricao.HabilitaCampos(
  const ceTipoOperacaoUsuario: TTipoOperacaoUsuario);
begin
  inherited;
  pnlMedicamento.Enabled := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  gbInformacoes.Enabled  := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  imgFinalizar.Enabled   := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  imgFinalizar2.Enabled   := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  btnLimpar.Enabled   := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  imgLimpar.Enabled   := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  imgCancelar.Enabled   := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
end;

procedure TFrmCadastroPrescricao.imgFinalizarClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Prescrição Finalizada');
  HabilitaCampos(touIndefinida);
  lvMedicamentos.Items.Clear;
  LimpaCampos;
  stNomeMedico.Caption := TLoginUsuario.FuncionarioAtual.NOME;
end;

procedure TFrmCadastroPrescricao.Inicializa;
begin
  inherited;
  DefineEntidade(@FPRESCRICAO, TPRESCRICAO);
  DefineRegraCRUD(@FRegraCRUDPrescricao, TRegraCRUDPrescricaoJSON);

  AdicionaOpcaoPesquisa(TOpcaoPesquisa.Create
    .DefineVisao(TBL_PRESCRICAO)
    .DefineNomeCampoRetorno(FLD_ENTIDADE_ID)
    .AdicionaFiltro(FLD_PRESCRICAO_COD_CLIENTE)
    .DefineNomePesquisa(STR_PRESCRICAO));

  FRegraCRUDPrescricao := TRegraCRUDPrescricaoJSON.Create;

  FRepositorioFuncionario     :=  TRepositorioFuncionarioJSON.Create;
  FRepositorioCliente         := TRepositorioClienteJSON.Create;
  FRepositorioMedicamentoJSON := TRepositorioMedicamentoJSON.Create;

  stNomeMedico.Caption := TLoginUsuario.FuncionarioAtual.NOME;
end;

procedure TFrmCadastroPrescricao.Label2Click(Sender: TObject);
begin
  Inherited;
  LimpaCampos;
  edPaciente.Text := EmptyStr;
  stNomeDoPaciente.Caption := EmptyStr;
end;

procedure TFrmCadastroPrescricao.LimpaCampos;
begin
  Inherited;
  edMedicamento.Text := EmptyStr;
  stDescricaoMedicamento.Caption := EmptyStr;
  stApresentacao.Caption := EmptyStr;
  mmInstrucaoDosagem.Text := EmptyStr;
  dtpVencimento.Date := now;
end;

procedure TFrmCadastroPrescricao.PosicionaCursorPrimeiroCampo;
begin
  inherited;
  edPaciente.SetFocus;
end;

procedure TFrmCadastroPrescricao.PreencheEntidade;
begin
  FPRESCRICAO.FUNCIONARIO          := TFUNCIONARIO.Create();
  FPRESCRICAO.FUNCIONARIO          := UsuarioLogado;
  FPRESCRICAO.DESCRICAO            := mmInstrucaoDosagem.Text;
  FPRESCRICAO.DATA_HORA_PRESCRITA  := (NOW);
  FPRESCRICAO.DATA_HORA_VENCIMENTO := dtpVencimento.Date;

//  FPRESCRICAO.CLIENTE := TCLIENTE.Create();
//  FPRESCRICAO.CLIENTE.ID := 1;
//  FPRESCRICAO.CLIENTE.NOME := 'Iris Maria';
//  FPRESCRICAO.CLIENTE.CPF := '12345';
//  FPRESCRICAO.CLIENTE.RG              := '123456'     ;
//  FPRESCRICAO.CLIENTE.RG_DATA_EMISSAO := strToDate('07/07/2017');
//  FPRESCRICAO.CLIENTE.RG_ORGAO_EMISSOR := 'SSP';
//  FPRESCRICAO.CLIENTE.DATA_NASCIMENTO := strToDate('07/07/2017');
//  FPRESCRICAO.CLIENTE.ENDERECO        := 'teste';
//  FPRESCRICAO.CLIENTE.COMPLEMENTO     := 'teste';
//  FPRESCRICAO.CLIENTE.NUMERO          :=  1;
//  FPRESCRICAO.CLIENTE.BAIRRO          := 'teste';
//  FPRESCRICAO.CLIENTE.CEP             := '12345';
//  FPRESCRICAO.CLIENTE.MUNICIPIO := TMUNICIPIO.Create;
//  FPRESCRICAO.CLIENTE.MUNICIPIO.NOME := 'Blumenau';
//  FPRESCRICAO.CLIENTE.MUNICIPIO.UF := 'SC';
//
//  FPRESCRICAO.CLIENTE.EMAIL           := 'teste';
//  FPRESCRICAO.CLIENTE.TELEFONE        := '478956641';
//  FPRESCRICAO.CLIENTE.CELULAR         := '748454665';
end;

procedure TFrmCadastroPrescricao.PreencheFormulario;
var
  ListItem: TListItem;
begin
  inherited;
  //Insert list view
  lvMedicamentos.Items.Clear;
  ListItem         := lvMedicamentos.Items.Add;
  ListItem.Caption := FPRESCRICAO.MEDICAMENTO.NOME;
  ListItem.SubItems.Add(FPRESCRICAO.MEDICAMENTO.APRESENTACAO);
  ListItem.SubItems.Add(FPRESCRICAO.DESCRICAO);
  //Insert stPesquisa
  edPaciente.Text := IntToStr(FPRESCRICAO.CLIENTE.ID);
  stNomeDoPaciente.Caption := FPRESCRICAO.CLIENTE.NOME;
  //Saber se a receita tem vencimento
  if Copy(DateTimeToStr(FPRESCRICAO.DATA_HORA_PRESCRITA),1, 10) <> DateToStr(FPRESCRICAO.DATA_HORA_VENCIMENTO) then
    ListItem.SubItems.Add(DateToStr(FPRESCRICAO.DATA_HORA_VENCIMENTO))
  else
    ListItem.SubItems.Add('Nil');
end;

end.
