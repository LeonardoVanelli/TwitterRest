unit UFrmPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, FMTBcd, DB, SqlExpr, Grids, DBGrids , Provider, DBClient
  , UEntidade
  , Generics.Collections
  , UOpcaoPesquisa
  , URepositorioJSON
  , UTraducaoPesquisa
  ;

type
  TfrmPesquisa = class(TForm)
    pnlBotoes: TPanel;
    btnSair: TBitBtn;
    btnConfirmar: TBitBtn;
    gbParametros: TGroupBox;
    pnlCabecalho: TPanel;
    dbgCliente: TDBGrid;
    edPesquisa: TEdit;
    lbOpcao: TLabel;
    lbIgualA: TLabel;
    cbOpcoes: TComboBox;
    lbCabecalho: TLabel;
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgClienteDblClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbOpcoesChange(Sender: TObject);
  private
    FDataSource      : TDataSource;
    FClientDataSet   : TClientDataSet;
    FRetorno         : Variant;
    FOpcaoPesquisa   : TOpcaoPesquisa;
    FRepositorioJSON : TRepositorioJSON<TENTIDADE>;
    FTraducaoPesquisa: ITraducaoPesquisa;

  public
    class function MostrarPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa): Variant;
    procedure Inicializa;

    property Retorno      : Variant        read FRetorno;
    property OpcaoPesquisa: TOpcaoPesquisa read FOpcaoPesquisa write FOpcaoPesquisa;
  end;

const
  CNT_DATA_SET_PROVIDER_NAME = 'dspPesquisa';
  CNT_SELECT_ALL             = 'select * from %s';

implementation

{$R *.dfm}

uses
    DBXJSON
  , DataSetConverter4D.Impl
  , URepositorioCompraJSON
  , URepositorioPrescricaoJSON
  ;

{ TfrmPesquisa }

class function TfrmPesquisa.MostrarPesquisa(const coOpcaoPesquisa: TOpcaoPesquisa): Variant;
var
  frmPesquisa: TfrmPesquisa;
begin
  frmPesquisa := TfrmPesquisa.Create(Application);
  try
    frmPesquisa.OpcaoPesquisa := coOpcaoPesquisa;
    frmPesquisa.Inicializa;

    if frmPesquisa.ShowModal = mrOk then
      Result := frmPesquisa.Retorno
    else
      Result := '';
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmPesquisa.Inicializa;
var
  JSONArray: TJSONArray;
  ENTIDADE: TENTIDADE;
begin
  FTraducaoPesquisa := FOpcaoPesquisa.TRADUTOR;

  FClientDataSet              := TClientDataSet.Create(Self);
  FClientDataSet.ProviderName := CNT_DATA_SET_PROVIDER_NAME;

  FDataSource         := TDataSource.Create(Self);
  FDataSource.DataSet := FClientDataSet;
  FDataSource.Enabled := True;

  FTraducaoPesquisa.DefineCampos(FClientDataSet);
  FClientDataSet.CreateDataSet;

  dbgCliente.DataSource := FDataSource;

  Caption             := Caption + ' - ' + FOpcaoPesquisa.NOME_PESQUISA;
  lbCabecalho.Caption := AnsiUpperCase(lbCabecalho.Caption + ' - ' + FOpcaoPesquisa.NOME_PESQUISA);

  if OpcaoPesquisa.VISAO = 'COMPRA' then
    FRepositorioJSON := TRepositorioJSON<TENTIDADE>(TRepositorioCompraJSON.Create)
  else
    if OpcaoPesquisa.VISAO = 'PRESCRICAO' then
      FRepositorioJSON := TRepositorioJSON<TENTIDADE>(TRepositorioPrescricaoJSON.Create);

  JSONArray := TJSONArray.Create;
  for ENTIDADE in FRepositorioJSON.RetornaTodos do
    JSONArray.AddElement(ENTIDADE.RetornaJSON);

  JSONArray := FTraducaoPesquisa.RetornaDados(JSONArray);

  TConverter.New.JSON.Source(JSONArray).ToDataSet(FClientDataSet);
  FClientDataSet.ReadOnly := True;
  FClientDataSet.Active   := True;

  FRetorno := 0;
end;

procedure TfrmPesquisa.btnConfirmarClick(Sender: TObject);
begin
  FRetorno := FClientDataSet.FieldValues[FOpcaoPesquisa.NOME_CAMPO_RETORNO];
end;

procedure TfrmPesquisa.dbgClienteDblClick(Sender: TObject);
begin
  FRetorno    := FClientDataSet.FieldValues[FOpcaoPesquisa.NOME_CAMPO_RETORNO];
  ModalResult := mrOk;
end;

procedure TfrmPesquisa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisa.cbOpcoesChange(Sender: TObject);
begin
  FClientDataSet.IndexFieldNames := cbOpcoes.Text;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
var
  lsCampo: String;
begin
  for lsCampo in FOpcaoPesquisa.FILTROS do
    cbOpcoes.Items.Add(lsCampo);

  cbOpcoes.ItemIndex             := 0;
  FClientDataSet.IndexFieldNames := cbOpcoes.Text;
end;

procedure TfrmPesquisa.edPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FClientDataSet.FindNearest([edPesquisa.Text]);
  FClientDataSet.GotoNearest;
end;

procedure TfrmPesquisa.dbgClienteKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        FRetorno    := FClientDataSet.FieldValues[FOpcaoPesquisa.NOME_CAMPO_RETORNO];
        ModalResult := mrOk;
      end;
    VK_ESCAPE: ModalResult := mrCancel;
  end;    
end;

end.
