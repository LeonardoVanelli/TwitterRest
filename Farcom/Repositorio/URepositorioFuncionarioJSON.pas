unit URepositorioFuncionarioJSON;

interface

uses
    URepositorioJSON
  , UFuncionario
  , UEntidade
  , SqlExpr
  , URepositorio
  , IdHTTP
  ;

type
  TRepositorioFuncionarioJSON = class(TRepositorioJSON<TFUNCIONARIO>)
  public
    constructor Create;

    function RetornaPeloCPF(const csCPF: String): TFUNCIONARIO;
  end;

implementation

uses
    Forms
  , Classes
  , SysUtils
  , Dialogs
  ;

{ TRepositorioClienteJSON }

constructor TRepositorioFuncionarioJSON.Create;
begin
  Inherited Create(TFUNCIONARIO, TBL_FUNCIONARIO, 'funcionarios');
end;

function TRepositorioFuncionarioJSON.RetornaPeloCPF(
  const csCPF: String): TFUNCIONARIO;
begin
  Result := TFUNCIONARIO(ExecutaRequisicaoObjeto('', '?' + FLD_FUNCIONARIO_CPF + '=' + csCPF));
end;

end.
