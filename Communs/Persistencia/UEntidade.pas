{
  @author: Felipe Silvino Pereira
  @date: 01/08/2017
  @description: Entidade base para todas as tabelas que sofrerão operação de
                CRUD no sistema.
}
unit UEntidade;

interface

uses
    DBXJSON
  ;

type
  TENTIDADE = class abstract
  protected
    FId: Integer;

  public
    constructor Create; overload; virtual;
    constructor Create(const coJSONObject: TJSONOBject); overload; virtual;

    function RetornaJSON: TJSONOBject; virtual;

    property ID: Integer read FId write FId;
  end;

  TEntidadeClasse = class of TENTIDADE;

const
  FLD_ENTIDADE_ID = 'ID';

implementation

uses
    SysUtils
  ;

{ TENTIDADE }

constructor TENTIDADE.Create;
begin
  Inherited;
end;

constructor TENTIDADE.Create(const coJSONObject: TJSONObject);
begin
  ID := StrToInt(coJSONObject.Get(FLD_ENTIDADE_ID).JsonValue.Value);
end;

function TENTIDADE.RetornaJSON: TJSONOBject;
begin
  Result := TJSONOBject.Create;
  Result.AddPair(FLD_ENTIDADE_ID, TJSONNumber.Create(ID));
end;

end.
