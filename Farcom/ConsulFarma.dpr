program ConsulFarma;

uses
  Forms,
  SysUtils,
  UFrmPrincipal in 'VisaoControle\UFrmPrincipal.pas' {FrmPrincipalFarcon},
  UFrmCRUD in 'VisaoControle\UFrmCRUD.pas' {FrmCRUD},
  UUtilitarios in '..\Communs\UUtilitarios.pas',
  UMensagens in '..\Communs\UMensagens.pas',
  UConstantes in '..\Communs\UConstantes.pas',
  UDialogo in 'Helper\UDialogo.pas',
  UOpcaoPesquisa in 'Helper\UOpcaoPesquisa.pas',
  UEntidade in '..\Communs\Persistencia\UEntidade.pas',
  UFarmacia in '..\Communs\Persistencia\UFarmacia.pas',
  UConsultorio in '..\Communs\Persistencia\UConsultorio.pas',
  UCliente in '..\Communs\Persistencia\UCliente.pas',
  UMunicipio in '..\Communs\Persistencia\UMunicipio.pas',
  UFrmCadastroCliente in 'VisaoControle\UFrmCadastroCliente.pas' {FrmCadastroCliente},
  UFrmCadastroFarmacia in 'VisaoControle\UFrmCadastroFarmacia.pas' {FrmCadastroFarmacia},
  URegraCRUD in '..\Communs\Regra\URegraCRUD.pas',
  URegraCRUDCliente in '..\Communs\Regra\URegraCRUDCliente.pas',
  URegraCRUDConsultorio in '..\Communs\Regra\URegraCRUDConsultorio.pas',
  URegraCRUDFarmacia in '..\Communs\Regra\URegraCRUDFarmacia.pas',
  URegraCRUDMunicipio in '..\Communs\Regra\URegraCRUDMunicipio.pas',
  URepositorioMunicipioJSON in 'Repositorio\URepositorioMunicipioJSON.pas',
  URegraCRUDClienteJSON in 'Regra\URegraCRUDClienteJSON.pas',
  URepositorioClienteJSON in 'Repositorio\URepositorioClienteJSON.pas',
  URepositorioJSON in 'Repositorio\URepositorioJSON.pas',
  UFrmPrincipalConsultorio in 'VisaoControle\UFrmPrincipalConsultorio.pas' {frmPrincipalConsultorio},
  UFrmCadastroPrescricao in 'VisaoControle\UFrmCadastroPrescricao.pas' {FrmCadastroPrescricao},
  URepositorioPrescricaoJSON in 'Repositorio\URepositorioPrescricaoJSON.pas',
  URegraCRUDPrescricao in '..\Communs\Regra\URegraCRUDPrescricao.pas',
  FormularioLogin in 'VisaoControle\FormularioLogin.pas' {FrmLoginT},
  ULoginUsuario in 'Helper\ULoginUsuario.pas',
  URepositorioFuncionarioJSON in 'Repositorio\URepositorioFuncionarioJSON.pas',
  UPrescricao in '..\Communs\Persistencia\UPrescricao.pas',
  URepositorioMedicamentoJSON in 'Repositorio\URepositorioMedicamentoJSON.pas',
  URegraCRUDPrescricaoJSON in 'Regra\URegraCRUDPrescricaoJSON.pas',
  URegraCRUDFuncaoJSON in 'Regra\URegraCRUDFuncaoJSON.pas',
  UFrmCadastroCompra in 'VisaoControle\UFrmCadastroCompra.pas' {FrmCadastroCompra},
  UCompra in '..\Communs\Persistencia\UCompra.pas',
  UProduto in '..\Communs\Persistencia\UProduto.pas',
  URegraCRUDCompra in '..\Communs\Regra\URegraCRUDCompra.pas',
  URegraCRUDCompraJSON in 'Regra\URegraCRUDCompraJSON.pas',
  URepositorioCompraJSON in 'Repositorio\URepositorioCompraJSON.pas',
  UFuncionario in '..\Communs\Persistencia\UFuncionario.pas',
  Controls,
  DataSetConverter4D.Helper in '..\DataSetConverter4Delphi\src\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\DataSetConverter4Delphi\src\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\DataSetConverter4Delphi\src\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\DataSetConverter4Delphi\src\DataSetConverter4D.Util.pas',
  UTraducaoPesquisa in 'Helper\UTraducaoPesquisa.pas',
  UFrmPesquisa in 'VisaoControle\UFrmPesquisa.pas' {frmPesquisa};

{$DEFINE PROD}

{$R *.res}

{$IFDEF PROD}
var
  FrmLogin: TFrmLogint;
{$ENDIF}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
{$IFDEF PROD}
  FrmLogin := TFrmLoginT.Create(nil);
  if FrmLogin.ShowModal = mrYes then
    begin
      FreeAndNil(FrmLogin);
      UsuarioLogado := TFUNCIONARIO.Create();
      UsuarioLogado := TLoginUsuario.FuncionarioAtual;
      if TLoginUsuario.FuncionarioAtual.Funcao = 'Farcon' then
        begin
          Application.CreateForm(TFrmPrincipalFarcon, FrmPrincipalFarcon);
  Application.Run;
        end
      else
        if TLoginUsuario.FuncionarioAtual.Funcao = 'Consultorio' then
          begin
            Application.CreateForm(TfrmPrincipalConsultorio, frmPrincipalConsultorio);
            Application.Run;
          end;
    end
  else
    begin
      Application.Run;
      Application.Terminate;
    end;
{$ELSE}
  TLoginUsuario.Unico.ValidaLogin('54321', 'admin');
  Application.CreateForm(TFrmPrincipalFarcon, FrmPrincipalFarcon);
  Application.Run;
{$ENDIF}

end.
