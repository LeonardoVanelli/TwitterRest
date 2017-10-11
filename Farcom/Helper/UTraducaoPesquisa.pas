unit UTraducaoPesquisa;

interface

uses
    DBXJSON
  , Generics.Collections
  , DB
  , DBClient
  , Classes
  ;

type
  ITraducaoPesquisa = Interface
    ['{D2687247-F1EA-4614-A527-35AE20E552AA}']
    function RetornaDados(const Source: TJSONArray): TJSONArray;
    procedure DefineCampos(const coClienteDataSet: TClientDataSet);
  End;

  TTraducaoPesquisaPrescricao = class(TInterfacedObject, ITraducaoPesquisa)
  public
    function RetornaDados(const Source: TJSONArray): TJSONArray;
    procedure DefineCampos(const coClienteDataSet: TClientDataSet);
  end;

implementation

uses
    DataSetConverter4D.Util
  ;

{ TTraducaoPesquisaPrescricao }


procedure  TTraducaoPesquisaPrescricao.DefineCampos(const coClienteDataSet: TClientDataSet);
begin
  NewDataSetField(coClienteDataSet, ftString, 'NOME_MEDICO'         , 80, 'NOME_MEDICO'     , 'Nome Médico');
  NewDataSetField(coClienteDataSet, ftString, 'NOME_CLIENTE'        , 80, 'NOME_CLIENTE'    , 'Nome Cliente');
  NewDataSetField(coClienteDataSet, ftString, 'NOME_MEDICAMENTO'    , 80, 'NOME_MEDICAMENTO', 'Nome Medicamento');
  NewDataSetField(coClienteDataSet, ftString, 'ID_MEDICAMENTO'      , 80, 'ID_MEDICAMENTO'  , 'ID Medicamento');
  NewDataSetField(coClienteDataSet, ftString, 'PRINCIPIO_ATIVO'     , 50, 'PRINCIPIO_ATIVO' , 'Principio_Ativo');
  NewDataSetField(coClienteDataSet, ftString, 'DESCRICAO'           , 80, 'DESCRICAO'       , 'Descrição');
  NewDataSetField(coClienteDataSet, ftString, 'DATA_VENCIMENTO'     , 20, 'DATA_VENCIMENTO' , 'Data de Vencimento');
  NewDataSetField(coClienteDataSet, ftString, 'DATA_HORA_PRESCRITA' , 20, 'DATA_HORA_PRESCRITA'  , 'Data/Hora Prescrita');
end;

function TTraducaoPesquisaPrescricao.RetornaDados(
  const Source: TJSONArray): TJSONArray;
var
  Indice: Integer;
  JSONObjectRaiz: TJSONObject;
  JSONObjectFuncionario: TJSONObject;
  JSONObjectMedicamento: TJSONObject;
  JSONObjectCliente: TJSONObject;
  JSONObjectTraduzido: TJSONObject;
begin
  Result := TJSONArray.Create;
  for Indice := 0 to Pred(Source.Size) do
    begin
      JSONObjectRaiz        := Source.Get(Indice) as TJSONObject;
      JSONObjectFuncionario := JSONObjectRaiz.Get('FUNCIONARIO').JsonValue as TJSONObject;
      JSONObjectMedicamento := JSONObjectRaiz.Get('MEDICAMENTO').JsonValue as TJSONObject;
      JSONObjectCliente     := JSONObjectRaiz.Get('CLIENTE').JsonValue     as TJSONObject;

      JSONObjectTraduzido := TJSONObject.Create;
      with JSONObjectTraduzido do
      begin
//        AddPair('NOME_MEDICO'         , JSONObjectFuncionario.Get ('NOME'               ).JsonValue.Value);
//        AddPair('NOME_CLIENTE'        , JSONObjectCliente.Get     ('NOME'               ).JsonValue.Value);
//        AddPair('NOME_MEDICAMENTO'    , JSONObjectMedicamento.Get ('NOME'               ).JsonValue.Value);
//        AddPair('ID_MEDICAMENTO'      , JSONObjectMedicamento.Get ('ID'                 ).JsonValue.Value);
//        AddPair('PRINCIPIO_ATIVO'     , JSONObjectMedicamento.Get ('PRINCIPIO_ATIVO'    ).JsonValue.Value);
//        AddPair('DESCRICAO'           , JSONObjectRaiz.Get        ('DESCRICAO'          ).JsonValue.Value);
//        AddPair('DATA_VENCIMENTO'     , JSONObjectRaiz.Get        ('DATA_VENCIMENTO'    ).JsonValue.Value);
//        AddPair('DATA_HORA_PRESCRITA' , JSONObjectRaiz.Get        ('DATA_HORA_PRESCRITA').JsonValue.Value);

        AddPair('NOME_CLIENTE'        , JSONObjectCliente.Get     ('NOME'               ).JsonValue.Value);
        AddPair('NOME_MEDICAMENTO'    , JSONObjectMedicamento.Get ('NOME'               ).JsonValue.Value);
        AddPair('DESCRICAO'           , JSONObjectRaiz.Get        ('DESCRICAO'          ).JsonValue.Value);
        AddPair('DATA_VENCIMENTO'     , JSONObjectRaiz.Get        ('DATA_VENCIMENTO'    ).JsonValue.Value);
        AddPair('NOME_MEDICO'         , JSONObjectFuncionario.Get ('NOME'               ).JsonValue.Value);
        AddPair('ID_MEDICAMENTO'      , JSONObjectMedicamento.Get ('ID'                 ).JsonValue.Value);
      end;

      Result.Add(JSONObjectTraduzido);
    end;
end;

end.
