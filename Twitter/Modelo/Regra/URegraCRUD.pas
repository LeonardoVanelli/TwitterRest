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
  , URepositorioDB
  ;

type
  TRegraCRUD = class abstract
  private
    function RetornaNomeEntidade: String;

  protected
    FRepositorioDB: TRepositorioDB<TENTIDADE>;

    procedure ValidaAtualizacao(const coENTIDADE: TENTIDADE); virtual;
    procedure ValidaInsercao(const coENTIDADE: TENTIDADE); virtual;
    procedure ValidaExclusao(const coENTIDADE: TENTIDADE); virtual;
    procedure PreparaInsercao(const coENTIDADE: TENTIDADE); virtual;
    procedure PreparaAtualizacao(const coENTIDADE: TENTIDADE); virtual;
    procedure PreparaExclusao(const coENTIDADE: TENTIDADE); virtual;

  public
    constructor Create; virtual;
    destructor Destroy; override;

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

constructor TRegraCRUD.Create;
begin
  Inherited;
end;

destructor TRegraCRUD.Destroy;
begin
  FreeAndNil(FRepositorioDB);
  inherited;
end;

procedure TRegraCRUD.Atualiza(const coENTIDADE: TENTIDADE);
begin
  ValidaAtualizacao(coENTIDADE);
  PreparaAtualizacao(coENTIDADE);
  FRepositorioDB.Atualiza(coENTIDADE);
end;

procedure TRegraCRUD.Exclui(const ciId: Integer);
var
  loENTIDADE: TENTIDADE;
begin
  ValidaExistencia(ciId);

  loENTIDADE := Retorna(ciId);
  ValidaExclusao(loENTIDADE);
  PreparaExclusao(loENTIDADE);

  FRepositorioDB.Exclui(ciId);
end;

procedure TRegraCRUD.Insere(const coENTIDADE: TENTIDADE);
begin
  ValidaInsercao(coENTIDADE);
  PreparaInsercao(coENTIDADE);
  FRepositorioDB.Insere(coENTIDADE);
end;

procedure TRegraCRUD.PreparaAtualizacao(const coENTIDADE: TENTIDADE);
begin
  //Sem implementacao padrão
end;

procedure TRegraCRUD.PreparaExclusao(const coENTIDADE: TENTIDADE);
begin
  //Sem implementacao padrão
end;

procedure TRegraCRUD.PreparaInsercao(const coENTIDADE: TENTIDADE);
begin
  //Sem implementacao padrão
end;

function TRegraCRUD.Retorna(const ciId: Integer): TENTIDADE;
begin
  Result := FRepositorioDB.Retorna(ciId);
end;

function TRegraCRUD.RetornaNomeEntidade: String;
begin
  Result := FRepositorioDB.NOME_ENTIDADE;
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
  if not FRepositorioDB.Achou(ciId) then
    raise EValidacaoNegocio.CreateFmt(STR_ENTIDADE_NAO_ENCONTRADA,
      [FRepositorioDB.NOME_ENTIDADE, ciId]);
end;

procedure TRegraCRUD.ValidaInsercao(const coENTIDADE: TENTIDADE);
begin
  //Sem implementacao padrão
end;

end.
