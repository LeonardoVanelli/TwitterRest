unit URegraCRUDPrescricao;

interface

uses
    URegraCRUD
  , URepositorio
  , UEntidade
  , UPrescricao
  ;

type
  TRegraCRUDPrescricao = class(TRegraCRUD)
  protected
    procedure ValidaInsercao(const coENTIDADE: TENTIDADE); override;
  end;

implementation

{ TRegraCRUDPrescricao }

uses
    SysUtils
  , UUtilitarios
  , UMensagens
  ;

procedure TRegraCRUDPrescricao.ValidaInsercao(const coENTIDADE: TENTIDADE);
begin
  inherited;
//    if Trim(TPrescricao(coENTIDADE).FUNCIONARIO) = EmptyStr Then
//    raise EValidacaoNegocio.Create(STR_CIDADE_NOME_NAO_INFORMADO);

//  if TFuncionario(coENTIDADE).CPF >= 12 then
//    raise EValidacaoNegocio.CreateFmt(STR_CIDADE_POPULACAO_INVALIDA,
//                                      [CNT_POPULACAO_MINIMA_CIDADE]);
end;

end.
