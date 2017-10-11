unit UDM;

interface

uses
  SysUtils, Classes, DB, SqlExpr, FMTBcd
  , UMensagens, DBXFirebird, DBXInterBase
  , DBXCommon
  ;

type
  TdmEntra21 = class(TDataModule)
    SQLConnection: TSQLConnection;
    SQLSelect: TSQLDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    FTransaction: TDBXTransaction;

  public
    procedure AbortaTransacao;
    procedure FinalizaTransacao;
    procedure IniciaTransacao;
    procedure ValidaTransacaoAtiva;

    function TemTransacaoAtiva: Boolean;
  end;

var
  dmEntra21: TdmEntra21;

const
  CNT_DATA_BASE = 'Database';

implementation

{$R *.dfm}

uses
    Math
  ;

procedure TdmEntra21.AbortaTransacao;
begin
  if not TemTransacaoAtiva then
    raise Exception.CreateFmt(STR_NAO_EXISTE_TRANSACAO_ATIVA, [STR_ABORTAR]);

  SQLConnection.RollbackFreeAndNil(FTransaction);
end;

procedure TdmEntra21.FinalizaTransacao;
begin
  if not TemTransacaoAtiva then
    raise Exception.CreateFmt(STR_NAO_EXISTE_TRANSACAO_ATIVA, [STR_FINALIZAR]);

  SQLConnection.CommitFreeAndNil(FTransaction);
end;

procedure TdmEntra21.IniciaTransacao;
begin
  if TemTransacaoAtiva then
    raise Exception.Create(STR_JA_EXISTE_TRANSACAO_ATIVA);

  FTransaction := SQLConnection.BeginTransaction;
end;

function TdmEntra21.TemTransacaoAtiva: Boolean;
begin
  Result := SQLConnection.InTransaction;
end;

procedure TdmEntra21.DataModuleCreate(Sender: TObject);
begin
  SQLConnection.Connected := True;
  SQLConnection.Open;
end;

procedure TdmEntra21.ValidaTransacaoAtiva;
begin
  if not TemTransacaoAtiva then
    raise Exception.Create(STR_VALIDA_TRANSACAO_ATIVA);
end;

end.
