unit ULoginUsuario;

interface

uses
    UFuncionario
  , URepositorioFuncionarioJSON
  , UUtilitarios
  ;

type
  TLoginUsuario = class
  private
    class var FLoginUsuario: TLoginUsuario;

    FRepositorioFuncionarioJSON: TRepositorioFuncionarioJSON;
    FFUNCIONARIO: TFUNCIONARIO;

    function RetornaFuncionario: TFUNCIONARIO;

  public
    constructor Create;
    destructor Destroy; override;

    procedure ValidaLogin(const csCPF, csSenha: String);

    class function FuncionarioAtual: TFUNCIONARIO;
    class function Unico: TLoginUsuario;
  end;

var
  UsuarioLogado : TFUNCIONARIO;

implementation

uses
    SysUtils
  ;

{ TLoginUsuario }

constructor TLoginUsuario.Create;
begin
  FRepositorioFuncionarioJSON := TRepositorioFuncionarioJSON.Create;
end;

destructor TLoginUsuario.Destroy;
begin
  FreeAndNil(FRepositorioFuncionarioJSON);

  if Assigned(FFUNCIONARIO) then
    FreeAndNIl(FFUNCIONARIO);

  inherited;
end;

class function TLoginUsuario.FuncionarioAtual: TFUNCIONARIO;
begin
  Result := Unico.RetornaFuncionario;
end;

function TLoginUsuario.RetornaFuncionario: TFUNCIONARIO;
begin
  Result := FFUNCIONARIO;
end;

class function TLoginUsuario.Unico: TLoginUsuario;
begin
  if not Assigned(FLoginUsuario) then
    FLoginUsuario := TLoginUsuario.Create;

  Result := FLoginUsuario;
end;

procedure TLoginUsuario.ValidaLogin(const csCPF, csSenha: String);
begin
  FFUNCIONARIO := FRepositorioFuncionarioJSON.RetornaPeloCPF(csCPF);
  if (not Assigned(FFUNCIONARIO))
  or (FFUNCIONARIO.SENHA <> csSenha)then
    begin
      raise EValidacaoNegocio.Create('CPF ou Senha informados são inválidos');
    end;
end;

end.
