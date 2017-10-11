unit URepositorioMedicamentoJSON;

interface

uses
    URepositorioJSON
  , UProduto
  , UEntidade
  , SqlExpr
  , URepositorio
  , IdHTTP
  ;

type
  TRepositorioMedicamentoJSON = class(TRepositorioJSON<TMedicamento>)
  public
    constructor Create;

  function RetornaPeloID(const csID: Integer): TMEDICAMENTO;
  end;

implementation

uses
    Forms
  , Classes
  , SysUtils
  , Dialogs
  ;

{ TRepositorioClienteJSON }

constructor TRepositorioMedicamentoJSON.Create;
begin
  Inherited Create(TMEDICAMENTO, TBL_PRODUTO, 'medicamentos');
end;

function TRepositorioMedicamentoJSON.RetornaPeloID(
  const csID: Integer): TMEDICAMENTO;
begin
  Result := TMEDICAMENTO(ExecutaRequisicaoObjeto('', '?' + FLD_ENTIDADE_ID + '=' + IntToStr(csID)));
end;

end.
