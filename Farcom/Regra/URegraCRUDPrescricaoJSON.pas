unit URegraCRUDPrescricaoJSON;

interface

uses
    URegraCRUD
  , URegraCRUDPrescricao
  , URepositorioJSON
  , URepositorioPrescricaoJSON
  , UEntidade
  , UPrescricao
  ;

type
  TRegraCRUDPrescricaoJSON = class(TRegraCRUDPrescricao)
  public
    constructor Create; override;
  end;

implementation

{ TRegraCRUDPrescricao }

//  if Trim(TPrescricao(coENTIDADE).FUNCIONARIO) = EmptyStr Then
//    raise EValidacaoNegocio.Create(STR_CIDADE_NOME_NAO_INFORMADO);
//  if TFuncionario(coENTIDADE).CPF >= 12 then
//    raise EValidacaoNegocio.CreateFmt(STR_CIDADE_POPULACAO_INVALIDA,
//                                      [CNT_POPULACAO_MINIMA_CIDADE]);

{ TRegraCRUDPrescricaoJSON }

constructor TRegraCRUDPrescricaoJSON.Create;
begin
  inherited;
  FRepositorio := TRepositorioJSON<TENTIDADE>(TRepositorioPrescricaoJSON.Create);
end;

end.
