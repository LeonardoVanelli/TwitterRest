unit URepositorioMunicipioDB;

interface
uses
    UMunicipio
  , UEntidade
  , URepositorioDB
  , SqlExpr
  ;

type
  TRepositorioMunicipioDB = class(TRepositorioDB<TMUNICIPIO>)
  public
    constructor Create;

    procedure AtribuiDBParaEntidade(const coMUNICIPIO: TMUNICIPIO); override;
    procedure AtribuiEntidadeParaDB(const coMUNICIPIO: TMUNICIPIO;
                                    const coSQLQuery: TSQLQuery); override;
    function RetornaPorUFEstadoNomeMunicipio(const csUF: String;
                                          const csNomeMunicipio: String): TMUNICIPIO;
  end;

implementation

uses
  UDM
  ;

const
  CNT_SELECT_MUNICIPIO_UF_ESTADO_NOME_MUNICIPIO = 'select * from municipio where nome = :nome and uf = :uf';

{ TRepositorioMunicipioDB }

constructor TRepositorioMunicipioDB.Create;
begin
  inherited Create(TMUNICIPIO, TBL_MUNICIPIO, FLD_ENTIDADE_ID, STR_MUNICIPIO);
end;

function TRepositorioMunicipioDB.RetornaPorUFEstadoNomeMunicipio(const csUF,
  csNomeMunicipio: String): TMUNICIPIO;
begin
  with UDM.dmEntra21 do
    begin
      SQLSelect.Close;
      SQLSelect.CommandText := CNT_SELECT_MUNICIPIO_UF_ESTADO_NOME_MUNICIPIO;
      SQLSelect.ParamByName(FLD_MUNICIPIO_NOME).AsString := csNomeMunicipio;
      SQLSelect.ParamByName(FLD_MUNICIPIO_UF  ).AsString := csUF;
      SQLSelect.Open;

      Result := nil;
      if not SQLSelect.Eof then
        begin
          Result := TMUNICIPIO.Create;
          AtribuiDBParaEntidade(Result);
        end;
    end;
end;

procedure TRepositorioMunicipioDB.AtribuiDBParaEntidade(const coMUNICIPIO: TMUNICIPIO);
begin
  inherited;
  with FSQLSelect do
    begin
      coMUNICIPIO.NOME := FieldByName(FLD_MUNICIPIO_NOME).AsString;
      coMUNICIPIO.UF   := FieldByName(FLD_MUNICIPIO_UF).AsString;
    end;
end;

procedure TRepositorioMunicipioDB.AtribuiEntidadeParaDB(const coMUNICIPIO: TMUNICIPIO;
  const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
    begin
      ParamByName(FLD_MUNICIPIO_NOME).AsString := coMUNICIPIO.NOME;
      ParamByName(FLD_MUNICIPIO_UF).AsString   :=  coMUNICIPIO.UF;
    end;
end;

end.

