{
  @author: Felipe Silvino Pereira
  @date: 01/08/2017
  @description: Entidade base para todas as tabelas que sofrerão operação de
                CRUD no sistema.
}
unit UEntidade;

interface

type
  TENTIDADE = class abstract
  protected
    FId: Integer;

  public
    constructor Create; virtual;

    property ID: Integer read FId write FId;
  end;

  TEntidadeClasse = class of TENTIDADE;

const
  FLD_ENTIDADE_ID = 'ID';

implementation

{ TENTIDADE }

constructor TENTIDADE.Create;
begin
  Inherited;
end;

end.
