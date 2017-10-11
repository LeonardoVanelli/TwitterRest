{
  @author: Felipe Silvino Pereira
  @date: 01/08/2017
  @description: Formulario base para geração de CRUDs utilizando as validações
                que forem fornecedidas por uma classe filha de TRegraCRUD.
}

unit UFrmCRUD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls
  , UUtilitarios
  , URegraCRUD
  , UEntidade
  , UFrmPesquisa
  , UOpcaoPesquisa
  , Generics.Collections, Menus, pngimage
  ;

type
  TEntidadePonteiro  = ^TENTIDADE;
  TRegraCRUDPonteiro = ^TRegraCRUD;

  TFrmCRUD = class(TForm)
    pnlBotoes: TPanel;
    Image1: TImage;
    imgNovo: TImage;
    imgGravar: TImage;
    imgExcluir: TImage;
    imgLimpar: TImage;
    imgOpenLocalizar: TImage;
    btnLocalizar: TLabel;
    btnNovo: TLabel;
    btnGravar: TLabel;
    btnExcluir: TLabel;
    btnLimpar: TLabel;
    pnlRodape: TPanel;
    Label9: TLabel;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    lbCabecalho: TLabel;
    gbInformacoes: TGroupBox;
    pmOpcoes: TPopupMenu;
    gbLocalizar: TGroupBox;
    edCodigo: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure btnOpenLocalizarClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FENTIDADE: TENTIDADE;

    FEntidadeClasse   : TEntidadeClasse;
    FEntidadePonteiro : TEntidadePonteiro;
    FRegraCRUD        : TRegraCRUD;
    FRegraCRUDClasse  : TRegraCRUDClasse;
    FRegraCRUDPonteiro: TRegraCRUDPonteiro;

    procedure DefineEntidadeInterno(const coENTIDADE: TENTIDADE);
    procedure DefineRegraCRUDInterno(const coRegraCRUD: TRegraCRUD);
    procedure InicializaInterno;

  protected
    FTipoOperacaoUsuario: TTipoOperacaoUsuario;
    FListaOpcoesPesquisa: TObjectList<TOpcaoPesquisa>;

    procedure RemoveEntidade; virtual;
    procedure GravaEntidade; virtual;
    procedure HabilitaCampos(const ceTipoOperacaoUsuario: TTipoOperacaoUsuario); virtual;
    procedure Inicializa; virtual;
    procedure Finaliza; virtual;
    procedure LimpaCampos; virtual;
    procedure PreencheEntidade; virtual; abstract;
    procedure PreencheFormulario; virtual; abstract;
    procedure PosicionaCursorPrimeiroCampo; virtual; abstract;
    procedure PesquisaSelecionada(Sender: TObject);
    procedure ExecutaPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa);
    procedure MostraOpcoesPesquisa;
    procedure DefineEntidade(const coEntidadePonteiro: TEntidadePonteiro;
                             const coEntidadeClasse: TEntidadeClasse);
    procedure DefineRegraCRUD(const coRegraCRUDPonteiro: TRegraCRUDPonteiro;
                              const coRegraCRUDClasse: TRegraCRUDClasse);

    function RetornaSelecaoTodos(const csNomeTabelaOuView: String): String;
    function RetornaEntidade(const ciId: Integer): TENTIDADE; virtual;
    function PreencheComInfromacoesEstadoMunicipio(CarregaEstado: boolean;
                                                      NomeEstado: string): TStringList;
  public
    procedure AdicionaOpcaoPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa);
  end;

implementation

{$R *.dfm}

uses
    UMensagens
  , UDialogo
  ;

const
  CNT_SELECIONA_UF = 'select uf from municipio group by uf order by uf';
  CNT_SELECIONA_CIDADE = 'select * from municipio where uf = ''%s'' ';

{ TFrmCRUD }

procedure TFrmCRUD.DefineEntidade(const coEntidadePonteiro: TEntidadePonteiro;
                                  const coEntidadeClasse: TEntidadeClasse);
begin
  FEntidadePonteiro := coEntidadePonteiro;
  FEntidadeClasse   := coEntidadeClasse;
end;

procedure TFrmCRUD.DefineRegraCRUD(const coRegraCRUDPonteiro: TRegraCRUDPonteiro;
                                   const coRegraCRUDClasse: TRegraCRUDClasse);
begin
  FRegraCRUDClasse   := coRegraCRUDClasse;
  FRegraCRUDPonteiro := coRegraCRUDPonteiro;
end;

procedure TFrmCRUD.btnExcluirClick(Sender: TObject);
begin
  if TDialogo.Questiona(STR_ENTIDADE_DESEJA_EXCLUIR, [FRegraCRUD.NOME_ENTIDADE]) then
    begin
      try
        RemoveEntidade;

        TDialogo.Informacao(Format(STR_OPERACAO_COM_SUCESSO
                                 , [FRegraCRUD.NOME_ENTIDADE
                                  , StrToIntDef(edCodigo.Text, 0)
                                  , STR_EXCLUIDO]));
        LimpaCampos;
        HabilitaCampos(touIndefinida);

        edCodigo.SetFocus;
      except
        on E: Exception do
          begin
            TDialogo.Excecao(E);
          end;
      end;
    end;
end;

procedure TFrmCRUD.btnGravarClick(Sender: TObject);
begin
  PreencheEntidade;
  try
    GravaEntidade;
    TDialogo.Informacao(Format(STR_OPERACAO_COM_SUCESSO,
                        [FRegraCRUD.NOME_ENTIDADE
                       , FENTIDADE.id
                       , CNT_TIPO_OPERACAO_USUARIO[FTipoOperacaoUsuario]]));
    LimpaCampos;
    HabilitaCampos(touIndefinida);

    if edCodigo.CanFocus then
      edCodigo.SetFocus;
  except
    on E: Exception Do
      begin
        TDialogo.Excecao(E);
      end;
  end;
end;

procedure TFrmCRUD.btnLimparClick(Sender: TObject);
begin
  LimpaCampos;
  HabilitaCampos(touIndefinida);

  edCodigo.SetFocus;
end;

procedure TFrmCRUD.btnLocalizarClick(Sender: TObject);
begin
  if FListaOpcoesPesquisa.Count = 1 then
    ExecutaPesquisa(FListaOpcoesPesquisa[0])
  else
    MostraOpcoesPesquisa;
end;

procedure TFrmCRUD.btnNovoClick(Sender: TObject);
begin
  HabilitaCampos(touInsercao);
  PosicionaCursorPrimeiroCampo;

  if Assigned(FENTIDADE) then
    begin
      FreeAndNil(FENTIDADE);
      FEntidadePonteiro := nil;
    end;

  DefineEntidadeInterno(FEntidadeClasse.Create);
end;

procedure TFrmCRUD.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCRUD.DefineEntidadeInterno(const coENTIDADE: TENTIDADE);
begin
  FENTIDADE          := coENTIDADE;
  FEntidadePonteiro^ := FENTIDADE;
end;

procedure TFrmCRUD.DefineRegraCRUDInterno(const coRegraCRUD: TRegraCRUD);
begin
  FRegraCRUD          := coRegraCRUD;
  FRegraCRUDPonteiro^ := FRegraCRUD;
end;

procedure TFrmCRUD.edCodigoExit(Sender: TObject);
begin
  if StrToIntDef(edCodigo.Text, 0) <> 0 then
    try
      FRegraCRUD.ValidaExistencia(StrToIntDef(edCodigo.Text, 0));

      DefineEntidadeInterno(RetornaEntidade(StrToIntDef(edCodigo.Text, 0)));
      PreencheFormulario;

      HabilitaCampos(touAtualizacao);
      PosicionaCursorPrimeiroCampo;
    except
      on E: Exception do
        begin
          TDialogo.Excecao(E);
          edCodigo.SetFocus;
        end;
    end;
end;

procedure TFrmCRUD.Finaliza;
begin
  if Assigned(FENTIDADE) then
    begin
      FreeAndNil(FENTIDADE);
      FEntidadePonteiro^ := nil;
    end;

  if Assigned(FRegraCRUD) then
    begin
      FreeAndNil(FRegraCRUD);
      FRegraCRUDPonteiro^ := nil;
    end;
end;

procedure TFrmCRUD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCRUD.FormCreate(Sender: TObject);
begin
  Inicializa;
  InicializaInterno;
end;

procedure TFrmCRUD.FormDestroy(Sender: TObject);
begin
  Finaliza;
end;

procedure TFrmCRUD.HabilitaCampos(const ceTipoOperacaoUsuario: TTipoOperacaoUsuario);
begin
  FTipoOperacaoUsuario := ceTipoOperacaoUsuario;

  edCodigo.Enabled      := FTipoOperacaoUsuario  in [touIndefinida];
  btnLocalizar.Enabled  := edCodigo.Enabled;
  btnGravar.Enabled     := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  btnExcluir.Enabled    := FTipoOperacaoUsuario  in [touAtualizacao, touExclusao];
  btnNovo.Enabled       := FTipoOperacaoUsuario  in [touIndefinida];

  imgGravar.Enabled     := FTipoOperacaoUsuario  in [touAtualizacao, touInsercao];
  imgExcluir.Enabled    := FTipoOperacaoUsuario  in [touAtualizacao, touExclusao];
  imgNovo.Enabled       := FTipoOperacaoUsuario  in [touIndefinida];
end;

procedure TFrmCRUD.Image1Click(Sender: TObject);
begin
  if pnlBotoes.Width = 30 then
    begin
      pnlBotoes.Width := 120;
      pnlFundo.Width := pnlFundo.Width + 90;
      pnlFundo.Align := alClient;
    end
  else
    begin
      pnlBotoes.Width := 30;
      pnlFundo.Width := pnlFundo.Width - 90;
      pnlFundo.Align := alClient;
    end;
end;

procedure TFrmCRUD.Image7Click(Sender: TObject);
begin
//  btnOpenLocalizar.Click;
end;

procedure TFrmCRUD.Inicializa;
begin
  LimpaCampos;
  HabilitaCampos(touIndefinida);

  FListaOpcoesPesquisa := TObjectList<TOpcaoPesquisa>.Create;
end;

procedure TFrmCRUD.InicializaInterno;
begin
  DefineRegraCRUDInterno(FRegraCRUDClasse.Create);

  Caption := Format(STR_CRUD_CABECALHO
                  , [FRegraCRUD.NOME_ENTIDADE]);
  lbCabecalho.Caption := AnsiUpperCase(Caption);
end;

procedure TFrmCRUD.btnOpenLocalizarClick(Sender: TObject);
begin
  if not gbLocalizar.Visible then
  begin
      gbLocalizar.Visible := true;
  end
  else
    begin
      gbLocalizar.Visible := false;
    end;
end;

procedure TFrmCRUD.Label1Click(Sender: TObject);
begin
  PreencheEntidade;
  try
    GravaEntidade;

    TDialogo.Informacao(Format(STR_OPERACAO_COM_SUCESSO,
                        [FRegraCRUD.NOME_ENTIDADE
                       , FENTIDADE.ID
                       , CNT_TIPO_OPERACAO_USUARIO[FTipoOperacaoUsuario]]));
    LimpaCampos;
    HabilitaCampos(touIndefinida);

    edCodigo.SetFocus;
  except
    on E: Exception Do
      begin
        TDialogo.Excecao(E);
      end;
  end;
end;

procedure TFrmCRUD.Label2Click(Sender: TObject);
begin
  LimpaCampos;
  HabilitaCampos(touIndefinida);

  edCodigo.SetFocus;
end;

procedure TFrmCRUD.LimpaCampos;
begin
  TUtilitario.LimpaFormulario(Self);

  if Assigned(FENTIDADE) then
    begin
      FreeAndNil(FENTIDADE);
      FEntidadePonteiro^ := nil;
    end;
end;

procedure TFrmCRUD.MostraOpcoesPesquisa;
var
  loMenuItem: TMenuItem;
  loOpcaoPesquisa: TOpcaoPesquisa;
  loPoint: TPoint;
  liIndice: Integer;
begin
  loPoint.x := btnLocalizar.Left + btnLocalizar.Width  + 2;
  loPoint.y := btnLocalizar.Top  + btnLocalizar.Height + 8;
  loPoint   := ClientToScreen(loPoint);

  pmOpcoes.Items.Clear;
  liIndice := 0;
  for loOpcaoPesquisa in FListaOpcoesPesquisa do
    begin
      loMenuItem         := pmOpcoes.CreateMenuItem;
      loMenuItem.OnClick := PesquisaSelecionada;
      loMenuItem.Tag     := liIndice;
      loMenuItem.Caption := loOpcaoPesquisa.NOME_PESQUISA;

      Inc(liIndice);
      pmOpcoes.Items.Add(loMenuItem);
    end;

  pmOpcoes.Popup(loPoint.x, loPoint.y);
end;

procedure TFrmCRUD.PesquisaSelecionada(Sender: TObject);
var
  loMenuItem: TMenuItem;
  loOpcaoPesquisa: TOpcaoPesquisa;
begin
  if Sender is TMenuItem then
    begin
      loMenuItem      := TMenuItem(Sender);
      loOpcaoPesquisa := FListaOpcoesPesquisa[loMenuItem.Tag];

      ExecutaPesquisa(loOpcaoPesquisa);
    end;
end;


function TFrmCRUD.PreencheComInfromacoesEstadoMunicipio(CarregaEstado: boolean;
  NomeEstado: string): TStringList;
//var
//  NomeCampo: string;
begin
{
  if CarregaEstado then
    NomeCampo := 'UF'
  else
    NomeCampo := 'Nome';
  result:= TStringList.Create;
  UDM.dmEntra21.SQLSelect.Close;
  if CarregaEstado then
    UDM.dmEntra21.SQLSelect.CommandText := CNT_SELECIONA_UF
  else
    UDM.dmEntra21.SQLSelect.CommandText := Format(CNT_SELECIONA_CIDADE,[NomeEstado]);
  UDM.dmEntra21.SQLSelect.Open;

  while not UDM.dmEntra21.SQLSelect.Eof do
    begin
      result.Add(dmEntra21.SQLSelect.FieldByName(NomeCampo).AsString);
      dmEntra21.SQLSelect.Next
    end;
}
  Result := nil;
end;

procedure TFrmCRUD.RemoveEntidade;
begin
  FRegraCRUD.Exclui(FENTIDADE.ID);
end;

function TFrmCRUD.RetornaEntidade(const ciId: Integer): TENTIDADE;
begin
  Result := FRegraCRUD.Retorna(ciId);
end;

function TFrmCRUD.RetornaSelecaoTodos(const csNomeTabelaOuView: String): String;
begin
  Result := Format('select * form %s', [csNomeTabelaOuView]);
end;

procedure TFrmCRUD.ExecutaPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa);
begin
  edCodigo.Text := TfrmPesquisa.MostrarPesquisa(coOpcaoPesquisa);
  if StrToIntDef(edCodigo.Text, 0) <> 0 then
    edCodigoExit(btnLocalizar);
end;

procedure TFrmCRUD.AdicionaOpcaoPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa);
begin
  FListaOpcoesPesquisa.Add(coOpcaoPesquisa);
end;

procedure TFrmCRUD.edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F7 then
    btnLocalizar.OnClick(Sender);
end;

procedure TFrmCRUD.FormShow(Sender: TObject);
begin
  btnLocalizar.Visible := FListaOpcoesPesquisa.Count > 0;
  {Remover bordas}
  pnlBotoes.BevelInner := bvNone;
  pnlBotoes.BevelOuter := bvNone;
  pnlCabecalho.BevelInner := bvNone;
  pnlCabecalho.BevelOuter := bvNone;
  pnlRodape.BevelInner := bvNone;
  pnlRodape.BevelOuter := bvNone;
end;

procedure TFrmCRUD.GravaEntidade;
begin
   case FTipoOperacaoUsuario of
    touInsercao: FRegraCRUD.Insere(FENTIDADE);
    touAtualizacao: FRegraCRUD.Atualiza(FENTIDADE);
  end;
end;

end.
