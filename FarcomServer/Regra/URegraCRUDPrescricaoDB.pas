unit URegraCRUDPrescricaoDB;

interface

uses
    URegraCRUDPrescricao
  , URepositorioDB
  , UEntidade
  , URepositorioPrescricaoDB
  ;

type
  TRegraCRUDPrescricaoDB = class(TRegraCRUDPrescricao)
  public
    constructor Create; override;
  end;

implementation

constructor TRegraCRUDPrescricaoDB.Create;
begin
  inherited;
  FRepositorio := TRepositorioDB<TENTIDADE>(TRepositorioPrescricaoDB.Create);
end;

end.
