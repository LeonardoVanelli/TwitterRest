unit UOpcaoPesquisa;

interface

uses
    Generics.Collections
  , DB
  , UTraducaoPesquisa
  ;

type
  TOpcaoPesquisa = class
  private
    FFiltros: TList<String>;
    FSQL: String;
    FNomeCampoRetorno: String;
    FNomePesquisa: String;
    FVisao: String;
    FTraducaoPesquisa: ITraducaoPesquisa;

  public
    constructor Create;

    function AdicionaFiltro(const csNomeCampo: String): TOpcaoPesquisa;
    function DefineSQL(const csSQL: String): TOpcaoPesquisa;
    function DefineNomeCampoRetorno(const csNomeCampoRetorno: String): TOpcaoPesquisa;
    function DefineNomePesquisa(const csNomePesquisa: String): TOpcaoPesquisa;
    function DefineVisao(const csVisao: String): TOpcaoPesquisa;
    function DefineTradutorPesquisa(const coTraducaoPesquisa: ITraducaoPesquisa): TOpcaoPesquisa;

    property FILTROS: TList<String> read FFiltros;
    property NOME_PESQUISA: String read FNomePesquisa;
    property SQL: String read FSQL;
    property NOME_CAMPO_RETORNO: String read FNomeCampoRetorno;
    property VISAO: String read FVisao;
    property TRADUTOR: ITraducaoPesquisa read FTraducaoPesquisa;
  end;

implementation

uses
    SysUtils
  ;

{ TOpcaoPesquisa }

constructor TOpcaoPesquisa.Create;
begin
  FFiltros := TList<String>.Create;
end;

function TOpcaoPesquisa.DefineNomeCampoRetorno(const csNomeCampoRetorno: String): TOpcaoPesquisa;
begin
  FNomeCampoRetorno := csNomeCampoRetorno;
  Result            := Self;
end;

function TOpcaoPesquisa.DefineNomePesquisa(const csNomePesquisa: String): TOpcaoPesquisa;
begin
  FNomePesquisa := csNomePesquisa;
  Result        := Self;
end;

function TOpcaoPesquisa.DefineSQL(const csSQL: String): TOpcaoPesquisa;
begin
  FSQL   := csSQL;
  Result := Self;
end;

function TOpcaoPesquisa.DefineTradutorPesquisa(
  const coTraducaoPesquisa: ITraducaoPesquisa): TOpcaoPesquisa;
begin
  FTraducaoPesquisa := coTraducaoPesquisa;
  Result := Self;
end;

function TOpcaoPesquisa.DefineVisao(const csVisao: String): TOpcaoPesquisa;
begin
  FVisao := csVisao;
  Result := DefineSQL(Format('select * from %s', [csVisao]));
end;

function TOpcaoPesquisa.AdicionaFiltro(const csNomeCampo: String): TOpcaoPesquisa;
begin
  FFiltros.Add(csNomeCampo);
  Result := Self;
end;



end.
