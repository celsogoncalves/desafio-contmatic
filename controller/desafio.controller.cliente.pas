unit desafio.controller.cliente;

interface

uses
  SysUtils,
  desafio.controller.interfaces,
  desafio.model.connection.interfaces,
  desafio.model.dto.interfaces,
  desafio.model.dao.interfaces;

type
  TControllerCliente = class(TinterfacedObject, iControllerCliente)
   strict private
     FClienteDao: iClienteDao;
   private
     constructor Create( const pConexao: iConexao );
   public
     function Retorna(const pCodigo: Integer): iCliente_dto;
     function Listar: iLstCliente_dto;

     class function New( const pConexao: iConexao ): iControllerCliente;
   end;

implementation

{ TControllerCliente }

uses desafio.model.dao.cliente, desafio.model.adapter;

constructor TControllerCliente.Create(const pConexao: iConexao);
begin
  inherited Create;

  Self.FClienteDao := TClienteDao.New( pConexao );
end;

function TControllerCliente.Listar: iLstCliente_dto;
begin
  Result := TAdapterCliente.LstEntityToLstDto( FClienteDao.Listar );
end;

class function TControllerCliente.New(
  const pConexao: iConexao): iControllerCliente;
begin
  Result := Self.Create( pConexao );
end;

function TControllerCliente.Retorna(const pCodigo: Integer): iCliente_dto;
begin
  Result := TAdapterCliente.EntityToDto( FClienteDao.RetornarPorCodigo( pCodigo ) );
end;

end.
