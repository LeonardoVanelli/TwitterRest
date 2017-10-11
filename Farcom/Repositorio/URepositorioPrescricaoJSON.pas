unit URepositorioPrescricaoJSON;

interface

uses
    UPrescricao
  , UEntidade
  , UFuncionario
  , UMedicamento
//  , URepositorioFuncionarioJSON
//  , URepositorioMedicamentoJSON
  , URepositorioClienteJSON
  , URepositorioJSON
  , SqlExpr
  ;

type
  TRepositorioPrescricaoJSON = class(TRepositorioJSON<TPRESCRICAO>)
  public
    constructor Create;

    function RetornaPeloID(const csID: Integer): TPRESCRICAO;
  end;

implementation

{ TRepositorioPrescricao }

uses
    SysUtils
  ;
{ TRepositorioClienteJSON }

constructor TRepositorioPrescricaoJSON.Create;
begin
  Inherited Create(TPRESCRICAO, TBL_PRESCRICAO, 'prescricoes');
end;

function TRepositorioPrescricaoJSON.RetornaPeloID(
  const csID: Integer): TPRESCRICAO;
begin
  Result := TPRESCRICAO(ExecutaRequisicaoObjeto('', '?' + FLD_ENTIDADE_ID + '=' + IntToStr(csID)));
end;

end.
