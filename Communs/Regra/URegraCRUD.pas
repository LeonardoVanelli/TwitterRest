{
  @author: Felipe Silvino Pereira
  @date: 01/08/2017
  @description: Classe base para implementação das regras de negócio a serem
                aplicadadas à uma entidade durante o CRUD.
}

unit URegraCRUD;

interface

uses
    UENTIDADE
  , URepositorio
  ;

type
  TRegraCRUD = class abstract
  private
    function RetornaNomeEntidade: String;

  protected
    FRepositorio: IRepositorio<TENTIDADE>;

    procedure ValidaAtualizacao(const coENTIDADE: TENTIDADE); virtual;
    procedure ValidaInsercao(const coENTIDADE: TENTIDADE); virtual;
    procedure ValidaExclusao(const coENTIDADE: TENTIDADE); virtual;

  public
    constructor Create; virtual;

    procedure Insere(const coENTIDADE: TENTIDADE);
    procedure Atualiza(const coENTIDADE: TENTIDADE);
    procedure Exclui(const ciId: Integer);
    procedure ValidaExistencia(const ciId: Integer);

    function Retorna(const ciId: Integer): TENTIDADE;

    property NOME_ENTIDADE: String read RetornaNomeEntidade;
  end;

  TRegraCRUDClasse = type of TRegraCRUD;

implementation

uses
    SysUtils
  , UMensagens
  , UUtilitarios
   ;

{ TRegraCRUD }


procedure TRegraCRUD.Atualiza(const coENTIDADE: TENTIDADE);
begin
  ValidaAtualizacao(coENTIDADE);
  FRepositorio.Atualiza(coENTIDADE);
end;

constructor TRegraCRUD.Create;
begin
  Inherited;
end;

procedure TRegraCRUD.Exclui(const ciId: Integer);
begin
  ValidaExistencia(ciId);
  ValidaExclusao(Retorna(ciId));
  FRepositorio.Exclui(ciId);
end;

procedure TRegraCRUD.Insere(const coENTIDADE: TENTIDADE);
begin
  ValidaInsercao(coENTIDADE);
  FRepositorio.Insere(coENTIDADE);
end;

function TRegraCRUD.Retorna(const ciId: Integer): TENTIDADE;
begin
  Result := FRepositorio.Retorna(ciId);
end;

function TRegraCRUD.RetornaNomeEntidade: String;
begin
  Result := FRepositorio.NOME_ENTIDADE;
end;

procedure TRegraCRUD.ValidaAtualizacao(const coENTIDADE: TENTIDADE);
begin
  ValidaExistencia(coENTIDADE.ID);
end;

procedure TRegraCRUD.ValidaExclusao(const coENTIDADE: TENTIDADE);
begin
  //Sem implementacao padrão
end;

procedure TRegraCRUD.ValidaExistencia(const ciId: Integer);
begin
  if not FRepositorio.Achou(ciId) then
    raise EValidacaoNegocio.CreateFmt(STR_ENTIDADE_NAO_ENCONTRADA,
      [FRepositorio.NOME_ENTIDADE, ciId]);
end;

procedure TRegraCRUD.ValidaInsercao(const coENTIDADE: TENTIDADE);
begin
  //Sem implementacao padrão
end;

end.
