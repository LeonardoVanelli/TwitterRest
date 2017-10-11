unit UFrmCadastroCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmCRUD, Menus, StdCtrls, pngimage, ExtCtrls
  , UMunicipio
  , UCompra
  , URegraCRUDCompraJSON
  , URepositorioMunicipioJSON
  , URepositorioMedicamentoJSON
  , URepositorio
  , UEntidade
  , UProduto
  , UUtilitarios, Grids, DBGrids, ComCtrls;

type
  TFrmCadastroCompra = class(TFrmCRUD)
    Label1: TLabel;
    lblNovo: TLabel;
    lblGravar: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edProduto: TEdit;
    btnLocalizarProduto: TButton;
    btnAdicionaCompra: TButton;
    lvProdutos: TListView;
    btnLimparDadosProduto: TButton;
    Label6: TLabel;
    Panel3: TPanel;
    Label7: TLabel;
    lblTotal: TLabel;
    Label8: TLabel;
    lblNomeProduto: TStaticText;
    lblPrecoProduto: TStaticText;
    lblDescricaoProduto: TStaticText;
    Label2: TLabel;
    lblFinalizaCompra1: TLabel;
    lblFinalizaCompra: TLabel;
    btnFinalizaCompra: TImage;
    lblLimpar1: TLabel;
    Button1: TButton;
    Label3: TLabel;
    procedure btnAdicionaCompraClick(Sender: TObject);
    procedure btnLimparDadosProdutoClick(Sender: TObject);
    procedure edProdutoExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure btnLocalizarProdutoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edProdutoChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFinalizaCompraClick(Sender: TObject);
  protected
    FMUNICIPIO: TMunicipio;
    FCOMPRA: TCOMPRA;

    FRegraCRUDCompra: TRegraCRUDCompraJSON;
    FRepositorioMunicipio: TRepositorioMunicipioJSON;
    FRepositorioMedicamento: TRepositorioMedicamentoJSON;

    procedure Inicializa; override;
    procedure Finaliza; override;
    procedure PreencheEntidade; override;
    procedure PreencheFormulario; override;
    procedure PosicionaCursorPrimeiroCampo; override;
    procedure HabilitaCampos(const ceTipoOperacaoUsuario: TTipoOperacaoUsuario); override;
    procedure LimpaCampo;
  public
    QtdProdutos: integer;
    numeroDeEnter: integer;
  private
    procedure carregaMecimanto;
  end;

var
  FrmCadastroCompra: TFrmCadastroCompra;

implementation

uses
    UOpcaoPesquisa
  , UDialogo
  , UFrmPesquisa
  , UTraducaoPesquisa
  , UPrescricao
  ;

{$R *.dfm}

{ TFrmCRUD1 }

procedure TFrmCadastroCompra.btnLocalizarProdutoClick(Sender: TObject);
begin
  inherited;
  edProduto.Text := TfrmPesquisa.MostrarPesquisa(TOpcaoPesquisa.Create
    .DefineVisao(TBL_PRESCRICAO)
    .DefineNomeCampoRetorno('ID_Medicamento')
    .AdicionaFiltro('Nome_Cliente')
    .DefineTradutorPesquisa(TTraducaoPesquisaPrescricao.Create));

  if StrToIntDef(edProduto.Text, 0) <> 0 then
    edProduto.OnExit(Sender);
end;

procedure TFrmCadastroCompra.btnNovoClick(Sender: TObject);
begin
  inherited;
  lvProdutos.Items.Clear;
  btnLimparDadosProduto.Click;
end;

procedure TFrmCadastroCompra.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadastroCompra.Button1Click(Sender: TObject);
begin
  inherited;
  edProduto.Text := TfrmPesquisa.MostrarPesquisa(TOpcaoPesquisa.Create
    .DefineVisao(TBL_PRODUTO)
    .DefineNomeCampoRetorno(FLD_ENTIDADE_ID)
    .AdicionaFiltro(FLD_PRODUTO_NOME)
    {.DefineTraducaoPesquisa(TTraducaoPesquisaPrescricao.Create)});

  if StrToIntDef(edProduto.Text, 0) <> 0 then
    edProduto.OnExit(Sender);
end;

procedure TFrmCadastroCompra.carregaMecimanto;
begin
  FCOMPRA.PRODUTO := TMEDICAMENTO.Create;
  if (edProduto.Text <> EmptyStr) and (StrToInt(edProduto.Text) < 26051) Then
    try
      FCOMPRA.PRODUTO := FRepositorioMedicamento.RetornaPeloID(StrToIntDef(edProduto.Text,0));
      if FCOMPRA.PRODUTO = nil then
        raise EValidacaoNegocio.Create('Medicamento com codigo '+ edProduto.Text+ ' não encontrado')
      else
        begin
          lblNomeProduto.Caption      := FCOMPRA.PRODUTO.NOME;
          lblDescricaoProduto.Caption := FCOMPRA.PRODUTO.APRESENTACAO;
          if FCOMPRA.PRODUTO.PRECOCOMERCIAL <> '0' then
            lblPrecoProduto.Caption   := FCOMPRA.PRODUTO.PRECOCOMERCIAL
          else
            lblPrecoProduto.Caption   := FCOMPRA.PRODUTO.PRECOFAB;
        end;
    except
      on E: Exception do
        begin
          TDialogo.Excecao(E);
          edProduto.SetFocus;
        end
  end;
end;

procedure TFrmCadastroCompra.btnAdicionaCompraClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  inherited;
  if (edProduto.Text <> EmptyStr) and (StrToInt(edProduto.Text) < 26051) then
    begin
      inc(QtdProdutos);
    //Insert list view
      ListItem         := lvProdutos.Items.Add;

      ListItem.Caption := IntToStr(QtdProdutos);
      ListItem.SubItems.Add(lblNomeProduto.Caption);
      ListItem.SubItems.Add(lblDescricaoProduto.Caption);
      ListItem.SubItems.Add(lblPrecoProduto.Caption);

      lblTotal.Caption := FloatToStr(StrToFloat(lblTotal.Caption)+StrToFloat(lblPrecoProduto.Caption));
      btnLimparDadosProduto.Click;
      edProduto.SetFocus;
    end;
end;

procedure TFrmCadastroCompra.btnLimparDadosProdutoClick(Sender: TObject);
begin
  inherited;
  LimpaCampo;
  edProduto.SetFocus;
end;

procedure TFrmCadastroCompra.edProdutoChange(Sender: TObject);
begin
  inherited;
  if numeroDeEnter = 1 then
    begin
      btnLimparDadosProduto.Click;
      numeroDeEnter := 0;
    end;
end;

procedure TFrmCadastroCompra.edProdutoExit(Sender: TObject);
begin
  inherited;
  CarregaMecimanto;
end;

procedure TFrmCadastroCompra.edProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (edProduto.Text <> EmptyStr) then
    begin
      if numeroDeEnter = 0 then
        begin
          carregaMecimanto;
          inc(numeroDeEnter);
        end
      else
        begin
          btnAdicionaCompra.Click;
          numeroDeEnter := 0;
        end;
    end;
end;

procedure TFrmCadastroCompra.Finaliza;
begin
  inherited;

end;

procedure TFrmCadastroCompra.FormShow(Sender: TObject);
begin
  inherited;
  Panel3.BevelInner := bvNone;
  Panel3.BevelOuter := bvNone;
end;

procedure TFrmCadastroCompra.HabilitaCampos(
  const ceTipoOperacaoUsuario: TTipoOperacaoUsuario);
begin
  inherited;
  gbInformacoes.Enabled       := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  lvProdutos.Enabled          := ceTipoOperacaoUsuario in [touInsercao, touAtualizacao];
  lblGravar.Enabled           := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  btnFinalizaCompra.Enabled   := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  lblFinalizaCompra1.Enabled  := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  lblFinalizaCompra.Enabled   := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  imgLimpar.Enabled           := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  btnLimpar.Enabled           := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  lblLimpar1.Enabled          := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  lblNovo.Enabled             := FTipoOperacaoUsuario  in [touIndefinida];
end;

procedure TFrmCadastroCompra.btnFinalizaCompraClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Compra Finalizada');
  HabilitaCampos(touIndefinida);
  lvProdutos.Items.Clear;
  lblTotal.Caption := '0';
  QtdProdutos := 0;
  LimpaCampo;
end;

procedure TFrmCadastroCompra.Inicializa;
begin
  inherited;
  DefineEntidade(@FCOMPRA, TCOMPRA);
  DefineRegraCRUD(@FRegraCRUDCompra, TRegraCRUDCompraJSON);

  AdicionaOpcaoPesquisa(TOpcaoPesquisa.Create
    .DefineVisao(TBL_COMPRA)
    .DefineNomeCampoRetorno(FLD_ENTIDADE_ID)
    .AdicionaFiltro(FLD_COMPRA_COD_PRODUTO)
    .DefineNomePesquisa(STR_COMPRA));

  FRepositorioMunicipio := TRepositorioMunicipioJSON.Create;
  FRepositorioMedicamento := TRepositorioMedicamentoJSON.Create;
end;

procedure TFrmCadastroCompra.Label2Click(Sender: TObject);
begin
  LimpaCampo;
  lvProdutos.Items.Clear;
  QtdProdutos := 0;
  lblTotal.Caption := '0';
end;

procedure TFrmCadastroCompra.LimpaCampo;
begin
  edProduto.Text := EmptyStr;
  lblPrecoProduto.Caption := EmptyStr;
  lblNomeProduto.Caption := EmptyStr;
  lblDescricaoProduto.Caption := EmptyStr;
end;

procedure TFrmCadastroCompra.PosicionaCursorPrimeiroCampo;
begin
  inherited;
  edProduto.SetFocus;
end;

procedure TFrmCadastroCompra.PreencheEntidade;
begin
  inherited;

end;

procedure TFrmCadastroCompra.PreencheFormulario;
begin
  inherited;

end;

end.
