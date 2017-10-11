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
  , Generics.Collections, Menus
  ;

type
  TEntidadePonteiro  = ^TENTIDADE;
  TRegraCRUDPonteiro = ^TRegraCRUD;

  TFrmCRUD = class(TForm)
    pnlCabecalho: TPanel;
    lbCabecalho: TLabel;
    gbLocalizar: TGroupBox;
    lbCodigo: TLabel;
    btnLocalizar: TButton;
    pnlBotoes: TPanel;
    btnLimpar: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnSair: TBitBtn;
    btnNovo: TBitBtn;
    pmOpcoes: TPopupMenu;
    edCodigo: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
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
  public
    procedure AdicionaOpcaoPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa);
  end;

implementation

{$R *.dfm}

uses
    UDM
  , UMensagens
  , UDialogo
  ;

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
      dmEntra21.IniciaTransacao;
      try
        RemoveEntidade;
        dmEntra21.FinalizaTransacao;
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
            dmEntra21.AbortaTransacao;
            TDialogo.Excecao(E);
          end;
      end;
    end;
end;

procedure TFrmCRUD.btnGravarClick(Sender: TObject);
begin
  PreencheEntidade;
  dmEntra21.IniciaTransacao;
  try
    GravaEntidade;

    dmEntra21.FinalizaTransacao;
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
        dmEntra21.AbortaTransacao;
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

procedure TFrmCRUD.btnLocalizarClick(Sender: TObject);
begin
  if FListaOpcoesPesquisa.Count = 1 then
    ExecutaPesquisa(FListaOpcoesPesquisa[0])
  else
    MostraOpcoesPesquisa;
end;

procedure TFrmCRUD.btnSairClick(Sender: TObject);
begin
  Close;
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
    btnLocalizar.Click;
end;

procedure TFrmCRUD.FormShow(Sender: TObject);
begin
  btnLocalizar.Visible := FListaOpcoesPesquisa.Count > 0;
end;

procedure TFrmCRUD.GravaEntidade;
begin
  case FTipoOperacaoUsuario of
    touInsercao: FRegraCRUD.Insere(FENTIDADE);
    touAtualizacao: FRegraCRUD.Atualiza(FENTIDADE);
  end;
end;

end.
