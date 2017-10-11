unit URegraCRUDConsultorioDB;

interface

uses
    URegraCRUDCOnsultorio
  , URepositorioDB
  , UEntidade
  , URepositorioConsultorioDB
  ;

type
  TRegraCRUDConsultorioDB = class(TRegraCRUDConsultorio)
  public
    constructor Create; override;
  end;

implementation

constructor TRegraCRUDConsultorioDB.Create;
begin
  inherited;
  FRepositorio := TRepositorioDB<TENTIDADE>(TRepositorioConsultorioDB.Create);
end;

end.
