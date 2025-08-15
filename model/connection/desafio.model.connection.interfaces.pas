unit desafio.model.connection.interfaces;

interface

uses
  Data.DB;

type

  iConexao = Interface
  ['{BF07A178-D42F-490A-9954-7DA30DD0B045}']
  {publico}
    function Conexao: TCustomConnection;
  End;

  iQuery = interface
  {publico}
    procedure Exec(const pStatement: String; const pParams: Array of Variant);
    function Open(const pStatement: String; const pParams: Array of Variant): TDataSet;

    procedure StartTransaction;
    procedure Rollback;
    procedure Commit;
  end;

  iConfigConexao = Interface
  ['{6259C2C5-FB6C-4F29-8EFC-AD1623BD511C}']
    function getProtocol: String;
    function getPort: Integer;
    function getHost: String;
    function getPath: String;
    function getDriverName: String;
    function getUser: String;
    function getPassword: String;

    function setHost(const pValue: String): iConfigConexao;
    function setPort(const pValue: Integer): iConfigConexao;
    function setPath(const pValue: String): iConfigConexao;
    function setDriverName(const pValue: String): iConfigConexao;
    function setUser(const pValue: String): iConfigConexao;
    function setPassword(const pValue: String): iConfigConexao;
  End;


implementation

end.
