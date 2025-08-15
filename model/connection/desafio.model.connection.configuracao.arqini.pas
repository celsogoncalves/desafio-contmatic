unit desafio.model.connection.configuracao.arqini;

interface

uses
  System.SysUtils, IniFiles,
  desafio.model.connection.interfaces;

type

  TConfigArqIni = class(TInterfacedObject, iConfigConexao )
  const
    CONFIG     = 'CONFIG';
    HOST       = 'HOST';
    PATH       = 'PATH';
    DRIVERNAME = 'DRIVERNAME';
    PORT       = 'PORT';
    USER       = 'USER';
    PASS       = 'PASS';
  strict private
    FArqIni     : TIniFile;
  private
    constructor Create( const pArq: String );
    destructor Destroy; override;

    {$Region 'Área de Gets'}
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

    {$EndRegion}
  public
    class function New( const pArq: String ): iConfigConexao;
  end;



implementation

{ TConfigArqIni }

constructor TConfigArqIni.Create( const pArq: String );
begin
  inherited Create;

  if FileExists(pArq) then
    FArqIni := TIniFile.Create( pArq )
  else
    raise Exception.Create('Arquivo de configuração inexistente!');
end;

destructor TConfigArqIni.Destroy;
begin
  FreeAndNil(FArqIni);

  inherited;
end;

function TConfigArqIni.getDriverName: String;
begin
  Result := FArqIni.ReadString( CONFIG, DRIVERNAME, '' );
end;

function TConfigArqIni.getPassword: String;
begin
  Result := FArqIni.ReadString( CONFIG, PASS, '' );
end;

function TConfigArqIni.getPath: String;
begin
  Result := FArqIni.ReadString( CONFIG, PATH, '' );
end;

function TConfigArqIni.getPort: Integer;
begin
  Result := FArqIni.ReadInteger( CONFIG, PORT, 0 );
end;

function TConfigArqIni.getProtocol: String;
begin
  Result := 'TCP';
  if (getHost='LOCALHOST') or (getHost='127.0.0.1')  then
    Result := 'LOCAL';
end;

function TConfigArqIni.getHost: String;
begin
  Result := FArqIni.ReadString( CONFIG, HOST, '' );
end;

function TConfigArqIni.getUser: String;
begin
  Result := FArqIni.ReadString( CONFIG, USER, '' );
end;

class function TConfigArqIni.New( const pArq: String ): iConfigConexao;
begin
  Result := Self.Create( pArq );
end;

function TConfigArqIni.setDriverName(const pValue: String): iConfigConexao;
begin
  try
    FArqIni.WriteString(CONFIG, DRIVERNAME, pValue);
  finally
    Result := Self;
  end;
end;

function TConfigArqIni.setHost(const pValue: String): iConfigConexao;
begin
  try
    FArqIni.WriteString(CONFIG, HOST, pValue);
  finally
    Result := Self;
  end;
end;

function TConfigArqIni.setPassword(const pValue: String): iConfigConexao;
begin
  try
    FArqIni.WriteString(CONFIG, PASS, pValue);
  finally
    Result := Self;
  end;
end;

function TConfigArqIni.setPath(const pValue: String): iConfigConexao;
begin
  try
    FArqIni.WriteString(CONFIG, PATH, pValue);
  finally
    Result := Self;
  end;
end;

function TConfigArqIni.setPort(const pValue: Integer): iConfigConexao;
begin
  try
    FArqIni.WriteInteger(CONFIG, PORT, pValue);
  finally
    Result := Self;
  end;
end;

function TConfigArqIni.setUser(const pValue: String): iConfigConexao;
begin
  try
    FArqIni.WriteString(CONFIG, USER, pValue);
  finally
    Result := Self;
  end;
end;

end.
