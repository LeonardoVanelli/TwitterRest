unit URepositorio;

interface

uses
    UEntidade
  ;

type
  TModoRepositorio = (mrBancoDados, mrMemoria);

  IRepositorio<T: TENTIDADE> = interface
    ['{007FE8B6-EFBA-4B60-A9A5-B3B8C5E4AD1C}']
    procedure Insere(const coENTIDADE: T);
    procedure Atualiza(const coENTIDADE: T);
    procedure Exclui(const ciId: Integer);

    function Achou(const ciId: Integer): Boolean;
    function Retorna(const ciId: Integer): TENTIDADE;
  end;

implementation

end.
