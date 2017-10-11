unit URegraCRUDClienteDB;

interface

uses
    URegraCRUDCliente
  , URepositorioDB
  , UEntidade
  , URepositorioClienteDB
  ;

type
  TRegraCRUDClienteDB = class(TRegraCRUDCliente)
  public
    constructor Create; override;
  end;

implementation

constructor TRegraCRUDClienteDB.Create;
begin
  inherited;
  FRepositorio := TRepositorioDB<TENTIDADE>(TRepositorioClienteDB.Create);
end;

end.
