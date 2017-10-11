program FarconServer;

uses
  Forms,
  Themes,
  formMain in 'formMain.pas' {frmMain},
  ServerUtils in 'ServerUtils.pas',
  SysTypes in 'SysTypes.pas',
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas',
  UDM in 'Persistencia\UDM.pas' {DMtest: TDataModule},
  UCliente in '..\Communs\Persistencia\UCliente.pas',
  UConsultorio in '..\Communs\Persistencia\UConsultorio.pas',
  UEntidade in '..\Communs\Persistencia\UEntidade.pas',
  UFarmacia in '..\Communs\Persistencia\UFarmacia.pas',
  UMunicipio in '..\Communs\Persistencia\UMunicipio.pas',
  UMensagens in '..\Communs\UMensagens.pas',
  UConstantes in '..\Communs\UConstantes.pas',
  UUtilitarios in '..\Communs\UUtilitarios.pas',
  URegraCRUD in '..\Communs\Regra\URegraCRUD.pas',
  URegraCRUDCliente in '..\Communs\Regra\URegraCRUDCliente.pas',
  URegraCRUDConsultorio in '..\Communs\Regra\URegraCRUDConsultorio.pas',
  URegraCRUDFarmacia in '..\Communs\Regra\URegraCRUDFarmacia.pas',
  URegraCRUDMunicipio in '..\Communs\Regra\URegraCRUDMunicipio.pas',
  URepositorio in '..\Communs\Persistencia\URepositorio.pas',
  URegraCRUDConsultorioDB in 'Regra\URegraCRUDConsultorioDB.pas',
  URegraCRUDClienteDB in 'Regra\URegraCRUDClienteDB.pas',
  URepositorioClienteDB in 'Persistencia\URepositorioClienteDB.pas',
  URepositorioConsultorioDB in 'Persistencia\URepositorioConsultorioDB.pas',
  URepositorioDB in 'Persistencia\URepositorioDB.pas',
  URepositorioFarmaciaDB in 'Persistencia\URepositorioFarmaciaDB.pas',
  URepositorioMunicipioDB in 'Persistencia\URepositorioMunicipioDB.pas',
  URepositorioCompraDB in 'Persistencia\URepositorioCompraDB.pas',
  URepositorioProdutoDB in 'Persistencia\URepositorioProdutoDB.pas',
  UProduto in '..\Communs\Persistencia\UProduto.pas',
  UCompra in '..\Communs\Persistencia\UCompra.pas',
  UFuncionario in '..\Communs\Persistencia\UFuncionario.pas',
  URepositorioFuncionarioDB in 'Persistencia\URepositorioFuncionarioDB.pas',
  URepositorioMedicamentoDB in 'Persistencia\URepositorioMedicamentoDB.pas',
  URepositorioPrescricaoDB in 'Persistencia\URepositorioPrescricaoDB.pas',
  UPrescricao in '..\Communs\Persistencia\UPrescricao.pas',
  URegraCRUDPrescricaoDB in 'Regra\URegraCRUDPrescricaoDB.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmEntra21, dmEntra21);
  Application.Run;
end.
